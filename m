Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21784F55126
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8SP-0003O7-Nf; Sun, 08 Mar 2026 03:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RZ-0002KP-W1
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:56 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RW-00033S-LS
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:52 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so9004119eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954449; x=1773559249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WzztSLe6IJjCsyASv5LBpq00D3Si30OBdTuZqVzuOjU=;
 b=P3/nBtw5fTPH8cUv+Fg15JJGYbR79kgRDtPxzEe0i5ZFAseemWWFAByKHgxgBKBwlr
 ch/JXVn+RrFs8I+uPHTbHquJa4Zq1FiKV05SI+MA5juX5tpSmKlE/PYZnE2vG/dweawR
 R8B9IxCPR1dDKlKv4DGVVhZ4QwfEEGo7vMrUjKvTZC754JBpojGDcUo3VPgagmwZhUeL
 CI5T/VpIqtc9VQ9S4repVrvBEsLB2+11FRD6soJnM/8F/4WGm0rBKBVJ95u0jSMJNIwj
 9IjVW4Lk5Ocas2ruwf/mquohlJJFGHNzV7MY+cQjrJrMTdXJWQDbqxeb63Lrd80m2fN4
 dgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954449; x=1773559249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WzztSLe6IJjCsyASv5LBpq00D3Si30OBdTuZqVzuOjU=;
 b=VNQfgfsY1NLdtru0+WmSI/iCuSY4VDZwWJZ1wM+IG7AYB0efUdy700RN9cJGkGQrhD
 wp5DLvJS6bKzvNGJh+mGal9gh+hKS46l3uneW0fVZcmUB3/RlqlVR8XRnTx0Hoc1mMZH
 5OwWev6JFw5znz5JsiZ+AjoEZ6zogyedaagtClmupKdRKbeFnnu3N+e7QHa7k1gA+kjz
 ob2gbLBlQI/Q/X72+GkGm2kQgQmg4OsJ2x+GJVwYlDuk2Jn5DzLKU3WPOTo/tp+42AVO
 iuAh3JVYd0hhm3+rpory0fdGOfOfqsKl8av6dCgoFisFzH1HoWpAA/85St/xInktLMKQ
 VlNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSd2ELl5/n/NTYLiC4IpNfMKNexUOJebz1/NEn6gxR56TzrIkAhqg04k+kUKxnqkEjbArHuig4OTV6@nongnu.org
X-Gm-Message-State: AOJu0YwIOX9sKiBRro09rDxvEWyL1dhfAXa5+5Wqw0BNapKtqIR1ceT3
 bJQj13hsSUEKI6lEXD48gVgCNgcdRrdDb2Tnlk8U+sGjyMInYXyxuSPe
X-Gm-Gg: ATEYQzwOQ9ic5/73T/HrIMgIaYseYUP8mIe67m3eClZVPsJeGYoZrLOkHGBHJ0bjyxC
 eEB4Pvg3LieVFV9QKfiZyvC6RmpoXDfq0EgS2yAVZGg/fpxLknf3Z2yD1WSgqQM00+sG8kzKotm
 ISYlPZw2ePshkraKAbXk9J7XOcXIH4EYWPs8Q9OX/K+1m7l6UJVHDRsaS4I9hzhy2lgaLycRgW6
 r2hhiJaoqh7YtowEi65ZDftxj3ueqTOd8S4W/C7uT+FjcGjawHetOCk7DaD5GlQSj6JbhuNPRYS
 kp9ZjsteNh/GEouV4H0pXjv2EahVM+jmwUzBsNMK39OOFY6qn9E8zWIYQV5boBFPI2H09hMTWLW
 gBV1amKVkURraMOvHaTG+Vc7HOH1Qvg7M3ZQD8aJrUX8KYXab1CZ6Vq3hdog6+EX9kwlW+oINbS
 JJ97T7EZjZKfS8l0pf3bTtUixqQD3jEP5192haSGj5ScNUuzU9zXfCDWW8iu3rx/fidn5+n9R9a
 vsgCvlZAHljMcxO23yquYDLkCQ=
X-Received: by 2002:a05:7301:1e89:b0:2b7:32fe:4bbb with SMTP id
 5a478bee46e88-2be4deaed60mr2676045eec.11.1772954449182; 
 Sat, 07 Mar 2026 23:20:49 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:47 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 23/28] hw/riscv/virt: integrate the Debug Module
Date: Sun,  8 Mar 2026 15:17:26 +0800
Message-ID: <9d4f695c95229e5b28247c477f2278294f5b2cbb.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Expand the VIRT_DEBUG memory map entry from 0x100 to
RISCV_DM_SIZE (0x1000 = 4 KiB) to accommodate the full
Debug Module address space: DMI registers, work area, and ROM
entry vector.

Create the Debug Module device via riscv_dm_create() and wire
each hart's halt-request GPIO to it. Set dm_halt_addr so the
CPU enters the DM ROM entry point on debug-mode entry.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/virt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bbce2fb667..0a7e29a743 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -58,6 +58,7 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
+#include "hw/riscv/dm.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
@@ -80,7 +81,7 @@ static bool virt_aclint_allowed(void)
 }
 
 static const MemMapEntry virt_memmap[] = {
-    [VIRT_DEBUG] =        {        0x0,         0x100 },
+    [VIRT_DEBUG] =        {        0x0, RISCV_DM_SIZE },
     [VIRT_MROM] =         {     0x1000,        0xf000 },
     [VIRT_TEST] =         {   0x100000,        0x1000 },
     [VIRT_RTC] =          {   0x101000,        0x1000 },
@@ -1702,6 +1703,24 @@ static void virt_machine_init(MachineState *machine)
 
     create_platform_bus(s, mmio_irqchip);
 
+    /* Create Debug Module and connect each hart's halt-request IRQ */
+    int total_harts = machine->smp.cpus;
+    DeviceState *dm = riscv_dm_create(system_memory,
+                                      s->memmap[VIRT_DEBUG].base,
+                                      total_harts);
+
+    for (int h = 0; h < total_harts; h++) {
+        CPUState *cs = qemu_get_cpu(h);
+        RISCVCPU *rcpu = RISCV_CPU(cs);
+
+        qdev_connect_gpio_out(dm, h,
+                              qdev_get_gpio_in_named(DEVICE(cs),
+                                                     "dm-halt-req", 0));
+        rcpu->env.dm_rom_present = true;
+        rcpu->env.dm_halt_addr = s->memmap[VIRT_DEBUG].base +
+                                 RISCV_DM_ROM_ENTRY;
+    }
+
     serial_mm_init(system_memory, s->memmap[VIRT_UART0].base,
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
-- 
2.53.0


