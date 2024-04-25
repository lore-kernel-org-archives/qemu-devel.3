Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C64C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWN-0001xo-6Z; Thu, 25 Apr 2024 06:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWM-0001x9-0q
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:06 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWK-00070Q-46
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:05 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5194cebd6caso901880e87.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041602; x=1714646402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UIo/4Y0jCkZhZbVf1z/K9VYt8JNRKmGPNz3rHCYkyTk=;
 b=kmTUlo5n+PIezLqs8wHwqp1IlssJuLBtzASP4yPrLIDef8U3c6B2HG2l87/eVRfJJf
 Ns1efYXazFPpvydnIHlLG9LmeR7FyXH8T7Crg6gMqcUeguT1AWL7vdVO2IesoiheH/X4
 LuFUh/jzEMURxkL4cBl/ecbS8xeJTCX8aWbAbToAH1akgLaAfWVI8UGF6gSHP701ToSj
 J6GP4xK7zSXEEQn52kO59K/Dz/l3MtU/5GcEgHB5DCSJa422JEj5VnANNEuD3gnSCHDi
 mvTqTQwIAymAGu/roljDqVHGEW4UWx2FmzoQWsH49HysbmAup0UPgzCJBF42y4zFBh6A
 /GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041602; x=1714646402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIo/4Y0jCkZhZbVf1z/K9VYt8JNRKmGPNz3rHCYkyTk=;
 b=Y0A731qTbU0hhC3yuzEZ2Kz77WX3PxL3Hs0ufhnnR0U59TfTEkYTyPtISikYk8ioCs
 qlYjxvto7DK6gCll8oyV6DIgB7JhArs/rpEmIU/TO2Ro1RNQwZOlIcmZmB9rEpJc0VFA
 VUjV5u0038ky/OuTAU2AY6XtBpZpWxGJ95Qtfg7z9hm1rsaeQrcB8PK2IHAzRDIVe4fg
 9ZngXROAPN7qB275YNa3QTS3LYUcGdeX8FEdOfM/uzi+ppezyugWmH3yEr+Uk58FoU5s
 tuCDkpoVi+2fUR0kGTYex70ywJUXVzIO5JLIXxAzFBMzQjGnL9BP2mZtywWzvC1wWcmk
 ILEg==
X-Gm-Message-State: AOJu0YxGruwP8cL3vVodNEN0YBXpxspbCLXyHI7BwZcyQTP10tFmIiP2
 xL/pcZcDhEQtVXnavbcRVPNCyebdeLEYnRv8SuFbhiM2sE/49WM+0VkMDKnVCc5wgTQcfAABMl8
 x
X-Google-Smtp-Source: AGHT+IGIUXUfL8ed/1eQi8VCDsq26Ev2gMqoSW7iJUd273qsKnkkXDALYoppPKazDECXEm1E2urHKQ==
X-Received: by 2002:ac2:4984:0:b0:51c:3e9e:98ee with SMTP id
 f4-20020ac24984000000b0051c3e9e98eemr1261876lfl.23.1714041602293; 
 Thu, 25 Apr 2024 03:40:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/37] target/arm: Add support for FEAT_NMI,
 Non-maskable Interrupt
Date: Thu, 25 Apr 2024 11:39:24 +0100
Message-Id: <20240425103958.3237225-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Add support for FEAT_NMI. NMI (FEAT_NMI) is an mandatory feature in
ARMv8.8-A and ARM v9.3-A.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-4-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dd3da211a3f..516e0584bf5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1229,6 +1229,9 @@ static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
     if (isar_feature_aa64_mte(id)) {
         valid |= PSTATE_TCO;
     }
+    if (isar_feature_aa64_nmi(id)) {
+        valid |= PSTATE_ALLINT;
+    }
 
     return valid;
 }
-- 
2.34.1


