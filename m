Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF904C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDB5-0001wg-Sv; Sat, 18 Jul 2026 18:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDAc-0001Sx-Pk; Sat, 18 Jul 2026 18:06:20 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDAX-0006EX-52; Sat, 18 Jul 2026 18:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412361; x=1815948361;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WVG7UbEd5jReDUPwyZrcT5g0dUYQucY4eitOzKM6+GY=;
 b=jwChfzwMmc9QTb5gNfYdSl2qJUwMKNIAo7NJPsGjYjxzHsg2mqgeGvVH
 Lwj0t1Bq46oz3n0yKGm9O/vHdFAB2QJ6sbRzrZjv6ozwPxrEHfolysvKn
 sTxzn6ekKI7V/HX/6bzuCnL50rM/EceIn5q59MeEO4CF4LC2dZJqAXgyQ
 knX/rBpfJUwcTYbhegK6J/7Vj2ShqKNoUEUdiKvsZeXfdrt+QMOgIHsKk
 yHmPIeLJD/RmCdncv67dBYmvmtSaLEp4MzzvOBqsdDfsWi1qCJkUYvqth
 yb2xu5BRBe0vattsIhZYAZAcyLuUcyUMK/ZP4lZN7oiW+/b7q3A0Dfih2 Q==;
X-CSE-ConnectionGUID: vyNQ7YcwR32+ML3nTz/a7A==
X-CSE-MsgGUID: uaheAJs9TTKFfoJU1OXPOQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23917985"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:05:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:13970]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.17:2525]
 with esmtp (Farcaster)
 id 240222be-972a-462e-8aca-ac2f19d26365; Sat, 18 Jul 2026 22:05:57 +0000 (UTC)
X-Farcaster-Flow-ID: 240222be-972a-462e-8aca-ac2f19d26365
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:05:56 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:05:47 +0000
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
Subject: [RFC PATCH v2 104/137] hw/char: Give parallel and htif memory regions
 an explicit owner
Date: Sat, 18 Jul 2026 21:36:19 +0000
Message-ID: <20260718213652.37673-105-graf@amazon.com>
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
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Thread Object *owner as the first argument through parallel_mm_init()
and htif_mm_init(). All callers are inside board init functions
and pass OBJECT(machine).

No functional change intended.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/char/parallel.c           | 5 +++--
 hw/char/riscv_htif.c         | 5 +++--
 hw/hppa/machine.c            | 5 +++--
 hw/mips/jazz.c               | 2 +-
 hw/riscv/spike.c             | 2 +-
 include/hw/char/parallel.h   | 3 ++-
 include/hw/char/riscv_htif.h | 3 ++-
 7 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 07bbc9443f..39a1d77e9f 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -585,7 +585,8 @@ static const MemoryRegionOps parallel_mm_ops = {
 };
 
 /* If fd is zero, it means that the parallel device uses the console */
-bool parallel_mm_init(MemoryRegion *address_space,
+bool parallel_mm_init(Object *owner,
+                      MemoryRegion *address_space,
                       hwaddr base, int it_shift, qemu_irq irq,
                       Chardev *chr)
 {
@@ -597,7 +598,7 @@ bool parallel_mm_init(MemoryRegion *address_space,
     s->it_shift = it_shift;
     qemu_register_reset(parallel_reset, s);
 
-    memory_region_init_io(&s->iomem, NULL, &parallel_mm_ops, s,
+    memory_region_init_io(&s->iomem, owner, &parallel_mm_ops, s,
                           "parallel", 8 << it_shift);
     memory_region_add_subregion(address_space, base, &s->iomem);
     return true;
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 488f938d98..f9e39c31aa 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -329,7 +329,8 @@ static const MemoryRegionOps htif_mm_ops = {
     },
 };
 
-HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
+HTIFState *htif_mm_init(Object *owner,
+                        MemoryRegion *address_space, Chardev *chr,
                         uint64_t nonelf_base, bool custom_base)
 {
     uint64_t base, size, tohost_offset, fromhost_offset;
@@ -359,7 +360,7 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
     qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
         htif_be_change, s, NULL, true);
 
-    memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
+    memory_region_init_io(&s->mmio, owner, &htif_mm_ops, s,
                           TYPE_HTIF_UART, size);
     memory_region_add_subregion_overlap(address_space, base,
                                         &s->mmio, 1);
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 233cf6318b..ea02b9e70e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -613,7 +613,8 @@ static void machine_HP_715_init(MachineState *machine)
         serial_hd(0), DEVICE_BIG_ENDIAN);
 
     /* Parallel port */
-    parallel_mm_init(addr_space, translate(NULL, LASI_HPA_715 + LASI_LPT + 0x800), 0,
+    parallel_mm_init(OBJECT(machine), addr_space,
+                     translate(NULL, LASI_HPA_715 + LASI_LPT + 0x800), 0,
                      qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
                      parallel_hds[0]);
 
@@ -706,7 +707,7 @@ static void machine_HP_B160L_init(MachineState *machine)
         serial_hd(1), DEVICE_BIG_ENDIAN);
 
     /* Parallel port */
-    parallel_mm_init(addr_space,
+    parallel_mm_init(OBJECT(machine), addr_space,
                      translate(NULL, LASI_HPA + LASI_LPT + 0x800), 0,
                      qdev_get_gpio_in(lasi_dev, LASI_IRQ_LPT_HPA),
                      parallel_hds[0]);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 8999efb352..ff18b28c86 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -385,7 +385,7 @@ static void mips_jazz_init(MachineState *machine,
 
     /* Parallel port */
     if (parallel_hds[0])
-        parallel_mm_init(address_space, 0x80008000, 0,
+        parallel_mm_init(OBJECT(machine), address_space, 0x80008000, 0,
                          qdev_get_gpio_in(rc4030, 0), parallel_hds[0]);
 
     /* FIXME: missing Jazz sound at 0x8000c000, rc4030[2] */
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9f1a1b5898..cd9a2ee0df 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -247,7 +247,7 @@ static void spike_board_init(MachineState *machine)
                               fdt_load_addr);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, serial_hd(0), memmap[SPIKE_HTIF].base,
+    htif_mm_init(OBJECT(machine), system_memory, serial_hd(0), memmap[SPIKE_HTIF].base,
                  htif_custom_base);
 }
 
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 782cc12602..7e8b9c9012 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -25,7 +25,8 @@ typedef struct ParallelState {
 
 void parallel_hds_isa_init(Object *parent, ISABus *bus, int n);
 
-bool parallel_mm_init(MemoryRegion *address_space,
+bool parallel_mm_init(Object *owner,
+                      MemoryRegion *address_space,
                       hwaddr base, int it_shift, qemu_irq irq,
                       Chardev *chr);
 
diff --git a/include/hw/char/riscv_htif.h b/include/hw/char/riscv_htif.h
index 9d61e60d0a..40516adc08 100644
--- a/include/hw/char/riscv_htif.h
+++ b/include/hw/char/riscv_htif.h
@@ -48,7 +48,8 @@ void htif_symbol_callback(const char *st_name, int st_info, uint64_t st_value,
     uint64_t st_size);
 
 /* legacy pre qom */
-HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
+HTIFState *htif_mm_init(Object *owner,
+                        MemoryRegion *address_space, Chardev *chr,
                         uint64_t nonelf_base, bool custom_base);
 
 #endif
-- 
2.47.1


