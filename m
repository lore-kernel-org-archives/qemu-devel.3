Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CE7C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKil-0000yp-Sb; Fri, 11 Jul 2025 16:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKe1-0003MR-QT; Fri, 11 Jul 2025 16:47:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKdy-0003m6-4e; Fri, 11 Jul 2025 16:46:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E3F4135D05;
 Fri, 11 Jul 2025 23:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D6B023FF40;
 Fri, 11 Jul 2025 23:46:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ethan Chen <ethan84@andestech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 07/15] qemu-options.hx: Fix reversed description of
 icount sleep behavior
Date: Fri, 11 Jul 2025 23:46:22 +0300
Message-ID: <20250711204632.1804872-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Ethan Chen <ethan84@andestech.com>

The documentation for the -icount option incorrectly describes the behavior
of the sleep suboption. Based on the actual implementation and system
behavior, the effects of sleep=on and sleep=off were inadvertently reversed.
This commit updates the description to reflect their intended functionality.

Cc: qemu-stable@nongnu.org
Fixes: fa647905e6ba ("qemu-options.hx: Fix minor issues in icount documentation")
Signed-off-by: Ethan Chen <ethan84@andestech.com>
Message-id: 20250606095728.3672832-1-ethan84@andestech.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e372214e663a4370fe064f7867f402eade37357e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qemu-options.hx b/qemu-options.hx
index 2c00ceac83..9a2ddb7be7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4497,13 +4497,13 @@ SRST
     with actual performance.
 
     When the virtual cpu is sleeping, the virtual time will advance at
-    default speed unless ``sleep=on`` is specified. With
-    ``sleep=on``, the virtual time will jump to the next timer
+    default speed unless ``sleep=off`` is specified. With
+    ``sleep=off``, the virtual time will jump to the next timer
     deadline instantly whenever the virtual cpu goes to sleep mode and
     will not advance if no timer is enabled. This behavior gives
     deterministic execution times from the guest point of view.
-    The default if icount is enabled is ``sleep=off``.
-    ``sleep=on`` cannot be used together with either ``shift=auto``
+    The default if icount is enabled is ``sleep=on``.
+    ``sleep=off`` cannot be used together with either ``shift=auto``
     or ``align=on``.
 
     ``align=on`` will activate the delay algorithm which will try to
-- 
2.47.2


