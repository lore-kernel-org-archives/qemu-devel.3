Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A49DC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhkW-00079F-S7; Mon, 27 May 2024 17:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkV-00078Y-Gu
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:19 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkT-0003bs-NZ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:19 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-681ad26f4a5so95666a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844756; x=1717449556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sg1iVxa+82en/q/7WfgY9cj5/18kkvyZ61i/JWvW0IA=;
 b=GQio++kA7PDpaT32+kID26igFLBu0oi2v4s5uexU7YoAGLkJW7xMRe46RiwtBKU/j7
 XpvI2ilNjJoGuR9A6v9uCpSeEw3ETGyjB7sqhdIEBE4f/OfDzWnu5L8w9tm/5Xpq2eyi
 Jv2TfHVR2sRW+bJpfnCWuCl5RDVL+hDYlgYy3ettg+5ncMHk87tg7EcLl1Z3Y+5jV17o
 RbHz7u0VRevDMOo7lNDiOeNxBcXa7UDsCzkn4mtCBA6KBqCq4M8HJruspA8C9pXwS6vv
 gFe5fnpv12ozhRJ/4QWyIrqGBlu1cbpCOqyX62zC8HRcy+bWNGX0ydPotPYkiI2HDz9f
 Bs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844756; x=1717449556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sg1iVxa+82en/q/7WfgY9cj5/18kkvyZ61i/JWvW0IA=;
 b=JeXe4KNOgqfwoveUvQGoxcBsNYssqdBhAnSNo630tSJzFSySgcm915CVd0r8gVLC0P
 28tj4CxdOpgWFI9XwC6i4Oux4+IRz1SA3vgz1+dtbqTCXlFd7UgsqYAGPNWDDtVUgFCH
 DdAt4LT9YXhOMy++bhyR+Wn6C4fY54/WN7265NHJEGpRMU3wnJC37214IOSAgeaLkSqE
 WwdIWlllR8mj3+yXGvo24koOtXkChmHxtWYDiMRFLrCx8cjRml9xKVff8ByGpkMZ5m6d
 YJ23DsnQYiYvizKxVXyoi2Gn46K9gizsVLVEvEDtebNVGap6zlPRDykGdeQyklakUkRl
 WWbw==
X-Gm-Message-State: AOJu0Yy8lU5SC7OhuzwNmlMVwtIw5zgvE/hrSL0nHK8xYxDL9cUAAyMe
 2QjTWQVFw1NwmRLT3lg9Vg2OJpzbriuMerIM6omRS+G14LIFOMa7F+RpswQjGhVXnjX0DqDgUzd
 S
X-Google-Smtp-Source: AGHT+IG4Xpivt4WVEREiTSC1Mmfj0ZyMSTvm+JbOOl3+hIQdsHt27dHRWpcscRMSJvwsErnxkE9W1w==
X-Received: by 2002:a05:6a20:c703:b0:1b2:1f70:a1fc with SMTP id
 adf61e73a8af0-1b21f70a369mr9439827637.39.1716844756242; 
 Mon, 27 May 2024 14:19:16 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 02/18] tcg/loongarch64: Use fp load/store for I32 and I64 into
 vector regs
Date: Mon, 27 May 2024 14:18:56 -0700
Message-Id: <20240527211912.14060-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 36 +++++++++-----------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 06ca1ab11c..b9078ac793 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -803,6 +803,12 @@ static void tcg_out_ldst(TCGContext *s, LoongArchInsn opc, TCGReg data,
     case OPC_ST_D:
         tcg_out32(s, encode_djsk12_insn(opc, data, addr, imm12));
         break;
+    case OPC_FLD_S:
+    case OPC_FLD_D:
+    case OPC_FST_S:
+    case OPC_FST_D:
+        tcg_out32(s, encode_fdjsk12_insn(opc, data, addr, imm12));
+        break;
     default:
         g_assert_not_reached();
     }
@@ -816,14 +822,14 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
         if (dest < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_LD_W, dest, base, offset);
         } else {
-            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_32, dest, base, offset);
+            tcg_out_ldst(s, OPC_FLD_S, dest, base, offset);
         }
         break;
     case TCG_TYPE_I64:
         if (dest < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
         } else {
-            tcg_out_dupm_vec(s, TCG_TYPE_I128, MO_64, dest, base, offset);
+            tcg_out_ldst(s, OPC_FLD_D, dest, base, offset);
         }
         break;
     case TCG_TYPE_V128:
@@ -847,36 +853,14 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
         if (src < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_ST_W, src, base, offset);
         } else {
-            /* TODO: Could use fst_s, fstx_s */
-            if (offset < -0x100 || offset > 0xff || (offset & 3)) {
-                if (-0x800 <= offset && offset <= 0x7ff) {
-                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
-                } else {
-                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
-                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
-                }
-                base = TCG_REG_TMP0;
-                offset = 0;
-            }
-            tcg_out_opc_vstelm_w(s, src, base, offset, 0);
+            tcg_out_ldst(s, OPC_FST_S, src, base, offset);
         }
         break;
     case TCG_TYPE_I64:
         if (src < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_ST_D, src, base, offset);
         } else {
-            /* TODO: Could use fst_d, fstx_d */
-            if (offset < -0x100 || offset > 0xff || (offset & 7)) {
-                if (-0x800 <= offset && offset <= 0x7ff) {
-                    tcg_out_opc_addi_d(s, TCG_REG_TMP0, base, offset);
-                } else {
-                    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, offset);
-                    tcg_out_opc_add_d(s, TCG_REG_TMP0, TCG_REG_TMP0, base);
-                }
-                base = TCG_REG_TMP0;
-                offset = 0;
-            }
-            tcg_out_opc_vstelm_d(s, src, base, offset, 0);
+            tcg_out_ldst(s, OPC_FST_D, src, base, offset);
         }
         break;
     case TCG_TYPE_V128:
-- 
2.34.1


