Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6092C35FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoPe-0000Cl-3L; Wed, 19 Mar 2025 04:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoP1-00084S-MU; Wed, 19 Mar 2025 04:03:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOz-0004UL-Rp; Wed, 19 Mar 2025 04:03:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224341bbc1dso124693895ad.3; 
 Wed, 19 Mar 2025 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371428; x=1742976228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8ym/X0tsdAFFXl/72oxrMtQ/+O/1A1epWPinRhhrVg=;
 b=I1HOstOr/2Vb9YpL1HeYn+fL/xbgEiSVdQhtO1ppedL0isSDsMMdRGSF/B11HMyW0x
 Bh+7MtjJQiYaEsfWMu9Q3J1l5Cw84yb6rEKiP4fyb5XV4d+xa2y9k1yXgbTMBIi+14Hz
 g/Eul/ENxdXVz4i6TVIdeQiP6/h/FO5r68VcPZGGLkFBBg16CtZTQjKZtPSkshUfoFdo
 rhfLpIO0rg4rNkOkVM2tkqtCKLVdPhARkr/XtKUoTFrvmEREW5YyR9FHSwl7tjXeis4+
 GTApl9SiSGS3EVHwEJqgOSpgEf3LrUMpLLbu4XKujkLZrx6ZcJ/n72mPiUZr8SiIOuEG
 hYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371428; x=1742976228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8ym/X0tsdAFFXl/72oxrMtQ/+O/1A1epWPinRhhrVg=;
 b=qBuP07PIpr5ihep2nFOUObx7h2GCo23q/TENsJoeGw/12wv/Cvkp4DGqCXob9jqlRq
 hpP6EJBLRzrpwcexglKaCSpoLxaTFzLUG+jqdRAuWVlbs9vEXwxlEprTu5XbzYHvsB8n
 Ie7yXxwew/hfrsPBTLu0RGDoM+fj8q5W9Sn0FeU7vbnez59TgScSd9KCsVlOtdZUJvIe
 GrdlFClvTu78cus1r+UqtS+1xsYTIRiXrI8BtPETEzO6noe29EHlEyufbZ20hItq0kh9
 oi7hc1r9I92hHp392VnoNw9VnaQZuSzeHtGg1fZtmLXcslIIOqaIRcR7mpIvHuY5QNCz
 A7tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUNcpxssLGhReHIPAoN04szH4Ay0qNMiubOnqavX92rwxIP5QzYd7yQ/aR0+xCt+Pi6csXKX5y3z++Q==@nongnu.org
X-Gm-Message-State: AOJu0YwjmLEfW+VHZuQcobehxL2YDxdGBWFKpy+N1kbINQu7FC8TmKIY
 qUwfiQ7v6s3aRaX9me4Xun7Sgtn99bseBufYCKG16W8crPm0ZRfVPjZR2g==
X-Gm-Gg: ASbGncs5vAqmcJM9At/nq0bVroillWA1Qpw0DdEew1DxJOiw8UEE4T+WuEWB46Uu6hl
 7wzD0eYZurR41HuDVUdduLnikgF9KQdXH2ePiQ5Of+m6pUgVaTEX67EuAsa0WpWKo6CqEtDQXtk
 sSVTE1BKFiD6SRWOz6pMK52uGKZVP5ZM3cN7OwGlAJLsUm90mDa30DMQVZH74tZAHm951CmUkOA
 J/NeJj/IENyYEHIUihJbW2t6mx9Rz8q7K+emR0WgYlfAUfCsJiVF9NCeAC/3dj1NX95j3cxK3OG
 8WwwY8Pwa2dvk00Ns9ZCYKqn/CmNU9RE66b6L/0pYN7cQnpuoHOSOkgPwg1oib2jwfQnPemXKvc
 QAQi68C3mEd6QS0a40azEuDlPQZ15K9Aw5SC182jYu54a+Rrm
X-Google-Smtp-Source: AGHT+IEhsMdDNNASmUWWfNRu5JfAF3tfcpEr1qzHyt/jRnwwDMoj4/gNMaJhUSI5kLxHsdLgF3+GxQ==
X-Received: by 2002:a17:902:ea0a:b0:223:3396:15e8 with SMTP id
 d9443c01a7336-2264981d9bdmr28022065ad.22.1742371427814; 
 Wed, 19 Mar 2025 01:03:47 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable@nongnu.org, Andreas Schwab <schwab@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/10] linux-user/riscv: Fix handling of cpu mask in
 riscv_hwprobe syscall
Date: Wed, 19 Mar 2025 18:03:07 +1000
Message-ID: <20250319080308.609520-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
---
 linux-user/syscall.c | 55 +++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b32de763f7..8bfe4912e1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9119,35 +9119,38 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
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
@@ -9164,7 +9167,7 @@ static abi_long do_riscv_hwprobe(CPUArchState *cpu_env, abi_long arg1,
 
     /* check cpu_set */
     if (arg3 != 0) {
-        ret = cpu_set_valid(arg3, arg4);
+        ret = nonempty_cpu_set(arg3, arg4);
         if (ret != 0) {
             return ret;
         }
-- 
2.48.1


