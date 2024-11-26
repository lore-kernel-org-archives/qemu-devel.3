Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A72CD3B986
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtfP-00046v-To; Tue, 26 Nov 2024 06:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFten-0003wR-Ny
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtek-0002ka-Dm
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:01 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so22497515e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620173; x=1733224973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=531OAHe2E6s/gjTEfxFCkh/CSUMa49twfx2TRTu9rug=;
 b=fu1eq2LPLYZFT1JFRqcrq/dgHJLG4aatbxi8h011QprBw2hhsCeLOZuP4mY49Yj2vo
 G5dN0v9kl10AbhDFyveVoQaWbtJ6HDuP6d5FhR5lZAVvEQS9IdjWN8wty6q9vfBAn0HY
 5WV/y6/Ez293S4CuXmjrGcKPRxn2wFmoPkkqtZmVCo7wuNup6EbaWK1FsaQ9wzf2J+WJ
 hm7/zlIcB3IMCWpNuF5DTTahZ0R2NVdnZU/e0t0IZGDFuXYiTImu3W9y7Cj3sySbVOIo
 XQ5qP5+mvy+djvuLimbVju0cY9CSiwzbqoQq85ljoICpo5tlzAa6M4WafrrytTuqfe6i
 c4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620173; x=1733224973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=531OAHe2E6s/gjTEfxFCkh/CSUMa49twfx2TRTu9rug=;
 b=Z4HAqTi0Ugd016pjq49vk2Ac5kDoVI7hvokqAiyRS2lj+xQbd5+NokG1FGYhZxYF/9
 OvVoih4NbS1w06NWuewUfimOr5MPItyKFapO/OBegeuqI5hc9sfVxQQBEjPH49jBYcbM
 4ct1CnpwwZ7DTm7kM9dHFmTu8sMJmi0LIWkvaggAKr+GkIpbMIjvCcni3ZlV1Z8atcPU
 8LxvwuJcHw9zwkSSFBfVOQK1PeAF19wo38mBYAC9WJaj2FexupShQB04gumwAGhKB1iT
 Xh4Q8R6WKPkvTTuz8XJ/GGz82yywrrQND4WXS+m/qRh8XIc3tVDiWxy3Do4wNZG8M4x5
 isew==
X-Gm-Message-State: AOJu0YxjAuBeXg+CRTHTiwKiq5H+QQn432yBgOXl6kfnQRMk0oNYbBWs
 WYKNcmXGsoQBO51E6egNJbVpE5MGMTE+JWH2frHAO/cyodaP2OvhnJkAzWD3NgwrQNT5Wo9uBUl
 g
X-Gm-Gg: ASbGncsTF2c0do+eVhsGbKDO6LCfjbUufsTLmfiDGyIgCszALqW4hPdSAzU7N0ZCEod
 4vq+VlzCF65zK+LmyQHYo+2tvy2v2wA46gcTDS2BusG6IiaN+MpyuEO4xhaKtbFZ0V5qqDH6f/B
 XaIERx9M1/Nmv0mroGrhr+17y0HNTUK4ps0vs7o2+MFqLNNSPyYlmw5stlkLh+XFkyKKZJe87Ep
 dQX1koD0Cxafo+UBVgJVII49aWKummrer681kJ+ofSu6pPA3rG0+sqYIGTNKKTqZ9Xs331/
X-Google-Smtp-Source: AGHT+IGlSefU/AUIv0V6tDlbe3TEFlshHBlt/NlBgyTesEOFvwph3W7BFNJsTCxNbGO+wmRFjIAk5Q==
X-Received: by 2002:a05:600c:154d:b0:434:a815:2b57 with SMTP id
 5b1f17b1804b1-434a8152d9dmr7809555e9.20.1732620173600; 
 Tue, 26 Nov 2024 03:22:53 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a4faf750sm25527775e9.10.2024.11.26.03.22.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:22:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 05/13] hw/pci: Propagate bar_at_addr_0_refused to
 pci_root_bus_internal_init()
Date: Tue, 26 Nov 2024 12:22:04 +0100
Message-ID: <20241126112212.64524-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Have pci_root_bus_internal_init() callers set the
'bar_at_addr_0_refused' argument. No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 27b66583e54..8eacb8f82fc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -529,7 +529,8 @@ static bool machine_refuses_bar_at_addr_0(void)
 
 static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
                                        MemoryRegion *mem, MemoryRegion *io,
-                                       uint8_t devfn_min)
+                                       uint8_t devfn_min,
+                                       bool bar_at_addr_0_refused)
 {
     assert(PCI_FUNC(devfn_min) == 0);
     bus->devfn_min = devfn_min;
@@ -537,7 +538,7 @@ static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
     bus->address_space_mem = mem;
     bus->address_space_io = io;
     bus->flags |= PCI_BUS_IS_ROOT;
-    if (machine_refuses_bar_at_addr_0()) {
+    if (bar_at_addr_0_refused && machine_refuses_bar_at_addr_0()) {
         bus->flags |= PCI_BUS_BAR_AT_ADDR0_REFUSED;
     }
 
@@ -563,7 +564,8 @@ void pci_root_bus_init(PCIBus *bus, size_t bus_size, DeviceState *parent,
                        uint8_t devfn_min, const char *typename)
 {
     qbus_init(bus, bus_size, typename, parent, name);
-    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min);
+    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min,
+                               true);
 }
 
 PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
@@ -573,7 +575,8 @@ PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
     PCIBus *bus;
 
     bus = PCI_BUS(qbus_new(typename, parent, name));
-    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min);
+    pci_root_bus_internal_init(bus, parent, mem, io, devfn_min,
+                               true);
     return bus;
 }
 
-- 
2.45.2


