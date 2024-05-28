Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A070CC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UB-0003pC-5Y; Tue, 28 May 2024 16:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Tg-00035B-KM
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TS-0003jL-Mp
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:24 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so1013458b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928268; x=1717533068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hINvuUb552QxtnFYsIP8gVHA+s4s5KaUcjBPHEb0IOw=;
 b=ocSHLx4mTeLwaXV4ChtpfBHmHekd1qfCVwpR+wpZV1aSxLVfuWYt5KXi7fI2/jfqrE
 xDRJjET0PWDEemQJfoJqQ2mCAWYJdq7U03uVqeUXGlY+Eeg/bAj1Bw444POkan06xbtU
 ztuMLS0ZanUfhepnkPwAFjz7q3kCnyiZxspzP9auB+4Pmm5qH2wf22mfQEqmgdOrzyd/
 Z4WciSagQ3bdxNHwsq1m8BwkJPFMTvN56A2rQS2VXSTF8UAgvL93oHodcAt2pKh1dIao
 D04mRLxwSHJfPVRV/EDH8VCVZWydZAtUPZoDfmcmM4SdRcEKql4D3UOg35HJs6pvLaO9
 SYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928268; x=1717533068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hINvuUb552QxtnFYsIP8gVHA+s4s5KaUcjBPHEb0IOw=;
 b=KZWbK+IiCuh8ZiPDqzpI+9FNlZV6b4fami9gv2KTKADlNSX8wsHEvjr+wozLbg6R2V
 IAg/jgy49L4jLXPiX8vR0kwkAnWfZl5MBS9f8knJFTALfwH+gvR99msd4h0ktCcXtTd2
 AYfzbughRqiHgdiz6NuVFBsBhDufbynrN+cojZeSXK450V2o8X6o1Tqqa1zhh0fb2CVO
 yRqoeLDCLvLtNNSHeOJsLEC5qOFN6qOVDo5tZXZkyYBZcMfjRD+onMb14VGEkz62AzQm
 9KEEXY/xjcYZ3/LpQ09XLyUFRApe40WJVIgzaaZkfkHWT6f8nliY6sGWP1NsLczT08mR
 jYew==
X-Gm-Message-State: AOJu0YwysuaW9+JEEzl8UWWUu8SjJX/Ih4rI2He/nAMOsSsk1crxwkmi
 6zqqSydCOnI6iRNOz30V52KGgm7vlneJDIIusIxf2t4KUP8fdbryYtJFvrbABpXk2iHt7xxYz8F
 K
X-Google-Smtp-Source: AGHT+IExQkZHoetfjAQZPrp6rLJEbo8a+6pHQ+U7Fa4gTNVYWTu5y2ugTkbZPrGA4vk0Af0IKH6l4g==
X-Received: by 2002:a05:6a20:de14:b0:1af:ab09:c555 with SMTP id
 adf61e73a8af0-1b212f34c55mr10586470637.47.1716928267929; 
 Tue, 28 May 2024 13:31:07 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 25/33] target/arm: Convert SRHADD, URHADD to decodetree
Date: Tue, 28 May 2024 13:30:36 -0700
Message-Id: <20240528203044.612851-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b1bbcb144e..1c448b4f7c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -916,6 +916,8 @@ SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
+SRHADD_v        0.00 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
+URHADD_v        0.10 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 40aa7a9d57..9ef5de6755 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5458,6 +5458,8 @@ TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
 TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
 TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
 TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
+TRANS(SRHADD_v, do_gvec_fn3_no64, a, gen_gvec_srhadd)
+TRANS(URHADD_v, do_gvec_fn3_no64, a, gen_gvec_urhadd)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10923,7 +10925,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0x2: /* SRHADD, URHADD */
     case 0xc: /* SMAX, UMAX */
     case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
@@ -10949,6 +10950,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
+    case 0x02: /* SRHADD, URHADD */
     case 0x04: /* SHSUB, UHSUB */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
@@ -10968,13 +10970,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x02: /* SRHADD, URHADD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_urhadd, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_srhadd, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


