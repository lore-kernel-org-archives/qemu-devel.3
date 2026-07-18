Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223B8C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD8k-0005mZ-77; Sat, 18 Jul 2026 18:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD8e-0005YK-Tg; Sat, 18 Jul 2026 18:04:06 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD8b-0005RH-U1; Sat, 18 Jul 2026 18:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412241; x=1815948241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ajwdLkeuNi8/PpudbHJqNzzmsBm2ieK8uas1me9LcLY=;
 b=Shh7x6QyVTJVC8awZTHY0lpppW6LjJXJFO0ScBpcVIug/0b+A/a7mZD6
 Hwx5/QA9mTc+0VUPMZG5RhCGgB5MmkoKQ38cbjroGg9/OY9/DRyDgMo95
 ooZQGm6kjiIaZyPXrVVO5G+KoLQ9TKkcP1oEQixKgnHZede88amNio/bQ
 aB4ks90SPN1iQBfJDXmzWaBcAZz8ao2u6jl5rtuo+TsOsGuh2sOGN2wPW
 rWINdf5drdeL37MJ93pQM7B5+axS5WKNmdo/BHYC7VH7Mf5BU4+AFeo3X
 7cI3M4G4ELFiqFi44hvoJkgQqdXu21JRR7VXtSjX5lb3trx7n328g5q1N A==;
X-CSE-ConnectionGUID: 9jrHVmm6TjWHnKJf/bv4/w==
X-CSE-MsgGUID: qN9VyImRQfG2CtPRBIsVcg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23942288"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:03:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:30231]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id a4c6e09e-883d-401b-b9f7-a6c0a1a914b2; Sat, 18 Jul 2026 22:03:58 +0000 (UTC)
X-Farcaster-Flow-ID: a4c6e09e-883d-401b-b9f7-a6c0a1a914b2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:03:57 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:03:48 +0000
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
Subject: [RFC PATCH v2 096/137] hw/arm/omap1: Give memory regions an explicit
 owner
Date: Sat, 18 Jul 2026 21:36:11 +0000
Message-ID: <20260718213652.37673-97-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.68.102;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

omap1.c models the TI OMAP310 MPU with ~20 pre-QOM sub-block init
helpers (omap_mpu_timer_init, omap_ulpd_pm_init, omap_pin_cfg_init,
omap_id_init, omap_mpui_init, omap_tipb_bridge_init, omap_tcmi_init,
omap_dpll_init, omap_clkm_init, omap_mpuio_init, omap_uwire_init,
omap_pwl_init, omap_pwt_init, omap_rtc_init, omap_mcbsp_init,
omap_lpg_init, omap_setup_mpui_io, omap_setup_dsp_mapping, ...) that
each create MemoryRegions with owner==NULL.

Thread an Object *owner first argument through every sub-block init
helper. All are static and called only from omap310_mpu_init(),
which already carries an Object *parent from the earlier device
conversion; pass it through.

No functional change intended.

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/omap1.c | 175 ++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 81 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index e5e092e074..be6af35e26 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -221,8 +221,8 @@ static void omap_mpu_timer_reset(struct omap_mpu_timer_s *s)
     s->it_ena = 1;
 }
 
-static struct omap_mpu_timer_s *omap_mpu_timer_init(MemoryRegion *system_memory,
-                hwaddr base,
+static struct omap_mpu_timer_s *omap_mpu_timer_init(Object *owner,
+                MemoryRegion *system_memory, hwaddr base,
                 qemu_irq irq, omap_clk clk)
 {
     struct omap_mpu_timer_s *s = g_new0(struct omap_mpu_timer_s, 1);
@@ -234,7 +234,7 @@ static struct omap_mpu_timer_s *omap_mpu_timer_init(MemoryRegion *system_memory,
     omap_mpu_timer_reset(s);
     omap_timer_clk_setup(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_mpu_timer_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_mpu_timer_ops, s,
                           "omap-mpu-timer", 0x100);
 
     memory_region_add_subregion(system_memory, base, &s->iomem);
@@ -353,8 +353,8 @@ static void omap_wd_timer_reset(struct omap_watchdog_timer_s *s)
     omap_timer_update(&s->timer);
 }
 
-static struct omap_watchdog_timer_s *omap_wd_timer_init(MemoryRegion *memory,
-                hwaddr base,
+static struct omap_watchdog_timer_s *omap_wd_timer_init(Object *owner,
+                MemoryRegion *memory, hwaddr base,
                 qemu_irq irq, omap_clk clk)
 {
     struct omap_watchdog_timer_s *s = g_new0(struct omap_watchdog_timer_s, 1);
@@ -365,7 +365,7 @@ static struct omap_watchdog_timer_s *omap_wd_timer_init(MemoryRegion *memory,
     omap_wd_timer_reset(s);
     omap_timer_clk_setup(&s->timer);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_wd_timer_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_wd_timer_ops, s,
                           "omap-wd-timer", 0x100);
     memory_region_add_subregion(memory, base, &s->iomem);
 
@@ -462,8 +462,8 @@ static void omap_os_timer_reset(struct omap_32khz_timer_s *s)
     s->timer.ar = 1;
 }
 
-static struct omap_32khz_timer_s *omap_os_timer_init(MemoryRegion *memory,
-                hwaddr base,
+static struct omap_32khz_timer_s *omap_os_timer_init(Object *owner,
+                MemoryRegion *memory, hwaddr base,
                 qemu_irq irq, omap_clk clk)
 {
     struct omap_32khz_timer_s *s = g_new0(struct omap_32khz_timer_s, 1);
@@ -474,7 +474,7 @@ static struct omap_32khz_timer_s *omap_os_timer_init(MemoryRegion *memory,
     omap_os_timer_reset(s);
     omap_timer_clk_setup(&s->timer);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_os_timer_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_os_timer_ops, s,
                           "omap-os-timer", 0x800);
     memory_region_add_subregion(memory, base, &s->iomem);
 
@@ -707,11 +707,11 @@ static void omap_ulpd_pm_reset(struct omap_mpu_state_s *mpu)
     omap_clk_reparent(omap_findclk(mpu, "ck_48m"), omap_findclk(mpu, "dpll4"));
 }
 
-static void omap_ulpd_pm_init(MemoryRegion *system_memory,
-                hwaddr base,
+static void omap_ulpd_pm_init(Object *owner,
+                MemoryRegion *system_memory, hwaddr base,
                 struct omap_mpu_state_s *mpu)
 {
-    memory_region_init_io(&mpu->ulpd_pm_iomem, NULL, &omap_ulpd_pm_ops, mpu,
+    memory_region_init_io(&mpu->ulpd_pm_iomem, owner, &omap_ulpd_pm_ops, mpu,
                           "omap-ulpd-pm", 0x800);
     memory_region_add_subregion(system_memory, base, &mpu->ulpd_pm_iomem);
     omap_ulpd_pm_reset(mpu);
@@ -933,11 +933,11 @@ static void omap_pin_cfg_reset(struct omap_mpu_state_s *mpu)
     memset(mpu->mod_conf_ctrl, 0, sizeof(mpu->mod_conf_ctrl));
 }
 
-static void omap_pin_cfg_init(MemoryRegion *system_memory,
-                hwaddr base,
+static void omap_pin_cfg_init(Object *owner,
+                MemoryRegion *system_memory, hwaddr base,
                 struct omap_mpu_state_s *mpu)
 {
-    memory_region_init_io(&mpu->pin_cfg_iomem, NULL, &omap_pin_cfg_ops, mpu,
+    memory_region_init_io(&mpu->pin_cfg_iomem, owner, &omap_pin_cfg_ops, mpu,
                           "omap-pin-cfg", 0x800);
     memory_region_add_subregion(system_memory, base, &mpu->pin_cfg_iomem);
     omap_pin_cfg_reset(mpu);
@@ -994,15 +994,16 @@ static const MemoryRegionOps omap_id_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void omap_id_init(MemoryRegion *memory, struct omap_mpu_state_s *mpu)
+static void omap_id_init(Object *owner, MemoryRegion *memory,
+                         struct omap_mpu_state_s *mpu)
 {
-    memory_region_init_io(&mpu->id_iomem, NULL, &omap_id_ops, mpu,
+    memory_region_init_io(&mpu->id_iomem, owner, &omap_id_ops, mpu,
                           "omap-id", 0x100000000ULL);
-    memory_region_init_alias(&mpu->id_iomem_e18, NULL, "omap-id-e18", &mpu->id_iomem,
-                             0xfffe1800, 0x800);
+    memory_region_init_alias(&mpu->id_iomem_e18, owner, "omap-id-e18",
+                             &mpu->id_iomem, 0xfffe1800, 0x800);
     memory_region_add_subregion(memory, 0xfffe1800, &mpu->id_iomem_e18);
-    memory_region_init_alias(&mpu->id_iomem_ed4, NULL, "omap-id-ed4", &mpu->id_iomem,
-                             0xfffed400, 0x100);
+    memory_region_init_alias(&mpu->id_iomem_ed4, owner, "omap-id-ed4",
+                             &mpu->id_iomem, 0xfffed400, 0x100);
     memory_region_add_subregion(memory, 0xfffed400, &mpu->id_iomem_ed4);
 }
 
@@ -1086,10 +1087,10 @@ static void omap_mpui_reset(struct omap_mpu_state_s *s)
     s->mpui_ctrl = 0x0003ff1b;
 }
 
-static void omap_mpui_init(MemoryRegion *memory, hwaddr base,
+static void omap_mpui_init(Object *owner, MemoryRegion *memory, hwaddr base,
                 struct omap_mpu_state_s *mpu)
 {
-    memory_region_init_io(&mpu->mpui_iomem, NULL, &omap_mpui_ops, mpu,
+    memory_region_init_io(&mpu->mpui_iomem, owner, &omap_mpui_ops, mpu,
                           "omap-mpui", 0x100);
     memory_region_add_subregion(memory, base, &mpu->mpui_iomem);
 
@@ -1195,7 +1196,7 @@ static void omap_tipb_bridge_reset(struct omap_tipb_bridge_s *s)
     s->enh_control = 0x000f;
 }
 
-static struct omap_tipb_bridge_s *omap_tipb_bridge_init(
+static struct omap_tipb_bridge_s *omap_tipb_bridge_init(Object *owner,
     MemoryRegion *memory, hwaddr base,
     qemu_irq abort_irq, omap_clk clk)
 {
@@ -1204,7 +1205,7 @@ static struct omap_tipb_bridge_s *omap_tipb_bridge_init(
     s->abort = abort_irq;
     omap_tipb_bridge_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_tipb_bridge_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_tipb_bridge_ops, s,
                           "omap-tipb-bridge", 0x100);
     memory_region_add_subregion(memory, base, &s->iomem);
 
@@ -1314,10 +1315,10 @@ static void omap_tcmi_reset(struct omap_mpu_state_s *mpu)
     mpu->tcmi_regs[0x40 >> 2] = 0x00000000;
 }
 
-static void omap_tcmi_init(MemoryRegion *memory, hwaddr base,
+static void omap_tcmi_init(Object *owner, MemoryRegion *memory, hwaddr base,
                 struct omap_mpu_state_s *mpu)
 {
-    memory_region_init_io(&mpu->tcmi_iomem, NULL, &omap_tcmi_ops, mpu,
+    memory_region_init_io(&mpu->tcmi_iomem, owner, &omap_tcmi_ops, mpu,
                           "omap-tcmi", 0x100);
     memory_region_add_subregion(memory, base, &mpu->tcmi_iomem);
     omap_tcmi_reset(mpu);
@@ -1399,11 +1400,12 @@ static void omap_dpll_reset(struct dpll_ctl_s *s)
     omap_clk_setrate(s->dpll, 1, 1);
 }
 
-static struct dpll_ctl_s  *omap_dpll_init(MemoryRegion *memory,
+static struct dpll_ctl_s  *omap_dpll_init(Object *owner, MemoryRegion *memory,
                            hwaddr base, omap_clk clk)
 {
     struct dpll_ctl_s *s = g_malloc0(sizeof(*s));
-    memory_region_init_io(&s->iomem, NULL, &omap_dpll_ops, s, "omap-dpll", 0x100);
+    memory_region_init_io(&s->iomem, owner, &omap_dpll_ops, s,
+                          "omap-dpll", 0x100);
 
     s->dpll = clk;
     omap_dpll_reset(s);
@@ -1822,12 +1824,13 @@ static void omap_clkm_reset(struct omap_mpu_state_s *s)
     s->clkm.dsp_rstct2 = 0x0000;
 }
 
-static void omap_clkm_init(MemoryRegion *memory, hwaddr mpu_base,
-                hwaddr dsp_base, struct omap_mpu_state_s *s)
+static void omap_clkm_init(Object *owner, MemoryRegion *memory,
+                hwaddr mpu_base, hwaddr dsp_base,
+                struct omap_mpu_state_s *s)
 {
-    memory_region_init_io(&s->clkm_iomem, NULL, &omap_clkm_ops, s,
+    memory_region_init_io(&s->clkm_iomem, owner, &omap_clkm_ops, s,
                           "omap-clkm", 0x100);
-    memory_region_init_io(&s->clkdsp_iomem, NULL, &omap_clkdsp_ops, s,
+    memory_region_init_io(&s->clkdsp_iomem, owner, &omap_clkdsp_ops, s,
                           "omap-clkdsp", 0x1000);
 
     s->clkm.arm_idlect1 = 0x03ff;
@@ -2071,8 +2074,8 @@ static void omap_mpuio_onoff(void *opaque, int line, int on)
         omap_mpuio_kbd_update(s);
 }
 
-static struct omap_mpuio_s *omap_mpuio_init(MemoryRegion *memory,
-                hwaddr base,
+static struct omap_mpuio_s *omap_mpuio_init(Object *owner,
+                MemoryRegion *memory, hwaddr base,
                 qemu_irq kbd_int, qemu_irq gpio_int,
                 omap_clk clk)
 {
@@ -2083,7 +2086,7 @@ static struct omap_mpuio_s *omap_mpuio_init(MemoryRegion *memory,
     s->in = qemu_allocate_irqs(omap_mpuio_set, s, 16);
     omap_mpuio_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_mpuio_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_mpuio_ops, s,
                           "omap-mpuio", 0x800);
     memory_region_add_subregion(memory, base, &s->iomem);
 
@@ -2236,7 +2239,8 @@ static void omap_uwire_reset(struct omap_uwire_s *s)
     s->setup[4] = 0;
 }
 
-static struct omap_uwire_s *omap_uwire_init(MemoryRegion *system_memory,
+static struct omap_uwire_s *omap_uwire_init(Object *owner,
+                                            MemoryRegion *system_memory,
                                             hwaddr base,
                                             qemu_irq txirq, qemu_irq rxirq,
                                             qemu_irq dma,
@@ -2249,7 +2253,8 @@ static struct omap_uwire_s *omap_uwire_init(MemoryRegion *system_memory,
     s->txdrq = dma;
     omap_uwire_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_uwire_ops, s, "omap-uwire", 0x800);
+    memory_region_init_io(&s->iomem, owner, &omap_uwire_ops, s,
+                          "omap-uwire", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
     return s;
@@ -2345,7 +2350,8 @@ static void omap_pwl_clk_update(void *opaque, int line, int on)
     omap_pwl_update(s);
 }
 
-static struct omap_pwl_s *omap_pwl_init(MemoryRegion *system_memory,
+static struct omap_pwl_s *omap_pwl_init(Object *owner,
+                                        MemoryRegion *system_memory,
                                         hwaddr base,
                                         omap_clk clk)
 {
@@ -2353,7 +2359,7 @@ static struct omap_pwl_s *omap_pwl_init(MemoryRegion *system_memory,
 
     omap_pwl_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_pwl_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_pwl_ops, s,
                           "omap-pwl", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
@@ -2456,7 +2462,8 @@ static void omap_pwt_reset(struct omap_pwt_s *s)
     s->gcr = 0;
 }
 
-static struct omap_pwt_s *omap_pwt_init(MemoryRegion *system_memory,
+static struct omap_pwt_s *omap_pwt_init(Object *owner,
+                                        MemoryRegion *system_memory,
                                         hwaddr base,
                                         omap_clk clk)
 {
@@ -2464,7 +2471,7 @@ static struct omap_pwt_s *omap_pwt_init(MemoryRegion *system_memory,
     s->clk = clk;
     omap_pwt_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_pwt_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_pwt_ops, s,
                           "omap-pwt", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
     return s;
@@ -2822,7 +2829,8 @@ static void omap_rtc_reset(struct omap_rtc_s *s)
     omap_rtc_tick(s);
 }
 
-static struct omap_rtc_s *omap_rtc_init(MemoryRegion *system_memory,
+static struct omap_rtc_s *omap_rtc_init(Object *owner,
+                                        MemoryRegion *system_memory,
                                         hwaddr base,
                                         qemu_irq timerirq, qemu_irq alarmirq,
                                         omap_clk clk)
@@ -2835,7 +2843,7 @@ static struct omap_rtc_s *omap_rtc_init(MemoryRegion *system_memory,
 
     omap_rtc_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_rtc_ops, s,
+    memory_region_init_io(&s->iomem, owner, &omap_rtc_ops, s,
                           "omap-rtc", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
@@ -3372,7 +3380,8 @@ static void omap_mcbsp_reset(struct omap_mcbsp_s *s)
     timer_del(s->sink_timer);
 }
 
-static struct omap_mcbsp_s *omap_mcbsp_init(MemoryRegion *system_memory,
+static struct omap_mcbsp_s *omap_mcbsp_init(Object *owner,
+                                            MemoryRegion *system_memory,
                                             hwaddr base,
                                             qemu_irq txirq, qemu_irq rxirq,
                                             qemu_irq *dma, omap_clk clk)
@@ -3387,7 +3396,8 @@ static struct omap_mcbsp_s *omap_mcbsp_init(MemoryRegion *system_memory,
     s->source_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, omap_mcbsp_source_tick, s);
     omap_mcbsp_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_mcbsp_ops, s, "omap-mcbsp", 0x800);
+    memory_region_init_io(&s->iomem, owner, &omap_mcbsp_ops, s,
+                          "omap-mcbsp", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
     return s;
@@ -3555,7 +3565,8 @@ static void omap_lpg_clk_update(void *opaque, int line, int on)
     omap_lpg_update(s);
 }
 
-static struct omap_lpg_s *omap_lpg_init(MemoryRegion *system_memory,
+static struct omap_lpg_s *omap_lpg_init(Object *owner,
+                                        MemoryRegion *system_memory,
                                         hwaddr base, omap_clk clk)
 {
     struct omap_lpg_s *s = g_new0(struct omap_lpg_s, 1);
@@ -3564,7 +3575,8 @@ static struct omap_lpg_s *omap_lpg_init(MemoryRegion *system_memory,
 
     omap_lpg_reset(s);
 
-    memory_region_init_io(&s->iomem, NULL, &omap_lpg_ops, s, "omap-lpg", 0x800);
+    memory_region_init_io(&s->iomem, owner, &omap_lpg_ops, s,
+                          "omap-lpg", 0x800);
     memory_region_add_subregion(system_memory, base, &s->iomem);
 
     omap_clk_adduser(clk, qemu_allocate_irq(omap_lpg_clk_update, s, 0));
@@ -3602,10 +3614,10 @@ static const MemoryRegionOps omap_mpui_io_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void omap_setup_mpui_io(MemoryRegion *system_memory,
+static void omap_setup_mpui_io(Object *owner, MemoryRegion *system_memory,
                                struct omap_mpu_state_s *mpu)
 {
-    memory_region_init_io(&mpu->mpui_io_iomem, NULL, &omap_mpui_io_ops, mpu,
+    memory_region_init_io(&mpu->mpui_io_iomem, owner, &omap_mpui_io_ops, mpu,
                           "omap-mpui-io", 0x7fff);
     memory_region_add_subregion(system_memory, OMAP_MPUI_BASE,
                                 &mpu->mpui_io_iomem);
@@ -3678,14 +3690,15 @@ static const struct omap_map_s {
     { 0 }
 };
 
-static void omap_setup_dsp_mapping(MemoryRegion *system_memory,
+static void omap_setup_dsp_mapping(Object *owner,
+                                   MemoryRegion *system_memory,
                                    const struct omap_map_s *map)
 {
     MemoryRegion *io;
 
     for (; map->phys_dsp; map ++) {
         io = g_new(MemoryRegion, 1);
-        memory_region_init_alias(io, NULL, map->name,
+        memory_region_init_alias(io, owner, map->name,
                                  system_memory, map->phys_mpu, map->size);
         memory_region_add_subregion(system_memory, map->phys_dsp, io);
     }
@@ -3757,11 +3770,11 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
     omap_clk_init(s);
 
     /* Memory-mapped stuff */
-    memory_region_init_ram(&s->imif_ram, NULL, "omap1.sram", s->sram_size,
+    memory_region_init_ram(&s->imif_ram, parent, "omap1.sram", s->sram_size,
                            &error_fatal);
     memory_region_add_subregion(system_memory, OMAP_IMIF_BASE, &s->imif_ram);
 
-    omap_clkm_init(system_memory, 0xfffece00, 0xe1008000, s);
+    omap_clkm_init(parent, system_memory, 0xfffece00, 0xe1008000, s);
 
     s->ih[0] = qdev_new(parent, "intc[0]", "omap-intc");
     qdev_prop_set_uint32(s->ih[0], "size", 0x100);
@@ -3804,21 +3817,21 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
     soc_dma_port_add_mem(s->dma, memory_region_get_ram_ptr(&s->imif_ram),
                          OMAP_IMIF_BASE, s->sram_size);
 
-    s->timer[0] = omap_mpu_timer_init(system_memory, 0xfffec500,
+    s->timer[0] = omap_mpu_timer_init(parent, system_memory, 0xfffec500,
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_TIMER1),
                     omap_findclk(s, "mputim_ck"));
-    s->timer[1] = omap_mpu_timer_init(system_memory, 0xfffec600,
+    s->timer[1] = omap_mpu_timer_init(parent, system_memory, 0xfffec600,
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_TIMER2),
                     omap_findclk(s, "mputim_ck"));
-    s->timer[2] = omap_mpu_timer_init(system_memory, 0xfffec700,
+    s->timer[2] = omap_mpu_timer_init(parent, system_memory, 0xfffec700,
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_TIMER3),
                     omap_findclk(s, "mputim_ck"));
 
-    s->wdt = omap_wd_timer_init(system_memory, 0xfffec800,
+    s->wdt = omap_wd_timer_init(parent, system_memory, 0xfffec800,
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_WD_TIMER),
                     omap_findclk(s, "armwdt_ck"));
 
-    s->os_timer = omap_os_timer_init(system_memory, 0xfffb9000,
+    s->os_timer = omap_os_timer_init(parent, system_memory, 0xfffb9000,
                     qdev_get_gpio_in(s->ih[1], OMAP_INT_OS_TIMER),
                     omap_findclk(s, "clk32-kHz"));
 
@@ -3827,20 +3840,20 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                             omap_dma_get_lcdch(s->dma),
                             omap_findclk(s, "lcd_ck"));
 
-    omap_ulpd_pm_init(system_memory, 0xfffe0800, s);
-    omap_pin_cfg_init(system_memory, 0xfffe1000, s);
-    omap_id_init(system_memory, s);
+    omap_ulpd_pm_init(parent, system_memory, 0xfffe0800, s);
+    omap_pin_cfg_init(parent, system_memory, 0xfffe1000, s);
+    omap_id_init(parent, system_memory, s);
 
-    omap_mpui_init(system_memory, 0xfffec900, s);
+    omap_mpui_init(parent, system_memory, 0xfffec900, s);
 
-    s->private_tipb = omap_tipb_bridge_init(system_memory, 0xfffeca00,
+    s->private_tipb = omap_tipb_bridge_init(parent, system_memory, 0xfffeca00,
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_BRIDGE_PRIV),
                     omap_findclk(s, "tipb_ck"));
-    s->public_tipb = omap_tipb_bridge_init(system_memory, 0xfffed300,
+    s->public_tipb = omap_tipb_bridge_init(parent, system_memory, 0xfffed300,
                     qdev_get_gpio_in(s->ih[0], OMAP_INT_BRIDGE_PUB),
                     omap_findclk(s, "tipb_ck"));
 
-    omap_tcmi_init(system_memory, 0xfffecc00, s);
+    omap_tcmi_init(parent, system_memory, 0xfffecc00, s);
 
     s->uart[0] = omap_uart_init(parent, 0xfffb0000,
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_UART1),
@@ -3864,11 +3877,11 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                     "uart3",
                     serial_hd(0) && serial_hd(1) ? serial_hd(2) : NULL);
 
-    s->dpll[0] = omap_dpll_init(system_memory, 0xfffecf00,
+    s->dpll[0] = omap_dpll_init(parent, system_memory, 0xfffecf00,
                                 omap_findclk(s, "dpll1"));
-    s->dpll[1] = omap_dpll_init(system_memory, 0xfffed000,
+    s->dpll[1] = omap_dpll_init(parent, system_memory, 0xfffed000,
                                 omap_findclk(s, "dpll2"));
-    s->dpll[2] = omap_dpll_init(system_memory, 0xfffed100,
+    s->dpll[2] = omap_dpll_init(parent, system_memory, 0xfffed100,
                                 omap_findclk(s, "dpll3"));
 
     dinfo = drive_get(IF_SD, 0, 0);
@@ -3895,7 +3908,7 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                      &error_fatal);
     }
 
-    s->mpuio = omap_mpuio_init(system_memory, 0xfffb5000,
+    s->mpuio = omap_mpuio_init(parent, system_memory, 0xfffb5000,
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_KEYBOARD),
                                qdev_get_gpio_in(s->ih[1], OMAP_INT_MPUIO),
                                omap_findclk(s, "clk32-kHz"));
@@ -3907,14 +3920,14 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
                        qdev_get_gpio_in(s->ih[0], OMAP_INT_GPIO_BANK1));
     sysbus_mmio_map(SYS_BUS_DEVICE(s->gpio), 0, 0xfffce000);
 
-    s->microwire = omap_uwire_init(system_memory, 0xfffb3000,
+    s->microwire = omap_uwire_init(parent, system_memory, 0xfffb3000,
                                    qdev_get_gpio_in(s->ih[1], OMAP_INT_uWireTX),
                                    qdev_get_gpio_in(s->ih[1], OMAP_INT_uWireRX),
                     s->drq[OMAP_DMA_UWIRE_TX], omap_findclk(s, "mpuper_ck"));
 
-    s->pwl = omap_pwl_init(system_memory, 0xfffb5800,
+    s->pwl = omap_pwl_init(parent, system_memory, 0xfffb5800,
                            omap_findclk(s, "armxor_ck"));
-    s->pwt = omap_pwt_init(system_memory, 0xfffb6000,
+    s->pwt = omap_pwt_init(parent, system_memory, 0xfffb6000,
                            omap_findclk(s, "armxor_ck"));
 
     s->i2c[0] = qdev_new(parent, "i2c", "omap_i2c");
@@ -3927,29 +3940,29 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
     sysbus_connect_irq(busdev, 2, s->drq[OMAP_DMA_I2C_RX]);
     sysbus_mmio_map(busdev, 0, 0xfffb3800);
 
-    s->rtc = omap_rtc_init(system_memory, 0xfffb4800,
+    s->rtc = omap_rtc_init(parent, system_memory, 0xfffb4800,
                            qdev_get_gpio_in(s->ih[1], OMAP_INT_RTC_TIMER),
                            qdev_get_gpio_in(s->ih[1], OMAP_INT_RTC_ALARM),
                     omap_findclk(s, "clk32-kHz"));
 
-    s->mcbsp1 = omap_mcbsp_init(system_memory, 0xfffb1800,
+    s->mcbsp1 = omap_mcbsp_init(parent, system_memory, 0xfffb1800,
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_McBSP1TX),
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_McBSP1RX),
                     &s->drq[OMAP_DMA_MCBSP1_TX], omap_findclk(s, "dspxor_ck"));
-    s->mcbsp2 = omap_mcbsp_init(system_memory, 0xfffb1000,
+    s->mcbsp2 = omap_mcbsp_init(parent, system_memory, 0xfffb1000,
                                 qdev_get_gpio_in(s->ih[0],
                                                  OMAP_INT_310_McBSP2_TX),
                                 qdev_get_gpio_in(s->ih[0],
                                                  OMAP_INT_310_McBSP2_RX),
                     &s->drq[OMAP_DMA_MCBSP2_TX], omap_findclk(s, "mpuper_ck"));
-    s->mcbsp3 = omap_mcbsp_init(system_memory, 0xfffb7000,
+    s->mcbsp3 = omap_mcbsp_init(parent, system_memory, 0xfffb7000,
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_McBSP3TX),
                                 qdev_get_gpio_in(s->ih[1], OMAP_INT_McBSP3RX),
                     &s->drq[OMAP_DMA_MCBSP3_TX], omap_findclk(s, "dspxor_ck"));
 
-    s->led[0] = omap_lpg_init(system_memory,
+    s->led[0] = omap_lpg_init(parent, system_memory,
                               0xfffbd000, omap_findclk(s, "clk32-kHz"));
-    s->led[1] = omap_lpg_init(system_memory,
+    s->led[1] = omap_lpg_init(parent, system_memory,
                               0xfffbd800, omap_findclk(s, "clk32-kHz"));
 
     /* Register mappings not currently implemented:
@@ -3967,8 +3980,8 @@ struct omap_mpu_state_s *omap310_mpu_init(Object *parent, MemoryRegion *dram,
      * DSP MMU          fffed200 - fffed2ff
      */
 
-    omap_setup_dsp_mapping(system_memory, omap15xx_dsp_mm);
-    omap_setup_mpui_io(system_memory, s);
+    omap_setup_dsp_mapping(parent, system_memory, omap15xx_dsp_mm);
+    omap_setup_mpui_io(parent, system_memory, s);
 
     qemu_register_reset(omap1_mpu_reset, s);
 
-- 
2.47.1


