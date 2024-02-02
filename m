Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB571C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvav-0000Am-0p; Fri, 02 Feb 2024 10:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvas-00006B-8j
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:42 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaq-0004R3-LV
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40fb804e330so19839685e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888199; x=1707492999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fNKMg/ZJY1ZR/wqUXxwkSX5uKgQGaWhsDdzDVMFs6JA=;
 b=eBxRUWviyRJKrmMJ5jL7eI7MQG27cqRh9/OmsryNURJIYoesqwKL7LH6rdJ8aGrwsP
 RfQpqOTblLmJZZSRBERooG2OuPiq4P4jW43B8UGl8AvFwRPQSBmkCSUZDUgqbR9QGPtm
 cSG8AgB1Thk7qKLh0BysvoMngUnhfwPSGALkbNX3sgc/8NNzzS6oeO1+pO8OiBQ1GMVX
 yvyIZBfjUS5tS9lvRwLlPoBJH4Dg/gAQqoeP/B4JY1pwXqmSpYKAg+qJePJGN1qiU5mo
 mvk4l7llveiEQtozRI3xlCgmgLXHmrcIpG+B4Q5uXDD+GTopO+x1ZJX5xFJx4u1zcP8o
 vgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888199; x=1707492999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNKMg/ZJY1ZR/wqUXxwkSX5uKgQGaWhsDdzDVMFs6JA=;
 b=l1A20Ww7LHcLQKydv6kIxsFSFsynheWUs6AADbVyPxPcCkpGuO54UYrKI2vy+XXRtL
 SFWhwHlDn/M7rJFUfa6RtpqQ/Ist79V1E76fhn01vSCqPvuYgvVi/w23DrHTGkWzoc9v
 a56RUD7DFpWaU+xRNPygiC6B4pwlgnqZtjicEeR6/mIE3DjGpbUXNuyiKDOrVjHG8x/v
 ddwmcmu2IBoSZSsLcAsqPK7jn1yYDtQi8tlfs4sejWKejOtrRiKqqTO+l26KgIRfQlu+
 SIf4F/jDEkEdt5f7Ys4YVxAR/HTzFdtV0FJTv0/w9dyEWhgH4DwnlTEyWYy7JKNkoJdZ
 3TcQ==
X-Gm-Message-State: AOJu0YwEU+CADU0DwJwl4z4Ak5HwmlM9PI/R/jFixNEF7xNI/DZ+aNbX
 ZsDvU29DHq9Pm+1j5wwbbhr2HUni8Lput7/bkdBY2n7MMgkw0pbU+kaEhyj93juawym7Ln+Arj3
 g
X-Google-Smtp-Source: AGHT+IEZtUOeWfpc403KiSe8H004+a6L1umJQdBcmxFPFyn8FXGuS1fNUn6FWMDEJDsPPHEeiVOqMQ==
X-Received: by 2002:a05:600c:4f95:b0:40f:b01d:6194 with SMTP id
 n21-20020a05600c4f9500b0040fb01d6194mr6283911wmq.30.1706888199186; 
 Fri, 02 Feb 2024 07:36:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/36] pci: Switch bus reset to 3-phase-reset
Date: Fri,  2 Feb 2024 15:36:03 +0000
Message-Id: <20240202153637.3710444-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Switch the PCI bus from using BusClass::reset to the Resettable
interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-id: 20240119163512.3810301-2-peter.maydell@linaro.org
---
 hw/pci/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580d..05c2e46bda5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,7 +64,7 @@ bool pci_available = true;
 
 static char *pcibus_get_dev_path(DeviceState *dev);
 static char *pcibus_get_fw_dev_path(DeviceState *dev);
-static void pcibus_reset(BusState *qbus);
+static void pcibus_reset_hold(Object *obj);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static Property pci_props[] = {
@@ -202,13 +202,15 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     PCIBusClass *pbc = PCI_BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->print_dev = pcibus_dev_print;
     k->get_dev_path = pcibus_get_dev_path;
     k->get_fw_dev_path = pcibus_get_fw_dev_path;
     k->realize = pci_bus_realize;
     k->unrealize = pci_bus_unrealize;
-    k->reset = pcibus_reset;
+
+    rc->phases.hold = pcibus_reset_hold;
 
     pbc->bus_num = pcibus_num;
     pbc->numa_node = pcibus_numa_node;
@@ -424,9 +426,9 @@ void pci_device_reset(PCIDevice *dev)
  * Called via bus_cold_reset on RST# assert, after the devices
  * have been reset device_cold_reset-ed already.
  */
-static void pcibus_reset(BusState *qbus)
+static void pcibus_reset_hold(Object *obj)
 {
-    PCIBus *bus = DO_UPCAST(PCIBus, qbus, qbus);
+    PCIBus *bus = PCI_BUS(obj);
     int i;
 
     for (i = 0; i < ARRAY_SIZE(bus->devices); ++i) {
-- 
2.34.1


