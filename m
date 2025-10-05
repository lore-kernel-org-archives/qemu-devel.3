Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FA6CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Rum-00009h-1D; Sun, 05 Oct 2025 12:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Ruk-00009J-Qi; Sun, 05 Oct 2025 12:48:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Ruf-00073Q-8k; Sun, 05 Oct 2025 12:48:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B1AF915AA2D;
 Sun, 05 Oct 2025 19:48:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E95EF2996EB;
 Sun,  5 Oct 2025 19:48:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 66/81] ui/spice: fix crash when disabling GL scanout on
Date: Sun,  5 Oct 2025 19:47:46 +0300
Message-ID: <20251005164822.442861-6-mjt@tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When spice_qxl_gl_scanout2() isn't available, the fallback code
incorrectly handles NULL arguments to disable the scanout, leading to:

Program terminated with signal SIGSEGV, Segmentation fault.
#0  spice_server_gl_scanout (qxl=0x55a25ce57ae8, fd=0x0, width=0, height=0, offset=0x0, stride=0x0, num_planes=0, format=0, modifier=72057594037927935, y_0_top=0)
    at ../ui/spice-display.c:983
983         if (num_planes <= 1) {

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2391334
Fixes: 98a050ca93afd8 ("ui/spice: support multi plane dmabuf scanout")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20250903193818.2460914-1-marcandre.lureau@redhat.com>
(cherry picked from commit 62fd247a24290dba2b2de4ee8575624a7993973c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 669832c561..db71e866f8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -980,7 +980,9 @@ static void spice_server_gl_scanout(QXLInstance *qxl,
     spice_qxl_gl_scanout2(qxl, fd, width, height, offset, stride,
                           num_planes, format, modifier, y_0_top);
 #else
-    if (num_planes <= 1) {
+    if (fd == NULL) {
+        spice_qxl_gl_scanout(qxl, -1, 0, 0, 0, 0, false);
+    } else if (num_planes <= 1) {
         spice_qxl_gl_scanout(qxl, fd[0], width, height, stride[0], format, y_0_top);
     } else {
         error_report("SPICE server does not support multi plane GL scanout");
-- 
2.47.3


