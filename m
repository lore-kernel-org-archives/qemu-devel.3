Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DC9C87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNiU-00072O-TI; Sat, 02 Aug 2025 21:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiR-0006zB-4x
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:47 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNiP-0004dH-Jn
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:40:46 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8ff3ef84d7so333239276.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754185244; x=1754790044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKKdhFemsGNB6aPKRV6dAvFjepdpP1yhrMp+rKvStFo=;
 b=InSeZevgruqZ/wlG5LyJXiDCuqyqb5UFwtU2UdWxQk0J1BIcoma85Eu7UUX/bmSqjH
 K0Rg0G4TTaEKT9jQGTVxtT+LStfWeu9DDmNJW3Jlrc/O7kDtoKSCzSCMfa5AcRBIWbR7
 lhLftH7241vMWgtZp/7n4Nt+xzD5uajO/9KYOL0HMylZVR0hylmJO5Q+dEHBFcXCXyOO
 AHoBlp9t1RCxq7hKKcFCRDgNOajb7M/HZkq4jctLEwPkdIMrvAggt8W6PxleT9Ssmodn
 +/x0lXLx5dfubx8Z+rXEbqNXPQdNUr8lyWs6psk4wcBBgQObVTyad+mkBBtnLr7SjSqA
 g6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754185244; x=1754790044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKKdhFemsGNB6aPKRV6dAvFjepdpP1yhrMp+rKvStFo=;
 b=SQHV2kS0a3hs/NTeRBoz5wl+JFySsU+b8LenWo0drmvCMzzMbl49EHprSGQDz1WLrZ
 6RGP0RpT+d1paUnyEbeoeRokFe89f4owwh2E1UK9yr07dt6V6MBOtNSV3ksy8RZDrRrM
 Ma/LCGLjnuk/mhonwiMwvedNb7CWh0DNOTc9sQicph24QdXrNA+tlJzh42Bcf56SgnDU
 8TtY8S2vnT/M/bDRUu2plJCqTxWXVvsYAsvccehDHd90gLumTr6WmfP6VFWC7LceMBHy
 HmAkJ3Y5RcFe6UgttqreTkhQT7K+WWnsoE9Mi8qeVqvuAwu3In7y0qtDBWP4VcNpLh3i
 XAQQ==
X-Gm-Message-State: AOJu0Yz8xs8IdI+EtiXf5CY+o4misIqYhRd/G/8FTjOOl8iS0WbVgj3z
 i3RORb7lDS99HEfOW4Y2DQPBsrKrxO3SMkUz406fW1dH+PgXYAnDkpqKUgNcILvsiCzshDigSmn
 pJT393Jg=
X-Gm-Gg: ASbGncsmjTbppvmdBXtWwZxKNBYYOm+jWUSRVm+k9kKT0+fVsoIGeaIUdBftwgZJFLu
 xCEAAaJ6tFDSObX3lH/KTWHBVwDV8O4nhsl2MSzYnoPJwwzFDv0kz4f7yL6P0avLBAJfkV18vw+
 8RzBlWvMzWGZuh/bNeGIARtsum7iDNQWXpa2o12DW7+aF7RZGKnYsxBx/WqPvHAD0wS6MF/tuM8
 BBrY97dGOKNiKZgHs+BseBps0KqwGbUA9YvwIw5iSy4b4qbg9OsCF/SV7UTjw3AFT/zmogqOW8m
 yTOr/Pu3CFrlQWjAMRtLBG8i3zUZFzduYbxI993QmlHNhA/6XLMQcxpvzU3P5HNDCRTs3OaS5px
 sOLFfTLNFNI7PtJlV6drMpTvmGuXaa+toMwAPhAMLlFCZPuF1C6K3
X-Google-Smtp-Source: AGHT+IFO1GSbAuNHuG3Riyg4mq6BpcUTTxud1+M1lxjY4Cf0Own4P7xDvhPIV8VqjXnyHf3Uhj1lWQ==
X-Received: by 2002:a05:690c:708e:b0:712:d70b:45d5 with SMTP id
 00721157ae682-71b7f437748mr59311697b3.33.1754185244442; 
 Sat, 02 Aug 2025 18:40:44 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a6031a1sm18753227b3.86.2025.08.02.18.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 18:40:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/11] target/arm: Split out gen_wrap2_i32 helper
Date: Sun,  3 Aug 2025 11:40:12 +1000
Message-ID: <20250803014019.416797-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
References: <20250803014019.416797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2b.google.com
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

Wrapper to extract the low 32 bits, perform an operation,
and zero-extend back to 64 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bb92bdc296..64a845d5fb 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8231,13 +8231,18 @@ static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
     return true;
 }
 
+static void gen_wrap2_i32(TCGv_i64 d, TCGv_i64 n, NeonGenOneOpFn fn)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_extrl_i64_i32(t, n);
+    fn(t, t);
+    tcg_gen_extu_i32_i64(d, t);
+}
+
 static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    TCGv_i32 t32 = tcg_temp_new_i32();
-
-    tcg_gen_extrl_i64_i32(t32, tcg_rn);
-    gen_helper_rbit(t32, t32);
-    tcg_gen_extu_i32_i64(tcg_rd, t32);
+    gen_wrap2_i32(tcg_rn, tcg_rn, gen_helper_rbit);
 }
 
 static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
@@ -8293,11 +8298,7 @@ static void gen_clz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 
 static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    TCGv_i32 t32 = tcg_temp_new_i32();
-
-    tcg_gen_extrl_i64_i32(t32, tcg_rn);
-    tcg_gen_clrsb_i32(t32, t32);
-    tcg_gen_extu_i32_i64(tcg_rd, t32);
+    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_clrsb_i32);
 }
 
 TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
-- 
2.43.0


