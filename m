Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145D6C56207
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7t-0005rj-C4; Fri, 20 Feb 2026 10:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2E-0008Dn-8e; Fri, 20 Feb 2026 10:03:17 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2C-0002Lf-9e; Fri, 20 Feb 2026 10:03:13 -0500
DKIM-Signature: a=rsa-sha256; bh=nA/pvhoKhGArAZpnZD0U0/Br7wO+8lIKMpEBB8d6hnc=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599790; v=1;
 b=bJsCkyWjpjtN6M8tEuFr3Qi2rXfVg5rajx/nLmyLN/xh9ZXU5ZsMi9TE4TB4uMHnl+0eDIpV
 ihBFJMIri3cTmjImaimylZSLOTDHFsxmAvyHvtUMOripY+Wz2xVF6iUs/kr/5Vc+OzhWWEo+X9t
 lvlD2NOsMPmtHDYWw1TiiIbPCtanT3i3MeXxD6BlcAy6X7wuGqOo4jdDW/BxbeBCh7FiHc0+AyO
 LWXKaQnNhWBc//W3aCq1LESk2MtjRfDWQEgBibFzJwsxLcfyPixOMLBO8w0bAZu5Jme+AtAP0D6
 jBic2flmJYzvbhNRD7DLSAzGs9LRyF/mf1RtUw0ncOWfA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 516F525020;
 Fri, 20 Feb 2026 15:03:10 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Wed, 15 Feb 2023 18:18:54 +0100
Subject: [PATCH qemu 08/11] [ot] hw/riscv: ot_earlgrey: add HW PMP
 configuration
MIME-Version: 1.0
Message-ID: <177159976712.8279.7732381632410882915-8@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

also adds property no_epmp_cfg on EarlGrey machine to disable
default ePMP configuration.

Usage:
  qemu-system-riscv32 -M ot-earlgrey,no-epmp-cfg=3Dtrue [...]

Signed-off-by: Emmanuel Blot <eblot@rivosinc.com>
Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
---
 hw/riscv/ot_earlgrey.c | 116 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/ot_earlgrey.c b/hw/riscv/ot_earlgrey.c
index 760a8d2c2e..77fb1b207c 100644
--- a/hw/riscv/ot_earlgrey.c
+++ b/hw/riscv/ot_earlgrey.c
@@ -18,6 +18,7 @@
 #include "qemu/cutils.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qobject/qlist.h"
 #include "cpu.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
@@ -28,6 +29,13 @@
 #include "hw/riscv/ot_earlgrey.h"
 #include "system/system.h"
=20
+/* ------------------------------------------------------------------------ =
*/
+/* Forward Declarations */
+/* ------------------------------------------------------------------------ =
*/
+
+static void ot_earlgrey_soc_hart_configure(
+    DeviceState *dev, const IbexDeviceDef *def, DeviceState *parent);
+
 /* ------------------------------------------------------------------------ =
*/
 /* Constants */
 /* ------------------------------------------------------------------------ =
*/
@@ -116,6 +124,7 @@ static const IbexDeviceDef ot_earlgrey_soc_devices[] =3D {
     /* clang-format off */
     [OT_EARLGREY_SOC_DEV_HART] =3D {
         .type =3D TYPE_RISCV_CPU_LOWRISC_OPENTITAN,
+        .cfg =3D &ot_earlgrey_soc_hart_configure,
         .prop =3D IBEXDEVICEPROPDEFS(
             IBEX_DEV_BOOL_PROP("zba", true),
             IBEX_DEV_BOOL_PROP("zbb", true),
@@ -529,6 +538,60 @@ static const IbexDeviceDef ot_earlgrey_soc_devices[] =3D=
 {
     /* clang-format on */
 };
=20
+#define PMP_CFG(_l_, _a_, _x_, _w_, _r_) \
+    ((uint8_t)(((_l_) << 7u) | ((_a_) << 3u) | ((_x_) << 2u) | ((_w_) << 1u)=
 | \
+               ((_r_))))
+#define PMP_ADDR(_a_) ((_a_) >> 2u)
+
+#define MSECCFG(_rlb_, _mmwp_, _mml_) \
+    (((_rlb_) << 2u) | ((_mmwp_) << 1u) | ((_mml_)))
+
+enum { PMP_MODE_OFF, PMP_MODE_TOR, PMP_MODE_NA4, PMP_MODE_NAPOT };
+
+static const uint8_t ot_earlgrey_pmp_cfgs[] =3D {
+    /* clang-format off */
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(1, PMP_MODE_NAPOT, 1, 0, 1), /* rgn 2  [ROM: LRX]      */
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(1, PMP_MODE_TOR, 0, 1, 1), /* rgn 11 [MMIO: LRW] */
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(1, PMP_MODE_NAPOT, 1, 1, 1), /* rgn 13 [DV_ROM: LRWX]  */
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0),
+    PMP_CFG(0, PMP_MODE_OFF, 0, 0, 0)
+    /* clang-format on */
+};
+
+static const uint32_t ot_earlgrey_pmp_addrs[] =3D {
+    /* clang-format off */
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x000083fc), /* rgn 2 [ROM: base=3D0x0000_8000 size (2KiB)]    =
  */
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x40000000), /* rgn 10 [MMIO: lo=3D0x4000_0000]                =
  */
+    PMP_ADDR(0x42010000), /* rgn 11 [MMIO: hi=3D0x4201_0000]                =
  */
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x000107fc), /* rgn 13 [DV_ROM: base=3D0x0001_0000 size (4KiB)]=
  */
+    PMP_ADDR(0x00000000),
+    PMP_ADDR(0x00000000)
+    /* clang-format on */
+};
+
+#define OT_EARLGREY_MSECCFG MSECCFG(1, 1, 0)
+
 enum OtEarlgreyBoardDevice {
     OT_EARLGREY_BOARD_DEV_SOC,
     _OT_EARLGREY_BOARD_DEV_COUNT,
@@ -553,8 +616,38 @@ struct OtEarlGreyBoardState {
=20
 struct OtEarlGreyMachineState {
     MachineState parent_obj;
+
+    bool no_epmp_cfg;
 };
=20
+/* ------------------------------------------------------------------------ =
*/
+/* Device Configuration */
+/* ------------------------------------------------------------------------ =
*/
+
+static void ot_earlgrey_soc_hart_configure(
+    DeviceState *dev, const IbexDeviceDef *def, DeviceState *parent)
+{
+    OtEarlGreyMachineState *ms =3D RISCV_OT_EARLGREY_MACHINE(qdev_get_machin=
e());
+    if (ms->no_epmp_cfg) {
+        /* skip default PMP config */
+        return;
+    }
+
+    QList *pmp_cfgs =3D qlist_new();
+    QList *pmp_addrs =3D qlist_new();
+
+    for (unsigned ix =3D 0; ix < ARRAY_SIZE(ot_earlgrey_pmp_cfgs); ix++) {
+        qlist_append_int(pmp_cfgs, (uint64_t)ot_earlgrey_pmp_cfgs[ix]);
+    }
+    for (unsigned ix =3D 0; ix < ARRAY_SIZE(ot_earlgrey_pmp_addrs); ix++) {
+        qlist_append_int(pmp_addrs, (uint64_t)ot_earlgrey_pmp_addrs[ix]);
+    }
+
+    qdev_prop_set_array(dev, "pmp_cfg", pmp_cfgs);
+    qdev_prop_set_array(dev, "pmp_addr", pmp_addrs);
+    qdev_prop_set_uint64(dev, "mseccfg", (uint64_t)OT_EARLGREY_MSECCFG);
+}
+
 /* ------------------------------------------------------------------------ =
*/
 /* SoC */
 /* ------------------------------------------------------------------------ =
*/
@@ -688,12 +781,31 @@ type_init(ot_earlgrey_board_register_types);
 /* Machine */
 /* ------------------------------------------------------------------------ =
*/
=20
+static bool ot_earlgrey_machine_get_no_epmp_cfg(Object *obj, Error **errp)
+{
+    OtEarlGreyMachineState *s =3D RISCV_OT_EARLGREY_MACHINE(obj);
+
+    return s->no_epmp_cfg;
+}
+
+static void
+ot_earlgrey_machine_set_no_epmp_cfg(Object *obj, bool value, Error **errp)
+{
+    OtEarlGreyMachineState *s =3D RISCV_OT_EARLGREY_MACHINE(obj);
+
+    s->no_epmp_cfg =3D value;
+}
+
 static void ot_earlgrey_machine_instance_init(Object *obj)
 {
     OtEarlGreyMachineState *s =3D RISCV_OT_EARLGREY_MACHINE(obj);
=20
-    /* nothing here */
-    (void)s;
+    s->no_epmp_cfg =3D false;
+    object_property_add_bool(obj, "no-epmp-cfg",
+                             &ot_earlgrey_machine_get_no_epmp_cfg,
+                             &ot_earlgrey_machine_set_no_epmp_cfg);
+    object_property_set_description(obj, "no-epmp-cfg",
+                                    "Skip default ePMP configuration");
 }
=20
 static void ot_earlgrey_machine_init(MachineState *state)
--=20
2.49.1


