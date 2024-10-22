Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE378D17148
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 00:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t32VW-0000FF-0F; Mon, 21 Oct 2024 20:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32V3-00005S-Bx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t32V0-0005Vb-Eg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 20:11:49 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cf6eea3c0so39689585ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 17:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729555904; x=1730160704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2l5tEjtrAAJ1z36wG6T8MRNWs0qyEl5t+tOFHscABs=;
 b=TLo4tzaCU1k12EdR9xC5xT2PQ/hd90hI2rJ9ZlIWdDOLEjY04CyYHDEa651jLgA9Pq
 NEneW52QYLSPWJxguORVs1IUb3jh4CoQsXHzIQg/PRpB/6m7Hqas0C1rC/aHALjdZD/c
 U87csFy3U5xliFt/oHQf2TweYDsgox2SH+DUOQcnaBIQU99DpbqiQ8w5kJgdGwOojOhm
 hnihz69tcCEFFE9+3Sb2NxLdCUvl144gQ6HCsbmVjcEMmoHkqAtDVNEBshrkO8VgKhUH
 u7foenvrddSmX+M9Ul+1+9kgZJNy8jtYgA6KU3xVVuol/pNIhVOU9PPkqoFqY6avyL/k
 IpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729555904; x=1730160704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2l5tEjtrAAJ1z36wG6T8MRNWs0qyEl5t+tOFHscABs=;
 b=J/K5FPck412uHAehYAqF12rXPvXwqcAHu8cfXuCO8wpHDYmwx9+Z2yywshD9Ny2U05
 yUHw3emi2cNR/MQvK2b/ydapfKOrsmw5zmag4Uun2Z5LNLxoEg/l1FMSysw+IRIJu+t3
 alwdRkjSt2sN4cU0a4J5otB9aZS+AUyk/5yo55PXVlFLXABXb7cJdF48rt91wvd4Iv1J
 6GbU5Qn4v4tfCFJSPef/yQ+D5rN3cnRMNiUVZxR1dQCoU+um2eXHA0zY4RjDn4p440hQ
 WWUzH1ByvXMe7VUCSRd2TzAIVCvZw/abvKwxAwUUqLO7fb9CUJ0dP+jNZl7eXMaUAFuO
 RL+g==
X-Gm-Message-State: AOJu0YxzKHswAvRN/blSSMII9qzPUJvVdtY/Jk9WrHAVLE9K1Cf5DXup
 5YYWT9JWzRsbxX7UX4OENfxXWwhRdLTEQP9uRtA/or++uGX6sX+B6U6fUFo5NsDZ4esYbjCkGhU
 E
X-Google-Smtp-Source: AGHT+IGWK2BDoEd35jQz9Ku6Y/h1Oory0t5Yt1npLQy+lFXsKaytCv+tVj0Tz7buPCp7nwLAvRNfgg==
X-Received: by 2002:a17:903:1104:b0:20b:c1e4:2d6c with SMTP id
 d9443c01a7336-20e5a943ad0mr151179705ad.57.1729555904414; 
 Mon, 21 Oct 2024 17:11:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f6462sm31681145ad.272.2024.10.21.17.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 17:11:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, alistair23@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v7 11/14] tcg/riscv: Implement vector min/max ops
Date: Mon, 21 Oct 2024 17:11:31 -0700
Message-ID: <20241022001134.828724-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022001134.828724-1-richard.henderson@linaro.org>
References: <20241022001134.828724-1-richard.henderson@linaro.org>
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


