Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EA6C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0529-0002m7-AQ; Fri, 28 Aug 2026 18:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0527-0002kH-VG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0526-0002IL-E5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d712281f8bso17449845ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956005; x=1788560805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/7Y8RdhplbD4Abq8NZ3BtTsO0de2a0oqbAmGeIVel4=;
 b=mB1enHum4woW+m8qtNtKyoo4c9XU8mVVhZMJJUa4beIO1U+sxCdOa23xUA0eCb/8Q4
 cGi0Kl5h3ZzRw6ylGDNeB+NtaRJvP0m70hA1JA067cJHN618KYJC2MsoumTIL3/EASu7
 3dcBmfos4WiY7/6HX/O0WeGOu9zlZRyff46D7LLrJcymOkk+MhNog8mmZYYK116IUfy8
 x2mSr0w3ojV8fJ5C9l9DTTYTbdOmaX1NGT0AaJrt5XXLNvRlImbk95hCZYMPWbzbnlRo
 b36Yj3LV10ZZWvaN0drGK+ciWZAdFl/znSa4sTqrA/QriWJEpL5vAn6gPfnM7rYAh8ib
 /fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956005; x=1788560805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L/7Y8RdhplbD4Abq8NZ3BtTsO0de2a0oqbAmGeIVel4=;
 b=lrNERNLy0hb1h5H6MJV24MS7Trt+pwk/XPrNiitcYCCpMyqztQuD5MbhwolnkcPDG5
 pwLjxJUY6oGl0IrR8BZ2Sg/m0LHQGE2ZRoJ+MHn3VEngtEOEsgxGhtlv7XD9fJbG6r7X
 hIaLUOkvqBiYzLVc1riPAYZvkEsW938Lvdl2qY0hTlIqXW9d7Ri8jqiqMN8ugSCul/s0
 vyZLT1JHMyNmRxqzOfI5Hfz9E9hRmxjLKUg9eVHt8s4fBM47CB3eFl4hIUJVv4oUcADb
 h/CBIGS50cI8lTW/j/pj4MsTrKFlsCuKxbpzYNsiA2hU5ITj2/nG/UQmxOyZN0Nfcj4b
 zA+A==
X-Gm-Message-State: AFuF++lt3t+2u1xkW24yGQ3ySpr/B/IwjubygyW73cIatYx5dU1aK4Sp
 5NhwKjVNDH7A+iD7UFgy7LP0t7mKhK67w+QgYIs8Pl9nWDmT+saOL01jixZK7RqDKzz/jxXHuc6
 ssVTigSg=
X-Gm-Gg: AYBFou14z/xAqK34tPuIDQpJKy4gthmrPNlEPbCpJywCTMrYJegf6k/7p+hwMeOyrew
 CFo9RNlmevGZiNMhub1LP5+4auJE41LzS9nIeraFzdUw0Gg8H1Hg2fthXJAoSdvD2LxrNkPRpuI
 uMC0dMWdBltqmJx0xlLfHha+PZd5qlNZFdA5dozUIYvF8npKs6PB/R4zlwQO6W8Um7qff1IJ34g
 VTn+8Qr3KtGmhKwh+ryddvqCHGuAAespFIXuafhzFc7c6AUKPAOsTE9lzb5knLHyZPxz4sIy6T7
 QMeTH7RpkJe+z5Nd7EOVUY7RbRghg7/h4/NrL/upEnShshPkXvA+362BWimaVQ4Kb71ioLTbkhk
 Xnvw7cb2D9B2lfAEDt+MUHDh/GtxBGKcfdA+Fs1crc/m9EMjO2hiazzozWkCAx4Ki0FboC5UoGP
 iUKrM9H45h49OZCeEG4XTKoL4NNSwfErOfTOVBIAEMig9gI4mzle4osTmAaeNW9XJQtagxaAFDl
 bUgyrpDgoFJ2hcZWvFr
X-Received: by 2002:a17:903:390c:b0:2cf:8131:75f4 with SMTP id
 d9443c01a7336-2d74dee9430mr201795605ad.11.1787956004988; 
 Fri, 28 Aug 2026 15:26:44 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/13] target/arm: Move ID_AA64PFR2 feature tests together
Date: Fri, 28 Aug 2026 15:26:31 -0700
Message-ID: <20260828222639.1432046-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently the MTE feature tests are clustered together,
but those are spread across two ID registers.  Sort the
functions by ID reg and bitfield order, like most others.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 280ead6f9cb..8ec9832424e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1207,16 +1207,6 @@ static inline bool isar_feature_aa64_mte3(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTE) >= 3;
 }
 
-static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
-{
-    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
-}
-
-static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
-{
-    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
-}
-
 static inline bool isar_feature_aa64_mte_mtx(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, MTEX) != 0;
@@ -1237,6 +1227,16 @@ static inline bool isar_feature_aa64_gcs(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR1, GCS) != 0;
 }
 
+static inline bool isar_feature_aa64_mteperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTEPERM) >= 1;
+}
+
+static inline bool isar_feature_aa64_mte_store_only(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR2, MTESTOREONLY) == 1;
+}
+
 static inline bool isar_feature_aa64_gcie(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR2, GCIE) != 0;
-- 
2.53.0


