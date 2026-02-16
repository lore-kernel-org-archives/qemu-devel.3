Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89AE63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXs-0002jO-OQ; Sun, 15 Feb 2026 22:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXn-0002dQ-AQ
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:07 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXi-0002Sg-8V
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:45:05 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a95bfdb31eso11641875ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213501; x=1771818301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z1G5iNA34KzEcs/mYmm8XYsWLt81ZFoJDv6FYs6NiaA=;
 b=kwi7nVc6QNCz+twvT7taGz94R89q21zSZ0wbr3R1uG0jN7BvRdf5vlSE8qC2DfKMXI
 OrwLnkcndNVlEvZno48kVk9sWYfkGipOMUeaHord0OWpfalA0bPe6fdM1cxf5SCq3b9E
 362i9L00u6cbQxpY4ZLrwlYkrcecnYfzOI+sTSfhojIBloTQXyYFkY06QpIZ45Geuy8x
 Osl2Pj7I5s5sgWnMy61qiICf+mTziDKOUY7Rc7f5gUkgNW6wvlYaqwE4LjEJwZ3M77/s
 JhjmCRWSbSEmGi82UdDQPRHo2SBKUGmfMPRCoxb3idAQD00bJDFWqeLNIKee6VUNJlUW
 lxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213501; x=1771818301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z1G5iNA34KzEcs/mYmm8XYsWLt81ZFoJDv6FYs6NiaA=;
 b=eR6Cd59swfcYhe2g+JLfBWM3e64vK8nsbB6BWDFuhrNN8MFbmCEH99QpaSU4Qbvqa2
 W2Pb0vD32N83o0xsgEkV0qHbTZLJu+5tDyqkwe1lcOP3xMwKv5velAZHrDruVFx92Pa4
 Jz2QOFrCC7ui5rV64GBlecNU83tmKsZfM30vF4rb+Dzs10nia+9bKe/jX+GRhl3i49o/
 jCx5c1w97dIyQ5CgMduyUJwCnvwBxg3BnNRfWr4jQsbhXe3NcnIIj7KVjouaxWu/GXTE
 LSiz5OnX8jCLtSoTyXjFA6AweCZv8sUJ1ZXk/sANl/W1xXknoaDlFB64DKkVJ/ZRibnc
 WFTg==
X-Gm-Message-State: AOJu0Yzyi6G40P96tyriI0LvSRHPu7lHo7VxUZSXF83QednRl4xSWeuJ
 D85ZR1MsakUraYhllT5ToaRNATNB+sW+szp7DlLjGn3xiRbDT/13aVxiHi4xBlye2SThslqFZl8
 X5p83hvw=
X-Gm-Gg: AZuq6aKOmP+4mn72/f6Qog2fdHaTM2t/60DcMAAfDaPLRaiI0PmnwLbbsYd3/66IBP/
 H6/5Hw0/G64CNp6ZnS//aur1m1EsITxLJkXXvWf2JQESe3NxPh5zXsBf9po5hElB0kxDSkxKJW/
 8hdpI29v08rjOdVg+rDSpnbZr4O7ycJm7q2EvruMKjRcaKvH+Ig+w6Op2uPgUFvaWSXYt2axcAn
 ZGlOKqeSCuJthVWUfZGcHAtmihAt/CvIPaWKTT56jsBITfL8R63ylwXQYoQHg+WtG/IjaP9W/mc
 2fspiY9jKuHVGjFW6zi+u/RS4aYC5xHvo1oE6k7GC8D06T1mQxhD4pslhpmM0kwzeUusmcqGJDA
 zMoBME2znOERnXDPlQzdI2apX9QnvKuhgvfFqd5qEQImVKOgjD/kX+OeuRO7hvOga6V6QwhpI91
 XjwuW80TJmA6zacDoQf8K/W3L8vM0SmIt8
X-Received: by 2002:a17:903:fb0:b0:2a9:4870:9606 with SMTP id
 d9443c01a7336-2ab505ca1b6mr81683365ad.42.1771213500789; 
 Sun, 15 Feb 2026 19:45:00 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:45:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/13] target/arm: Add have_ffr argument to kvm_arch_{get,
 put}_sve
Date: Mon, 16 Feb 2026 13:44:30 +1000
Message-ID: <20260216034432.23912-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f6bab562a0..d05ad1d7e1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2122,7 +2122,7 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_put_sve(CPUState *cs, uint32_t vq)
+static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
 {
     CPUARMState *env = cpu_env(cs);
     uint64_t tmp[ARM_MAX_VQ * 2];
@@ -2145,11 +2145,13 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq)
         }
     }
 
-    r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
-                    DIV_ROUND_UP(vq * 2, 8));
-    ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
-    if (ret) {
-        return ret;
+    if (have_ffr) {
+        r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
+                        DIV_ROUND_UP(vq * 2, 8));
+        ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
+        if (ret) {
+            return ret;
+        }
     }
 
     return 0;
@@ -2238,7 +2240,7 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_put_sve(cs, cpu->sve_max_vq);
+        ret = kvm_arch_put_sve(cs, cpu->sve_max_vq, true);
     } else {
         ret = kvm_arch_put_fpsimd(cs);
     }
@@ -2304,7 +2306,7 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_get_sve(CPUState *cs, uint32_t vq)
+static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
 {
     CPUARMState *env = cpu_env(cs);
     uint64_t *r;
@@ -2328,12 +2330,14 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq)
         sve_bswap64(r, r, DIV_ROUND_UP(vq * 2, 8));
     }
 
-    r = &env->vfp.pregs[FFR_PRED_NUM].p[0];
-    ret = kvm_get_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
-    if (ret) {
-        return ret;
+    if (have_ffr) {
+        r = &env->vfp.pregs[FFR_PRED_NUM].p[0];
+        ret = kvm_get_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
+        if (ret) {
+            return ret;
+        }
+        sve_bswap64(r, r, DIV_ROUND_UP(vq * 2, 8));
     }
-    sve_bswap64(r, r, DIV_ROUND_UP(vq * 2, 8));
 
     return 0;
 }
@@ -2421,7 +2425,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_get_sve(cs, cpu->sve_max_vq);
+        ret = kvm_arch_get_sve(cs, cpu->sve_max_vq, true);
     } else {
         ret = kvm_arch_get_fpsimd(cs);
     }
-- 
2.43.0


