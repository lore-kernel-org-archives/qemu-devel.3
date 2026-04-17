Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14FF8D75C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 18:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDoEU-0003FR-KW; Fri, 17 Apr 2026 14:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wDoEP-0003Eq-Rc
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 14:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wDoEO-00064F-BA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 14:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776451672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gnjqo+pqbMlz5cqi/ASPMjsRwhbdVbV/bUNHiWq7jek=;
 b=WsOXOcFyFALMmO9xnodUWhn5PhORDoaYdcI7URcmex0cpdKD5d7MdXBSwxy5gd7TXcSVzG
 xV74cVoRNKC93C4jrbnhz6Cuop7SycSpPI7Z8Yk8FtP5QuNPaZd+W5gahOEcQ2eNNGi/m3
 7B9kC3ZzOMJulNaLpqaimXgKgjDgnZc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-NZslp314MeCAzbGAHeVFvg-1; Fri,
 17 Apr 2026 14:47:48 -0400
X-MC-Unique: NZslp314MeCAzbGAHeVFvg-1
X-Mimecast-MFC-AGG-ID: NZslp314MeCAzbGAHeVFvg_1776451667
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AA52180036E; Fri, 17 Apr 2026 18:47:47 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDE5A1800351; Fri, 17 Apr 2026 18:47:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: steven.sistare@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: fix abort when re-migrating after cancel during
 SETUP
Date: Fri, 17 Apr 2026 22:47:42 +0400
Message-ID: <20260417184742.293061-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When a migration is cancelled during the early SETUP phase (before
migration_connect_outgoing() has set s->to_dst_file), migration_cancel()
takes a fast path that transitions the state from CANCELLING to
Cancelled without calling migration_cleanup(). This leaves the migration
yank instance registered.

A subsequent qmp_migrate() call passes the migration_is_running() guard
(since CANCELLED is a terminal state) and then calls
yank_register_instance(MIGRATION_YANK_INSTANCE, &error_abort), which
finds the stale entry and aborts with "duplicate yank instance".

  #6  0x000056028b5e17fc in error_setg_internal
      (errp=errp@entry=0x56028cc8cb18 <error_abort>, src=src@entry=0x56028ba87fa5 "../util/yank.c", line=line@entry=87, func=func@entry=0x56028bb77140 <__func__.5> "yank_register_instance", fmt=fmt@entry=0x56028ba87f8d "duplicate yank instance") at ../util/error.c:100
  #7  0x000056028b601b2a in yank_register_instance (instance=instance@entry=0x7ffea0cf36b0, errp=0x56028cc8cb18 <error_abort>) at ../util/yank.c:87
  #8  0x000056028b25221e in migrate_prepare (s=0x5602b0a7db90, resume=<optimized out>, errp=0x7ffea0cf3718) at ../migration/migration.c:2001
  #9  qmp_migrate (uri=<optimized out>, has_channels=<optimized out>, channels=<optimized out>, has_resume=<optimized out>, resume=<optimized out>, errp=errp@entry=0x7ffea0cf3718) at ../migration/migration.c:2039
  #10 0x000056028b5891be in qmp_marshal_migrate (args=<optimized out>, ret=<optimized out>, errp=0x7f63392e0ee0) at qapi/qapi-commands-migration.c:459

Add missing yank_unregister_instance. Alternatively, it seems
migration_cleanup() should be safe in this context too.

Fixes: 624e6e654e11 ("migration: cpr-transfer mode")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58f..bbdd91ee7ee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1477,6 +1477,7 @@ void migration_cancel(void)
                           MIGRATION_STATUS_CANCELLED);
         cpr_state_close();
         cpr_transfer_source_destroy(s);
+        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
     }
 }
 
-- 
2.53.0


