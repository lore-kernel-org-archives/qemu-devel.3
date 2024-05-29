Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C710AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLek-0006au-At; Wed, 29 May 2024 11:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLei-0006Zm-La
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:56:00 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLeg-0001Co-Vt
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:56:00 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f462so2559353a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998157; x=1717602957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4dLkWGEawEKJGEPvKXN6qkpuzPGuxO26xPFOndIqLM=;
 b=cJO6GMLQWb4VSSoPokA+HXV5M/LxallDnFikj9fwK2BhEEz0g6PqSPzOeiih307j7W
 5ubcw+VvA73LDJ5bm65X6S1uooB4YNsIGCSSJddXbqjkYrA7Kb8dR4K7Pe5r2WaoMV3D
 /rJfR2Ahxmzj7Ey/pMKcQVI3f99pavvVBRBkaVQ2f5nytd03tlbrw9RhwMtQwrmJIWuj
 kI2tuoUtfL3Gw5qhwN84oosRqTD+p8Z3BpZdlPPfB74UyrLLztMUriIz/0Maxw9iQRpb
 JHzWK2o8H7xl9/AvqbW8G8e3S9nPH05WL877MrkY4MwhaANL642N+PYY7qkJJ+GUjD2F
 VvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998157; x=1717602957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4dLkWGEawEKJGEPvKXN6qkpuzPGuxO26xPFOndIqLM=;
 b=HTEJm9ObexHloIEbPpSk0QOOKSUza6ePqTsLgR7UrMuiVzwftuASqPnEFWRv4tRuHc
 KUiGKnC80aaxvr57t2g4RrfilPtnJcA2bpbgg4sZdahSSeZmrQ9nsMP5xOi1u8jmgVoG
 lpj4adFTV4JiGmj3g1fxsFEfh6MSbpc4qbXbqOzWwu7npicOe8qhQzt+CpFKgVQKgzTk
 sgBspqPU2AU6jGGDsWGKSQpjViM0P580vDFnnIhZyjXQ0zXqdNOWD82fU+qei8szuse2
 R6rsW36cODCHAq5SANI/CuiLjMOxCeFxLILCRsidMgITq1yaSrOfH6hN9Z6WCxZ6j6dt
 Kd3A==
X-Gm-Message-State: AOJu0Yzwc1i9TgnyQNnZ4zrwzBujFgxaf0VNRvQ8YpGMKyog/Wea8TED
 yA3TMgLrZBcU+UGAdVamuoHD//z0Id5Wh2JrO9go0AgZ1IztFDLi2fZzkKtBrfkK0+FeGpD6AXH
 3
X-Google-Smtp-Source: AGHT+IGu/nGXJeG+xpjODewbrqqvFG/mF3UbejcscizHFNpMif8xfoHQv0JMTZJJGW+TsfeVp1f6mg==
X-Received: by 2002:a17:907:944f:b0:a63:42b6:20b7 with SMTP id
 a640c23a62f3a-a6342b62102mr465078866b.47.1716998156609; 
 Wed, 29 May 2024 08:55:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc50064sm722028366b.107.2024.05.29.08.55.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 May 2024 08:55:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] target/mips: Restrict semihosting to TCG
Date: Wed, 29 May 2024 17:55:46 +0200
Message-ID: <20240529155548.5878-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529155548.5878-1-philmd@linaro.org>
References: <20240529155548.5878-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

It is pointless to build semihosting when TCG is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/Kconfig b/target/mips/Kconfig
index eb19c94c7d..4918fa42e9 100644
--- a/target/mips/Kconfig
+++ b/target/mips/Kconfig
@@ -1,6 +1,6 @@
 config MIPS
     bool
-    select SEMIHOSTING
+    select SEMIHOSTING if TCG
 
 config MIPS64
     bool
-- 
2.41.0


