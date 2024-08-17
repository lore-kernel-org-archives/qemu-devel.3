Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FB5C52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 15:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfLJy-0005Ze-43; Sat, 17 Aug 2024 11:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>)
 id 1sfLJu-0005SI-IT; Sat, 17 Aug 2024 11:26:22 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>)
 id 1sfLJs-0002ww-T7; Sat, 17 Aug 2024 11:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723908378; x=1724167578;
 bh=s1J+/joXcnmcBoU8KLpZcBTE95mzfsErY/FNZ190l+o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=rlW8z0XeQaNzMWc/WBcrDRx7BKdI3vFDWcIopNL3luqmJy7d/URc9c19bkMvL0ZnY
 BGZTdablPRmaBF3uaOC3gP0TifAjwbf+md4PP33RjUC9fbFa1y0jF2h2WSaVe03e52
 5Fr/Gjp5VG7U98XVx+h2CNJW+xzZKwHOa5J7Q2rgKWGhNx1EKijVPKAw+C1ODneioy
 R9GmpmFo0qw5AutlSjeLVi/9Caog8sWxVFcXHLZ13tCfiuGTs5QEPNxMDw7542QR7e
 YXuj0xEuRlQeNXLj9bJm0Mxt8LEgjkSUypvkSFqnErOS51R7DEF8/K6GVS3xxXrRca
 4iXFu3Hvg2U7Q==
Date: Sat, 17 Aug 2024 15:26:15 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Joelle van Dyne <j@getutm.app>
Subject: [PATCH-for-9.1 v3 2/2] hw/i386/pc: Ensure vmport prerequisites are
 fulfilled
Message-ID: <0MS3y5E-hHqODIhiuFxmCnIrXd612JIGq31UuMsz4KGCKZ_wWuF-PHGKTRSGS0nWaPEddOdF4YOczHdgorulECPo792OhWov7O9BBF6UMX4=@szczek.dev>
In-Reply-To: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
References: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 224da595a205981604b56b7ecd1509ad48547c22
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=kamil@szczek.dev;
 helo=mail-4018.proton.ch
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
 hw/i386/pc.c    | 11 ++++++++---
 qemu-options.hx |  4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 72229a24ff..7779c88a91 100644
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
@@ -1219,12 +1223,13 @@ void pc_basic_device_init(struct PCMachineState *pc=
ms,
=20
     assert(pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX);
     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
-        pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
+        pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
+            ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
     }
=20
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
-                    pcms->vmport !=3D ON_OFF_AUTO_ON);
+                    pcms->vmport !=3D ON_OFF_AUTO_ON, &error_fatal);
 }
=20
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
diff --git a/qemu-options.hx b/qemu-options.hx
index cee0da2014..9197bb25d3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -68,8 +68,8 @@ SRST
=20
     ``vmport=3Don|off|auto``
         Enables emulation of VMWare IO port, for vmmouse etc. auto says
-        to select the value based on accel. For accel=3Dxen the default is
-        off otherwise the default is on.
+        to select the value based on accel and i8042. For accel=3Dxen or
+        i8042=3Doff the default is off otherwise the default is on.
=20
     ``dump-guest-core=3Don|off``
         Include guest memory in a core dump. The default is on.
--=20
2.45.0



