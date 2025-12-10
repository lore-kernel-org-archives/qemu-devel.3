Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE5CD3E771
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP3u-00017c-N1; Wed, 10 Dec 2025 13:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3r-00015Z-B9
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:15 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3p-0002Sn-FK
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:14 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42e2d5e119fso18323f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765391832; x=1765996632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rmuruirWl2Hf5ekYVz4hPWVOUqfIMTyLIVh2I054+1w=;
 b=lPf1ng1m+syMAWv97M961lmlISdr0FiIEk0KTMWAzZTDmT4/2GVlGauTE+IcI8mfkf
 ttDFhpju8A8nWM0BbeqooV2RSL87OlQ640hGgDKLu4xmp5Z1NbTIHpU+SZ3uvU2bBiKI
 ZBOl+nVn+NuSw4aY+SgYg/Zpk4fPu/drEEU08AtVMerHCBDjDZaKYCOLeKuEN5iQt18C
 qp9EcE4mWaVAVMcPPhf+6P3Gj6fUr+EEqYLMZXRnxRQYsrkmrmUtJZ/9IqCndL9ICN0K
 Y4Y4nEmZdK779+8YhkYwDrg6uUYrd+hRlj7Qy76HbegQUV3/odckKa8GDi39MksDIrmY
 cj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765391832; x=1765996632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rmuruirWl2Hf5ekYVz4hPWVOUqfIMTyLIVh2I054+1w=;
 b=Z/1m1sRJcv33gdrWWnJveoGhjCVVmcQFwJuEdNyAnRczv+TiS/sfLSJ+wc6HiROTZ7
 MssqIP0xhxRGYnFQeZhZp5abFWtJmuv5/XkWWoI/Vr1XgUkaFemERyavVMFK4ifkcJFP
 xx8e/AyBU+/WE+rmiPSJxrfUZ1kHMYlhxvaDusglTApoeqN0LoGDwHghhRcA6Lk09jkm
 kpaH+3GHQwuAR7WYkym23DRpdSZM4Mmbjd3X6QmjOLwT0yWPty6uDzyYosSc+co0GMLa
 pTLBGGFMz0IBNJkAXEsye0WIfC++P4fdjx/VMiJOug2GQpkhVOCs6E7KHPkbcQH0gAnk
 WzCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlw7qxJPd1S1QDv4cKGUqER1G15szphOUUsPU/KYhDdpgvg8d7x/rY+n5M3QGIOQP3t6zp2v2oyFid@nongnu.org
X-Gm-Message-State: AOJu0YzHdmErfWlyCwAZZPZre5fevNN9trTV+4vG7NiCwyLg/VNFjItq
 SVD2XkfTC7iEoSiT7L49tH3CBlTfUR0PTWPDfolTYnaieofEirFSstLN3d0tzeK1xII=
X-Gm-Gg: AY/fxX7fw+wGWKW65MzJRKxAvgPZ0IlZU4WTaTVv/gvm/UDWzifUM/BxJwoQWwXuQdd
 tde5PFKdUcchnZQXRxhoaBJORdIhPjsfcq+wFGRzkV7kAlQn+dOvtbF6lUbL711m7gCqbU9xt2O
 m5WNNf3HqBAmvojA2LL/NgTdTYo/KPFIYfF3f/rND3u17e+jk41Wpmdso8CZRHm7rHGyLlopAK8
 3Rm9nS6Beuljbzvajs+B69tjst4AKRt8shDjIHf98yo3fg5UGSfw+AfBJIgMTZDapEYX5s0LWq2
 yapouLrso81WwlehEvwL2d576dUORVg+Mkt42NAVGtgXyeSPeDbpR5sZRwZ0K0HjfCjiW2L42Ab
 oHGWiaJ1ywCbtOW54CQ6Pb/GZMwjqi4MD6Eis0RVVgo08kJqHVLbZx2SmHKlHShNsF5Sy4JQebc
 Wuh8xhskvNf1D/DJDM
X-Google-Smtp-Source: AGHT+IH1iyn5x17R9K9rC7H+NaITv97PoyAn08Em0f2NKaqGMEXqVLZSE34ATuLzYc85qXZ4UwQfig==
X-Received: by 2002:a05:6000:2509:b0:42b:3131:5433 with SMTP id
 ffacd0b85a97d-42fa3ada434mr3916195f8f.26.1765391831880; 
 Wed, 10 Dec 2025 10:37:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a7044csm477702f8f.15.2025.12.10.10.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 10:37:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 7/7] hw/arm/omap1: Remove omap_badwidth_*
 implementations
Date: Wed, 10 Dec 2025 18:37:00 +0000
Message-ID: <20251210183700.3446237-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210183700.3446237-1-peter.maydell@linaro.org>
References: <20251210183700.3446237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Now there are no callsites for the omap_badwidth_* family
of functions we can remove their implementations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h | 10 --------
 hw/arm/omap1.c        | 59 -------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index bdb2e887e47..66a435a3d72 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -673,16 +673,6 @@ struct omap_mpu_state_s {
 struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *sdram,
                 const char *core);
 
-uint32_t omap_badwidth_read8(void *opaque, hwaddr addr);
-void omap_badwidth_write8(void *opaque, hwaddr addr,
-                uint32_t value);
-uint32_t omap_badwidth_read16(void *opaque, hwaddr addr);
-void omap_badwidth_write16(void *opaque, hwaddr addr,
-                uint32_t value);
-uint32_t omap_badwidth_read32(void *opaque, hwaddr addr);
-void omap_badwidth_write32(void *opaque, hwaddr addr,
-                uint32_t value);
-
 void omap_mpu_wakeup(void *opaque, int irq, int req);
 
 #define OMAP_BAD_REG(paddr)        \
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index cfa4e1f677c..8fa4195a5fa 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -44,65 +44,6 @@
 #include "target/arm/cpu-qom.h"
 #include "trace.h"
 
-static inline void omap_log_badwidth(const char *funcname, hwaddr addr, int sz)
-{
-    qemu_log_mask(LOG_GUEST_ERROR, "%s: %d-bit register %#08" HWADDR_PRIx "\n",
-                  funcname, 8 * sz, addr);
-}
-
-/* Should signal the TCMI/GPMC */
-uint32_t omap_badwidth_read8(void *opaque, hwaddr addr)
-{
-    uint8_t ret;
-
-    omap_log_badwidth(__func__, addr, 1);
-    cpu_physical_memory_read(addr, &ret, 1);
-    return ret;
-}
-
-void omap_badwidth_write8(void *opaque, hwaddr addr,
-                uint32_t value)
-{
-    uint8_t val8 = value;
-
-    omap_log_badwidth(__func__, addr, 1);
-    cpu_physical_memory_write(addr, &val8, 1);
-}
-
-uint32_t omap_badwidth_read16(void *opaque, hwaddr addr)
-{
-    uint16_t ret;
-
-    omap_log_badwidth(__func__, addr, 2);
-    cpu_physical_memory_read(addr, &ret, 2);
-    return ret;
-}
-
-void omap_badwidth_write16(void *opaque, hwaddr addr,
-                uint32_t value)
-{
-    uint16_t val16 = value;
-
-    omap_log_badwidth(__func__, addr, 2);
-    cpu_physical_memory_write(addr, &val16, 2);
-}
-
-uint32_t omap_badwidth_read32(void *opaque, hwaddr addr)
-{
-    uint32_t ret;
-
-    omap_log_badwidth(__func__, addr, 4);
-    cpu_physical_memory_read(addr, &ret, 4);
-    return ret;
-}
-
-void omap_badwidth_write32(void *opaque, hwaddr addr,
-                uint32_t value)
-{
-    omap_log_badwidth(__func__, addr, 4);
-    cpu_physical_memory_write(addr, &value, 4);
-}
-
 /* MPU OS timers */
 struct omap_mpu_timer_s {
     MemoryRegion iomem;
-- 
2.43.0


