Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4170C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9LX8-0005cW-Pi; Wed, 23 Sep 2026 07:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1x9Ho6-0000Oj-84
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:54:22 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1x9Ho3-0001Z8-IT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 03:54:21 -0400
DKIM-Signature: a=rsa-sha256; bh=rkWk/mW5/lweUPHeSN7Fuz/vRlDeYx4+p3YxyGHWUuA=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1790150054; v=1;
 b=FDdvi1Jw8zHvaX7ehRxx76f7kZCVfULrai0D6ObbtE7viLazJCy9rTSDPqZpd684+2zHnu3O
 afyOgJxmY5HWUI2mu1+J/p6aRLTogwrsaRMD7RAnoLo2S9rNxiPg12tnENTDhk5uRqYGDoP4hOp
 icvRV9SCPOiz6wFp0XpVSd4yGnklXA/+ym7hqZ/9k49Z6yiMBu7+4Idya8CNn1apWIPOA4H3ezG
 kGrPZ+EEegkGveSOKGd27GoaAmCCJMBZhL3Hhf66hrJ3fW0Q5xD5Db7GhH5eeoTS5MAjhN8Tp4K
 jT5QPqH0c7sscp0pIWtxQ5gzsAkJM52BAr67qT1x7NSGQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id E4D2522689;
 Wed, 23 Sep 2026 07:54:14 +0000 (UTC)
From: ~oyasan2-ba2 <oyasan2-ba2@git.sr.ht>
Date: Wed, 23 Sep 2026 16:18:48 +0900
Subject: [PATCH qemu 1/1] hw/net/e1000e: reset the PHY on a D3hot to D0
 transition
Message-ID: <179015005471.1471.12638559665582988999-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <179015005471.1471.12638559665582988999-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: dmitry.fleytman@gmail.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 jasowangio@gmail.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 FREEMAIL_REPLYTO_END_DIGIT=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:53:04 -0400
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
Reply-To: ~oyasan2-ba2 <oyasan.ba2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: oyasan2-ba2 <oyasan.ba2@gmail.com>

The e1000e PMCSR is writable, but a D3hot -> D0 transition through the
PowerState field does nothing. The 82574 datasheet says the device performs an
internal reset on that transition (PMCSR.No_Soft_Reset is always 0; the
transition is the "ACPI reset"), and Table 27 ("82574 Resets") lists the PHY =
as
reset by it. The wake-up context and status registers are not.

This was confirmed on a real 82574L (8086:10d3): after a BMCR.PDOWN write,
PMCSR D3hot then D0 leaves the PHY at its defaults (PDOWN cleared), whereas t=
he
model keeps PDOWN set.

Detect the D3hot -> D0 change of PowerState in e1000e_write_config() and reset
the PHY (registers back to their defaults, auto-negotiation restarts), the sa=
me
as CTRL.PHY_RST does. The PM capability offset is looked up with
pci_find_capability(). Entering D3hot and rewriting D0 -> D0 do nothing.

Add a qtest (`phy_d3hot_reset`): power the PHY down, rewrite PMCSR D0 (no
reset), go D3hot -> D0, check that PDOWN is cleared, the link is down while
renegotiating and comes back afterwards. The test does not touch MMIO while in
D3hot, so it also works where BARs are unmapped in D-states.

Signed-off-by: oyasan2-ba2 <oyasan.ba2@gmail.com>
---
 hw/net/e1000e.c           | 14 ++++++++++++++
 hw/net/e1000e_core.c      | 15 +++++++++++++++
 hw/net/e1000e_core.h      |  3 +++
 tests/qtest/e1000e-test.c | 40 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 9faf0c74c3..a3f555e00f 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -398,9 +398,23 @@ static void e1000e_write_config(PCIDevice *pci_dev, uint=
32_t address,
                                 uint32_t val, int len)
 {
     E1000EState *s =3D E1000E(pci_dev);
+    uint8_t pm =3D pci_find_capability(pci_dev, PCI_CAP_ID_PM);
+    uint16_t old_pmcsr =3D pm ? pci_get_word(pci_dev->config + pm + PCI_PM_C=
TRL)
+                            : 0;
=20
     pci_default_write_config(pci_dev, address, val, len);
=20
+    /*
+     * D3hot -> D0 through the PowerState field: the device performs an
+     * internal reset (No_Soft_Reset is 0), which includes the PHY.
+     */
+    if (pm && range_covers_byte(address, len, pm + PCI_PM_CTRL) &&
+        (old_pmcsr & PCI_PM_CTRL_STATE_MASK) =3D=3D 3 &&
+        !(pci_get_word(pci_dev->config + pm + PCI_PM_CTRL) &
+          PCI_PM_CTRL_STATE_MASK)) {
+        e1000e_core_pm_d3hot_to_d0(&s->core);
+    }
+
     if (range_covers_byte(address, len, PCI_COMMAND) &&
         (pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
         e1000e_start_recv(&s->core);
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 8c2ecb2411..e973ce2c8f 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -3608,6 +3608,21 @@ e1000e_core_reset(E1000ECore *core)
     e1000e_reset(core, false);
 }
=20
+/*
+ * D3hot -> D0: the 82574 performs an internal reset (PMCSR.No_Soft_Reset is
+ * always 0), and per Table 27 of its datasheet ("82574 Resets") that reset
+ * includes the PHY. A PHY that was powered down (PDOWN) or configured by the
+ * guest goes back to its defaults and renegotiates the link. The wake-up
+ * context and status are not part of it. (The data path and the wake-up
+ * management registers are reset too on real hardware; not modelled here.)
+ */
+void
+e1000e_core_pm_d3hot_to_d0(E1000ECore *core)
+{
+    e1000e_phy_reset(core);
+    e1000e_core_set_link_status(core);
+}
+
 void e1000e_core_pre_save(E1000ECore *core)
 {
     int i;
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 01510ca78b..8b0a88392a 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -127,6 +127,9 @@ e1000e_core_pci_realize(E1000ECore      *regs,
 void
 e1000e_core_reset(E1000ECore *core);
=20
+void
+e1000e_core_pm_d3hot_to_d0(E1000ECore *core);
+
 void
 e1000e_core_pre_save(E1000ECore *core);
=20
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index a398a0b6f8..17428d42fe 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -36,6 +36,7 @@
 #include "libqos/e1000e.h"
 #include "hw/net/e1000_regs.h"
 #include "hw/net/mii.h"
+#include "hw/pci/pci_regs.h"
=20
 static const struct eth_header packet =3D {
     .h_dest =3D E1000E_ADDRESS,
@@ -341,6 +342,43 @@ static void test_e1000e_phy_reset_semantics(void *obj, v=
oid *data,
     g_assert_true(e1000e_link_is_up(d));
 }
=20
+/*
+ * D3hot -> D0 through PMCSR resets the PHY (82574 datasheet, Table 27): a P=
HY
+ * that was powered down comes back at its defaults and the link returns only
+ * after auto-negotiation. Entering D3hot, or D0 -> D0, does not reset it.
+ */
+static void test_e1000e_phy_d3hot_reset(void *obj, void *data,
+                                        QGuestAllocator *alloc)
+{
+    QE1000E_PCI *e1000e =3D obj;
+    QE1000E *d =3D &e1000e->e1000e;
+    QPCIDevice *pdev =3D &e1000e->pci_dev;
+    uint8_t pm =3D qpci_find_capability(pdev, PCI_CAP_ID_PM, 0);
+    uint16_t bmcr;
+
+    g_assert_cmpuint(pm, !=3D, 0);
+
+    clock_step(1000000000LL);
+    g_assert_true(e1000e_link_is_up(d));
+
+    bmcr =3D e1000e_phy_read(d, MII_BMCR);
+    e1000e_phy_write(d, MII_BMCR, bmcr | MII_BMCR_PDOWN);
+    g_assert_false(e1000e_link_is_up(d));
+
+    /* D0 -> D0 rewrite of PMCSR: nothing is reset. */
+    qpci_config_writew(pdev, pm + PCI_PM_CTRL, 0);
+    g_assert_cmphex(e1000e_phy_read(d, MII_BMCR) & MII_BMCR_PDOWN, =3D=3D,
+                    MII_BMCR_PDOWN);
+
+    /* D3hot and back to D0: the PHY is reset, PDOWN is gone. */
+    qpci_config_writew(pdev, pm + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK);
+    qpci_config_writew(pdev, pm + PCI_PM_CTRL, 0);
+    g_assert_cmphex(e1000e_phy_read(d, MII_BMCR) & MII_BMCR_PDOWN, =3D=3D, 0=
);
+    g_assert_false(e1000e_link_is_up(d));      /* renegotiating */
+    clock_step(1000000000LL);
+    g_assert_true(e1000e_link_is_up(d));
+}
+
 static void register_e1000e_test(void)
 {
     QOSGraphTestOptions opts =3D {
@@ -356,6 +394,8 @@ static void register_e1000e_test(void)
     qos_add_test("phy_power_down", "e1000e", test_e1000e_phy_power_down, &op=
ts);
     qos_add_test("phy_reset_semantics", "e1000e",
                  test_e1000e_phy_reset_semantics, &opts);
+    qos_add_test("phy_d3hot_reset", "e1000e",
+                 test_e1000e_phy_d3hot_reset, &opts);
 }
=20
 libqos_init(register_e1000e_test);
--=20
2.49.1

