Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D71CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNva-0005cE-Vx; Sat, 30 Aug 2025 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELs-0005uf-VW
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:14 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELr-00048e-4V
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:12 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32326793a85so2258263a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532530; x=1757137330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PO0Xi+l8mZtLQEAvQVUzx/DN6qW1/Pe1V+/XNJEzQZI=;
 b=Fv467NqED+pXqVgiroRex0xtxdjAlZVsomwWpMBzYk4+eEPtMRcHtce4weCLRFTUpO
 P6ISggIayeE6k35M0YeYWx8C9/VKXFpUyR2rh7aY4GzNgD9ARUb+RNZOl+GsQWBT4Oci
 4N6k2Dkjoo4OMp477ichb/TYoGJQvHd4dX0dvpp54wPVRzQ5VZQ9jl3DsVR+pLBw5cK9
 g9plPm5hhKSC8CB3ppnehKXGStyOwse4raNN7UIqXNhTKDbpyr7tQdQwXPnX1VUXBW0x
 QCg5osFCNoY6qMb0jFFCdxMRXXx+WnaVcKaLckH5578NK1LSayYGNiMpzif8CS8D9gIt
 CMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532530; x=1757137330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PO0Xi+l8mZtLQEAvQVUzx/DN6qW1/Pe1V+/XNJEzQZI=;
 b=aw/LIbbjq9h3YcqtZoR8WQPi8o30irx/XIytfjAUJOIjkexINeOfJVTjadc8dzSLaQ
 Vj3sVjDfQ4ZMEYKEbWsNoIYTdt2/VnMDX/Xc6DuCx6go6L+AIpcNoYN9c1WgZgDjs/No
 huaOSSnRYnpJWhHqb3Vqakdeu4XfcG3CQBqdLkMp3IWpm0e79q2rpFqX+/8eDXQYhY4B
 mg2MwNtFxgYV8wVJl1CC8hFmgJrmrFK5cY7ms5mKg5W47W1waoesjCuIyfTT8RFgj3dH
 5rDEZ/4ZM2NrMX0jWzWqTibTipvE5a23dHKvxsEPu3x62saQi7XKU/bSyncEgZmvAdux
 YTug==
X-Gm-Message-State: AOJu0YxLTPyyb0PC6N1SXFHkiqmCtRc4lKJjK//4Qq9rznuc4aDnt/dM
 paDW2Hn5GPElFhBgXJKy42u6I0JBkh7N2Jgd9hwKqurQkiMYdIgkadTdcnZmf4SSMkdQQZzbA8x
 ANFrwi8I=
X-Gm-Gg: ASbGncvafsFiRHjivmOanq87ZiVet48kYIm4NbSyfF7H5kdLirGBgx1awbG72jXu+y6
 uNeIw8A8K1WPrnqy/CeDqnlf7FpQ2hrY+xPI6yE8EBmt5yZG6y6jV37uVKJIqIrfuh7xvFUYqFv
 IqiaLtMG06Iw5qsOghPdrXxpFsuyGeg1tlFJtpQL4zH+GGNy4PX9qFDniEhShkfZKn1JzqSe7wc
 GNRKD6HKuNG4p8uY322igqMyQYskTsMg6gY3lgyVKv48ckgzlKRItopmvqICnLAmmJ1SGqzABk+
 cwcuoJbr6pIyKozT6ItB5eOt4G5YYx6hgQazqoq2T9FwXfrMKvWipPpBtTz0p3PO+D7t12jpHu9
 /8DQDaK+jXGMCsWl4aXYrQc8ZWEyCOR52BRj22H5cIZK4Scz9626HyDiSCB0ErcvrZMoWwco=
X-Google-Smtp-Source: AGHT+IG6LqGDW+Tu16Mn6qUou9tbcXB+xr5QmjF/O27a6mSLPa34/LZRDg6Z6SpIC+4g43EKA1dcHQ==
X-Received: by 2002:a17:90b:390f:b0:324:eac4:2968 with SMTP id
 98e67ed59e1d1-328156e46cemr1727157a91.33.1756532529887; 
 Fri, 29 Aug 2025 22:42:09 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 13/84] target/arm: Add isar feature test for FEAT_S1PIE,
 FEAT_S2PIE
Date: Sat, 30 Aug 2025 15:40:17 +1000
Message-ID: <20250830054128.448363-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 512eeaf551..30226814bb 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -929,6 +929,16 @@ static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
 }
 
+static inline bool isar_feature_aa64_s1pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S1PIE) != 0;
+}
+
+static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
+}
+
 static inline bool isar_feature_aa64_pmuv3p1(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64DFR0, PMUVER) >= 4 &&
-- 
2.43.0


