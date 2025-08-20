Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A60DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDz-0005MS-PP; Wed, 20 Aug 2025 17:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDx-0005L0-Eu; Wed, 20 Aug 2025 17:20:01 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDv-00051X-LV; Wed, 20 Aug 2025 17:20:01 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6188b7550c0so522348a12.2; 
 Wed, 20 Aug 2025 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724797; x=1756329597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erIPPZ0BDsRCUdIVCLWmsfKr2++tLsVOASTjdmVI5yc=;
 b=YBbOKNpfp9LF6wqvn8eZ0U6NThkb4auFhWQa0diYcc6jTN2llYT2v7DLeS//0PvqFT
 J4q1CSk6lFTj7bfXBwZfzzJfIHU/HpMyRRr607nBQkuaK9EjrQQpONo83L7h1q+gZzn1
 fL4muHTpWvhao6RHxJIel5GbQuD4NO/FXb7JuwRkth881mufst5w2swGDrmkmLTcMclK
 VpDMKa6QswZdUbJ69euMGN9R5Al9Iq89olYNb0g29dRKH2f8i7YoLM6cdvWDwiY25+sh
 Ql8nikAPKADNOGKezyWVkyb93RXLY7IMBNsuiFZEMlla3MqZHv//PgRM/3WGVTxV8PxX
 G8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724797; x=1756329597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erIPPZ0BDsRCUdIVCLWmsfKr2++tLsVOASTjdmVI5yc=;
 b=pAQejMq1UvzZWmKo+u65m8ysvCn1rVj0T8t2sm+6/rC/HbXQtE754NK3LNGmRMbNKG
 K0Uz8N3ov3+RJ1hw2igK13T5h+m17qUsk1x6dd3yvxYEgiaeMnH5OpVp0JX4NOsgr9i3
 48Fm6TjQ9YvoBqI2/I2dTuJ+YrxHTM6E3DJeCPfH57bUBt7wKo+E9YZQy113P6MoBW1e
 XvBKDpMud2UzC1oj1T3SGO2y6eWDf8VtEdFGgKZStrqR+vtM/8m9L6LV2YRONoLcvesU
 WA/Jswez/4kesTYCpdzM0j+AbLaR+e/jDtNA1z+WBvTY1i/yluRVpGIb22ne1ZCwXUcI
 +VdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWw5u5I1Sg3KYhM4Fwpfsqm9cs9AovOET0LuS7nHvZs0DgSpJhYXlNePAYOEliDk8Gs0KXg6aUVw==@nongnu.org
X-Gm-Message-State: AOJu0YzcO57cTz1tRc90onBgWx1GFkpjnBaUfwsCayiCHsjMcj9DcgJI
 5c7BGnJkvUgu+tmNj+RvYDW51FCtpK9xDJuw/nDPyv624s2GjhxTY0SFq7j2W1Fy
X-Gm-Gg: ASbGncvg0SDI7/xsxXbftAky4HOUA/G+R5+YA7YxX2oyt4tInuNBTB3wWt5bokwEioG
 klcGvw1sNPk2oNqQihoxPf49v/CRVzuHTz8VSJOjauK4Jjc5tRoWF0keTIqOYr2lx1e4Ng9ZzF6
 4bofroO+Xoh0UGcKbFql6ow0zoby3yKXrCWWCVRDI5+IcfSNrtgpOrwkBK30RC4wLP11a6stWDb
 pBnbrdQTBIitmtL04v+FH04nWXsVNOed6H1rw0Hhj/ndb2+zGTikXH+6EvTM4FlXdL72VPN8H8D
 FPFsluNy0UWckFEDBms9PggMsPvwa/hrv7Ghpm4lN6a2+0QoIiSftPBk/hUPtYqk3NjXaiNl0P8
 tdZH5jaPg2bsPFlX/7JlPaWw1TP008FmhRmHgOwx2KZt/ZggQzrv2/e8gs2jE3Qe5Z0QMvuY4eM
 FBQ5a2mp2n0MpB2l/fbxrRAUnjlBKN3ML8NiQZe8VXGnw=
X-Google-Smtp-Source: AGHT+IES/X3jCpVFBPW5Fsn92ctVYmmPEMPSTxTY0WFkFFZKPEj8f2/e09b38dVW/YzW7cnyR8Jyqg==
X-Received: by 2002:a05:6402:2749:b0:615:6a10:f048 with SMTP id
 4fb4d7f45d1cf-61bf88481dfmr122754a12.33.1755724797160; 
 Wed, 20 Aug 2025 14:19:57 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 08/10] hw/pci-host/designware: Fix default inbound viewport
 mapping
Date: Wed, 20 Aug 2025 23:19:30 +0200
Message-ID: <20250820211932.27302-9-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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

Linux clears all inbound viewport mappings which results in the default mapping
set up during realize() to be cleared. Fix that by introducing a fallback
memory region which gets enabled if no inbound viewports are configured, as the
real HW would do.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/designware.h |  1 +
 hw/pci-host/designware.c         | 30 +++++++++++++++++-------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index 34beee1285..342b09fd08 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -86,6 +86,7 @@ struct DesignwarePCIEHost {
     struct {
         AddressSpace address_space;
         MemoryRegion address_space_root;
+        MemoryRegion address_space_root_default;
 
         MemoryRegion memory;
         MemoryRegion io;
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 2fd60a4817..d71133a456 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -347,6 +347,17 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
             break;
         }
     }
+
+    bool one_mapped = false;
+    for (int j = 0; j < DESIGNWARE_PCIE_NUM_VIEWPORTS; j++) {
+        one_mapped |= memory_region_is_mapped(&root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][j].mem);
+    }
+
+    /*
+     * If no inbound iATU windows are configured, HW defaults to
+     * letting inbound TLPs to pass in.
+     */
+    memory_region_set_enabled(&host->pci.address_space_root_default, !one_mapped);
 }
 
 static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
@@ -477,19 +488,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
             viewport->target  = 0x0000000000000000ULL;
             viewport->limit   = UINT32_MAX;
             viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
-
-            /*
-             * If no inbound iATU windows are configured, HW defaults to
-             * letting inbound TLPs to pass in. We emulate that by explicitly
-             * configuring first inbound window to cover all of target's
-             * address space.
-             *
-             * NOTE: This will not work correctly for the case when first
-             * configured inbound window is window 0
-             */
-            viewport->cr[1]   = (viewport->inbound && j == 0)
-                                  ? DESIGNWARE_PCIE_ATU_ENABLE
-                                  : 0;
+            viewport->cr[1]   = 0;
 
             designware_pcie_update_viewport(root, viewport);
         }
@@ -706,6 +705,11 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->pci.address_space,
                        &s->pci.address_space_root,
                        "pcie-bus-address-space");
+    memory_region_init_alias(&s->pci.address_space_root_default, OBJECT(s),
+                             "pcie-bus-inbound-default", get_system_memory(),
+                             0, UINT32_MAX);
+    memory_region_add_subregion_overlap(&s->pci.address_space_root, 0,
+                                        &s->pci.address_space_root_default, -10);
     pci_setup_iommu(pci->bus, &designware_iommu_ops, s);
 
     qdev_realize(DEVICE(&s->root), BUS(pci->bus), &error_fatal);
-- 
2.50.1


