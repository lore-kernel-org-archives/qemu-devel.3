Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0173606A31B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOJhx-0005f0-4T; Tue, 03 Nov 2026 13:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1xOJhv-0005er-3U
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:58:07 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1xOJhs-0006BU-Qy
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:58:06 -0500
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id CB633DA0566;
 Tue, 03 Nov 2026 19:57:36 +0100 (CET)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=weilnetz.de
 (policy=none); 
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 31088466751; Tue, 03 Nov 2026 19:57:21 +0100 (CET)
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Hui Peng <benquike@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/net/eepro100: fix use-after-free on reset after hot-unplug
Date: Tue,  3 Nov 2026 19:56:59 +0100
Message-ID: <20261103185659.698079-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: CB633DA0566
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.60 / 10.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain];
 DMARC_POLICY_SOFTFAIL(0.10)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine,sampled_out]; TO_DN_SOME(0.00)[];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_ONE(0.00)[1];
 R_DKIM_NA(0.00)[]; ARC_NA(0.00)[];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 R_SPF_SOFTFAIL(0.00)[~all];
 FREEMAIL_CC(0.00)[nongnu.org,weilnetz.de,gmail.com,linaro.org];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4058
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4510
Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

Note that I used AI assistance to create and test the patch.
I am not shure whether this is acceptable to small and rather mechnical
changes like in this case.

The Reported-by for issue 4058 was not added because I did not
find the required full name and email of the reporter.

Stefan W.


 hw/net/eepro100.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index aaa3eb60f8a..e1cd8346941 100644
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
@@ -1881,8 +1888,6 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     TRACE(OTHER, logout("%s\n", qemu_get_queue(s->nic)->info_str));
 
-    qemu_register_reset(nic_reset, s);
-
     s->vmstate = g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro100));
     s->vmstate->name = qemu_get_queue(s->nic)->model;
     vmstate_register_any(VMSTATE_IF(&pci_dev->qdev), s->vmstate, s);
@@ -2064,6 +2069,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
     E100PCIDeviceInfo *info;
 
     info = eepro100_get_class_by_name(object_class_get_name(klass));
@@ -2080,6 +2086,7 @@ static void eepro100_class_init(ObjectClass *klass, const void *data)
     k->revision = info->revision;
     k->subsystem_vendor_id = info->subsystem_vendor_id;
     k->subsystem_id = info->subsystem_id;
+    rc->phases.hold = eepro100_reset_hold;
 }
 
 static void eepro100_register_types(void)
-- 
2.54.0 (Apple Git-157)


