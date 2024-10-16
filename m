Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F680D2A559
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AM8-0004pS-D7; Wed, 16 Oct 2024 16:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM6-0004pD-K6; Wed, 16 Oct 2024 16:10:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM4-0000gl-Uk; Wed, 16 Oct 2024 16:10:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AF7FB98F99;
 Wed, 16 Oct 2024 23:10:07 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F170156379;
 Wed, 16 Oct 2024 23:10:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Stable-9.1.1 39/49] meson: define qemu_isa_flags
Date: Wed, 16 Oct 2024 23:09:58 +0300
Message-Id: <20241016201025.256294-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Create a separate variable for compiler flags that enable
specific instruction set extensions, so that they can be used with
cc.compiles/cc.links.

Note that -mfpmath=sse is a code generation option but it does not
enable new instructions, therefore I did not make it part of
qemu_isa_flags.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6ae8c5382b2396d394e135c2c6d3742d11c6d0c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 6e467cbe7d..3031f37f45 100644
--- a/meson.build
+++ b/meson.build
@@ -322,6 +322,10 @@ elif host_os == 'windows'
   endif
 endif
 
+# Choose instruction set (currently x86-only)
+
+qemu_isa_flags = []
+
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
 # use i686 as default anyway, but for those that don't, an explicit
 # specification is necessary
@@ -338,7 +342,7 @@ if host_arch == 'i386' and not cc.links('''
     sfaa(&val);
     return val;
   }''')
-  qemu_common_flags = ['-march=i486'] + qemu_common_flags
+  qemu_isa_flags += ['-march=i486']
 endif
 
 # Pick x86-64 baseline version
@@ -354,29 +358,31 @@ if host_arch in ['i386', 'x86_64']
     else
       # present on basically all processors but technically not part of
       # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
-      qemu_common_flags = ['-mcx16'] + qemu_common_flags
+      qemu_isa_flags += ['-mcx16']
     endif
   endif
   if get_option('x86_version') >= '2'
-    qemu_common_flags = ['-mpopcnt'] + qemu_common_flags
-    qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
+    qemu_isa_flags += ['-mpopcnt']
+    qemu_isa_flags += cc.get_supported_arguments('-mneeded')
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_isa_flags += ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c']
   endif
 
   # add required vector instruction set (each level implies those below)
   if get_option('x86_version') == '1'
-    qemu_common_flags = ['-msse2'] + qemu_common_flags
+    qemu_isa_flags += ['-msse2']
   elif get_option('x86_version') == '2'
-    qemu_common_flags = ['-msse4.2'] + qemu_common_flags
+    qemu_isa_flags += ['-msse4.2']
   elif get_option('x86_version') == '3'
-    qemu_common_flags = ['-mavx2'] + qemu_common_flags
+    qemu_isa_flags += ['-mavx2']
   elif get_option('x86_version') == '4'
-    qemu_common_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_common_flags
+    qemu_isa_flags += ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl']
   endif
 endif
 
+qemu_common_flags = qemu_isa_flags + qemu_common_flags
+
 if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
-- 
2.39.5


