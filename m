Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71753F9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUXt-0006v6-7u; Wed, 22 Apr 2026 06:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXl-0006pO-1w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXh-0000iQ-WD
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:52 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so52303525e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852648; x=1777457448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
 b=fzE97kJz62CgSTz+ZapOg+VcESMiBRuzcFh7RGBaaV0/sxCEOi5vuaDucca///vvWD
 AX/Tm1ZlAsrLiTs/up9dxB9d6QeZnUJi7vhCMXg1XluRVypGJjx/Va3ekd8mfoDWlZDI
 9I5MBirNe8wF2sbL2YPchsOfHzi5fVjzbcEN4JdvlG+3feJuqc89oPb+l1j0maXdVAcJ
 xu/yqkqksdBTYN1k6SyMVKwjBO8kFY3DwStJiQyYH2XKWsrczSVwOifUtVZ0vJXPIZYh
 ameJwrKNy4IEZUUQORvZPH29vG2+a9UPUKt2NG+fGYuoVyJ3mDw/d/5Zx6UVFuL7Ezb0
 06BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852648; x=1777457448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XRTiu65oEEP/NVXKQGmyzqv/GBntii32+7VLEeXU9Tc=;
 b=XZhOnuRnxVoZ6NEvtlwCj4jUhIAsqRhB/RXgbczBG3GyTyx/xgudkh68hN5YfNeX2+
 sjrW8osMaGGwXHILotZ7MJaN1rMPn/GcrWTeCKcaZtc6MnvAf8bw29psJ4k6ORrCgJxM
 pQoQUmBviR3E4F4AU0xOZVP28caZo9AdM42gCpaTg9DtdJAx3EgXfmFXZyi8NLgHAZX3
 PC5/7Yx/MkEY8WXWQVpVrbEhDb5NJmH8Ar3yKWs4vpu7iZWgNDlQk42jrQcIcVIk3mj2
 y7zIh52kZwh+r0upuN5G2nnzPkVFbUhNkLPO9edyfKTVJBAFcHwOBQw512vLb68o6sGg
 dOHA==
X-Gm-Message-State: AOJu0YwrwNGnK93vMLcwE7HEWDpU/Q13hmRZrUzGEEfM1KkZ0IJac0sf
 GGJ2RD+/gLBQTRhinFMxmIB4XVf0cE+UeZgP/W5kOev0X58QpXkZn/w7mUuphXI+1FE=
X-Gm-Gg: AeBDietzgykfpmcsYxjSZBpMSewZkNBfUIs6fpyH1Wxhckp4dYRRZLXc6xSAHUgjc9J
 TQNvzwaDQIRguKR5gjw0+LZ3XIMr6z2LAlcUegmSPy7Wa4CVyWMGo6FBSpwvpasRgXvp7s1XUAg
 0xXg3B+8giGjFxE2DTJO1Nvv9edsNhOZ/IgeYIXobee30ZjJzBXort49fN0WcdYzCg68EKSbDfK
 G5aEbzKuap8edL3492YQjiD3VpdbJ6eLsSH/F2+9nWZEQt7Na9UkLxmAB99b3fK/w8r8oVY2+Gr
 XnK9t4+s20adMB5luRZgg3vmcxZjcGCpDoduv/UHu7HcnCliDLpVaa3BT0u80OK8IrE/73jGT2F
 5FXtZC4ApOegKMC1qCpcPKSc4nxdcIbQ//Nrtt6aMKp7VaeOf7LBf12//Ie5S7+UFDntTnQKKfV
 JJAi4uCKpnFJAX3Aws964as/WH7DYdncY+kw==
X-Received: by 2002:a05:600c:19d3:b0:489:1ae1:4eb9 with SMTP id
 5b1f17b1804b1-4891ae14f23mr171514615e9.28.1776852648038; 
 Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e46898sm46509989f8f.27.2026.04.22.03.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC52060338;
 Wed, 22 Apr 2026 11:10:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 04/31] target/arm: migrate eret trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 11:10:15 +0100
Message-ID: <20260422101043.1234229-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

For simplicity keep the OP as a two bit field rather than the two
interlinked fields in the docs (ERET/ERETA).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 72051443d59..63c8e66ea91 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -367,12 +367,21 @@ static inline uint32_t syn_sve_access_trap(void)
 }
 
 /*
+ * ISS encoding for an exception from an ERET, ERETAA or ERETAB
+ * instructions.
+ *
  * eret_op is bits [1:0] of the ERET instruction, so:
  * 0 for ERET, 2 for ERETAA, 3 for ERETAB.
  */
+FIELD(ERET_ISS, OP, 0, 2)
+
 static inline uint32_t syn_erettrap(int eret_op)
 {
-    return (EC_ERETTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | eret_op;
+    uint32_t res = syn_set_ec(0, EC_ERETTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, ERET_ISS, OP, eret_op);
+
+    return res;
 }
 
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
-- 
2.47.3


