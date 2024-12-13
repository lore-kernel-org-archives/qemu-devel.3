Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13809E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB8M-0008NY-F7; Fri, 13 Dec 2024 14:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB77-0006SR-4A
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:13 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB73-0007Xv-E1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:11 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f2e13cb356so1021794eaf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117247; x=1734722047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMNcGFi52Uwl+0HNftyeCD60t2xD+7lCeBeevmzpoWs=;
 b=iyWsTBuLKPHUdXwDzfi00LOYT0qzHPApxCPp99gSKCRWdMcxx1Ad0BSFv0Z5pHLvUC
 37deW9rCH2botfJhwpDtTQwa73HH0afxY+Ffr7AL0w0pzsUlxM7SFPXZQ2QH/QV0VgLj
 uZF2oDei6/EAGTj6cZSSvF5jM9mO6mNFA+cAgscpNfq2U1vQ7ZuCSLJYfvoHRUqxwMlp
 AuvBHVOvxu1YLLEqnj43sq/UZJee29ePT+XbGVqLiE4NjOUpHai2PYZpkvvjRxjro8VT
 wD+q6cc6sciEoM5h1kKdr2OXEHDtJwAoXz3GhqEgMXTwHAQ+rueiSl9aFOSVT33RkQkb
 C/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117247; x=1734722047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HMNcGFi52Uwl+0HNftyeCD60t2xD+7lCeBeevmzpoWs=;
 b=qMM2rhfxCd5/rqkd/mKwIOEIOJpnJ2LQFz1VXjoW3kqlSYItYiCxlAT6JVvxR2+WBD
 S/q3CEIxu9zhdWD6WDIWmeqhjxCenP7rU3XgPCqnAB9t28iwO/Q1xYjtTZSgKab/9Nwf
 +kE0CqYCiMM1K4hXs+k/aABjTtsHO4luqZEotb6DUK5h5mGnQBOyKpZ55FinSXVPl/Om
 EdfbHPzQ2dDLk6yrS63JwYw7TPd2wxjiVWRUK5pdqzmBFQ7aHsda8ldROOhHaUQqr4n6
 G5tzvCa5Okgmo1MDwkMdu1VkDu3zH1RhdJ3VbgBlia8GD/qEa22ECuGn0JpdAK8+vf5r
 IMQA==
X-Gm-Message-State: AOJu0Yzf7RDI7ZehMgSZEYI4gC4h+6lWx/bYvG0E3DernQR7SEr3Naq1
 vRjhMjg/pMMlTPGJUPQHlXspQXOBGceUN3dzmCMCh0lp936hs3ClvGSfpASClmYcootO2e8PCfc
 ocdMlNwQm
X-Gm-Gg: ASbGncuLa7FYPkWC/a6ul1x4gFTCZZ/mgBnmha7Rzofn41tsKReftyw47ol1GPPHt5J
 tdfRhOSSXAroBbwEdzIhk1g8Fnu3YF+QUrdY1g6vxnIv5zomNL1Y3s3v+aHQaVUysUHwIiv5Xy9
 yMvJ0X2yNF0UM5LhJpXeAyFM3l4b0y77iOZV0GSkW5sOYFCsHO26H619SI8YhWXDBzCyWwRGwB4
 C/bMHaqyXhBye+4C3VNcAMevZ7aWx2q+b0yXFgWkP+t1CJnOLSjjmGa0fKmf/le
X-Google-Smtp-Source: AGHT+IHhSE/5W3yMzeW4V02i7KSNJxp1aEhHFhHZaus8WJZptCnJKshYPKoKfZ5NdZD8PdE59yK1sA==
X-Received: by 2002:a05:6808:3985:b0:3eb:a0ce:f3c2 with SMTP id
 5614622812f47-3eba6987cadmr2320350b6e.40.1734117247616; 
 Fri, 13 Dec 2024 11:14:07 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 48/71] hw/pci: Constify all Property
Date: Fri, 13 Dec 2024 13:07:22 -0600
Message-ID: <20241213190750.2513964-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/pci/pci.c        | 2 +-
 hw/pci/pci_bridge.c | 2 +-
 hw/pci/pci_host.c   | 2 +-
 hw/pci/pcie_port.c  | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1416ae202c..c38b674211 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -80,7 +80,7 @@ static const PropertyInfo prop_pci_busnr = {
     .get = prop_pci_busnr_get,
 };
 
-static Property pci_props[] = {
+static const Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 2c7bb1a525..dd4fd3674f 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -477,7 +477,7 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
     return 0;
 }
 
-static Property pci_bridge_properties[] = {
+static const Property pci_bridge_properties[] = {
     DEFINE_PROP_BOOL("x-pci-express-writeable-slt-bug", PCIBridge,
                      pcie_writeable_slt_bug, false),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfe6fe6184..321e7be709 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -240,7 +240,7 @@ const VMStateDescription vmstate_pcihost = {
     }
 };
 
-static Property pci_host_properties_common[] = {
+static const Property pci_host_properties_common[] = {
     DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
                      mig_enabled, true),
     DEFINE_PROP_BOOL(PCI_HOST_BYPASS_IOMMU, PCIHostState, bypass_iommu, false),
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 9f978ba164..bac2822e98 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -111,7 +111,7 @@ void pcie_chassis_del_slot(PCIESlot *s)
     QLIST_REMOVE(s, next);
 }
 
-static Property pcie_port_props[] = {
+static const Property pcie_port_props[] = {
     DEFINE_PROP_UINT8("port", PCIEPort, port, 0),
     DEFINE_PROP_UINT16("aer_log_max", PCIEPort,
                        parent_obj.parent_obj.exp.aer_log.log_max,
@@ -204,7 +204,7 @@ static const TypeInfo pcie_port_type_info = {
     .class_init = pcie_port_class_init,
 };
 
-static Property pcie_slot_props[] = {
+static const Property pcie_slot_props[] = {
     DEFINE_PROP_UINT8("chassis", PCIESlot, chassis, 0),
     DEFINE_PROP_UINT16("slot", PCIESlot, slot, 0),
     DEFINE_PROP_BOOL("hotplug", PCIESlot, hotplug, true),
-- 
2.43.0


