Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9921F112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PKy-0007Sc-O3; Wed, 11 Mar 2026 15:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKp-0007Rp-Kc; Wed, 11 Mar 2026 15:35:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PKn-0008Ua-SH; Wed, 11 Mar 2026 15:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257665; bh=UkC+mGEKAng2ipeWdHY5FpVi3rpU3TW2kt6s+TMUcoc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B2x/v/IfM6v4zL2faSJBrmZMaXEDPscMCEAXZQX1ZG6rIpecFULsX1R21+x4Ye9U8
 I8Qq9AgCZbXvaV170NaCpqsjMYKKSdeTC2WNeeoUBhBZvHfxBaj4Eew2NBqvhPpVPt
 2boovpAeXdwiwjWohBx6nnAVx96j68R5ssBHKTeRo4rvdLeEJbUcxQgLXf5b3FLddD
 wPVZcYavaEK4LV7M892ROqH4tBQVcP//yAWWRmQrd6M8zfNGRMvh4oTKty23oT8GxF
 IFYpWi0dlk1nav7vE66m08RjMzUNifbz/dtCW+Hkz1d8A39D/7NtaKc+uj8qe2nC2J
 +MRR4tYYMHcTw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EFCA01920EA;
 Wed, 11 Mar 2026 22:34:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F20837C44F;
 Wed, 11 Mar 2026 22:35:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 02/53] plugins: fix cross-build using LLVM for Windows
 targets
Date: Wed, 11 Mar 2026 22:33:55 +0300
Message-ID: <20260311193449.1096110-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

llvm-dlltool assumes that it's by default targeting the host architecture
it's running on. That assumption doesn't hold true when cross-compiling.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260210040722.11375-1-mohamed@unpredictable.fr
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
(cherry picked from commit b0353beebb0c4fa4059c88362561a8362ada8b4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/plugins/meson.build b/plugins/meson.build
index 62c991d87f..222aed8c2e 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -41,9 +41,16 @@ if host_os == 'windows'
   # to find missing symbols in current program.
   win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
   if meson.get_compiler('c').get_id() == 'clang'
+    if host_machine.cpu() == 'x86_64'
+      dlltool_target = 'i386:x86-64'
+    elif host_machine.cpu() == 'aarch64'
+      dlltool_target = 'arm64'
+    else
+      error('Unknown machine')
+    endif
     # With LLVM/lld, delaylib is specified at link time (-delayload)
     dlltool = find_program('llvm-dlltool', required: true)
-    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
+    dlltool_cmd = [dlltool, '-m', dlltool_target,'-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
     win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
   else
     # With gcc/ld, delay lib is built with a specific delay parameter.
-- 
2.47.3


