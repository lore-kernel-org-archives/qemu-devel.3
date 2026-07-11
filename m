Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05033C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigUM-0000r8-Ql; Sat, 11 Jul 2026 18:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigUB-0000bs-AO; Sat, 11 Jul 2026 18:47:54 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigU6-0007UR-Pw; Sat, 11 Jul 2026 18:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810066; x=1815346066;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=urslx+F+1DcIG3WUi4fMfYT2/zRrg9pAEDrsh9YargQ=;
 b=izSq6CFs3F6ndSae3lsgI27z+khf3AxUlyHYfP8Bts9XfTaNIXvBFXID
 Q5bU3MH9Cqn2gCdmlyC3EKjSS/rdamoycyInva76OUNT6Q9XWYeat0T1n
 s2E/myT8vAD/bXuUQiXoyBo0grdtOu5Zg3YSdNUAdQ2e35xq9qiN1Z4vz
 /1o+kkhoQl0oRbVrHvOkNzylYyvmeziqkL8KTyhGzZApEslfxcj6aEYko
 9VlXn7rF69kAJpO4BkPjRYHurS+5PViW4GflvreCzP5300gWC7AiDbHG3
 ueKSFQwK1KhgekwkVU6oEpb0JsSeOjMEY468vFFWumH9N/pCqIC52s765 A==;
X-CSE-ConnectionGUID: k2DGPdOOTCSGAO5S8+UCUw==
X-CSE-MsgGUID: fpsjUdf1Sx2W5u6wG68Dog==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23505584"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:47:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:25187]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id 8f9145b8-4259-41d4-b720-ba37100c3c08; Sat, 11 Jul 2026 22:47:42 +0000 (UTC)
X-Farcaster-Flow-ID: 8f9145b8-4259-41d4-b720-ba37100c3c08
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:47:41 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:47:33 +0000
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
Subject: [RFC PATCH 040/134] hw/i3c: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:33 +0000
Message-ID: <20260711223707.42139-41-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
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

Convert the *_orphan() device-creation calls in hw/i3c to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/i3c/core.c:550 | qdev_new | parent | id | public helper; thread Object *parent + const char *id through i3c_target_new() and its caller i3c_target_create_simple()
hw/i3c/core.c:626 | i2c_slave_new | parent | id | public helper; thread Object *parent + const char *id through legacy_i2c_device_create_simple()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/i3c/core.c        | 19 +++++++++++--------
 include/hw/i3c/i3c.h |  9 ++++++---
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/i3c/core.c b/hw/i3c/core.c
index 469d66f1fb..23b32290e5 100644
--- a/hw/i3c/core.c
+++ b/hw/i3c/core.c
@@ -542,12 +542,13 @@ static bool i3c_addr_is_rsvd(uint8_t addr)
     return is_rsvd[addr];
 }
 
-I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,
+I3CTarget *i3c_target_new(Object *parent, const char *id,
+                          const char *name, uint8_t addr, uint8_t dcr,
                           uint8_t bcr, uint64_t pid)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(name);
+    dev = qdev_new(parent, id, name);
     qdev_prop_set_uint8(dev, "static-address", addr);
     qdev_prop_set_uint8(dev, "dcr", dcr);
     qdev_prop_set_uint8(dev, "bcr", bcr);
@@ -566,12 +567,13 @@ bool i3c_target_realize_and_unref(I3CTarget *dev, I3CBus *bus, Error **errp)
     return qdev_realize_and_unref(&dev->parent_obj, &bus->parent_obj, errp);
 }
 
-I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name, uint8_t addr,
+I3CTarget *i3c_target_create_simple(Object *parent, const char *id,
+                                    I3CBus *bus, const char *name, uint8_t addr,
                                     uint8_t dcr, uint8_t bcr, uint64_t pid)
 {
-    I3CTarget *dev = i3c_target_new(name, addr, dcr, bcr, pid);
+    I3CTarget *dev = i3c_target_new(parent, id, name, addr, dcr, bcr, pid);
     dev->address = 0;
-    i3c_target_realize_and_unref(dev, bus, &error_abort);
+    qdev_realize(DEVICE(dev), BUS(bus), &error_abort);
 
     return dev;
 }
@@ -620,12 +622,13 @@ void legacy_i2c_end_transfer(I3CBus *bus)
     i2c_end_transfer(bus->i2c_bus);
 }
 
-I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,
+I2CSlave *legacy_i2c_device_create_simple(Object *parent, const char *id,
+                                          I3CBus *bus, const char *name,
                                           uint8_t addr)
 {
-    I2CSlave *dev = i2c_slave_new_orphan(name, addr);
+    I2CSlave *dev = i2c_slave_new(parent, id, name, addr);
 
-    i2c_slave_realize_and_unref(dev, bus->i2c_bus, &error_abort);
+    qdev_realize(DEVICE(dev), BUS(bus->i2c_bus), &error_abort);
     return dev;
 }
 
diff --git a/include/hw/i3c/i3c.h b/include/hw/i3c/i3c.h
index dcf8d9b143..d0edf7d8bd 100644
--- a/include/hw/i3c/i3c.h
+++ b/include/hw/i3c/i3c.h
@@ -257,7 +257,8 @@ int legacy_i2c_start_transfer(I3CBus *bus, uint8_t address, bool is_recv);
 int legacy_i2c_start_recv(I3CBus *bus, uint8_t address);
 int legacy_i2c_start_send(I3CBus *bus, uint8_t address);
 void legacy_i2c_end_transfer(I3CBus *bus);
-I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,
+I2CSlave *legacy_i2c_device_create_simple(Object *parent, const char *id,
+                                          I3CBus *bus, const char *name,
                                           uint8_t addr);
 
 /**
@@ -265,7 +266,8 @@ I2CSlave *legacy_i2c_device_create_simple(I3CBus *bus, const char *name,
  *
  * The target returned from this function still needs to be realized.
  */
-I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,
+I3CTarget *i3c_target_new(Object *parent, const char *id,
+                          const char *name, uint8_t addr, uint8_t dcr,
                           uint8_t bcr, uint64_t pid);
 
 /**
@@ -274,7 +276,8 @@ I3CTarget *i3c_target_new(const char *name, uint8_t addr, uint8_t dcr,
  * Create the target, initialize it, put it on the specified I3C bus, and
  * realize it.
  */
-I3CTarget *i3c_target_create_simple(I3CBus *bus, const char *name,
+I3CTarget *i3c_target_create_simple(Object *parent, const char *id,
+                                    I3CBus *bus, const char *name,
                                     uint8_t addr, uint8_t dcr, uint8_t bcr,
                                     uint64_t pid);
 
-- 
2.47.1


