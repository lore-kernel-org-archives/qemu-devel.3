Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BCDE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPda-0006WN-Aa; Wed, 11 Dec 2024 11:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPd6-000530-UO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:05 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPd5-0001LK-25
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:04 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4678664e22fso13282391cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934722; x=1734539522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qB2IZAS09IccrdqxBacklaTzmXPtI54chcpe7/zCzag=;
 b=q9VnoxaCKTZSGYGgNHbBmEfW9i3Rvu/P3tiWhKmmaVCzTn1uRYHf7hkccF4clrdOyy
 uaXo4fcyinJqGDb1OJ7eMFs0y19XwCyoCaoSknxnzRPeMmVyO0ZWHf8kzu8TjrmbGFGS
 FherlWXlp6o1BxhLUMZ5rB2CiqPo7/pIHPnZuEDaf1SFpCdMwiKl8dPA8johTNigTckD
 r7P+4A1TmZw1QrczJdgwqjNQGJJP/uOd9Ok9UcTqkIz4j8DrEoFDaK8mDFFoYhCecc60
 r/99S4w/8fuKFbnHJfc+h68auLFZqQSzdUeqn0ysxXIsPkwmkQxeXLTqLalW7lSk3NlP
 En8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934722; x=1734539522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qB2IZAS09IccrdqxBacklaTzmXPtI54chcpe7/zCzag=;
 b=YP8f/e7V1U5TnCBI3pd8iX9lYykXtlgfamxc/b9c9KHunWoI6jIe4HJlYxH1YKtLmb
 27MLc2nZME3koqkUuIDv+3H8vULAMcrWqDMechtFEOnEl492QDG6CKFV9n6FXv/QSoCm
 ddUGZXf0iXn8ZPv5vVwPCq6n7CKlwXTCN+uoMT8R+6dBC6vnLYrm3spS/AF1bYFjz+3a
 akc3S0IOkF73Ggae6HWaQMhNJDloZggOjnJrwV8a2agsc1ueaILN+4TZ5JGI5PCYllR0
 JaHG+gNbza8DK+wgFdbNfvH4QItH/fjqBYAPWTqsik/XcRohfVznqhImsQQB9pZpkDgI
 kBqQ==
X-Gm-Message-State: AOJu0YzcWQK0OYVtDCCEZlTHqxfsst6mNL53HgcB++hw37v95kjQzLGw
 Xcrgn4krSjmNTcOU8WQKUYfKx1bzG7TcMFomntE6r7TcPCP5VzIICFqf5w9ie/y1lBHjg0pEzap
 DWlLY2LFH
X-Gm-Gg: ASbGnctzpzgjfh1HolMCdhCIemH2aLuaoePSDcgTIEEHXHmhK+0vwJ8VFGNv+3tLbvY
 o9wbxaT/RDl3hLOU8PYl8gDYXuwZ0oMRSV7QTxC24zf52cp9YI+JMF6N0YGTd1KHF8DeUtMawE9
 vdEGb8WheVM1oofHAt2Z86XarriI7Wp0qfLwQU0ax245N++vzBw1zaazPe/YuISW3zQLZuitCS9
 ApcNijRarAD1uh0taw8YIbro4QmEg74T/6N2xG3mie5D2uNlIX4aSk6Zk1Pbw==
X-Google-Smtp-Source: AGHT+IEBCdPG9+UN0lwgj80Qf92dHhSj+yrkm5Lj+e2y+J51kYzUPd1mGdrIT9uJVoejghxkkwoprA==
X-Received: by 2002:ac8:5947:0:b0:466:9197:b503 with SMTP id
 d75a77b69052e-46789379413mr58417541cf.46.1733934720543; 
 Wed, 11 Dec 2024 08:32:00 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 19/69] target/arm: Convert disas_cond_select to decodetree
Date: Wed, 11 Dec 2024 10:29:46 -0600
Message-ID: <20241211163036.2297116-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

This includes CSEL, CSINC, CSINV, CSNEG.  Remove disas_data_proc_reg,
as these were the last insns decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 84 ++++++----------------------------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 17 insertions(+), 70 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 56a445a3c2..9c6365f5ef 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8171,39 +8171,17 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     return true;
 }
 
-/* Conditional select
- *   31   30  29  28             21 20  16 15  12 11 10 9    5 4    0
- * +----+----+---+-----------------+------+------+-----+------+------+
- * | sf | op | S | 1 1 0 1 0 1 0 0 |  Rm  | cond | op2 |  Rn  |  Rd  |
- * +----+----+---+-----------------+------+------+-----+------+------+
- */
-static void disas_cond_select(DisasContext *s, uint32_t insn)
+static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
 {
-    unsigned int sf, else_inv, rm, cond, else_inc, rn, rd;
-    TCGv_i64 tcg_rd, zero;
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 zero = tcg_constant_i64(0);
     DisasCompare64 c;
 
-    if (extract32(insn, 29, 1) || extract32(insn, 11, 1)) {
-        /* S == 1 or op2<1> == 1 */
-        unallocated_encoding(s);
-        return;
-    }
-    sf = extract32(insn, 31, 1);
-    else_inv = extract32(insn, 30, 1);
-    rm = extract32(insn, 16, 5);
-    cond = extract32(insn, 12, 4);
-    else_inc = extract32(insn, 10, 1);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
+    a64_test_cc(&c, a->cond);
 
-    tcg_rd = cpu_reg(s, rd);
-
-    a64_test_cc(&c, cond);
-    zero = tcg_constant_i64(0);
-
-    if (rn == 31 && rm == 31 && (else_inc ^ else_inv)) {
+    if (a->rn == 31 && a->rm == 31 && (a->else_inc ^ a->else_inv)) {
         /* CSET & CSETM.  */
-        if (else_inv) {
+        if (a->else_inv) {
             tcg_gen_negsetcond_i64(tcg_invert_cond(c.cond),
                                    tcg_rd, c.value, zero);
         } else {
@@ -8211,53 +8189,23 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
                                 tcg_rd, c.value, zero);
         }
     } else {
-        TCGv_i64 t_true = cpu_reg(s, rn);
-        TCGv_i64 t_false = read_cpu_reg(s, rm, 1);
-        if (else_inv && else_inc) {
+        TCGv_i64 t_true = cpu_reg(s, a->rn);
+        TCGv_i64 t_false = read_cpu_reg(s, a->rm, 1);
+
+        if (a->else_inv && a->else_inc) {
             tcg_gen_neg_i64(t_false, t_false);
-        } else if (else_inv) {
+        } else if (a->else_inv) {
             tcg_gen_not_i64(t_false, t_false);
-        } else if (else_inc) {
+        } else if (a->else_inc) {
             tcg_gen_addi_i64(t_false, t_false, 1);
         }
         tcg_gen_movcond_i64(c.cond, tcg_rd, c.value, zero, t_true, t_false);
     }
 
-    if (!sf) {
+    if (!a->sf) {
         tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
-}
-
-/*
- * Data processing - register
- *  31  30 29  28      25    21  20  16      10         0
- * +--+---+--+---+-------+-----+-------+-------+---------+
- * |  |op0|  |op1| 1 0 1 | op2 |       |  op3  |         |
- * +--+---+--+---+-------+-----+-------+-------+---------+
- */
-static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
-{
-    int op1 = extract32(insn, 28, 1);
-    int op2 = extract32(insn, 21, 4);
-
-    if (!op1) {
-        goto do_unallocated;
-    }
-
-    switch (op2) {
-    case 0x4: /* Conditional select */
-        disas_cond_select(s, insn);
-        break;
-
-    default:
-    do_unallocated:
-    case 0x0:
-    case 0x2: /* Conditional compare */
-    case 0x6: /* Data-processing */
-    case 0x8 ... 0xf: /* (3 source) */
-        unallocated_encoding(s);
-        break;
-    }
+    return true;
 }
 
 static void handle_fp_compare(DisasContext *s, int size,
@@ -11212,10 +11160,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
 static void disas_a64_legacy(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 4)) {
-    case 0x5:
-    case 0xd:      /* Data processing - register */
-        disas_data_proc_reg(s, insn);
-        break;
     case 0x7:
     case 0xf:      /* Data processing - SIMD and floating point */
         disas_data_proc_simd_fp(s, insn);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a9d7d57199..5670846768 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -766,6 +766,9 @@ SETF16          0 01 11010000 00000 010010 rn:5 01101
 CCMP            sf:1 op:1 1 11010010 y:5 cond:4 imm:1 0 rn:5 0 nzcv:4
 
 # Conditional select
+
+CSEL            sf:1 else_inv:1 011010100 rm:5 cond:4 0 else_inc:1 rn:5 rd:5
+
 # Data Processing (3-source)
 
 &rrrr           rd rn rm ra
-- 
2.43.0


