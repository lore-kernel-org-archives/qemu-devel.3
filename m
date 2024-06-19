Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D234CC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2Pe-0002H2-Ib; Wed, 19 Jun 2024 17:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PZ-0002ED-DV
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:09 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PX-0000Zl-FP
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:09 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so157050a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830806; x=1719435606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aV9/9tUhy1q3lTqTAPm4aB01/qjHdGqJPt4bfSkOPy0=;
 b=d2N77oMg7m+MkNClX6pmqcZQDeor5tqlIZOZLuPCUrCUq3zG9452S1njaWfD5gIIM+
 F+zsRbB2YFMSouPoTQlbPBF5u2sDt43WmHJLoQv65frCKUr8Tb5yPuzZknhGJWwm42rF
 B0GohWgZD5evrIB5gCeLALreJXx5z4CL5SXaNsDwJi1Lmve9BTbLOreRrDzchwzq69zn
 9zilqmKimUIygZhCNBBES9BehlH9UyXl38ZmivEt0pSzCtcs8YwEjjD6ql6RaMfoEL2A
 mm6Pp2Yp39GLpbu2hiR5JIQUEaxGYgoB4D7J9M99LIb1cBo50QYMcq+XuRu8V6OSXzE4
 H09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830806; x=1719435606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aV9/9tUhy1q3lTqTAPm4aB01/qjHdGqJPt4bfSkOPy0=;
 b=Y8iINnSzOdzOCfWGGSIJX0PuPiKVtt8F2010NYt17gUEHsWWWYQ+VFCn3BKj+i22Rg
 pBLJkA3R3jEizXBOKBPS8OuZRHX+5KYwfzxj2ZtmND2+rdaHpALfBK/x6P2rIRbN0a9K
 pvTHivZVs3GLebAFb5LIrZeQx1vhPf4duo92KAeZwI8CoiTOoVYyXCDspT6peT5p04+f
 Hn3DgwEhb8Suxzb+LYMdCdmtEoHNsH0/IT93Jpgc27xW+yfZzGfCtNxc5HTiIDSpGcfX
 OI4yireONrwUE4d9k4ymSRwpoIvxPLje70ohLJS33sJSEy2cFligw7PHTGKn4mtqdc7S
 mbtA==
X-Gm-Message-State: AOJu0YwhI/Bes8/yQA+3wGDnnlFZmxyuA2PNFz4+vsTkmsx4JgsUldcS
 tuWNUE2irB3fHu67sQGgpVNXG6hLWRZJaC68IJGbC47XCXAgbuTp54flwKuFNs7nzGLfUbCkbv9
 P
X-Google-Smtp-Source: AGHT+IF073z6Pb0oMBMh2MSsPV4vGRgapkmPypbl24IbVH/GrA0TryXLX7EkHwC+SRrx3xCTgASpmg==
X-Received: by 2002:a17:902:f544:b0:1f7:111c:2d53 with SMTP id
 d9443c01a7336-1f9aa4612a0mr39522375ad.45.1718830805847; 
 Wed, 19 Jun 2024 14:00:05 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.14.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 14:00:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 12/24] tcg/loongarch64: Support LASX in tcg_out_addsub_vec
Date: Wed, 19 Jun 2024 13:59:40 -0700
Message-Id: <20240619205952.235946-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 36 ++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 47011488dd..652aa261a3 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1758,21 +1758,25 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     tcg_out_dup_vec(s, type, vece, rd, TCG_REG_TMP0);
 }
 
-static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
-                               const TCGArg a1, const TCGArg a2,
+static void tcg_out_addsub_vec(TCGContext *s, bool lasx, unsigned vece,
+                               TCGArg a0, TCGArg a1, TCGArg a2,
                                bool a2_is_const, bool is_add)
 {
-    static const LoongArchInsn add_vec_insn[4] = {
-        OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D
+    static const LoongArchInsn add_vec_insn[2][4] = {
+        { OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D },
+        { OPC_XVADD_B, OPC_XVADD_H, OPC_XVADD_W, OPC_XVADD_D },
     };
-    static const LoongArchInsn add_vec_imm_insn[4] = {
-        OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU
+    static const LoongArchInsn add_vec_imm_insn[2][4] = {
+        { OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU },
+        { OPC_XVADDI_BU, OPC_XVADDI_HU, OPC_XVADDI_WU, OPC_XVADDI_DU },
     };
-    static const LoongArchInsn sub_vec_insn[4] = {
-        OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
+    static const LoongArchInsn sub_vec_insn[2][4] = {
+        { OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D },
+        { OPC_XVSUB_B, OPC_XVSUB_H, OPC_XVSUB_W, OPC_XVSUB_D },
     };
-    static const LoongArchInsn sub_vec_imm_insn[4] = {
-        OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU
+    static const LoongArchInsn sub_vec_imm_insn[2][4] = {
+        { OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU },
+        { OPC_XVSUBI_BU, OPC_XVSUBI_HU, OPC_XVSUBI_WU, OPC_XVSUBI_DU },
     };
     LoongArchInsn insn;
 
@@ -1783,10 +1787,10 @@ static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
             value = -value;
         }
         if (value < 0) {
-            insn = sub_vec_imm_insn[vece];
+            insn = sub_vec_imm_insn[lasx][vece];
             value = -value;
         } else {
-            insn = add_vec_imm_insn[vece];
+            insn = add_vec_imm_insn[lasx][vece];
         }
 
         /* Constraint TCG_CT_CONST_VADD ensures validity. */
@@ -1797,9 +1801,9 @@ static void tcg_out_addsub_vec(TCGContext *s, unsigned vece, const TCGArg a0,
     }
 
     if (is_add) {
-        insn = add_vec_insn[vece];
+        insn = add_vec_insn[lasx][vece];
     } else {
-        insn = sub_vec_insn[vece];
+        insn = sub_vec_insn[lasx][vece];
     }
     tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
 }
@@ -1963,10 +1967,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
     case INDEX_op_add_vec:
-        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], true);
+        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], true);
         break;
     case INDEX_op_sub_vec:
-        tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], false);
+        tcg_out_addsub_vec(s, false, vece, a0, a1, a2, const_args[2], false);
         break;
     case INDEX_op_neg_vec:
         tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
-- 
2.34.1


