Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9C2CDD57A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwq-0006au-KQ; Thu, 19 Sep 2024 09:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwQ-00056x-Uj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:26 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwK-00012Q-Vq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:23 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so9237331fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751478; x=1727356278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2wdk0UxISnpYZXSzl9mBlpBWDXNtfPgycdSZ7wgD7Uw=;
 b=iiequgpRfX9UaZeMfSpgILz5BOu2vdRGDPb6WZG+sOq1Lihgh3T+WoA8p+7PSufs3I
 02mYw6PSMassPp/vHAIaDxMXxVhKxT1hwK8hbmNI9s7i1VPeOzsYZjtL+8hvCfdeGVBw
 8epaTFlLdRqO7f7dUiEgQS88qlK3wP4YeKVZggNSrW2OC7OU5Qtf+XQ5Mwhaze/r73d0
 J5hgL8luLyF78erqQ9emJSeGYoZzxKs+Vm/h32TSONhDmYikFWwB7VY1FHT+JtFr4zPX
 HQRbp2e3LRky1sStgupXZzALXWzT1TJwESRE6XBz72OfPM6gnYwQbRh6p93OKkqxVvG9
 6bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751478; x=1727356278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wdk0UxISnpYZXSzl9mBlpBWDXNtfPgycdSZ7wgD7Uw=;
 b=th5KCLh/oYJhdviOXQxMOmPoGlyMWIArvsiDjXqnF3XqGK7ARnrCKxFDCkfivETWDx
 vOvVEiM8vlTDvpn3a7bSbZCMvAFCp+eRyAcTZhdEtBFyAoXMFYPCXOuaMP1SI3yJQbT3
 TmFnSw8uSpfygPAbJozvyv3VZ0qsiU57bR8iv7pFmL/B6dUxTKyW6Wh3zvu6Ix+V2tD1
 q9TjyBaagiHBFJFXe++vaSxbBpbm2z8CRHVn4ptP50LMtg9CSnMTX8L08EEffD4D32io
 M5ZuPVY/3oojAEdVAZTiZftuoQKlv11pGA11ddSYipiSQBrPVV4JzPbcbHYfK2zK8w4g
 oSVQ==
X-Gm-Message-State: AOJu0YzLUibAkVo6wV6+dAWViUfPGj8WslNGkH+bRd8ds/GBiYwTR+G4
 4iVsfkGc0iDsB79dbSjPBN6Vmc4GC7hplXMLcj2EhazL6DKnfmawTvxwgXWLsciqHEaPvCbEQMB
 1
X-Google-Smtp-Source: AGHT+IFy3revvNyCWgxsZE5y05HkzWzNBDjN3JB3viSpfTRHSfNtyBHNnvRv6ocVeena6qwPtphtKA==
X-Received: by 2002:a05:651c:a0a:b0:2f7:c215:4f33 with SMTP id
 38308e7fff4ca-2f7c2155066mr20428091fa.27.1726751478283; 
 Thu, 19 Sep 2024 06:11:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/38] target/arm: Use {, s}extract in handle_vec_simd_wshli
Date: Thu, 19 Sep 2024 14:10:46 +0100
Message-Id: <20240919131106.3362543-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

Combine the right shift with the extension via
the tcg extract operations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1225aac6654..740620074ad 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10477,8 +10477,11 @@ static void handle_vec_simd_wshli(DisasContext *s, bool is_q, bool is_u,
     read_vec_element(s, tcg_rn, rn, is_q ? 1 : 0, MO_64);
 
     for (i = 0; i < elements; i++) {
-        tcg_gen_shri_i64(tcg_rd, tcg_rn, i * esize);
-        ext_and_shift_reg(tcg_rd, tcg_rd, size | (!is_u << 2), 0);
+        if (is_u) {
+            tcg_gen_extract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        } else {
+            tcg_gen_sextract_i64(tcg_rd, tcg_rn, i * esize, esize);
+        }
         tcg_gen_shli_i64(tcg_rd, tcg_rd, shift);
         write_vec_element(s, tcg_rd, rd, i, size + 1);
     }
-- 
2.34.1


