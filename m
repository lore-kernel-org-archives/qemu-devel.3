Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB65CCC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHBzV-0006gK-RN; Wed, 14 Oct 2026 23:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBzT-0006fT-IQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:18:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBzR-0006f5-KT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:18:47 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-396affa9420so600109a91.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034324; x=1792639124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m9xpONnAYUkseLI5R+rwBE0n4JIBSx/u5dBOW9gFrh8=;
 b=BNHKmlY/Zgslk6hfsRPoEmcuy6Mj2VkmSoKfvVd2t7H9Smod2+qZ0DXHT+71WZUx7G
 XMYtc5u4lI/qyx56QD2kLi8bLXvp1rreO8odCkMB9ivJktNlV6Af9l4xWqtJ2S92rsu1
 2vC3OfTrcsHFLt+NWJhm/HVWPbC5z/dFgWpxd6XJnyKaoSt9VobxbmMtizazigWGqu8P
 yAPbeMyNiaY16Vm8alSHDex1caqNDlkw7zhERGkNRbOCPOltx2BlTp+rNNDKj4gwQcQ3
 Kk6sgNAe9C0N4UWL4eb6sSQ3PI2/FhmYFhRniB1naeF8UrEX5rPmsB3YWwh+YwMJmm11
 mVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034324; x=1792639124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m9xpONnAYUkseLI5R+rwBE0n4JIBSx/u5dBOW9gFrh8=;
 b=JIVFmjMBMM+OJLwuZvehCRpukEPbSo7Su0GL6Z+pScyBRgNjnQRhInoAQ1wfnkIM/0
 jWMrE6faVp+Omvz2ptSofZPfkhk7W42D6YNH+usw0UkV6rXh3xNtaUCyyTj2oxoPO//4
 gVxPnIrWNXVn2frAQeREa6gURhLkPTEXswLZapxml7FeHD5zSvc97vqOoBd8k0hp1LdT
 2Ae3gJMdrb3hbLLntHm/3cpri/0rGOC5NGYs3mLa0K0dB2ZzAzictem7aDnjqRmxPzBH
 YJQOjFInugVDLhqfD0knl2VVZV1El8/wLwN8bN9Cf/yNL7o9rV5SzV/x3qQvCIwwm+Ln
 MkkA==
X-Gm-Message-State: AFq9FYK6TTG8z6Xw9Wt8gAax0lfbrmV5cFA41LPKyOkqeGBAuN0cpq4O
 Su619vpS9DZvQfvHJY90VPWJBS5LpwRHm7VAD3WVT63VEsbtN9Mtp9WWq84XBQASRAQq+XDoXWh
 zKSoCclQ=
X-Gm-Gg: AYBFou0mgurHy1/2TseXCisxEKF+xMlvsJ7NKTz+Wc8yHFWO3VHZfpaVn00d1JpAqye
 FtqGPdAblAKwRMv2Jp+30p5N5pu8iHDWRC8V3cp4W5Ti3MBK2H/KclBvQSLBP02VrN+z2UL/49A
 /SIhJiDY+LsXgHQA7eHxibXALKm8IxdvDcorA7vVZjqb85HuiV1sD6CeCyUerMymosW9mISpUm/
 wG3akz+DjJtPaEAkXKdfOjcybie8qBETqhoiJBeOI+HxuxNNaAWqAdtOauEwFqzSoamFtKu9HBW
 /4a2k1idfO49MbF3yvKtJcgGyxP5hlidLwLEGgj/DrXK8JhzmpO4FtmMwogZ87sYd2lCLOznqMS
 /mLSGpbcbygB9oJiT9NhINlpWTOR2ThTdZNalo4uf68oWeWNux4cFEtKVUsIKPHMpwfpDclzwos
 rBdGLvM73eR6XMZesS1VREISBrTAoex+/DkYNDezf2YMDq7VIba8VYRrYruBWVF17iuGA5GNW48
 UjAk8EU/fuXojx+JkgfS/fKKIUmJhWzLfxNhEZ8MtxRon75w0m4EaKwDA==
X-Received: by 2002:a17:90b:3910:b0:3ac:73c7:9c07 with SMTP id
 98e67ed59e1d1-3ac73c7ac70mr5924112a91.0.1792034323961; 
 Wed, 14 Oct 2026 20:18:43 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:18:43 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 04/12] hw/riscv/atlantis: Store Ascalon memory in cluster
 struct
Date: Thu, 15 Oct 2026 13:17:56 +1000
Message-ID: <20261015031804.2406055-5-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The system memory is the memory view of the Ascalon CPU. Store the
memory directly in the TTAscalonClusterState and set it to
system_memory. There is no need to track it at the machine level,
get_system_memory() can be used when needed.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c         | 43 ++++++++++++++--------------------
 include/hw/riscv/tt_atlantis.h |  3 +--
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 8f217088c6..f087fd16e3 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -563,18 +563,19 @@ static void tt_ascalon_cluster_realize(DeviceState *dev, Error **errp)
 {
     TTAscalonClusterState *ac = TT_ASCALON_CLUSTER(dev);
 
-    if (!ac->memory) {
-        error_setg(errp, "'memory' link is not set");
-        return;
-    }
     ac->memmap = tt_atlantis_memmap;
 
+    /* Ascalon's memory view is system memory */
+    memory_region_init(&ac->memory, OBJECT(ac),
+                       "tt-ascalon-memory", UINT64_MAX);
+    memory_region_add_subregion(get_system_memory(), 0, &ac->memory);
+
     /* Boot ROM */
     if (!memory_region_init_rom(&ac->bootrom, OBJECT(ac), "tt-atlantis.bootrom",
                                 ac->memmap[TT_ATL_BOOTROM].size, errp)) {
         return;
     }
-    memory_region_add_subregion(ac->memory, ac->memmap[TT_ATL_BOOTROM].base,
+    memory_region_add_subregion(&ac->memory, ac->memmap[TT_ATL_BOOTROM].base,
                                 &ac->bootrom);
 
     /* CPUs */
@@ -588,7 +589,7 @@ static void tt_ascalon_cluster_realize(DeviceState *dev, Error **errp)
                             ac->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
     object_property_set_link(OBJECT(&ac->cpus), "memory",
-                             OBJECT(ac->memory),
+                             OBJECT(&ac->memory),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&ac->cpus), errp)) {
         return;
@@ -598,8 +599,6 @@ static void tt_ascalon_cluster_realize(DeviceState *dev, Error **errp)
 static const Property tt_ascalon_cluster_props[] = {
     DEFINE_PROP_STRING("cpu-type", TTAscalonClusterState, cpu_type),
     DEFINE_PROP_UINT32("num-harts", TTAscalonClusterState, num_harts, 8),
-    DEFINE_PROP_LINK("memory", TTAscalonClusterState, memory,
-                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void tt_ascalon_cluster_class_init(ObjectClass *oc, const void *data)
@@ -658,7 +657,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 
     ram_size = memory_region_size(s->dram);
 
-    s->irqchip = riscv_create_aia(ac->memory,
+    s->irqchip = riscv_create_aia(&ac->memory,
                                   true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
@@ -671,7 +670,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(ac->memory,
+    riscv_aclint_mtimer_create(&ac->memory,
             ac->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
@@ -693,13 +692,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_alias(&s->ram_hi, OBJECT(s), "ram.high", s->dram,
                              0, ram_size);
-    memory_region_add_subregion(ac->memory,
+    memory_region_add_subregion(&ac->memory,
                                 ac->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
 
     lo_ram_size = MIN(ram_size, ac->memmap[TT_ATL_DDR_LO].size);
     memory_region_init_alias(&s->ram_lo, OBJECT(s), "ram.low", s->dram,
                              0, lo_ram_size);
-    memory_region_add_subregion(ac->memory,
+    memory_region_add_subregion(&ac->memory,
                                 ac->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
 
     /* 4 PRCM blocks */
@@ -708,7 +707,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]), 0));
 
@@ -717,7 +716,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]), 0));
 
@@ -726,7 +725,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]), 0));
 
@@ -735,7 +734,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
 
@@ -749,7 +748,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        memory_region_add_subregion(ac->memory,
+        memory_region_add_subregion(&ac->memory,
                                     ac->memmap[TT_ATL_UART0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
@@ -763,7 +762,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(sbd, errp)) {
             return;
         }
-        memory_region_add_subregion(ac->memory,
+        memory_region_add_subregion(&ac->memory,
                                     ac->memmap[TT_ATL_I2C0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
@@ -792,10 +791,6 @@ static void tt_atlantis_machine_init(MachineState *machine)
     TTAtlantisSoCState *s = &ams->soc;
     TTAscalonClusterState *ac = &s->ascalon;
 
-    memory_region_init(&ams->soc_memory, OBJECT(machine),
-                       "tt-atlantis.soc-memory", UINT64_MAX);
-    memory_region_add_subregion(get_system_memory(), 0, &ams->soc_memory);
-
     object_initialize_child(OBJECT(machine), "soc", &ams->soc,
                             TYPE_TT_ATLANTIS_SOC);
 
@@ -807,9 +802,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             machine->smp.cpus,
                             &error_abort);
 
-    object_property_set_link(OBJECT(ac), "memory",
-                             OBJECT(&ams->soc_memory), &error_abort);
-    object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
+    object_property_set_link(OBJECT(s), "dram", OBJECT(machine->ram),
                              &error_abort);
 
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 4e3d5d4b5f..52b44504ae 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -37,7 +37,7 @@ struct TTAscalonClusterState {
     /*< public >*/
     const MemMapEntry *memmap;
 
-    MemoryRegion *memory;
+    MemoryRegion memory;
 
     RISCVHartArrayState cpus;
     MemoryRegion bootrom;
@@ -70,7 +70,6 @@ struct TTAtlantisState {
     /*< public >*/
     Notifier machine_done;
 
-    MemoryRegion soc_memory;
     TTAtlantisSoCState soc;
 };
 
-- 
2.43.0


