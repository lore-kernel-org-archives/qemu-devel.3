Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25926C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Kzm-0000Jf-U0; Fri, 25 Apr 2025 11:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kzi-0000Gy-FS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8Kzf-0003ZJ-7d
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so26264915e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594973; x=1746199773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDeK2OgzN2P2mbb8Tyis2S5kU/yrfY2rgHLC/uGH9B8=;
 b=K4SaGfamANQ7k+pNMlr4S0Ydhd8TtzzpcyNB9W1Ufhl5r1QE0cVwP5KBcP3ZLp3Dmm
 19pLZ/dckdt0eF/rAaKwCsDRgzFaEH6Q/MVJLraZr1QBuy36XfiaS2HoYE313fLfMJBY
 4Ll33OxqehmhpqOv/HdgOYsbcbVX8NcAO7kaNNSxoyJG6BxTRg7c5c4GoCYHgsYTUpkV
 2vCpA+UbP0azGMq8mjIccfgsvyudbXHGHtGn5qh6vDP0DurC+zI1wkOL+Ae6eVk2tmaV
 3XM0gpCXB3xc/7JG0VWNmxK/Ux7a3Lt5GQiOdO1nXA/sa2jAmOPyjg5RtwzLLujYJOr1
 vTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594973; x=1746199773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDeK2OgzN2P2mbb8Tyis2S5kU/yrfY2rgHLC/uGH9B8=;
 b=VC/87Cm87Xrp11yVPhaXPoyUgp6EYKhpJKEveFad0aoI19Ut988bRy2tvv5ozsfBp5
 rhLI6weAknt9KwowLNEkcS4ug2x37gcLnoYDBH0m5rKJ1FTvrf1paM7JRNyAAfuojdXF
 h9AtDEATHFL0Kn+4ImminYXnD5Pe9kzFCqjq7nidtRqwX0N9K/DT7h/FbkNDQwvZPuuc
 hOfwU7wEhm5JprgVZLxq37cv+WxUfxM8x1k0Lw3pX4b8NbzwXZnQp3eoO9BuJHxxJviP
 8O4qHL9RyZxXGqoyX7UJ06BNdFcfcJFyf9t4exaAGzbN8O0lVCcc5GQIfYpAhOax1wDJ
 tBRw==
X-Gm-Message-State: AOJu0YxkXSPAeQck/3YjoxaGDgwtrlXu7QiKFKdihNMNeurZR1r/syX3
 CdCS7re7PJ3ExhwgMuMw7pGhJVR8QcGISfkQ27+YRoT/AfAx6kkXc6V7oWgeScQ4qYolaaZnrCo
 0
X-Gm-Gg: ASbGncs2pjiTcnuw9asDTAv17+YFZPvP73yQUU1lYRWPjrHBC0nDQ7Cywue2sfnrcMn
 6TNB0naxW34hg1FEnX4bAN5I16XOZtgSoYCfrPv9dods0HvOPk6zGJTYnoZdZFjTVyj7IT1oOsJ
 cvBYLqBWEv/YzLK2acV5/PcX1mdahnhivHvVUNGhoXb/OmnTdFdvYmKKujkHwcy+SPFts05rXQC
 NmLnB30G4i+m0L9ZJHaEhzvIS5XvmNhm1U1sodgr36BvUMLBn3gLSWvimigK04TVWa2BIuGTtTx
 elgBVhnJPqMZp3dBSiFILEJXJhrLEhYsUuX/8jO3VUCkvqmXS8iaEXDxHLiyY+ciboFVTl6f+x6
 c5go7LJ8tJVyxXk8=
X-Google-Smtp-Source: AGHT+IFjD+H6lueYbYeVkK/+gDvAJSfBFBormjGh3T+fbRHyh6addhdZcPjTQ7oTnGPsfZ3BdbclLQ==
X-Received: by 2002:a5d:64a3:0:b0:39f:bfa:7c90 with SMTP id
 ffacd0b85a97d-3a06d66cfb5mr6043146f8f.13.1745594973234; 
 Fri, 25 Apr 2025 08:29:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c82fsm2608749f8f.85.2025.04.25.08.29.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PULL 10/58] hw/pci-host/designware: Use deposit/extract API
Date: Fri, 25 Apr 2025 17:27:54 +0200
Message-ID: <20250425152843.69638-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Prefer the safer (less bug-prone) deposit/extract API
to access lower/upper 32-bit of 64-bit registers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20250331152041.74533-3-philmd@linaro.org>
---
 hw/pci-host/designware.c | 48 ++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 5598d18f478..9c3a5f8d910 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "qemu/bitops.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
@@ -162,11 +163,9 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
         break;
 
     case DESIGNWARE_PCIE_MSI_ADDR_LO:
-        val = root->msi.base;
-        break;
-
     case DESIGNWARE_PCIE_MSI_ADDR_HI:
-        val = root->msi.base >> 32;
+        val = extract64(root->msi.base,
+                        address == DESIGNWARE_PCIE_MSI_ADDR_LO ? 0 : 32, 32);
         break;
 
     case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
@@ -190,19 +189,16 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_BASE:
-        val = viewport->base;
-        break;
-
     case DESIGNWARE_PCIE_ATU_UPPER_BASE:
-        val = viewport->base >> 32;
+        val = extract64(viewport->base,
+                        address == DESIGNWARE_PCIE_ATU_LOWER_BASE ? 0 : 32, 32);
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
-        val = viewport->target;
-        break;
-
     case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
-        val = viewport->target >> 32;
+        val = extract64(viewport->target,
+                        address == DESIGNWARE_PCIE_ATU_LOWER_TARGET ? 0 : 32,
+                        32);
         break;
 
     case DESIGNWARE_PCIE_ATU_LIMIT:
@@ -321,14 +317,10 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_MSI_ADDR_LO:
-        root->msi.base &= 0xFFFFFFFF00000000ULL;
-        root->msi.base |= val;
-        designware_pcie_root_update_msi_mapping(root);
-        break;
-
     case DESIGNWARE_PCIE_MSI_ADDR_HI:
-        root->msi.base &= 0x00000000FFFFFFFFULL;
-        root->msi.base |= (uint64_t)val << 32;
+        root->msi.base = deposit64(root->msi.base,
+                                   address == DESIGNWARE_PCIE_MSI_ADDR_LO
+                                   ? 0 : 32, 32, val);
         designware_pcie_root_update_msi_mapping(root);
         break;
 
@@ -355,23 +347,17 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_BASE:
-        viewport->base &= 0xFFFFFFFF00000000ULL;
-        viewport->base |= val;
-        break;
-
     case DESIGNWARE_PCIE_ATU_UPPER_BASE:
-        viewport->base &= 0x00000000FFFFFFFFULL;
-        viewport->base |= (uint64_t)val << 32;
+        viewport->base = deposit64(root->msi.base,
+                                   address == DESIGNWARE_PCIE_ATU_LOWER_BASE
+                                   ? 0 : 32, 32, val);
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
-        viewport->target &= 0xFFFFFFFF00000000ULL;
-        viewport->target |= val;
-        break;
-
     case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
-        viewport->target &= 0x00000000FFFFFFFFULL;
-        viewport->target |= (uint64_t)val << 32;
+        viewport->target = deposit64(root->msi.base,
+                                     address == DESIGNWARE_PCIE_ATU_LOWER_TARGET
+                                     ? 0 : 32, 32, val);
         break;
 
     case DESIGNWARE_PCIE_ATU_LIMIT:
-- 
2.47.1


