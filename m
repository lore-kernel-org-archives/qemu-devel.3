Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADE2D1714D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 00:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t32VI-0000AF-TQ; Mon, 21 Oct 2024 20:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32V4-000063-LR
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32V0-0005Vn-Eb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:50 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c805a0753so43127655ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 17:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729555905; x=1730160705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQsTX6H4v2TuWOGDvoBRa/6B8ljDNLzgCo0hPVyXZRg=;
 b=YG5Kwe14KVSlJtlAGzMZOAyqRJqsMCfSJ5ayPmaIiDKsLm2zJoGulKeOWnrWmAhB+Y
 oIL2R3hDBjXFYGqtsLxBopSqvBgYb1a/z0AFfgdNl28nNkng4vKpUy5QNFdM/rB9iLaE
 d7ASOejufAl5QtnVGSry5vkKbvVg6E9jt96enZ5Jf9FaN36ei0DyIJ3FB7yyEqXlJc5d
 2z5AxKRxJNQxxGHojorERmyW/o6hyufZINHi0Ib2Yvsmy+sTS4osu47hPdsKPRiv+TbC
 cGga0iJ8TI2AXehE0FfPBlN9/T6goES+TrBPjCA8bkjHi1ELT1LVvWaVt/7lifMM8eXq
 CY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729555905; x=1730160705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQsTX6H4v2TuWOGDvoBRa/6B8ljDNLzgCo0hPVyXZRg=;
 b=OgIiX/9+4lrGmOjntt2CwqQ9/D12I55AklV1Xg5+ASzEpx1GVkTE04jVNN1UF13tGM
 KrLTK+spHLVEaZnidhSb/jeOPuKBzHKamLDaOPWB3Z0FG5Iaacku47QHdULsFwLpiNwj
 UiSnn2kCiMf+VGtMORsdWRoVDX7mOtv/rdnWWaXbwwWB1WEsUN2Op+QnObG6emOVd1Sc
 UYHLkB00JO1iYZsBrctzx9PrIFOuiJlRND1HW/0Dabnjl33ftna/XcIIjxHUhjcBuLOc
 aVzM3eW0c5j9hyrGOFBKNm5FsEhmFvAmbK4oaslsCyFKaYA4E6i5c6PupseRHIq+OHm5
 xXiA==
X-Gm-Message-State: AOJu0Yxq4iMpsl6FV4AOBmemUu8Aaxoix4gTC18wZPvB8zz31ukC1XYI
 gTRDVL1VAbar6LRpZFXCcVfySpuDnsFUz0qgHFipiFrpB4vd9ocx4krO2UciFDqJ8V3lHng06BV
 /
X-Google-Smtp-Source: AGHT+IFO29zRus/ZKSQdq9bIZL78Jj958vFYAdQJQLqcP/1IXlS2IdCQ/X108ayIYqr40weS1P7p8Q==
X-Received: by 2002:a17:902:d50d:b0:20d:345a:9641 with SMTP id
 d9443c01a7336-20e5a798dfemr162044015ad.27.1729555905053; 
 Mon, 21 Oct 2024 17:11:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6462sm31681145ad.272.2024.10.21.17.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 17:11:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair23@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 12/14] tcg/riscv: Implement vector shi/s/v ops
Date: Mon, 21 Oct 2024 17:11:32 -0700
Message-ID: <20241022001134.828724-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022001134.828724-1-richard.henderson@linaro.org>
References: <20241022001134.828724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-11-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |  1 +
 tcg/riscv/tcg-target.h         |  6 +--
 tcg/riscv/tcg-target.c.inc     | 76 ++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d8ce5414f5..3c4ef44eb0 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -24,6 +24,7 @@ C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
+C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
 C_O1_I2(v, vK, v)
 C_O1_I2(v, v, vK)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 7005099810..76d30e789b 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -157,9 +157,9 @@ typedef enum {
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          0
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          1
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 35b244b7a2..2c78ea6507 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -326,6 +326,16 @@ typedef enum {
     OPC_VMSGT_VI = 0x7c000057 | V_OPIVI,
     OPC_VMSGT_VX = 0x7c000057 | V_OPIVX,
 
+    OPC_VSLL_VV = 0x94000057 | V_OPIVV,
+    OPC_VSLL_VI = 0x94000057 | V_OPIVI,
+    OPC_VSLL_VX = 0x94000057 | V_OPIVX,
+    OPC_VSRL_VV = 0xa0000057 | V_OPIVV,
+    OPC_VSRL_VI = 0xa0000057 | V_OPIVI,
+    OPC_VSRL_VX = 0xa0000057 | V_OPIVX,
+    OPC_VSRA_VV = 0xa4000057 | V_OPIVV,
+    OPC_VSRA_VI = 0xa4000057 | V_OPIVI,
+    OPC_VSRA_VX = 0xa4000057 | V_OPIVX,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -1551,6 +1561,17 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
     }
 }
 
+static void tcg_out_vshifti(TCGContext *s, RISCVInsn opc_vi, RISCVInsn opc_vx,
+                             TCGReg dst, TCGReg src, unsigned imm)
+{
+    if (imm < 32) {
+        tcg_out_opc_vi(s, opc_vi, dst, src, imm);
+    } else {
+        tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP0, imm);
+        tcg_out_opc_vx(s, opc_vx, dst, src, TCG_REG_TMP0);
+    }
+}
+
 static void init_setting_vtype(TCGContext *s)
 {
     s->riscv_cur_type = TCG_TYPE_COUNT;
@@ -2431,6 +2452,42 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_opc_vv_vi(s, OPC_VMINU_VV, OPC_VMINU_VI, a0, a1, a2, c2);
         break;
+    case INDEX_op_shls_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vx(s, OPC_VSLL_VX, a0, a1, a2);
+        break;
+    case INDEX_op_shrs_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vx(s, OPC_VSRL_VX, a0, a1, a2);
+        break;
+    case INDEX_op_sars_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vx(s, OPC_VSRA_VX, a0, a1, a2);
+        break;
+    case INDEX_op_shlv_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSLL_VV, a0, a1, a2);
+        break;
+    case INDEX_op_shrv_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSRL_VV, a0, a1, a2);
+        break;
+    case INDEX_op_sarv_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSRA_VV, a0, a1, a2);
+        break;
+    case INDEX_op_shli_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_vshifti(s, OPC_VSLL_VI, OPC_VSLL_VX, a0, a1, a2);
+        break;
+    case INDEX_op_shri_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_vshifti(s, OPC_VSRL_VI, OPC_VSRL_VX, a0, a1, a2);
+        break;
+    case INDEX_op_sari_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_vshifti(s, OPC_VSRA_VI, OPC_VSRA_VX, a0, a1, a2);
+        break;
     case INDEX_op_cmp_vec:
         tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
                        -1, true, 0, true);
@@ -2471,6 +2528,15 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_sari_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
@@ -2626,6 +2692,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I1(v, r);
     case INDEX_op_neg_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
         return C_O1_I1(v, v);
     case INDEX_op_add_vec:
     case INDEX_op_and_vec:
@@ -2643,7 +2712,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_vec:
         return C_O1_I2(v, vK, v);
     case INDEX_op_mul_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return C_O1_I2(v, v, v);
+    case INDEX_op_shls_vec:
+    case INDEX_op_shrs_vec:
+    case INDEX_op_sars_vec:
+        return C_O1_I2(v, v, r);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
     case INDEX_op_cmpsel_vec:
-- 
2.43.0


