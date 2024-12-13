Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A71CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF8x-0003kG-UQ; Fri, 13 Dec 2024 18:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8T-0003FL-51
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8O-00032k-A5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:52 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361c705434so16543415e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132706; x=1734737506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhXlFUTDfxapy11V5i3YVoLs5g9dq7c+juyIoRheajs=;
 b=X4s0EIe2ELGx3YmUocM8WKb42HxZ0Xt/HaimTCUrXZjoXIZNv/JYoKVD7G53xzDSug
 VeZ+hb/OLEpePt2YkytOzeTCmqjEXhYofaVQATrO4phHoxBBGNDZJeJGctjPzeJ2Bteh
 V9FB0GPxLsL2HTrRv9fJ2ifbPlZvVwIbXDS5t+9YHi6WsH0+UG2Azb6O7Ve3YMbEEpwj
 b88P0a5QWvKtClsDakd2QLn4db1ptLeVMUR3MB78gKxlhU22z6jGFArJ2HT26EYhBTNe
 8AxgzhjaazHcW8VCWi945uEjCcAwuESoBBPkQIaDDF1CjYIFGuaL0m1dQmVix3ASyUvN
 KvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132706; x=1734737506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhXlFUTDfxapy11V5i3YVoLs5g9dq7c+juyIoRheajs=;
 b=lLyx2kMUT0N+H0GKpB2EEp7dJXAvzpOAhc3iYyoi+y33gboRYxhDq8cv8jPRT//Iji
 4/oUZFiGIyRB2PqbaJTcqNZqhJ4lz8rVwT1/9JWqrwb1cLV2NRav87MoOMFrybrYkOUC
 +E7C/QVLX9uqPyAxXyUN8Blsye49HZLhy9GyTMDXaW6pnP8AeZpX1Di6j9JMnNGB/ISf
 lGuimEM+UBp2/tyKCy/Rg6+jg85Tc35QTb1QIvP8ABQA4ALL8P74DmU6QJfPtxEHOsmN
 EPXlY2PnmSrU5qyGj7dLD2E9XLrPdTwhHj24BZPx5BcMlpFy9+GiAS00GFyNUlzEnBNk
 /kng==
X-Gm-Message-State: AOJu0YzmfEwbyOi+wM9Fwi9DZ9YMHFRLb3nVHc5Dpw0ZFYxXaV/qOsxd
 6pbCtuiHDPVNl3F/v/Wp5pcquqh7whKAtRg1Fklh74CGFz3O5uBLaGejsVsRati8FnN115ccw2K
 qdHA=
X-Gm-Gg: ASbGnctQAFFOXKXKJ2cfX64IlSPy59S2jJ1MJYKjHQ34emguh6HBpcijfb07PynbVpn
 274W1IJ+jJ5qydHq5A44Modffzj76sPZPGa88C4nbCXqYXO7tW35GntVYGncfuO1FdWmVcEaMeZ
 peCcZScSaE/BBs6Ii1mumEoWsBIfrLlRbjTPwR/PpwuWNGNvY2ql6syYdMqt1m83Rr8N5tCR6ss
 luOW59IrN/hDbcOAuXrpg3XcsYycYvhxYBVUOhPLR/HnDxhsjoy56/kLBZlqV9VGISgFEB4Dyy6
 QBs3eQ==
X-Google-Smtp-Source: AGHT+IH3WKCEb23Uu+7a+fKhpD0efJgn+t/Jd91Cxz11VZGiW6ikpYJy3AoRrpT+NdYDsaozVgjcEA==
X-Received: by 2002:a05:600c:4f07:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4362aa50f6emr39461595e9.17.1734132705994; 
 Fri, 13 Dec 2024 15:31:45 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162b1sm827473f8f.38.2024.12.13.15.31.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/20] hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
Date: Sat, 14 Dec 2024 00:30:44 +0100
Message-ID: <20241213233055.39574-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

pci_bus_add_fw_cfg_extra_pci_roots() calls the fw_cfg
API with PCI bus specific arguments.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241206181352.6836-5-philmd@linaro.org>
---
 include/hw/pci/pci.h |  3 +++
 hw/pci/pci.c         | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c0717e31219..603c456c3a8 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -297,6 +297,9 @@ int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
 uint32_t pci_bus_get_slot_reserved_mask(PCIBus *bus);
 void pci_bus_set_slot_reserved_mask(PCIBus *bus, uint32_t mask);
 void pci_bus_clear_slot_reserved_mask(PCIBus *bus, uint32_t mask);
+bool pci_bus_add_fw_cfg_extra_pci_roots(FWCfgState *fw_cfg,
+                                        PCIBus *bus,
+                                        Error **errp);
 /* 0 <= pin <= 3 0 = INTA, 1 = INTB, 2 = INTC, 3 = INTD */
 static inline int pci_swizzle(int slot, int pin)
 {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8844251eceb..bf0a1840dbe 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -217,6 +217,22 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
 
+bool pci_bus_add_fw_cfg_extra_pci_roots(FWCfgState *fw_cfg,
+                                        PCIBus *bus,
+                                        Error **errp)
+{
+    Object *obj;
+
+    if (!bus) {
+        return true;
+    }
+    obj = OBJECT(bus);
+
+    return fw_cfg_add_file_from_generator(fw_cfg, obj->parent,
+                                          object_get_canonical_path_component(obj),
+                                          "etc/extra-pci-roots", errp);
+}
+
 static GByteArray *pci_bus_fw_cfg_gen_data(Object *obj, Error **errp)
 {
     PCIBus *bus = PCI_BUS(obj);
-- 
2.45.2


