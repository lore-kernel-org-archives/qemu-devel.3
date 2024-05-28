Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1967EC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUg-0001Uv-Il; Tue, 28 May 2024 10:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUf-0001Tq-7R
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUd-00070S-Ha
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-35bf77ba951so210008f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905278; x=1717510078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=js5qncWkemZbFOUTBcvGMDqOGolfrcRJMq2DK5PGxrw=;
 b=sXX4gy/28aC7T3VCBj8KFmLrXZinqkKJTsHpRbPtz7R+FJ229SZNdptGVtYfW++yV8
 92Zco127RY4BcdqBiMVrO067VXrGHdTBIqlRmqBqE0lM2QKIvqBGG5U+U77fHWqsHDYp
 MO0ai/5GKw36e+kxA4kf5L6Kguf54BOEzJzEd3Pkdfap6dz2tIaOFmkZi/I5S0OCAqV/
 aKtyIfG67Z5dacmapW+m9Uhwn4EVFQ5mm3di8o6kTQqxbUDmyfgzFkSKJ18UjvdgcKIe
 vg2VxFFPudGws5/+d98wjPC+3Dfohvozidlm0DEdB5sCLF8gJIFIFp01Ii6/RLj+kGW4
 WKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905278; x=1717510078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js5qncWkemZbFOUTBcvGMDqOGolfrcRJMq2DK5PGxrw=;
 b=dSxJMO0QZ2tHN7C6AyXFAvAFbEqA1zfcrPH0lHvhasAIRzHtIRBSFNgo6LdZXIUbdN
 GLu0vGbNJvJZZIWGdFj2M7U6z5a0A5fFhuxfpk2+Doaa6v/EXukxTI0oHF1rvHVgFaYb
 qIEEhBI9rF3W1FDrYQC5GhDCQs9oie9TOhMk+XvvI4bDaeE2X2/fvGBQ5x7k+aPQRDkF
 9Wmu5z7bdNaRL44OE33UYbaoL4+LJpiKln0Iz2Ov1SJ4M70+F1APo0YgUO9oURh4qdiP
 mnczmCHXOP+d5VKyFSrG+bSlMdBLNADH81R0TMycjhArnCdy/1Pi2N7sg+CN+OM4SbJO
 3EdA==
X-Gm-Message-State: AOJu0YyMYAEI9xs287x5KaHAZoNlUFvqDrQhL3Z3+Q6QVoC167foZnLQ
 dywPVQKnOxL5+YP28mAUqz/ZkO8IbGyGJxu8Wgz3hUv2uvsVy9n/RN4Nu4yNh2o9UwDmsxpKA/g
 u
X-Google-Smtp-Source: AGHT+IHDpbbNQL4S4FsazvxQtOjWo80Y1YbSx9AqlPUC8vZBYaUKR48E61Ih+Hcs/E1+gxjfM3kKEA==
X-Received: by 2002:a5d:4988:0:b0:354:f489:fb8 with SMTP id
 ffacd0b85a97d-35526c3e2admr8015667f8f.14.1716905278262; 
 Tue, 28 May 2024 07:07:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.07.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:07:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/42] hw/char: Correct STM32L4x5 usart register CR2 field
 ADD_0 size
Date: Tue, 28 May 2024 15:07:15 +0100
Message-Id: <20240528140753.3620597-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240505141613.387508-1-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32l4x5_usart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 02f666308c0..fc5dcac0c45 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -56,7 +56,7 @@ REG32(CR1, 0x00)
     FIELD(CR1, UE, 0, 1)     /* USART enable */
 REG32(CR2, 0x04)
     FIELD(CR2, ADD_1, 28, 4)    /* ADD[7:4] */
-    FIELD(CR2, ADD_0, 24, 1)    /* ADD[3:0] */
+    FIELD(CR2, ADD_0, 24, 4)    /* ADD[3:0] */
     FIELD(CR2, RTOEN, 23, 1)    /* Receiver timeout enable */
     FIELD(CR2, ABRMOD, 21, 2)   /* Auto baud rate mode */
     FIELD(CR2, ABREN, 20, 1)    /* Auto baud rate enable */
-- 
2.34.1


