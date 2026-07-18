Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27D5C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDDf-0000nS-0h; Sat, 18 Jul 2026 18:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDDX-0000Xo-Nq; Sat, 18 Jul 2026 18:09:09 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDDU-0006Tb-Ik; Sat, 18 Jul 2026 18:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412544; x=1815948544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vGQVF4AvH4I1N7F/96ahCv1nChpT2tiIK+RKCxSA6+c=;
 b=SBSoTn39gWQcJQBboDdGucxngzJ60WpRlaREtjXIQLdbrH/rlYCceRY9
 TqRsrXySgk7l1KTshuu4V20j+7jndXEDUH4CeT3DUtugxMAS3IVoMm9M+
 HocrRe61ssRuK4+Lk6qPwdmEbM/XAJkIIUtHI3X16kHcW9fg/dIl7ZO4V
 UVnj1W4S5e2GBy8e7J1EhH+/V2l00Zl1k9kJCNVCc0SLovTEzGyT26vnW
 DsIPGyE3Gi2unIn6MAuIuZ9sW+0rbGbhVZNP+VX76zv7WUlKP1Lb9oy7G
 bE79pmjlCA1ja0d+DiVLS8cy+bI6yy2XH06I+HL2p4t775zVIyf/Yp7R2 g==;
X-CSE-ConnectionGUID: 6JgrcFRvRH6r9ZQ4XT1Cow==
X-CSE-MsgGUID: jIQMUlurTXWsZdSCbmlpXQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23927901"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:09:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:15443]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.199:2525]
 with esmtp (Farcaster)
 id f1dff26c-470d-4a34-8a2d-e50e8263b1de; Sat, 18 Jul 2026 22:09:00 +0000 (UTC)
X-Farcaster-Flow-ID: f1dff26c-470d-4a34-8a2d-e50e8263b1de
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:08:59 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:08:50 +0000
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
Subject: [RFC PATCH v2 114/137] hw/xtensa: Give allocated IRQs an owner and
 name
Date: Sat, 18 Jul 2026 21:36:29 +0000
Message-ID: <20260718213652.37673-115-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Thread an Object *owner through xtensa_mx_pic_init() and use the CPU
object as owner for the per-CPU IRQ input arrays.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/xtensa/mx_pic.c         | 4 ++--
 hw/xtensa/pic_cpu.c        | 5 +++--
 hw/xtensa/xtfpga.c         | 2 +-
 include/hw/xtensa/mx_pic.h | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 9959bec5f2..f698d592f0 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -341,12 +341,12 @@ static void xtensa_mx_pic_set_irq(void *opaque, int irq, int active)
     }
 }
 
-XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
+XtensaMxPic *xtensa_mx_pic_init(Object *owner, unsigned n_irq)
 {
     XtensaMxPic *mx = g_new0(XtensaMxPic, 1);
 
     mx->n_irq = n_irq + 1;
-    mx->irq_inputs = qemu_allocate_irqs_orphan(xtensa_mx_pic_set_irq, mx,
+    mx->irq_inputs = qemu_allocate_irqs(owner, "irq", xtensa_mx_pic_set_irq, mx,
                                         mx->n_irq);
     return mx;
 }
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index c3163a8b6c..496c83a298 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -100,9 +100,10 @@ static void xtensa_set_runstall(void *opaque, int irq, int active)
 
 void xtensa_irq_init(CPUXtensaState *env)
 {
+    Object *cpu = OBJECT(env_cpu(env));
     unsigned i;
 
-    env->irq_inputs = qemu_allocate_irqs_orphan(xtensa_set_irq, env,
+    env->irq_inputs = qemu_allocate_irqs(cpu, "irq-in", xtensa_set_irq, env,
                                          env->config->ninterrupt);
     if (xtensa_option_enabled(env->config, XTENSA_OPTION_TIMER_INTERRUPT)) {
         env->time_base = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
@@ -118,7 +119,7 @@ void xtensa_irq_init(CPUXtensaState *env)
 
         env->ext_irq_inputs[i] = env->irq_inputs[irq];
     }
-    env->runstall_irq = qemu_allocate_irq_orphan(xtensa_set_runstall, env, 0);
+    env->runstall_irq = qemu_allocate_irq(cpu, "runstall", xtensa_set_runstall, env, 0);
 }
 
 qemu_irq *xtensa_get_extints(CPUXtensaState *env)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index f0c21180a2..6ec0822a96 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -247,7 +247,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     Object *mo = OBJECT(machine);
 
     if (smp_cpus > 1) {
-        mx_pic = xtensa_mx_pic_init(31);
+        mx_pic = xtensa_mx_pic_init(mo, 31);
         qemu_register_reset(xtensa_mx_pic_reset, mx_pic);
     }
     for (n = 0; n < smp_cpus; n++) {
diff --git a/include/hw/xtensa/mx_pic.h b/include/hw/xtensa/mx_pic.h
index 01d5ea884e..212cf91e78 100644
--- a/include/hw/xtensa/mx_pic.h
+++ b/include/hw/xtensa/mx_pic.h
@@ -33,7 +33,7 @@
 struct XtensaMxPic;
 typedef struct XtensaMxPic XtensaMxPic;
 
-XtensaMxPic *xtensa_mx_pic_init(unsigned n_extint);
+XtensaMxPic *xtensa_mx_pic_init(Object *owner, unsigned n_extint);
 void xtensa_mx_pic_reset(void *opaque);
 MemoryRegion *xtensa_mx_pic_register_cpu(Object *owner, XtensaMxPic *mx,
                                          qemu_irq *irq,
-- 
2.47.1


