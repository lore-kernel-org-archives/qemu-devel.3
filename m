Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDADD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWo-0001K9-1e; Sun, 01 Dec 2024 10:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWj-0001FS-0x
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:25 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWh-00048g-4Q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:24 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71d41932d32so1332399a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065581; x=1733670381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzZUTxewRXWA3oangdGKG33zRvvNhBpt0lFMk8HOMsc=;
 b=uBh9JCUIOxReeCz61SxXXZzpKKNTauEk6QZBaeaSw2IT41BQAHyP1zfDGu7uaazqeI
 7k2Q4r9L9+ZQJUirdH3A0ECwmSBoIQuGrZPdwqEkfAEGlkPv/FI/udjGldG6D+wtnMSb
 1Krf9Pvmx13nQz6MaPnKyc4GKs6M5YK7QvzN4jsg1n2EON9AYWyLtQsveG5nm/aNt8Bl
 NVONrKAFfVZw3i+01oL2Q2gmMIH0FQ1NQHcOOAgBbXTffJybHblL6nAbQKSsNRK5oOVs
 zIH+zDd+/IXA59tSrx7lqibxnOl9lyqA7uVM3GYgpEo23yoUp2DoBT0gnV0WHkbsTuRf
 Q0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065581; x=1733670381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzZUTxewRXWA3oangdGKG33zRvvNhBpt0lFMk8HOMsc=;
 b=h9dKan+Xdjs9Y/fc+H5Gj9HHeuXJLndQI3n8vsAFw21IWy8TAQD1WLfYf1NvAcpzNZ
 x8gJUtn7Z7xWM2dr94CLBvWrEXSaE/JecyggAFiwFN5aXWaypFDzkLclwzeZ24fvIOrg
 wu4uCHDspfPbZK5DrmEnLYnJsoImykADGiIdAEPiggpsOa4mUmiBQ3MKOEDguwJzubKS
 S3n6Zk0s2q/Y0efXFtA8s346IkQ1gaU693PRsOjXMKVCVbhO5TSZOkGdfe81Dyd7reps
 ohu1GKUhM9Z3UAryLLsMW4QDrugzUYMjrs7kxw+fDPh6tK5FFjp1wogV/Q2EQ3ywAXUJ
 yZfw==
X-Gm-Message-State: AOJu0YxTYPgflPb5xOBratDZ+kFgQR5GwUmXRcdaAciH747rylnRhyGZ
 ROAxI7/Qa+cZOcQrClR90xbC62dOVWm63Hf9s59eJVS2sPU1KhKtW+E0XjxtH3mEyEX9TOYo3rs
 gmzI=
X-Gm-Gg: ASbGnctY2vDlSY2unMqJnwSJD7/xNI1/L3Uv7WW2XKBiZeQJzazjmfIZxUvOXP8CYPY
 MfNBthVOjr3KNJwBrAFBvSz+r52mrv1RKyAplxR+YDz4+eCfL5gAc2i9TGDm/sYJnCrK7WfIKuL
 xdwLgWHB8CgaU814haRoqwLJ5G5SQVs1aU3Poery/kziMvnXascJIcSOvZ+gJzpzMlA+PvcGf0R
 ajc/8A4g8dmrBXPVgObL/uywxdboTyjDC6MExN3WMQDrgB+gmGqIDnJTgRQWyWI1+yXawLUUSo8
 xPwg7L0npg5OEYa8j8Mz/HOt1nA3m2vTAmVe
X-Google-Smtp-Source: AGHT+IHX5IFcLRH9NdPaSRtS64nZ167WpfTKK09wk8cnbDnzOxnBY/jYBthc+2EyaM2pB8mEyUt2bw==
X-Received: by 2002:a05:6830:490c:b0:71d:6314:40dd with SMTP id
 46e09a7af769-71d65cb2662mr16405842a34.14.1733065581619; 
 Sun, 01 Dec 2024 07:06:21 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/67] target/arm: Convert XPAC[ID] to decodetree
Date: Sun,  1 Dec 2024 09:05:09 -0600
Message-ID: <20241201150607.12812-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Remove disas_data_proc_1src, as these were the last insns
decoded by that function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 99 +++++-----------------------------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 16 insertions(+), 86 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 852545dfcc..d92fe68299 100644
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
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9083ac4ac3..0e04ab6ce4 100644
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
-- 
2.43.0


