Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DDAC4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCjS-0000LR-Qo; Sat, 18 Jul 2026 17:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCjR-0000K7-4x; Sat, 18 Jul 2026 17:38:01 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCjP-000201-7i; Sat, 18 Jul 2026 17:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784410679; x=1815946679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ADocZE9Wgpun0caKBt5HshGGbKBiD2Su+oLEOen/wow=;
 b=ReWfYfDfp9sU8bbv5BrlIqtVusx69MGYRZ8uQ46nT2UOOy47OWhSEysr
 MguGG3rXY4A3fIpIMpgqSyxuAE53XUSaRDRVvWKhbZA+5IVg+153qEOmb
 kqFS1UyTB4jFF4yX66Bb0bzwVAsLpZzL7SV3iHvTf+wzR0MAaSvI37pYO
 SyRFAFMOcM2OTdEFTriWN5QKygMGHB00DV/Ne/I1xkcULxvEioJ9BAZtU
 SYTRiAv8W0CValyvd4zldQkvPDbSVJNbcsEeylbaO7Qhg3s/EXv5sr+jt
 vUwHa7dZw16d1y4/s8mWgmrT1O12FaZstiuJDStUkQ058IIiPoxrcJXrR g==;
X-CSE-ConnectionGUID: fh0307X3QLipVIMEbCnklA==
X-CSE-MsgGUID: 5XlmG0etRmGbxqNgI1oGbg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23422468"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:37:55 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:14237]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.17:2525]
 with esmtp (Farcaster)
 id cd177983-6252-40b9-af51-e0142a57fdf3; Sat, 18 Jul 2026 21:37:55 +0000 (UTC)
X-Farcaster-Flow-ID: cd177983-6252-40b9-af51-e0142a57fdf3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:37:54 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:37:45 +0000
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
Subject: [RFC PATCH v2 003/137] qdev: Reintroduce qdev_new() with a mandatory
 QOM parent
Date: Sat, 18 Jul 2026 21:34:38 +0000
Message-ID: <20260718213652.37673-4-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
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

The previous commit vacated the qdev_new()/qdev_try_new() names.
Reintroduce them with the signature we actually want:

  DeviceState *qdev_new(Object *parent, const char *id,
                        const char *type);

which is the qdev-layer, heap-allocated dual of
object_initialize_child(): the returned device is created and
immediately added to the QOM composition tree as a child of @parent
under @id.

Refcount contract: the initial reference is transferred to the
child<> property of @parent, so on return the caller does not hold a
reference.  Pair with qdev_realize() (not qdev_realize_and_unref()),
matching object_initialize_child()'s convention.

qdev_new_orphan() remains for callers that set the parent themselves
before realize (notably qdev_device_add(), which parents under
/machine/peripheral via qdev_set_id()).  Later patches convert the
remaining orphan callers subsystem by subsystem.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/qdev.c         | 20 ++++++++++++++++++++
 include/hw/core/qdev.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 8a8d206a02..947ba7db80 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -145,6 +145,26 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
     return true;
 }
 
+DeviceState *qdev_new(Object *parent, const char *id, const char *type)
+{
+    return DEVICE(object_new_child(parent, id, type));
+}
+
+DeviceState *qdev_try_new(Object *parent, const char *id, const char *type)
+{
+    ObjectClass *oc = module_object_class_by_name(type);
+    Object *obj;
+
+    if (!oc) {
+        return NULL;
+    }
+    obj = object_new_with_class(oc);
+    g_assert(id[0] && !strchr(id, '/'));
+    object_property_add_child(parent, id, obj);
+    object_unref(obj);
+    return DEVICE(obj);
+}
+
 DeviceState *qdev_new_orphan(const char *name)
 {
     return DEVICE(object_new(name));
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 839c1b4147..e692a1d48e 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -406,6 +406,40 @@ struct BusState {
 
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
+/**
+ * qdev_new: Create a device and parent it in the QOM composition tree
+ * @parent: the QOM parent (usually the machine or containing device)
+ * @id: child<> property name; the device's canonical QOM path becomes
+ *      @parent's path plus "/" plus @id
+ * @type: device type to create (we assert() that this type exists)
+ *
+ * Heap-allocated counterpart to object_initialize_child().  This
+ * allocates and initializes the device state and immediately adds it
+ * as a child of @parent, ready for the caller to set properties and
+ * then realize.
+ *
+ * The reference count of the returned device is 1, held by @parent's
+ * child<> property.  The caller therefore does not hold a reference
+ * and pairs this with qdev_realize() (NOT qdev_realize_and_unref()).
+ *
+ * Return: a derived DeviceState, owned by @parent.
+ */
+DeviceState *qdev_new(Object *parent, const char *id, const char *type);
+
+/**
+ * qdev_try_new: Try to create a parented device on the heap
+ * @parent: the QOM parent
+ * @id: child<> property name
+ * @type: device type to create
+ *
+ * This is like qdev_new(), except it returns %NULL when @type does
+ * not exist, rather than asserting.
+ *
+ * Return: a derived DeviceState owned by @parent, or NULL if @type
+ * does not exist.
+ */
+DeviceState *qdev_try_new(Object *parent, const char *id, const char *type);
+
 /**
  * qdev_new_orphan: Create a device on the heap
  * @name: device type to create (we assert() that this type exists)
-- 
2.47.1


