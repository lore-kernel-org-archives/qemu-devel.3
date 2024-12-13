Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39BFE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xb-0007Rp-Vz; Fri, 13 Dec 2024 12:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X3-0006zD-IP
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:57 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X1-0001Uq-Jt
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:53 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so1291127f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111169; x=1734715969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BwDq0W+meAt5kc5H/cSi+hBv6OXqnPA2qE21LgjmUFw=;
 b=CunIteSfOVEugnEiGZ8c3fzBVUwit4aP+gbzuXR2z1MnmvDTfi2oKYfM4cPcBgTvW/
 vHygm1mwhMSrSrgkzb4nMc7DjYYaMpDTwHVOr36nWkR1q43iPMKa3OaAJ4Gm7WkUyGa0
 FZXEk5bsgZ/hGU9bIXhucCrbhXrIfnLFCfOVwK8Da54uQ4kotdrNOT7D3pdNLg9RhlMe
 g+Az1L/Uv/eRix3y7aW1A86s3B/bhrlmktEHmusHI7ZVHGpdawMuVEwwF/pDqHxJBjqN
 9NHaiffgerkX2E8srvGGedXpsHZVM8pSXB0u9lRC9u02qJh1Crx8+sKbmDWlBTWZugiy
 mfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111169; x=1734715969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BwDq0W+meAt5kc5H/cSi+hBv6OXqnPA2qE21LgjmUFw=;
 b=vuBO7+5mGBThNTPR4gAm19+DaPGb7jInk3ZRxIE/jAGY0HC/KlUgNtMOcQbLtCjwDo
 m1yvDttF4+E6Mt3FLEWyFQ4u36mB+zTbAq/uqFUPgK7YTNHN+D8mJkieiqyu5LAwIIOv
 YlxYHqMjUt42l9j96dFiF6FsXok2je7xCYvbfo+wKqsuunAA4/s8fRVuGmVqfYqA+DVs
 QlhtHfLZmLi4QTTASL/OsMLhszBIL5fJHOabZrXFyeVLkofooEP88bhTSw2q4CaS9yOR
 SAM/Tkeu0A/0SREV6Ym7rC1aWuYWsTrU/qXatG9h41hJkJPHgHagOxQ3aJ91za/WN1FO
 QW3A==
X-Gm-Message-State: AOJu0YycqtPu6OWjiLefrRODeWU97DtcZx7BHF0IdOYJWm+w3V6NKNDa
 7u7LKBjslW3phsQnUmua2NN6zryQr7xLDtDx26j3/CVrtGrBfbeWztwxQACs/ugyfLA5DkQk2XF
 Q
X-Gm-Gg: ASbGncuXTKXa/6dK7IFxVq8TG3skMfZN6u8ARt7EgGPsWUw38awofXbKBHeRhmUr62S
 l/lB8rYAqP8OmAqUDDNMVFQtaZrThR7UE6priQAWF2yqHxr3cVArt3SE5othNPu1VQ6GjO6OxZ+
 +lfOn1xEu6hAqcXdB+mLM7xd9DfmkasO6lmwcFCjYRrl/cBY2n5+gnlrdk+GEZQ74OZT0/R93di
 SXViAwx8rZfRHPzc3nJBh8nTIAf0NIdQxCqNVX9nrqsHCQFpD4zxAhN7lYF5A==
X-Google-Smtp-Source: AGHT+IEMlyRz09dgA9tqYxF00aJCksB00lM6h3TTEsiqP/1G7iY4CMUBapIqHUgarEER3RUqdXf/pQ==
X-Received: by 2002:a5d:64af:0:b0:385:fb2c:6034 with SMTP id
 ffacd0b85a97d-3888e0b9e49mr2956210f8f.47.1734111168627; 
 Fri, 13 Dec 2024 09:32:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/85] target/arm: Convert RMIF to decodetree
Date: Fri, 13 Dec 2024 17:31:20 +0000
Message-Id: <20241213173229.3308926-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 32 +++++++++-----------------------
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7a40ca455e4..454494742e6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -753,6 +753,9 @@ SBC             . 10 11010000 ..... 000000 ..... .....  @rrr_sf
 SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
 
 # Rotate right into flags
+
+RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
+
 # Evaluate into flags
 # Conditional compare (regster)
 # Conditional compare (immediate)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d7747fcf575..1af41e22eb5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8045,30 +8045,18 @@ TRANS(SBC, do_adc_sbc, a, true, false)
 TRANS(ADCS, do_adc_sbc, a, false, true)
 TRANS(SBCS, do_adc_sbc, a, true, true)
 
-/*
- * Rotate right into flags
- *  31 30 29                21       15          10      5  4      0
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- * |sf|op| S| 1 1 0 1 0 0 0 0 |  imm6  | 0 0 0 0 1 |  Rn  |o2| mask |
- * +--+--+--+-----------------+--------+-----------+------+--+------+
- */
-static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
+static bool trans_RMIF(DisasContext *s, arg_RMIF *a)
 {
-    int mask = extract32(insn, 0, 4);
-    int o2 = extract32(insn, 4, 1);
-    int rn = extract32(insn, 5, 5);
-    int imm6 = extract32(insn, 15, 6);
-    int sf_op_s = extract32(insn, 29, 3);
+    int mask = a->mask;
     TCGv_i64 tcg_rn;
     TCGv_i32 nzcv;
 
-    if (sf_op_s != 5 || o2 != 0 || !dc_isar_feature(aa64_condm_4, s)) {
-        unallocated_encoding(s);
-        return;
+    if (!dc_isar_feature(aa64_condm_4, s)) {
+        return false;
     }
 
-    tcg_rn = read_cpu_reg(s, rn, 1);
-    tcg_gen_rotri_i64(tcg_rn, tcg_rn, imm6);
+    tcg_rn = read_cpu_reg(s, a->rn, 1);
+    tcg_gen_rotri_i64(tcg_rn, tcg_rn, a->imm);
 
     nzcv = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(nzcv, tcg_rn);
@@ -8086,6 +8074,7 @@ static void disas_rotate_right_into_flags(DisasContext *s, uint32_t insn)
     if (mask & 1) { /* V */
         tcg_gen_shli_i32(cpu_VF, nzcv, 31 - 0);
     }
+    return true;
 }
 
 /*
@@ -8297,11 +8286,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     switch (op2) {
     case 0x0:
         switch (op3) {
-        case 0x01: /* Rotate right into flags */
-        case 0x21:
-            disas_rotate_right_into_flags(s, insn);
-            break;
-
         case 0x02: /* Evaluate into flags */
         case 0x12:
         case 0x22:
@@ -8311,6 +8295,8 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 
         default:
         case 0x00: /* Add/subtract (with carry) */
+        case 0x01: /* Rotate right into flags */
+        case 0x21:
             goto do_unallocated;
         }
         break;
-- 
2.34.1


