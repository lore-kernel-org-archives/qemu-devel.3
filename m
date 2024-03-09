Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFDFC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riz50-00079S-Jt; Sat, 09 Mar 2024 10:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz4y-000793-8D; Sat, 09 Mar 2024 10:57:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1riz4w-0004Fq-D7; Sat, 09 Mar 2024 10:57:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 148EC54526;
 Sat,  9 Mar 2024 18:58:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7613B944BB;
 Sat,  9 Mar 2024 18:57:31 +0300 (MSK)
Received: (nullmailer pid 1694647 invoked by uid 1000);
 Sat, 09 Mar 2024 15:57:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 01/11] replay: Improve error messages about configuration
 conflicts
Date: Sat,  9 Mar 2024 18:57:19 +0300
Message-Id: <20240309155729.1694607-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309155729.1694607-1-mjt@tls.msk.ru>
References: <20240309155729.1694607-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

Improve

   Record/replay feature is not supported for '-rtc base=localtime'
   Record/replay feature is not supported for 'smp'
   Record/replay feature is not supported for '-snapshot'

to

   Record/replay is not supported with -rtc base=localtime
   Record/replay is not supported with multiple CPUs
   Record/replay is not supported with -snapshot

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
index 48aae6e053..70f4cece7f 100644
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
2.39.2


