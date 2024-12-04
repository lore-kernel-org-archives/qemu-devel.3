Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66AAE77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwA6-0001Cp-NU; Wed, 04 Dec 2024 15:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9y-00019l-QH
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:46 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIw9x-0008Gz-0E
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:39:46 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee88b57ac0so199181a91.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344784; x=1733949584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4FdoiVujAHlSAX1GNeXZCXDPP5ciq+pm5Du23bE3KQ=;
 b=JeL37xGa3PohGazFfvVdKqlzLvvDy8vFC7rKBl2b1kRP2+o8ROUWmuNtUT9KSLo2qw
 VZyyhpywdo40g6HwdyvHKmvsJ0nzoF4yqqAnUSfERm2XbnpUGBQuHs4oL5pH2xKjlJxZ
 uXRatxoxqLRezgDz5bL+U0pxISWmxIFIbq9jS6MvaCpjIF1RahbBcy7/FE9UKRd2tct5
 Twb3iN98joX8qilPTJZtqiswoKjtuZUsOB+NzjgdG84Z/Qj//ZEZvRTAZeQlxnnRUS7d
 7BW5414j6EOJ3CnXKhn0KUJkCR5E9I2fK1mz0wzhfQapAUMnYb/AhDyfsZK1yrVzhDqI
 XHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344784; x=1733949584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4FdoiVujAHlSAX1GNeXZCXDPP5ciq+pm5Du23bE3KQ=;
 b=j1WdERDlyX0xlrIZPkLtyF61xMF9WPKQcukUJg7C9JwX4NA7XfGdOBrRgGl2riGejx
 rrQq3X0YH5El3erBAhdRlYQeRcN7BE3E4vjdHpsStJCnOwvSwnPF6yfXVVUuBt5ZZnLF
 KDUWDfQAq7tapx0PL+wAlcdJAAscjCaVds/FWu/URulprqbLGAZfuJyD1DuwC1CJGqsl
 SyD+csk4hBsDeKqyavRUuvGl3VdfzHcbaEsircLFlwlxSh92cIZrsFk1aUTLMeVIVOms
 cbBeVA/rcdz4E5Aui/+ITELAsZUzzSs/Bvy1LDrRQnU1CGnSvQSi0AkdxhhJx3lyHKcl
 KNxA==
X-Gm-Message-State: AOJu0YxUZTjCSESo0FmepcnJ5i+FRuSXO7h5s5vQwHHTK4jde2IzBwb/
 PWO9bCS0qoagjFS/4yRz7ezUGBFprck9c+dyfla/Uihw4OyluxYUPuzXzjiDnmIvDk2OQluHBia
 CHzA=
X-Gm-Gg: ASbGncuQ1IbqqUHkrjX6aKlY7eTotkfZ6x4x/NE6T7pws1igN4aqxuJxK3oaTE1vc8R
 P7XU1iE759+w5x8UuMdswQRRdHA6ctC4DIvTfmdbgagTLAzTKddsvN4Or3mVtk4PITrGpwKHXVx
 rD7CSWALmbmsAb1RJkZS0tozQ8OWSfLyRKvy1FBmfD7TkkjIOgIDo8Aj/tKT3PdQKOiu864qNTF
 EO6MzMcJE+lB45jnsEytppP9kOpbI0k9AfCBgki0Q+nSxxkyoTTe7RtnOmH4A7p/HRof70ceuLH
 eNcsgJeb
X-Google-Smtp-Source: AGHT+IH9pCxj4AEDU0wMLJPPfq4gzzkJtOOHYXI5zOsWZVxemOMxcTG5LuoGT96IjzpM+DPZ4Fwy8A==
X-Received: by 2002:a17:90b:180b:b0:2ea:5fed:4a32 with SMTP id
 98e67ed59e1d1-2ef41c1892amr1126286a91.11.1733344783717; 
 Wed, 04 Dec 2024 12:39:43 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2700cc6esm1873117a91.21.2024.12.04.12.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:39:43 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 alex.bennee@linaro.org, Alistair Francis <alistair@alistair23.me>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/4] docs/system/arm/xlnx-versal-virt: document ospi-flash
 property
Date: Wed,  4 Dec 2024 12:39:11 -0800
Message-Id: <20241204203912.3037515-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
References: <20241204203912.3037515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 0bafc76469d..c5f35f28e4f 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -178,6 +178,9 @@ Run the following at the U-Boot prompt:
   fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
   booti 30000000 - 20000000
 
+It's possible to change the OSPI flash model emulated by using the machine model
+option ``ospi-flash``.
+
 BBRAM File Backend
 """"""""""""""""""
 BBRAM can have an optional file backend, which must be a seekable
-- 
2.39.5


