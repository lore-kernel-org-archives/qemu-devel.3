Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D223C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6C4-0005Tz-5j; Tue, 21 Jul 2026 04:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bz-0005Sr-Iz
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bw-0005ie-W7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49546c690ffso30921035e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623867; x=1785228667; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZIBpVhCtB4kCVzqzRgaDhWrdDjmNisBtYqwZMNexmQg=;
 b=CDlIE/dbZ7KZua6HqppgYVpGRrUAlbzHvmJCLLagPOP/6z2KNaU6gfAvsPzmKM3O3s
 R546LvlnQxQPzWsm0CHhNLfzOcDm5QgXbhrxH88UMCO7ewZZLA91MgkWbVTGziyWAJwH
 qdJ3SmxnSeotraZQ0ekNM4Krbl9f0soCBbcGc7AGsln/UspEopBHvU8tynqIfw91dn3b
 vRG/tlpJwZJ3UFnChvjvZ4R5n0WWPAkDw4fFm8MzJcEnGw+PUjiRU5TMaJXwDq8JgERt
 aLU1pxgiAIBln0J5DMnPK6WbKfee+mtE4Nz10gHDJg83yogSYm+P5jjSEaK/ZVCGM1XJ
 v4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623867; x=1785228667;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZIBpVhCtB4kCVzqzRgaDhWrdDjmNisBtYqwZMNexmQg=;
 b=EOvCUT6wUTEU+DNcqJt3oZP9iqEoqLsX35xuIdRPlopmupZ2k8y/1t/j+bWFnfZ/O2
 gweiPWkfAjjk6hJPBuB7N/nQzvX+Tn4QLj2rhoK/s8V15srKs+kjhuMlpr5HFadlZZsN
 5brJw9xg7UFEhQ3Io1b48l9tAnYG9x77Mz5gbT5zXx7AcxVOgblOgXZHBxxLC0AzYHS0
 O6xRH7SlQ1bhtVUIkKPpnVcH2Fdpa1YFlctCEHkUu11WYuXH4cLU21yEdfOKQ1ojcwzh
 AZzS0b9rXuYOAarr0b0rA7E0otYM094DhNLZoBk1/YbCQ63DoxT0ZwXbqrmTq9wiq8K2
 uq7Q==
X-Gm-Message-State: AOJu0YxQ1l2dcqYDI+gN5iueT7aImK1enINLg5akquff5BZEmdxRrA7o
 J4D+VLoa0lGt20CppCque8Qg1N0CnE/j4wky0i3VLcdzU1XPSv3NwTncJ1d6Ys3nR+pqZ5breCm
 TNYLytQ1MZQ==
X-Gm-Gg: AfdE7ckM7+oQUC463gMPDLDESkvEdL8ncSxFU5QVNTnJiUbGp+VZSYquruJchM1TSt2
 5Ioz5f8HfmwXa6/N2D44uRnAN1eEEPPIpq8r0K6Os06OXdswSVZA29j83O6y58f5QbZEgJydzGW
 9ZGUgnGb0pprmu5+8OBq7QfKw1yd2nAxRK7VfeFw6DUu1Zo1RsvgiQxANZbxysVgAcnVfcpYRSb
 iOAoUYo9/IPplr8Jlx8uiJrxG7kw5HtkHDwupiZ+5Vlp5iKR9kCDKa6kg8txJ/prHExY3FXJcEg
 JnhaWCXBY73X7AegyyvTQ/9nuvS/ONwUQIEocS9gSi4BS+Pec+ZMV0rKJLhtlW7Prtx3DtgmycB
 O+oDgRaV92EblIlY88/Z/5z46HdGDPXah3AZ6LlXQ5iOFGbTJHdue0FKBDua5kHOKzv6uKWlhN4
 E+0RqUQSCWPmWDGgVsnHEDapl9ntEf0fDJN09G9D28DVbHleDQEpRegrAATwU6Du6YTVDZ+DUdf
 UXxHdgyTk/rFBhxl5fsAg==
X-Received: by 2002:a05:600c:3113:b0:495:61aa:523c with SMTP id
 5b1f17b1804b1-49561aa56admr64056595e9.17.1784623867484; 
 Tue, 21 Jul 2026 01:51:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] hw/dma/soc_dma: Remove unused mem.base, paddr fields
Date: Tue, 21 Jul 2026 09:50:47 +0100
Message-ID: <20260721085050.421257-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710105907.2570621-8-peter.maydell@linaro.org
---
 hw/arm/omap1.c           | 6 ++----
 hw/dma/soc_dma.c         | 9 +--------
 include/hw/arm/soc_dma.h | 7 ++-----
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 44f9dd67c36..9e739a07122 100644
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
index 6e325122d9e..ff890149ee8 100644
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
index b5ad9743be5..fdae7a29c2e 100644
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


