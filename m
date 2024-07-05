Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B661BC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku5-0005lZ-SM; Fri, 05 Jul 2024 11:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku3-0005j4-SV
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:15 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktw-0000RQ-V1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:14 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a77cbb5e987so99699866b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193466; x=1720798266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpfNv2j1tI1/v38krNO8PFDL7fPSKpwptFmGNLBYEoE=;
 b=ej3zdBcfzH/zSAxOhJFma/V29bxTzJiF/+09GrVFfD8bouleA/YCPAgg+YSOtq1obR
 ubIInOeDnoEtXdc5fad11x6OpCRVYwpdfJup2HMoffLISncwZ7yScM92vbTcyZ3nWDL6
 PPnLZbRjOjUttXy61hBPCp4zTA+EjLujNqM1C8taMGJ3cKmIndHh6472AlRRIK6J6nX5
 EiQKZgiS4pGHaqdtCMbiU3Gs4RXLfHBdJXtANm1vXIB5G8fiMJ3Eam+wXAioU3KAwmuo
 n3kDstTcvdxTz8+t/YfdCTD5D0+J/2Ycx52V5X7eLBIj7MbMY+jCfVykISS4ql/WhSCh
 8WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193466; x=1720798266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpfNv2j1tI1/v38krNO8PFDL7fPSKpwptFmGNLBYEoE=;
 b=iRku91COMWJSRzWbZkbRIdYtbyADy1jzY/JuJgPSbQwLegJhC5tQE4kETVKDJcFCSF
 NOIVPw4H0VoooIUnUf4qz2HCBFVwJxn9ilA/NFI4zPneOkM5wLm4MUoI+GNHL94ANTEq
 exwKtc6LW3mJeW+e9tgoh4td8QHwloX0zj7/p7/IrZCVdik+HylbQnXEZCHtVFGUyR85
 msQTM27tdcuIAf7WUXWFYukxCeeg2jJmh0YJFKscd0WcyjwRF1fdm/SYcmawe0HOspfE
 2wnuZeF4ZKehR1dBn3Lsix7kQpNFKYOTvP16MCxErqnsJhXRV7PXZo3VGwKFWI8Aj/Gz
 lniw==
X-Gm-Message-State: AOJu0YzPc5+CztL4/gPzg1BPalZupy0flXz8Y6HBhizxE599uOd6DyLU
 /RvIwAW3gHUsVoRwd1XO3fxbzrKIoh5IbZx3/49/q5Le2V96XeDvlDYJNeWTBjo=
X-Google-Smtp-Source: AGHT+IFktobtFQF7pXq8M8MB/zRklhx6L1bZLUudQVSQNGTyOtiiGg+8aBxphxOzxduoqOoXb3IEdA==
X-Received: by 2002:a17:906:494e:b0:a77:cf09:9c70 with SMTP id
 a640c23a62f3a-a77cf099d0emr113404666b.43.1720193466149; 
 Fri, 05 Jul 2024 08:31:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77d965dc4asm37881266b.87.2024.07.05.08.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A26546211C;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 17/40] tests/tcg/arm: Use -march and -mfpu for fcvt
Date: Fri,  5 Jul 2024 16:30:29 +0100
Message-Id: <20240705153052.1219696-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Clang requires the architecture to be set properly
in order to assemble the half-precision instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-13-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-18-alex.bennee@linaro.org>

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 95f891bf8c..8e287191af 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -29,8 +29,8 @@ test-arm-iwmmxt: test-arm-iwmmxt.S
 
 # Float-convert Tests
 ARM_TESTS += fcvt
-fcvt: LDFLAGS+=-lm
-# fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
+fcvt: LDFLAGS += -lm
+fcvt: CFLAGS += -march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
 run-fcvt: fcvt
 	$(call run-test,fcvt,$(QEMU) $<)
 	$(call diff-out,fcvt,$(ARM_SRC)/fcvt.ref)
-- 
2.39.2


