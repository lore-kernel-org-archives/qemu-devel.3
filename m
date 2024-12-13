Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D150E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB7F-00070J-TG; Fri, 13 Dec 2024 14:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB71-0006Hi-7P
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:08 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6y-0007WY-1g
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:06 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2a3c075ddb6so324162fac.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117241; x=1734722041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdpsJAhLYte2lIkZLag9WCSXb1FF/foqWHpt7GOwf7s=;
 b=bnHlpISBDSoPoBKNV7266WyYnn1Q63g1/bdLGaJmYHczIG2t6sdSpJZP3h+BzBRwZ3
 F6qCAfheX4xeGkENvYO6V3K+hJDuyC7S49r4TCsh9OBR68eXnbeaccdYL5vCcqLw+5Wo
 XTCk19t03acNLQYMFss5R3UOPTqYtM6qOajDFUJcv5L/GBOFtxz57D/jjeYycixTLy6x
 AV+v4G3sCHW9wVZaxy/WdKIBZ7tM75nZRQ3c8+cWJw5xBS1ed3w/88KzRRvhAaqY3v6+
 HuGkhfwWZ/dTb7XXqJ5XEKSovNuOjGw8XXOIc1DqsxxS2XgETcE8QIaXFX28jvo3zgnI
 elFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117241; x=1734722041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdpsJAhLYte2lIkZLag9WCSXb1FF/foqWHpt7GOwf7s=;
 b=ftFp0weP535HJ+ZSxb9zZi0N7kNERInQoME8mRBZbT5O9w3rMIuXXfK5J9pVIZTCWv
 GoU9rBhpdnmXASM9kJIsehVP7gJXR+JMzOXwYVi2gsJu/7GjOpFaeFKo9YulY0YHHWW9
 d96vBiVYYocyHAb+pAMSq6hs0bAvdjUBdx4+oYABN+hKS0ci2heZAtwh1FiEAloX688q
 6h4pVBImFZE58VLRhFytBDdXeIP6vvY/n6ATCZuQErPlSKUODpB+Ou8VIVEO3NMbuxUg
 qqmcYqwqEPzu0tcOSQxhyf81Yybh2ckjT0Ds1a6rzzEWarU1JIFWgqCJLi3BNF1dyFYJ
 npRA==
X-Gm-Message-State: AOJu0YwsyuSVEhA77sTJjs5PEM7xUR+Z3Mw6bLocEte7MoCg7rwn2f2K
 4xz4epJpz0uTQ7mSoC5fhpSv5lwS3YHpXhWsa2NiOcux6EYiyRaAi7KlTNNynbw3tqn1fSo9Ho9
 n9cD3G1ye
X-Gm-Gg: ASbGncuIetPm1Ut9/pG2ppcfVbjFuCmGLkemx07sNc5jBkXKL++ouhvtG0IqK6dJWsT
 GbizjHutuFqU8YDcVgJ+S2HYIXyB9kDzi22DU9a/qJjOhTYkZMng+yCcc3QKs7m3HmGD4m/GFiF
 1nFtEFIKB4WYtHYw5s/nb3/z8B4Pfo0rR/5Yv99gfBQewu90tLK6ayn8cEbfHDJrznAKz6D5ON+
 pKCos6+VpQM8Z5+i+JSu5LTuYas+xh+4svcZxC79Gmls9E8WBS6oizkcWj2D7zm
X-Google-Smtp-Source: AGHT+IFsHptExUFZoIZGsWk4RbguT+pzFk1ZOSTmP02DvjFOwa0fsQPzBP1gF5rpWWL+m1cHt/goag==
X-Received: by 2002:a05:6808:151f:b0:3eb:5f1a:d083 with SMTP id
 5614622812f47-3eba6896469mr2487136b6e.20.1734117241423; 
 Fri, 13 Dec 2024 11:14:01 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 45/71] hw/pci-bridge: Constify all Property
Date: Fri, 13 Dec 2024 13:07:19 -0600
Message-ID: <20241213190750.2513964-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
 hw/pci-bridge/cxl_downstream.c      | 2 +-
 hw/pci-bridge/cxl_root_port.c       | 2 +-
 hw/pci-bridge/cxl_upstream.c        | 2 +-
 hw/pci-bridge/gen_pcie_root_port.c  | 2 +-
 hw/pci-bridge/pci_bridge_dev.c      | 2 +-
 hw/pci-bridge/pci_expander_bridge.c | 4 ++--
 hw/pci-bridge/pcie_pci_bridge.c     | 2 +-
 hw/pci-bridge/pcie_root_port.c      | 2 +-
 hw/pci-bridge/xio3130_downstream.c  | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index c347ac06f3..cfe50e60e9 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -212,7 +212,7 @@ static void cxl_dsp_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-static Property cxl_dsp_props[] = {
+static const Property cxl_dsp_props[] = {
     DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 5e2156d7ba..5824ba3c75 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -199,7 +199,7 @@ static void cxl_rp_reset_hold(Object *obj, ResetType type)
     latch_registers(crp);
 }
 
-static Property gen_rp_props[] = {
+static const Property gen_rp_props[] = {
     DEFINE_PROP_UINT32("bus-reserve", CXLRootPort, res_reserve.bus, -1),
     DEFINE_PROP_SIZE("io-reserve", CXLRootPort, res_reserve.io, -1),
     DEFINE_PROP_SIZE("mem-reserve", CXLRootPort, res_reserve.mem_non_pref, -1),
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 55f8b0053f..ef94aa3654 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -362,7 +362,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-static Property cxl_upstream_props[] = {
+static const Property cxl_upstream_props[] = {
     DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
     DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLUpstreamPort,
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index 784507c826..c319ca8263 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -128,7 +128,7 @@ static const VMStateDescription vmstate_rp_dev = {
     }
 };
 
-static Property gen_rp_props[] = {
+static const Property gen_rp_props[] = {
     DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort,
                      migrate_msix, true),
     DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort,
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 8e7f926621..35a37e056a 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -168,7 +168,7 @@ static void qdev_pci_bridge_dev_reset(DeviceState *qdev)
     }
 }
 
-static Property pci_bridge_dev_properties[] = {
+static const Property pci_bridge_dev_properties[] = {
                     /* Note: 0 is not a legal chassis number. */
     DEFINE_PROP_UINT8(PCI_BRIDGE_DEV_PROP_CHASSIS_NR, PCIBridgeDev, chassis_nr,
                       0),
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 07d411cff5..01997c1ab3 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -420,7 +420,7 @@ static void pxb_dev_exitfn(PCIDevice *pci_dev)
     pxb_dev_list = g_list_remove(pxb_dev_list, pxb);
 }
 
-static Property pxb_dev_properties[] = {
+static const Property pxb_dev_properties[] = {
     /* Note: 0 is not a legal PXB bus number. */
     DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
     DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
@@ -507,7 +507,7 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
     pxb_cxl_dev_reset(DEVICE(dev));
 }
 
-static Property pxb_cxl_dev_properties[] = {
+static const Property pxb_cxl_dev_properties[] = {
     DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 6e8d7d9478..8834ff3dbf 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -124,7 +124,7 @@ static void pcie_pci_bridge_write_config(PCIDevice *d,
     shpc_cap_write_config(d, address, val, len);
 }
 
-static Property pcie_pci_bridge_dev_properties[] = {
+static const Property pcie_pci_bridge_dev_properties[] = {
         DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi, ON_OFF_AUTO_AUTO),
         DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 09a34786bc..a7f87a1bc4 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -148,7 +148,7 @@ static void rp_exit(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-static Property rp_props[] = {
+static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 473e2dd950..92e5fb72ec 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -134,7 +134,7 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
     pci_bridge_exitfn(d);
 }
 
-static Property xio3130_downstream_props[] = {
+static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


