Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C282C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag01-0001R8-UO; Thu, 15 Feb 2024 12:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafzy-0001Kj-Py
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:15 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafzw-0001U4-3r
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:14 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d109e7bed2so15220381fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019889; x=1708624689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUafXRAhN727LPu8aV7JxhjZQNzC7SOPem4FLXSz2oI=;
 b=L8T7thl9epGi8oF1MWrVN2UTh7SuL01GqbFe61kdJ5xegyPRcUFpO2iCM0AaMvW6aR
 IpJkvBI2PjNJ59VPMadvaZKDd4l3Mob18cxzCogqmM/LZ+7xR93vfSfauLp+8w23w9nJ
 UDokqFe+y5Jp/o8u1CcuY23XAJerzSWwVkYUeqOLhm7y8JKjkf/5J+Gqi7M0a38VqFmM
 eOZoltQXMoGfPmx9j0C10BIxELvvgyk58aLraJumT395JvMe2INrp3AH6iFIFz+Liqyt
 EeFc6ILXk9mOV+hWLMtt8SoYjfF61k4DCH0Sks6r4l66R2JIJLRl+xzp9QfsjKaAC2eF
 VJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019889; x=1708624689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUafXRAhN727LPu8aV7JxhjZQNzC7SOPem4FLXSz2oI=;
 b=hr0jEiGU7Olc5XfJ0w5YO1cNcwrJTDkNTCcvPCpICITaLgbVkxiblnxnvjrY1CeoAQ
 Vqi/U4T4cWTKj6Qlw+VAIZvQzg1RVx9FJy5XW3mkIPQ7Eq6bGJAQUPpmQpCLj9/ZOkW+
 ShuNrUMaEWuY7tGoDCt0+CXEVXETfDGew36Q5zzNe76G32R1zHXv94G//JsDqTAGsFpu
 egs6NGn8yx6azXcQCYSQT8QPy6sx7RpCQ2kDcuvspo0dwqJMM8rkq79lmEvrMUCHVp3q
 DhyuEGNr7gv34lHIqGpXdNJPzhf1xhihEM8avWbOVTyLJGwN3qwqEH3/TBf8UzNAXyrd
 HkUg==
X-Gm-Message-State: AOJu0Yxf8dYafAI95V48O4cahYb9snzMFQeaWobQoW0HFlwCxM77L6um
 x2gxk+AwvETM1MbtYJXBIDiE0JthUpBetc4FMyOj9CyGQeyFe6IDNKRIl04p/9byRLkMZRAGRzX
 QWNE=
X-Google-Smtp-Source: AGHT+IElwG4sbsQuHtf8X8jvD18iJYtxlYg3dBQaZnA7a0iAKfwkO8sMLmwjIAXsTUhRce+MufLJQg==
X-Received: by 2002:a2e:331a:0:b0:2d0:e2aa:24d4 with SMTP id
 d26-20020a2e331a000000b002d0e2aa24d4mr1745440ljc.9.1708019888851; 
 Thu, 15 Feb 2024 09:58:08 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 ba3-20020a0560001c0300b0033b406bc689sm2495039wrb.75.2024.02.15.09.58.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 02/56] hw/mips: remove unnecessary "select PTIMER"
Date: Thu, 15 Feb 2024 18:56:56 +0100
Message-ID: <20240215175752.82828-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

There is no use of ptimer functions in mips_cps.c or any other related
code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129115811.1039965-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 505381a0bb..ab61af209a 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -50,7 +50,6 @@ config LOONGSON3V
 
 config MIPS_CPS
     bool
-    select PTIMER
     select MIPS_ITU
 
 config MIPS_BOSTON
-- 
2.41.0


