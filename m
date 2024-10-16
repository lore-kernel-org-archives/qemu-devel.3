Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3ACD2A549
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kT-0002kt-1x; Wed, 16 Oct 2024 15:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kN-0002g3-2V
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kK-0003pK-Ar
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:50 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cbcd71012so1487215ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107107; x=1729711907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F16mOGOCEtDulhf7gkD6+zfYNl/76OFFUvZQ0M86ofc=;
 b=RUu26uCxYoDiJPFrG5Zj14mJC5PvjKLGbAoNJDRXVLB3GdnRBJoq2kxVNu5lJTBTf8
 H6ltWkr3Fk0oWYHhjFrzvK+f89lgfS7xYu/wPszZl9C3bwi2F1u6Ubv73wK/dut9OSCq
 zIcpxvKDl6dtSXFgRb3Ppw1TDirzkY54B+ZrhaUBEOcRPoQjNuUTXvVvNz9KYYxCNOGK
 SLvt4bqDWY8PKpDMLQSGo4DemuQOnK5W1CMF7P/XNcb2suqj9HoT4UGPXv0rU5BDBQFw
 D9y7pWXDCWzyOeTQ1Pg4Yds9GtBUFUpzpdQETtzwDx/J+4/je0XsEEsV3x/nuwh1qa80
 iUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107107; x=1729711907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F16mOGOCEtDulhf7gkD6+zfYNl/76OFFUvZQ0M86ofc=;
 b=Co48UqZjz1F/mOlyoUMg5j4sXYDgUHxwbNxKCJqltOEMJGgEr4MtSp+LE1DRufCPFU
 yCrFyp3mub/dRUgv4klo8YteOj2j+45e0P+wJp24/LojTaUQ9eEv+R8ufxiaTf8y/xoV
 WlSGQSt9QwIWrOyFjVX5PVKGbwH8IMjWh5IbORDKzqqEu23BpUDB7g9vRKRa027IY+Ke
 k6D9AVKiud5YpZIqUADNVW12OTSJmb603HSXIMAxEmcoIoi5u0Ie/WdprXUKDkVTw6SH
 z9LP8nHpHiI0jkgezASGj/FlF9/jSl+nzWhfpjHeZy1UjiN6jfD4CLjQzDYgxuarzeIq
 qEyA==
X-Gm-Message-State: AOJu0Yz2xV2CzMQAqOr0kzv2weTBIEs0mr06FC/K6r+wuqKxR+mq3nNF
 BZwlNvFY7nli2lw8DEVKSMLJmpAIat2Rd4NngIusXzs6SSlFnaSTgpi4zA2MXwAOaqCmlAnWcx9
 9
X-Google-Smtp-Source: AGHT+IFNO62pnbgm/+kO5qpm//dJySrOK66//oEZCv4qV05G3qrnuUXbmYyVrYCSj63O9uGac7+ykg==
X-Received: by 2002:a17:902:f54d:b0:20c:ecd8:d092 with SMTP id
 d9443c01a7336-20cecd8d2edmr147712825ad.30.1729107106895; 
 Wed, 16 Oct 2024 12:31:46 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v6 08/14] tcg/riscv: Implement vector neg ops
Date: Wed, 16 Oct 2024 12:31:34 -0700
Message-ID: <20241016193140.2206352-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Message-ID: <20241007025700.47259-8-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     | 2 +-
 tcg/riscv/tcg-target.c.inc | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 94034504b2..ae10381e02 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -152,7 +152,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 1893c419c6..ce8d6d0293 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -276,6 +276,7 @@ typedef enum {
     OPC_VADD_VV = 0x57 | V_OPIVV,
     OPC_VADD_VI = 0x57 | V_OPIVI,
     OPC_VSUB_VV = 0x8000057 | V_OPIVV,
+    OPC_VRSUB_VI = 0xc000057 | V_OPIVI,
     OPC_VAND_VV = 0x24000057 | V_OPIVV,
     OPC_VAND_VI = 0x24000057 | V_OPIVI,
     OPC_VOR_VV = 0x28000057 | V_OPIVV,
@@ -2367,6 +2368,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len(s, type);
         tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1);
         break;
+    case INDEX_op_neg_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a1, 0);
+        break;
     case INDEX_op_cmp_vec:
         tcg_out_cmpsel(s, type, vece, args[3], a0, a1, a2, c2,
                        -1, true, 0, true);
@@ -2397,6 +2402,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
@@ -2550,6 +2556,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_neg_vec:
     case INDEX_op_not_vec:
         return C_O1_I1(v, v);
     case INDEX_op_add_vec:
-- 
2.43.0


