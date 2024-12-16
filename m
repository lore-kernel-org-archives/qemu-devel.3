Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02AE7716A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 00:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMzJ9-0001Hf-6R; Sun, 15 Dec 2024 19:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJ4-0001G1-LN
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:49:54 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzIz-00073w-7a
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:49:53 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-728f1e66418so2885779b3a.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734310187; x=1734914987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUe/CaMF1o3K5iHx+qDApgHKPoUWwGBc8t+UaT1YHyc=;
 b=asvH60svarZ7u3X3/heC9aA3cbPRY750IK32BoAJXakbmgbSdAd8D3htha1iQlx+wb
 9fO5gCdVGamTIcN07QYgw6sQm7P0I8Anayvzw0hgsJBoXc/DC/YHzgpoDvW+UPXAWf1U
 USas5Gcf4chngOqEC/4KRMdWyrcV8UfO516BJXMaOmwRBCl7yzK20AkDcrxUm8QzbO3r
 /xjaXzTemjOcpAtlrnWEtDnhH6hBBNjonKiqn7ucYMNBAnsYgSV7nVTEYwjdfzGc9UCL
 fHRSH7FaNJCiATx+qSnhXCsfI/7bI1A4RMp7286G18BCLuiQ8R8ka/iMDJ6MwlMpkHKQ
 Y9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734310187; x=1734914987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUe/CaMF1o3K5iHx+qDApgHKPoUWwGBc8t+UaT1YHyc=;
 b=bN+cQTZ0F8dznL6blUyaT8Wzj05O39ebeSKoinpM2YUJXF/OTe7+2j+XvfdttXw/lh
 TuMUTfjepPTaP8joPj8qJ/O/U5LoLYU1NWI1meEPx4nsPO20yrvhnGr2dKNMRbh3nJ0e
 9UuhTGTX+gFTlLKPQFuuh187zrX5MfNn/djpVC39En4t1HwJ1vxzkngn9ickUmCbiGYd
 gt0JNcB5k2tJI6cQOaMIWcVWHqXQiTnd+URdSAsubq/dX6zFr9Wa4J5YjMAeIsu+6egI
 9OyDsq9JkAV+yJBahnqqGCfCHByg8bu1kLtSjQLfh++h4rwKLPdwy3KQKR0sY2Gy4qZM
 TrWQ==
X-Gm-Message-State: AOJu0YxYKDbe0VQSc//ezgS/6qqNnXsVJ+vBBVni4k6dSWuqKQinZdKA
 QWe9h304ppQ+nq+2Q7YG2Ce8n3OifqdojFvszNJNVOXI7f1hRmvijRwCpF//3rSdd8OQUmfcuni
 knMPsiCpDPJ4e/JEsFWA5xqh413CVKAw0VDDyBNknIIlG39BhCelS5wHO14cbR18rW8Q6Wfx1Nz
 LYM4GGXNDwpP7iWsygbBxxXQb5FTAihuJe3oxgCZpCFikStnI=
X-Gm-Gg: ASbGnctTG34FGE/g2m4j2g+PrdRhEoiG+yOnKA87O1wyf6kOEPWtwogeQyeRMKIlYTi
 gZ7rXgKpJ1s5MSSakbiwKQIrV8fUn74whdnKmZC53zAHXPIJnueW22OBPtIcrTpyjP0Pk4QBUWq
 /K5B1ihbrnU6Nx5aEAo/5oOTsia7yGKRRzA/H3DK6tMltpGwBUMdy9JXgKJLz0TgRwD2xLCRjSo
 yAA5aDevZ4vYdP5FLLy74FkkwuP21UHXF7I6LKnj1BcqVKTYTUbdLpePdGVuC1xeDLSXvgj5qvv
 hS3UtQ4j
X-Google-Smtp-Source: AGHT+IHvj674NESG+JlkRqyelwD4AO0yabLxvdCxK9Ao7iPJigpu0Z94K/UWRLMXbhHs198KfQoQew==
X-Received: by 2002:a05:6a20:728f:b0:1db:ec0f:5cf4 with SMTP id
 adf61e73a8af0-1e1dfe322a0mr16052201637.39.1734310186830; 
 Sun, 15 Dec 2024 16:49:46 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5addbf9sm3059586a12.47.2024.12.15.16.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 16:49:46 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...),
 Jason Chien <jason.chien@sifive.com>
Subject: [RFC PATCH 2/6] hw/pci: Add an API to set the downstream memory
 region of a PCI bus
Date: Mon, 16 Dec 2024 08:48:53 +0800
Message-ID: <20241216004857.9367-3-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241216004857.9367-1-jason.chien@sifive.com>
References: <20241216004857.9367-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x42f.google.com
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

pci_setup_iommu_downstream_mem() invokes PCIIOMMUOps.set_memory_region()
to set the downstream memroy region of a PCI bus.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/pci/pci.c         | 6 ++++++
 include/hw/pci/pci.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1416ae202c..8703d75ac3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2811,6 +2811,12 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
     bus->iommu_opaque = opaque;
 }
 
+void pci_setup_iommu_downstream_mem(PCIBus *bus, MemoryRegion *mr)
+{
+    assert(bus->iommu_ops && bus->iommu_ops->set_memory_region);
+    bus->iommu_ops->set_memory_region(bus->iommu_opaque, mr);
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cb3039bce8..9ae2cc61f1 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -450,6 +450,13 @@ void pci_device_unset_iommu_device(PCIDevice *dev);
  * @opaque: passed to callbacks of the @ops structure.
  */
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
+/**
+ * pci_setup_iommu_downstream_mem: Designate a memory region for a PCIBus
+ *
+ * @bus: the #PCIBus being updated.
+ * @mr: the designated memory region.
+ */
+void pci_setup_iommu_downstream_mem(PCIBus *bus, MemoryRegion *mr);
 
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
-- 
2.43.2


