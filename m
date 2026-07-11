Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04ACC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiglB-0001ci-Bh; Sat, 11 Jul 2026 19:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigl6-0001Yn-IW; Sat, 11 Jul 2026 19:05:21 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigl4-00036j-Or; Sat, 11 Jul 2026 19:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811118; x=1815347118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w6Pfk1xQ4FRrAQkKCewEEwHD3O/ZvRglgXd3sI9Xt2w=;
 b=Kd4SRqrtGjq9pzaQCUjBGCMScmc6Zp3Un/gXfkXWGYokoBCWKoMQbiCh
 fGPqBvRu3R/BQN+qiZJzZV0z8aLZWBJ54mK5kRQzAoYJZfLw6hXgVC5nr
 lDikpH3omgu2xvkQysgsUiz2R6ek2Quz9I7ebsFPa1XH/ZwnxJSAVEiZb
 WcTIWOMKEq8n4MtgyffbCxthgg0kgYjCK75LXgTxJbY80OoGPdVQTJ8z1
 pTC4TAaWxgEI0s/sSViw748HMDDwX5EBUkiUYAO5pycuaS4FbG6Ez6/pP
 15Mp8azznpM22afIY71PwpwtSOzUMXa/wIEihaHNBpyeCQ4vz+K0PUbZa Q==;
X-CSE-ConnectionGUID: jM3fguWESOa8NRPPJu6GuA==
X-CSE-MsgGUID: 2c1ADUXITy6CHgCzBRxWKw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23505942"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:05:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:20840]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id 78f9f4e0-ab2a-413a-9444-aaf789afd760; Sat, 11 Jul 2026 23:05:14 +0000 (UTC)
X-Farcaster-Flow-ID: 78f9f4e0-ab2a-413a-9444-aaf789afd760
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:14 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:05:05 +0000
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
Subject: [RFC PATCH 107/134] memory: Require an owner for named memory regions
Date: Sat, 11 Jul 2026 22:36:40 +0000
Message-ID: <20260711223707.42139-108-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Now that every named memory region in the tree passes an explicit
owner, replace the /machine/unattached fallback in
memory_region_do_init() and portio_list_add_1() with an assertion.

Anonymous (name==NULL) regions such as subpages and io_mem_unassigned
are never QOM-parented and continue to accept a NULL owner.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 system/ioport.c | 7 ++-----
 system/memory.c | 7 +++----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 0a1b80f299..0415b3cd60 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -248,11 +248,8 @@ static void portio_list_add_1(PortioList *piolist,
     /* Reparent the MemoryRegion to the piolist owner */
     object_ref(&mrpio->mr);
     object_unparent(OBJECT(&mrpio->mr));
-    if (!piolist->owner) {
-        owner = machine_get_container("unattached");
-    } else {
-        owner = piolist->owner;
-    }
+    g_assert(piolist->owner);
+    owner = piolist->owner;
     name = g_strdup_printf("%s[*]", piolist->name);
     object_property_add_child(owner, name, OBJECT(&mrpio->mr));
     g_free(name);
diff --git a/system/memory.c b/system/memory.c
index e3ee0416cc..f3a77197df 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1230,14 +1230,13 @@ static void memory_region_do_init(MemoryRegion *mr,
     mr->dev = (DeviceState *) object_dynamic_cast(mr->owner, TYPE_DEVICE);
     mr->ram_block = NULL;
 
+    /* A named MemoryRegion is a QOM child of @owner */
+    g_assert(!name || owner);
+
     if (name) {
         char *escaped_name = memory_region_escape_name(name);
         char *name_array = g_strdup_printf("%s[*]", escaped_name);
 
-        if (!owner) {
-            owner = machine_get_container("unattached");
-        }
-
         object_property_add_child(owner, name_array, OBJECT(mr));
         object_unref(OBJECT(mr));
         g_free(name_array);
-- 
2.47.1


