Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7362E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YM-0001kW-W7; Fri, 13 Dec 2024 12:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XF-00076m-Q3
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:06 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XD-0001YO-NO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:05 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so11937655e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111182; x=1734715982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOwJkFpCYPBbxu4BEzK9jmh/7u4NOfmJpDTTNygl1i4=;
 b=yqDMf2qDPMkjT957s6xoFBx8eVahZqrR16HN9hmmc8qLWeEqKY39xE/MvY0a5K811g
 JErMrC5LGeQGjR+T6rW/4YCuWkgR77YXQxk52s9iTq5CjwjlDSYnz/eH/Wbyl/Glt1Iq
 Fm8OELIxTQA+nYmFD8O76o8aZ1H9s+WrOkykrO2OFkfUG4o3SD0zOJBcBQeGpnwF2NOg
 SgCWkUIz5n3ZTPL+o8NNK84RoG95naiW1/of2xcIXv6pAFuD1AqXYo+wxgAVKUgEAj8l
 PC/Y0vD8w895oIHFc4NQsIsk1Zk4AkVfaEh46XYGEYoqtKMLy8G5bMLvBm4UO1aV6mdO
 LF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111182; x=1734715982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOwJkFpCYPBbxu4BEzK9jmh/7u4NOfmJpDTTNygl1i4=;
 b=wy04FmuKCnYgooEDbSO8UwSQTqThb2d8Wkz6xk+b1tqOxf/j8DgTKC6OVEoTEMml1Q
 8H/xpKaz5wLM+RXQ33mphPcdC+yU2uofjE/HLNmA92z8bUXipdv6s7SQ9f6otVmZEvG0
 80kJNLYRxuIjdXM6Y5ZTJgITBll+MpJFf1Ub/nlKwUkeXQ309126KfBCchZsWZpJ8jYJ
 Oi0zTOIm7Km9sQjhlECpaYYPGshTuDA4qLYCD/KsNJRLQ6iqGY2TIZn6CuWLlrI+x8L8
 JZMECKXmI/8urcZik2gl80oblUPmqT7jgEvSMkF6HyLQ1oDVwIhdY3m4KZiO7GpcNBgB
 KVVQ==
X-Gm-Message-State: AOJu0Yx86phpSpUvG9SYM94XvUsD9oM42YwrSwX/3Itsh1lGD4WaSaxl
 rin/cKwg2bXOcr+wU18PAjc8c33m990/TIGgcMlNd6KwsoUy7Nq13qEfYz4W/vSXM8JuZcdVymp
 O
X-Gm-Gg: ASbGncuE+Ox1mFZJv9xFfgysJ8Fb3EN1EzsLsm0XcYSlKTYT7xvGwQmaE9/Vynu9tws
 6P52P4U3T6mx4vvKKkxvVsyvVCUoN9gVgJe6g2GOlWGfCE7PFeLVls6ZCLa29qPK0U38uKkJ3iR
 2yX7I8usVEMF4PzuUUjobzEYuYZP3i606uBg3cP+PBU3k/Too4A/kCsaGlUSAIXhWFCeTC7Y8/8
 e+jy9ytG4FPsRPQ+3DgutgxCDp5urNf/T1h4+NzUSUuKAjuEerdvhU+tjOtqw==
X-Google-Smtp-Source: AGHT+IEPqLHO+xvZLu07iia8YzukgarYMLF8wMSdwEtIJwHYIrUBS+QQzVlwTkm4Wzka1MEfxgxqTQ==
X-Received: by 2002:a5d:598b:0:b0:382:5aae:87c7 with SMTP id
 ffacd0b85a97d-38880adaaadmr2289721f8f.31.1734111182184; 
 Fri, 13 Dec 2024 09:33:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/85] target/arm: Convert BFCVT to decodetree
Date: Fri, 13 Dec 2024 17:31:33 +0000
Message-Id: <20241213173229.3308926-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-30-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 26 +++++++-------------------
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9d2f099c9ca..4a48fcff1dc 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5a347bece37..5b30b4cacac 100644
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
-- 
2.34.1


