Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697D7D3B984
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtgO-0005oF-RO; Tue, 26 Nov 2024 06:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtet-0003wy-PI
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:10 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtep-0002mF-8F
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:06 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53ddb99e9dcso3054169e87.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620179; x=1733224979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLOtH90q6HrNlk2tttqrB7+LmSS1Ew20sdzHgtSgHVA=;
 b=M9RaepEJcW14Cci3sSEcQuJTTSAuP074Jx9guCrLdZtSqXILgilhsZIEt5EsuWXTED
 jJ7NAEkY2GxO9p5uJJUOPHKy6CJfwaODRW0i3/jwe5qc3xMt0i7TdsbsUgMFAA9n5PTS
 RHVP6yL9vetgwN9U2vYmh0HId+BcFXO5xyyzNGE8CRDLj6jyvlvrDOxl/ACsK9RgRPQj
 Bh6ZO7NwCzxUnve8RbWcf7228hhihsEL0g1Rq5Ufoy9mgUppf2nqpisGDYyWxJOV9r0q
 Q4IWdP20sHXqULqSjJHibCVB8hHJa82YumXG78VomJy3MUpHE1i2Z5UP5KI5MB/BzVjN
 /jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620179; x=1733224979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLOtH90q6HrNlk2tttqrB7+LmSS1Ew20sdzHgtSgHVA=;
 b=xSgYmF/8XX5nSLI6pQF0rQyyT+ePDygOb8GzOkRBI/GY1Oj6192z7YeyrImRbQOXf2
 Oy7CnA0bCsECDncSBaeiANMHL/XWRUVEGODwhhHxKCPBb8mWOn64qcyuc47E+KlEZ7r6
 EYFcjHI4i4ZyIWEMrYfrWGBXphpo9/l4g4FOUr60lRYPhnl71Jg/lhvfsAoeQwvYFUSw
 qYh6czGtIwY2qJRV9EcLhAPlUqXaPG1JRX07/XK29aYy/VH/32uhGyPuBmSc9T/M+N+Y
 hmU5biXdJ0pcxyoyO+giSxAFTXYZsJOTIDAJWS4Dy9ZvD4+iWupqBHZ8dXCSvefx9ulg
 yztg==
X-Gm-Message-State: AOJu0Yz0eLANEfLkPVDhXvuK5b5ugM2CZ+cTTqhHE3866HzNRHheApGG
 DQORBki+f5qqWnT1aHZKoU3jSQUFlV6UAaJ4GA09eTQsS7tpGIlc4zP/75ZNwV204is7HJXZcbX
 j
X-Gm-Gg: ASbGncvhRONn9sQNx35buf7FU30EwXzvvfK8IiMxLzAWJaPri/jyYGBW1kdG0vRydF1
 /an4Vt3UXP43wrEU7gI4v7NSvYABZyMN/UsbksqF4t2wmqZAi9WQ0mxHykvgKnstXpn9Q6X4J+O
 IsIi+6dZkbLjjEJIM8ZeL/ugyw8yynTbedK2Muq08dYjJUi3EwIMZ6pdRtwKXLo45A7iqQNlfIx
 49q+6kPT+sA7XdBvOszQzP8u5+mzN3lKKEWwNU6cMwNhpRIwuQKQDiv1ZXmtVBPsACuyR41
X-Google-Smtp-Source: AGHT+IGsj5VzaHU8SAaWvn5jQSkwZvf//JK1pbBPc7Ax707C0OpTerSeHt4R927s6MsqNJ3PMJA0fw==
X-Received: by 2002:a05:6512:2388:b0:53d:e8f5:f9d4 with SMTP id
 2adb3069b0e04-53de8f5fa18mr1392986e87.36.1732620179597; 
 Tue, 26 Nov 2024 03:22:59 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349e117bf5sm81335245e9.18.2024.11.26.03.22.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:22:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 06/13] hw/pci: Propagate bar_at_addr_0_refused to
 pci_root_bus_init()
Date: Tue, 26 Nov 2024 12:22:05 +0100
Message-ID: <20241126112212.64524-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

Have pci_root_bus_init() callers set the
'bar_at_addr_0_refused' argument. No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h    | 3 ++-
 hw/pci-host/raven.c     | 2 +-
 hw/pci-host/versatile.c | 2 +-
 hw/pci/pci.c            | 5 +++--
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 135695c5511..b499846083f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -284,7 +284,8 @@ bool pci_bus_is_express(const PCIBus *bus);
 void pci_root_bus_init(PCIBus *bus, size_t bus_size, DeviceState *parent,
                        const char *name,
                        MemoryRegion *mem, MemoryRegion *io,
-                       uint8_t devfn_min, const char *typename);
+                       uint8_t devfn_min, const char *typename,
+                       bool bar_at_addr_0_refused);
 PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
                          MemoryRegion *mem, MemoryRegion *io,
                          uint8_t devfn_min, const char *typename);
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index a7dfddd69ea..d5087af5ec6 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -313,7 +313,7 @@ static void raven_pcihost_initfn(Object *obj)
                                         &s->pci_io_non_contiguous, 1);
     memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
     pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), DEVICE(obj), NULL,
-                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
+                      &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS, true);
 
     /* Bus master address space */
     memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index d257acee172..f82262f8d1e 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -407,7 +407,7 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
 
     pci_root_bus_init(&s->pci_bus, sizeof(s->pci_bus), dev, "pci",
                       &s->pci_mem_space, &s->pci_io_space,
-                      PCI_DEVFN(11, 0), TYPE_PCI_BUS);
+                      PCI_DEVFN(11, 0), TYPE_PCI_BUS, true);
     h->bus = &s->pci_bus;
 
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8eacb8f82fc..f7158fb9573 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -561,11 +561,12 @@ bool pci_bus_is_express(const PCIBus *bus)
 void pci_root_bus_init(PCIBus *bus, size_t bus_size, DeviceState *parent,
                        const char *name,
                        MemoryRegion *mem, MemoryRegion *io,
-                       uint8_t devfn_min, const char *typename)
+                       uint8_t devfn_min, const char *typename,
+                       bool bar_at_addr_0_refused)
 {
     qbus_init(bus, bus_size, typename, parent, name);
     pci_root_bus_internal_init(bus, parent, mem, io, devfn_min,
-                               true);
+                               bar_at_addr_0_refused);
 }
 
 PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
-- 
2.45.2


