Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA05C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFd-0003On-0W; Sun, 04 Feb 2024 16:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFY-00035R-Qo
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:06 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFW-0003bW-Lo
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:04 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d94323d547so29787715ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082921; x=1707687721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Njou8078FZIGaih/KmoVshAEm+KpvJ/TDJRnizv9npg=;
 b=mGOBDGLka1XKGdc3MJgsMNDRaFXaVQxBL6kfRdYeD8Rtdks5aGeoLiKU0Vo/s7dik6
 noq5ZPVlH7uATwV3RoTUTH7AkHJHQgL1uRU/vQuzOQIBClgIXfI/KYLJl8x1QmQYyTXo
 qoKs/66Qlb2T2weeoSRtJ2t0lUkVMRPr7uHcI7D+C+jyXK+U8H84LzyqhtfEoyRxR1R9
 gGQQR4AQRP7nyGKkvUDJvi9ekYShUvEgzzMGFJvXnx9ZIiNEqMAThPCHNeNrqBoLYKWy
 9aPOzG8GX+Yq+arP8CKw7j2CRTbTNlyYcDEacNOlimAQO5mgol3V66rh4sLrBedCtNOe
 snjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082921; x=1707687721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Njou8078FZIGaih/KmoVshAEm+KpvJ/TDJRnizv9npg=;
 b=uN3WHiwxJA0npAhF1u5oTkcCGiLj2wEDI/48RsQkMu2sB9BR1c6U6+QB7lJ6TWLNML
 /AmyJd7rvtXZM5bMZ7XrNE3+IBhtqlJVOtxdvVSPN4DFh5++g/6QoLCCICUyqnu1RC9g
 0yOfj6enYZLWHrPcNNM3CiC2grlzsjWAnVjyn4AgFNLeX0AdFphm07bZ13/xdwvuwJym
 dMN8bw9WUBThMNkIvgLVOuEybZ1cAOQsxVVsPLvS2QZXV7l97M4xMZKoIRT96XheTZij
 RSXvcuumkbWm4Jf+LVnuvbTTh/H1ma5QRklmqyunJuhRRZsVF2PtMLVNsfuGkgMmhAbu
 BNuQ==
X-Gm-Message-State: AOJu0YylKk8kQh/j2K/ozq6Ty26Q8GKgdcqCHvQyD3AN3ZrwLacIwJGI
 +ptw5cIx2VVawmYXyramCqDmpVKuXfQVUlnrqvY5Ky6pJ2jk/CmRh2WOKCQO/gm0TQ0IvXRIC3I
 F2+k=
X-Google-Smtp-Source: AGHT+IGkShMsME+17YGJovzi742eWvFHsCD3lBqB8iMPpJGBWkjxsNtuoSbKsW3XYSOn0wQyRyL7xQ==
X-Received: by 2002:a17:902:f545:b0:1d9:a674:aa77 with SMTP id
 h5-20020a170902f54500b001d9a674aa77mr1951226plf.24.1707082921409; 
 Sun, 04 Feb 2024 13:42:01 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/39] tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
Date: Mon,  5 Feb 2024 07:40:44 +1000
Message-Id: <20240204214052.5639-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Rename the current tcg_out_bc function to tcg_out_bc_lab, and
create a new function that takes an integer displacement + link.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 850ace98b2..830d2fe73a 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1946,14 +1946,20 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 }
 
-static void tcg_out_bc(TCGContext *s, int bc, TCGLabel *l)
+static void tcg_out_bc(TCGContext *s, TCGCond cond, int bd)
 {
+    tcg_out32(s, tcg_to_bc[cond] | bd);
+}
+
+static void tcg_out_bc_lab(TCGContext *s, TCGCond cond, TCGLabel *l)
+{
+    int bd = 0;
     if (l->has_value) {
-        bc |= reloc_pc14_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
+        bd = reloc_pc14_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
     } else {
         tcg_out_reloc(s, s->code_ptr, R_PPC_REL14, l, 0);
     }
-    tcg_out32(s, bc);
+    tcg_out_bc(s, cond, bd);
 }
 
 static void tcg_out_brcond(TCGContext *s, TCGCond cond,
@@ -1961,7 +1967,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond,
                            TCGLabel *l, TCGType type)
 {
     tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
-    tcg_out_bc(s, tcg_to_bc[cond], l);
+    tcg_out_bc_lab(s, cond, l);
 }
 
 static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
@@ -2003,7 +2009,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
             }
         }
         /* Branch forward over one insn */
-        tcg_out32(s, tcg_to_bc[cond] | 8);
+        tcg_out_bc(s, cond, 8);
         if (v2 == 0) {
             tcg_out_movi(s, type, dest, 0);
         } else {
@@ -2024,11 +2030,11 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
             tcg_out32(s, tcg_to_isel[TCG_COND_EQ] | TAB(a0, a2, TCG_REG_R0));
         } else if (!const_a2 && a0 == a2) {
-            tcg_out32(s, tcg_to_bc[TCG_COND_EQ] | 8);
+            tcg_out_bc(s, TCG_COND_EQ, 8);
             tcg_out32(s, opc | RA(a0) | RS(a1));
         } else {
             tcg_out32(s, opc | RA(a0) | RS(a1));
-            tcg_out32(s, tcg_to_bc[TCG_COND_NE] | 8);
+            tcg_out_bc(s, TCG_COND_NE, 8);
             if (const_a2) {
                 tcg_out_movi(s, type, a0, 0);
             } else {
@@ -2108,11 +2114,11 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
     tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, 31, 31, 31);
 }
 
-static void tcg_out_brcond2 (TCGContext *s, const TCGArg *args,
-                             const int *const_args)
+static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
+                            const int *const_args)
 {
     tcg_out_cmp2(s, args, const_args);
-    tcg_out_bc(s, BC | BI(7, CR_EQ) | BO_COND_TRUE, arg_label(args[5]));
+    tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
 }
 
 static void tcg_out_mb(TCGContext *s, TCGArg a0)
@@ -2446,7 +2452,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
         ldst->label_ptr[0] = s->code_ptr;
-        tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
+        tcg_out_bc(s, TCG_COND_NE, LK);
 
         h->base = TCG_REG_TMP1;
     } else {
-- 
2.34.1


