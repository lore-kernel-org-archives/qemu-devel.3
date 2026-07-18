Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC01C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDEL-0001ix-RO; Sat, 18 Jul 2026 18:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDEK-0001fJ-14; Sat, 18 Jul 2026 18:09:56 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDEI-0006Vv-8A; Sat, 18 Jul 2026 18:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412594; x=1815948594;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FY183wjjQlqz+5usHhcMwB4KgwWExApPxxwqiZT033s=;
 b=WsHX3QHCkKpWNTPsPP9Z710qBHXv0NofGWZOA2yPuNTU7axS7MpaPtN2
 AZ/7hXPt9mQMRgDkPkpQeYJj/DDBAaqa8tviCdGpqUiHd2F3JOiRm65qA
 9fxrypc2OiFu+BxfuDfGuVd9n/WbOSrEBNgaOeAbB0KsjMqZ98tEytu8U
 mecTIxauPG9/hbCyX4osImWlN1SlJlbdkVIPl85j+G8PckensXnSW/etp
 Kq/Ggvso096CySe9q4XulO9oE3s5X+AWpzGs9M1Po6DD36uFCr9vcuQfL
 oGE5TnkjZG2lwS61bYXY+FMvElX2QrK0zYlcJGa74fNfq7hw35CYBazEl Q==;
X-CSE-ConnectionGUID: G1M1ZeVnS/ueV290kyp2SQ==
X-CSE-MsgGUID: +Zv4XqJ2TJO48HlGI7jmTQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23945061"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:09:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:4642]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.115:2525]
 with esmtp (Farcaster)
 id f6c48346-945f-4e21-bf60-dc11b11f4cc5; Sat, 18 Jul 2026 22:09:50 +0000 (UTC)
X-Farcaster-Flow-ID: f6c48346-945f-4e21-bf60-dc11b11f4cc5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:09:50 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:09:40 +0000
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
Subject: [RFC PATCH v2 117/137] irq: Delete the *_orphan() IRQ allocation
 variants
Date: Sat, 18 Jul 2026 21:36:32 +0000
Message-ID: <20260718213652.37673-118-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
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

Every caller has been converted to the parented form; drop the
transitional *_orphan() helpers.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/irq.c         | 35 -----------------------------------
 include/hw/core/irq.h | 20 +-------------------
 2 files changed, 1 insertion(+), 54 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index 1ae53a74d3..459ff467ff 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -68,34 +68,6 @@ void qemu_init_irqs(IRQState irq[], size_t count,
     }
 }
 
-qemu_irq *qemu_extend_irqs_orphan(qemu_irq *old, int n_old, qemu_irq_handler handler,
-                           void *opaque, int n)
-{
-    qemu_irq *s;
-    int i;
-
-    if (!old) {
-        n_old = 0;
-    }
-    s = old ? g_renew(qemu_irq, old, n + n_old) : g_new(qemu_irq, n);
-    for (i = n_old; i < n + n_old; i++) {
-        s[i] = qemu_allocate_irq_orphan(handler, opaque, i);
-    }
-    return s;
-}
-
-qemu_irq *qemu_allocate_irqs_orphan(qemu_irq_handler handler, void *opaque, int n)
-{
-    return qemu_extend_irqs_orphan(NULL, 0, handler, opaque, n);
-}
-
-qemu_irq qemu_allocate_irq_orphan(qemu_irq_handler handler, void *opaque, int n)
-{
-    IRQState *irq = IRQ(object_new(TYPE_IRQ));
-    init_irq_fields(irq, handler, opaque, n);
-    return irq;
-}
-
 qemu_irq qemu_allocate_irq(Object *owner, const char *name,
                            qemu_irq_handler handler, void *opaque, int n)
 {
@@ -153,13 +125,6 @@ static void qemu_notirq(void *opaque, int line, int level)
     qemu_set_irq(irq, !level);
 }
 
-qemu_irq qemu_irq_invert_orphan(qemu_irq irq)
-{
-    /* The default state for IRQs is low, so raise the output now.  */
-    qemu_irq_raise(irq);
-    return qemu_allocate_irq_orphan(qemu_notirq, irq, 0);
-}
-
 qemu_irq qemu_irq_invert(Object *owner, const char *name, qemu_irq irq)
 {
     /* The default state for IRQs is low, so raise the output now.  */
diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
index 5ccccd2697..89923cf4a8 100644
--- a/include/hw/core/irq.h
+++ b/include/hw/core/irq.h
@@ -74,19 +74,8 @@ void qemu_init_irq_child(Object *parent, const char *propname,
 void qemu_init_irqs(IRQState irq[], size_t count,
                     qemu_irq_handler handler, void *opaque);
 
-/* Returns an array of N IRQs. Each IRQ is assigned the argument handler and
- * opaque data.
- */
-qemu_irq *qemu_allocate_irqs_orphan(qemu_irq_handler handler, void *opaque, int n);
-
 /*
- * Allocates a single IRQ. The irq is assigned with a handler, an opaque
- * data and the interrupt number.
- */
-qemu_irq qemu_allocate_irq_orphan(qemu_irq_handler handler, void *opaque, int n);
-
-/*
- * Same as the *_orphan() variants above, but the new IRQ objects are
+ * Allocate IRQ objects with an explicit QOM parent.  The new objects are
  * parented under @owner with property name @name (or @name[*] for the
  * array/extend variants).  The reference is held by @owner; call
  * qemu_free_irq() to unparent and free.
@@ -99,17 +88,10 @@ qemu_irq *qemu_extend_irqs(Object *owner, const char *name,
                            qemu_irq *old, int n_old,
                            qemu_irq_handler handler, void *opaque, int n);
 
-/* Extends an Array of IRQs. Old IRQs have their handlers and opaque data
- * preserved. New IRQs are assigned the argument handler and opaque data.
- */
-qemu_irq *qemu_extend_irqs_orphan(qemu_irq *old, int n_old, qemu_irq_handler handler,
-                                void *opaque, int n);
-
 void qemu_free_irqs(qemu_irq *s, int n);
 void qemu_free_irq(qemu_irq irq);
 
 /* Returns a new IRQ with opposite polarity.  */
-qemu_irq qemu_irq_invert_orphan(qemu_irq irq);
 qemu_irq qemu_irq_invert(Object *owner, const char *name, qemu_irq irq);
 
 /* For internal use in qtest. */
-- 
2.47.1


