Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3081CE77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQal-00043k-Jm; Wed, 24 Dec 2025 10:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQaA-0002q3-Kg
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:15:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQa6-0003Ih-9f
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:15:20 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so40069755e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589314; x=1767194114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ph2pmdjoZr/k/2utUkSFXBLpUcN9Mg0Sl+yl3bcGaD8=;
 b=t7vCJH4hzNuEGKyyI6H7E0Hrluu3Csjr5bfLCAnebiFtT74k2ChIiK3bql0JgvpNXm
 ZhV5MQjhAH06GtMx4YlniY+SLDrAljQG4AnloX3h5h/DFToH6T2F7MudVGkoiIANpjeO
 GS9HyvbyT4jPcQLxCmEshmETWgMUMLrtvcAiHZ+H8g+2jm63rw7BzCBgZI2j3ynMp5EJ
 v/cZ6fN+NKEETbMDSMVsANNw8mdzg8XWnTBwEcFM44L/aDrOc93jGff6+9InV008lMgh
 NDTsnvrwIFEJ0IFaeCjmhNKnmDAKjp4zvFvtJOzIm1zjYTGw57U5TpAJAk8CebQkyEc0
 MfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589314; x=1767194114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ph2pmdjoZr/k/2utUkSFXBLpUcN9Mg0Sl+yl3bcGaD8=;
 b=YcD2vus7hjH8NdZZYgQzPabR+8x1Hl8v2YIgJWMfKEqr7jtr5KIbY/XUOGrY0fziOC
 Ufp7f6Pvs6vE1DNiia0/8TjYPMRIp+uMHr3i/leasUAPjAT1K34FpoI4Hz11AhVoPgEV
 J6goPh65nR0gIniHkSZIuHXdMwEw2w9P9luGtwpXqdyYUog6XfoCblj+ZhHEmprLqGXy
 AmIIJEVrBbe9QBRXqy3IpjjqnSgNksGsPSJQxQVf5HS3YvTCwQZ7SDH02TTkZYq1yLe/
 T1BiYoOEBtzwmMRCcaKeIGvdsNE7zYUiK2jBdmnHlN8wKZMleVnI9JP40lIQYs1BZL7M
 MJiw==
X-Gm-Message-State: AOJu0YyeGSUm8Gg0mqCr4rxnuQxhrqHjR7cINyfR//dc0bN8na3uISek
 vrGOv4nzvPci9vM2XLAlzYQBdRaiT4LXt688Jb85qW6kbm+LCiQC+WVdHwa25tN3KmqM0Khp6Ss
 xTA07OYI=
X-Gm-Gg: AY/fxX6NwNWfEiUGIvHT5QuYN9RPcuRm/MVOYVLyrL8nMSNnh2hd+1+tk28oTv2QBF6
 bVHfbWiV5udxSZ6Mxdvugnn0wBfu5+egrJmsqZtQWANxoFbPkwm620KMjvzPCgOlGBXyrW2+TkT
 nYPwMyN/T25ggpZgGpFqTH3qB1XzeWS1aZpd/0rT51culEeDUnGfjkooOF/H+8rtswJ9PLD4KxZ
 HjmSMgOsYDhkj6k1B9CkEsBEmU1G+y4JqRVXrdpgcr6tDQVK1qblBT+mzws1/N9wpa3fpIzy8Vw
 t0Zo0JAhsbB/gNW47lEK3VggnM/SRYXmG9jbfUZU1mR8DV97kGxisUD1ofXtwILRUYGGR+jItBk
 Eu8XuFwfaVYdxzEGmM+kPZGbaTGQMOQmePExYuq4imnYSoqqTg0nH/UXRjHTYxwFQKbcoO3Xhjm
 BgWbdzoAyrJld7dZaZGzJ9xHroAgLwD8jox6rU+NQSp8Mp+sCooiCvb58=
X-Google-Smtp-Source: AGHT+IFScwoxBCRqkTeXaQCsqQxt7KS6o7llklEBeQ0REgEuL7FRa07r2QGkzCL9a3oZPernIGWBSw==
X-Received: by 2002:a05:600c:4e0d:b0:46e:48fd:a1a9 with SMTP id
 5b1f17b1804b1-47d1959d2b4mr168685985e9.33.1766589313650; 
 Wed, 24 Dec 2025 07:15:13 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19362345sm298439715e9.6.2025.12.24.07.15.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:15:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] hw/virtio: Remove unused ldst_phys() helpers
Date: Wed, 24 Dec 2025 16:13:48 +0100
Message-ID: <20251224151351.86733-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
References: <20251224151351.86733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

None of the following virtio ldst_phys() inlined helpers are used:

 - virtio_lduw_phys()
 - virtio_ldl_phys[_cached]()
 - virtio_ldq_phys[_cached]()
 - virtio_stw_phys()
 - virtio_stl_phys[_cached]()

Just remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 85 -------------------------------
 1 file changed, 85 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 07aae69042a..c866769cad8 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -39,60 +39,6 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 #endif
 }
 
-static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        return lduw_be_phys(dma_as, pa);
-    }
-    return lduw_le_phys(dma_as, pa);
-}
-
-static inline uint32_t virtio_ldl_phys(VirtIODevice *vdev, hwaddr pa)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldl_be_phys(dma_as, pa);
-    }
-    return ldl_le_phys(dma_as, pa);
-}
-
-static inline uint64_t virtio_ldq_phys(VirtIODevice *vdev, hwaddr pa)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldq_be_phys(dma_as, pa);
-    }
-    return ldq_le_phys(dma_as, pa);
-}
-
-static inline void virtio_stw_phys(VirtIODevice *vdev, hwaddr pa,
-                                   uint16_t value)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        stw_be_phys(dma_as, pa, value);
-    } else {
-        stw_le_phys(dma_as, pa, value);
-    }
-}
-
-static inline void virtio_stl_phys(VirtIODevice *vdev, hwaddr pa,
-                                   uint32_t value)
-{
-    AddressSpace *dma_as = vdev->dma_as;
-
-    if (virtio_access_is_big_endian(vdev)) {
-        stl_be_phys(dma_as, pa, value);
-    } else {
-        stl_le_phys(dma_as, pa, value);
-    }
-}
-
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
     if (virtio_access_is_big_endian(vdev)) {
@@ -166,26 +112,6 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
     return lduw_le_phys_cached(cache, pa);
 }
 
-static inline uint32_t virtio_ldl_phys_cached(VirtIODevice *vdev,
-                                              MemoryRegionCache *cache,
-                                              hwaddr pa)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldl_be_phys_cached(cache, pa);
-    }
-    return ldl_le_phys_cached(cache, pa);
-}
-
-static inline uint64_t virtio_ldq_phys_cached(VirtIODevice *vdev,
-                                              MemoryRegionCache *cache,
-                                              hwaddr pa)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldq_be_phys_cached(cache, pa);
-    }
-    return ldq_le_phys_cached(cache, pa);
-}
-
 static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
                                           MemoryRegionCache *cache,
                                           hwaddr pa, uint16_t value)
@@ -197,17 +123,6 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
     }
 }
 
-static inline void virtio_stl_phys_cached(VirtIODevice *vdev,
-                                          MemoryRegionCache *cache,
-                                          hwaddr pa, uint32_t value)
-{
-    if (virtio_access_is_big_endian(vdev)) {
-        stl_be_phys_cached(cache, pa, value);
-    } else {
-        stl_le_phys_cached(cache, pa, value);
-    }
-}
-
 static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 {
     *s = virtio_tswap16(vdev, *s);
-- 
2.52.0


