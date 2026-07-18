Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E44FC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDBG-00039n-6d; Sat, 18 Jul 2026 18:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDBE-0002u9-7Y; Sat, 18 Jul 2026 18:06:44 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDBC-0006GZ-CC; Sat, 18 Jul 2026 18:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412402; x=1815948402;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v7Gg0RTMoE3PHga7JOaBPxL+IE5NtvtLRm4f+QKNUWQ=;
 b=r5i3S6bEnvjlMfZQcQGi3B0VqdbUZzN3+FTBBMO5Pp9VZSoam9/kkYHc
 8hFYboHcIeA+4NHdSxMWb22AWggSc/vm1lTESaIK8+fh7baKuKCMPt2Ne
 il2uhARFPgOOGL+ANtJ4MdfG61J23rfLG2/CBqKGVeo9XTIDnoUB3YPm+
 2M6y+/0wYIS7fUPc48KrDXEZ72HoAHYAknMSC8ekmax/XXtn1HBEqdlrB
 PcSY5zSvtmsxX8sGujqOu4zbV51q/6vwt2nMReFi/M9NMRB0Y9UEQBNiY
 OSxDwJQrF/N71C10oeFL+Y1Jve7RK9Ag8s4T+1rv0IjsZus5q5vpodeXU Q==;
X-CSE-ConnectionGUID: U19EcyNiR4qGvGPOvW+lDA==
X-CSE-MsgGUID: kST7DPDuTcyFgqZbsj8dig==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23942435"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:06:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:20403]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.199:2525]
 with esmtp (Farcaster)
 id b648b38f-d09c-483b-bbcb-871a0b98d8b5; Sat, 18 Jul 2026 22:06:38 +0000 (UTC)
X-Farcaster-Flow-ID: b648b38f-d09c-483b-bbcb-871a0b98d8b5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:06:38 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:06:28 +0000
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
Subject: [RFC PATCH v2 106/137] system,
 backends: Give named memory regions an explicit owner
Date: Sat, 18 Jul 2026 21:36:21 +0000
Message-ID: <20260718213652.37673-107-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
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

memory_map_init() creates the "system" and "io" root memory regions
after qemu_create_machine() has instantiated current_machine, so
qdev_get_machine() is available as owner.

The IGVM backend creates guest-memory regions on behalf of the
confidential-guest machine it carries in ctx->machine_state; use
that as owner.

subpage_init() and io_mem_init() pass name==NULL and thus never
QOM-parent their MemoryRegion; leave owner NULL there.

No functional change intended.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 backends/igvm.c  | 6 ++++--
 system/physmem.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 80e87fe602..544a51b70e 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -256,13 +256,15 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
         igvm_pages = g_new0(MemoryRegion, 1);
         if (ctx->machine_state->cgs &&
             ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
+            if (!memory_region_init_ram_guest_memfd(igvm_pages,
+                                                     OBJECT(ctx->machine_state),
                                                     region_name, size, errp)) {
                 g_free(igvm_pages);
                 return NULL;
             }
         } else {
-            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
+            if (!memory_region_init_ram(igvm_pages, OBJECT(ctx->machine_state),
+                                        region_name, size,
                                         errp)) {
                 g_free(igvm_pages);
                 return NULL;
diff --git a/system/physmem.c b/system/physmem.c
index c21ea92915..8466885994 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3100,11 +3100,11 @@ static void memory_map_init(void)
 {
     system_memory = g_malloc(sizeof(*system_memory));
 
-    memory_region_init(system_memory, NULL, "system", UINT64_MAX);
+    memory_region_init(system_memory, qdev_get_machine(), "system", UINT64_MAX);
     address_space_init(&address_space_memory, system_memory, "memory");
 
     system_io = g_malloc(sizeof(*system_io));
-    memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
+    memory_region_init_io(system_io, qdev_get_machine(), &unassigned_io_ops, NULL, "io",
                           65536);
     address_space_init(&address_space_io, system_io, "I/O");
 }
-- 
2.47.1


