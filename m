Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5B1CC6B2D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHC0B-00073l-K6; Wed, 14 Oct 2026 23:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHC00-0006xS-RP
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBzz-0006py-2W
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:19:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d8f2ed7bdcso5742925ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034357; x=1792639157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1wcmKnMN5dUbkhw29h7gAt91JYUH/Ta/i7WlMlmB/m0=;
 b=Rd/Us4IjfX1Wt7Rmj+c/WHfFYC6a+ZLWufCZ9jucjDWEaiaR7zeA1O2fLPEG5BpdAE
 K0CzeFqofrOUI3+PPIw0kSOIyYUeMWxPmOQ6og/mMdnzP0zc3uCDMADOQguDC/2KJsnP
 HF32Rh3lZVTGRYU0z3xEZxZBKwZRd1YgIZoJTkDhsh4jnLglE9r5bXtKl+65X8MSc6Be
 c86hMbJ/x1I0uRrOSOEmloNw+ECGCOGv5N+SfUMhVa+urAv7WlMTsmQl+GQRmBq0ysZ8
 z+uZ8i/Ml+K0Jrx6rPVezQOQvqyX7//W9cLY74IRu00ufaQOuEY47dHdIh/DUD8KRU6Y
 Lk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034357; x=1792639157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1wcmKnMN5dUbkhw29h7gAt91JYUH/Ta/i7WlMlmB/m0=;
 b=CYhhQ2wP2/y4agrt2U+XHiX39ms8PX20s1YeZmdPxFYg7c2hfqBEtsxqWnS7Xpbiuw
 7JaD91G4hup2ezlknFEE3LHuq5uLYHFl8s9uX6LDqFg2/EeciwypMm6sCc1OcrVXdbHn
 jtdt4CJSovPN0t//Ig0OokvVWBkGOxUG8WaFz5T+VKXX+v6bQbBd3cqWI2FCX7s+u2ly
 rUz3MnTS3K0nBp78P6+dIncltMtBu4PH3SYrxa9xjJpS6ym12YYzX88+7iPaleofFoTn
 M3p4ABDH5+VsZzhUEE1v0VSC7N3w5BvMO+yhOJREZj1Hr1KipOQ7qzTnxApOKMFxXh7M
 buOw==
X-Gm-Message-State: AFq9FYIkp8yHqzpf3hawngPNBVQlKDnK0/yc9m/YYGMoybKFBob1NoQl
 /hJOa1kebdabp3XawLCmPu4S/sk7yZs2eCAu3iZHtZZ5onRkcXquj7D52VmlMlpVRZFamnIBwFu
 JDirj
X-Gm-Gg: AYBFou0Hy0g5HcA09QZiba+ulJxKZWxhjRzj56AOABpLiBf56ryD3wuMt3OYR/ydIo8
 iRppUb9Igy8KGrzihvV5qyZRsc58bG31MK6RZGbpaxYU0ZHjV63eOlkpsIWi5pnTfrdNZGM11YC
 Nu651puArrSZRvoiUrE5qYHDgHM7iipxzUEMy70xi8mE2ODDJm8xr7PE+zEL+2U47H5K8k1oEBW
 ooM+vWCiH4i0E9ZlgBJRCmkLYk1oTJ3upc1yfb78B12Qb6P8noEWLV7LTb29Ku685ixWE+y8DtR
 ZiFoWpXtoxl+durQPJtFsIsYcqjA5YfbxH1WIylGUsbwXBxuYKkdvsg4Vkblc9dX4OWej5Gb4iy
 +9d63pdU0TIoLqV1k2b15RD6KXin2NWPmdma2KqThzZZFMbajwtM5L+pwNJn7o4N0Sx9iUjn5CE
 YVx8M/CcS6myBgSwyXki1lNAKP7YKspsx075hvhC0n7zTrnCC1pLzvjcbNCZUHUhgFvsQReru7g
 FyxwFRSwrUbZJlfmui8blO3P27lkXYRMVAQkK5Ojr+GDz8U96wc/Nl7iA==
X-Received: by 2002:a17:90b:224c:b0:3a6:f1d2:57fa with SMTP id
 98e67ed59e1d1-3ab3a9d3e21mr29051262a91.4.1792034357460; 
 Wed, 14 Oct 2026 20:19:17 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:19:16 -0700 (PDT)
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
Subject: [PATCH 09/12] hw/riscv/atlantis: Back RCPU memory region by
 unimplemented device
Date: Thu, 15 Oct 2026 13:18:01 +1000
Message-ID: <20261015031804.2406055-10-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Most devices on the RCPU memmap are not modeled yet in QEMU. Back the
entire 4G memory view of the RCPU by a low priority unimplemented
device. This prevents accesses to non-modeled device from faulting.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/Kconfig               |  1 +
 hw/riscv/tt_atlantis.c         | 20 ++++++++++++++++++++
 include/hw/riscv/tt_atlantis.h |  6 ++++++
 3 files changed, 27 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 4eccfa443e..8e1812923a 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -150,6 +150,7 @@ config TENSTORRENT
     select DS1338
     select TMP105
     select CPU_CLUSTER
+    select UNIMP
 
 config XIANGSHAN_KUNMINGHU
     bool
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index e2bd1fce08..635f85e44b 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -524,6 +524,17 @@ static void load_fdt(TTAtlantisState *ams)
     create_fdt_memory(ms->fdt, ac->memmap, ms->ram_size);
 }
 
+static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
+                                   const char *name, hwaddr addr, uint64_t size)
+{
+    qdev_prop_set_string(DEVICE(dev), "name", name);
+    qdev_prop_set_uint64(DEVICE(dev), "size", size);
+    sysbus_realize(dev, &error_abort);
+
+    memory_region_add_subregion_overlap(memory, addr,
+                                        sysbus_mmio_get_region(dev, 0), -1000);
+}
+
 static void tt_atlantis_machine_done(Notifier *n, void *data)
 {
     TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
@@ -601,6 +612,8 @@ static void tt_rcpu_cluster_init(Object *obj)
                             TYPE_CPU_CLUSTER);
     object_initialize_child(OBJECT(&rc->cluster), "cpus", &rc->cpus,
                             TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(OBJECT(rc), "tt-rcpu.unimp-mem", &rc->unimp_mem,
+                            TYPE_UNIMPLEMENTED_DEVICE);
 }
 
 static void tt_rcpu_cluster_realize(DeviceState *dev, Error **errp)
@@ -656,6 +669,13 @@ static void tt_rcpu_cluster_realize(DeviceState *dev, Error **errp)
     if (!qdev_realize(DEVICE(&rc->cluster), NULL, errp)) {
         return;
     }
+
+    /*
+     * Map the entire 4G memory view as unimplemented to prevent faults from
+     * devices that have not been modeled yet.
+     */
+    mmio_map_unimplemented(&rc->memory, SYS_BUS_DEVICE(&rc->unimp_mem),
+                           "tt-rcpu.unimp", 0, UINT32_MAX);
 }
 
 static void tt_rcpu_cluster_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 4f79ef5af5..7ef290ca9d 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -16,6 +16,7 @@
 #include "hw/misc/tt_atlantis_prcm.h"
 #include "hw/char/dw8250.h"
 #include "hw/cpu/cluster.h"
+#include "hw/misc/unimp.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
@@ -63,6 +64,11 @@ struct TTRCPUClusterState {
     CPUClusterState cluster;
     MemoryRegion bootrom;
     MemoryRegion sram;
+    /*
+     * All device memory is backed by a catch-all unimplemented device to
+     * prevent faults on accesses to regions not modeled.
+     */
+    UnimplementedDeviceState unimp_mem;
 };
 
 struct TTAtlantisSoCState {
-- 
2.43.0


