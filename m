Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AFDC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 20:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr0sy-0006LI-FT; Sat, 08 Mar 2025 15:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr0sw-0006Kz-ED
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 15:35:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr0su-0001wT-1N
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 15:35:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22435603572so20977315ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741466098; x=1742070898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nAl4pf8E8sE2qLvyFwJ/6sczfmHaPGMTc7HMlUw0GYQ=;
 b=EDWj9pggPO4dAzW8zMbOV23YLpghMH2nUWlVQzgYEwGM2jMGKA8fd/ocefTrCxMlMO
 4QOcDntdzebbqG1ZigLPMPQxHTsXAOmBc6MzmwBZYVDtXMlMGBSpBrbvNejnSBf+32By
 Bv3yT9Rf8QYt1B10YAfBAJ+HQmojPvRBX5loHfthcwnHyfylfjdcjecN1+4KUkwQakM1
 DHogTXXyIzq+k27rEMnjiwodjASeEzJWh8zt3HIBVgrvoMFNhOiPm13Ff/FJGsVdShV8
 v1XWiS+cMAzTxzSRjknCK751fUjSKK30JzTqBqss6YRwWQvTEqVO2ozgd0p7qPG9HYkc
 n8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741466098; x=1742070898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nAl4pf8E8sE2qLvyFwJ/6sczfmHaPGMTc7HMlUw0GYQ=;
 b=MoctRLDfOCfkg+4FETimUv/hQIt3+fKgcrCc12XtZxPPfqWT5tO5FFUSL0mTbzS2NK
 VmCSiHgbXKPUVDBs17x3mRw1xxvY4bagi7PZdT612pMNwgU7oCVU+6MxT0yseTBMhF/W
 46hLMhlvGe2mKx4c1zPBGeyshIUvqwzgRd47maki5FVWDf1QwnivYa2c00HvBNhSDXhR
 IkEhiJWeBQJUamHgfLQpTAGUhnhd/2wCftWSFCc+ETjBGvowJ6s0If0wSoearRhUtfeU
 zepNHH1RckcWXyVexkIzm6mj1vpUaRdsCCp+K1Kg299J648zQ5XrlE5wQcQQkTCdHQKD
 6F2Q==
X-Gm-Message-State: AOJu0YwP8WpRrCiT0AlpgEQPrFF7hxQ1k3jDRrlwDxY5Sm1PUDQUsR8C
 oU0cWhuTLgAJOHnK5VfoTtSnVXHJ1dYF0KS8LRsLDuJwqZEA4lhcoZik/VodNURIQDICGHFK2ze
 H
X-Gm-Gg: ASbGnct/DIZwleMHmCXLfzy81pTrdnH8IJyHU0b/viVjMGwH3NY5ZqhMbjCgv/M3iyE
 bp0nRX+XLcRdmX/h3h5REwrL+fD5+fKbR9TLxOXJZzdqFiS22ar/HMhu2Sa0xXqvupTuHKjcZJA
 Nj627xF74FEA+ugkQTG/jYli/c+NoViShSIh55BvUxiNHMf07WynEPeVQHlUohceGpH9QhKdXez
 vcsVVqsH7s718ScKmrueNI0vXlg1rHQepm/EQL2sUzs/2M61C29yIS2LR4Br/Ht4p9GDfqSNrpH
 xTLY55TB6SeK71pY0gI5448ikqXP8uTJrcmfVN1FZ7IT2NiJb7R5d5yCSlRSKq3ndpU3iS6tUwT
 s
X-Google-Smtp-Source: AGHT+IHaa1ttyoWr2wy6tUJWlgX+Yt/T9XFENgxbEqkHDZpsYj7hCQWXSA1SYYxusNYYYz/gbcySjw==
X-Received: by 2002:a05:6a00:2f8a:b0:736:b9f5:47c6 with SMTP id
 d2e1a72fcca58-736b9f548f8mr6039404b3a.16.1741466097913; 
 Sat, 08 Mar 2025 12:34:57 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f81b3sm5381451b3a.118.2025.03.08.12.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 12:34:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Andreas Schwab <schwab@suse.de>
Subject: [PATCH v2] linux-user/riscv: Fix handling of cpu mask in
 riscv_hwprobe syscall
Date: Sat,  8 Mar 2025 12:34:56 -0800
Message-ID: <20250308203456.1205623-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


