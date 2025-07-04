Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFF4C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjF0-0001yU-3l; Fri, 04 Jul 2025 12:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEr-0001TV-AC
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:14 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEp-0006br-2e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:13 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so735530f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646369; x=1752251169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cwvushiLVebVw534HbDroYhAk65JqrojHcIJDIqa2C8=;
 b=OobhmTJWdanOOc0TmFy+5sPTg0Sa+kVBF+P19fiXGPIyLI3su81yJjoFgdc3KK0RPK
 kMhoHGz4/+FtC9ZcRHK5VL+lIyzHJsbhX7ALRHdxUNOW0ntJHngvy2EjvL3c9Nu/+Ffx
 6v17l5DLNwVPBnAl+4knY4qjUHJhCEeIsbzMpeSobffpveV5HxgkrEbDL72R5FwQA9Ez
 v1AlB5dKGDLniSXsPdBSjUp97vfaxxg2JjnxGDDgvktnLOYDRopRL3rG6rqolmV/aC2O
 uhcvz0dI/vQOd/7MSfdEZiKpGNxvddcDCD29Cwj905O9/Jkkrn1UNzUaCWar/vSlA/rE
 +/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646369; x=1752251169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwvushiLVebVw534HbDroYhAk65JqrojHcIJDIqa2C8=;
 b=XWrAEEoNwws8QHwH3hGVg2aoauEFTkA93hUA7Q4VDZ6vmUTrc6Ya9a7/FMT1nIe0hT
 /YkwefDw49aqF7avMGcT3iTIRpw6YLoXK35lsqeD+5HH4303XAnxWFVm0yF1T5ir3Awp
 L1ivAiJs2KxoRmvFDw8FQVuz0kaduaITRf8EydWitL75dZpabZPKsV4ZpgSxqEMlpJQI
 yRS0/VWPjxyiKpOy87OVgH2M6BxMUmmrWnmoOlRdd0g6eotJf3ZYJeeFHo+3R/w7l64X
 7b10+n6bZs5tAEHe6eB5SeEf/BR89hz4A344pdOuTaiClmb9G2NagQTqZQAU3msJiVT+
 kbJQ==
X-Gm-Message-State: AOJu0YwGZ3C6pOZwkTBppX/MEr0koqO9OXPITYSJShsoLMsvRns90tuP
 uH/BRi/Qiu5bQ6pkZHQAd/ucPTLozyJ18rZ7CB9d0VU0GjDPJEE//kH/OgYWcM8XEQsBbs4fleu
 peY9j
X-Gm-Gg: ASbGncvbLOXD1nXpspc5VY7zh6I/c/h6O362exPhU5/G5KZIkteZX6IFhC1x/iF1wQN
 7a6qu5vzxLnPYeeedqD6vZ3Bn26K9q3jllmzxMcj79XeeYeAE6crAc22+ljsf6q93hH1FOIAVzP
 TqyAclpnHqY5P6pLzWePSaHvXG6IaDW99XZOYrhr/MThm94tuZhJcLtdxEvgS6JCTK6/GVWeDJt
 RiA3Sm9fX7wSiZVEinb1eW1cuGiO4q8iZ3FwltfYu4M34ARwkUQ1kaNhyajFEonQXden34VLJGS
 rwZxry8h7dmoE2exkdl2Frf7JMYsmotvYwaqVG/y0urE/GtUa34CZO0baFgNokrO5rPNXeiXPXi
 fvM4=
X-Google-Smtp-Source: AGHT+IHqb8sQgpoIav8vgQZpWuchEcejo8CTN4COqG/Q137uF9bzAHsW97PZNugxcbDUik9YKk+h6w==
X-Received: by 2002:a05:6000:4026:b0:3a4:ef30:a4c8 with SMTP id
 ffacd0b85a97d-3b4964bb6e0mr2881120f8f.10.1751646369320; 
 Fri, 04 Jul 2025 09:26:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 070/119] target/arm: Use do_[us]sat_[bhs] in sve_helper.c
Date: Fri,  4 Jul 2025 17:24:10 +0100
Message-ID: <20250704162501.249138-71-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Replace and remove do_sat_bhs.
This avoids multiple repetitions of INT*_MIN/MAX.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-59-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 116 +++++++++++++++---------------------
 1 file changed, 48 insertions(+), 68 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 4f12723afea..f9052f21644 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -527,14 +527,9 @@ DO_ZPZZ(sve2_uhsub_zpzz_h, uint16_t, H1_2, DO_HSUB_BHS)
 DO_ZPZZ(sve2_uhsub_zpzz_s, uint32_t, H1_4, DO_HSUB_BHS)
 DO_ZPZZ_D(sve2_uhsub_zpzz_d, uint64_t, DO_HSUB_D)
 
-static inline int32_t do_sat_bhs(int64_t val, int64_t min, int64_t max)
-{
-    return val >= max ? max : val <= min ? min : val;
-}
-
-#define DO_SQADD_B(n, m) do_sat_bhs((int64_t)n + m, INT8_MIN, INT8_MAX)
-#define DO_SQADD_H(n, m) do_sat_bhs((int64_t)n + m, INT16_MIN, INT16_MAX)
-#define DO_SQADD_S(n, m) do_sat_bhs((int64_t)n + m, INT32_MIN, INT32_MAX)
+#define DO_SQADD_B(n, m) do_ssat_b((int64_t)n + m)
+#define DO_SQADD_H(n, m) do_ssat_h((int64_t)n + m)
+#define DO_SQADD_S(n, m) do_ssat_s((int64_t)n + m)
 
 static inline int64_t do_sqadd_d(int64_t n, int64_t m)
 {
@@ -551,9 +546,9 @@ DO_ZPZZ(sve2_sqadd_zpzz_h, int16_t, H1_2, DO_SQADD_H)
 DO_ZPZZ(sve2_sqadd_zpzz_s, int32_t, H1_4, DO_SQADD_S)
 DO_ZPZZ_D(sve2_sqadd_zpzz_d, int64_t, do_sqadd_d)
 
-#define DO_UQADD_B(n, m) do_sat_bhs((int64_t)n + m, 0, UINT8_MAX)
-#define DO_UQADD_H(n, m) do_sat_bhs((int64_t)n + m, 0, UINT16_MAX)
-#define DO_UQADD_S(n, m) do_sat_bhs((int64_t)n + m, 0, UINT32_MAX)
+#define DO_UQADD_B(n, m) do_usat_b((int64_t)n + m)
+#define DO_UQADD_H(n, m) do_usat_h((int64_t)n + m)
+#define DO_UQADD_S(n, m) do_usat_s((int64_t)n + m)
 
 static inline uint64_t do_uqadd_d(uint64_t n, uint64_t m)
 {
@@ -566,9 +561,9 @@ DO_ZPZZ(sve2_uqadd_zpzz_h, uint16_t, H1_2, DO_UQADD_H)
 DO_ZPZZ(sve2_uqadd_zpzz_s, uint32_t, H1_4, DO_UQADD_S)
 DO_ZPZZ_D(sve2_uqadd_zpzz_d, uint64_t, do_uqadd_d)
 
-#define DO_SQSUB_B(n, m) do_sat_bhs((int64_t)n - m, INT8_MIN, INT8_MAX)
-#define DO_SQSUB_H(n, m) do_sat_bhs((int64_t)n - m, INT16_MIN, INT16_MAX)
-#define DO_SQSUB_S(n, m) do_sat_bhs((int64_t)n - m, INT32_MIN, INT32_MAX)
+#define DO_SQSUB_B(n, m) do_ssat_b((int64_t)n - m)
+#define DO_SQSUB_H(n, m) do_ssat_h((int64_t)n - m)
+#define DO_SQSUB_S(n, m) do_ssat_s((int64_t)n - m)
 
 static inline int64_t do_sqsub_d(int64_t n, int64_t m)
 {
@@ -585,9 +580,9 @@ DO_ZPZZ(sve2_sqsub_zpzz_h, int16_t, H1_2, DO_SQSUB_H)
 DO_ZPZZ(sve2_sqsub_zpzz_s, int32_t, H1_4, DO_SQSUB_S)
 DO_ZPZZ_D(sve2_sqsub_zpzz_d, int64_t, do_sqsub_d)
 
-#define DO_UQSUB_B(n, m) do_sat_bhs((int64_t)n - m, 0, UINT8_MAX)
-#define DO_UQSUB_H(n, m) do_sat_bhs((int64_t)n - m, 0, UINT16_MAX)
-#define DO_UQSUB_S(n, m) do_sat_bhs((int64_t)n - m, 0, UINT32_MAX)
+#define DO_UQSUB_B(n, m) do_usat_b((int64_t)n - m)
+#define DO_UQSUB_H(n, m) do_usat_h((int64_t)n - m)
+#define DO_UQSUB_S(n, m) do_usat_s((int64_t)n - m)
 
 static inline uint64_t do_uqsub_d(uint64_t n, uint64_t m)
 {
@@ -599,12 +594,9 @@ DO_ZPZZ(sve2_uqsub_zpzz_h, uint16_t, H1_2, DO_UQSUB_H)
 DO_ZPZZ(sve2_uqsub_zpzz_s, uint32_t, H1_4, DO_UQSUB_S)
 DO_ZPZZ_D(sve2_uqsub_zpzz_d, uint64_t, do_uqsub_d)
 
-#define DO_SUQADD_B(n, m) \
-    do_sat_bhs((int64_t)(int8_t)n + m, INT8_MIN, INT8_MAX)
-#define DO_SUQADD_H(n, m) \
-    do_sat_bhs((int64_t)(int16_t)n + m, INT16_MIN, INT16_MAX)
-#define DO_SUQADD_S(n, m) \
-    do_sat_bhs((int64_t)(int32_t)n + m, INT32_MIN, INT32_MAX)
+#define DO_SUQADD_B(n, m) do_ssat_b((int64_t)(int8_t)n + m)
+#define DO_SUQADD_H(n, m) do_ssat_h((int64_t)(int16_t)n + m)
+#define DO_SUQADD_S(n, m) do_ssat_s((int64_t)(int32_t)n + m)
 
 static inline int64_t do_suqadd_d(int64_t n, uint64_t m)
 {
@@ -634,12 +626,9 @@ DO_ZPZZ(sve2_suqadd_zpzz_h, uint16_t, H1_2, DO_SUQADD_H)
 DO_ZPZZ(sve2_suqadd_zpzz_s, uint32_t, H1_4, DO_SUQADD_S)
 DO_ZPZZ_D(sve2_suqadd_zpzz_d, uint64_t, do_suqadd_d)
 
-#define DO_USQADD_B(n, m) \
-    do_sat_bhs((int64_t)n + (int8_t)m, 0, UINT8_MAX)
-#define DO_USQADD_H(n, m) \
-    do_sat_bhs((int64_t)n + (int16_t)m, 0, UINT16_MAX)
-#define DO_USQADD_S(n, m) \
-    do_sat_bhs((int64_t)n + (int32_t)m, 0, UINT32_MAX)
+#define DO_USQADD_B(n, m) do_usat_b((int64_t)n + (int8_t)m)
+#define DO_USQADD_H(n, m) do_usat_h((int64_t)n + (int16_t)m)
+#define DO_USQADD_S(n, m) do_usat_s((int64_t)n + (int32_t)m)
 
 static inline uint64_t do_usqadd_d(uint64_t n, int64_t m)
 {
@@ -1226,37 +1215,29 @@ void HELPER(NAME)(void *vd, void *vn, uint32_t desc)                    \
     }                                                                   \
 }
 
-#define DO_SQXTN_H(n)  do_sat_bhs(n, INT8_MIN, INT8_MAX)
-#define DO_SQXTN_S(n)  do_sat_bhs(n, INT16_MIN, INT16_MAX)
-#define DO_SQXTN_D(n)  do_sat_bhs(n, INT32_MIN, INT32_MAX)
+DO_XTNB(sve2_sqxtnb_h, int16_t, do_ssat_b)
+DO_XTNB(sve2_sqxtnb_s, int32_t, do_ssat_h)
+DO_XTNB(sve2_sqxtnb_d, int64_t, do_ssat_s)
 
-DO_XTNB(sve2_sqxtnb_h, int16_t, DO_SQXTN_H)
-DO_XTNB(sve2_sqxtnb_s, int32_t, DO_SQXTN_S)
-DO_XTNB(sve2_sqxtnb_d, int64_t, DO_SQXTN_D)
+DO_XTNT(sve2_sqxtnt_h, int16_t, int8_t, H1, do_ssat_b)
+DO_XTNT(sve2_sqxtnt_s, int32_t, int16_t, H1_2, do_ssat_h)
+DO_XTNT(sve2_sqxtnt_d, int64_t, int32_t, H1_4, do_ssat_s)
 
-DO_XTNT(sve2_sqxtnt_h, int16_t, int8_t, H1, DO_SQXTN_H)
-DO_XTNT(sve2_sqxtnt_s, int32_t, int16_t, H1_2, DO_SQXTN_S)
-DO_XTNT(sve2_sqxtnt_d, int64_t, int32_t, H1_4, DO_SQXTN_D)
+DO_XTNB(sve2_uqxtnb_h, uint16_t, do_usat_b)
+DO_XTNB(sve2_uqxtnb_s, uint32_t, do_usat_h)
+DO_XTNB(sve2_uqxtnb_d, uint64_t, do_usat_s)
 
-#define DO_UQXTN_H(n)  do_sat_bhs(n, 0, UINT8_MAX)
-#define DO_UQXTN_S(n)  do_sat_bhs(n, 0, UINT16_MAX)
-#define DO_UQXTN_D(n)  do_sat_bhs(n, 0, UINT32_MAX)
+DO_XTNT(sve2_uqxtnt_h, uint16_t, uint8_t, H1, do_usat_b)
+DO_XTNT(sve2_uqxtnt_s, uint32_t, uint16_t, H1_2, do_usat_h)
+DO_XTNT(sve2_uqxtnt_d, uint64_t, uint32_t, H1_4, do_usat_s)
 
-DO_XTNB(sve2_uqxtnb_h, uint16_t, DO_UQXTN_H)
-DO_XTNB(sve2_uqxtnb_s, uint32_t, DO_UQXTN_S)
-DO_XTNB(sve2_uqxtnb_d, uint64_t, DO_UQXTN_D)
+DO_XTNB(sve2_sqxtunb_h, int16_t, do_usat_b)
+DO_XTNB(sve2_sqxtunb_s, int32_t, do_usat_h)
+DO_XTNB(sve2_sqxtunb_d, int64_t, do_usat_s)
 
-DO_XTNT(sve2_uqxtnt_h, uint16_t, uint8_t, H1, DO_UQXTN_H)
-DO_XTNT(sve2_uqxtnt_s, uint32_t, uint16_t, H1_2, DO_UQXTN_S)
-DO_XTNT(sve2_uqxtnt_d, uint64_t, uint32_t, H1_4, DO_UQXTN_D)
-
-DO_XTNB(sve2_sqxtunb_h, int16_t, DO_UQXTN_H)
-DO_XTNB(sve2_sqxtunb_s, int32_t, DO_UQXTN_S)
-DO_XTNB(sve2_sqxtunb_d, int64_t, DO_UQXTN_D)
-
-DO_XTNT(sve2_sqxtunt_h, int16_t, int8_t, H1, DO_UQXTN_H)
-DO_XTNT(sve2_sqxtunt_s, int32_t, int16_t, H1_2, DO_UQXTN_S)
-DO_XTNT(sve2_sqxtunt_d, int64_t, int32_t, H1_4, DO_UQXTN_D)
+DO_XTNT(sve2_sqxtunt_h, int16_t, int8_t, H1, do_usat_b)
+DO_XTNT(sve2_sqxtunt_s, int32_t, int16_t, H1_2, do_usat_h)
+DO_XTNT(sve2_sqxtunt_d, int64_t, int32_t, H1_4, do_usat_s)
 
 #undef DO_XTNB
 #undef DO_XTNT
@@ -2187,10 +2168,9 @@ DO_SHRNT(sve2_rshrnt_h, uint16_t, uint8_t, H1_2, H1, do_urshr)
 DO_SHRNT(sve2_rshrnt_s, uint32_t, uint16_t, H1_4, H1_2, do_urshr)
 DO_SHRNT(sve2_rshrnt_d, uint64_t, uint32_t, H1_8, H1_4, do_urshr)
 
-#define DO_SQSHRUN_H(x, sh) do_sat_bhs((int64_t)(x) >> sh, 0, UINT8_MAX)
-#define DO_SQSHRUN_S(x, sh) do_sat_bhs((int64_t)(x) >> sh, 0, UINT16_MAX)
-#define DO_SQSHRUN_D(x, sh) \
-    do_sat_bhs((int64_t)(x) >> (sh < 64 ? sh : 63), 0, UINT32_MAX)
+#define DO_SQSHRUN_H(x, sh) do_usat_b((int64_t)(x) >> sh)
+#define DO_SQSHRUN_S(x, sh) do_usat_h((int64_t)(x) >> sh)
+#define DO_SQSHRUN_D(x, sh) do_usat_s((int64_t)(x) >> (sh < 64 ? sh : 63))
 
 DO_SHRNB(sve2_sqshrunb_h, int16_t, uint8_t, DO_SQSHRUN_H)
 DO_SHRNB(sve2_sqshrunb_s, int32_t, uint16_t, DO_SQSHRUN_S)
@@ -2200,9 +2180,9 @@ DO_SHRNT(sve2_sqshrunt_h, int16_t, uint8_t, H1_2, H1, DO_SQSHRUN_H)
 DO_SHRNT(sve2_sqshrunt_s, int32_t, uint16_t, H1_4, H1_2, DO_SQSHRUN_S)
 DO_SHRNT(sve2_sqshrunt_d, int64_t, uint32_t, H1_8, H1_4, DO_SQSHRUN_D)
 
-#define DO_SQRSHRUN_H(x, sh) do_sat_bhs(do_srshr(x, sh), 0, UINT8_MAX)
-#define DO_SQRSHRUN_S(x, sh) do_sat_bhs(do_srshr(x, sh), 0, UINT16_MAX)
-#define DO_SQRSHRUN_D(x, sh) do_sat_bhs(do_srshr(x, sh), 0, UINT32_MAX)
+#define DO_SQRSHRUN_H(x, sh) do_usat_b(do_srshr(x, sh))
+#define DO_SQRSHRUN_S(x, sh) do_usat_h(do_srshr(x, sh))
+#define DO_SQRSHRUN_D(x, sh) do_usat_s(do_srshr(x, sh))
 
 DO_SHRNB(sve2_sqrshrunb_h, int16_t, uint8_t, DO_SQRSHRUN_H)
 DO_SHRNB(sve2_sqrshrunb_s, int32_t, uint16_t, DO_SQRSHRUN_S)
@@ -2212,9 +2192,9 @@ DO_SHRNT(sve2_sqrshrunt_h, int16_t, uint8_t, H1_2, H1, DO_SQRSHRUN_H)
 DO_SHRNT(sve2_sqrshrunt_s, int32_t, uint16_t, H1_4, H1_2, DO_SQRSHRUN_S)
 DO_SHRNT(sve2_sqrshrunt_d, int64_t, uint32_t, H1_8, H1_4, DO_SQRSHRUN_D)
 
-#define DO_SQSHRN_H(x, sh) do_sat_bhs(x >> sh, INT8_MIN, INT8_MAX)
-#define DO_SQSHRN_S(x, sh) do_sat_bhs(x >> sh, INT16_MIN, INT16_MAX)
-#define DO_SQSHRN_D(x, sh) do_sat_bhs(x >> sh, INT32_MIN, INT32_MAX)
+#define DO_SQSHRN_H(x, sh) do_ssat_b(x >> sh)
+#define DO_SQSHRN_S(x, sh) do_ssat_h(x >> sh)
+#define DO_SQSHRN_D(x, sh) do_ssat_s(x >> sh)
 
 DO_SHRNB(sve2_sqshrnb_h, int16_t, uint8_t, DO_SQSHRN_H)
 DO_SHRNB(sve2_sqshrnb_s, int32_t, uint16_t, DO_SQSHRN_S)
@@ -2224,9 +2204,9 @@ DO_SHRNT(sve2_sqshrnt_h, int16_t, uint8_t, H1_2, H1, DO_SQSHRN_H)
 DO_SHRNT(sve2_sqshrnt_s, int32_t, uint16_t, H1_4, H1_2, DO_SQSHRN_S)
 DO_SHRNT(sve2_sqshrnt_d, int64_t, uint32_t, H1_8, H1_4, DO_SQSHRN_D)
 
-#define DO_SQRSHRN_H(x, sh) do_sat_bhs(do_srshr(x, sh), INT8_MIN, INT8_MAX)
-#define DO_SQRSHRN_S(x, sh) do_sat_bhs(do_srshr(x, sh), INT16_MIN, INT16_MAX)
-#define DO_SQRSHRN_D(x, sh) do_sat_bhs(do_srshr(x, sh), INT32_MIN, INT32_MAX)
+#define DO_SQRSHRN_H(x, sh) do_ssat_b(do_srshr(x, sh))
+#define DO_SQRSHRN_S(x, sh) do_ssat_h(do_srshr(x, sh))
+#define DO_SQRSHRN_D(x, sh) do_ssat_s(do_srshr(x, sh))
 
 DO_SHRNB(sve2_sqrshrnb_h, int16_t, uint8_t, DO_SQRSHRN_H)
 DO_SHRNB(sve2_sqrshrnb_s, int32_t, uint16_t, DO_SQRSHRN_S)
-- 
2.43.0


