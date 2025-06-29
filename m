Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F02C7EE30
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 20:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVyxW-0003ei-Jm; Sun, 29 Jun 2025 16:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uVyxV-0003eC-EE; Sun, 29 Jun 2025 16:49:05 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uVyxU-0000Rn-1Q; Sun, 29 Jun 2025 16:49:05 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0b2ead33cso678500266b.0; 
 Sun, 29 Jun 2025 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751230141; x=1751834941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQOw7AHWnconnv7IJtYR9CMfxMCXTEspg6v7zFVpGKE=;
 b=dVYeuqkcuBagkpsDhSzVQWJyAgLr5F2TJEYjM8qEpTgKvBUmPh0EK8oUKUuDihu95s
 FrnWSlrv9Hyl6vNKUcHWjhJvb+09ZGtFDof+YE+aFboQjaUsCl6udKZemxvOuI4J52G0
 7UTQi/Ffg4UNykJAlZ9FyMw+bxgf/Y34nwFyHBviJdZRIdj7D6VNYtwbV0sl+Lc9DOp1
 E6hWGq6gvBKpRUGlVxyEVHgGDAPT1JhOSVa3jK4uJlm7/QrW7E3fmaeY9CLyOPmAjWSi
 1NmFpc0ZDelqAqYTncm54xlXriff60O5DmPZb43H5aS4GOjvKVr9ZtR5ncPYkReX8V5a
 dQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751230141; x=1751834941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQOw7AHWnconnv7IJtYR9CMfxMCXTEspg6v7zFVpGKE=;
 b=rsQtiE7Jm02UGQyIZTNIT2Iu7Va+BUSlSg72fYGEH5qqmPax1lqyHkeLnEYyjr5nXe
 mljSvIoh+cRoqK/P3M389xW4b7l6ojbF7MuUAFbH0RwZno4gex6kcQYa4uev+8GynhJh
 iF1fhNJmJJRg5v9aIJUrtrEj3D5KmlNvZqEXWX8hLiNldG67UmHWfzoxgzBOtEyTgsKi
 gsujSX8dD1AHWao8WRLYeTEfzvYNaYDhKYa9vo2aCd3s7jEdHN8ZdIzPKGO7UBJn7tSP
 1a8NDW+Daq6HeQPG6gVwj7fCdHdHrWJ2GwFBJ12DBExS0eFbPvzfN+W2TpCieX+faJgg
 dGNg==
X-Gm-Message-State: AOJu0YwQTBb2LbS+v+hwVyYxaw4fygDkKr71xXg9DvXWWEccYluI0dtt
 0LLJ6sTfrG1E2TIgaMQ0JnHwItwzQt4YU5olLY8tST/B/I/1SSyg5tTuTDpZEw==
X-Gm-Gg: ASbGncua3U5trXyaaGCq8EToV2dDsBzrpTStNCQ8s8ULqpJdk4powxK7bNi39Moj9XM
 FFIq3o/2jY9X3sxRJc8u1DFDKvGxxE3lZ3WGYWPB4usd9vVruyGZRiGcAhOI/IUKULOhbETRzXh
 jYtsvg9H9LssMOv4so4c7bXWN2S7uf7LUyYSM7w84ppCW2qCNTNEKJnCxVkgm06eh3F9bnKlExr
 ubW6Mvr6HLnCvcrZ8M37Ig5rgb1CmvlA9qu1fWUXV8x/7JLcw2aSqcuIC9Dm3UPx9ygGM4up4HD
 X+cqnypgglCAAxnIpokzS8W9vbNH1G8PppsdW98BLDjZniG8b1jeAXjy4PNOMKI2kUUsTprLuJ2
 AbarJO/jfOZ6Ac7VDXQ18r4A4d1y/zyMmTAf8pjT+LKkV0/2d/Rsu8UrhnCOmwJePpw==
X-Google-Smtp-Source: AGHT+IFMfXIpJbgmQAE7ZwsWVtoK1YAjL8z+OjDo0/mkoYKcc/0kuMXrHWwP0eyF7MDi1tS+Dp8Tdg==
X-Received: by 2002:a17:907:94c8:b0:ae0:6621:2f69 with SMTP id
 a640c23a62f3a-ae0d262937emr1704713166b.13.1751230141268; 
 Sun, 29 Jun 2025 13:49:01 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-2f97-a200-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2f97:a200:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353659e06sm535709566b.44.2025.06.29.13.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 13:49:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ
Date: Sun, 29 Jun 2025 22:48:50 +0200
Message-ID: <20250629204851.1778-2-shentey@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250629204851.1778-1-shentey@gmail.com>
References: <20250629204851.1778-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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

Allows to run KVM guests inside the imx8mp-evk machine.

Fixes: a4eefc69b237 ("hw/arm: Add i.MX 8M Plus EVK board")
CC: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx8mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 23e662c16c..866f4d1d74 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -356,6 +356,10 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                                qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
             sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
                                qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
         }
     }
 
-- 
2.50.0


