Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7EFC44521
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD9d-0000LK-Su; Sat, 18 Jul 2026 18:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD9c-0000JK-CG; Sat, 18 Jul 2026 18:05:04 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD9Z-000604-Pd; Sat, 18 Jul 2026 18:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412301; x=1815948301;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tKAFIGvuvg+rvsXblBX4laucz3nii8xsoj3mnsvZRt4=;
 b=qNmOhyMID34X3nt9nd782xtoE4kE7Sb0mhGyj7cEMXUZCeyIurKUkpTQ
 PN4lRZ1oXSMn7iqtqfH3VJPVFms6tiQOR+mDjLbaHsMujnsMV4TPs0p/a
 FzZHMglo0HMC7PAizgZ90rkd5zLbQ2XYnAorP/ub3CrSZhqTi2AabT7yI
 5ufq6AodsenwZyNRoHcuF2k6F6fBifyrlBZz9bndSb6+4Zv1vwR4kHSZ3
 YwYg5e9YQfz5TtucEYMaqsfFM/4LgvDoMn5w3V25IbGPbb3MKu1zpWp3M
 XojYxdvkBoAjxfozscjqsB+2h6Zp2lY5jVOeHkYsJMRrVLQbiiH0fVtJv w==;
X-CSE-ConnectionGUID: nG2E/lsxTzKuTF0892LWqQ==
X-CSE-MsgGUID: aR7+0wUfT2yzt98xV2z6SA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23423481"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:04:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:12906]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id 028e2e9d-b795-427e-bae5-af8c9c9d0a84; Sat, 18 Jul 2026 22:04:57 +0000 (UTC)
X-Farcaster-Flow-ID: 028e2e9d-b795-427e-bae5-af8c9c9d0a84
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:04:57 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:04:47 +0000
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
Subject: [RFC PATCH v2 100/137] hw/tricore: Give memory regions an explicit
 owner
Date: Sat, 18 Jul 2026 21:36:15 +0000
Message-ID: <20260718213652.37673-101-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert memory_region_init*() calls that pass NULL owner to pass
the enclosing machine or device instead.

Thread Object *owner through the static make_rom() / make_ram() / make_alias() helpers in tc27x_soc.c. All callers are inside tc27x_soc_init_memory_mapping(DeviceState *dev_soc).

No functional change intended.

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/tricore/tc27x_soc.c         | 77 +++++++++++++++++-----------------
 hw/tricore/tricore_testboard.c | 12 +++---
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index 5b1b07cee1..0475698b29 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -67,10 +67,10 @@ const MemmapEntry tc27x_soc_memmap[] = {
  * Initialize the auxiliary ROM region @mr and map it into
  * the memory map at @base.
  */
-static void make_rom(MemoryRegion *mr, const char *name,
+static void make_rom(Object *owner, MemoryRegion *mr, const char *name,
                      hwaddr base, hwaddr size)
 {
-    memory_region_init_rom(mr, NULL, name, size, &error_fatal);
+    memory_region_init_rom(mr, owner, name, size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
 
@@ -78,10 +78,10 @@ static void make_rom(MemoryRegion *mr, const char *name,
  * Initialize the auxiliary RAM region @mr and map it into
  * the memory map at @base.
  */
-static void make_ram(MemoryRegion *mr, const char *name,
+static void make_ram(Object *owner, MemoryRegion *mr, const char *name,
                      hwaddr base, hwaddr size)
 {
-    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
+    memory_region_init_ram(mr, owner, name, size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
 
@@ -89,10 +89,10 @@ static void make_ram(MemoryRegion *mr, const char *name,
  * Create an alias of an entire original MemoryRegion @orig
  * located at @base in the memory map.
  */
-static void make_alias(MemoryRegion *mr, const char *name,
+static void make_alias(Object *owner, MemoryRegion *mr, const char *name,
                            MemoryRegion *orig, hwaddr base)
 {
-    memory_region_init_alias(mr, NULL, name, orig, 0,
+    memory_region_init_alias(mr, owner, name, orig, 0,
                              memory_region_size(orig));
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
@@ -101,81 +101,82 @@ static void tc27x_soc_init_memory_mapping(DeviceState *dev_soc)
 {
     TC27XSoCState *s = TC27X_SOC(dev_soc);
     TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
+    Object *obj = OBJECT(dev_soc);
 
-    make_ram(&s->cpu0mem.dspr, "CPU0.DSPR",
+    make_ram(obj, &s->cpu0mem.dspr, "CPU0.DSPR",
         sc->memmap[TC27XD_DSPR0].base, sc->memmap[TC27XD_DSPR0].size);
-    make_ram(&s->cpu0mem.pspr, "CPU0.PSPR",
+    make_ram(obj, &s->cpu0mem.pspr, "CPU0.PSPR",
         sc->memmap[TC27XD_PSPR0].base, sc->memmap[TC27XD_PSPR0].size);
-    make_ram(&s->cpu1mem.dspr, "CPU1.DSPR",
+    make_ram(obj, &s->cpu1mem.dspr, "CPU1.DSPR",
         sc->memmap[TC27XD_DSPR1].base, sc->memmap[TC27XD_DSPR1].size);
-    make_ram(&s->cpu1mem.pspr, "CPU1.PSPR",
+    make_ram(obj, &s->cpu1mem.pspr, "CPU1.PSPR",
         sc->memmap[TC27XD_PSPR1].base, sc->memmap[TC27XD_PSPR1].size);
-    make_ram(&s->cpu2mem.dspr, "CPU2.DSPR",
+    make_ram(obj, &s->cpu2mem.dspr, "CPU2.DSPR",
         sc->memmap[TC27XD_DSPR2].base, sc->memmap[TC27XD_DSPR2].size);
-    make_ram(&s->cpu2mem.pspr, "CPU2.PSPR",
+    make_ram(obj, &s->cpu2mem.pspr, "CPU2.PSPR",
         sc->memmap[TC27XD_PSPR2].base, sc->memmap[TC27XD_PSPR2].size);
 
     /* TODO: Control Cache mapping with Memory Test Unit (MTU) */
-    make_ram(&s->cpu2mem.dcache, "CPU2.DCACHE",
+    make_ram(obj, &s->cpu2mem.dcache, "CPU2.DCACHE",
         sc->memmap[TC27XD_DCACHE2].base, sc->memmap[TC27XD_DCACHE2].size);
-    make_ram(&s->cpu2mem.dtag,   "CPU2.DTAG",
+    make_ram(obj, &s->cpu2mem.dtag,   "CPU2.DTAG",
         sc->memmap[TC27XD_DTAG2].base, sc->memmap[TC27XD_DTAG2].size);
-    make_ram(&s->cpu2mem.pcache, "CPU2.PCACHE",
+    make_ram(obj, &s->cpu2mem.pcache, "CPU2.PCACHE",
         sc->memmap[TC27XD_PCACHE2].base, sc->memmap[TC27XD_PCACHE2].size);
-    make_ram(&s->cpu2mem.ptag,   "CPU2.PTAG",
+    make_ram(obj, &s->cpu2mem.ptag,   "CPU2.PTAG",
         sc->memmap[TC27XD_PTAG2].base, sc->memmap[TC27XD_PTAG2].size);
 
-    make_ram(&s->cpu1mem.dcache, "CPU1.DCACHE",
+    make_ram(obj, &s->cpu1mem.dcache, "CPU1.DCACHE",
         sc->memmap[TC27XD_DCACHE1].base, sc->memmap[TC27XD_DCACHE1].size);
-    make_ram(&s->cpu1mem.dtag,   "CPU1.DTAG",
+    make_ram(obj, &s->cpu1mem.dtag,   "CPU1.DTAG",
         sc->memmap[TC27XD_DTAG1].base, sc->memmap[TC27XD_DTAG1].size);
-    make_ram(&s->cpu1mem.pcache, "CPU1.PCACHE",
+    make_ram(obj, &s->cpu1mem.pcache, "CPU1.PCACHE",
         sc->memmap[TC27XD_PCACHE1].base, sc->memmap[TC27XD_PCACHE1].size);
-    make_ram(&s->cpu1mem.ptag,   "CPU1.PTAG",
+    make_ram(obj, &s->cpu1mem.ptag,   "CPU1.PTAG",
         sc->memmap[TC27XD_PTAG1].base, sc->memmap[TC27XD_PTAG1].size);
 
-    make_ram(&s->cpu0mem.pcache, "CPU0.PCACHE",
+    make_ram(obj, &s->cpu0mem.pcache, "CPU0.PCACHE",
         sc->memmap[TC27XD_PCACHE0].base, sc->memmap[TC27XD_PCACHE0].size);
-    make_ram(&s->cpu0mem.ptag,   "CPU0.PTAG",
+    make_ram(obj, &s->cpu0mem.ptag,   "CPU0.PTAG",
         sc->memmap[TC27XD_PTAG0].base, sc->memmap[TC27XD_PTAG0].size);
 
     /*
      * TriCore QEMU executes CPU0 only, thus it is sufficient to map
      * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
      */
-    make_alias(&s->psprX, "LOCAL.PSPR", &s->cpu0mem.pspr,
+    make_alias(obj, &s->psprX, "LOCAL.PSPR", &s->cpu0mem.pspr,
         sc->memmap[TC27XD_PSPRX].base);
-    make_alias(&s->dsprX, "LOCAL.DSPR", &s->cpu0mem.dspr,
+    make_alias(obj, &s->dsprX, "LOCAL.DSPR", &s->cpu0mem.dspr,
         sc->memmap[TC27XD_DSPRX].base);
 
-    make_ram(&s->flashmem.pflash0_c, "PF0",
+    make_ram(obj, &s->flashmem.pflash0_c, "PF0",
         sc->memmap[TC27XD_PFLASH0_C].base, sc->memmap[TC27XD_PFLASH0_C].size);
-    make_ram(&s->flashmem.pflash1_c, "PF1",
+    make_ram(obj, &s->flashmem.pflash1_c, "PF1",
         sc->memmap[TC27XD_PFLASH1_C].base, sc->memmap[TC27XD_PFLASH1_C].size);
-    make_ram(&s->flashmem.dflash0,   "DF0",
+    make_ram(obj, &s->flashmem.dflash0,   "DF0",
         sc->memmap[TC27XD_DFLASH0].base, sc->memmap[TC27XD_DFLASH0].size);
-    make_ram(&s->flashmem.dflash1,   "DF1",
+    make_ram(obj, &s->flashmem.dflash1,   "DF1",
         sc->memmap[TC27XD_DFLASH1].base, sc->memmap[TC27XD_DFLASH1].size);
-    make_ram(&s->flashmem.olda_c,    "OLDA",
+    make_ram(obj, &s->flashmem.olda_c,    "OLDA",
         sc->memmap[TC27XD_OLDA_C].base, sc->memmap[TC27XD_OLDA_C].size);
-    make_rom(&s->flashmem.brom_c,    "BROM",
+    make_rom(obj, &s->flashmem.brom_c,    "BROM",
         sc->memmap[TC27XD_BROM_C].base, sc->memmap[TC27XD_BROM_C].size);
-    make_ram(&s->flashmem.lmuram_c,  "LMURAM",
+    make_ram(obj, &s->flashmem.lmuram_c,  "LMURAM",
         sc->memmap[TC27XD_LMURAM_C].base, sc->memmap[TC27XD_LMURAM_C].size);
-    make_ram(&s->flashmem.emem_c,    "EMEM",
+    make_ram(obj, &s->flashmem.emem_c,    "EMEM",
         sc->memmap[TC27XD_EMEM_C].base, sc->memmap[TC27XD_EMEM_C].size);
 
-    make_alias(&s->flashmem.pflash0_u, "PF0.U",    &s->flashmem.pflash0_c,
+    make_alias(obj, &s->flashmem.pflash0_u, "PF0.U",    &s->flashmem.pflash0_c,
         sc->memmap[TC27XD_PFLASH0_U].base);
-    make_alias(&s->flashmem.pflash1_u, "PF1.U",    &s->flashmem.pflash1_c,
+    make_alias(obj, &s->flashmem.pflash1_u, "PF1.U",    &s->flashmem.pflash1_c,
         sc->memmap[TC27XD_PFLASH1_U].base);
-    make_alias(&s->flashmem.olda_u,    "OLDA.U",   &s->flashmem.olda_c,
+    make_alias(obj, &s->flashmem.olda_u,    "OLDA.U",   &s->flashmem.olda_c,
         sc->memmap[TC27XD_OLDA_U].base);
-    make_alias(&s->flashmem.brom_u,    "BROM.U",   &s->flashmem.brom_c,
+    make_alias(obj, &s->flashmem.brom_u,    "BROM.U",   &s->flashmem.brom_c,
         sc->memmap[TC27XD_BROM_U].base);
-    make_alias(&s->flashmem.lmuram_u,  "LMURAM.U", &s->flashmem.lmuram_c,
+    make_alias(obj, &s->flashmem.lmuram_u,  "LMURAM.U", &s->flashmem.lmuram_c,
         sc->memmap[TC27XD_LMURAM_U].base);
-    make_alias(&s->flashmem.emem_u,    "EMEM.U",   &s->flashmem.emem_c,
+    make_alias(obj, &s->flashmem.emem_u,    "EMEM.U",   &s->flashmem.emem_c,
         sc->memmap[TC27XD_EMEM_U].base);
 }
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 9e8cccbd59..4b5398ab95 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -70,17 +70,17 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
 
     cpu = TRICORE_CPU(cpu_create(mo, "cpu", machine->cpu_type));
     env = &cpu->env;
-    memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
+    memory_region_init_ram(ext_cram, OBJECT(machine), "powerlink_ext_c.ram",
                            2 * MiB, &error_fatal);
-    memory_region_init_ram(ext_dram, NULL, "powerlink_ext_d.ram",
+    memory_region_init_ram(ext_dram, OBJECT(machine), "powerlink_ext_d.ram",
                            4 * MiB, &error_fatal);
-    memory_region_init_ram(int_cram, NULL, "powerlink_int_c.ram", 48 * KiB,
+    memory_region_init_ram(int_cram, OBJECT(machine), "powerlink_int_c.ram", 48 * KiB,
                            &error_fatal);
-    memory_region_init_ram(int_dram, NULL, "powerlink_int_d.ram", 48 * KiB,
+    memory_region_init_ram(int_dram, OBJECT(machine), "powerlink_int_d.ram", 48 * KiB,
                            &error_fatal);
-    memory_region_init_ram(pcp_data, NULL, "powerlink_pcp_data.ram",
+    memory_region_init_ram(pcp_data, OBJECT(machine), "powerlink_pcp_data.ram",
                            16 * KiB, &error_fatal);
-    memory_region_init_ram(pcp_text, NULL, "powerlink_pcp_text.ram",
+    memory_region_init_ram(pcp_text, OBJECT(machine), "powerlink_pcp_text.ram",
                            32 * KiB, &error_fatal);
 
     memory_region_add_subregion(sysmem, 0x80000000, ext_cram);
-- 
2.47.1


