Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA15CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmm-00010H-9f; Tue, 26 May 2026 10:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsml-0000zJ-Jq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:35 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmj-0001P2-Sq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso51202785e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805772; x=1780410572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9AqD1oHDlEi7hjoiK1h0GkH5UvTjIhBiTLaTuxECtGI=;
 b=BSIDisU908VhKqEdR2HpH1Xj/HS8+guONNmPuR/bVJFNnActWq6kNdAvnJ3L6cV+F+
 KXzq1SVz02Lcugq8yJIsTrzOfulei3TbqQvCjN5y6lELgICFUtvX9pffU1zzn5weIW62
 MqiWKOk1Xj2LpgiGCgBA5Dni5TdHWGDz+jRljGLEjw/T5wVxtEUvrRgquRCXCtVZ47rW
 Zzks9QU3LmFw44z9bTbwWwBUpDblZiW8Nap0z4b9abz7EAlvmnnU90/sL3jz8f/4EMg+
 7Ukt3d+VGXRKuojhRxPfIapI5QqwyEhvKBhlj6+xU1zuyhHc0wCKZL+MYssv+O5OUKiA
 QPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805772; x=1780410572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9AqD1oHDlEi7hjoiK1h0GkH5UvTjIhBiTLaTuxECtGI=;
 b=F0WErgPftEhoqHSoqf7uHwtAGjSy5PqvQ+JkH1NzQ5atlv6lYxlichE80mzWnRQ43a
 Pgv5SmMfhisnXHBRGOGpITN4thSd3mp6KX2QoQi7RdjRwawTetaqLVKebK4+m7F+DSqd
 MJYq1JNB0bM9SEYJOZf+8PN628N/22fufhRDibx7G19joIhoKX2ebFIGqsAEJsf/+nH5
 9rcmOsMwjxJ4bnwUrLyTRDrcnlz6y0gO52fZh7NFxjl5EJbAJxOhuaKbqNjOxdqUYUcX
 r7FFgBItyZBbkT1n9opgTnm3L0I2GwPBzN/vne27m4FoOD7sUr/jJZY/NEhrKdSxTuFr
 iNzw==
X-Gm-Message-State: AOJu0YxBlBt1HPpNI3rRLfm0hpVcoZkhkf03IV4NQ56N5AB9LZUrDfEq
 a7F2QXewRDTUJdwN2s2cCLGUQu+KoLv9dCRlBvKTCWALZXHem+H3aYp9yXY199/2hm21jy1Z+ts
 F+u4e
X-Gm-Gg: Acq92OGZi1Sg6EelBBocfbxSOaYup2w/LW/pi+2n6rpGR1T5j6AmHMvSOPiuPOn9VMl
 Ln8zy3tyuKkX+pwXllwgaeyQ8fhxFwPpxonTd9QIzA8XEFC+mN4ld1PCi8L0rivDGrMTcFVGu6B
 Kztx5Ear7uA/2pNpALzdx5jFc99EpCMXuI6FnzJjzUHmXO84x558cjjWre6cqZH1ZEZpvakTvfv
 /h/enkTouqFLE8Utoa8NwPoG8lRAl/sviE5zov/xaf9qU395MfJQagaMwuvXVGRQWmAJAqtOzDx
 QYvG0jZzeQQZ6vt+pPe7QHC37chuAWKG5F8NNMDjvO4Xysa+Ojqig/PzG7bCP908XumOrKZBWU/
 mf1ZyvwifD6DGuhWb/gnftcauaq64hNlsg1eV1McAjF3fMYHma3o+wSMwIzxgpihZgWezoVtlUk
 mw69iWPWA7cAjImBgNh1Qrh8mqLE/Etk6OC7jBsYTvGS/rFDPpd7zZ07VeP3gI32ITQvPQjAjQQ
 Ahw1Hc3Fdq+2IRC0u1PL+xtk72Y11MriSRaluLO2A==
X-Received: by 2002:a05:600c:3b20:b0:48e:8741:fd53 with SMTP id
 5b1f17b1804b1-490426adc1amr289814525e9.15.1779805772325; 
 Tue, 26 May 2026 07:29:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/54] target/arm: Enable EnFPM bits for FEAT_FPMR
Date: Tue, 26 May 2026 15:28:37 +0100
Message-ID: <20260526142850.2326589-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c    | 3 +++
 target/arm/helper.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e1ea41fdc5..84b2cc70e2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -742,6 +742,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
             if (cpu_isar_feature(aa64_mec, cpu)) {
                 env->cp15.scr_el3 |= SCR_MECEN;
             }
+            if (cpu_isar_feature(aa64_fpmr, cpu)) {
+                env->cp15.scr_el3 |= SCR_ENFPM;
+            }
         }
 
         if (target_el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ae1dd42dc4..7eb7031294 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -787,6 +787,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |= SCR_MECEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            valid_mask |= SCR_ENFPM;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -3973,6 +3976,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_gcs, cpu)) {
         valid_mask |= HCRX_GCSEN;
     }
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        valid_mask |= HCRX_ENFPM;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4046,6 +4052,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_gcs, cpu)) {
             hcrx |= HCRX_GCSEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            hcrx |= HCRX_ENFPM;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
-- 
2.43.0


