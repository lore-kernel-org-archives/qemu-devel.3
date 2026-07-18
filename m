Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A47C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDAZ-0001N5-BH; Sat, 18 Jul 2026 18:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDAG-0001C5-4P; Sat, 18 Jul 2026 18:05:44 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDAE-0006DK-90; Sat, 18 Jul 2026 18:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412342; x=1815948342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uYXfcUGTcd7vy1ZKIayA3ffKEGDWK1Kjsc1hvCY3J34=;
 b=VJx793g1WGxNGAGsJKic6KFBBY+34DMqgmRhnJ2aLe9uCy2HyHdT2Bf4
 1FwNuBp3m4WoFrgHx8w76nVT55qoCUSk1t1AjiATCPh2e7VsmK5fXIZZe
 WBQC2hRuCsqHQYOQ62aowiBRRfQW+dLFAUyDt88n1KS0dreabEFUA1bVU
 umyUg+CQzaKscOyu/1vAymDPatw1ryD8UIhHNVMaslNFkx6JedB5KG9C1
 eVfJ78lvbDdBwOdjZu4GlnNCxSzKAHudtgXyNaAV8zGg+BEe7s+e7ogLx
 x3y7z2TdM9BdqnlvK2ld0zL35msiJh7PEI8dZTAlK3g5u/kcJ98UWG5eA g==;
X-CSE-ConnectionGUID: oVLAanCzRteQDpF0CiVGkQ==
X-CSE-MsgGUID: B8iD5A6PTs+zlSFaABZREw==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23944849"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:05:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:27628]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.230:2525]
 with esmtp (Farcaster)
 id 3290fc78-ff97-4dee-b4da-65640f42e02a; Sat, 18 Jul 2026 22:05:38 +0000 (UTC)
X-Farcaster-Flow-ID: 3290fc78-ff97-4dee-b4da-65640f42e02a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:05:38 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:05:28 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 102/137] hw/display: Give memory regions an explicit
 owner
Date: Sat, 18 Jul 2026 21:36:17 +0000
Message-ID: <20260718213652.37673-103-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.26.1.71;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Convert memory_region_init*() calls in device realize functions
to pass OBJECT(dev) instead of NULL. All sites (cg3, g364fb,
virtio-gpu-gl, vmware_vga) already have the DeviceState in scope.

omap_lcdc is handled separately together with the other OMAP
peripherals.

No functional change intended.

RAMBlock idstrs are unchanged for all conversions except
vmware_vga.c: the vmsvga.fifo RAM is now owned by a PCI device, so the
convenience wrapper is replaced with the _nomigrate variant plus an
explicit vmstate_register_ram_global() to preserve the historical bare
idstr.  All other display owners here are Machine or SysBus devices.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/display/cg3.c           |  2 +-
 hw/display/g364fb.c        |  2 +-
 hw/display/virtio-gpu-gl.c |  2 +-
 hw/display/vmware_vga.c    | 12 ++++++++++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index f9dda1549d..507b0d8189 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -304,7 +304,7 @@ static void cg3_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    memory_region_init_ram(&s->vram_mem, NULL, "cg3.vram", s->vram_size,
+    memory_region_init_ram(&s->vram_mem, OBJECT(dev), "cg3.vram", s->vram_size,
                            &error_fatal);
     memory_region_set_log(&s->vram_mem, true, DIRTY_MEMORY_VGA);
     sysbus_init_mmio(sbd, &s->vram_mem);
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index af54f1f900..0bd993b826 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -482,7 +482,7 @@ static void g364fb_init(DeviceState *dev, G364State *s)
 
     memory_region_init_io(&s->mem_ctrl, OBJECT(dev), &g364fb_ctrl_ops, s,
                           "ctrl", 0x180000);
-    memory_region_init_ram(&s->mem_vram, NULL, "g364fb.vram", s->vram_size,
+    memory_region_init_ram(&s->mem_vram, OBJECT(dev), "g364fb.vram", s->vram_size,
                            &error_fatal);
     memory_region_set_log(&s->mem_vram, true, DIRTY_MEMORY_VGA);
 }
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c466..b6f183123d 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -153,7 +153,7 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
         }
 
         gl->hostmem_mmap = map;
-        memory_region_init_ram_ptr(&gl->hostmem_background, NULL,
+        memory_region_init_ram_ptr(&gl->hostmem_background, OBJECT(qdev),
                                    "hostmem-background", b->conf.hostmem,
                                    gl->hostmem_mmap);
         memory_region_add_subregion(&b->hostmem, 0, &gl->hostmem_background);
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f6f9edfd1d..571c3184c2 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1257,8 +1257,16 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
     s->vga.con = qemu_graphic_console_create(dev, 0, &vmsvga_ops, s);
 
     s->fifo_size = SVGA_FIFO_SIZE;
-    memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
-                           &error_fatal);
+    /*
+     * The fifo RAM must keep its historical bare RAMBlock idstr
+     * ("vmsvga.fifo") for cross-version migration.  Use _nomigrate + a
+     * global vmstate registration so the QOM owner is the PCI device but
+     * the migration idstr is not prefixed with the PCI dev-path.
+     */
+    memory_region_init_ram_flags_nomigrate(&s->fifo_ram, OBJECT(dev),
+                                           "vmsvga.fifo", s->fifo_size, 0,
+                                           &error_fatal);
+    vmstate_register_ram_global(&s->fifo_ram);
     s->fifo_ptr = memory_region_get_ram_ptr(&s->fifo_ram);
 
     vga_common_init(&s->vga, OBJECT(dev), &error_fatal);
-- 
2.47.1


