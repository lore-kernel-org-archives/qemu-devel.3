Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1DCC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCqG-0007FC-FF; Sat, 18 Jul 2026 17:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCqD-0007BW-AM; Sat, 18 Jul 2026 17:45:01 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCqB-0002yF-Db; Sat, 18 Jul 2026 17:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411099; x=1815947099;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qVCl/LGYfL4UCle58yHXW8mCdP/ph3jgnSmOc1JYYvo=;
 b=ZhkIruUSOh3piSQKjvyBkYCv7yWqrr2JZRCA4RM3InDbNQnWf9i8rp9u
 +p3lVBRAWvgKSWxec4JUYIw3VxztDuIrlSgrhCAOX6mTTayC/zRpP27mJ
 CV/tzv1oh2QOxFSRiaC3T6uYVsCeZpn7TDpp5YkzonDG2sAS7hR2L0orl
 kpSkNjHD8VYSo0GTCkpb8kx6bCwEyUINeYUhuQUQJfyjiTspLvOcjTcYk
 DV7oeBkLWYLqVoy2VIFLAK0IcqwVUVhJqBnB/NLWw0qEEudemqdMSj4Gw
 QWxDMXetYQ2r8necpMc4+0YgOcPYDl8R/cVmMYeQ7ZKQk3gS3m51H9Pvp A==;
X-CSE-ConnectionGUID: 7j7rb7PISgqsU1wtkjzSIw==
X-CSE-MsgGUID: rJ+oC4gXQ96g7IvRC437ig==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23422691"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:44:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3753]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.151:2525]
 with esmtp (Farcaster)
 id 3a5ed661-dd78-4c44-992b-09c3c211baf5; Sat, 18 Jul 2026 21:44:55 +0000 (UTC)
X-Farcaster-Flow-ID: 3a5ed661-dd78-4c44-992b-09c3c211baf5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:44:55 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:44:46 +0000
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
Subject: [RFC PATCH v2 029/137] hw/mem: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:04 +0000
Message-ID: <20260718213652.37673-30-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/mem to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/mem/sparse-mem.c:111 | qdev_new | parent (new arg) | "sparse-mem" | Public helper; thread Object *parent through. Only caller is generic_fuzz which passes qdev_get_machine()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/mem/sparse-mem.c             | 6 +++---
 include/hw/mem/sparse-mem.h     | 2 +-
 tests/qtest/fuzz/generic_fuzz.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 3310504578..fbf94eb8e7 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -104,14 +104,14 @@ static const Property sparse_mem_properties[] = {
     DEFINE_PROP_UINT64("maxsize", SparseMemState, maxsize, 10 * MiB),
 };
 
-MemoryRegion *sparse_mem_init(uint64_t addr, uint64_t length)
+MemoryRegion *sparse_mem_init(Object *parent, uint64_t addr, uint64_t length)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_SPARSE_MEM);
+    dev = qdev_new(parent, "sparse-mem", TYPE_SPARSE_MEM);
     qdev_prop_set_uint64(dev, "baseaddr", addr);
     qdev_prop_set_uint64(dev, "length", length);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, addr, -10000);
     return &SPARSE_MEM(dev)->mmio;
 }
diff --git a/include/hw/mem/sparse-mem.h b/include/hw/mem/sparse-mem.h
index f9863b154b..79c30cf412 100644
--- a/include/hw/mem/sparse-mem.h
+++ b/include/hw/mem/sparse-mem.h
@@ -14,6 +14,6 @@
 #define SPARSE_MEM_H
 #define TYPE_SPARSE_MEM "sparse-mem"
 
-MemoryRegion *sparse_mem_init(uint64_t addr, uint64_t length);
+MemoryRegion *sparse_mem_init(Object *parent, uint64_t addr, uint64_t length);
 
 #endif
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index e48f868775..99b38a7fd4 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -788,7 +788,7 @@ static void generic_pre_fuzz(QTestState *s)
      * Create a special device that we can use to back DMA buffers at very
      * high memory addresses
      */
-    sparse_mem_mr = sparse_mem_init(0, UINT64_MAX);
+    sparse_mem_mr = sparse_mem_init(qdev_get_machine(), 0, UINT64_MAX);
 
     dma_regions = g_array_new(false, false, sizeof(address_range));
     dma_patterns = g_array_new(false, false, sizeof(pattern));
-- 
2.47.1


