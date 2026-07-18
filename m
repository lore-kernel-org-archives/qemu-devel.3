Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097FBC4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDJV-0004Yc-GA; Sat, 18 Jul 2026 18:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDJN-0004Mz-Sm; Sat, 18 Jul 2026 18:15:13 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDJK-00077U-8C; Sat, 18 Jul 2026 18:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412906; x=1815948906;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Kn1MUAOIEK05pqPjEqHHPU7H8BZuLmOaTQp8KZvj590=;
 b=l7N34ecfKliQqsGwd1FbiHxGTBQTw0jNEcKBekUIvenQnYFfCjVOf4KB
 BUWKCJK9+aZmNx3V7xWtZRc8P1aEH4fSVLxPFL1cENH3cX11QkCMC9UDk
 dJwI0cawEnT9gWrjPMkC91YntVT6Wnmj5ckowF1rwI1qmc/u2aVVKV4DO
 mItZ8vDqdon6bc4ZadUfg37f/Cf2FlfO51Q1zAZCvrnC3+FADKnQ2I/U5
 zHQ0DRhBdwnos+D9CFichC5kk9vkoZ3vQRk7qqv/i0nvbArY4OVDMxCif
 O7ePs13adhujirq6e/sq2dkfxAX95qOD8XyZUV6YSXiZrPnsd29NEuPrv w==;
X-CSE-ConnectionGUID: HlvVdsQhRLiSszKeJXKhDw==
X-CSE-MsgGUID: bomBcti/Ryern5a1EmSkBA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23424001"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:15:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:16389]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id 2dd8e872-f7cf-4b1b-bff4-26ff92e74a44; Sat, 18 Jul 2026 22:15:01 +0000 (UTC)
X-Farcaster-Flow-ID: 2dd8e872-f7cf-4b1b-bff4-26ff92e74a44
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:15:01 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:14:52 +0000
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
Subject: [RFC PATCH v2 136/137] docs/devel/qom: Document the composition-tree
 parenting contract
Date: Sat, 18 Jul 2026 21:36:51 +0000
Message-ID: <20260718213652.37673-137-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
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

Add a section to the QOM developer documentation explaining that
every object must have a composition-tree parent before use, how
to pick the parent (creator owns lifetime), how to name children,
the reference-count contract for parented creators, and where the
contract is enforced (device_set_realized, memory_region_do_init,
qdev_connect_gpio_out_named).

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 docs/devel/qom.rst | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 935bb1004a..ffcb3333b5 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -27,6 +27,102 @@ that make up a QEMU "machine". You can view this tree by running
 objects created by the machine itself as well those created due to
 user configuration.
 
+Composition-tree parenting contract
+====================================
+
+Every QOM object that participates in the running system must have a
+composition-tree parent before it is used.  The parent gives the object
+a stable, canonical path such as ``/machine/soc/uart[0]`` that is
+visible in ``info qom-tree`` and addressable via ``qom-get`` and
+``qom-set``.  Objects that reach ``realize`` (for devices), that are
+wired to another object (for IRQ lines), or that are given a name (for
+memory regions) without a parent are programming errors.
+
+Creating parented objects
+-------------------------
+
+The standard creation helpers all take the composition-tree parent and
+the child name as their first two arguments:
+
+.. code-block:: c
+
+    Object      *object_new_child(Object *parent, const char *id,
+                                  const char *typename);
+    DeviceState *qdev_new(Object *parent, const char *id,
+                          const char *typename);
+    DeviceState *sysbus_create_simple(Object *parent, const char *id,
+                                      const char *type, hwaddr, qemu_irq);
+    PCIDevice   *pci_new(Object *parent, const char *id, ...);
+    ISADevice   *isa_new(Object *parent, const char *id, ...);
+    /* i2c_slave_new(), ssi_create_peripheral(), usb_new(),
+       cpu_create() etc. follow the same pattern. */
+
+``object_new()`` remains available as the primitive allocator for
+transient introspection objects and for ``qdev_device_add()``, which
+parents the device via ``qdev_set_id()``.  All other callers should use
+one of the parented helpers above, or ``object_initialize_child()`` for
+objects that are embedded by value in the parent's instance struct.
+
+Choosing the parent
+-------------------
+
+The QOM parent is the object that owns the child's lifetime.  In
+practice this is the object whose code is creating the child:
+
+* Board code (``MachineClass.init``) parents onboard devices to the
+  machine: ``OBJECT(machine)``.
+* A composite device's ``DeviceClass.realize`` parents the sub-devices
+  it creates to itself: ``OBJECT(dev)``.
+* An SoC container likewise parents the devices it creates to the SoC
+  object.
+
+The bus a device is plugged into is *not* its composition-tree parent.
+A device may sit on a bus owned by ``B`` without being a child of
+``B``; the bus relationship is expressed through the ``parent_bus``
+link, not the ``child<>`` property.
+
+Choosing the child name
+-----------------------
+
+* A single instance takes a bare noun: ``"uart"``, ``"gic"``, ``"rtc"``.
+* A fixed number of identical instances take an explicit index:
+  ``"uart[0]"``, ``"uart[1]"``.
+* When the caller does not care about the index, ``"uart[*]"`` lets
+  QOM allocate the next free slot in the ``uart[]`` array.
+* Address-based names such as ``"eth@0x30000000"`` should only be used
+  when the address is genuinely the identity of the device.
+
+Child names share the parent's property namespace, so avoid names that
+collide with class-defined properties of the parent (in particular,
+machine class properties visible on ``/machine``).
+
+Reference-count contract
+------------------------
+
+``object_new_child()``, ``qdev_new()`` and the per-bus creators return
+with the object's single reference held by the parent's ``child<>``
+property.  The caller does *not* hold a reference of its own and must
+therefore pair creation with plain ``qdev_realize()`` rather than
+``qdev_realize_and_unref()``.  The object is finalized when the parent
+drops its ``child<>`` property, typically via ``object_unparent()``.
+
+Enforcement
+-----------
+
+The parenting contract is enforced at the points where an unparented
+object would first become visible or entangled with another object:
+
+* ``device_set_realized()`` fails with an ``Error`` if the device has
+  no composition-tree parent.
+* ``memory_region_do_init()`` asserts that a memory region given a
+  non-empty name also has an owner.
+* ``qdev_connect_gpio_out_named()`` asserts that the outbound IRQ
+  line being connected already has a composition-tree parent.
+
+There is no ``/machine/unattached`` fallback container; an object that
+would previously have landed there now triggers one of the errors
+above instead.
+
 Creating a QOM class
 ====================
 
-- 
2.47.1


