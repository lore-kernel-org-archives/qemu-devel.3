Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A0C3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Si-0001Hq-Jz; Thu, 08 May 2025 09:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1SD-0000Wz-E7
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:38:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1S9-0003sU-Qm
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:38:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22e5df32197so10935615ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711500; x=1747316300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpFm28NPDHDVh+ccZL7bpwZ5qyD7oJMGgna414/IiOE=;
 b=dxa9saRtQ5WgUstWpDY6Qkt9Fpayc5ysgWzHsFIc7v6mRvw7DuNifaIWStnh1l27Wt
 SMsDwtWpKPk1CIxTYRvU62hlZht2XD3FP9CgyTFM93eA+vzaTFjjzup1c6kSHwR+XJ7p
 ZPQavg8uj7J7Qmw0TRAM4tx/DXtBCsM5T7LVBnfUkACJkVNMAkBEMpBt1l7ndAzJXH9e
 9isMl2Tnc+getmmKG4DyBMGxeMEvw9eZkHL64EbeQEm6UxYM/9AegEpO77rqUoiMeGUb
 IDk1zP2lk5o0Mycb160r7hyZtCEY0xeeEqlO4RQQR0mYLrrcC+HmqjLuceINK/E1IUjG
 Q+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711500; x=1747316300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpFm28NPDHDVh+ccZL7bpwZ5qyD7oJMGgna414/IiOE=;
 b=XeVzMH53vjLURAaI8RRisdodg5+PJBYGAL2M9W+147vEf1dQ6s5BB8n9HBeSPGOcld
 z/yDFC4vJI2ENSL0XLlsBaYrtYjcHPkTf5PK2teTCAvBqH100ESX1w7/MN2KZ52WIg8B
 kQyujLjQf+NDt71Vg0z3q/wA5v2BrRLhSz7O8OcZd9vPq2Ub8mFHOccxG3TsKFbDhIVY
 rqnQ3/RIno+kglMZS0lzv/MUMXbLbU2iupKnJTfv1Qkn3allU2JxXnD6Srack5REL07a
 ImW6cEOuv+o6FcuAkGlFd0wqBmRr2tY0YyVwDOZkSWjOU5t8Fo6DhVZxni+DTYJmZIKG
 sx1w==
X-Gm-Message-State: AOJu0YyQCxwTFUPzROD/VOHg4WW4/WXAponcw+pFAWc6KHOEcD61B4iC
 yfmXNvp0296Io9tML2RMvovLSGEQ8H6ICi5HjZRmsMRsvEU4slYtKplEx8x8gX0byuMdDHW6sdE
 yikqoyg==
X-Gm-Gg: ASbGncu88qvVGDtDnRFligYpnzBH4XKTO5+nRodU0ht+b1XzcOmRsv9qZK5UlRnum0Q
 OMLtJOI4hQIqML7VCtMRrtdmS0amzr8rA3vk2sI5+tcgaDi0mQRDTqh6fGt3A037lBm8G2euRiI
 EqZT6lhHOxPPfD25E5QohBwyQGJ+w9kogpnfAIEmA8eNn4+m8bENwmqvJuGi1wutLR4ghSDsG20
 JI7V6bDXclZ3w8a3YLC86xiijaeZN52XBwh+EXNgxHmCD1LY4HIfyffxBA0fawk+Fi9x3uOh2tu
 oGfi4npGyp2rC0Gkdz/jtSJx2u9573DpF540SqlLa4ei6inWJHDA2e/dj1U4FCjs8LfIq8TDNmm
 n35nHhYvvbJH9puc=
X-Google-Smtp-Source: AGHT+IG5M7LxAxEtqrn6SjETmt6IKYSS9xA29boF8nxAUppyBF7lEa5eggXi+7v4Zp5iVONXRRv7CQ==
X-Received: by 2002:a17:902:ecc6:b0:224:10a2:cae7 with SMTP id
 d9443c01a7336-22e5edf9e5cmr112894945ad.40.1746711499714; 
 Thu, 08 May 2025 06:38:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15232797sm112617585ad.240.2025.05.08.06.38.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:38:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 06/27] hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
 fw_cfg_init_mem_dma()
Date: Thu,  8 May 2025 15:35:29 +0200
Message-ID: <20250508133550.81391-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62b.google.com
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

"wide" in fw_cfg_init_mem_wide() means "DMA support".
Rename for clarity.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h | 6 +++---
 hw/arm/virt.c             | 2 +-
 hw/nvram/fw_cfg.c         | 6 +++---
 hw/riscv/virt.c           | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index d5161a79436..c4c49886754 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -309,9 +309,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as);
+FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
+                                hwaddr data_addr, uint32_t data_width,
+                                hwaddr dma_addr, AddressSpace *dma_as);
 
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9a6cd085a37..7583f0a85d9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1361,7 +1361,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     FWCfgState *fw_cfg;
     char *nodename;
 
-    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
+    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 4067324fb09..51b028b5d0a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1087,9 +1087,9 @@ static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as)
+FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
+                                hwaddr data_addr, uint32_t data_width,
+                                hwaddr dma_addr, AddressSpace *dma_as)
 {
     assert(dma_addr && dma_as);
     return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index be1bf0f6468..3ddea18c93e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1266,8 +1266,8 @@ static FWCfgState *create_fw_cfg(const MachineState *ms)
     hwaddr base = virt_memmap[VIRT_FW_CFG].base;
     FWCfgState *fw_cfg;
 
-    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
-                                  &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16,
+                                 &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     return fw_cfg;
-- 
2.47.1


