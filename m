Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E914CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqM-0007GV-KG; Fri, 10 Oct 2025 09:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqH-0007BO-52
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpK-0003ym-Sa
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so13086705e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101585; x=1760706385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jfCqvYmDBzQS0MlZ3vkHzNfRKleHbLlTPbhSwKkY4vc=;
 b=RSIz5z9oZnkE74FEYRNPjkTFQJAavi7znDOQ/qyHHpNFUyuQOElh9e0/OgoWyFd/T7
 CZTE555haz/fjl0iUCgbQg/WIxopCQJ+dhKZFhFy0cKfRci+K32C9TIsAnw+yWiSemxM
 jRoeTk82jKlsiG19qM3rdLDdD7dBDrr1J1atLjDtPGgo/uy7nenuW5RDqIEYAbHc112E
 PwnQ3w80hzOJnlksMIR6ePTIl6Ib1MOSmTNcDuakD6+Naxm3o54F36sv+cs/idiDhNii
 zmDIGw5dNOpJEDizSGkn2kO8iEa7y5TtBUsoeI+Tg9FJb6siKT6Qdm2gVBBJjNcStCNW
 ZmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101585; x=1760706385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfCqvYmDBzQS0MlZ3vkHzNfRKleHbLlTPbhSwKkY4vc=;
 b=OrUCj2AEFmLSOMGj42LEWQf76cnmXiF9/lmzUXfpClqf3Wiqv0RURRl9rpYQLr8/Bf
 bZhnMVwhY/iDtrJF7pdUGTjj17uoEiB7pzIlu1BH+fLyYDqzb9Ua1GqhKYLQUGAmkEnk
 oDbdw2H0WpeaHtDcbNjE7Rg8pWB/dFbtW1PK2pqbNdV9/MZZUZOSWpVmVCm+lNCVkg3n
 0WSwrVRvSASFKIFIEB2CJkIkHiJ0xQpHuL0KcwVgIoIpw4axp0p5DC/EBP3WAw2nltoD
 i4ObJ9t0FLc3ZSe/JBDASsAkQcd60UrtmWUMesZazVk/ROSpPK7TDH5mOaO2RVeqGeCB
 sxsg==
X-Gm-Message-State: AOJu0YzYmdRGSoM9ay/drNZPoUWvL3dKhi1zqab2DEcm8Bv8IxicBHCC
 RHDOTRf0t4SmnsG5EaobIMM0l70TIwWs350oW0eRACAiF5pfpo0ELrxzQlskfM47SdRmLhhb6OU
 W04Z6
X-Gm-Gg: ASbGncuhPw+FE/NkMwCtEZDwE2JbQg6TCaDvEn1rX0DN8BHvQk0mLXBesSLETcan6Qq
 wJKMARtwHbY4qu+j4g2QXOr/CtYyE6VqgwBy9DFi9jV5RRMHZY+QaeLDJjlJnscPowacfnDsTU9
 mv/Eud2ApDsR5yO6yZmSueF3fzMwfBV3ohK1vg1SaBEzXRc1pc7eh03E4De6sOprk9QnocUeIlq
 TQvLixrJoFOOyJ7BymH9AalEFUZtc46D/tHDCL2ttjmuaK7XnVR2YdbF6PDV1c62a+vDlRVV3mg
 NDg/yxUZ+rcC+/+3V1tB7KEuQwm8zm3Gxp2TF4+6GVjK7nSE2QSXU1Nk8gUO43uLQzNlUk85cZX
 vQ29AmuYX3zOOwCoBflwlAP+dizC7JGtkGSntQdhchkLyEzJWL7g=
X-Google-Smtp-Source: AGHT+IENQ0f3MGXkNbbuQ3Ca4FEbwmSue+yCdijK79/53OITGK2WqgPpDqsqzOmwN2Z8sMnD/aG/RA==
X-Received: by 2002:a05:600c:820a:b0:46c:e3df:529e with SMTP id
 5b1f17b1804b1-46fa9af9019mr85310675e9.19.1760101585245; 
 Fri, 10 Oct 2025 06:06:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/76] target/arm: Implement GCSPOPM
Date: Fri, 10 Oct 2025 14:05:00 +0100
Message-ID: <20251010130527.3921602-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-50-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index d22ae383cdb..81d8f0e32b1 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -49,6 +49,7 @@ enum {
     ARM_CP_DC_GZVA               = 0x0007,
     /* Special: gcs instructions */
     ARM_CP_GCSPUSHM              = 0x0008,
+    ARM_CP_GCSPOPM               = 0x0009,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index cc5a0b86e4b..15d383b2a41 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -100,6 +100,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 0,
       .access = PL0_W, .accessfn = access_gcspushm,
       .fgt = FGT_NGCSPUSHM_EL1, .type = ARM_CP_GCSPUSHM },
+    { .name = "GCSPOPM", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 7, .opc2 = 1,
+      .access = PL0_R, .type = ARM_CP_GCSPOPM },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 625563d95be..7783273cc1d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2521,6 +2521,24 @@ static void gen_sysreg_undef(DisasContext *s, bool isread,
     gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
 }
 
+static void gen_gcspopm(DisasContext *s, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPM, rt));
+
+    /* The value at top-of-stack must have low 2 bits clear. */
+    tcg_gen_qemu_ld_i64(value, clean_data_tbi(s, gcspr), mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_TSTNE, value, 3, fail_label);
+
+    /* Complete the pop and return the value. */
+    tcg_gen_addi_i64(gcspr, gcspr, 8);
+    tcg_gen_mov_i64(cpu_reg(s, rt), value);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2832,6 +2850,12 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_add_gcs_record(s, cpu_reg(s, rt));
         }
         return;
+    case ARM_CP_GCSPOPM:
+        /* Note that X[rt] is unchanged if !GCSEnabled. */
+        if (s->gcs_en) {
+            gen_gcspopm(s, rt);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


