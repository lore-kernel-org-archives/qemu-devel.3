Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6300DC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiglk-0002wR-0Q; Sat, 11 Jul 2026 19:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiglj-0002vr-B1; Sat, 11 Jul 2026 19:05:59 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wiglh-0003NC-7X; Sat, 11 Jul 2026 19:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811157; x=1815347157;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=muI5dEyqzqqFCvV0Mx5cUYEs7ERUUjkM8aKOhV7cnrg=;
 b=f1q8u0uuGw4618t9Ds5Czo8dt3CkzCFwjIf80jhwXpdUho3v5jm1uR+j
 DeEIdJ/iVUOCufCe4rR8i79gD79BBYyhZLH2EoBffZbAKeoCt/DMPaUNi
 9rPWk3yOWoXAmxtf3qAmbXSuaJS820baVepZFs8KJf5NurU4ze7M5NwYK
 xhYLjKkbZJaWO+XAgb6R4pOppooeukjCrxwZKcJnxlccR1PuknWd4ApcG
 GnXhStS4jhXThBNHhbSMzgiL7PZkTCEw4N6ElDre64aEkzGPB4KwAYwZg
 VS1LsEcZ5EtvIHylxZsw9U3IxZxUoU3TvkDm/vjI+q6OQKNJCOGTcqz9N Q==;
X-CSE-ConnectionGUID: go8APNENSYez8fwgs7DenQ==
X-CSE-MsgGUID: jipw6+yHRXmyGo9aww1U7Q==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23483656"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:05:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:27500]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id 09b0fb71-566c-4cff-a2f0-04d9be53f3bd; Sat, 11 Jul 2026 23:05:53 +0000 (UTC)
X-Farcaster-Flow-ID: 09b0fb71-566c-4cff-a2f0-04d9be53f3bd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:52 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:44 +0000
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
Subject: [RFC PATCH 109/134] irq: Reintroduce qemu_allocate_irq*() with a
 mandatory owner and name
Date: Sat, 11 Jul 2026 22:36:42 +0000
Message-ID: <20260711223707.42139-110-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Add parented variants of the IRQ allocation helpers under the
well-known names, taking (Object *owner, const char *name, ...) as
their first two arguments:

  qemu_allocate_irq(owner, name, handler, opaque, n)
  qemu_allocate_irqs(owner, name, handler, opaque, n)
  qemu_extend_irqs(owner, name, old, n_old, handler, opaque, n)
  qemu_irq_invert(owner, name, irq)

The new IRQ object is created via object_new_child() so it lands
under @owner with a stable path.  The array/extend variants suffix
"[*]" so callers pass a bare name and get name[0], name[1], ...

qemu_free_irq() is taught to unparent when the IRQ has a QOM parent,
so it works for both the *_orphan() and the parented allocation
paths during the transition.

The *_orphan() variants stay for now; later commits convert every
caller and delete them, at which point the /machine/unattached
fallback in qdev_connect_gpio_out_named() also goes away.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/irq.c         | 45 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/core/irq.h | 15 +++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index f8fdeb7e02..ee954eaf62 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -96,6 +96,38 @@ qemu_irq qemu_allocate_irq_orphan(qemu_irq_handler handler, void *opaque, int n)
     return irq;
 }
 
+qemu_irq qemu_allocate_irq(Object *owner, const char *name,
+                           qemu_irq_handler handler, void *opaque, int n)
+{
+    IRQState *irq = IRQ(object_new_child(owner, name, TYPE_IRQ));
+    init_irq_fields(irq, handler, opaque, n);
+    return irq;
+}
+
+qemu_irq *qemu_extend_irqs(Object *owner, const char *name,
+                           qemu_irq *old, int n_old,
+                           qemu_irq_handler handler, void *opaque, int n)
+{
+    g_autofree char *propname = g_strdup_printf("%s[*]", name);
+    qemu_irq *s;
+    int i;
+
+    if (!old) {
+        n_old = 0;
+    }
+    s = old ? g_renew(qemu_irq, old, n + n_old) : g_new(qemu_irq, n);
+    for (i = n_old; i < n + n_old; i++) {
+        s[i] = qemu_allocate_irq(owner, propname, handler, opaque, i);
+    }
+    return s;
+}
+
+qemu_irq *qemu_allocate_irqs(Object *owner, const char *name,
+                             qemu_irq_handler handler, void *opaque, int n)
+{
+    return qemu_extend_irqs(owner, name, NULL, 0, handler, opaque, n);
+}
+
 void qemu_free_irqs(qemu_irq *s, int n)
 {
     int i;
@@ -107,7 +139,11 @@ void qemu_free_irqs(qemu_irq *s, int n)
 
 void qemu_free_irq(qemu_irq irq)
 {
-    object_unref(OBJECT(irq));
+    if (irq && OBJECT(irq)->parent) {
+        object_unparent(OBJECT(irq));
+    } else {
+        object_unref(OBJECT(irq));
+    }
 }
 
 static void qemu_notirq(void *opaque, int line, int level)
@@ -124,6 +160,13 @@ qemu_irq qemu_irq_invert_orphan(qemu_irq irq)
     return qemu_allocate_irq_orphan(qemu_notirq, irq, 0);
 }
 
+qemu_irq qemu_irq_invert(Object *owner, const char *name, qemu_irq irq)
+{
+    /* The default state for IRQs is low, so raise the output now.  */
+    qemu_irq_raise(irq);
+    return qemu_allocate_irq(owner, name, qemu_notirq, irq, 0);
+}
+
 void qemu_irq_set_observer(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
 {
     int i;
diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
index f984c02c14..5ccccd2697 100644
--- a/include/hw/core/irq.h
+++ b/include/hw/core/irq.h
@@ -85,6 +85,20 @@ qemu_irq *qemu_allocate_irqs_orphan(qemu_irq_handler handler, void *opaque, int
  */
 qemu_irq qemu_allocate_irq_orphan(qemu_irq_handler handler, void *opaque, int n);
 
+/*
+ * Same as the *_orphan() variants above, but the new IRQ objects are
+ * parented under @owner with property name @name (or @name[*] for the
+ * array/extend variants).  The reference is held by @owner; call
+ * qemu_free_irq() to unparent and free.
+ */
+qemu_irq qemu_allocate_irq(Object *owner, const char *name,
+                           qemu_irq_handler handler, void *opaque, int n);
+qemu_irq *qemu_allocate_irqs(Object *owner, const char *name,
+                             qemu_irq_handler handler, void *opaque, int n);
+qemu_irq *qemu_extend_irqs(Object *owner, const char *name,
+                           qemu_irq *old, int n_old,
+                           qemu_irq_handler handler, void *opaque, int n);
+
 /* Extends an Array of IRQs. Old IRQs have their handlers and opaque data
  * preserved. New IRQs are assigned the argument handler and opaque data.
  */
@@ -96,6 +110,7 @@ void qemu_free_irq(qemu_irq irq);
 
 /* Returns a new IRQ with opposite polarity.  */
 qemu_irq qemu_irq_invert_orphan(qemu_irq irq);
+qemu_irq qemu_irq_invert(Object *owner, const char *name, qemu_irq irq);
 
 /* For internal use in qtest. */
 void qemu_irq_set_observer(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
-- 
2.47.1


