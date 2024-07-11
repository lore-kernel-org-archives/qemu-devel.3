Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C68FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthA-0001GL-Fs; Thu, 11 Jul 2024 09:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00016Z-CL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRtgq-00062m-9s
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so5725575e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703905; x=1721308705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4B0cjzyR7ZYUx+Z++ZVQ0QOKO5mEVD5odZrqQM9vOjM=;
 b=ZYFfFGWoY9x39ldz7MVjoRjLgwvC0nOYAkGiMvzItYRNgvJvyus9JZIvwH1zDm6PVu
 VpoWDZyU7R5YIWU2QDTTpJYo4KaO3IADz80EcLXgLLuVpdBaBlq5uhwbjABItZLLLSKx
 y6qvWlBnkJJmPamd8PuEJD5pZGv5Qkok6UsLJoPmvy13r2UPmeQr4k/K+KBxMdKBwdua
 DxXXEc+VpWqKTZ8Mee7NZJVHoW1Bj5rcugSHJYyd/v3d5i+UQ+xgThXVMFeQcYuUHKIO
 XmV9+b3wtQ2Numo2BK+KW7sXzGEWGyhBNXkGOXtMt134pvu/3lPmPjdn1B+V+JkKHowq
 0Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703905; x=1721308705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4B0cjzyR7ZYUx+Z++ZVQ0QOKO5mEVD5odZrqQM9vOjM=;
 b=a9LZh5VvX9wy66cJc5DZ2lTFDDzORSHjDOSjWn+Gepv++GiJrpGeYjcATIWbp9Ceah
 Ggcuc8oV7b2M8n6uDlMiFMz9ZuTJVfBSc0nhk24ERre+7gKdEFcgkufEgoAOh75l96vw
 9b9t7LnncuqDOCRYILZRQCDekyDl7H9QSxgt9esebJa0+YZYZoYhx7HFT9YUY2VaTfPM
 c9jUD4Y1N24Smt+ECY8Wr7bONSkhQ+CFnBw2k6i31Dv4pNxNGvchq/3LXBAqBewbQPis
 KypX7NJqvi4I0+hx1ZLxP3s3xqcGd1fKgyFUDQJcgr8dvGTp9FRmLvFXv1xYnrdZ9GTo
 DBKw==
X-Gm-Message-State: AOJu0Yz3ntGymi3MhhqOF+dAzoASUjQfxNs55LXSk8oVpR7f/5aoX/g1
 Z6Lx+dWyIo5YhkOJCKExJ7C7G7SDslFBImzstB/KCLotd58s3MDuigHo/k4eeAsi1le0vhcLpyy
 lrwg=
X-Google-Smtp-Source: AGHT+IEojYnU9qjG1V0RQB3K94S0uyO6QQuuAoAQBy6lARAwD8nolkx2AuDvSKLQjVtVyZUzZL4eYw==
X-Received: by 2002:a05:600c:1c8e:b0:426:58ca:5a3 with SMTP id
 5b1f17b1804b1-426708f18famr60048915e9.30.1720703905702; 
 Thu, 11 Jul 2024 06:18:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/24] target/arm: Make vfp_get_fpscr() call vfp_get_{fpcr,
 fpsr}
Date: Thu, 11 Jul 2024 14:18:00 +0100
Message-Id: <20240711131822.3909903-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In AArch32, the floating point control and status bits are all in a
single register, FPSCR.  In AArch64, these were split into separate
FPCR and FPSR registers, but the bit layouts remained the same, with
no overlaps, so that you could construct an FPSCR value by ORing FPCR
and FPSR, or equivalently could produce FPSR and FPCR by masking an
FPSCR value.  For QEMU's implementation, we opted to use masking to
produce FPSR and FPCR, because we started with an AArch32
implementation of FPSCR.

The addition of the (AArch64-only) FEAT_AFP adds new bits to the FPCR
which overlap with some bits in the FPSR.  This means we'll no longer
be able to consider the FPSCR-encoded value as the primary one, but
instead need to treat FPSR/FPCR as the primary encoding and construct
the FPSCR from those.  (This remains possible because the FEAT_AFP
bits in FPCR don't appear in the FPSCR.)

As the first step in this refactoring, make vfp_get_fpscr() call
vfp_get_fpcr() and vfp_get_fpsr(), instead of the other way around.

Note that vfp_get_fpcsr_from_host() returns only bits in the FPSR
(for the cumulative fp exception bits), so we can simply rename
it without needing to add a new function for getting FPCR bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-3-peter.maydell@linaro.org
---
 target/arm/cpu.h        | 24 +++++++++++++++---------
 target/arm/vfp_helper.c | 34 ++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d8eb986a047..abeb2f89764 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1714,10 +1714,21 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_NZCV_MASK (FPCR_N | FPCR_Z | FPCR_C | FPCR_V)
 #define FPCR_NZCVQC_MASK (FPCR_NZCV_MASK | FPCR_QC)
 
-static inline uint32_t vfp_get_fpsr(CPUARMState *env)
-{
-    return vfp_get_fpscr(env) & FPSR_MASK;
-}
+/**
+ * vfp_get_fpsr: read the AArch64 FPSR
+ * @env: CPU context
+ *
+ * Return the current AArch64 FPSR value
+ */
+uint32_t vfp_get_fpsr(CPUARMState *env);
+
+/**
+ * vfp_get_fpcr: read the AArch64 FPCR
+ * @env: CPU context
+ *
+ * Return the current AArch64 FPCR value
+ */
+uint32_t vfp_get_fpcr(CPUARMState *env);
 
 static inline void vfp_set_fpsr(CPUARMState *env, uint32_t val)
 {
@@ -1725,11 +1736,6 @@ static inline void vfp_set_fpsr(CPUARMState *env, uint32_t val)
     vfp_set_fpscr(env, new_fpscr);
 }
 
-static inline uint32_t vfp_get_fpcr(CPUARMState *env)
-{
-    return vfp_get_fpscr(env) & FPCR_MASK;
-}
-
 static inline void vfp_set_fpcr(CPUARMState *env, uint32_t val)
 {
     uint32_t new_fpscr = (vfp_get_fpscr(env) & ~FPCR_MASK) | (val & FPCR_MASK);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index e1686005558..f0692f0c811 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -85,7 +85,7 @@ static inline int vfp_exceptbits_to_host(int target_bits)
     return host_bits;
 }
 
-static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
+static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     uint32_t i;
 
@@ -156,7 +156,7 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
 
 #else
 
-static uint32_t vfp_get_fpscr_from_host(CPUARMState *env)
+static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 {
     return 0;
 }
@@ -167,26 +167,36 @@ static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
 
 #endif
 
-uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+uint32_t vfp_get_fpcr(CPUARMState *env)
 {
-    uint32_t i, fpscr;
-
-    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
-            | (env->vfp.vec_len << 16)
-            | (env->vfp.vec_stride << 20);
+    uint32_t fpcr = (env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_MASK)
+        | (env->vfp.vec_len << 16)
+        | (env->vfp.vec_stride << 20);
 
     /*
      * M-profile LTPSIZE is the same bits [18:16] as A-profile Len; whichever
      * of the two is not applicable to this CPU will always be zero.
      */
-    fpscr |= env->v7m.ltpsize << 16;
+    fpcr |= env->v7m.ltpsize << 16;
 
-    fpscr |= vfp_get_fpscr_from_host(env);
+    return fpcr;
+}
+
+uint32_t vfp_get_fpsr(CPUARMState *env)
+{
+    uint32_t fpsr = env->vfp.xregs[ARM_VFP_FPSCR] & FPSR_MASK;
+    uint32_t i;
+
+    fpsr |= vfp_get_fpsr_from_host(env);
 
     i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
-    fpscr |= i ? FPCR_QC : 0;
+    fpsr |= i ? FPCR_QC : 0;
+    return fpsr;
+}
 
-    return fpscr;
+uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+{
+    return (vfp_get_fpcr(env) & FPCR_MASK) | (vfp_get_fpsr(env) & FPSR_MASK);
 }
 
 uint32_t vfp_get_fpscr(CPUARMState *env)
-- 
2.34.1


