Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775F7C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38S-0004ZH-RF; Sat, 08 Mar 2025 17:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38O-0004WA-K0
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:08 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38M-0005K6-9w
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:08 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22185cddbffso74606635ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474744; x=1742079544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAl4pf8E8sE2qLvyFwJ/6sczfmHaPGMTc7HMlUw0GYQ=;
 b=fdEOrYX0MYKLV5FGoNZXuwV5wzSAa1Y66tiHo8WeHruYGj1B8h1twH1JzoncPfVaF7
 zNKrDaRibmLnvrN8D8dv6LpiESCuWP//FZNC2edvKwtT/DGYFfgnzoXW5dAXSphx9/la
 DVTBrsvnZFu3dvNsVxeWHwlBKSBpGygGz+rTkNkUxt6A/MAr/EktbthxEifa/Yyv+V9M
 wklk5a9vwMFWWx/oUbYK4yqP8Hd9bNwLbM+Q5ruvyxpdeeQ/fn8tAgMJ7AeyrJhyql+/
 AYXz/WMV9gj532LgUPwZsbVXZ+GlBPBHEl+Z7FPbFz0DBpZ6Ay6XMRM4GHGhXhy1c0rc
 zhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474744; x=1742079544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAl4pf8E8sE2qLvyFwJ/6sczfmHaPGMTc7HMlUw0GYQ=;
 b=A3xlfwyB52ZKMJVA1ajEX9uDfoj5Jclkg6OccDz/fg1gmIhYR7dfcnE/2ujfxB8207
 N/jLvAOzkunx6O1i1jPjohMWWxKX04J8hPoHuQ92egQwv/6kd1p3FeLaTJO9etkFJ+iM
 XjD1bLZXsKn948ot+luZWH2VR/u3FNWEXYWYccfbRPMC0tX07v0IYX5vPeiDERAJGtsY
 dP7pVfLEGQdojAXuLaBkdv9/91DqPhItDCawxGOxVz8HaHUUEMloyvAMiEVWbczQKbY9
 iRyEUNdJKMI4k8YX5ck2D7/SasbiZT29HBabT1wGaNSVMqJ02glF8FTSBJeGB/kcIMIj
 jpmg==
X-Gm-Message-State: AOJu0YzX/V7kApHdH0OaG+xKXLLp57tb43wf/n7j7pMRanCRjjE205kr
 qa9M+oB9+5FNO0l/h8p1DmIq//BX5JfCpHnDtKnmhH1Pp8ZX4P5wOO9f2DT3q5Pi1uZTy6pTnvU
 j
X-Gm-Gg: ASbGncsC+m2+aoanjebb4k/iVfQhbam3OzX/wldD1VdECOjWshJUA/+AznrJjYYGYuf
 Eldz2gP64O8dIyqOH3Lyp67v1TiZgTbfUHQkdlliAF1lUNnV6lBUPQKc97KPeqKjlxd5EnOxkNa
 uRG3ksMdDOGSb3oTqaW5QIpLVH4jW6PQMcGakgaHFjIF6xa3c38Ldkk2Dm9STlVa9C287M/yRol
 Dbs0ZAwANqrZSlxmTyicpjcHpbkRfCOKeYbtNo9uGrqJW4hVzuYey0wb3sqC74Ijp7w9dqadKp4
 eTE9NIJlgdiXdOR0z95mNGvfF0SrAUtiC1/Sv3nEXbTCr+TYNrOcy9+piVKJTN5I6MjuWqGU7Ub
 5
X-Google-Smtp-Source: AGHT+IGHDGDYT3NF9yTRC8JoEqRr1rOChRHdnPjv3txaRDlpIyKyTQkhIBJ/WJdxE4xorS8TI4fhpg==
X-Received: by 2002:a17:902:f708:b0:223:4d5e:76a6 with SMTP id
 d9443c01a7336-2244f057623mr79708035ad.1.1741474744602; 
 Sat, 08 Mar 2025 14:59:04 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Andreas Schwab <schwab@suse.de>
Subject: [PATCH v2] linux-user/riscv: Fix handling of cpu mask in
 riscv_hwprobe syscall
Date: Sat,  8 Mar 2025 14:58:40 -0800
Message-ID: <20250308225902.1208237-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The third argument of the syscall contains the size of the
cpu mask in bytes, not bits.  Nor is the size rounded up to
a multiple of sizeof(abi_ulong).

Cc: qemu-stable@nongnu.org
Reported-by: Andreas Schwab <schwab@suse.de>
Fixes: 9e1c7d982d7 ("linux-user/riscv: Add syscall riscv_hwprobe")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 55 +++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 02ea4221c9..fcc77c094d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9118,35 +9118,38 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
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
+    unsigned char *p = lock_user(VERIFY_READ, target_cpus, cpusetsize, 1);
+    int ret = -TARGET_EFAULT;
 
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
-
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
@@ -9163,7 +9166,7 @@ static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
 
     /* check cpu_set */
     if (arg3 != 0) {
-        ret = cpu_set_valid(arg3, arg4);
+        ret = nonempty_cpu_set(arg3, arg4);
         if (ret != 0) {
             return ret;
         }
-- 
2.43.0


