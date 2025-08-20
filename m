Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131ADCA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqE2-0005O5-HC; Wed, 20 Aug 2025 17:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqE0-0005NK-Tk; Wed, 20 Aug 2025 17:20:04 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDz-00052a-A0; Wed, 20 Aug 2025 17:20:04 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6188b73bef3so654856a12.3; 
 Wed, 20 Aug 2025 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724801; x=1756329601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeVRfk3VsZf+so/2hf9x9CGHxpMR/23OVPq3yUxSLhA=;
 b=dRvLZOXAEa8SfZgzATNncEFryELaOnhuRm7seTHoOPzZmeUzTwefgRfobzgle6XMpx
 KcMjeveqnFFmsSxfB2O9PpRbNaJWYAspFKFMIDrRFDqFWA5+36Wq0Nij+IiX4Y2RumgF
 BizHGEszRrhyB7A5BpSiYuXQ8Ge77sDVF310DgF/oIMIjYMOZJVnEQi61lroYLs/832m
 fUSa9ma7TSUtA25fvCQXe/Dm1mPBgq8Dw8BnnuKMpd6hh/8h0qkGbPHLQ8smVEbRhmdz
 aFQ5JKYZqbmq4KenkBRHDagfoYpw8bye15jWRTEZ+aGggf3PDV6GJgSJGYL0ss5+xRHj
 OfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724801; x=1756329601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeVRfk3VsZf+so/2hf9x9CGHxpMR/23OVPq3yUxSLhA=;
 b=hm217y+HHVakCQiaCom2m6aLIW+JjJdExsyKAEPnoLVAyR9gTJmzXY9NCsAM+iJ6Ye
 JUOQpfZK4xEiWsSiMXSbXxqg+KjXAF9nmlcyDF1G6/Vb/D7Tz798FcqXxsXcUBdBnIAm
 NeoUi4PA2pSeaDwCTTAe0n/6/Ia06HwP4F7TemsUXwhqnlqYVze3wWpRffZaq3xkAfvU
 nlgJajb4Gooh+fc/skX3Id/aKVnJra7rI1djaJCl2lyyGG8BYhaUT1mKG8ZFualIgFR3
 /cI/WPfgkt72HihPMe7XNhrGn6hrhQUssx/u3J4Tgt588xofIHFGKvmN3ZYAE9oy8LeV
 jcMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLaMGU4hqvTsZLWCGVQlniIdo9RwausY8Ps2Sl/pH4kMwyBu3NmldVxkPtJVDfp1EWUjkFOq4NbA==@nongnu.org
X-Gm-Message-State: AOJu0Yw7ZbkTgJPYFOVIuebV0RvxuopFh11HI9KRMpY3pRT3OJfeOloJ
 9hxw5t70cdaQnq4vVL/beYkEvx5yFC/Ge/s27M/BxAOYk/hCuqqf1/oYNlNoH/14
X-Gm-Gg: ASbGncu8vnoouMs4vMHRWZpVH2pi+XFJM/N0+4byen+pFGKck/uBjjDHTM5JjU8T/ge
 MXL+MhPJlFoz0jtXkXs+MHIa2lm4PbT+9X26irH4sjRpGJ06lrkLAul78EtzgVCG46HxOjQ8420
 zfJsvO0dJf2Y435ONkRQSbws0FrfRdBLud1ZMOR7LD4q0gQ82cIoE76QBN9wPSs44XIFt44GnIg
 YbeQupwCar+USQ4iNKyny+CVpqW/niL3c2BAkYs1XYsDI8CAQQcoaYyWdikJH6czcWTRzY98ocF
 pcr6C3FzTqTG2vZtGntOxDpt+enHb544RDN3ZQVqttTOH+LqyrdYjV8JkCRCCqBFHmF/wodFEOL
 iJfLhdbLTgoVL3SywemF0eRUMF9tDnkja3f9kI6hRsXL1Grg2xR6l3OkO4/YbfUVb9ENEXkluwt
 iJ3ZWfscYONaS1Tr+BkgZeUIWi4kOgbMRFRggIKv/Xl6EQxDPphOC9OA==
X-Google-Smtp-Source: AGHT+IGd6MFMtd+Deaef2YizMDx8hhPfbLZYMq+9A3+3dqqPiaX8bsIFq8g6eYFK67HFUAAmszoH/w==
X-Received: by 2002:a05:6402:524d:b0:61a:87c8:1b2c with SMTP id
 4fb4d7f45d1cf-61bf87355aemr131371a12.27.1755724800973; 
 Wed, 20 Aug 2025 14:20:00 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:20:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 10/10] hw/arm/fsl-imx8mp: Do not map PCI window as
 unimplemented
Date: Wed, 20 Aug 2025 23:19:32 +0200
Message-ID: <20250820211932.27302-11-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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

Now that populating the PCI window via iATUs is functional, it's no longer
necessary to cover the PCI window with an unimplemented memory region.
Previously, this workaround was required because the device model failed to map
all configured memory regions, which caused Linux to emit backtraces during
access attempts.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx8mp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 866f4d1d74..d66783c101 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -669,6 +669,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_OCRAM:
         case FSL_IMX8MP_PCIE1:
+        case FSL_IMX8MP_PCIE1_MEM:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
         case FSL_IMX8MP_SNVS_HP:
-- 
2.50.1


