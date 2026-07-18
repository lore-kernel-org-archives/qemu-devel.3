Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564E9C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDCE-0006R5-I1; Sat, 18 Jul 2026 18:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDCC-0006PV-Vx; Sat, 18 Jul 2026 18:07:45 -0400
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.162.73.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDCB-0006L3-1S; Sat, 18 Jul 2026 18:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412463; x=1815948463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oOcpxY9uuHLwNP84nyMpDB+plpJZzHNJBk6PAKAsl+w=;
 b=mCFKoPWmXWzukKmhqeIY74sDgn+5wuFa56y5jwJbI5y5NErB2ChUWopy
 APDirtI69ApiDvbU9qorB4gSOpaueRMJpMrogb59JfWeagKDp1H+0zgPy
 /3CBteljC3XEkcF5+RerQjF4tD5/wNVKrfEAvROiYIeOV3bkYw/H6FCS7
 fY70vTMypMU7QjO3k2QrYNU51g5cucvRO0gvT8tUSpgr7JzlqAXTwcx3s
 /j8QVUT+tkoUiEvCZeWr5HQDRoVgWHjMK5pUc2ypcjuN7A88h52qlazCA
 /rtoX1O8l/DsQPtEkxo9OMfnreMYcWlOt2oeb8asJdICjy5ZJqlun/RP1 w==;
X-CSE-ConnectionGUID: WVnxyI9ITX6rJv6JAkODKA==
X-CSE-MsgGUID: 29CmgQC5Qv6CdbPfzLqZFA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23716616"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:07:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:1129]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.151:2525]
 with esmtp (Farcaster)
 id d03d448b-dc04-4473-a688-b37d328c93c7; Sat, 18 Jul 2026 22:07:38 +0000 (UTC)
X-Farcaster-Flow-ID: d03d448b-dc04-4473-a688-b37d328c93c7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:07:38 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:07:28 +0000
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
Subject: [RFC PATCH v2 110/137] irq: Reintroduce qemu_allocate_irq*() with a
 mandatory owner and name
Date: Sat, 18 Jul 2026 21:36:25 +0000
Message-ID: <20260718213652.37673-111-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.162.73.231;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/irq.c         | 45 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/core/irq.h | 15 +++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index f8fdeb7e02..1ae53a74d3 100644
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
+    qemu_irq *s;
+    int i;
+
+    if (!old) {
+        n_old = 0;
+    }
+    s = old ? g_renew(qemu_irq, old, n + n_old) : g_new(qemu_irq, n);
+    for (i = n_old; i < n + n_old; i++) {
+        g_autofree char *propname = g_strdup_printf("%s[%d]", name, i);
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


