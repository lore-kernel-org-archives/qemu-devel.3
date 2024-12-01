Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD625D49775
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlX4-0001Y8-Id; Sun, 01 Dec 2024 10:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlX1-0001Vi-VG
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:44 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlX0-0004Jv-5A
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:43 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ea369fdb0cso1893956b6e.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065601; x=1733670401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vZ+D4zf1PBhpfrDUbIquFaEGgs8hQN808U2e75k8ik=;
 b=qD95fmXZQTtaV1B+A4Jw9npw4uD+8lIV3gehigSvoVz2ng/LCp0GMtnzTMVJrNg0mD
 Fy+dFJyMGoTlM6EwU0aOW70HR/4Hhrv1vdiufwQXqOO9WYntv1SGu0hiHl4/JMKS7My1
 +6NjG+uERnBEHq1pGkrLZaiGYYqdYMqBtbxOdCAaRIC3WCysKlpbTLByzaeVsBZ1k1RX
 Vj8wCJM7zFSJtkaYqfMV5MnlYXEj+jDKyVjXVUgFj44THEp26qna5OtmeGZBk70+cd+z
 G9fbT6RYc4nIFvy5rn9+5I63R6jnFHYojIgQkKKlr8ZOzXKtE/g58tOfSOvYiHOs4Rbc
 9LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065601; x=1733670401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vZ+D4zf1PBhpfrDUbIquFaEGgs8hQN808U2e75k8ik=;
 b=v33yIq2OlT/zYFPZMwV8UjGZ1uh3NSPt3cAwwL7yoVVr9xgJbMlXw0qm0GV1QjVY1E
 sIlpbYgEcc1O7v73+zaaTgZMg492JA49aX3RZI1qIX8PMYDmnkrSj4sfGY426pauYBik
 cUDzsjGoYI11FxpqITiwU1AAx12EV1mjMw3pFvf+QDRskR97LDeDnxKzND+R3PrqLCs6
 Zx+ZY449QZG+BNCC73FBDhhj6pVkxww+Znx72Q6O0Liw2DrCP0+c72nx2ZdrMWJx3VZw
 PbWxaX9YP36C5yEfn88+J+zPp9DfMYmG9YxUABEmSou8MngmrgaaUdLyErLYfaDyJ/pc
 PsZw==
X-Gm-Message-State: AOJu0YyBdhV5vCw5CJrk0MHJ+2tNq1QlTOdJ/dXoeCHYtA0m5RPEOB3z
 PWGGhfFEIiRMBmQ/ONfwPETk48aiJJTUEbLGyv8f9nSdtGw+btn/41fpVCETXOoQ4KJlKY8a0wx
 Cueg=
X-Gm-Gg: ASbGnctdzZGKoay3slYUMn0UAzFa26azEKdGdWPLdk3eIj356O/9E/SfSp1FUZPfVe0
 UgYdwQXx1j4IMCeChEaJKcFt+Q7Nj6/NLridz4M7ZapE080sJy3paLX1ZX19KIKegzteCt07IWM
 c7jlkCpyyWbeXGGmCIitUuBq0zsAMKe1QntDsB/hOaRg5F9OP1g3JHyK+PkJ6KxGMU0X6ujmHtm
 DsUhLGNGWdGlZCTJigxo4QorPEhvsluMivQtVS+e/6LnmhROnoWadFiNbHCZHRgrN0MOMUVUHip
 4NfJAkaLYKkPH9Ba6uoAm9dzh+tV2nd6MpdS
X-Google-Smtp-Source: AGHT+IEcUA6SyXGxM23qrA7gGQDkeiACPa/3MlmVFwIwKinIv7RuMTSCrfly2EQH306pslkzkmlTDg==
X-Received: by 2002:a05:6808:22a4:b0:3ea:6ce3:a0bb with SMTP id
 5614622812f47-3ea6db611dcmr17116443b6e.5.1733065601053; 
 Sun, 01 Dec 2024 07:06:41 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 28/67] target/arm: Convert BFCVT to decodetree
Date: Sun,  1 Dec 2024 09:05:27 -0600
Message-ID: <20241201150607.12812-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/translate-a64.c | 24 ++++++------------------
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e8842012ea..b713c7d184 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8424,6 +8424,11 @@ static const FPScalar1 f_scalar_frintx = {
 };
 TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 
+static const FPScalar1 f_scalar_bfcvt = {
+    .gen_s = gen_helper_bfcvt,
+};
+TRANS_FEAT(BFCVT_s, aa64_bf16, do_fp1_scalar, a, &f_scalar_bfcvt, -1)
+
 /* Floating-point data-processing (1 source) - single precision */
 static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -8436,9 +8441,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x6: /* BFCVT */
-        gen_fpst = gen_helper_bfcvt;
-        break;
     case 0x10: /* FRINT32Z */
         rmode = FPROUNDING_ZERO;
         gen_fpst = gen_helper_frint32_s;
@@ -8458,6 +8460,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
     case 0x3: /* FSQRT */
+    case 0x6: /* BFCVT */
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8661,21 +8664,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
         break;
 
     case 0x6:
-        switch (type) {
-        case 1: /* BFCVT */
-            if (!dc_isar_feature(aa64_bf16, s)) {
-                goto do_unallocated;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_fp_1src_single(s, opcode, rd, rn);
-            break;
-        default:
-            goto do_unallocated;
-        }
-        break;
-
     default:
     do_unallocated:
         unallocated_encoding(s);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index fbfdf96eb3..476989c1b4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -45,6 +45,7 @@
 &qrrrr_e        q rd rn rm ra esz
 
 @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
+@rr_s           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=2
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 @rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
@@ -1337,6 +1338,8 @@ FRINTA_s        00011110 .. 1 001100 10000 ..... .....      @rr_hsd
 FRINTX_s        00011110 .. 1 001110 10000 ..... .....      @rr_hsd
 FRINTI_s        00011110 .. 1 001111 10000 ..... .....      @rr_hsd
 
+BFCVT_s         00011110 10 1 000110 10000 ..... .....      @rr_s
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


