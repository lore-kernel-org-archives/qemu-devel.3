Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EBECA0FE1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDx-0005Ko-9X; Wed, 20 Aug 2025 17:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDu-0005IZ-RG; Wed, 20 Aug 2025 17:19:58 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDt-00050u-0G; Wed, 20 Aug 2025 17:19:58 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-afcb7a3ee3cso47694566b.2; 
 Wed, 20 Aug 2025 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724794; x=1756329594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYVlm45QQ3i2G9+d7L5TMWVG0rHC31MFiYi6MByt5lI=;
 b=WApl8whV3ThW48xD93M5HDy8yQWfU3v2vkcrwBiSIeco7cUjT1MYefped2NMd9J4dZ
 quHt2yZ2PSoevkb9ZKpGB4ebRXd0cTvbggAwmZJeqnp1cbNtzTdsikVByW1N35Ea8XSZ
 N/cVvW/UkqWGRjhX+vLXl3/XR9afVeMtD/vyO0EkkzwvOtJWX76XHqkFMv+9stKliJrv
 GEbeYq9EqzdBEMZbtNX+CC0Xr7E/nrcJiwZFd18cMY+Cu7VZ20G9F90uPgzXfeHoxxev
 hcpoWG8ok2Tdjp5xVqLjSkcqEcNq0CJ8c14E4B59cxLSt+/dmrALnQds2kxIai7shYFL
 RfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724794; x=1756329594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYVlm45QQ3i2G9+d7L5TMWVG0rHC31MFiYi6MByt5lI=;
 b=lFPJ4613Cx+ErsWKCSUEIaNw8pYw8CEmf+1qeXeDaFIqe5VweBk4Bdo1dsMBDGl6ac
 RpHC8JwUQAAb6SOuwB4NbnHyvTbxJCKtvfKDo+DYbGSj/dmGbXjm2L7qNmAPegrN+I8j
 5OMs/mXf2VN9GM+ETW7EI9D3cPRDVWWBaC1VVnc83qeOkoDZOGNzo3QSuQtGwfO1WRdg
 i63hAfW3lNVBVz1gymASQGbjRjm36aeB7HQcyuYuoE3lQWjPYVxii14UaV9MKcGkAxcD
 V5B1gfPq6eTE9gutf6YGNC1tbrb62WGIxCzfQfY3OMlD/iyDDzFQH9uo4rH8YHJySM/2
 gX1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQWO5Rjxnr6zXUGB/k4wclOhjJatlBiazHvZ4wH9UdwRJ5Z6fg0KIzzquVtKJ3b+So9qlgf1QvOA==@nongnu.org
X-Gm-Message-State: AOJu0Yy4e03mQEIFVXNTAYRWTkNa16CqRsSstkK/DV7rAxVTyqFYeV0y
 ooiirR2tT0lTJ0nS0vUEqkd7J62GHHBheIlQFsBF4qqJCXXIXSFrgBthpU5u8uSo
X-Gm-Gg: ASbGncttaXO1mlckjPzeBq8HbgHCDR704AdaGx8q4HIhGaEIrhrBCq+LLbsQcx+KQsX
 Kyj1f784dx6+9nnEuC1G0BmG1lM9UzWn39m8PcriBNco9OF8FywJlSVcNcQqq0FWs5zttnqRXIJ
 JVTweaH78Ww5rz0QaNqH+H81gQ2cvm7Iw5raCCipHtgDvo/llJqKgD1EkvgDHL2lUz0RgNG5nuv
 vODrrYqWLZ/MEdZF1ov+LdQHfGsQQg2fdYeBRW2FpQlACFxXLg52L4kmUYL1Cyv0iOSHQ57tZM0
 HrRUgrDP/xfV2UqxtTd21n8+z2EXdhiJX9yKx5QttQ6sLlMG/jt+OtHT76VgCA6oKd17kLSTl58
 tS3Eclrc/1Z47riDiwKAqk6iqpN66NE1gVqf0dSrd4GqJy7EjQVDLbl8h+FxAqjI0mTCrp+y37/
 Bpl2sMwEUkwnMFbkp6QmzTFbOIJL1hUUSPS7/LWIOhVu4=
X-Google-Smtp-Source: AGHT+IHQNonhEgilS57+dK9QsUv61vNu8G75Wnu7JcFl9Yvskq0GZBts/p1M7CkrjuqYkfXEQjtw/Q==
X-Received: by 2002:a17:907:9726:b0:af9:5366:b42c with SMTP id
 a640c23a62f3a-afe07d4c190mr19252366b.59.1755724794237; 
 Wed, 20 Aug 2025 14:19:54 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:53 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/10] hw/pci-host/designware: Fix I/O range
Date: Wed, 20 Aug 2025 23:19:28 +0200
Message-ID: <20250820211932.27302-7-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
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

Fix the size of the I/O space to be 64KiB, as defined by the PCI
specification. This fixes illegal memory access by guests in the
imx8mp-evk machine such that the FSL_IMX8MP_PCIE1_MEM unimplemented
region can be omitted there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 7342207eb3..1e29b7e6be 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -684,7 +684,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                           "pcie.reg", 4 * 1024);
     sysbus_init_mmio(sbd, &s->mmio);
 
-    memory_region_init(&s->pci.io, OBJECT(s), "pcie-pio", 16);
+    memory_region_init(&s->pci.io, OBJECT(s), "pcie-pio", UINT16_MAX);
     memory_region_init(&s->pci.memory, OBJECT(s),
                        "pcie-bus-memory",
                        UINT64_MAX);
-- 
2.50.1


