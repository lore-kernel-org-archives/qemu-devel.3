Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE04DC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLlB-0005A2-Lt; Wed, 26 Aug 2026 18:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLlA-00059s-Ms
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:16 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLl8-0004ix-Ph
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:16 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so33986a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787781973; x=1788386773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBIdq1IerXBEqjEqdh2t+EBfxfqKjlwofVB6m7BdaPs=;
 b=k/okJot3/NeWC1Lzknu7R5CklTc3a3M5GV0zYcwK8hLRy2WN4OnzV9OLjw5mFnwx87
 QZQPu4gD4jg1K1Zg6FJnyKBmH/gOOG5uue0X5XIWt/4n1OlKkLikUy1900b+olzLPWuf
 AylOZu9Uypd1k2eVVxVkVv1HMaMfNEi10cte9RKJ9+wNwoTetq3lY2NT52hmd1Vw/pRv
 fHGeKENiYvTC+1ICl4r2NFFDqrnJ8sOodiDrmsiP25JWUzlHsK+HiwsTb3inr3sOt3CU
 ONxpvNKk/0+ZdROmVMQ0E8e/Jt58eYYMMndtxDExd/t7k5K9c5ZFh4datBNNQJ4s9+yh
 exeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787781973; x=1788386773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pBIdq1IerXBEqjEqdh2t+EBfxfqKjlwofVB6m7BdaPs=;
 b=qV+G4LYlYa3YB1hmhSAC11rkyeFBnzxAwDcdRbQALzEKhE12gY+5SVOwkfLWdoNQ2k
 RDpQ7IzHSuTi1lMI0Upjh6yloM3Heo5WC2EI0ZrO2BxO8St7yiWaQ/g7sgIaTSSCCFG7
 anbT0Rrj2CRd5ams2Xf901ABYfN0+M1keVqMtD8CPLXNflSQj6C2270O4a2VsFH4uPh6
 3N94+SyEsYjvhVDYk37hW+Yst2YQZ6ZQJhdPUqjWqFWXVuj3KvNmbfJfzjPQxlbGTZOg
 JMtcScTp2gFfwGlt47pCtZSKJvjHERhqHrAHrUmXMb0VGlzUzuuaRZBsQh18DVyd8kj3
 e6pA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+4ge3S6QSmCQWuTa5mRpuBiDAuoLx/l8xcEn4iV4yCMztm06ocbxMI0JTIRyOGpTiE/MSfRKQiFYc@nongnu.org
X-Gm-Message-State: AFuF++kWJJ6BkBztwILq5YsDFTj3fF6ApaOAiRKO3sdimvt4GfWM+avJ
 Z3/dCo56Wx6/2i5TiQIMuX2oXFwXHw3eosYeQsIZmx7nB2r3ldrXX1IX
X-Gm-Gg: AR+sD11Ftm7/G+bPveFW0UxzNjRSfGCmgtz8Xw4kjmCUmKtT6UnlIyNcLWLFp6yhwRl
 EwlT/3RFMK2nvUsZqAGawi5SWLwbotuxtpAvtyisVsx9lsKkkl1jmmzbDmMd9WXTCBUqWpAPDhc
 kyZHuRlkZbWpzd6ytCanYThq8EpSce7lFNX/aTJQTdhguBvflVoxZ791M0fXWHNEv2T2ZofxIKY
 BMxKEWt0JTpjTClk1aKqGhr7lL5fDDvMmhEQEMDnT6S655PafbK+Mi3DWzaIK1GK5rimxwMUhl2
 Z+XV+dXNmM9uh3sX2RkDS64QuPioJ1x090pe9gugkPq/e9KWTNybxwpTjiXFEPjY+ja0iHnK339
 n9My0bYWYfYZTHeP421FmI1vucgbecKIivUWWTQZDJL8mXha4FwL0BUMyQNcWSanj3wLIjqiQaQ
 jZdTK/3pwN/nqKuRNeDUs3eg4OJT7b+8lbkm5Jc1ut2e9fsCu7i78MWbEm7YMTYxWFmOP+Yk4x1
 Hr613If3zuTD+PhadlYNYX+q89KDYzDHPC7E+baC4vz0ifBnpOjbilhy7+FYIwkdnAnX5KZiaMu
 rQEIHnVWX1Rhw/eErZC8pQ==
X-Received: by 2002:a17:90b:17d1:b0:38e:8300:af51 with SMTP id
 98e67ed59e1d1-3966d20b09fmr18616544a91.8.1787781972987; 
 Wed, 26 Aug 2026 15:06:12 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a573a1sm5789956a91.14.2026.08.26.15.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:06:12 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 05/16] hw/intc/sifive_plic: Take a MemoryRegion for the
 created device
Date: Thu, 27 Aug 2026 07:35:15 +0930
Message-ID: <20260826220528.54516-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826220528.54516-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

sifive_plic_create() maps the device it creates into system_memory,
which prevents its use by SoCs that map devices into their own memory
container.

Add a MemoryRegion parameter and map the device into it instead of
calling sysbus_mmio_map(). All callers pass system_memory, so there is
no change in behaviour.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/intc/sifive_plic.h | 3 ++-
 hw/intc/sifive_plic.c         | 6 ++++--
 hw/riscv/k230.c               | 3 ++-
 hw/riscv/microchip_pfsoc.c    | 3 ++-
 hw/riscv/shakti_c.c           | 3 ++-
 hw/riscv/sifive_e.c           | 2 +-
 hw/riscv/sifive_u.c           | 3 ++-
 hw/riscv/virt.c               | 1 +
 8 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
index 32973dbf281e..13fe6b2909d2 100644
--- a/include/hw/intc/sifive_plic.h
+++ b/include/hw/intc/sifive_plic.h
@@ -76,7 +76,8 @@ struct SiFivePLICState {
     qemu_irq *s_external_irqs;
 };
 
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
+DeviceState *sifive_plic_create(MemoryRegion *mr, hwaddr addr,
+    char *hart_config,
     uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 9c84ff06a9fd..b6472443276b 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -473,7 +473,8 @@ type_init(sifive_plic_register_types)
 /*
  * Create PLIC device.
  */
-DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
+DeviceState *sifive_plic_create(MemoryRegion *mr, hwaddr addr,
+    char *hart_config,
     uint32_t num_harts,
     uint32_t hartid_base, uint32_t num_sources,
     uint32_t num_priorities, uint32_t priority_base,
@@ -499,7 +500,8 @@ DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     qdev_prop_set_uint32(dev, "context-stride", context_stride);
     qdev_prop_set_uint32(dev, "aperture-size", aperture_size);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+    memory_region_add_subregion(mr, addr,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     plic = SIFIVE_PLIC(dev);
 
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 1ef4260c5391..6b0f0453c80b 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -134,7 +134,8 @@ static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
     plic_hart_config = riscv_plic_hart_config_string(hartid_count);
 
     /* Per-socket PLIC */
-    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
+    return sifive_plic_create(get_system_memory(),
+                              memmap[K230_DEV_PLIC].base,
                               plic_hart_config, hartid_count, base_hartid,
                               K230_PLIC_NUM_SOURCES,
                               K230_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index a6026776d4de..1f6d9f5ae1ed 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -282,7 +282,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* PLIC */
-    s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
+    s->plic = sifive_plic_create(system_memory,
+        memmap[MICROCHIP_PFSOC_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         MICROCHIP_PFSOC_PLIC_NUM_SOURCES,
         MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 86ff8f8fcaab..62052bf7c61e 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -115,7 +115,8 @@ static void shakti_c_soc_state_realize(DeviceState *dev, Error **errp)
 
     sysbus_realize(SYS_BUS_DEVICE(&sss->cpus), &error_abort);
 
-    sss->plic = sifive_plic_create(shakti_c_memmap[SHAKTI_C_PLIC].base,
+    sss->plic = sifive_plic_create(system_memory,
+        shakti_c_memmap[SHAKTI_C_PLIC].base,
         (char *)SHAKTI_C_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SHAKTI_C_PLIC_NUM_SOURCES,
         SHAKTI_C_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0ea444f43bc5..81d7995ddcfb 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -214,7 +214,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
+    s->plic = sifive_plic_create(sys_mem, memmap[SIFIVE_E_DEV_PLIC].base,
         (char *)SIFIVE_E_PLIC_HART_CONFIG, ms->smp.cpus, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 58b4744318f8..1cc6be744f08 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -772,7 +772,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
 
     /* MMIO */
-    s->plic = sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
+    s->plic = sifive_plic_create(system_memory,
+        memmap[SIFIVE_U_DEV_PLIC].base,
         plic_hart_config, ms->smp.cpus, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 6e4b39315aaa..6d061a80ca9e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1138,6 +1138,7 @@ static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
 
     /* Per-socket PLIC */
     return sifive_plic_create(
+             get_system_memory(),
              memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
              plic_hart_config, hart_count, base_hartid,
              VIRT_IRQCHIP_NUM_SOURCES,
-- 
2.47.3


