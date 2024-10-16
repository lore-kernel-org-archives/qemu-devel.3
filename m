Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA44D2A541
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kT-0002lZ-H9; Wed, 16 Oct 2024 15:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kO-0002hf-Pq
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kL-0003pu-MT
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:52 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso2155405ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107108; x=1729711908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dluUCaEndjBCunQfjOsd/2zhh5fJAnoMBhZPYS0jDTY=;
 b=s7GsZPaxxkxY9mrAShlFoEkdDaGA1fSqSQsCnG55hHPlVJHxhJV9kRBdu0QmG4jvcc
 c0pGWoeNEcBwR7xrmcUhe+mMpHaU+Q2eQAqvbl3rVmfJ1L6RbZuKPwUQxVSm6QysqLjw
 I632etlBZi/UQOgpLoXDFApfNz/MD94VwSaxQmzGy3/5Dtl9CwZJZQ5HyWniinaMjqrX
 e5iT7vEeL4bLLGVm7UNE69zWUP7H53mMgN6+EFz9gRHWdqqJQRCJoPmfnXBBuDmg4Dqj
 dLe4hB7+RC2EL/dFz+R+wZGma2LaDIQhyra3zgy3DbKW2daZ6jmG0gux/VjE1yhQkr96
 ECYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107108; x=1729711908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dluUCaEndjBCunQfjOsd/2zhh5fJAnoMBhZPYS0jDTY=;
 b=vcTTbQi9G3hOYjsQWPe2dbdhneiykqrxxtb5Inzxa0cAhhxJOJtRX5rWCpD4xXpPf6
 RtwLgB2S6wncKh6f6dPbzWhr7u5GwSWYW3RF62BeLhYpJ1hfEx63iWWmlodyN3D5/Wp3
 QektMdAVAb+Ndo9LnAF4s/7aH9lojjyON6NtoEnkJlTrgu5gUSwlw52cjRqBRAe+hLTJ
 QBc8FycN3csI9fB1w/b6oMfYcxp/TZ/AGvgiIktiFPMZbsXhIlNenhcDmCE/rwHFDTpa
 01XEMMvtzt8jyOAMo0ZTSvieS9ox3X0dKN7i679HsVMrEToJB5JVOCX4MYxGfl2cs3jz
 GRYw==
X-Gm-Message-State: AOJu0YwpEeNUOLjjiyiZwwCbwrb+BtSWgFMRh7Dw2Hy+mDVV5fZzlYRl
 WnbqcoRHwpMlQjNVe+6ijR2Qp5V4mtEYOrHwRmiBO5agKSbfsyRPnaKX+qWan14j5EbnkM+Ajnx
 U
X-Google-Smtp-Source: AGHT+IGd+q4ycDu4KKuJgYwmSHWw3qn3CzqvgF7/8wUEtvZWDIfAJDtkFOw8ft6NmU0+E2zuuXeHmg==
X-Received: by 2002:a17:902:e951:b0:20b:59be:77b with SMTP id
 d9443c01a7336-20cbb1a9654mr260092385ad.6.1729107108225; 
 Wed, 16 Oct 2024 12:31:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v6 10/14] tcg/riscv: Implement vector sat/mul ops
Date: Wed, 16 Oct 2024 12:31:36 -0700
Message-ID: <20241016193140.2206352-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-9-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  4 ++--
 tcg/riscv/tcg-target.c.inc | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index ae10381e02..1d4d8878ce 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -160,8 +160,8 @@ typedef enum {
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       0
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       1
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1ce2f291d3..4758555565 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -284,6 +284,16 @@ typedef enum {
     OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
     OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
 
+    OPC_VMUL_VV = 0x94000057 | V_OPMVV,
+    OPC_VSADD_VV = 0x84000057 | V_OPIVV,
+    OPC_VSADD_VI = 0x84000057 | V_OPIVI,
+    OPC_VSSUB_VV = 0x8c000057 | V_OPIVV,
+    OPC_VSSUB_VI = 0x8c000057 | V_OPIVI,
+    OPC_VSADDU_VV = 0x80000057 | V_OPIVV,
+    OPC_VSADDU_VI = 0x80000057 | V_OPIVI,
+    OPC_VSSUBU_VV = 0x88000057 | V_OPIVV,
+    OPC_VSSUBU_VI = 0x88000057 | V_OPIVI,
+
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2376,6 +2386,26 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a1, 0);
         break;
+    case INDEX_op_mul_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMUL_VV, a0, a1, a2);
+        break;
+    case INDEX_op_ssadd_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_sssub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_usadd_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_ussub_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1, a2, c2);
+        break;
     case INDEX_op_cmp_vec:
         tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
                        -1, true, 0, true);
@@ -2407,6 +2437,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
@@ -2567,9 +2602,15 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
         return C_O1_I2(v, vK, v);
+    case INDEX_op_mul_vec:
+        return C_O1_I2(v, v, v);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
     case INDEX_op_cmpsel_vec:
-- 
2.43.0


