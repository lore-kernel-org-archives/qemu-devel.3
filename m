Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E00C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigoE-0007iD-C4; Sat, 11 Jul 2026 19:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigo8-0007SE-Cj; Sat, 11 Jul 2026 19:08:29 -0400
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.42.203.116])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigo6-00043Q-K9; Sat, 11 Jul 2026 19:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811306; x=1815347306;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z9jEjZXxPXlMJqbiHIRBDdPowd0FRoDuIoH9/d4zUSc=;
 b=XCuquQOiTrbrU5LLYEObM2TtvrgHqR7wuT5OAMYrJMablcFtBcxC5z4z
 A9Xzdlre1Ja7pmHL6mVLeXlRA1pMaANbv4tBgYwgbtVKNcULuievnUJ6r
 iNUQPZlTawzglsMCVSMGMEQ9bxARuu8RuXzirHyOLhdbRqqAmLjmm798L
 BsnUpdpHlhQpinLcOWIOOk6GgkHzr9YmmqHTJGDZp3zRBBZalwJs6O4AH
 hh22wj36qGnkTD3pLWuMkR+Zpr1uHvqa0EklozDznhqILsHF4afAq3/LE
 1woEXRF8If48s7wxHUT1tFY5GwywnJ7w07T8gxBfoVKygbF0GqytMv9DH A==;
X-CSE-ConnectionGUID: xEw6ybjpR9ScqvbkC6e2Bw==
X-CSE-MsgGUID: B1bQ1VuZQimt/IgX0fVpjg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23518195"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:08:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:8809]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id 04fffb0f-cf34-4624-a838-41849e58edce; Sat, 11 Jul 2026 23:08:22 +0000 (UTC)
X-Farcaster-Flow-ID: 04fffb0f-cf34-4624-a838-41849e58edce
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:08:22 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:08:13 +0000
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
Subject: [RFC PATCH 119/134] hw/core/reset: Give the root reset container and
 legacy shims a QOM path
Date: Sat, 11 Jul 2026 22:36:52 +0000
Message-ID: <20260711223707.42139-120-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.42.203.116;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

The root ResettableContainer and the LegacyReset shim objects are
long-lived singletons held only by static pointers and refcounts.
Give them a canonical path in the composition tree so
qom-tree/qom-list can enumerate them and so device_set_realized()
can require a QOM parent for every object.

  /machine/reset-container                (ResettableContainer)
  /machine/reset-container/legacy-reset[N] (LegacyReset shims)

get_root_reset_container() is first reached from configure_accelerators()
or machine_run_board_init(), both of which run after qemu_create_machine(),
so qdev_get_machine() is available.  qemu_unregister_reset() switches
from object_unref() to object_unparent() to release the child<> ref.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/reset.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/core/reset.c b/hw/core/reset.c
index e7230b49b7..34c1ab84d9 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -27,6 +27,7 @@
 #include "system/reset.h"
 #include "hw/core/resettable.h"
 #include "hw/core/resetcontainer.h"
+#include "hw/core/qdev.h"
 
 /*
  * Return a pointer to the singleton container that holds all the Resettable
@@ -38,7 +39,9 @@ static ResettableContainer *get_root_reset_container(void)
 
     if (!root_reset_container) {
         root_reset_container =
-            RESETTABLE_CONTAINER(object_new(TYPE_RESETTABLE_CONTAINER));
+            RESETTABLE_CONTAINER(object_new_child(qdev_get_machine(),
+                                          "reset-container",
+                                          TYPE_RESETTABLE_CONTAINER));
     }
     return root_reset_container;
 }
@@ -94,7 +97,8 @@ static void legacy_reset_class_init(ObjectClass *klass, const void *data)
 
 void qemu_register_reset(QEMUResetHandler *func, void *opaque)
 {
-    Object *obj = object_new(TYPE_LEGACY_RESET);
+    Object *obj = object_new_child(OBJECT(get_root_reset_container()),
+                                   "legacy-reset[*]", TYPE_LEGACY_RESET);
     LegacyReset *lr = LEGACY_RESET(obj);
 
     lr->func = func;
@@ -104,7 +108,8 @@ void qemu_register_reset(QEMUResetHandler *func, void *opaque)
 
 void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
 {
-    Object *obj = object_new(TYPE_LEGACY_RESET);
+    Object *obj = object_new_child(OBJECT(get_root_reset_container()),
+                                   "legacy-reset[*]", TYPE_LEGACY_RESET);
     LegacyReset *lr = LEGACY_RESET(obj);
 
     lr->func = func;
@@ -156,7 +161,7 @@ void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)
 
     if (obj) {
         qemu_unregister_resettable(obj);
-        object_unref(obj);
+        object_unparent(obj);
     }
 }
 
-- 
2.47.1


