Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8950C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigop-0000LO-Fw; Sat, 11 Jul 2026 19:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigof-00008h-2M; Sat, 11 Jul 2026 19:09:01 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigob-00047n-2S; Sat, 11 Jul 2026 19:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783811337; x=1815347337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RjzyzstKMqEdpWpECl8E1JcahBO6m41j6mbqUJjb658=;
 b=h0Kt1uI3I3XTOf6ZragpUP2VlZc8BpzRxINLQYvuck/pDscy0JVJUJrO
 gyH5n+t3iRL2MYuXQjH8t/a3fS8w7serfKY3SNxB71asodQYpteDk9YmS
 b+KPF+JlSzuQYQhxKtUYeAfWTRmMKkBVspOL0T35lES1dLvsoVKWfYSlL
 5vO8fvAWdGJS2KngGNM9ityr6fXKzMWqTUmMF0giZtL74VGecvfp1RvCN
 pdKdKWVG+1jrFbBNdOzDUawXRrZaWshS3S3M7H6sQgezb0YADcs+plbWO
 wR0VIaApZvlq2yLDslZ/DJwhiN1l9Or0Pm+A3UOTr757rggtbxCtgyV7T Q==;
X-CSE-ConnectionGUID: 4V/jQ0cnRo2wHIvGpDl6aA==
X-CSE-MsgGUID: Y1BgZRbrRamvEsi+WCujQQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="22997855"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:08:53 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:7144]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id b70aa7fb-e9b8-4175-b273-0d4dd83d31cc; Sat, 11 Jul 2026 23:08:52 +0000 (UTC)
X-Farcaster-Flow-ID: b70aa7fb-e9b8-4175-b273-0d4dd83d31cc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:08:52 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:08:44 +0000
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
Subject: [RFC PATCH 120/134] system: Parent per-MR helper objects under their
 owner
Date: Sat, 11 Jul 2026 22:36:53 +0000
Message-ID: <20260711223707.42139-121-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

RamBlockAttributes and MemoryRegionPortioList objects are long-lived
helpers whose lifetime is already tied to a MemoryRegion or its owner.
Give each a canonical path under that owner instead of leaving them
as floating refcounted objects:

  <mr-path>/attributes           (RamBlockAttributes)
  <owner-path>/portio-list[N]    (MemoryRegionPortioList)

The destroy paths switch from object_unref() to object_unparent()
now that the parent holds the reference.

RamDiscardManager is deliberately left as-is: it is unref'd from
memory_region_finalize() itself, so making it a child<> of the MR
would introduce a use-after-free during MR teardown.  It can move
under a different owner in a follow-up once the RDM lifecycle is
untangled from MR finalize.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 system/ioport.c               | 5 +++--
 system/ram-block-attributes.c | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 0415b3cd60..77ab77d7be 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -145,7 +145,7 @@ void portio_list_destroy(PortioList *piolist)
     for (i = 0; i < piolist->nr; ++i) {
         mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
         object_unparent(OBJECT(&mrpio->mr));
-        object_unref(mrpio);
+        object_unparent(OBJECT(mrpio));
     }
     g_free(piolist->regions);
 }
@@ -228,7 +228,8 @@ static void portio_list_add_1(PortioList *piolist,
 
     /* Copy the sub-list and null-terminate it.  */
     mrpio = MEMORY_REGION_PORTIO_LIST(
-                object_new(TYPE_MEMORY_REGION_PORTIO_LIST));
+                object_new_child(piolist->owner, "portio-list[*]",
+                                 TYPE_MEMORY_REGION_PORTIO_LIST));
     mrpio->portio_opaque = piolist->opaque;
     mrpio->ports = g_new0(MemoryRegionPortio, count + 1);
     memcpy(mrpio->ports, pio_init, sizeof(MemoryRegionPortio) * count);
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 59ec7a28eb..0967bed6d3 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -182,12 +182,13 @@ RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
     RamBlockAttributes *attr;
     MemoryRegion *mr = ram_block->mr;
 
-    attr = RAM_BLOCK_ATTRIBUTES(object_new(TYPE_RAM_BLOCK_ATTRIBUTES));
+    attr = RAM_BLOCK_ATTRIBUTES(object_new_child(OBJECT(mr), "attributes",
+                                                 TYPE_RAM_BLOCK_ATTRIBUTES));
 
     attr->ram_block = ram_block;
 
     if (memory_region_add_ram_discard_source(mr, RAM_DISCARD_SOURCE(attr))) {
-        object_unref(OBJECT(attr));
+        object_unparent(OBJECT(attr));
         return NULL;
     }
     attr->bitmap_size = DIV_ROUND_UP(int128_get64(mr->size), block_size);
@@ -202,7 +203,7 @@ void ram_block_attributes_destroy(RamBlockAttributes *attr)
 
     g_free(attr->bitmap);
     memory_region_del_ram_discard_source(attr->ram_block->mr, RAM_DISCARD_SOURCE(attr));
-    object_unref(OBJECT(attr));
+    object_unparent(OBJECT(attr));
 }
 
 static void ram_block_attributes_init(Object *obj)
-- 
2.47.1


