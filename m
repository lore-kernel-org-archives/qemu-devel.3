Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB91E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPe6-000099-Ph; Wed, 11 Dec 2024 11:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdM-0005Vo-0R
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:21 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdI-0001Pg-Lh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:18 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4675d91ea1fso33294421cf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934736; x=1734539536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVZbpzoYlL2Dxsbbr2iwK6Jz90M9hQKlxSzzwf2vpI4=;
 b=TMncqWWbe0ZG4opO6PZHipvTr/jDHjC+IkBSGNgefpuDbJu/ixqRTaL6wpg0fbflWe
 BL+MRog38/xWlV+SCmZaf3rfYY/H7Wpj8gjBJ0gCXWbp/XnUXZpC7CKwAcCXaRifpUwt
 NlPUBBUAKv69tbUr41nkjBwk7nr8l3gxKgCTdedbjNyaFIf5eOKnnFSCwY7kjZ6L6n02
 LVAS8KjmKshb2LS7s+qbre6Vp+R9f5Kxf/FIItfMKJVadVKb/BPN+etR7KvbMYv9aLyv
 9ffswIPk4n/IASZhHDEy1Lr+iM1Sr2JJXHR2h2D9od8M5cNADPZa52SU/qUff3ZoHTER
 h5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934736; x=1734539536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVZbpzoYlL2Dxsbbr2iwK6Jz90M9hQKlxSzzwf2vpI4=;
 b=Kh5IV7BA5b234352AR2xy24EO2meWDhk+j/eU45KB3PEV0vIH4fA+v8g5wm7opbMgA
 hXhssiltejFCsdekBl92bxCP/kVbWe9hISYGjh6t9+GkR394GChBDv7Mkc+Xf+gZdn22
 TIOws/kkQLZH0ASQN0WSy/BaQRSbf7Gai35gcqjnGriWey8CIBk5Mb3H1Hc3P1tyOyP0
 bgU26Bz4Ley//SNRiTBIZSgs7te2yIbkeEAqBO4uMT/llC0JFZYvHgw2mh1ztAJlbOHO
 trSxurN4n8WNC5rzlVIqbyVUHYQhTKiB5vtzFm/uOyb4quq/Dx98ZMcPvpcbuooPiFHw
 pE8w==
X-Gm-Message-State: AOJu0Ywdy6PURp5ykoUAf2NqZ/JcffbGJHnbEilCPshACcCCq0i8rkuQ
 pwvYnOnUdmMQs9YSgniHyalzqyNWjLJLNNPJRVjRE/j2aY8biE4gU/53QUmLj4UrgaFyiIvWVkO
 56LTjLqhJ
X-Gm-Gg: ASbGncvDBea8PAdTFLNzFZ1bVlACxJSd5u9ehMO8O7TLpe7rLavB+fI3HB6hu7c1nwb
 qrDDYvhTP3+7OizSJrhHI8TJCPxryr68T8j1XmoXMt/bMTSKZ2U0gDnlZK2kGa0vqYhKP/YepEc
 XIa3SFBDzj4ykD2yN6sCmqvJopP/4szX9gTez/JnZvSrapIQ0X1QK+COHc/QWnVzqO5uh0RSxD5
 0qSmAEFDpzlWQ0p2woXiiZh+MsxTTg2zGOkrZjdbJkKyHXwZCufcgB7pLkURA==
X-Google-Smtp-Source: AGHT+IFNxAe4FAibCnAX1y4RxEDFBbrsuANA21hqUnAvKPF+YZNBbeMupkYdPetjgKSJRB7IZSyu5g==
X-Received: by 2002:ac8:7d07:0:b0:467:7cda:936d with SMTP id
 d75a77b69052e-467893201d2mr60175501cf.14.1733934735761; 
 Wed, 11 Dec 2024 08:32:15 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 29/69] target/arm: Convert BFCVT to decodetree
Date: Wed, 11 Dec 2024 10:29:56 -0600
Message-ID: <20241211163036.2297116-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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
 target/arm/tcg/translate-a64.c | 26 +++++++-------------------
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5a347bece3..5b30b4caca 100644
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


