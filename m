Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3167CD6E55
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1IO-00036r-D5; Fri, 29 May 2026 13:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IJ-000363-Lo
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wT1IH-0001cW-Jc
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:46:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so93953205e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780076808; x=1780681608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LbzTwiLoTDLVZod2WDf3iVvM71txNUTsGObhcWg3SLM=;
 b=aREFNSNvkJkdPZLpVVf6NJQV4ISAKokwPR7V9GkHa7wcanqdGu4fK+Stw5da0E5OFO
 VP77t2pEj4IdaKfsF+og02POEhBf5AAZ4/sgvAA3xR2M+IBJFKnbxc5SV/IoY+vS0WWy
 bOUOD8Hr0M+NogHXle6r/Xn6IULtqA3v6dcmS/zpGCV6rltWTZA841fzLDcP4Gn0VFen
 jj7wr1wq73zfI2f9B2LnJEwcmMscEMfriBuoiZOVfJ5jYiAH61KE5xgU22o3nX+LUs2C
 9CGZV2ho9Kkew0TurMMLKRr7yBhkoTKRWZeMlCPtwAJt20BxvG+R3TeWc54eV7Swo3jj
 S1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780076808; x=1780681608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LbzTwiLoTDLVZod2WDf3iVvM71txNUTsGObhcWg3SLM=;
 b=ZfsEILdS40A2RmxJk9VpRp/GoEhJMaD1rmLdo1Xis8SB1kFfq3oaxgdS0lB2F7xz68
 OPRsFFHhBsbcGU5n1/b+R/yZn3LhVxSmsw3/lFBhu9REn0z2tuTzIo0Ls9UOEpTIVhQt
 thIfMpOpSwhuCJR1wntE5vQDNZlBtA9EZzaplO2qZeF+LEPfgZnYDY6VI7ILId6z0SYg
 DZT2EcZwLyDi8/qwQwc7mHP7L2mJZZBX82asgOQtCNxkGhgLKSbxY5sRjyY5d8rfOLBS
 46V4PqUHNctxzWl2S3IUA5IHzS4rQ15Up4vQihZ1D3ePxHYVLtImk10PRgAiFNAA2O/5
 XvxA==
X-Gm-Message-State: AOJu0Yxd+W3K+Lhv45OT1J/G1xRCiKe0+Db3L7cNCnoq9r8MwCs526d8
 cWcetW+TUFrR9DFP4ceuvMFngOxzUULZdQGWrjx4bHvts5ujCc5K/V/GAdBBom3hr0euYhpA6KV
 THwEd
X-Gm-Gg: Acq92OFz8JCQfuyMsJ/pjJCncdfvtCLk64MuIWMx14N+b+/BwiynOHFTA0s2Bto36r1
 OrBk8kSzSWflSpngXIsJ+fcP3ZBx8Eew8ANhaIwnBPegmYPZP4qQn4BKFyUa8ulXQ9c1oR1dQ45
 nANnhoJ/cPpntB1npIzpyW7NVX32VgRoxbUWnIvH+frj0CPKm4+KjwC/L+U4joCP2lBA+4ldImC
 o0He9P/pBapYrTTZdiWtkIYqFu1TwO6XEQwKK0TCJp3iYg3ncBdyU4qzfRqC/IUPIKSZgjR2Ms1
 FFYDY+hRbNoy3s69K2EE4UWPjefYCZUWOSWEIAgzOjmv2M4XZG611HhQOauuZjQQPmS95rQZ6oC
 v3Qfxpuc4+WyhiAx7RMSmmx5IDaiZj3DkdcNHgSMWfX+3UK1dH8wP6nn5+zayVpp38eA+Em1+Wz
 fDHDTXJ632CP+Y/0EC8HJZdqxjQ66OXd5PJLPvyy+Fst9/4wfBW3vf0h9gQB1JIQAtPNBJXtNUh
 fwQUMHEpOt15mAC4vFkxjv/bBgdIveCI5I5yD1GQiw=
X-Received: by 2002:a05:600c:314e:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-490a2a78973mr5081385e9.15.1780076808000; 
 Fri, 29 May 2026 10:46:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0aa24bsm18668895e9.9.2026.05.29.10.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:46:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 3/5] hw/nvram/fw_cfg: Enforce standard layout for x86 fw_cfg
 I/O ports
Date: Fri, 29 May 2026 18:46:37 +0100
Message-ID: <20260529174639.451353-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529174639.451353-1-peter.maydell@linaro.org>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The fw_cfg_init_io_dma() function allows the caller to specify the
base port number of the selector/data register and the base port
number of the DMA address register separately. No caller actually
uses this: they all pass in base + 4 for the dma_iobase.

To reduce the risk of unnecessary variation in what different x86
machine types use as their fw_cfg register layout, remove the
dma_iobase argument from fw_cfg_init_io_dma(), and have the function
always use the same "DMA port is base port + 4" layout.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/fw_cfg.c          |  3 +--
 hw/i386/microvm.c         |  3 +--
 hw/i386/pc.c              |  3 +--
 hw/nvram/fw_cfg.c         |  8 ++++----
 include/hw/nvram/fw_cfg.h | 17 +++++++++++++++--
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 2876490f06..d422302c1c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -127,8 +127,7 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
     const CPUArchIdList *cpus = mc->possible_cpu_arch_ids(ms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
 
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
-                                &address_space_memory);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, boot_cpus);
 
     /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 779741ec76..e7adab7d2e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -320,8 +320,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
         e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
     }
 
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
-                                &address_space_memory);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, &address_space_memory);
 
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, machine->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, machine->smp.max_cpus);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503..f9d8990d1d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -568,8 +568,7 @@ void xen_load_linux(PCMachineState *pcms)
 
     assert(MACHINE(pcms)->kernel_filename != NULL);
 
-    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
-                                &address_space_memory);
+    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 59cf92293c..f68191553b 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1019,15 +1019,14 @@ static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
     qemu_add_machine_init_done_notifier(&s->machine_ready);
 }
 
-FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
-                                AddressSpace *dma_as)
+FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as)
 {
     DeviceState *dev;
     SysBusDevice *sbd;
     FWCfgIoState *ios;
     FWCfgState *s;
     MemoryRegion *iomem = get_system_io();
-    bool dma_requested = dma_iobase && dma_as;
+    bool dma_requested = dma_as;
 
     dev = qdev_new(TYPE_FW_CFG_IO);
     if (!dma_requested) {
@@ -1048,7 +1047,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         /* 64 bits for the address field */
         s->dma_as = dma_as;
         s->dma_addr = 0;
-        memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
+        /* DMA register ioport is always at base + 4 */
+        memory_region_add_subregion(iomem, iobase + 4, &s->dma_iomem);
     }
 
     return s;
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 45a3747908..be3fb5f8aa 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -305,8 +305,21 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
                                     Object *parent, const char *part,
                                     const char *filename, Error **errp);
 
-FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
-                                AddressSpace *dma_as);
+/**
+ * fw_cfg_init_io_dma:
+ * @iobase: x86 port number which is the base of the fw_cfg port range
+ * @dma_as: the device will do DMA to/from this AddressSpace
+ *
+ * Create a fw_cfg device and map it into the specified I/O port range.
+ *
+ * This creates a device with the x86 PC standard port I/O layout:
+ * - Selector Register IOport: @iobase
+ * - Data Register IOport:     @iobase + 1
+ * - DMA Address IOport:       @iobase + 4
+ *
+ * Returns the device object.
+ */
+FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
 /**
-- 
2.43.0


