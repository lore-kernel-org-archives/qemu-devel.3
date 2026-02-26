Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86FDFD8FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdid-0005R4-N3; Thu, 26 Feb 2026 10:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiY-0005PX-BZ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiW-0003o0-Lh
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-480706554beso13256095e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121355; x=1772726155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OKoWT2ApVIzhi/7waZCc6MN7OGT/UzfjYDpeVAHn0Cc=;
 b=pH8lRnP3HU7QkBUituspQfoo30kiO76IUZF6u96NNywx7hdkMTGlV53JZK0XLjg2uo
 F0OuE8wuhbnoN8caFLXAPanHJx8wj5wGfR9igcaIWB2eKQikiYo2DAFKtSgapZxm2Mqr
 wXJooVWe0nSrdAE8oIM62FgOEIjYcOuYf4PbcBhe6EowfA1+QjmBYBTKajkhC/x4JzfM
 f3k7H/ngHUSrisP7GmU0bvfezQ2jHr2CaL0sTV4avmGemntVo6tCBaIgSS6CSdkTNr/p
 5yo1cRIgBZzAjwkTyIdXOsnR7WMArs50j5veb26sgXSGx2PMYQzES0tzXXaXmYq14Ph4
 OCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121355; x=1772726155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OKoWT2ApVIzhi/7waZCc6MN7OGT/UzfjYDpeVAHn0Cc=;
 b=Gsfz6DFF7hzoobijnjGDJ+y1mdEeQwmXgNEW1Yg/ka+Q7V5UpEYvGWy22aR6iQtFSA
 L10Olphj2iS8Ez+mAM0Av7B90pj5VG5p/uErNbQlxFldqvFaNy4+yLCfkbhR+3zGbnlP
 r7sHu5nmR8eZ5ESZtmXBW9y63UPeNQbAxI8aiAbsyddjyL2X0K35VSgnGSHIn5IbNmYF
 5I+PfVza7DB/MJYy0QICN9amCiX59EJfTDNvdE7lCqwlbVtxUuPaDkhpXxXrhuLhvhku
 n8J01XAiQhzn3dvMAExCW29s4VGToqvqKj3ac4L/M0/+u3OkzdtJ5LthNEPb7di0tqeZ
 wJFw==
X-Gm-Message-State: AOJu0YzQ+Iw5TDK6NY88zbArXWHEBxaUad7LQb//CcveWh3ctFlXVO8w
 ZC3gfDbuIkZvawrHlS6q025+DtRwCjoPAa+mpHtHwGmxgtSCIU7KL3QXMJtBiOdatYlamFXytqp
 Jdr8Q
X-Gm-Gg: ATEYQzyRMgRke6Hkb6N88N9KmBFIB/BmU903kKKDPqgbzC+nnsBXdtV6F+mM+rf3mCD
 eOsxYmvFRsDYJwJ5+zZ/ylXxCVtMg+LkJiZe5pFR2PkYF9Zc5rBe6wG6e9dz64j45yHGTjZu6B2
 lLG0RuC0QbkguOgTksLzPWfTa23HE9bWMKhpdwMkTiVwVflyWfrsQzrjgvp0NczozCx0XMVlwU9
 NzXI00Q4zVkp/cvWVZOlasdXyGeOJLRsv+g3xhYa5b54mCz1TEyYSSNX4R5px0CKFVdmiqI6bpn
 YrGU9mejRkc7UEvWjv1WeV8qNHo1+LfPLrVfUzQH79Zmz0Lbyo9+7ClPuFbDcmtJiYIVJIJ6GIC
 9MY5mAUd2JUAtdadTIq1LEM+rneOTM6mrcqh05VBAoD8Dem2SyauLiME3p/8Hkxrm6Vdq2BGqZd
 4w05rcVzG61+/9+kRZ8KK0aTWlIoVFIxWNYeZVZNmC9Fy2cvW/Poomxr2PoyFhFceE+S4MPXIY+
 H2Zs++pIV/KqZ5e5LhZFTnpE2YgItI=
X-Received: by 2002:a05:6000:26d2:b0:439:8f5a:2b8d with SMTP id
 ffacd0b85a97d-439942fdfb0mr8967158f8f.56.1772121355171; 
 Thu, 26 Feb 2026 07:55:55 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] target/arm: Add have_ffr argument to kvm_arch_{get,
 put}_sve
Date: Thu, 26 Feb 2026 15:55:33 +0000
Message-ID: <20260226155535.1171290-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index ecb732a669..4908138764 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2118,7 +2118,7 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_put_sve(CPUState *cs, uint32_t vq)
+static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
 {
     CPUARMState *env = cpu_env(cs);
     uint64_t tmp[ARM_MAX_VQ * 2];
@@ -2141,11 +2141,13 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq)
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
@@ -2234,7 +2236,7 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_put_sve(cs, cpu->sve_max_vq);
+        ret = kvm_arch_put_sve(cs, cpu->sve_max_vq, true);
     } else {
         ret = kvm_arch_put_fpsimd(cs);
     }
@@ -2300,7 +2302,7 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_get_sve(CPUState *cs, uint32_t vq)
+static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
 {
     CPUARMState *env = cpu_env(cs);
     uint64_t *r;
@@ -2324,12 +2326,14 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq)
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
@@ -2417,7 +2421,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_get_sve(cs, cpu->sve_max_vq);
+        ret = kvm_arch_get_sve(cs, cpu->sve_max_vq, true);
     } else {
         ret = kvm_arch_get_fpsimd(cs);
     }
-- 
2.43.0


