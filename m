Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34BEE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPdq-0007bt-I6; Wed, 11 Dec 2024 11:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPd1-0004qH-3G
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:59 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcz-0001Jp-8o
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:58 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-46761d91f7aso34838681cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934716; x=1734539516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LirZcHgHdp9tBVrM59CgIjq2zHMAEgw0F35SBHQ2JzQ=;
 b=B5A3UNG1lUGUOGenU2epv9TJKe8X7xdNqkX32mc039VbNhOFqsjmL11yufVVV4bLS6
 asWokPlCAKVSm1vnMsqtOvaiB0FkGdHO6JhHjZ5njnjs8VSfvo4BJZN8Tt6xfThuQ/C7
 HZZQJ904vK5oQ0DtRdr80prWzT09A9ANr89DA4JxeMBDSvYN1p/1Cq0FFIqRgfy8PTBm
 FJ4N6XjcphBcHWaYYSw+9jnYagf+qnZk/G7Fv4pmCXDj2LCNV1kRdXHe3C+L5Sdm+O1/
 1nGciBfk3OGnKtpCUH7hAWw5WQilOqkmB45ycfLpx0Umcaz3nrKttQ841Rmq/dnEqpUq
 HB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934716; x=1734539516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LirZcHgHdp9tBVrM59CgIjq2zHMAEgw0F35SBHQ2JzQ=;
 b=gTKsSHEwKuEBc4OAS7u7/m3pMm1poEKdBGgOBGKATe9bQnsePcbYLi5x2PLFq8/TxI
 jFWZfEL98r1IBAihXvBKyNFbLRYBkhvoZzo3CiFfa/x0x3j+RSEYaz3CChXXDwZ/7Tgn
 aRwJCL+7tEg+6Be+do3uCBmQMlelVt0sFI0+Olar1U+chJvjoeXeLgnI6axcbuKHMNN9
 ee/IRoqDlqv9mmd7csPV+6HTXACJDOGafp7klL5SIycFhvhBuZ14OglXmfprnIObvFDQ
 Xry6Nw7XNRRA9jRKG/+P8YGasBCdAhkk/67FBZ2eEOHp3WFMdrf3t5CQfxoLUStbjxDs
 eQTg==
X-Gm-Message-State: AOJu0YwLKwEzdJQw8Dts4W3t6srITwAbF9XrhBjKFUD7HTTq4xZ0lKlf
 WjJE1McNOp94Ic+pJ7n4TiRK+aIDh13l/6/HFUvNErYE92Zf9MIbNbWB/i8vFy14QIeKD41c2hj
 DXV4d6LHx
X-Gm-Gg: ASbGncv66Ewg6NtftLboS23YvhVVdizeC/3CmEqR/fpZeJElyUBhYNTV8rC91iso6vQ
 U+eRoQ2Cb1xyMMJT2ueP5vbkOn+NvOsccbJMicQTLHu7Nd3poPy39phTvobZF2Ar83sP89cPuXD
 Qz3ziAZ8kXm12o1t97QLnioU3BWP1LZBnbhKDIwbwwF6qarHiVVgHPI1e5ZsRO4lPw0MZDuoqP8
 L7LU9qINU96CwA1smj0i/e6M8pXIDDlgmPT8s5DitrGaPA+kv3WJ59LsLOPzA==
X-Google-Smtp-Source: AGHT+IFeefhyIGS8JmXhCqjiMmGirLwp9qVY5DkaeKk9HGdU7x0sfatpkElmJKTuKseUu1Zk5VLYsQ==
X-Received: by 2002:a05:622a:5c6:b0:466:8a95:d1cc with SMTP id
 d75a77b69052e-467893c3fa7mr41643811cf.47.1733934716208; 
 Wed, 11 Dec 2024 08:31:56 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 17/69] target/arm: Convert SETF8, SETF16 to decodetree
Date: Wed, 11 Dec 2024 10:29:44 -0600
Message-ID: <20241211163036.2297116-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 48 +++++-----------------------------
 target/arm/tcg/a64.decode      |  4 +++
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1af41e22eb..774689641d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8077,38 +8077,21 @@ static bool trans_RMIF(DisasContext *s, arg_RMIF *a)
     return true;
 }
 
-/*
- * Evaluate into flags
- *  31 30 29                21        15   14        10      5  4      0
- * +--+--+--+-----------------+---------+----+---------+------+--+------+
- * |sf|op| S| 1 1 0 1 0 0 0 0 | opcode2 | sz | 0 0 1 0 |  Rn  |o3| mask |
- * +--+--+--+-----------------+---------+----+---------+------+--+------+
- */
-static void disas_evaluate_into_flags(DisasContext *s, uint32_t insn)
+static bool do_setf(DisasContext *s, int rn, int shift)
 {
-    int o3_mask = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int o2 = extract32(insn, 15, 6);
-    int sz = extract32(insn, 14, 1);
-    int sf_op_s = extract32(insn, 29, 3);
-    TCGv_i32 tmp;
-    int shift;
+    TCGv_i32 tmp = tcg_temp_new_i32();
 
-    if (sf_op_s != 1 || o2 != 0 || o3_mask != 0xd ||
-        !dc_isar_feature(aa64_condm_4, s)) {
-        unallocated_encoding(s);
-        return;
-    }
-    shift = sz ? 16 : 24;  /* SETF16 or SETF8 */
-
-    tmp = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(tmp, cpu_reg(s, rn));
     tcg_gen_shli_i32(cpu_NF, tmp, shift);
     tcg_gen_shli_i32(cpu_VF, tmp, shift - 1);
     tcg_gen_mov_i32(cpu_ZF, cpu_NF);
     tcg_gen_xor_i32(cpu_VF, cpu_VF, cpu_NF);
+    return true;
 }
 
+TRANS_FEAT(SETF8, aa64_condm_4, do_setf, a->rn, 24)
+TRANS_FEAT(SETF16, aa64_condm_4, do_setf, a->rn, 16)
+
 /* Conditional compare (immediate / register)
  *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
  * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
@@ -8277,30 +8260,12 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 {
     int op1 = extract32(insn, 28, 1);
     int op2 = extract32(insn, 21, 4);
-    int op3 = extract32(insn, 10, 6);
 
     if (!op1) {
         goto do_unallocated;
     }
 
     switch (op2) {
-    case 0x0:
-        switch (op3) {
-        case 0x02: /* Evaluate into flags */
-        case 0x12:
-        case 0x22:
-        case 0x32:
-            disas_evaluate_into_flags(s, insn);
-            break;
-
-        default:
-        case 0x00: /* Add/subtract (with carry) */
-        case 0x01: /* Rotate right into flags */
-        case 0x21:
-            goto do_unallocated;
-        }
-        break;
-
     case 0x2: /* Conditional compare */
         disas_cc(s, insn); /* both imm and reg forms */
         break;
@@ -8311,6 +8276,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
 
     default:
     do_unallocated:
+    case 0x0:
     case 0x6: /* Data-processing */
     case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 454494742e..ae2c6831d7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -757,6 +757,10 @@ SBCS            . 11 11010000 ..... 000000 ..... .....  @rrr_sf
 RMIF            1 01 11010000 imm:6 00001 rn:5 0 mask:4
 
 # Evaluate into flags
+
+SETF8           0 01 11010000 00000 000010 rn:5 01101
+SETF16          0 01 11010000 00000 010010 rn:5 01101
+
 # Conditional compare (regster)
 # Conditional compare (immediate)
 # Conditional select
-- 
2.43.0


