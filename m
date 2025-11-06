Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB576CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1IZ-0005Vz-PM; Thu, 06 Nov 2025 09:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vH1IY-0005Vc-4O
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:49:14 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vH1IW-0005UJ-IZ
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:49:13 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7272012d30so180476066b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762440551; x=1763045351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I0etlvZbNwYaPLzX0lVKmatPCLOUs+kyAR7zZ+B1IME=;
 b=mmZ9O/0GnzfxUY609YRnb8oMkVNffqozPlFk2kGc7Et2rF+t5vEC1SoEkINbwQLOMo
 1WX5S0EnT1arENr/MBU7JIeMdhTpuBGvOdTVONND2QZRG9jp/eAM3l8cqDf6bvj/xSfC
 2LDB4VUTwd2nr6Y+Pr1sCYqEN1iSom+3F2mS2BpBVno+yuzoUtkfIKXHASfTvVVHZMHg
 ug8cp+TpD7VWlps5W2g/D1wuit5gyleppDixnp8wGFOZN8POqcSp7w6hdoGw9MvPumOL
 1q1P7mg4pQ5/SQXl8YyxjcLqFE117S+HPGk1zgopHzWMhcwR2ZzlNVXb1F2rRqGqbPd7
 DwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762440551; x=1763045351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I0etlvZbNwYaPLzX0lVKmatPCLOUs+kyAR7zZ+B1IME=;
 b=ZsFJTZ5aSjcmOKMVbD0tvp9eM31e47tpzHzQXLjJ4PQfX3cdBX5AX5yfovoVWHrpjH
 w21cDS51Z1ig0PZyEIYxiyOhTWLlN/rKkU1ekSlJ+AOkfey1IcxuXFrXHAF9p/dPzoAg
 p/tz9y9/etWQVoPP03ZYAjS174bMA72h4ZlF1tJ9Ur6ba7uemYAwZISogkT8QQ1Uq3pB
 vqUy+OVDnr+KvUVNEi6MdcraC8a4kx2bIFibWtONE8AX8ESLuYD/kTLc48b2d2ngYQPh
 thfp9xeR+JGfgUQFKBCVZpdScwGQXQCQ8BJoiVyxyd7Cwy9onwnqqXkD30cHuVUaJ/Ty
 E6EA==
X-Gm-Message-State: AOJu0Yx9FLjGcQP3DMU6nw+Dfz8U9pT5PTaLXLBq3ltax75+2KlEwZoQ
 t6H0OaPZXAw4w4iA5TZpCL2GFdkGnKFLIoKbhPx2gAZQEUroX1fQNCb3Khqw1b/FmAE5FTBWUHI
 P2pp9PsQ=
X-Gm-Gg: ASbGnctxW/etyv9L1UI8K0/XkUx5Phi0v3DUPrtNybb6ZgkXAxeZH3PWfjoi/5orZZj
 oM3hEp4O9BJHutMxsKznvnU/3aWCqB2Sb6HMNc3hRaaIJZUSBwO5OKMntYLM1Mpt0oKsh7gpsu2
 vf1zJlVj+vAIY5IV0CHxrfW+PZBZtMIwlWJLFGDUEyVbXyI6qxXiVjhEkSTOijGiwHoozqnB8Bn
 J0kSyIkYhLbHY7pS3lGwH4BNYctmgDh3c1VpliA/pnT6CGCMDBz5guPgC/BaPcbZ+3qYKDysQRD
 LkyyYlNahvqQ73IW8Rdfy8hA/ivBYEPesVyHDSvZac9pWiLrHyPbuPPY9pTZ/7QD5ZkwgFMNnHw
 WFm+Azo6jctpZtOsTmQ6bbCJiRPtGx+EFf+FmjyxUiUmdBkhDA+Z7D/ILAXlK2hmXqKUemuYCm3
 xyYOiW+TUg0eZ7TMWdhqzcdTCoXg==
X-Google-Smtp-Source: AGHT+IFrrrJcfx/rA/QRrXL/E51LYSIMvbrRvA35T2k2fxTbvQdqmLizVXJbhz/Z6HOV2kiTteQd0Q==
X-Received: by 2002:a17:907:3e0b:b0:b70:b3cb:3b30 with SMTP id
 a640c23a62f3a-b726567fa67mr727274266b.59.1762440550804; 
 Thu, 06 Nov 2025 06:49:10 -0800 (PST)
Received: from stoup.. ([87.213.113.147]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b728933429fsm231990266b.9.2025.11.06.06.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 06:49:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org,
	Anton Johansson <anjo@rev.ng>
Subject: [PATCH] target/arm: Fix accidental write to TCG constant
Date: Thu,  6 Nov 2025 15:49:09 +0100
Message-ID: <20251106144909.533997-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

Currently an unpredictable movw such as

  movw pc, 0x123

results in the tinycode

   and_i32 $0x123,$0x123,$0xfffffffc
   mov_i32 pc,$0x123
   exit_tb $0x0

which is clearly a bug, writing to a constant is incorrect and discards
the result of the mask.  Fix this by adding a temporary in store_reg().

Signed-off-by: Anton Johansson <anjo@rev.ng>
[rth: Avoid an extra temp and extra move.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 5f64fed220..63735d9789 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -303,20 +303,23 @@ TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs)
    marked as dead.  */
 void store_reg(DisasContext *s, int reg, TCGv_i32 var)
 {
+    uint32_t mask = 0;
+
     if (reg == 15) {
-        /* In Thumb mode, we must ignore bit 0.
+        /*
+         * In Thumb mode, we must ignore bit 0.
          * In ARM mode, for ARMv4 and ARMv5, it is UNPREDICTABLE if bits [1:0]
          * are not 0b00, but for ARMv6 and above, we must ignore bits [1:0].
          * We choose to ignore [1:0] in ARM mode for all architecture versions.
          */
-        tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
+        mask = s->thumb ? 1 : 3;
         s->base.is_jmp = DISAS_JUMP;
         s->pc_save = -1;
     } else if (reg == 13 && arm_dc_feature(s, ARM_FEATURE_M)) {
         /* For M-profile SP bits [1:0] are always zero */
-        tcg_gen_andi_i32(var, var, ~3);
+        mask = 3;
     }
-    tcg_gen_mov_i32(cpu_R[reg], var);
+    tcg_gen_andi_i32(cpu_R[reg], var, ~mask);
 }
 
 /*
-- 
2.43.0


