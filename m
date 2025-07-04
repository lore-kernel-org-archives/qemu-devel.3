Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE309C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXi8D-00026K-8t; Fri, 04 Jul 2025 11:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi87-0001z1-CX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:14 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uXi84-0004cT-TI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:15:11 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6fad8b4c927so10757486d6.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751642106; x=1752246906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NElkJwQRf1CyYZ1pLfGMEkRff1YKnUUmnNhqdv4yZE4=;
 b=cWIjx3S2POrzVWFa9dGbOP2QypTWNjAtygi7YorlrMijQVCT3kkQ8mRWtaAXfj12FZ
 dmpG1xDwOXxppj0+G8HcQeOELAIa5OyRPNpocTEndNYpantT8t5URCHrY5lU6jG6W9GM
 2p3IkFmgCys3btypC42ubSDAaigxDZZezj51b+8yKOPfEW8nzzBzL9h9KBHIyJ/Mg20a
 EIRojsVybR/k1Y8Q/QwNVPT8ZFEs+SpnF6kHY1owNy72tManS3uW4/3FDh348bPwgl2M
 8H49jL5d/ulh068F0FXjtPlgZE/86lFuZV1poXY3vRRM6/l9QcSAO/Hfic4uSIr8pohI
 SE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751642106; x=1752246906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NElkJwQRf1CyYZ1pLfGMEkRff1YKnUUmnNhqdv4yZE4=;
 b=MH/iH0MheCdPbxElYMlUo/SCdJCWEJ3zpdpqC+gaXe5pkFHFogyJNlNNKSatXmahz3
 Z29rut5HnTfX9qS8vSPglxN2ModozJeYDW5Wp95iYVk85ZE/VdpqHYrOqZsyTefqorF7
 9g9p7UisOlyrQNieXQNndnw6XuO5kMdFdYoRjuiMwMnM3QcCm+6eG7Tp5F423M3TvjuD
 OLOZWxrgfIPabMVjFgKbhPr8P4OPtmcCjfg2eGh1mfTIHqb/WZ804WLv0zLxsAIe6E/e
 rukfzcAiWjF3MkaHsxVBUppo3C5Rabn/1I6jmML9+KIkKzLf4v2UIvLcTy9Tgrl2PNSo
 4Z8Q==
X-Gm-Message-State: AOJu0YxrA8N6QuZrEE14zGl7pX1cly+iiV3UhaGHH6oFmgNYgadCU5Nr
 9c9uou/V7jYurIovmzDCelUv5oxeSzb3iyrwARwCInPWtm4QXtr88JWqR97RVE8LQY+fEcJSzzP
 19mDR
X-Gm-Gg: ASbGncuyLBO2NhL5OkiTm+jfQhqUtXXcd5rtb5K5vQzkNsaOJ1epSu+v/zsiVyBn+9S
 X0AaVIwnPXrhETOcvwHTNDR9QeC4FfBmgydgq3hhLsaXPiBkkKqBaOs+53P69bqxxNZYATN5d9a
 xMwJjbLZzC6U3wCPk/K+jIV/GMXMGAkBAA1hq1qqz1z927qeUjOd8mXG04yHBvOS67u6G0bdYWT
 FmlqSsCBgplJVAhLbe4yXzTwkjKbItJUgbQAtc01fZ53YC3WCfshEM0YCAaTdM156Xiir3ZpzNx
 0ZKHafHXZbWxo2QBLwLr65pHMRQrofiHgFwDFpgfAPGuwAd8Ilgwv+xC6e9UafObKQA=
X-Google-Smtp-Source: AGHT+IHbzxQh2U+33z2cIAXvHE/qRdlCtc7FLiLSRjUktLxqC4c4FdKRLsSj1Z5+AZRfY8CCcMrguw==
X-Received: by 2002:a05:6214:1d0b:b0:6fa:d976:197e with SMTP id
 6a1803df08f44-702c6d8c788mr38540696d6.33.1751642106295; 
 Fri, 04 Jul 2025 08:15:06 -0700 (PDT)
Received: from gromero0.. ([189.110.24.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d6039fsm13658666d6.111.2025.07.04.08.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:15:05 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org,
	alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [WIP-for-10.1 v2 1/5] target/arm: Add the MECEn SCR_EL3 bit
Date: Fri,  4 Jul 2025 15:14:27 +0000
Message-Id: <20250704151431.1033520-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704151431.1033520-1-gustavo.romero@linaro.org>
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qv1-xf36.google.com
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

The MECEn bit in SCR_EL3 enables access to the EL2 MECID registers from
EL2, so add it to the SCR mask list to use it later on.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 302c24e232..8ce30ca857 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1683,6 +1683,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_TRNDR             (1ULL << 40)
 #define SCR_ENTP2             (1ULL << 41)
 #define SCR_GPF               (1ULL << 48)
+#define SCR_MECEN             (1ULL << 49)
 #define SCR_NSE               (1ULL << 62)
 
 /* Return the current FPSCR value.  */
-- 
2.34.1


