Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D26FC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seru2-00030V-Qn; Fri, 16 Aug 2024 04:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sertu-0002ko-6k
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:01:34 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sertr-0001C2-LO
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723795289; x=1724054489;
 bh=rPFgNlJ6chvB0hG9r9nURep/QmzrAcRSRUPwGjYwykY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=rhQ55VRNC7aig6JnoJV2PxQIA5VMorDjJkxjxCWtHdTay8A3p8kfkC98AupNt/YFE
 YXv6rZpwjnlfXfl+apA5ONvPqH0QJQhv+32mA8lEqZ+V6Oh1+67NyV5THS6rJvnmuE
 iaRgpwqXNiPR9i6xiNWygmouZlBGsj3UNyG03n4zTOIl+gVWqeBtMixgjMck5/0Mq7
 N/qs/+g3p3eY3AC+sMYj1/FEGELJSkEE7GtJ18RHE3zy1kRYuyx2lz6DwrWybQGsHC
 p58sTxyzinRoiVJ+CO7lVkmhTqcccOiz5i3SKxVd/gyzsHgz9Cv4XT3hvIQgDQ6rdz
 hjDtBkro3AmYg==
Date: Fri, 16 Aug 2024 08:01:26 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-9.1 v2] hw/i386/pc: Ensure vmport prerequisites are
 fulfilled
Message-ID: <CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: ef0bbe03faa94f568da6425093c804af69018f0b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=kamil@szczek.dev;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
to disable PS/2 mouse/keyboard'), the vmport will not be created unless
the i8042 PS/2 controller is enabled. To avoid confusion, let's fail if
vmport was explicitly requested, but the i8042 controller is disabled.
This also changes the behavior of vmport=3Dauto to take i8042 controller
availability into account.

Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek.dev>
---
 hw/i386/pc.c      | 8 ++++++--
 hw/i386/pc_piix.c | 3 ++-
 hw/i386/pc_q35.c  | 2 +-
 qemu-options.hx   | 4 ++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c74931d577..c99f2ce540 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1075,7 +1075,7 @@ static const MemoryRegionOps ioportF0_io_ops =3D {
 };
=20
 static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
-                            bool create_i8042, bool no_vmport)
+                            bool create_i8042, bool no_vmport, Error **err=
p)
 {
     int i;
     DriveInfo *fd[MAX_FD];
@@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool cr=
eate_fdctrl,
     }
=20
     if (!create_i8042) {
+        if (!no_vmport) {
+            error_setg(errp,
+                       "vmport requires the i8042 controller to be enabled=
");
+        }
         return;
     }
=20
@@ -1219,7 +1223,7 @@ void pc_basic_device_init(struct PCMachineState *pcms=
,
=20
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
-                    pcms->vmport !=3D ON_OFF_AUTO_ON);
+                    pcms->vmport !=3D ON_OFF_AUTO_ON, &error_fatal);
 }
=20
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d9e69243b4..cf2e2e3e30 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, const char =
*pci_type)
=20
     assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
-        pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
+        pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
+            ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
     }
=20
     /* init basic PC hardware */
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9d108b194e..6c112d804d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine)
=20
     assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
-        pcms->vmport =3D ON_OFF_AUTO_ON;
+        pcms->vmport =3D pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_AUT=
O_OFF;
     }
=20
     /* init basic PC hardware */
diff --git a/qemu-options.hx b/qemu-options.hx
index cee0da2014..0bc780a669 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -68,8 +68,8 @@ SRST
=20
     ``vmport=3Don|off|auto``
         Enables emulation of VMWare IO port, for vmmouse etc. auto says
-        to select the value based on accel. For accel=3Dxen the default is
-        off otherwise the default is on.
+        to select the value based on accel and i8042. For accel=3Dxen
+        and/or i8042=3Doff the default is off otherwise the default is on.
=20
     ``dump-guest-core=3Don|off``
         Include guest memory in a core dump. The default is on.
--=20
2.45.0



