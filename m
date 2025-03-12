Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D40C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 21:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsTaw-0003Jm-Ei; Wed, 12 Mar 2025 17:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tsTau-0003Ik-G7; Wed, 12 Mar 2025 17:26:28 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tsTas-0002it-Sb; Wed, 12 Mar 2025 17:26:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so375765a12.1; 
 Wed, 12 Mar 2025 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741814784; x=1742419584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNCTgDXk+dJWFTVjg9W6fCkEY6qDUx+0kEGi7VohCMY=;
 b=GolfgxS5gm/O2Oi5eDuJp1UVgrHjNg65wrJ/MZ/k1Mkl7iv+Imfe/+FAu+s4JLsraZ
 DvWJsKIhoxbRE1tUFctqba4XrbOQnKsX9XlH/VTF3qSD2w++HQsYCnJ/zu44EqPaGA4P
 +z1IwVjyQ6Pdq/LEP8VhvDeqPwT/KDnmH+7ovr75HOFt/2ZElm+Z7P1B/Pcn5RYmGuo+
 pJ/Gb+JkZ1yT0SXXKoSuRhY+HBOJlBTRGMcPl6TMZJsFrbODgqfwJHEjWzo5CHtPEUX0
 XbfzLyJgov3yw0CKryYMUohAVsdp8D9KYy/uAikpT951x9X2aREAdeG7tfJndKuvXSrN
 8ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741814784; x=1742419584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNCTgDXk+dJWFTVjg9W6fCkEY6qDUx+0kEGi7VohCMY=;
 b=lIUBgGRSIkjvXA7oxM5wtUYf46cBVrcV7b7Vz51811rr/CzZ2OOmJ0kDY6Id0mcfiS
 FlsnVt5pKFXK/GIxiNF/KtAdCN0bhNccRg71hNcxdCVYz2D86meqeWAdu0i3ZGGaCRo6
 SkJ86cbu9rZqBBcUhLQ+Z84droPFpb4vD9KW3AwMTOKIbAGYY+VSqEqkUHtHdwN2Dp97
 +SyIF1SxrsqF4ja8b3dL1U6oHEqaZKYhVzsfoCQJFaCTxDVZfpTxjALqMltp6Zm0XPcK
 Wl+aLR8XxXCxHYLV408bGHGNoZkubgDOgHU3F8egOCXqI+hKpA7RKZXqZRqhn+vxJE1b
 oGZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX3Cy7VtqMNdbBGtuT6bOAX4m4pqGDRmiF07sDX6bD+FrDEd5C026GXyLZQ8u2ncqPItBeYDBS5g==@nongnu.org
X-Gm-Message-State: AOJu0YyAja6j0u/1rx7gzM+qKxn/Kk9z5FF9nbbS/nZ2Ayfx+UOphkSx
 CguvTWshoT/uNroa1LZVsuWu9qjqi+PINqHnYOS6CLE8sGYV9w+SbF7XIA==
X-Gm-Gg: ASbGncu4oXvYQ6hxfttsjKW8mch9NrHcmDjZGYR3nnUjcwIC+3iHq+SBKjcYbBrJZG1
 51mkvPgnZBKKF0/YBpMv0LoRSusYB7sGGRxh+Ew2fiaLv+LnJvwPpV5aPZrZwL9siZS5SOrFUy4
 AAcfrmnr4XsoNA2CIAHZVE9hwR1JMQP7G31nw1fe+q/KlG/8xVi6I7FG7wLbAzHfk5YFHfMybeh
 gvyCH+2rr81mXtlqJSpRRKurwrvhREOnEB1HrPz/dB+6A0J3wll1bkB78cBd4dtEQvuY8tOAPxM
 eyYoyYwsJK5Kgt46ThS3xPbYznEjJDSx77Km5o9bp6YiNdgVSHYGxKRdF6lZmcNTDOs9RhN2KwP
 u5vAEBjmUI+81mN8wZ+2ErL30ZeYpVahKrl9aWCGWsaZLt2MZ3e/gYsfrAsnGQBfbILpCNCezCQ
 E=
X-Google-Smtp-Source: AGHT+IELGoNLGtxSVUxKpEDErC+T2OnkCet784L2r2tceUDzxffQBg5m5jEBJCYbXUHJpTSWbnkhrQ==
X-Received: by 2002:a05:6402:5201:b0:5df:6a:54ea with SMTP id
 4fb4d7f45d1cf-5e5e22b92e8mr54442141a12.11.1741814783845; 
 Wed, 12 Mar 2025 14:26:23 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2c4e-b100-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2c4e:b100:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c768d1d8sm10024540a12.67.2025.03.12.14.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 14:26:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/2] hw/arm/fsl-imx8mp: Remove unused define
Date: Wed, 12 Mar 2025 22:26:10 +0100
Message-ID: <20250312212611.51667-3-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312212611.51667-1-shentey@gmail.com>
References: <20250312212611.51667-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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


