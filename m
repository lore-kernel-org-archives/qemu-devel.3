Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE44C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCtO-0005ig-4o; Sat, 18 Jul 2026 17:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCtI-0005fn-Ui; Sat, 18 Jul 2026 17:48:13 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCtG-0003Qn-Vf; Sat, 18 Jul 2026 17:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411290; x=1815947290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UhLAmzyz2vuayR3+tp7eAX58tqrCnDdM+m/9YQbf8r8=;
 b=tBHOpyMgAo84wLJNknil7aKne5qO9+8UoAYIAm/4ydSITHJdVoyB20c8
 82l/XRMOuqoNumswtnvjq6FsSfPXAX5x1g0RUrgiZIdyHIlUuWa3ujmEV
 VmbqWwQsFG9WxsjHJacisZBjWX3jCcHgcRK8gpMXvR3vr/7gPFSHvNrqS
 WVG+L8Lcu6BR78VZ/sApqil1vh4XphytA+lOnGPpbyWIXZnDncCVOD0p5
 5iS1qSJ9FjtNn7chRr5QbnQ0nnXmmtQYvpgEolO8RbeXZWm4priEVPbIS
 OkJKJP2AtsMmyxZcfm0A/8uh9czKkCk9OA+8O7F898pbXkfOTypsjfbr4 A==;
X-CSE-ConnectionGUID: a3KoWJ7wRYyCYSTV3eSg2A==
X-CSE-MsgGUID: 8gSd0AYqT2KimmaKDerDLg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23944067"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:48:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:10748]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.177:2525]
 with esmtp (Farcaster)
 id 3ce8bbf2-eab3-4647-a35a-bbc71a629317; Sat, 18 Jul 2026 21:48:06 +0000 (UTC)
X-Farcaster-Flow-ID: 3ce8bbf2-eab3-4647-a35a-bbc71a629317
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:48:06 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:47:57 +0000
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
Subject: [RFC PATCH v2 040/137] hw/i3c: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:15 +0000
Message-ID: <20260718213652.37673-41-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
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
AI-used-for: code (refactoring)
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


