Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DF0C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFQ-0002cE-Mi; Sun, 04 Feb 2024 16:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFM-0002Y1-5R
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:52 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFK-0003Z4-8E
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:51 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso27236955ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082909; x=1707687709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Od/xSXS8NstAz+sWZVmhj5MEuIknHRPAQGdZXQ5yceo=;
 b=SLO9Ia3r4v4Daltp8toKeIOQqe7vGnqHdX9DPV33H1hTxd2cM+AnyuDWJyfcmMgcq2
 oroc779APiI8ZyBZBL/72U4y3zfFiAkLaQBq0132vv2+oW4djkxFUFC5dra6RipD0PkC
 rLwQMIjkNjyv4zGEc7YVrmi+oMrsA3VGY76T8dtQW4UrCNYfDZm+GVTEIBkNiy2vfisx
 OY1PpBEzLv2wsf5G8ZDLlwjSIKhw/1JxHHhDBzJDHC1h52lOBwW/Ag5mNgerAYfNl2Jn
 X7oeDHF4m49ZHqIDf/VzMTIOkyn0JPrjOdkwdiTEEULGLMO9IEttNWRG1u0gYcSWiEcP
 0cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082909; x=1707687709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Od/xSXS8NstAz+sWZVmhj5MEuIknHRPAQGdZXQ5yceo=;
 b=B7fckriWqkwxZO7YYt8jD52JY/V0ORqyUhDCTv5VDwHH+esWMRFtqMWW4zSqwhi7ur
 MoBaDchdWxhWZLxcuCeTpWW8Hm2njKk7icy4J0zocHrLQzJnNTpsMp0doE58RSyhqlFx
 RWWrWUbMpxtktPuTJenGsgwyEGjO326rpEVuF8qMCbGQNMO1flIJIkRVEKpuIP6PgHW4
 gQnIXbtJgicKJ7a6Nu9+KGX43TDpR+UVDj4sE8KDIEJzY1VlbNcoJPPNj4SDq7Wwe5S4
 /aE5N/Cn14Q6mYWDoSwMah5XVwnRYmjB2miP5LpQ4EnCXLev7gl5VpUMyuvn4hVdlp1o
 cz7Q==
X-Gm-Message-State: AOJu0YxjaUPrEDAJiJKvGfJprHpHRzI9ID5r6Md1IiudkfCEVTp9D72M
 KE3Cze8z0AEYphe8WERk6AFBegcqimeQv/OP8O6l3fC0bXfjti1XQIKMmgLaRmvfa3Wkpqo3r0Y
 KlGI=
X-Google-Smtp-Source: AGHT+IGvDn+ycLG02SyieiVfm1JG05eC7Hg6iurqvme8ofYTyoUPLaBS9s08XT5u1niz9DJhvqbVTA==
X-Received: by 2002:a17:902:e9c4:b0:1d8:f06f:5cfa with SMTP id
 4-20020a170902e9c400b001d8f06f5cfamr6575716plk.59.1707082909052; 
 Sun, 04 Feb 2024 13:41:49 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/39] tcg/i386: Support TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:38 +1000
Message-Id: <20240204214052.5639-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Merge tcg_out_testi into tcg_out_cmp and adjust the two uses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.c.inc | 95 ++++++++++++++++++++++++---------------
 2 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 1dd917a680..a10d4e1fce 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -198,7 +198,7 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128 \
     (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 /* We do not support older SSE systems, only beginning with AVX1.  */
 #define TCG_TARGET_HAS_v64              have_avx1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 02718a02d8..f2414177bd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -506,6 +506,8 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_GEU] = JCC_JAE,
     [TCG_COND_LEU] = JCC_JBE,
     [TCG_COND_GTU] = JCC_JA,
+    [TCG_COND_TSTEQ] = JCC_JE,
+    [TCG_COND_TSTNE] = JCC_JNE,
 };
 
 #if TCG_TARGET_REG_BITS == 64
@@ -1452,17 +1454,49 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
-    if (const_arg2) {
-        if (arg2 == 0) {
-            /* test r, r */
+    int jz;
+
+    if (!is_tst_cond(cond)) {
+        if (!const_arg2) {
+            tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        } else if (arg2 == 0) {
             tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
         } else {
+            tcg_debug_assert(!rexw || arg2 == (int32_t)arg2);
             tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
         }
-    } else {
-        tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        return tcg_cond_to_jcc[cond];
     }
-    return tcg_cond_to_jcc[cond];
+
+    jz = tcg_cond_to_jcc[cond];
+
+    if (!const_arg2) {
+        tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
+        return jz;
+    }
+
+    if (arg2 <= 0xff && (TCG_TARGET_REG_BITS == 64 || arg1 < 4)) {
+        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
+        tcg_out8(s, arg2);
+        return jz;
+    }
+
+    if ((arg2 & ~0xff00) == 0 && arg1 < 4) {
+        tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
+        tcg_out8(s, arg2 >> 8);
+        return jz;
+    }
+
+    if (rexw) {
+        if (arg2 == (uint32_t)arg2) {
+            rexw = 0;
+        } else {
+            tcg_debug_assert(arg2 == (int32_t)arg2);
+        }
+    }
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, arg1);
+    tcg_out32(s, arg2);
+    return jz;
 }
 
 static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
@@ -1479,18 +1513,21 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 {
     TCGLabel *label_next = gen_new_label();
     TCGLabel *label_this = arg_label(args[5]);
+    TCGCond cond = args[4];
 
-    switch(args[4]) {
+    switch (cond) {
     case TCG_COND_EQ:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
-                       label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_EQ, args[1], args[3], const_args[3],
+    case TCG_COND_TSTEQ:
+        tcg_out_brcond(s, 0, tcg_invert_cond(cond),
+                       args[0], args[2], const_args[2], label_next, 1);
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_NE:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+    case TCG_COND_TSTNE:
+        tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
                        label_this, small);
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[1], args[3], const_args[3],
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_LT:
@@ -1827,23 +1864,6 @@ static void tcg_out_nopn(TCGContext *s, int n)
     tcg_out8(s, 0x90);
 }
 
-/* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
-static void __attribute__((unused))
-tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i)
-{
-    /*
-     * This is used for testing alignment, so we can usually use testb.
-     * For i686, we have to use testl for %esi/%edi.
-     */
-    if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
-        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
-        tcg_out8(s, i);
-    } else {
-        tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_TESTi, r);
-        tcg_out32(s, i);
-    }
-}
-
 typedef struct {
     TCGReg base;
     int index;
@@ -2104,16 +2124,17 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_L0,
                    offsetof(CPUTLBEntry, addend));
     } else if (a_mask) {
-        ldst = new_ldst_label(s);
+        int jcc;
 
+        ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addrlo;
         ldst->addrhi_reg = addrhi;
 
-        tcg_out_testi(s, addrlo, a_mask);
         /* jne slow_path */
-        tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
+        jcc = tcg_out_cmp(s, TCG_COND_TSTNE, addrlo, a_mask, true, false);
+        tcg_out_opc(s, OPC_JCC_long + jcc, 0, 0, 0);
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
     }
@@ -2259,9 +2280,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         } else {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
+            int jcc;
 
-            tcg_out_testi(s, h.base, 15);
-            tcg_out_jxx(s, JCC_JNE, l1, true);
+            jcc = tcg_out_cmp(s, TCG_COND_TSTNE, h.base, 15, true, false);
+            tcg_out_jxx(s, jcc, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_VxWx + h.seg,
                                          TCG_TMP_VEC, 0,
@@ -2387,9 +2409,10 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         } else {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
+            int jcc;
 
-            tcg_out_testi(s, h.base, 15);
-            tcg_out_jxx(s, JCC_JNE, l1, true);
+            jcc = tcg_out_cmp(s, TCG_COND_TSTNE, h.base, 15, true, false);
+            tcg_out_jxx(s, jcc, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_WxVx + h.seg,
                                          TCG_TMP_VEC, 0,
-- 
2.34.1


