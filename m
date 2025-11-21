Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3CFCFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdUU-00086O-Fk; Fri, 21 Nov 2025 21:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdUA-0007pH-A8; Fri, 21 Nov 2025 21:36:27 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdT8-0001Fd-QH; Fri, 21 Nov 2025 21:36:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D062816C6FB;
 Fri, 21 Nov 2025 16:51:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 35CF8321998;
 Fri, 21 Nov 2025 16:52:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 35/76] tests/tcg/s390x: Test SET CLOCK COMPARATOR
Date: Fri, 21 Nov 2025 16:51:13 +0300
Message-ID: <20251121135201.1114964-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test to prevent regressions.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20251016175954.41153-5-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 0408c61e27aca56c2d40aeb6ca0e5c5f8b8c3845)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 8cd4667c63..a4425d3184 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -28,6 +28,7 @@ ASM_TESTS =                                                                    \
     mc                                                                         \
     per                                                                        \
     precise-smc-softmmu                                                        \
+    sckc                                                                       \
     ssm-early                                                                  \
     stosm-early                                                                \
     stpq                                                                       \
diff --git a/tests/tcg/s390x/sckc.S b/tests/tcg/s390x/sckc.S
new file mode 100644
index 0000000000..ecd64a3059
--- /dev/null
+++ b/tests/tcg/s390x/sckc.S
@@ -0,0 +1,63 @@
+/*
+ * Test clock comparator.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    .org 0x130
+ext_old_psw:
+    .org 0x1b0
+ext_new_psw:
+    .quad 0x180000000, _ext            /* 64-bit mode */
+    .org 0x1d0
+pgm_new_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
+    .org 0x200                         /* lowcore padding */
+
+    .globl _start
+_start:
+    lpswe start31_psw
+_start31:
+    stctg %c0,%c0,c0
+    oi c0+6,8                          /* set clock-comparator subclass mask */
+    lctlg %c0,%c0,c0
+
+0:
+    brasl %r14,_f                      /* %r14's most significant bit is 1 */
+    jg 0b
+_f:
+    br %r14                            /* it must not end up in ext_old_psw */
+
+_ext:
+    stg %r0,ext_saved_r0
+
+    lg %r0,ext_counter
+    aghi %r0,1
+    stg %r0,ext_counter
+
+    cgfi %r0,0x1000
+    jnz 0f
+    lpswe success_psw
+0:
+
+    stck clock
+    lg %r0,clock
+    agfi %r0,0x40000                   /* 64us * 0x1000 =~ 0.25s */
+    stg %r0,clock
+    sckc clock
+
+    lg %r0,ext_saved_r0
+    lpswe ext_old_psw
+
+    .align 8
+start31_psw:
+    .quad 0x100000080000000,_start31   /* EX, 31-bit mode */
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+c0:
+    .skip 8
+clock:
+    .quad 0
+ext_counter:
+    .quad 0
+ext_saved_r0:
+    .skip 8
-- 
2.47.3


