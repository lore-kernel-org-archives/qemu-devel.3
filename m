Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5775FC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEC-0006GX-9F; Thu, 28 Aug 2025 13:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbb0-00072Q-6S
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbau-0000pe-4R
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:19:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2487104b9c6so7822495ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383546; x=1756988346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/6x1HXP1N+S4ifQMLcnaTaBv3fLHAqVhSKu6p0/+oM=;
 b=p+xVgnULBAP11fxScBV9TkkFb372ftx+6cGWoemkc6vagLeLTapnwJJy4NbD5jroZx
 txXe1iBEwNXCnWW8T+ZmpLsc4UN37SqEZ6HTs8XCV31Jn/Ob1eGpkUlsTP5swJx+AecO
 1J4t03HTZl2uqgnFUp09dEUfKT+4DJK5VMxQ376eb5SSy+Ky6z9FK3VNIjcrx9nI9n8r
 bzuv7OosXVzCFSNcSsmvOLR+2hrj49MMGrkyearI/83oCqNxEfDplkDPXhXEOSsSWdYS
 dZcFDkGGWx4ajQssQ2bguBcA1O5JS+lmoy5vccmZy4rzhXPonPtsDdMLj711e8Jc1mHU
 WG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383546; x=1756988346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/6x1HXP1N+S4ifQMLcnaTaBv3fLHAqVhSKu6p0/+oM=;
 b=DCkbgrqwqKiNoQ1KfR6A1e5SsY8fxVgOl4s+Sl2zRgjtZf81JUHCGi2tziuvYLGVDf
 6WBiLoxUBybR8KD6xahcRTm/n1nPto9gldhB4C6SJ1IkWxBYRegzyeZ6vdYybrDxX8MS
 cMZlDukX4jTkQAloDU9WZBqi3tp0aXTq0HP/nKS0dBh/9d106H3nSrySch8x0/E7wbqx
 G7Wu53WPjF5jvKDiI+rCttOBUYDs1E6iAQvUAg9bFyVKEmA+QFK0bQ0wHU+KUCakez1f
 ajzWrEgTyf9A5pdzTrT7zW9/nuySCFA+4imH6HOE9TXQOWsaHg1cOEl2wchHVDaaGJUA
 vVYg==
X-Gm-Message-State: AOJu0Yxg7Hj8G3KLm7jIpVmOvwVRYnSvBAemHQrAsX+VvRPVBvmJcJEu
 uMKXRanUQ3uLiH68v1+cbnD9kSaRYqotrSExnX9qamNiU5FKtFUiP8U/hzOIoWLzbm3FMKcivGo
 PiL9FCQw=
X-Gm-Gg: ASbGncuK7HJ8ntbVX/TZ1P7UdJqAx3iodwD4hTtn2X3fT8jfbmGyfBRCP4Li9RO6jGZ
 e5RAQyDExvr3ziXqPRvw1mNoK0o2a7zYRJGhbs+POwyJyyevb5j9R3vCKa7feC/zz5rHfDD7jIx
 NevCthAR0NHBe7+9tvAKDJKkadsuj6V+6bHs69jk6dA2z5Z0+dLqBGy9FJyptuImN8zgCv3H1ZW
 zHZ/F52i7t+cf1K2Ykl2mRKzLytfGoh++IBi0Y1iM/p3fXelr4gw0Jll2xr/H5XkgP8UuGLFB13
 3oFKvPMiqVsF4/f32BrM2OYH1kbNpdcve5Y/ctLALr6WodkCL36T/aMdC6+dvh27QU66pmtoAic
 06HKlTK14U299ON+2HnMvRd4vCOXzHU1I8WIZAKwyRjSqrkY=
X-Google-Smtp-Source: AGHT+IGQeM3R51nUNstdZSTHRJ1/H9U3HovUr02tQlWLDZH/6Lo5kmdO74fB5mm67ZpTRR5jpwxIJw==
X-Received: by 2002:a17:903:38cf:b0:248:aa0d:bb25 with SMTP id
 d9443c01a7336-248aa0dc43amr72399725ad.14.1756383546501; 
 Thu, 28 Aug 2025 05:19:06 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248953dc1f4sm48898735ad.30.2025.08.28.05.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:19:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 82/87] linux-user: Remove ELIBBAD from elfload.c
Date: Thu, 28 Aug 2025 22:08:31 +1000
Message-ID: <20250828120836.195358-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The last use of this fallback was removed in 8e62a71738bc.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index aa0eed6dea..c0326928d4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -110,11 +110,6 @@ int info_is_fdpic(struct image_info *info)
 #define MAP_DENYWRITE 0
 #endif
 
-/* should probably go in elf.h */
-#ifndef ELIBBAD
-#define ELIBBAD 80
-#endif
-
 #if TARGET_BIG_ENDIAN
 #define ELF_DATA        ELFDATA2MSB
 #else
-- 
2.43.0


