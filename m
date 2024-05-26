Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5C4C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmQ-0000og-1u; Sun, 26 May 2024 15:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm7-0000Ef-MR
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:25 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm4-0007kv-2S
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:21 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so18161525ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752599; x=1717357399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gw9CRkELC5tp9TSLlcB1aPlGOCJptfKvVgjqBFHj+X0=;
 b=DyMvLmVHyRwiGr3zzfjsJgAauPWmHjGcgnKpI88Nmh3V6Hd+c2tUnRTirfAtazFohf
 GKqw5eHZJ7Y2P4gIL4exdf+tPuaFl/wb+zYeUW+xv2zlKbhvEoiZ8ynMX8E/df4l3jRd
 Fswe8tKGWJjcgct5bHoP1qa7jw4InvpCXKemFQaJkCl/RXDySFSuVLwO3keWGeSgA8MS
 tsxs/3cSq9PSifEUDS32g0KG8fpy/jyAe+l/5mtImguwgz8Lpz9xGidcuW9i2A9ygNEm
 TLSPmkk8lKbojdpiXpzk2lcnzySVZuLnlf2SACRRYeFn1M1leKKyNw6iMW42FMQ+zxr+
 R3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752599; x=1717357399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gw9CRkELC5tp9TSLlcB1aPlGOCJptfKvVgjqBFHj+X0=;
 b=hRvTQ2l6rEeoXd6eFUmsX3JCD7beHeNCpbGuzlO8wWwhwYf5CgmmjhSeyg8cBovQhE
 3WuWG3sdWM4iLcUlWl6HPJ3fyKOal9hOZLtva+mOh67HkESUBvht8yFiMO+sv/+1Uklc
 7RRuWl4uqdaQ80jcXFXMNBfd0Q12zjkCypebzTUxIWHrnWDxOiIskn7sYbrcKZBAtK1K
 GQSezeklGfD55OpEuxXQjT8pkPa5prYTbi6QX9LXe6CLI0xZR71R3xPEs+tOcXTuiTxg
 j/bpwxhR81whHvgU2cu4FxISd5wNcKML/81+nK+tH8FTvaUsEUWD+pOqS6oJANoXo6rz
 gVXQ==
X-Gm-Message-State: AOJu0YyrsZlIBx3RFrCJf1DGoLX14CFCvfueObdqt15TUIWWEfwrkaFV
 EnemAhLrGFoTsYmC0//x5JcD3ET6vvWsGGFQRFRfLhz5E1g3GUDYULGRJBOR5xYVLJQHs+8h9WD
 w
X-Google-Smtp-Source: AGHT+IEUnKuVrEWCtCN9CgVT+fwfMjI2jncHAtZUQ+hJpqOfym4cbB0lvUPIkXf9Im/G/PDy+xaMKQ==
X-Received: by 2002:a17:902:e743:b0:1f4:5d87:ffad with SMTP id
 d9443c01a7336-1f45d880565mr72336455ad.15.1716752598954; 
 Sun, 26 May 2024 12:43:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 30/37] target/sparc: Implement FALIGNDATAi
Date: Sun, 26 May 2024 12:42:47 -0700
Message-Id: <20240526194254.459395-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5d85e124ed..0913fe7a86 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -446,6 +446,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @d_d_d
     FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @d_r2
+    FALIGNDATAi 10 ..... 110110 ..... 0 0100 1001 .....    @d_r_d
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @d_d1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 88e6da4f8b..5b6a12c81e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -809,7 +809,8 @@ static void gen_op_fpsubs32s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
     tcg_gen_movcond_i32(TCG_COND_LT, d, v, z, t, r);
 }
 
-static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+static void gen_op_faligndata_i(TCGv_i64 dst, TCGv_i64 s1,
+                                TCGv_i64 s2, TCGv gsr)
 {
 #ifdef TARGET_SPARC64
     TCGv t1, t2, shift;
@@ -818,7 +819,7 @@ static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
     t2 = tcg_temp_new();
     shift = tcg_temp_new();
 
-    tcg_gen_andi_tl(shift, cpu_gsr, 7);
+    tcg_gen_andi_tl(shift, gsr, 7);
     tcg_gen_shli_tl(shift, shift, 3);
     tcg_gen_shl_tl(t1, s1, shift);
 
@@ -836,6 +837,11 @@ static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
 #endif
 }
 
+static void gen_op_faligndata_g(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+{
+    gen_op_faligndata_i(dst, s1, s2, cpu_gsr);
+}
+
 static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 {
 #ifdef TARGET_SPARC64
@@ -5064,7 +5070,7 @@ TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
 TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
-TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
+TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata_g)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
 TRANS(FHADDd, VIS3, do_ddd, a, gen_op_fhaddd)
@@ -5225,6 +5231,27 @@ TRANS(FNMADDd, FMAF, do_dddd, a, gen_op_fnmaddd)
 TRANS(FPMADDX, IMA, do_dddd, a, gen_op_fpmaddx)
 TRANS(FPMADDXHI, IMA, do_dddd, a, gen_op_fpmaddxhi)
 
+static bool trans_FALIGNDATAi(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst, src1, src2;
+    TCGv src3;
+
+    if (!avail_VIS4(dc)) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst  = tcg_temp_new_i64();
+    src1 = gen_load_fpr_D(dc, a->rd);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    src3 = gen_load_gpr(dc, a->rs1);
+    gen_op_faligndata_i(dst, src1, src2, src3);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
 {
-- 
2.34.1


