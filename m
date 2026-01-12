Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810AC9EC97
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJJh-0007gV-8o; Mon, 12 Jan 2026 09:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJc-0007bq-3B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:44 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJZ-0001VO-4U
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:43 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b86f69bbe60so205795666b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229679; x=1768834479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9E9nBJERza2cHSSGZ/56X3Psf+p38WCxtaLvvfm5Kk=;
 b=V7mmSi9/YQwuPVDAk/iqa2utT0MnvOdfjSZaHaQROVTHj5EdXMRbX/gNc+uyTeo38h
 4s43ZdNhlFMwZ5eupcXs14fg1/oR8+HCpBrLtgp7vpCk0oQAw9hyvIS9nyv9Or1r2+Ka
 zZ+XC32RW1sB3iFGD+1RPqQ1z27JGLHfVXQ12y5qkLJGx0m0Oq/wEHVg9i60GMQ7m9lf
 FKIjM9/Czsx8NZYb6yTLbbWLyqkKLdN38Ky6qMphl3wZl5AEG7ZwdEitQJIR2Ttts9E0
 WWeYldUT7eAmw5xsJcUJorrSmkNIF70a5jzcbOzNFlM/oVTLIbAqWQ8RH+tjEYP1tWGo
 QDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229679; x=1768834479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c9E9nBJERza2cHSSGZ/56X3Psf+p38WCxtaLvvfm5Kk=;
 b=tHxK6aTU7+QG94jKmXf7ZPG1qS/ekKMiTlY2Zc24/V2r9NsgSiLBYMUivLOPemBxKq
 fbIJDssURhSnrZEGVO3AjvZosWOY2v0UH4tjCC3ShzawALAemLp/5eos5VSnSQQsVatz
 8ozRpWGpl8nwTf7wnupNnyTOoab/41VbonDtj7BVhm92Z2pomYJCFJQNF1vnnjAkm/Ue
 2EVu9PvaFVsQ998UF+bgrHBZxK3ZtxtFQeGxbnjydyRDmzlhXjK33mPRiaDmUzphUI8y
 WTb4wZCFZ5SIm5JdMtEkyX43ug1BC/HKPsmHV9FBBDhM8TcKd2QSR0y2S5UAhbykKCIl
 TEXw==
X-Gm-Message-State: AOJu0YwTmCB4uv/+M8EozOIqqUZy9K++OEVK/n2lb202snS7b6k541vJ
 Osm+ex9WXVXbTPVrAFIabfCXZuPd3U6Ro6BEWfQwHyoZsVPeuxBMMcTJaHV0Yg==
X-Gm-Gg: AY/fxX40qsGiX5m7P3bx0j/BlGDRp9GDu+2OayJmdPPKXQS65UhIDaNqA0buy1kBToB
 4+/b6mZOONN5QwZ76lKq4WTu/I4ZRi+adJVUC6VN2ob5+eOC5ody6xPEJJeX6XHdub6yR3OnlsH
 KJ1MYPAKbOzWy5Hw8EcOYMczVMFrK0PXhqwT2eGU23UnzgLYtbyvsBahJ5CqxoqYVkwLzPWhOuu
 R+70u/FPnM/UErbVkJ/xAyGxgnhy3pLqBKkCX8BSEdk3+Oi5N7AlRGe8xIEmVLCsCRqT2HmiIIo
 l+mT5hn/WPURkandY/0VDImYUU/afViMk8b7snvf6o5+NdZ1dAXtIecC/7jZoA2OYMlVqCrHH5I
 RfGSsp30ijXcev3LfICmXnZ8JxNXUwndrAhGtLPDVbdm38SzlzvNPgU+SIJZya3aKr9D0H4todi
 T7Rm1FK8vvKKyDuHrmMaG/Bp6ON2SI2FDAMBNWRHdK/y5D4Q+d8qbFXXjjdEIdZdWzdGqn+5y4F
 2sRX13a+/s=
X-Google-Smtp-Source: AGHT+IHL54xx7rm0k/txbFmkMEyEBwLCj51POjQlV2qOk5/n32Y3UKQc6bEwkvv2RfBzzoqLE230MA==
X-Received: by 2002:a17:907:7282:b0:b87:892:f440 with SMTP id
 a640c23a62f3a-b8708930758mr491424666b.38.1768229678584; 
 Mon, 12 Jan 2026 06:54:38 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:38 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 01/14] hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement
 sd-spec-version 3 by default
Date: Mon, 12 Jan 2026 15:54:05 +0100
Message-ID: <20260112145418.220506-2-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fixes TYPE_FSL_IMX6UL, TYPE_FSL_IMX7, and TYPE_FSL_IMX8MP to implement
version 3 of the SD specification.

Note that TYPE_FSL_IMX6 already had "sd-spec-version" set accordingly and
that TYPE_FSL_IMX25 correctly sets the same property to version 2 since the
real hardware is an eSDHC which is the uSDHC's predecessor.

Fixes: fd1e5c817964 ("sdhci: Add i.MX specific subtype of SDHCI")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 9146e0cde0..23d8f7cbc8 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1884,9 +1884,11 @@ static const MemoryRegionOps usdhc_mmio_ops = {
 static void imx_usdhc_init(Object *obj)
 {
     SDHCIState *s = SYSBUS_SDHCI(obj);
+    DeviceState *dev = DEVICE(obj);
 
     s->io_ops = &usdhc_mmio_ops;
     s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    qdev_prop_set_uint8(dev, "sd-spec-version", 3);
 }
 
 /* --- qdev Samsung s3c --- */
-- 
2.52.0


