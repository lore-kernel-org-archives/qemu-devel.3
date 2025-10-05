Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8434BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Rug-00008s-Vp; Sun, 05 Oct 2025 12:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rud-00007o-0o; Sun, 05 Oct 2025 12:48:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Rub-00072h-9u; Sun, 05 Oct 2025 12:48:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B2C4C15AA2C;
 Sun, 05 Oct 2025 19:48:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 731272996EA;
 Sun,  5 Oct 2025 19:48:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mohamed Akram <mohd.akram@outlook.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 65/81] ui/spice: Fix abort on macOS
Date: Sun,  5 Oct 2025 19:47:45 +0300
Message-ID: <20251005164822.442861-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mohamed Akram <mohd.akram@outlook.com>

The check is faulty because the thread variable was assigned in the main
thread while the main loop runs in a different thread on macOS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3070
Signed-off-by: Mohamed Akram <mohd.akram@outlook.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <C87205B9-DD8F-4E53-AB5B-C8BF82EF1D16@outlook.com>
(cherry picked from commit e7ecb533ee0dbfbe30c90abb213247f4943a9a12)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/spice-core.c b/ui/spice-core.c
index 5992f9daec..2645e96ef6 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -50,8 +50,6 @@ static int spice_migration_completed;
 static int spice_display_is_running;
 static int spice_have_target_host;
 
-static QemuThread me;
-
 struct SpiceTimer {
     QEMUTimer *timer;
 };
@@ -222,7 +220,7 @@ static void channel_event(int event, SpiceChannelEventInfo *info)
      * thread and grab the BQL if so before calling qemu
      * functions.
      */
-    bool need_lock = !qemu_thread_is_self(&me);
+    bool need_lock = !bql_locked();
     if (need_lock) {
         bql_lock();
     }
@@ -675,8 +673,6 @@ static void qemu_spice_init(void)
     spice_wan_compression_t wan_compr;
     bool seamless_migration;
 
-    qemu_thread_get_self(&me);
-
     if (!opts) {
         return;
     }
-- 
2.47.3


