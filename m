Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820FFC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 12:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg1fA-0006wR-K5; Fri, 01 Mar 2024 07:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rg1f9-0006vY-5b
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 07:06:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rg1f6-0000o8-2u
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 07:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709294807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GmwbXANjbQn7cFl9kcfopa+JEJxz+iBpIG0xCALad10=;
 b=XCjboF8/JeRbZNrovCRvwg8x2ZrpQ+H8gGjsKmWr/3+1EPmd3ZIRHDzQrxb+f3s2K37aC1
 kZImDzcVnOGuuH9vC9JQDCiZ4wkp22KeU4yx9voS3MShUVyErVQE6cANFBiAqtZppM1yUo
 1GmMyFjdQs2QcK34fLEB0wSgm4hND6E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-4wdnAoM2NJiYnKHdF_RMLw-1; Fri,
 01 Mar 2024 07:06:43 -0500
X-MC-Unique: 4wdnAoM2NJiYnKHdF_RMLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 580EE3C0ED71;
 Fri,  1 Mar 2024 12:06:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 363F81BDB1;
 Fri,  1 Mar 2024 12:06:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0009821E66D0; Fri,  1 Mar 2024 13:06:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pavel.dovgaluk@ispras.ru,
	pbonzini@redhat.com,
	qemu-trivial@nongnu.org
Subject: [PATCH] replay: Improve error messages about configuration conflicts
Date: Fri,  1 Mar 2024 13:06:41 +0100
Message-ID: <20240301120641.864047-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Improve

   Record/replay feature is not supported for '-rtc base=localtime'
   Record/replay feature is not supported for 'smp'
   Record/replay feature is not supported for '-snapshot'

to

   Record/replay is not supported with -rtc base=localtime
   Record/replay is not supported with multiple CPUs
   Record/replay is not supported with -snapshot

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 replay/replay.c | 2 +-
 system/vl.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/replay/replay.c b/replay/replay.c
index 3fd241a4fc..a2c576c16e 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -511,7 +511,7 @@ void replay_add_blocker(const char *feature)
 {
     Error *reason = NULL;
 
-    error_setg(&reason, "Record/replay feature is not supported for '%s'",
+    error_setg(&reason, "Record/replay is not supported with %s",
                feature);
     replay_blockers = g_slist_prepend(replay_blockers, reason);
 }
diff --git a/system/vl.c b/system/vl.c
index e480afd7a0..cc03a17c09 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1932,7 +1932,7 @@ static void qemu_apply_machine_options(QDict *qdict)
     }
 
     if (current_machine->smp.cpus > 1) {
-        replay_add_blocker("smp");
+        replay_add_blocker("multiple CPUs");
     }
 }
 
-- 
2.43.0


