Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC11C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59q-0006jR-Te; Tue, 07 Jul 2026 08:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59m-0006YE-Jp
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59l-0005EJ-5C
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocsZ+ZS/uZOmOBaGGwXxIEEWnL++j83GHFTOdtsKoTs=;
 b=b/xv40uFnsdftC0bv/+d37gIJpkIKTz/p82yZ7by8cs2BW0LybFi2HIEE4zJzRKtmnw12V
 E/w1U8+HcFMgLaKaLezITyTYrVwD7pQoGYhHskRJt31+9SfYgnKV4UjIaq3vMN2Dj1EDuX
 /SlSd1kqYOYmVlhscHblhPec98sm3oY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19--OhTN8-ONIqIpcl9yo6zDw-1; Tue,
 07 Jul 2026 08:44:06 -0400
X-MC-Unique: -OhTN8-ONIqIpcl9yo6zDw-1
X-Mimecast-MFC-AGG-ID: -OhTN8-ONIqIpcl9yo6zDw_1783428244
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5308619540E6; Tue,  7 Jul 2026 12:44:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B06D236924; Tue,  7 Jul 2026 12:44:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/8] hw/misc/aspeed_scu: Drop noisy unhandled read logs for
 AST2700 SCU/SCUIO
Date: Tue,  7 Jul 2026 14:43:46 +0200
Message-ID: <20260707124349.662198-6-clg@redhat.com>
In-Reply-To: <20260707124349.662198-1-clg@redhat.com>
References: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST2700 SCU/SCUIO read handlers currently emit LOG_GUEST_ERROR
messages for all registers that are not explicitly handled.

However, most SCU registers are simple read-back registers without
side effects, and do not require explicit handling in the read path.
Returning the stored register value is sufficient.

Emitting "Unhandled read" logs for these cases generates excessive
and misleading noise during normal guest operation, making it harder
to spot real issues.

Remove the default unhandled read logging from the SCU and SCUIO read
handlers to reduce log noise and align with common QEMU device model
behavior for passive registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260706052701.1141740-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index fe731a28bd50..ed7f5e648d44 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -849,13 +849,6 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
         return 0;
     }
 
-    switch (reg) {
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, offset);
-    }
-
     trace_aspeed_ast2700_scu_read(offset, size, s->regs[reg]);
     return s->regs[reg];
 }
@@ -961,13 +954,6 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,
         return 0;
     }
 
-    switch (reg) {
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, offset);
-    }
-
     trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);
     return s->regs[reg];
 }
-- 
2.54.0


