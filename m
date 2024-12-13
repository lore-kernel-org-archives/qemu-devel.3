Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA60CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xb-0007Qm-0K; Fri, 13 Dec 2024 12:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X0-0006xi-T5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:52 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wx-0001Tb-Ky
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:49 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so2402535e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111163; x=1734715963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0SEh1YhqeT/Prmk+UdNRkslDKNsy4cS4QQDVYqwULJc=;
 b=nP/qcvOl0ggPZeg+IyJkhnWECwnuH7TGmzCqmRPVQWIGNsrqXoC+tOCcJ6MhrHJNvh
 HitsrATKrjnoVSQAuWlqPq5dkV46lNoqtFctDXMvyZ1bYU10sszkUsDfvnxbrBI5Hbpb
 JsmMRxgC6lNH6atrZDO+DYW37xge+qEWIQvHVQRmMb7ReN7LCTVcFrcdX1XFtLrUQTfE
 oK1/zrdiL5qMSq0xMw7plD7+OcSUYUsxP5TT2JLbJFpfxd4oof8aQsHFURUc40VGGv79
 m4W3RK13EEPvhFL10tjHVG80ayxBtf/zvJGtBXW1kbqmb44LkNo3niJbjsaV+JctFbug
 isdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111163; x=1734715963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SEh1YhqeT/Prmk+UdNRkslDKNsy4cS4QQDVYqwULJc=;
 b=QMfpKXIVptQdG3kTDLqJSNSvqYmnTByYKzwDkl7H0+uiJ7S1oq6Ma5dIhBYZawAwe3
 tnO1K+du0xE5BMfKKAnshRVJj4mwN99zmWExXrBEKn/14BKy1Kgs2vW7uMspewXDqLkt
 OY6xO0jwxujFPGZUphICXz53IQToCNxCuWSd4LtUQTHYMosucF8cQRFSaCJGaSno+pwu
 0UJhLu8PpDW1dnd5EHIKejo9cHwVxeZ/itjs2RuWUfKxfPPP4E6wC3PUkSza2k2aPKDs
 Mr0hjXaY5hOrKUE1hXYK/dizwXo39RimcPNU+/pJ6igHdJHTRFp1mlk7VIkBefExeJ3o
 Hzwg==
X-Gm-Message-State: AOJu0YyCK5CB8xTUMWC+hlBzYkumTBg+GdU8gLwgiW2KnNOVWp3mB4gH
 /0bKABCbFYoYdvPB3afhaKUF34zKVqZyBRrjjps3WEpJGYr7qkaUI2ejRNur8dgi/ZKbzxX+mwh
 5
X-Gm-Gg: ASbGncuo2MaHjhb3fvTIBEScmnjI9ChE/l2ku8644QeLUPSxc/hHTi4RsZz1nSnWUQb
 UPXigsnzF/pzqBHZC9Itf7TmUTyEMPISG3kmGuGYp8GCvuuE+Gz6NgRO9rYc1Y5T8YRCIqsQjqQ
 wyzxfNdUTSKKBRt3B7/u7UcuXJ08zdXa74DKaUJ2qEhAgsSduSt1oQGE2kNJXKRFO19U9Qi8m6b
 uDT654NEQWLjeEly/z+Sq9KTTDA601iX0bMvCP8TQNaKLu6uPpgglZJMBaKDw==
X-Google-Smtp-Source: AGHT+IFxPJ7nmy6q0yHskMruF5kA3eO7IXfSeWZwmeSiK+b3+v2wRaucb+1AAcekMhFQbg1AefzlMA==
X-Received: by 2002:a5d:6801:0:b0:388:c75c:e839 with SMTP id
 ffacd0b85a97d-388c75ce895mr527468f8f.42.1734111162737; 
 Fri, 13 Dec 2024 09:32:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/85] target/arm: Convert XPAC[ID] to decodetree
Date: Fri, 13 Dec 2024 17:31:14 +0000
Message-Id: <20241213173229.3308926-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Remove disas_data_proc_1src, as these were the last insns
decoded by that function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 ++
 target/arm/tcg/translate-a64.c | 99 +++++-----------------------------
 2 files changed, 16 insertions(+), 86 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9083ac4ac30..0e04ab6ce45 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -712,6 +712,9 @@ AUTIB           1 10 11010110 00001 00.101 ..... .....  @pacaut
 AUTDA           1 10 11010110 00001 00.110 ..... .....  @pacaut
 AUTDB           1 10 11010110 00001 00.111 ..... .....  @pacaut
 
+XPACI           1 10 11010110 00001 010000 11111 rd:5
+XPACD           1 10 11010110 00001 010001 11111 rd:5
+
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 852545dfcc2..d92fe682998 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7793,6 +7793,18 @@ TRANS_FEAT(AUTIB, aa64_pauth, gen_pacaut, a, gen_helper_autib)
 TRANS_FEAT(AUTDA, aa64_pauth, gen_pacaut, a, gen_helper_autda)
 TRANS_FEAT(AUTDB, aa64_pauth, gen_pacaut, a, gen_helper_autdb)
 
+static bool do_xpac(DisasContext *s, int rd, NeonGenOne64OpEnvFn *fn)
+{
+    if (s->pauth_active) {
+        TCGv_i64 tcg_rd = cpu_reg(s, rd);
+        fn(tcg_rd, tcg_env, tcg_rd);
+    }
+    return true;
+}
+
+TRANS_FEAT(XPACI, aa64_pauth, do_xpac, a->rd, gen_helper_xpaci)
+TRANS_FEAT(XPACD, aa64_pauth, do_xpac, a->rd, gen_helper_xpacd)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8377,84 +8389,6 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Data-processing (1 source)
- *   31  30  29  28             21 20     16 15    10 9    5 4    0
- * +----+---+---+-----------------+---------+--------+------+------+
- * | sf | 1 | S | 1 1 0 1 0 1 1 0 | opcode2 | opcode |  Rn  |  Rd  |
- * +----+---+---+-----------------+---------+--------+------+------+
- */
-static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
-{
-    unsigned int sf, opcode, opcode2, rn, rd;
-    TCGv_i64 tcg_rd;
-
-    if (extract32(insn, 29, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    sf = extract32(insn, 31, 1);
-    opcode = extract32(insn, 10, 6);
-    opcode2 = extract32(insn, 16, 5);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-#define MAP(SF, O2, O1) ((SF) | (O1 << 1) | (O2 << 7))
-
-    switch (MAP(sf, opcode2, opcode)) {
-    case MAP(1, 0x01, 0x10): /* XPACI */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_xpaci(tcg_rd, tcg_env, tcg_rd);
-        }
-        break;
-    case MAP(1, 0x01, 0x11): /* XPACD */
-        if (!dc_isar_feature(aa64_pauth, s) || rn != 31) {
-            goto do_unallocated;
-        } else if (s->pauth_active) {
-            tcg_rd = cpu_reg(s, rd);
-            gen_helper_xpacd(tcg_rd, tcg_env, tcg_rd);
-        }
-        break;
-    default:
-    do_unallocated:
-    case MAP(0, 0x00, 0x00): /* RBIT */
-    case MAP(1, 0x00, 0x00):
-    case MAP(0, 0x00, 0x01): /* REV16 */
-    case MAP(1, 0x00, 0x01):
-    case MAP(0, 0x00, 0x02): /* REV/REV32 */
-    case MAP(1, 0x00, 0x02):
-    case MAP(1, 0x00, 0x03): /* REV64 */
-    case MAP(0, 0x00, 0x04): /* CLZ */
-    case MAP(1, 0x00, 0x04):
-    case MAP(0, 0x00, 0x05): /* CLS */
-    case MAP(1, 0x00, 0x05):
-    case MAP(1, 0x01, 0x00): /* PACIA */
-    case MAP(1, 0x01, 0x01): /* PACIB */
-    case MAP(1, 0x01, 0x02): /* PACDA */
-    case MAP(1, 0x01, 0x03): /* PACDB */
-    case MAP(1, 0x01, 0x04): /* AUTIA */
-    case MAP(1, 0x01, 0x05): /* AUTIB */
-    case MAP(1, 0x01, 0x06): /* AUTDA */
-    case MAP(1, 0x01, 0x07): /* AUTDB */
-    case MAP(1, 0x01, 0x08): /* PACIZA */
-    case MAP(1, 0x01, 0x09): /* PACIZB */
-    case MAP(1, 0x01, 0x0a): /* PACDZA */
-    case MAP(1, 0x01, 0x0b): /* PACDZB */
-    case MAP(1, 0x01, 0x0c): /* AUTIZA */
-    case MAP(1, 0x01, 0x0d): /* AUTIZB */
-    case MAP(1, 0x01, 0x0e): /* AUTDZA */
-    case MAP(1, 0x01, 0x0f): /* AUTDZB */
-        unallocated_encoding(s);
-        break;
-    }
-
-#undef MAP
-}
-
-
 /*
  * Data processing - register
  *  31  30 29  28      25    21  20  16      10         0
@@ -8464,7 +8398,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
  */
 static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 {
-    int op0 = extract32(insn, 30, 1);
     int op1 = extract32(insn, 28, 1);
     int op2 = extract32(insn, 21, 4);
     int op3 = extract32(insn, 10, 6);
@@ -8517,19 +8450,13 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
         disas_cond_select(s, insn);
         break;
 
-    case 0x6: /* Data-processing */
-        if (op0) {    /* (1 source) */
-            disas_data_proc_1src(s, insn);
-        } else {      /* (2 source) */
-            goto do_unallocated;
-        }
-        break;
     case 0x8 ... 0xf: /* (3 source) */
         disas_data_proc_3src(s, insn);
         break;
 
     default:
     do_unallocated:
+    case 0x6: /* Data-processing */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


