Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE098E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcqg-0001fn-Ag; Fri, 06 Dec 2024 13:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqc-0001Z8-Ow
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqb-0005QW-7K
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:38 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so27046765e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508876; x=1734113676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1k+dmjInIZ8nHyYwBxRGsxTlfJ8uy0DiQ6erMadlMM=;
 b=hty37EaH5Z4EVHdKe+a1bOodU/5O6eO3vDZzYEueYpWsOGZ3SCj+DllnIQPYOA6kLM
 0HXTMFKN8C795JPYmLejYzDpywhRe9svpNBrCy0e+8V5ZqT18seyRelbi4VZL8czJiAI
 8cAFr3s0ba3ApI32Cf4AVvg8ZfHP9TK8nDbX1/ozKQl1k7BblhV5o0qjFwNvNHINE8lt
 1wBLBiPeoxJcGVEKha5Kzxz/vk4ONAloQPMRtuG/FesCXwILvM9F2PAaVvhThuDAwQn7
 iGI1lQUlYrFUzphZMWZN17XWUvKUbD6sTzz42rjp4weIae4gKTcIXtP0l9xgN5XJ9ewG
 2zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508876; x=1734113676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1k+dmjInIZ8nHyYwBxRGsxTlfJ8uy0DiQ6erMadlMM=;
 b=jyB+uv4OWTSlsOI5ky4AS7ZvLj4W0m35tbZXOGX6OPXGGb6tdXl9N8m8spHo4TUwEV
 3gqXzqpgwmx69AI6Z20Zp027xT38KeS3qqbPljrMtu2hOE9pDFGDFY/6YA+IF4HjkHqH
 fTBzVl/vSMXEeSygMV5x3hkUPt5hxOu7aCK3dcwVptMQ2Ynm1IZS7GjxNHQF8lFt8H4L
 KFrZ/6VvILtK+OfxXPJnPCZcAaRNM6wKaoq1yGQyBigXMGcsW7Psvz5ilwE2WycTd7I9
 BypCa4a/gvNDfev6J1PwGp4YmZaCeH6t0UNyoNyY3ONEjkpJU36cGe+meqPdK17NOFSH
 EEcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHmBMozId7z26JBDbD6UySzg2Nk1/NA1gixFdiA5iifQhCwVCQvXQvDvGiAl+y5rPFj9aMHTr2Amzv@nongnu.org
X-Gm-Message-State: AOJu0YxdgKbmGqMyXBFO8MDCcdu0+8fms/wyP+ihWu+lxYF+VHYe4bmR
 r2/u2P+pZ5SCLAzaXGSwBf/syKyKNDB5QUjWJ2zymgGU0gLX4zdlklW8lJs/W88=
X-Gm-Gg: ASbGncu1GsCKr/o2g+BNpgzRP+hPGtt+gw1IYBN2W5C7W8zzDuGMI0txoChdWbe1qXL
 dazHTaBP2+PlcLIKwWhcfOzKibOM9fmBVO/Yjs3DyIekFgixkrzbnD6Wh6AZRyUCBIYvJ6GGgVq
 Z79k+Sf9NA8YP51BHRjcVz2ezeklhxUBS7lAcOuSJBNsztRJnglKcq/2q/08lLmDfXLNQaxm+ow
 E8XyLS/GEssbH7NWXjYtrbVgeheDLxCy1d8Fw7aFkYh/zS0lXJTYfLW9ZJEkXKWdiU=
X-Google-Smtp-Source: AGHT+IEjNW+Q39bvzV8SvBAEdzgVqcIk7gK2aOiSg+qS8DEC9sL7/5mLKpg6DJ9NKu+AXQtdXPDrVA==
X-Received: by 2002:a05:600c:1d85:b0:434:a955:ede with SMTP id
 5b1f17b1804b1-434ddeb8d9dmr43314725e9.14.1733508875758; 
 Fri, 06 Dec 2024 10:14:35 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e6af5819sm1660245e9.17.2024.12.06.10.14.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 10:14:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiahui Cen <cenjiahui@huawei.com>,
	qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 4/6] hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
Date: Fri,  6 Dec 2024 19:13:50 +0100
Message-ID: <20241206181352.6836-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206181352.6836-1-philmd@linaro.org>
References: <20241206181352.6836-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


