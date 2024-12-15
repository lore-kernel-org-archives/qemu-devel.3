Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE00FE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu00-0002z1-S7; Sun, 15 Dec 2024 14:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzq-00022b-KJ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:42 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzn-0001UV-6D
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:41 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e16519031so1794588a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289777; x=1734894577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+gk5HJw1iEsGhk9+lmLncqMRFX0RNw29XKNkIMEgog=;
 b=kye0pV7Da3fWf3vzFLzz1UhBX8tySQPbY+ZbYCPME0/K8rGoCfv8ZbjkfQ3m/ZP400
 scKzcjB8DFVZDT0MLwNyEt8bDsy0i8B25TGuiLKBj75O+DMhBW+VryVDZ+wExk62NUGP
 XgaukX/YXHBnHTlwoOvun0DD0nNxgymGykHONsyLIGrYeBZfyX3xyD1TiexnUPdYQLcg
 AXQEF/yniUHnegFnEQd2qmgn+Lo+4jCefD8mPa+ZwRR7IZRpwG0shUdRsIe1F5Fr1XQb
 IwdLAf6BZe8jvzeDr+Cj1jwqn+Lvgpo1gW5KzvPo5L4PLsSAh3XvmFit3zKyDieCE2/b
 UXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289777; x=1734894577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+gk5HJw1iEsGhk9+lmLncqMRFX0RNw29XKNkIMEgog=;
 b=YE5wY7dRSktsTsQF15EFWVvQL0gZag5Mfz1mKtEfV3pFQkbWngVYTudRvFyN98/Nsp
 cw7UQi2DfPiKdK99JhVi/GBSQ110HsUoy+gKpoS/1n6Uj8MCCg4v9EJ99LtJ/zgMJIVq
 C2kwxY29p+3uXVnja/gwyYtfj316I6zMBq4lziRc5/4EhJVOSy7zL70kCL0dmo5SH1Qz
 KkqCbp2U/lZCGLzL7XbK/+yHlT1vRwbk9kPKSO1UqLB1ChuI7SnusI59YHWXjOF/I4qM
 jJrl5dRIUhZyVzhEDctEKJruo5hE9mP4GAhDkxRz8UEujGQb5gSQtMqrxVuuZJ5AZZ9l
 0OiA==
X-Gm-Message-State: AOJu0YzzOQnyeq9UCxEahDKGAWU8GjcEzGqVY1+26zHoKVdqLY0RYPsF
 9xLGkqIb18GMhJB0sUQxeCr//Sz49R2T2bY6xxZDeEcIwy+6XszkZVkIpuwAv3+PNe7xH5fvSvr
 F9FnQ7Xq8
X-Gm-Gg: ASbGncv6GEWPTHeFb6uu9Nt4nIgzMR83Xw5VApElYPCyHH1avBnZVP1hUgdVQV4WMOy
 IUAPf2YP24CzkAThCm77h97+pC3rKpRmq74S5a778y83TYwRn9SOYL/1/e6HDdOgJxpPNqFTcwN
 zApY8CitLwvHzo8fS8QhcseawGtMJ9yNcjAADxWfTdax8Q3n4BGwckIGWKonxSotS+7j4BZvVZd
 6QEnSmJX9afjo2mye8sbz4uXgX5K4HY0G2nD2xXgNWGT1gv9ntoPdWTWjeEuJ+jvPGZZTWYa60p
 y22wpartEluYdmZBuM92d5Ul6YqZo2UgjvOlaS14CZk=
X-Google-Smtp-Source: AGHT+IEt+ATd0NV25KDgu0/dbIYjoKONuiMbojqXmTBFF7Jr29m3Rs5OrcWuqUxLZsi1RYqR8RYMjA==
X-Received: by 2002:a05:6830:c09:b0:71d:e5e2:c648 with SMTP id
 46e09a7af769-71e36bcf82bmr6055095a34.1.1734289777612; 
 Sun, 15 Dec 2024 11:09:37 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/67] hw/pci-bridge: Constify all Property
Date: Sun, 15 Dec 2024 13:05:10 -0600
Message-ID: <20241215190533.3222854-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


