Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57063FD8FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdif-0005S9-2y; Thu, 26 Feb 2026 10:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiX-0005PW-NX
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:59 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiV-0003ng-LQ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:57 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4398d1f06caso962106f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121354; x=1772726154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hc2CJaf+EvCFfQ6zg/jl611kyl275mtn77dMnXM1joU=;
 b=ZmuwAgiIgg2xuyIglzv+2mH2dA0uaH4Om8qmBZTb18pOyfVXxryxMGnn0C1+c/hJAR
 Mn1Ssk/OG9dfIywuFZnENnt5CwLr+a7ke+qs3yucgu1vffDPnGgiF4Ok7YK7tr+H1Yyo
 E/U3uDztCNH9FuOWjoGlhzQg+1hMJ1umNqVjRRvRaSAebVUyme+Ls52Su2u7E43mwi5d
 sEF4IuslJjk4DTfOGywU8pLMtajQrSSDpATqn5Z3BhLTqumgSMUGrN0jU4UxC5fJR/sn
 HzV7+Gm5o42kYJPkCKtrKfK/m0eElotjNCL6oxlHWtqR0JehjmgSVOD7HThgCoga0iex
 82pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121354; x=1772726154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hc2CJaf+EvCFfQ6zg/jl611kyl275mtn77dMnXM1joU=;
 b=dM8HNYzTB/BiXOZS2l3vr2LsMDEQsb+V87APp/eUgYq9Tul10A0nj88nXdQyZpcv+J
 QUW64wUYgrG8uUpADkZsrnocw/iD3C8ccf4oDJxS0jqEI3BLLNTLly5uTUsFGWS/xXUO
 wyhXqWfYVKX8etMeXd23dWSLu4bbTncCkHjfZzkDGcCW61kKrD1vAOikUmRnijFdWsjh
 r3cOQmCvuPENJWSri2Rk64VrAifippJhhJTagKKTbdmC7w9PXWXRqZi2RMNriZ6nRXYM
 bVOaQfQtIuVf13iV7hxYxr5CIoNbpf0mZ+WJ4tC5p0jeTAxwtGBdd3Zp/xY0JKG5LntP
 ZYKw==
X-Gm-Message-State: AOJu0Yw2REdBeqwqQ3fuhFKfsxTYzKv8agMl12blAKVGFaWTJsFqiFxp
 3e15eEn+HBCPAGXijhWtnl8/peGVD5m39h3dollMomFkHE/QmoCqAccgnYnD5rDeyl9YN0F+VOI
 HICiJ
X-Gm-Gg: ATEYQzzkcOxTMSv4rxzdI21sF3L11tgZKD4h73zrIp0VYrp0dyQ/AAA4pWVkudKHpFb
 uBzc+xHStfl8FPc4Mhk2ZwDNWAXiH8cbSBlayeu1w+trZaPx0fyvtp9+6tSaXppp7Nk1XxihU/B
 PoXKBWf27xppBdqbJGYH04k9OUmqfyc+ZSKZQeQ+9B/EZqIO+UzmLt2vK4niQfC53sqWjysVQim
 AWDcKtf44XqBHt79aUgw8b6IzZMUgHZdK3/rlNMaYIAotpxENBZ3G9g7e/V7ZmaDwcfWVSA7tbE
 8lzMro0WlyHan9QRHQly6DwWfPRloCzV2BrVc8GKxU0p2IT4Hdgz5fuMMucUIfdTagosB+nW3kx
 UJ2Qy01KYonoGiTPkRPQv48kHIy34G6yOIAkAagGXLXoyCqPtPTf73J8Vfc0OE/Is+BPzSibFrv
 YvcfcH3SG1QaPdeXEIrMd30o+a6pTjpGLJTuZF7mz/hO3GnjzuakO36ZSa6ZIl3NV4FV88ggvt/
 RqmPK7mxit2bCFyCtE5H6sLq7I3/8w=
X-Received: by 2002:a05:6000:25c8:b0:437:6e6e:6f95 with SMTP id
 ffacd0b85a97d-439942e2c68mr7908662f8f.27.1772121354250; 
 Thu, 26 Feb 2026 07:55:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] target/arm: Add vq argument to kvm_arch_{get, put}_sve
Date: Thu, 26 Feb 2026 15:55:32 +0000
Message-ID: <20260226155535.1171290-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Message-id: 20260216034432.23912-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b8aba20f02..ecb732a669 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2118,16 +2118,15 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_put_sve(CPUState *cs)
+static int kvm_arch_put_sve(CPUState *cs, uint32_t vq)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     uint64_t tmp[ARM_MAX_VQ * 2];
     uint64_t *r;
     int n, ret;
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
-        r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], cpu->sve_max_vq * 2);
+        r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], vq * 2);
         ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_ZREG(n, 0), r);
         if (ret) {
             return ret;
@@ -2135,8 +2134,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     }
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
-        r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
-                        DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+        r = sve_bswap64(tmp, &env->vfp.pregs[n].p[0], DIV_ROUND_UP(vq * 2, 8));
         ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_PREG(n, 0), r);
         if (ret) {
             return ret;
@@ -2144,7 +2142,7 @@ static int kvm_arch_put_sve(CPUState *cs)
     }
 
     r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
-                    DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+                    DIV_ROUND_UP(vq * 2, 8));
     ret = kvm_set_one_reg(cs, KVM_REG_ARM64_SVE_FFR(0), r);
     if (ret) {
         return ret;
@@ -2236,7 +2234,7 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_put_sve(cs);
+        ret = kvm_arch_put_sve(cs, cpu->sve_max_vq);
     } else {
         ret = kvm_arch_put_fpsimd(cs);
     }
@@ -2302,10 +2300,9 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
  * code the slice index to zero for now as it's unlikely we'll need more than
  * one slice for quite some time.
  */
-static int kvm_arch_get_sve(CPUState *cs)
+static int kvm_arch_get_sve(CPUState *cs, uint32_t vq)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = cpu_env(cs);
     uint64_t *r;
     int n, ret;
 
@@ -2315,7 +2312,7 @@ static int kvm_arch_get_sve(CPUState *cs)
         if (ret) {
             return ret;
         }
-        sve_bswap64(r, r, cpu->sve_max_vq * 2);
+        sve_bswap64(r, r, vq * 2);
     }
 
     for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
@@ -2324,7 +2321,7 @@ static int kvm_arch_get_sve(CPUState *cs)
         if (ret) {
             return ret;
         }
-        sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+        sve_bswap64(r, r, DIV_ROUND_UP(vq * 2, 8));
     }
 
     r = &env->vfp.pregs[FFR_PRED_NUM].p[0];
@@ -2332,7 +2329,7 @@ static int kvm_arch_get_sve(CPUState *cs)
     if (ret) {
         return ret;
     }
-    sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+    sve_bswap64(r, r, DIV_ROUND_UP(vq * 2, 8));
 
     return 0;
 }
@@ -2420,7 +2417,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
 
     if (cpu_isar_feature(aa64_sve, cpu)) {
-        ret = kvm_arch_get_sve(cs);
+        ret = kvm_arch_get_sve(cs, cpu->sve_max_vq);
     } else {
         ret = kvm_arch_get_fpsimd(cs);
     }
-- 
2.43.0


