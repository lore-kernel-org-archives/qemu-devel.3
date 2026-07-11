Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024D4C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigmd-0004zc-Ow; Sat, 11 Jul 2026 19:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigmc-0004uF-55; Sat, 11 Jul 2026 19:06:54 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigma-0003fy-77; Sat, 11 Jul 2026 19:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811212; x=1815347212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w/aD5NYnau+ZnTk1eR1BTVjPeFMEELMMhtgZGkb5Ouw=;
 b=RMe1bLab3OKPoeFgDc+HVPQYcV/VP14uV8BXzTWpRsmT/LrVkyMt1/6N
 IkO+tacN3KLKuqN8OjueYv/KRJ5+Jh7Ft0srHPWOBF874aFHzirnyNSyi
 83ZsVQtrZsOpJ3nOrN3dZVhRA65SJUrmwYnp3rpfsdr9oXk2I+vJvS4DQ
 B/4w6MIg1KgUj7b1Wl7zjXwMYpK6gMlAo6e7jbRnHXpQ9uMvTEjFJ3AAJ
 dcwx2pPtUXxPrsFQxT/h7dK0PdSFNhDo4+IPSOK54y0a6xOVwlXhlUFqI
 2ZolBpiWkwYjpA0MC+07gkh18GKaTkjzYWWd3TQtQ1x7fS23n6sy7DF8u g==;
X-CSE-ConnectionGUID: AVox5K2eSWySgUbgACtvMg==
X-CSE-MsgGUID: UZWzl86rQBa180H3fG962A==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23296948"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:06:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:21852]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id b5137696-ae70-469a-9448-dc736f7daa37; Sat, 11 Jul 2026 23:06:48 +0000 (UTC)
X-Farcaster-Flow-ID: b5137696-ae70-469a-9448-dc736f7daa37
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:06:48 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:06:39 +0000
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
Subject: [RFC PATCH 113/134] hw/xtensa: Give allocated IRQs an owner and name
Date: Sat, 11 Jul 2026 22:36:46 +0000
Message-ID: <20260711223707.42139-114-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=34.218.115.239;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Thread an Object *owner through xtensa_mx_pic_init() and use the CPU
object as owner for the per-CPU IRQ input arrays.

Assisted-by: Kiro
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


