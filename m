Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA32D2A543
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kW-0002om-1d; Wed, 16 Oct 2024 15:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kO-0002hp-Up
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kM-0003qJ-DW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso1607465ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107109; x=1729711909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2l5tEjtrAAJ1z36wG6T8MRNWs0qyEl5t+tOFHscABs=;
 b=YEc4eecFzjc5UTf7feocWov9uKgZADCErmCJeQxkaLByEg48OWCzE4WM5SKwzaEMzp
 C4/DUsexNIDFyyJKX3goC9deYRPbEabtvdyPXRx8dZQDp8FQGU6Do0ojQGbWxtXsgmFz
 /kk+nkt2cE3j+HS70wXvrVq2EhkLSTsmlU6EdU6AmC3nBjBQNI3LEx8DF7aHALhMwIcq
 GgFTtE7ziEJdfrpvwG8UuTi/Q9ubPztfRVNq8u5WgAwKTh0/Z/NF3glGaPgkgtbBMr9/
 cRU6vd0CqI8e85mP22IhlfzkH5U3lC/wH2Pl1xmPAmDo2vCOP8g/PFV1xwIhnrl0Ifur
 zNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107109; x=1729711909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2l5tEjtrAAJ1z36wG6T8MRNWs0qyEl5t+tOFHscABs=;
 b=RbZh/gRR5I1YNKzDq8a3kS9THQYagk4U4JYXANG1XMX7DUAeg9uwx93ToM3PgKgTyr
 UWwNt+k0B/VhSCSQf+bcJGP5reFTrOanN//0guSKCs3Dz22neQGsl1LGaPwz/M9CY4RV
 QAPRjQV941dY+drqn3iA5a3mIunyoxQG+arg/Sz80JH8Pwat8DnfZvz7Fn4/Wd2Uh3vY
 A36Wp8U4A9GrogZxG3k4VHya+XbkFwzdZKVD30idChPvNeClJPnAoIVtbrhVmHeqonE8
 2fHNU3t8xP2OTJWawN/pj0gQEF4Yt4N+ucHWM7+vB/f71HY3eCMkH/oq7srB++HN8NoR
 iHBQ==
X-Gm-Message-State: AOJu0Yw0wRRNbxCxscs0wF/vVklp5b0VYs8vvdLDX7i/6Gm4JnLNm2rV
 gBPDaJ51nyyN/a6waWfIjGZiqt83qJo2An9ewchLfJaHT7OZyMAew6pZrGpiX/hD3ASMthOD5JA
 I
X-Google-Smtp-Source: AGHT+IGmm0A+rC3SfktNTz7pDuwd/1J0BI10FBRB99DDMGD38q5EIDg72Fzw2mFNsy4C1nPzb0O6sg==
X-Received: by 2002:a17:902:e802:b0:20c:bcd8:5ccb with SMTP id
 d9443c01a7336-20d27ecae36mr59790865ad.30.1729107108896; 
 Wed, 16 Oct 2024 12:31:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v6 11/14] tcg/riscv: Implement vector min/max ops
Date: Wed, 16 Oct 2024 12:31:37 -0700
Message-ID: <20241016193140.2206352-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
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
Message-ID: <20241007025700.47259-10-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  2 +-
 tcg/riscv/tcg-target.c.inc | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 1d4d8878ce..7005099810 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -162,7 +162,7 @@ typedef enum {
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       1
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4758555565..35b244b7a2 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -294,6 +294,15 @@ typedef enum {
     OPC_VSSUBU_VV = 0x88000057 | V_OPIVV,
     OPC_VSSUBU_VI = 0x88000057 | V_OPIVI,
 
+    OPC_VMAX_VV = 0x1c000057 | V_OPIVV,
+    OPC_VMAX_VI = 0x1c000057 | V_OPIVI,
+    OPC_VMAXU_VV = 0x18000057 | V_OPIVV,
+    OPC_VMAXU_VI = 0x18000057 | V_OPIVI,
+    OPC_VMIN_VV = 0x14000057 | V_OPIVV,
+    OPC_VMIN_VI = 0x14000057 | V_OPIVI,
+    OPC_VMINU_VV = 0x10000057 | V_OPIVV,
+    OPC_VMINU_VI = 0x10000057 | V_OPIVI,
+
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2406,6 +2415,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1, a2, c2);
         break;
+    case INDEX_op_smax_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VMAX_VV, OPC_VMAX_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_smin_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VMIN_VV, OPC_VMIN_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_umax_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VMAXU_VV, OPC_VMAXU_VI, a0, a1, a2, c2);
+        break;
+    case INDEX_op_umin_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv_vi(s, OPC_VMINU_VV, OPC_VMINU_VI, a0, a1, a2, c2);
+        break;
     case INDEX_op_cmp_vec:
         tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
                        -1, true, 0, true);
@@ -2442,6 +2467,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
@@ -2606,6 +2635,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return C_O1_I2(v, v, vK);
     case INDEX_op_sub_vec:
         return C_O1_I2(v, vK, v);
-- 
2.43.0


