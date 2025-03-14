Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC5DC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt9py-00089h-3H; Fri, 14 Mar 2025 14:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tt9pw-00088W-2D; Fri, 14 Mar 2025 14:32:48 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tt9pt-0007gx-Hm; Fri, 14 Mar 2025 14:32:47 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2b10bea16so491996066b.0; 
 Fri, 14 Mar 2025 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741977163; x=1742581963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNCTgDXk+dJWFTVjg9W6fCkEY6qDUx+0kEGi7VohCMY=;
 b=H8Gc/RYI+S6gj7rpt71S3BV0ASVBQmx4LGGNUsx5b4wC18qtJApd8BYCLuRS1EV1u0
 3x+rbYMm5tR4ZIxG6ZhxGm8U98rGF106cudjp69UdNwGHPvylLyrgOuZHfnFpcZA8OAm
 jf/JY1RVz7nWp9U2/jCCt4bMBKvIUjA2QJquKMvu6SIq+jsljLoTIathIYoZeLUP2w08
 dlcKrAjoNp/fzjV0675vf6th3VM6LwsKOXmz/SLSHC73jvRtRBGdvP7wwHEkSa3KEhfB
 Frz6FkXkXjlG5HCCiSKGSabpdY6gn88LyKNsygKjyoYE3EVob0uyXAXOiGq8RNvhbngP
 kUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741977163; x=1742581963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNCTgDXk+dJWFTVjg9W6fCkEY6qDUx+0kEGi7VohCMY=;
 b=qTx5t8cu8QfGMgtQ58JQxcvUHMLN+pEZgcAO16/zoU3CqaxTSivXNlR12uL02enRTu
 tMhP6wvAg3aPvRQg4NYDfmhA3hF6Rkw9fXdJzWkg9hXGSN4qAZMVG8fhNf7rBp6pMPHr
 eX8ZpzYscL+3kNTmzeqxO/JmJzNBu6Cp1C71tyhkgOWcV6n2XTK57SGABslrRawkVdkI
 gJkbuzvwsUaqtQSJVwmQ26stcFb2zRJyD1MS25MuQ7JI/7NMQF1QCAhXxUTY6agbBcUD
 n6QytR2m69S2OlgYr7W40TfQr6xvPJrOOc6vk7dI6+FqgIhrHAkFYw8+Gft52ewJTczm
 lGNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL3bBJ2mxBA481a+EdzuKeujbghSxXgnNOypwguxSs/xRD62pZn4ptA7hpGpTFT7VWpt5nhST2Kw==@nongnu.org
X-Gm-Message-State: AOJu0Yy1LhORXoMhxpdPZ0sTa/isklDOTqVxPFX4xAUYJVJkwFMIIKla
 0dUpnzfeoYx3RaRr9Ht2rmD1+lUoZKktHDzPmw8MToqU6NcWyOsFEOrWAw==
X-Gm-Gg: ASbGncukyJRFykQxqOikFkCW/LJqjule+uaqWakZvEjaO5ZoeeZMuPwYhTnKgyjXWa9
 5x6oVgcX6sCxUMNlcSaxOPg0r5qOaywahF8FVOkpRKdLCG7LYN8HqGFW5Rh5GZ/t3YwsVPJy9u/
 bCQIVqoR+47Lj1Qkg/R9pRAUWvVtDFhPJoSc9IsGESg/Yh7dTE9Hhf+felbVBA51UJSiRH2P9y/
 VDNBV9O/kEc4CcsTxHoKDZ6nJCY6Bb/TVoWDiHgmXzxVGo0jYB+Gl+pZb5lYREq3Z9nN6tZHPlV
 oVEL2i9BfmbB5o5CEk3pRMTTfsNCOBQYibzSArdgxOVLERWfcXvYkAgU/amoUeQFEbdEtNlmwB6
 aR8pjo8RBeM4ZMCCIQosMiY0/1KHr4+ce/3cSeo2V9WQ8jyR5MYBBBOsoW1TdxSDI
X-Google-Smtp-Source: AGHT+IGYSdiNKxDqtuazJqGxI88PmNo4dxyktdEPsShlKLrs1LAiuCyyLI8iJlWgDinn4N5KglrqeQ==
X-Received: by 2002:a17:907:d92:b0:ac1:dc0f:e03e with SMTP id
 a640c23a62f3a-ac3301768bfmr463081466b.13.1741977162487; 
 Fri, 14 Mar 2025 11:32:42 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1ac1-f400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1ac1:f400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f0ca7sm262104466b.60.2025.03.14.11.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 11:32:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 2/2] hw/arm/fsl-imx8mp: Remove unused define
Date: Fri, 14 Mar 2025 19:32:24 +0100
Message-ID: <20250314183224.21822-3-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314183224.21822-1-shentey@gmail.com>
References: <20250314183224.21822-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The SoC has three SPI controllers, not four. Remove the extra define of an SPI
IRQ.

Fixes: 06908a84f036 "hw/arm/fsl-imx8mp: Add SPI controllers"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx8mp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 22fdc0d67c..d016f7d337 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -238,7 +238,6 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_ECSPI1_IRQ   = 31,
     FSL_IMX8MP_ECSPI2_IRQ   = 32,
     FSL_IMX8MP_ECSPI3_IRQ   = 33,
-    FSL_IMX8MP_ECSPI4_IRQ   = 34,
 
     FSL_IMX8MP_I2C1_IRQ     = 35,
     FSL_IMX8MP_I2C2_IRQ     = 36,
-- 
2.48.1


