Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A296E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5pG-0006KO-7a; Fri, 13 Dec 2024 08:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5oE-0005Ev-Tm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5oC-00017Q-T5
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:22 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so18525695e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096858; x=1734701658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOp9iHpt/Xa4k++YQIG/ZHdZLo2cw6SbKLu+TNop+/w=;
 b=IT7EvcZu5hPaCdWncg15GtHUYg+1+E0ArkTR5TdcUBHZtViWx4bMh6bv1dP2tkbQl6
 4yoLCiJswOILA5Unn1HPy/uWis5DuYj4CiaXp9Oe3nfh7K024FwnKQE3tPmfNxy9Ax55
 ZYJYdLBbCUp1zyrfsdRlOG01BW1Jc3QkFbmmJzl8vzC1AeDgcEXGs5Q8gbgO5/MrqhXi
 j18b4LV4u9bhPRjLBBUaAIrvm3W2AxMGVO+AIkY33U/Bu1sB16iCO7siWgagEV83IeA4
 5G6YJenRtyJQexesw+Zvt9qSPLpBF0vx/k83S8hImVt+45NgLidOno9kfqPMT0GuwiBN
 /C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096858; x=1734701658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOp9iHpt/Xa4k++YQIG/ZHdZLo2cw6SbKLu+TNop+/w=;
 b=IeT2Eomyjh3xHYs/MziCX/aGxaqmGCG47gSvzkUZ+k0IbP2Ns07Ij72jEDOnFen4Ut
 9pSbLHNDwezfxcA/aqMCFZEbYiGxC9/4XMg9mWBET1xS8lKqwYYAgPr556LP/TeFED+Y
 3ZLsZHEDoKTlqmAge9HwSNREvwS8W4yQxAhFbsnpjXp5+FO18Wz6FZCY6On0TvExVMZ1
 xkx7NZrrbsy5BoliGU/eTO+mQGCPuPOKTkUot5nIX0WnALbvJv0vzwkcleSAqIzdQnnP
 daE7hfbVW2fKsuwYZlo+M9r7DDg9IQ7o3Kv+ZQUJs7s6aFRkbg1IOdKSI177Svl6GGjS
 2RXA==
X-Gm-Message-State: AOJu0Yw97/o8IvWJc0aNpiSGcJbyUUrptqAcqjbB/YYlFAvTOjqd09iY
 j2euJlOzRhUZU4/n3QH7nqnJ7VLBVbZa8Zyq59Jp2LSj4pe1FkBXVK3qsgTEggjtTNwJSp+uEjA
 y
X-Gm-Gg: ASbGnctdrzo6HJcWvq0O2mnAAydmEsQbgjSQzhid9sPZBQyNpmLELttki2SZVkAMuww
 oEBrTdCZOf81+EMNfZJH3qsHo55IfrabqFuLvJljv/16M3KyY9oqMjfhJPkgsjErPGJc9fiwAPg
 h+AI9uj8cig6e3sXJzdbRArtfMv/FIQJHjg9Hpp96IQdkkOTlCCncblZQ0+iu1e4yvZBJcTesms
 VqclKVgp84CVTxgGGOOI6ls76eIel7N9woFg6MFsIBgNv5jgISbcKv0QO+RP54hmWoLZ5tAl2Xc
 DBlpgWSc150a49QaK3CL4hUtK7DwO94GN1aB
X-Google-Smtp-Source: AGHT+IFE/AMFqAlaGCflKUGIJ22Qst4DTBtoy+UyZh5h9BTZ7y7S+SNjDWIf4TKUeIFwCRRnhRXc3g==
X-Received: by 2002:a05:600c:3b1d:b0:435:192:63fb with SMTP id
 5b1f17b1804b1-4362aa1361emr24812965e9.3.1734096857974; 
 Fri, 13 Dec 2024 05:34:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824c2bf2sm7010324f8f.55.2024.12.13.05.34.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:34:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
Date: Fri, 13 Dec 2024 14:33:50 +0100
Message-ID: <20241213133352.10915-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
References: <20241213133352.10915-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

pci_bus_add_fw_cfg_extra_pci_roots() calls the fw_cfg
API with PCI bus specific arguments.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


