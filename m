Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39291E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xq-0005mZ-KI; Tue, 10 Dec 2024 11:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xe-0004r0-RW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:48 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2xa-0006Xw-Lf
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:45 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5401ab97206so2429153e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847579; x=1734452379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzRacBoTVvTyHmOFDiNorsk3TiwuSPdvbsL1tVp2ix0=;
 b=EwIBKe8OTmHBoevqWX7QGPIIqw1509twavTluizUJNxdBcLSpyZiFujuV45jmBpuiy
 WwOk9QoUClLKXm7Hme0VTZLw1E9IeUUmWSW9NbH2n+iBOzq0au+85M3Ijx/sR3PpqvLG
 RcOl+wzuX3O/4+XWhlqqkxJWoGyEm/0TgP5stGiEmfVhgvRILs6bxH/alUmO/cwmf+qr
 XZiG4bZptFn5SraE/iwVI8hZu1+aOdnetXig8lTnCISxQwAbtkETE0rw+REs13NVsI+u
 jX8unK2FcIvqEcimMDC5ldRdwTNifHnc6BKPNk9rSAZ0GYomQFT2F0z1Mv4ZadQpKkS2
 Musg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847579; x=1734452379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzRacBoTVvTyHmOFDiNorsk3TiwuSPdvbsL1tVp2ix0=;
 b=gvG7ZyDrdFz05CVSq74z1zulRX4yxAFwvIPXT4DRe5pJc5vO4e4nBl55pO5AasMzLb
 vF0SqfaUMCrUppoP+Efhj6j0afeKs8pUz1DnIb26cQ+A+Md73kz7yGZKi3YGykT0mv5p
 Hab6ZAli3PuaP8UcKV+psgCdv7dVJ/F+Fxgl9aTRP14dKqti/tduosAE8Z6w+0kT9uM7
 T7aoLEPqIMFbpo3PyZX2tKDNabNUgbBwu0bQfAhDXhoTNp2byAtQpnOnMTywlk+TeY8a
 MWsh1xwlu31o9RmQSkoE1szquIw4tP3Pt3ROCNHVTmgxZT7nrWjiFYwsjnp+yhB6yaeV
 6biQ==
X-Gm-Message-State: AOJu0Yz34Cn5U44TVH+tTpB/cQi8DfqntWkuCLUh4Cc45QGdd9tUzIoE
 gg5YJFvFEkrjQ/2RabiiHRl6MsFqwUGuMo6KWTHYC4kAAypW6FvFcUJQ+wh3Tv4kR+ReEuVqLQe
 nOm6S+68t
X-Gm-Gg: ASbGncvbyJtgCOQwKpy2K/suoTkyEJw7G7S7MVwUehTiORcOI5rHo6JhvIkPDXFK+UN
 TSYphEEsWbzWuzLi2Ny2H3or8nU7+AFKFLyPcfhbMt+Pzv3RIdgID+100bF2qS6fIHCMDT7gx2E
 hAffPearq1je+GMMrqwurTaX4e/4W8mrXMHdB6hQdneGVmQuey2OAWnZjUdUPY25P6X9y9YY7c6
 gHlX97Za3Y7MXrTiyd7fZOev/8+5s5rQn1vi/i3Se4WMT4Uj54JisMaXAM=
X-Google-Smtp-Source: AGHT+IFOnU4ZeAB5x0AgjOtIL7oI/xD7o91ASiPmVUwOG+0ZVi8kIO39jBtLlG5JkV0Kp9AtDItsIg==
X-Received: by 2002:a05:6512:b96:b0:540:2339:375b with SMTP id
 2adb3069b0e04-540240e65e3mr1984600e87.32.1733847579395; 
 Tue, 10 Dec 2024 08:19:39 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:19:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 29/69] target/arm: Convert BFCVT to decodetree
Date: Tue, 10 Dec 2024 10:16:53 -0600
Message-ID: <20241210161733.1830573-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
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
 target/arm/tcg/translate-a64.c | 26 +++++++-------------------
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 45321cdca7..ef0379d17f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8420,6 +8420,11 @@ static const FPScalar1 f_scalar_frintx = {
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
@@ -8432,9 +8437,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     tcg_res = tcg_temp_new_i32();
 
     switch (opcode) {
-    case 0x6: /* BFCVT */
-        gen_fpst = gen_helper_bfcvt;
-        break;
     case 0x10: /* FRINT32Z */
         rmode = FPROUNDING_ZERO;
         gen_fpst = gen_helper_frint32_s;
@@ -8454,6 +8456,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
     case 0x3: /* FSQRT */
+    case 0x6: /* BFCVT */
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8652,28 +8655,13 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
         }
         break;
 
-    case 0x6:
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
     case 0x0: /* FMOV */
     case 0x1: /* FABS */
     case 0x2: /* FNEG */
     case 0x3: /* FSQRT */
+    case 0x6: /* BFCVT */
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9d2f099c9c..4a48fcff1d 100644
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
 
+BFCVT_s         00011110 01 1 000110 10000 ..... .....      @rr_s
+
 # Floating-point Immediate
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
-- 
2.43.0


