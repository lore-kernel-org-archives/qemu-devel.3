Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDDDC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyBC-0001U6-JE; Tue, 25 Mar 2025 02:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9c-0006Ny-Ji; Tue, 25 Mar 2025 02:52:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy9Z-0001yQ-IV; Tue, 25 Mar 2025 02:52:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA68A107D7E;
 Tue, 25 Mar 2025 09:49:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D12A1D5E89;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 80C175705A; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Andreas Schwab <schwab@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 60/69] linux-user/riscv: Fix handling of cpu mask in
 riscv_hwprobe syscall
Date: Tue, 25 Mar 2025 09:50:33 +0300
Message-Id: <20250325065043.3263864-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

The third argument of the syscall contains the size of the
cpu mask in bytes, not bits.  Nor is the size rounded up to
a multiple of sizeof(abi_ulong).

Cc: qemu-stable@nongnu.org
Reported-by: Andreas Schwab <schwab@suse.de>
Fixes: 9e1c7d982d7 ("linux-user/riscv: Add syscall riscv_hwprobe")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250308225902.1208237-3-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 1a010d22b7adecf0fb1c069e1e535af1aa51e9cf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index a407d4a023..549e39e196 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9097,35 +9097,38 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
     }
 }
 
-static int cpu_set_valid(abi_long arg3, abi_long arg4)
+/*
+ * If the cpumask_t of (target_cpus, cpusetsize) cannot be read: -EFAULT.
+ * If the cpumast_t has no bits set: -EINVAL.
+ * Otherwise the cpumask_t contains some bit set: 0.
+ * Unlike the kernel, we do not mask cpumask_t by the set of online cpus,
+ * nor bound the search by cpumask_size().
+ */
+static int nonempty_cpu_set(abi_ulong cpusetsize, abi_ptr target_cpus)
 {
-    int ret, i, tmp;
-    size_t host_mask_size, target_mask_size;
-    unsigned long *host_mask;
-
-    /*
-     * cpu_set_t represent CPU masks as bit masks of type unsigned long *.
-     * arg3 contains the cpu count.
-     */
-    tmp = (8 * sizeof(abi_ulong));
-    target_mask_size = ((arg3 + tmp - 1) / tmp) * sizeof(abi_ulong);
-    host_mask_size = (target_mask_size + (sizeof(*host_mask) - 1)) &
-                     ~(sizeof(*host_mask) - 1);
-
-    host_mask = alloca(host_mask_size);
-
-    ret = target_to_host_cpu_mask(host_mask, host_mask_size,
-                                  arg4, target_mask_size);
-    if (ret != 0) {
-        return ret;
-    }
+    unsigned char *p = lock_user(VERIFY_READ, target_cpus, cpusetsize, 1);
+    int ret = -TARGET_EFAULT;
 
-    for (i = 0 ; i < host_mask_size / sizeof(*host_mask); i++) {
-        if (host_mask[i] != 0) {
-            return 0;
+    if (p) {
+        ret = -TARGET_EINVAL;
+        /*
+         * Since we only care about the empty/non-empty state of the cpumask_t
+         * not the individual bits, we do not need to repartition the bits
+         * from target abi_ulong to host unsigned long.
+         *
+         * Note that the kernel does not round up cpusetsize to a multiple of
+         * sizeof(abi_ulong).  After bounding cpusetsize by cpumask_size(),
+         * it copies exactly cpusetsize bytes into a zeroed buffer.
+         */
+        for (abi_ulong i = 0; i < cpusetsize; ++i) {
+            if (p[i]) {
+                ret = 0;
+                break;
+            }
         }
+        unlock_user(p, target_cpus, 0);
     }
-    return -TARGET_EINVAL;
+    return ret;
 }
 
 static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
@@ -9142,7 +9145,7 @@ static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
 
     /* check cpu_set */
     if (arg3 != 0) {
-        ret = cpu_set_valid(arg3, arg4);
+        ret = nonempty_cpu_set(arg3, arg4);
         if (ret != 0) {
             return ret;
         }
-- 
2.39.5


