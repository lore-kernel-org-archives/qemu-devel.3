Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C2AC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHS-0002lt-9l; Fri, 26 Jan 2024 09:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHN-0002Tk-Bg
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:01 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHL-0007zn-LB
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:34:01 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3392d417a9fso239941f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279638; x=1706884438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C5S28rdH5ZOgcnO36OWOW5DPAS8PCmcDgoLOzpGvQH0=;
 b=VM6/jWRY2nrlR6dvjufh17JM0zp/0CxemEYfEmKj7M9Pf+AooZD0uQBW0YmIQjUvM/
 cPLSYBbAqk6WsPBmnpdiHG2gNI2+/TxW1Sh6iISJvlyZhKN3NQgWd4bZOTrzKs2n3kWS
 Rt0uN1z++z4hOV8UUhSjhGImHy38M42CpKB/tX0IrLx9kM5PCgf2wiltP0OS/QmBB1Kx
 WQMiNJY8ZzhChFDlf3JjL3T8VsMAAxWVfoWeNmHUB6dItSCQb5++M+xf4Ekhhzz5tuT2
 NZOPRXkGBHRjyDfMm3UQh/aAQg02XL3Yq8BlgToT3BPFdKm84qb61VYGls7ERJWCwhJM
 bzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279638; x=1706884438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5S28rdH5ZOgcnO36OWOW5DPAS8PCmcDgoLOzpGvQH0=;
 b=l1Zfcr+w40aQF0z4Shl73bTL1301rL/qEwu2cTpWoQ/0GOdxvI+hJFSCzDwVgq0vnX
 8R0sBbbkzzZ/sdVCIsyUvB/1Uy8t6YuUClPqGbAUhBLaxQEK37WnXffLfr4NKSC8TYA3
 w8lwQfztCLZaYpbAA62h9xClm/2RHkR8BVZPS9+7a5oSGzSa1md46utNgFfaa9rn7u9v
 0rPdWu5Q54sokkYWXz+QdtfNP7kcou19iTWuua30IQe328J5ymztjMITkhhCRL8ORkBx
 uX1MFjHx5fUxyDm+uAQhy9EWAd/j00GUgTtU4VlfrBrOlOtFU2t+JlZgqjrq9OxnYa+Y
 qYjA==
X-Gm-Message-State: AOJu0YyY5bEypoX/LbMpeQrA35K3SZr4FiEEzAgQnrzYYwG8Ta1Kf4NL
 TBxDxjZr0SpLlMhM8Edp0fLsO4IcEwXGfgmqkGqYbLZBJAlMKLheya9d5jrUkQrlZ/aZxlfaUhF
 g
X-Google-Smtp-Source: AGHT+IFHfcslRv6yflytRnCHgtutM2iAyDyWyfUpzvJOzYoWtDOD5yvb4pFTxs7dwV/MddQjv5QG1g==
X-Received: by 2002:a5d:4ac4:0:b0:333:a28:bfc5 with SMTP id
 y4-20020a5d4ac4000000b003330a28bfc5mr1401960wrs.70.1706279638409; 
 Fri, 26 Jan 2024 06:33:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/36] target/arm: Fix incorrect aa64_tidcp1 feature check
Date: Fri, 26 Jan 2024 14:33:40 +0000
Message-Id: <20240126143341.2101237-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

A typo in the implementation of isar_feature_aa64_tidcp1() means we
were checking the field in the wrong ID register, so we might have
provided the feature on CPUs that don't have it and not provided
it on CPUs that should have it. Correct this bug.

Cc: qemu-stable@nongnu.org
Fixes: 9cd0c0dec97be9 "target/arm: Implement FEAT_TIDCP1"
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2120
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240123160333.958841-1-peter.maydell@linaro.org
---
 target/arm/cpu-features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 028795ff23f..7567854db63 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -773,7 +773,7 @@ static inline bool isar_feature_aa64_hcx(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_tidcp1(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR1, TIDCP1) != 0;
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, TIDCP1) != 0;
 }
 
 static inline bool isar_feature_aa64_hafs(const ARMISARegisters *id)
-- 
2.34.1


