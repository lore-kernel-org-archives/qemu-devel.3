Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD98C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10B-0004dS-MN; Fri, 31 May 2024 08:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zt-0004Sw-Kf
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zn-0003W1-QD
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421338c4c3bso645315e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157070; x=1717761870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Cl6hphlrp5B4h9rodhQH5Ja12Wip+zDVetQCGVJBlI=;
 b=UJcdL2++ILovKoNXAgupS2OxScqCsQa36jhngakSWrDoL++bFij5is0T40+7+E2evG
 XvQN7fbTtVacbb6K/3GlWPwsVDNVSLx6sTes7MnQd6LQKR6ChvKST2U+/X5HN7eDiVhz
 ggctrcc3PYkAWjlfS9KECltyaJWot7G+RWJKqIKMKs19ojszt3z5wQ0yRjqA6gEW9YyP
 iBDFDSFzc03jvFg5f5mrNyKJbF2Tjsx0uuIPl37hU54J28uUW7vDSbRTiFtp523pQ81N
 /HHhAZwD4AyzMEbdzBx+nPKl73koM01w/MN5QBdPSAVyWsQnPGzMV7fWX9r9HVUB2CoF
 ffKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157070; x=1717761870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Cl6hphlrp5B4h9rodhQH5Ja12Wip+zDVetQCGVJBlI=;
 b=Qf30aQUX7KU45+5+rmDlgL4OWKajODp/gzNn6oGnieW3H/s01jimXe4iGRqRx2y8Xu
 cdB6ObWydTCX4Cs0OLZBBgqJdif7MnG3wvLp2mbh0g1kFnNBcBCAqlW8tfvpQWG37pRB
 Yn3afZ53zklFi3kRnot2okD3/FVTs5PGrtPH19GaldDoWehoCl9YLRgtC43Ms5wUdPwW
 K9gN9ZFRf/Bb/xL4KlsAJ2FrCJ3Be2EZmsAEAMR9bMZb6kFsAMv11Dz7CJqUsBZ8ScnY
 UEqiezWECYFLB97DQFpoeedulg5ObrplJq1FbSYD1ZtPqDJPjZmiff43hhOyfHPg2sIE
 kLVw==
X-Gm-Message-State: AOJu0Yzae15Jh6fPWtN1dmHdZgRTQc5herL//lNUoXsLiS4BxA9ZdH6L
 G/VxiJwkD1A+aPoqTh4JUZcLH+V5qJlAwdDGUfEGtPXBZ7318tWvn03g/VDiP8AsrursFqZn2qO
 z
X-Google-Smtp-Source: AGHT+IFAEG2YpVOBot5hgXdoieIF2SmudMkF9p71sDchy+HQxmUdlma/OyLxfqModAUu0ibglQGEPg==
X-Received: by 2002:a05:600c:19c9:b0:421:29cd:5cb9 with SMTP id
 5b1f17b1804b1-4212e06217amr13877495e9.20.1717157069995; 
 Fri, 31 May 2024 05:04:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/43] target/arm: Convert FCSEL to decodetree
Date: Fri, 31 May 2024 13:03:56 +0100
Message-Id: <20240531120401.394550-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-34-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   4 ++
 target/arm/tcg/translate-a64.c | 108 ++++++++++++++-------------------
 2 files changed, 49 insertions(+), 63 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6f6cd805b71..5dadbc74d73 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1000,6 +1000,10 @@ SQDMULH_vi      0.00 1111 10 . ..... 1100 . 0 ..... .....   @qrrx_s
 SQRDMULH_vi     0.00 1111 01 .. .... 1101 . 0 ..... .....   @qrrx_h
 SQRDMULH_vi     0.00 1111 10 . ..... 1101 . 0 ..... .....   @qrrx_s
 
+# Floating-point conditional select
+
+FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
+
 # Floating-point data-processing (3 source)
 
 @rrrr_hsd       .... .... .. . rm:5  . ra:5  rn:5  rd:5     &rrrr_e esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 78a2e6d6922..f1dea5834c4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5866,6 +5866,50 @@ static bool trans_ADDP_s(DisasContext *s, arg_rr_e *a)
     return true;
 }
 
+/*
+ * Floating-point conditional select
+ */
+
+static bool trans_FCSEL(DisasContext *s, arg_FCSEL *a)
+{
+    TCGv_i64 t_true, t_false;
+    DisasCompare64 c;
+
+    switch (a->esz) {
+    case MO_32:
+    case MO_64:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        break;
+    default:
+        return false;
+    }
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    /* Zero extend sreg & hreg inputs to 64 bits now.  */
+    t_true = tcg_temp_new_i64();
+    t_false = tcg_temp_new_i64();
+    read_vec_element(s, t_true, a->rn, 0, a->esz);
+    read_vec_element(s, t_false, a->rm, 0, a->esz);
+
+    a64_test_cc(&c, a->cond);
+    tcg_gen_movcond_i64(c.cond, t_true, c.value, tcg_constant_i64(0),
+                        t_true, t_false);
+
+    /*
+     * Note that sregs & hregs write back zeros to the high bits,
+     * and we've already done the zero-extension.
+     */
+    write_fp_dreg(s, a->rd, t_true);
+    return true;
+}
+
 /*
  * Floating-point data-processing (3 source)
  */
@@ -7332,68 +7376,6 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating point conditional select
- *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5 4    0
- * +---+---+---+-----------+------+---+------+------+-----+------+------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 1 1 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+------+------+-----+------+------+
- */
-static void disas_fp_csel(DisasContext *s, uint32_t insn)
-{
-    unsigned int mos, type, rm, cond, rn, rd;
-    TCGv_i64 t_true, t_false;
-    DisasCompare64 c;
-    MemOp sz;
-
-    mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2);
-    rm = extract32(insn, 16, 5);
-    cond = extract32(insn, 12, 4);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-    if (mos) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        sz = MO_32;
-        break;
-    case 1:
-        sz = MO_64;
-        break;
-    case 3:
-        sz = MO_16;
-        if (dc_isar_feature(aa64_fp16, s)) {
-            break;
-        }
-        /* fallthru */
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    /* Zero extend sreg & hreg inputs to 64 bits now.  */
-    t_true = tcg_temp_new_i64();
-    t_false = tcg_temp_new_i64();
-    read_vec_element(s, t_true, rn, 0, sz);
-    read_vec_element(s, t_false, rm, 0, sz);
-
-    a64_test_cc(&c, cond);
-    tcg_gen_movcond_i64(c.cond, t_true, c.value, tcg_constant_i64(0),
-                        t_true, t_false);
-
-    /* Note that sregs & hregs write back zeros to the high bits,
-       and we've already done the zero-extension.  */
-    write_fp_dreg(s, rd, t_true);
-}
-
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8207,7 +8189,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
             break;
         case 3:
             /* Floating point conditional select */
-            disas_fp_csel(s, insn);
+            unallocated_encoding(s); /* in decodetree */
             break;
         case 0:
             switch (ctz32(extract32(insn, 12, 4))) {
-- 
2.34.1


