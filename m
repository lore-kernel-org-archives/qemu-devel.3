Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F07AC44521
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD6X-0000vD-JF; Sat, 18 Jul 2026 18:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD6V-0000ow-5i; Sat, 18 Jul 2026 18:01:51 -0400
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD6T-0005I6-AJ; Sat, 18 Jul 2026 18:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412109; x=1815948109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gFz4tkd1KJwCvb3Rl1/cy5JLi/p+MBu/0U/TuIwPjWU=;
 b=VCyxGr58HPbC1meUb8qTi/7RsgBEo7q2ReS8V185BwI5022HY91aQtUb
 0KGZYHMN3GQ6o2OpmSctGegE2zH61CQKW34+knAvhMMRgkLyZ9ZQQN3zG
 xKiweb7K9kbe/t21OYrA75BF0Bw/qB0ukHvBet9KaSykZwt9fsDvwiVyo
 xgYEqUAVVOS5DeQJZ41NHWYHD/zmqsv4iD+oiPWHUEamzL3NkrL449OXR
 V0BChAmy/ujzr48M2iAH4h5t+TpOR2fTo3oEaRg4n5OzkDBxdH1coVyRi
 vdPK23GwvEhGC5znGUDxCEbT/eKNoDvnoBQ3ScE+cXQUyaBKrt/QKh4tI A==;
X-CSE-ConnectionGUID: kJNB4abfQdeXrvuWzpFnLg==
X-CSE-MsgGUID: teDMr8DeQ6Sn4eG5OZdexA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23927606"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:01:45 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:9718]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id abec0ef8-c6ad-457f-a6bc-46fc6b9d85df; Sat, 18 Jul 2026 22:01:45 +0000 (UTC)
X-Farcaster-Flow-ID: abec0ef8-c6ad-457f-a6bc-46fc6b9d85df
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:01:45 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:01:36 +0000
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
Subject: [RFC PATCH v2 089/137] qdev: Remove qdev_new_orphan() and
 qdev_try_new_orphan()
Date: Sat, 18 Jul 2026 21:36:04 +0000
Message-ID: <20260718213652.37673-90-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Every bus-layer *_orphan() wrapper is gone and the last direct
caller, qdev_device_add_from_qdict(), now uses object_new() plus
qdev_set_id() to place -device instances under
/machine/peripheral{,-anon} as before.  There is no remaining
legitimate way to create a device without picking its parent, so
drop the transitional *_orphan() spellings and update the doc
comments that still referenced them.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/qdev.c         | 13 -------------
 include/hw/core/qdev.h | 30 +++---------------------------
 system/qdev-monitor.c  |  2 +-
 3 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 947ba7db80..89bc1e30c0 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -165,19 +165,6 @@ DeviceState *qdev_try_new(Object *parent, const char *id, const char *type)
     return DEVICE(obj);
 }
 
-DeviceState *qdev_new_orphan(const char *name)
-{
-    return DEVICE(object_new(name));
-}
-
-DeviceState *qdev_try_new_orphan(const char *name)
-{
-    ObjectClass *oc = module_object_class_by_name(name);
-    if (!oc) {
-        return NULL;
-    }
-    return DEVICE(object_new_with_class(oc));
-}
 
 static QTAILQ_HEAD(, DeviceListener) device_listeners
     = QTAILQ_HEAD_INITIALIZER(device_listeners);
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e692a1d48e..9220e9e3b1 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -440,30 +440,6 @@ DeviceState *qdev_new(Object *parent, const char *id, const char *type);
  */
 DeviceState *qdev_try_new(Object *parent, const char *id, const char *type);
 
-/**
- * qdev_new_orphan: Create a device on the heap
- * @name: device type to create (we assert() that this type exists)
- *
- * This only allocates the memory and initializes the device state
- * structure, ready for the caller to set properties if they wish.
- * The device still needs to be realized.
- *
- * Return: a derived DeviceState object with a reference count of 1.
- */
-DeviceState *qdev_new_orphan(const char *name);
-
-/**
- * qdev_try_new_orphan: Try to create a device on the heap
- * @name: device type to create
- *
- * This is like qdev_new_orphan(), except it returns %NULL when type @name
- * does not exist, rather than asserting.
- *
- * Return: a derived DeviceState object with a reference count of 1 or
- * NULL if type @name does not exist.
- */
-DeviceState *qdev_try_new_orphan(const char *name);
-
 /**
  * qdev_is_realized() - check if device is realized
  * @dev: The device to check.
@@ -488,8 +464,8 @@ static inline bool qdev_is_realized(DeviceState *dev)
  * If @bus, plug @dev into @bus.  This takes a reference to @dev.
  * If @dev has no QOM parent, make one up, taking another reference.
  *
- * If you created @dev using qdev_new_orphan(), you probably want to use
- * qdev_realize_and_unref() instead.
+ * If you created @dev via object_new() directly (holding a floating
+ * reference), you probably want to use qdev_realize_and_unref() instead.
  *
  * Return: true on success, else false setting @errp with error
  */
@@ -506,7 +482,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
  * (private) reference, which is dropped on return regardless of
  * success or failure.  Intended use::
  *
- *     dev = qdev_new_orphan();
+ *     dev = DEVICE(object_new(TYPE_FOO));
  *     [...]
  *     qdev_realize_and_unref(dev, bus, errp);
  *
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index adc37d6a89..0e13b1540c 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -707,7 +707,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     /* create device */
-    dev = qdev_new_orphan(driver);
+    dev = DEVICE(object_new(driver));
 
     /* Check whether the hotplug is allowed by the machine */
     if (phase_check(PHASE_MACHINE_READY) &&
-- 
2.47.1


