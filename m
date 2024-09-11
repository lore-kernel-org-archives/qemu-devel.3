Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64E7EE57C8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYR-0001xC-TX; Wed, 11 Sep 2024 12:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYQ-0001rn-Al
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:54 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYO-0003eC-8M
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:50:54 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7db174f9050so30642a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073451; x=1726678251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4LfLCCfd77AE3gIUDkv8zMuzeAX8OHemsoCsp4r7PY=;
 b=Yn+TF8iFS0O+5Vw/6QXmmUH33fyrxlY5MKmAAd0rXtonfk0vnzDGqyIkltkk5QouN5
 boYtZmp1DvIgu5mAI9MAomgpIUVOlPhDTib9dU1KJg0w7WPr5o30H//e0eK5exx18u3r
 0+QDqyKv+ujBeY0QSyECAZxDKNggetU+3OWEwu0gRjsVhmeaLYYW17zc8Gjm5auzVgF2
 1g0qH19rmPN9G5Gy6+Gw7n0LlAKtybIdyQ+gcpRGVkEg1B+3lHjY1U3NUzg6vuYMKLvO
 u5z4d8a69YaNxz9W5e0+rbOLqekxc0OZPiWhnPPyl7GCwxPtRpsuPDybomRq7w6hEOxj
 ojig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073451; x=1726678251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4LfLCCfd77AE3gIUDkv8zMuzeAX8OHemsoCsp4r7PY=;
 b=d2QYW8iM4zZ+wPsxa64iApYMb1vl8mBjShbyZx6xLTve8jWOK7Zkn9+DBUoFZbDwU0
 wxY6kvBz4DhGEbUJ5bi8Joq8kIpeT9GaWHiDM0ZF48NQEzh7AhaugKji3W/ZRNbESsaG
 8/kZq2yPcSAPYaH2y7X0+WsJZkbW8xrbDfme14vvShhDLHsSUmh2ZWhMWCgtwA8E+RCb
 /qXCQxw/fRXUhlnBxiJ+ylTjn7ILCIXK0kekF9tf86nIL/qS+MSzTifVzCzJDAE5B0Yh
 8zrGdOc7wdlTvxAykD6qXZ9Moy1bBQyqU0JAMbTwPPTdjch1qfyaLqMwC+jNABUx2TrF
 Z88A==
X-Gm-Message-State: AOJu0Yw7BShFf3FJbUx7ZfJ3YEZFDEn0n3H8ZKFkDFpgq8vaAtMI7hAU
 3GFeBIO/ukNkG14PWUoIGQ8lZF6ulv9TXS1x4TDo7SGolK8Keec7Y9LiEhdn92vM2tQbtx3otLk
 N
X-Google-Smtp-Source: AGHT+IFn8LWW0mQbbQ3lncg5aU5yuUvEE2h8vNuPGqorWDXr2WYRJj8jlHkap/m4oOOiC4eA8jjAfQ==
X-Received: by 2002:a05:6a20:c70b:b0:1cf:5d45:3b29 with SMTP id
 adf61e73a8af0-1cf5e1577cemr7790850637.35.1726073450774; 
 Wed, 11 Sep 2024 09:50:50 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 02/18] tcg/i386: Split out tcg_out_vex_modrm_type
Date: Wed, 11 Sep 2024 09:50:31 -0700
Message-ID: <20240911165047.1035764-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Helper function to handle setting of VEXL based
on the type of the operation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9a54ef7f8d..af71a397b1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -711,6 +711,15 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
+static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
+                                   int r, int v, int rm, TCGType type)
+{
+    if (type == TCG_TYPE_V256) {
+        opc |= P_VEXL;
+    }
+    tcg_out_vex_modrm(s, opc, r, v, rm);
+}
+
 /* Output an opcode with a full "rm + (index<<shift) + offset" address mode.
    We handle either RM and INDEX missing with a negative value.  In 64-bit
    mode for absolute addresses, ~RM is the size of the immediate operand
@@ -904,8 +913,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg r, TCGReg a)
 {
     if (have_avx2) {
-        int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
-        tcg_out_vex_modrm(s, avx2_dup_insn[vece] + vex_l, r, 0, a);
+        tcg_out_vex_modrm_type(s, avx2_dup_insn[vece], r, 0, a, type);
     } else {
         switch (vece) {
         case MO_8:
@@ -3231,10 +3239,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_simd;
     gen_simd:
         tcg_debug_assert(insn != OPC_UD2);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, insn, a0, a1, a2, type);
         break;
 
     case INDEX_op_cmp_vec:
@@ -3250,10 +3255,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a2, a1);
+        tcg_out_vex_modrm_type(s, insn, a0, a2, a1, type);
         break;
 
     case INDEX_op_shli_vec:
@@ -3281,10 +3283,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_shift;
     gen_shift:
         tcg_debug_assert(vece != MO_8);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, sub, a0, a1);
+        tcg_out_vex_modrm_type(s, insn, sub, a0, a1, type);
         tcg_out8(s, a2);
         break;
 
@@ -3361,19 +3360,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     gen_simd_imm8:
         tcg_debug_assert(insn != OPC_UD2);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, insn, a0, a1, a2, type);
         tcg_out8(s, sub);
         break;
 
     case INDEX_op_x86_vpblendvb_vec:
-        insn = OPC_VPBLENDVB;
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, a0, a1, a2, type);
         tcg_out8(s, args[3] << 4);
         break;
 
-- 
2.43.0


