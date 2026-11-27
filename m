Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1612606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=EZEJbOTV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWowB-0004ot-Rv; Fri, 27 Nov 2026 00:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWow0-0004Z8-Mb; Fri, 27 Nov 2026 00:55:48 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovy-0000Xb-Sk; Fri, 27 Nov 2026 00:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758873; bh=HeA2XG+y7N8cCfyKR84W36o1uXr8ZwSessr/FJvcazg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EZEJbOTVHK20aqCL+5mLfPCnqc7mbT7iKymcT2jsllbC3jbtsl9qcxIWZR3iXOW5U
 n+w4ywx1PqSMsKsNTgiMzQU6dg7LGnxRzM9tzbTf9fz0kZH+BqA9ZE5Z7NOeXWZtmu
 5qotbV0r2xNJpzkUADrcG4Jw7tArqts0+2kSoxh5ZrCi/0ya+NKlCTbNce8OQTXohz
 Ggw7xZlU7irld6iImTSzAf1kV450IK2wVDLutDaA7kDFwElrPz9K2P1KvLeIb15RP+
 hr86OzKQieowE61uCL4lLt70AEh0MdruYzkeCUKKC/Tbtzw8uX8SiPnPrMpmCJvStr
 2myL1es4oR0dA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAFBE1EA2D5;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8148469912;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C2146CF230; Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Hui Peng <benquike@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 077/140] hw/net/eepro100: fix use-after-free on
 reset after hot-unplug
Date: Fri, 27 Nov 2026 08:53:03 +0300
Message-ID: <20261127055421.39015-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Weil <sw@weilnetz.de>

e100_nic_realize() registers a system reset handler via
qemu_register_reset(nic_reset, s), but pci_nic_uninit() never
unregisters it. After the device is hot-unplugged, the LegacyReset
object stored in the root reset container still holds the raw pointer
to the freed EEPRO100State, so the next system reset invokes
nic_reset() on freed memory.

Instead, define a reset phase on the device itself: assign
phases.hold in eepro100_class_init() to a wrapper around nic_reset().
The device is already part of the resettable tree via its parent bus
(TYPE_DEVICE implements the Resettable interface), so no explicit
registration is needed, and the reset state is automatically dropped
when the device is unplugged. This follows the approach used by the
e1000, e1000e and igb emulations.

Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261103215430.703404-1-sw@weilnetz.de
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4058
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4510
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e17590ca62cb15c70a9de0b7d851244544664ebd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 29a39865a60..3441482667e 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -617,6 +617,13 @@ static void nic_reset(void *opaque)
     nic_selective_reset(s);
 }
 
+static void eepro100_reset_hold(Object *obj, ResetType type)
+{
+    EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, PCI_DEVICE(obj));
+
+    nic_reset(s);
+}
+
 #if defined(DEBUG_EEPRO100)
 static const char * const e100_reg[PCI_IO_SIZE / 4] = {
     "Command/Status",
@@ -1871,8 +1878,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     logout("macaddr: %s\n", nic_dump(&s->conf.macaddr.a[0], 6));
 
-    nic_reset(s);
-
     s->nic = qemu_new_nic(&net_eepro100_info, &s->conf,
                           object_get_typename(OBJECT(pci_dev)),
                           pci_dev->qdev.id,
@@ -1881,8 +1886,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     TRACE(OTHER, logout("%s\n", qemu_get_queue(s->nic)->info_str));
 
-    qemu_register_reset(nic_reset, s);
-
     s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
     s->vmstate->name = qemu_get_queue(s->nic)->model;
     vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
@@ -2064,6 +2067,7 @@ static void eepro100_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     E100PCIDeviceInfo *info;
 
     info = eepro100_get_class_by_name(object_class_get_name(klass));
@@ -2080,6 +2084,7 @@ static void eepro100_class_init(ObjectClass *klass, void *data)
     k->revision = info->revision;
     k->subsystem_vendor_id = info->subsystem_vendor_id;
     k->subsystem_id = info->subsystem_id;
+    rc->phases.hold = eepro100_reset_hold;
 }
 
 static void eepro100_register_types(void)
-- 
2.47.3


