Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6F1E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnI02-0007yW-Aw; Tue, 03 Feb 2026 10:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnI00-0007w1-AY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:28 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzy-0002R4-QL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:28 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48069a48629so59560085e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131245; x=1770736045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X5Z2duohm6FpVj961qM5fTcwUMs49OrZr5pUH6kFnME=;
 b=XwsXCnsZ+J12HWwIMbHlcBZJ5QhgEwkDPubvQz0oCClQ7/GDemNc/jUFFRibA5Wtyx
 YglT8aeONlYqqerywOSBeBHeoCwrVTjt3gAUa1ukzQDI/hSOaD1mB6EbK1qw6y4bE92Y
 d29/WMJmlZMYEuRvNqcHRAJs4FFFEbZGnq4nDFYZtY1UP3Y1/UuLp6AYq1YCJfBJIgf/
 PhMdqmdBvQ3U6jNDJgK6B99fsOM59iC8EXLF+zZVRFD1QJ/74XOE0RocaKpap9Oj3csk
 A7rr27t9/rXE2WNVO1YZxibeYFmmy83Gk/inuo/NdfmGUyqtqEO/AbeTBHyKzR2uYcpQ
 WOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131245; x=1770736045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X5Z2duohm6FpVj961qM5fTcwUMs49OrZr5pUH6kFnME=;
 b=m1pM7UTI/YqLlVNyjWMSz8Wb46FdtjSTBDQdBmylNiWBBFqx39m1fU9bp+rUlSIp7X
 AhLDrRyh3zkguBOEFxwZDzCWNILgMC6q4Op1kaiAtLcPC4+2KUANiVdGACcoEIMJUZ3A
 9rapIMXLCsdPfQxEiYA2RPmgMsvdHOn2bHagVYgpM8gKcdQkr4u60EpYriKQl29zSbXw
 dDt2q2gwuzv0BEX+5Hr0uIAKjTZKqvbCu5Rdb0WKvxIlCmWS6UlV8awUdZVq4k7rs1u3
 M8e235V5ZXJTTcx6OAIhDDSrFiN1yq+nEkqvLOWE8Mul0r7ipvzfrplvsS3Zv5ijhCPS
 YVYw==
X-Gm-Message-State: AOJu0YzmACM5eL/tmsbi2Fg1pXQevQCviO7A6BIsnHRmH97myAjk96Qw
 rVfAl6SLfld5+pZuO/o3qY2vnNSkliVMfMYuCl1wd8o0Y9alVO2NRVwkjbfoWeue8akRXM08KQV
 qdczkNOE=
X-Gm-Gg: AZuq6aIn27P7j/+f05ymjEAFtr3COsILGsvuOURXFyVs+ofLiBtem7BPkO5eyFXaVdG
 alcxv2hAdp6yaBHbuKKFPTl2aHJO3hwa1525n//xK7+QFCVxgx9hEJAwTXtFm5dNWRp/naUnkoC
 mBLO37cATGBdO77LS9eFGKSF3BhXcC6ULXGTb5Z4f0bWn3RdkHKjN5BFRICt9bUH1z87GZl/D5+
 0P7v0fWKvsHOXBTaD7M5/4ei5cjAOwdMSJFKn85gYxHhvUJXZuEXnJ+7inSKDtrg64ZmVJ5e97E
 hyLGSwe/dpVTyiim6cOC1Io6DDjH/JphG4MT88jF5QQUCWUcxdEVoM+sFznKqFhzeq4bh06R8Yh
 dKtzn1J/89Ny/ZeI8xzhuP41GI4z0eFFh6rzsvy2SLEDY5hWjzSh9BnvW8o6exIwZO6+h5/WL/A
 XCNq0f92ICWYWSezAGRFivBHf+GSOfFXb8jo6IWnh7vUbq8comkq+Pk7LAvJxe
X-Received: by 2002:a05:600c:1385:b0:480:3b4e:41b8 with SMTP id
 5b1f17b1804b1-482db497d9bmr199801495e9.33.1770131245013; 
 Tue, 03 Feb 2026 07:07:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051287cfsm110145175e9.6.2026.02.03.07.07.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/30] target/arm: Have arm_feature() take a const @env argument
Date: Tue,  3 Feb 2026 16:04:29 +0100
Message-ID: <20260203150436.71907-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

arm_feature() only access @env read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202222412.24923-2-philmd@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 21fee5e840b..d4a146b4202 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2140,7 +2140,7 @@ enum arm_features {
     ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
 };
 
-static inline int arm_feature(CPUARMState *env, int feature)
+static inline int arm_feature(const CPUARMState *env, int feature)
 {
     return (env->features & (1ULL << feature)) != 0;
 }
-- 
2.52.0


