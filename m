Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8178C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzGwd-0007Fw-MF; Mon, 31 Mar 2025 11:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGwb-0007FA-D6
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:20:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzGwZ-0007QB-1y
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 11:20:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso31586675e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743434453; x=1744039253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXIcLIfDAyhYrdj9+q8KiZNiZrZdeQAwoIn2YrKTzw8=;
 b=owglU0D0ZMQTY/u+6nb3QGBWqa8a0yj6C0yQse3ZUMg0IzgGp9Y/dOexvXsKyQYvrh
 eEthXCgQSd+E8WfZAtE7ak+eBSnOUtqCxyhP7277EJezEX17hw8va1aQEqy7nFZ/rPjn
 0nlozGH/W3hSfc6mwmo/ACumUI929CJ/ge7Mc/BwDhAAfLsoeZrySesk9ypHYPejyuo1
 d3pMOyGm0kc31ckDL/Wb2OYR0o2w1KqwxlctMHknccmpa6Bvmwl1NutGE5m9+iclHWoT
 lHDqId2c6wqvuLinb9/uKuJ8xEJLUd2J9zvy2VbdSENkmOxxZMrG37F2tmow06oFEaMb
 zQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743434453; x=1744039253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXIcLIfDAyhYrdj9+q8KiZNiZrZdeQAwoIn2YrKTzw8=;
 b=se8029l3LzkO+gB5rMOZVT5CC7vQNppIAvM3My5mIbtGkj2srBC/A4G8ry+ZIoKZty
 Dr/cwGMbGrMBhl+Ei6Nn9JwmUi/G3omoAp1Yftre3tFJcA6okehjUcl654EKD0AP3hYa
 cGirtx7GnSGPCeB179wb86FyKJBmgFP4f0t78pnpNJiFjLZB6ZZJAx9o6yTxeJN+pesc
 Vn+pKbtj/uLSh9HdO6Tb/h0q0c2k7co0/urhu15ZvrjGC0xhkT4cmuNYWBtN4LAngmXP
 JkKGkzLvAoaxl+grQhQsRtx6TKpf74zsYjH17IXX1kaYEQiZcny7UzA0WsGcrOnkOo+f
 EgRg==
X-Gm-Message-State: AOJu0YxWuX3BlrZE46zaefmGK3meHb8T0Rj2RKMgUZf9VOvQgTyeHMtL
 M67c7QhdZp3T8di/LWaVSohBrv2ClaodRU0ezdT7tqhguE1GIrtqVxZJ+OT6nPXJL13b9yHUxXM
 n
X-Gm-Gg: ASbGnctWaDgo5Oi4dWjXgmhtacAhqmNpPJbFL4zsqbdc6nAEgnhNBF0wM7kKB0sZ6xb
 LOViYLnTGyhqxjQXazEys6aVOiufw5zYkaVozuruePtQJVKXijLcn6ZgY0xy9QD0DE8GxtGeY01
 +7WyFNk7b0J82YR1y62o51ubentPpUlYCtovUF445Qie1cJQ/DuIqt1qdmRZXa6gV/CGa64I/nb
 gKVh/qqtIQ9AFKQVJe6AFy+xrSVEeEzhPXrCi9dhfcFNfFdFXMuiJIEIppBFjz82cxTNJ/k8AgA
 4GBFNJgJSM/aKR3Fu8w/wedyULRixV067j2TwL0wvVThABlfkQFtxCRJFsQZasRboh83tDTgZ9l
 i8HOiDN8u3QOmJCLnP1A=
X-Google-Smtp-Source: AGHT+IEnClq1D5WCa5r0w2jraLAL6HRELwr7rU3epqHPKPZ/25cP5+jcNlaWqj/2ktzMiDaNffwXwA==
X-Received: by 2002:a5d:5848:0:b0:390:fe8b:f442 with SMTP id
 ffacd0b85a97d-39c12119cc3mr6632217f8f.54.1743434453205; 
 Mon, 31 Mar 2025 08:20:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a433bsm11689353f8f.97.2025.03.31.08.20.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 08:20:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>, Joey <jeundery@gmail.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/2] hw/pci-host/designware: Use deposit/extract API
Date: Mon, 31 Mar 2025 17:20:41 +0200
Message-ID: <20250331152041.74533-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331152041.74533-1-philmd@linaro.org>
References: <20250331152041.74533-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/pci-host/designware.c | 47 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 5598d18f478..3f2282b2596 100644
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
@@ -190,19 +189,15 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
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
+                        address == DESIGNWARE_PCIE_ATU_LOWER_TARGET ? 0 : 32, 32);
         break;
 
     case DESIGNWARE_PCIE_ATU_LIMIT:
@@ -321,14 +316,10 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
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
 
@@ -355,23 +346,17 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
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


