Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A374BC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigjb-0005t9-Lg; Sat, 11 Jul 2026 19:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigja-0005qk-18; Sat, 11 Jul 2026 19:03:46 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigjY-0002ht-Bt; Sat, 11 Jul 2026 19:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811024; x=1815347024;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OPixt3dA2I0YABTgFbPfsYIeHgeFDdypEeTEjw+W/WA=;
 b=b16+sCXJvyuKBY6SqEOKqOyUysec3axwOcqUuZ45qL9gyE/m5H1i4M7N
 FnleUV5pc+u3MUn8Rj0QeG5gP4Q1rasoX2II1VjIHbtWaACPfwRXI1ekw
 drdfsemgu5cIYrDgLBXWMcL0i3SsWbD4Cgp1PTJqUgeUXjej/YvOMakOF
 3C8NWspbeUqF7J438YAXTT14dL9wuCY1O7BT11QOeRYM4M3oqm7QNUAEM
 ZfjytytfO5QDoGO1yPmqu1Ckm9lT+ip3gf9/o+aoxxhrLtB11o/BoV3OU
 hQG3agfUsjGrZOMFawn52i+F3ejfi4sFrqAqpgmLKdHBtmOw5QM5p0oZT w==;
X-CSE-ConnectionGUID: O3vM7TWMRhmLXxi6Vt/1YA==
X-CSE-MsgGUID: oDU6o+WPQAex0Dv2HB3/eA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23517384"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:03:40 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:1051]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.212:2525]
 with esmtp (Farcaster)
 id 4fa6175f-a60e-419b-9695-433ff0d02032; Sat, 11 Jul 2026 23:03:40 +0000 (UTC)
X-Farcaster-Flow-ID: 4fa6175f-a60e-419b-9695-433ff0d02032
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:03:40 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:03:31 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [RFC PATCH 101/134] hw/display: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:34 +0000
Message-ID: <20260711223707.42139-102-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.68.102;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/display/cg3.c           | 2 +-
 hw/display/g364fb.c        | 2 +-
 hw/display/virtio-gpu-gl.c | 2 +-
 hw/display/vmware_vga.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
index f6f9edfd1d..0be124fa89 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1257,7 +1257,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
     s->vga.con = qemu_graphic_console_create(dev, 0, &vmsvga_ops, s);
 
     s->fifo_size = SVGA_FIFO_SIZE;
-    memory_region_init_ram(&s->fifo_ram, NULL, "vmsvga.fifo", s->fifo_size,
+    memory_region_init_ram(&s->fifo_ram, OBJECT(dev), "vmsvga.fifo", s->fifo_size,
                            &error_fatal);
     s->fifo_ptr = memory_region_get_ram_ptr(&s->fifo_ram);
 
-- 
2.47.1


