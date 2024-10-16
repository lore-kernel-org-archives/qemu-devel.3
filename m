Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F15D2A555
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AMB-0004r0-DE; Wed, 16 Oct 2024 16:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM8-0004pU-8p; Wed, 16 Oct 2024 16:10:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AM6-0000h0-IZ; Wed, 16 Oct 2024 16:10:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 17B9098F9A;
 Wed, 16 Oct 2024 23:10:08 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0276515637A;
 Wed, 16 Oct 2024 23:10:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 40/49] meson: ensure -mcx16 is passed when detecting
 ATOMIC128
Date: Wed, 16 Oct 2024 23:09:59 +0300
Message-Id: <20241016201025.256294-8-mjt@tls.msk.ru>
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

Moving -mcx16 out of CPU_CFLAGS caused the detection of ATOMIC128 to
fail, because flags have to be specified by hand in cc.compiles and
cc.links invocations (why oh why??).

Ensure that these tests enable all the instruction set extensions that
will be used to build the emulators.

Fixes: c2bf2ccb266 ("configure: move -mcx16 flag out of CPU_CFLAGS", 2024-05-24)
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 8db4e0f92e83fd80b6609439440b303ddded7ad8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 3031f37f45..a11018b3ad 100644
--- a/meson.build
+++ b/meson.build
@@ -2795,7 +2795,7 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
     __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);
     __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
     return 0;
-  }'''))
+  }''', args: qemu_isa_flags))
 
 has_int128_type = cc.compiles('''
   __int128_t a;
@@ -2829,7 +2829,7 @@ if has_int128_type
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
       return 0;
     }'''
-  has_atomic128 = cc.links(atomic_test_128)
+  has_atomic128 = cc.links(atomic_test_128, args: qemu_isa_flags)
 
   config_host_data.set('CONFIG_ATOMIC128', has_atomic128)
 
@@ -2838,7 +2838,8 @@ if has_int128_type
     # without optimization enabled.  Try again with optimizations locally
     # enabled for the function.  See
     #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107389
-    has_atomic128_opt = cc.links('__attribute__((optimize("O1")))' + atomic_test_128)
+    has_atomic128_opt = cc.links('__attribute__((optimize("O1")))' + atomic_test_128,
+                                 args: qemu_isa_flags)
     config_host_data.set('CONFIG_ATOMIC128_OPT', has_atomic128_opt)
 
     if not has_atomic128_opt
@@ -2849,7 +2850,7 @@ if has_int128_type
           __sync_val_compare_and_swap_16(&x, y, x);
           return 0;
         }
-      '''))
+      ''', args: qemu_isa_flags))
     endif
   endif
 endif
-- 
2.39.5


