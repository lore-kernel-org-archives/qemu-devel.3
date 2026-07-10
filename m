Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17475C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8x2-0006aW-GQ; Fri, 10 Jul 2026 06:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wx-0006U0-Ih
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wv-0001PV-UF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493f738638fso526795e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783681156; x=1784285956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ihg7vHTyXn0KPCfa4E2cworXVRkER/1mlTfqytBQui8=;
 b=MprzbGI2ORCiJrEPsLcPT5TocSvo3O5mIuj+KHIVm7A8rsYS/Tgx5aIJ1JDDNg84Tn
 josvBlBZBOQDp+iXzpy+BgVg/goqS7BIyRtwDaMxB651fVnw6bOZ17CkBdORW3SoEa3m
 6Vc3aKPi+XcG5j8ZQNAbNYCbWvV5PMKE4/n4cIx9wBBukYcFSvvyfrL9YeVr4DjAAHNZ
 pCNqlQGAGzKseDccmWXixnhgqOPYdrXveUq9FX7D8oIY9DOlUwUYpGgLx4y3NzYhz8m4
 6OySffOPSeeCBUZGEjo9R8jFPhFLq1CuuNacHxJGQZOFJaktD7y6WaQmlTXexZ+pv46m
 G2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681156; x=1784285956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ihg7vHTyXn0KPCfa4E2cworXVRkER/1mlTfqytBQui8=;
 b=U7WYB4lULwfOqongK+TN2k5qOPpxVnRIAwC9Uf3A45rVyOPjr8EDex9u7oWJIT0E+s
 CA8c6cU0jbKv1FcWtdU9Y3j54BxSD497VVwXUvWkdL9EcunYMhRXQUsUqD9WHXDKCcqF
 rbcdfeH/ggPHq9TBgkxogU2V1KeNxbEnq/0CxKn7zFOmqQCeVInmezfEH2VDRxkVNp3v
 kfATo6UccjJ3Pr60cKQK8+tyGsigHKIGgHNEZKXNPEeki4NIy9oeA0Odd+77ha3yBiHh
 Ga6kM0rJH1kp68JlkjCEHKjXO8y6EM6TJCYc8B4gPgvDUvGUjLY+LifQHllELRpz2GIx
 mt0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7xAtDtoRDL3+WnCwyWrUwco1d+mDOAzdSccF/kwc5E8h0/hjfGJGh+hcsY7yL3td4d6ITLjSZX9mH@nongnu.org
X-Gm-Message-State: AOJu0YybR55gVtM2L01WHerybLykZZz4zI9vLPkoL89lG+Nq0HGQDWMd
 kjO2ap4FGbmEeZ4u15x5MXPCW6CpF4hlqjvfoPkn2I+sOtRzIXBQjSRKq6JlAV8fyx4=
X-Gm-Gg: AfdE7cliyJ5XhXHkaJFxCXObIJoVjNzUpqp2TrwMkXMIVwDnO3rp3PAlbsWR0EmrDa0
 Oj//+Z8fsVXt55ojnrwQH4PdjiGFP2NUJGM8J80uoUd1gdjRRsKaoyRnyE/9SlgWk3gTA6DTysW
 6iYTcZTSXuMdsr0zML2VowQgEEBNloeP6wChWTKnonpoc6Jb/xwsHzYQhIiVrayFU9ZjTtFbkIL
 nlz7eDtlLFnV1DgQThNDtFM34gojcDHxswOGVUZCoxWJzz95iZLhQ+Ephubx0B7F8nRJfl9KI0b
 lwu4cT7h3shAkNzNIkJaYXLhiu8CdhmT8/G+0qqPZA+LYcVm0c1uJQnpjTQ5lw2l6qKXF9W9mLQ
 bJ61R5BOrGF1II++woFi5Wa8h20/NitXMc6/RxYNFcf4ewrg5FbKThLZ4NqA0lCIclmQIrpFy6u
 JYfYBApeO2wuLT+czSy4bUlg9cNpBJLKWnyvxBY0SgEooPQb8jQliRNS/zWlirfVrrzPX5zDs8e
 V05sV656KwUjr6OCfgT7A==
X-Received: by 2002:a05:600c:8a17:20b0:493:f5bf:4deb with SMTP id
 5b1f17b1804b1-493f5bf501amr10938975e9.25.1783681156435; 
 Fri, 10 Jul 2026 03:59:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm51946175e9.1.2026.07.10.03.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:59:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 7/9] hw/dma/soc_dma: Remove unused mem.base, paddr fields
Date: Fri, 10 Jul 2026 11:59:05 +0100
Message-ID: <20260710105907.2570621-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710105907.2570621-1-peter.maydell@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that transfer_mem2mem() uses physical_memory_map(), the
soc_dma_ch_s::paddr field is unused; remove it, and the code that set
it, and the memmap_entry_s::mem.base and the soc_dma_port_add_mem()
phys_base argument that were passing around host pointers to use for
setting paddr.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap1.c           | 6 ++----
 hw/dma/soc_dma.c         | 9 +--------
 include/hw/arm/soc_dma.h | 7 ++-----
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 44f9dd67c3..9e739a0712 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3799,10 +3799,8 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     s->port[tipb_mpui].addr_valid = omap_validate_tipb_mpui_addr;
 
     /* Register SDRAM and SRAM DMA ports for fast transfers.  */
-    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(dram),
-                         OMAP_EMIFF_BASE, s->sdram_size);
-    soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->imif_ram),
-                         OMAP_IMIF_BASE, s->sram_size);
+    soc_dma_port_add_mem(s->dma, OMAP_EMIFF_BASE, s->sdram_size);
+    soc_dma_port_add_mem(s->dma, OMAP_IMIF_BASE, s->sram_size);
 
     s->timer[0] = omap_mpu_timer_init(system_memory, 0xfffec500,
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_TIMER1),
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 6e325122d9..ff890149ee 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -85,7 +85,6 @@ struct dma_s {
         enum soc_dma_port_type type;
         hwaddr addr;
         struct {
-            void *base;
             size_t size;
         } mem;
     } *memmap;
@@ -154,10 +153,6 @@ static inline enum soc_dma_port_type soc_dma_ch_update_type(
         if (ch->type[port] != soc_dma_access_const)
             return soc_dma_port_other;
 
-        ch->paddr[port] = (uint8_t *) entry->mem.base +
-                (ch->vaddr[port] - entry->addr);
-        /* TODO: save bytes left to the end of the mapping somewhere so we
-         * can check we're not reading beyond it.  */
         return soc_dma_port_mem;
     } else
         return soc_dma_port_other;
@@ -245,8 +240,7 @@ struct soc_dma_s *soc_dma_init(int n)
     return &s->soc;
 }
 
-void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
-                hwaddr virt_base, size_t size)
+void soc_dma_port_add_mem(struct soc_dma_s *soc, hwaddr virt_base, size_t size)
 {
     struct memmap_entry_s *entry;
     struct dma_s *dma = (struct dma_s *) soc;
@@ -293,7 +287,6 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
 
     entry->addr          = virt_base;
     entry->type          = soc_dma_port_mem;
-    entry->mem.base    = phys_base;
     entry->mem.size    = size;
 }
 
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index b5ad9743be..fdae7a29c2 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -53,8 +53,6 @@ struct soc_dma_ch_s {
     /* Initialised by the DMA module, call soc_dma_ch_update after writing.  */
     enum soc_dma_access_type type[2];
     hwaddr vaddr[2];    /* Updated by .transfer_fn().  */
-    /* Private */
-    void *paddr[2];
 
     int running;
     soc_dma_transfer_t transfer_fn;
@@ -83,7 +81,6 @@ void soc_dma_set_request(struct soc_dma_ch_s *ch, int level);
  * calling soc_dma_set_request(ch, 1):
  *   ch->type[0...1],
  *   ch->vaddr[0...1],
- *   ch->paddr[0...1],
  * or after a soc_dma_port_add_mem().
  */
 void soc_dma_ch_update(struct soc_dma_ch_s *ch);
@@ -92,7 +89,7 @@ void soc_dma_ch_update(struct soc_dma_ch_s *ch);
 void soc_dma_reset(struct soc_dma_s *s);
 struct soc_dma_s *soc_dma_init(int n);
 
-void soc_dma_port_add_mem(struct soc_dma_s *dma, uint8_t *phys_base,
-                hwaddr virt_base, size_t size);
+void soc_dma_port_add_mem(struct soc_dma_s *dma,
+                          hwaddr virt_base, size_t size);
 
 #endif
-- 
2.43.0


