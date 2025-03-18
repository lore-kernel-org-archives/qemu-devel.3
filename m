Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 20:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tue0W-0007LA-Fr; Tue, 18 Mar 2025 16:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tue04-0007ID-2z; Tue, 18 Mar 2025 16:57:27 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tue02-0005mN-DF; Tue, 18 Mar 2025 16:57:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so584534466b.0; 
 Tue, 18 Mar 2025 13:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742331440; x=1742936240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOrNiTqjVFTUhCSRr6mCNcgoHeGlKxIWCFhVKGQ+JvA=;
 b=cHSu2QtDIqG3l+vFC+aH/YSxTbPJtjI8V+hWX8Zb5hfrdPltylEFZpxe1LPm8B5+ol
 UzNCH8qHHxWsJ+vnFTuxOYxaipWpK84jDRrR+VJimfl997IK/r78RaizgY6t84NF26wQ
 Il7ncpt7k7+tAil7//+VWZwrGN0bH+Bhq+t0DkIrQCkWAstcE4M6qlX5aCmp/n+YXatB
 N13IkG399JkKyNRZxNZRR2e8i2ReL0ipHcEuq/R7zmg0MJjYy01gcKJtJMakZXvjbspc
 LN1Qk7sqFQXOo4gmOk5/cg5jLA3+wqps1NWTq2nzE5Ox2Y+bR36cQ1vIL7aeyxUTba0t
 3A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742331440; x=1742936240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IOrNiTqjVFTUhCSRr6mCNcgoHeGlKxIWCFhVKGQ+JvA=;
 b=UqcqiUl0aBRoGwwrVq74+TmIhoTxlD4ScdCSrQQL3piCTEaC0gJ/jKuxCZN52p1hfH
 hGNOsWqaCqu4zxxc0/iCNw3miugBJYZ/bmIFYdFhFuDrE0+wN3Sb+12CdqZgw301fvkt
 Vk+3Nx2qkHxC/tC2thGtu58SkgF+ipQT+9ThSZcLqJ+dWTg7b3y1Z+pjHu4ZYTVKoPOW
 YzJGIRy6sUzxivCBrEZ6GHC8SypZC6vZAEkcNsfDnJcP1304blgL0DkS/727utqCNmW9
 sHkHf3PGAVzqQ7yzkhOrEy8MIDl5Zg6TMfOmKESWEbGTSbJjOFzG/u8fsnKkl4tlweWT
 gd5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI9Q75W0pcbiXuLGU4vClbQcYyPjGZhXSCqLaHHQrovyJcKJeBU9OUJxWoZmsYE+hRJBlAo/82Ug==@nongnu.org
X-Gm-Message-State: AOJu0YwX9YDVrGc85XUPMR4wvvD0DzvJ5GmkEFEuJIVzms6Nm7P5uC5t
 EMnh6HEGxam5btVW0MFLbIzcO5cEf4gMlcOPHXRtmjnI3D2LVgIP33BkKg==
X-Gm-Gg: ASbGncvJGdMQkXrGfZj6D0IieOU9bukwelecDMSIjEtB04F3lALvOQ7v+LPMfFk6s2X
 VVwEdLQV746zvUAB5I3p6vlxZ77wGls2k3S2iARXUVm7GGvTiPcA5xZU6GPNShal0CnUhRgeXe6
 Bvtyqv2183OjA9dQLkqqnHKmDOg9q3KUl/BmslzfV+rM72iSR0rTlwPmVwpaJjTrorZgmiA/xi4
 mGTC/D4dvmaYuEWJoQx1VkDU/BpfUFpXYJklJO9L1+9BScF4EW1klnPucTTVZKyMqfCbLqI0+eW
 sw5/Df7kgneUAnm6bXxzEuUtWM8XSJe7lmYUz54u+Gr8v8tF0ptfchgQ17RST2d1hiXS9mY9POM
 kAklUkD3czv9zavAlZ6EYG7fThooBtLqPpIUNkiR2Z10FHAhrhQWTFxnxBTUsJhg=
X-Google-Smtp-Source: AGHT+IH49vvidLTAnEJQav8tz1+H3ZztnkmkQqcDG3uq5ymAV5UcXB7sxG+i0PDCqO8aDPAwn4lEmQ==
X-Received: by 2002:a17:907:6d07:b0:abf:7406:a5c3 with SMTP id
 a640c23a62f3a-ac3b7f275camr8228266b.51.1742331439783; 
 Tue, 18 Mar 2025 13:57:19 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-19c6-0d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:19c6:d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3146aed4fsm895944266b.26.2025.03.18.13.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 13:57:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/3] hw/arm/fsl-imx8mp: Remove unused define
Date: Tue, 18 Mar 2025 21:57:09 +0100
Message-ID: <20250318205709.28862-4-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318205709.28862-1-shentey@gmail.com>
References: <20250318205709.28862-1-shentey@gmail.com>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
2.49.0


