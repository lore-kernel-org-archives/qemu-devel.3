Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FADC52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 15:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfLJF-00027w-M8; Sat, 17 Aug 2024 11:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfLJC-00020c-Mn
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 11:25:38 -0400
Received: from mail-4022.proton.ch ([185.70.40.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfLJB-0002tz-0o
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 11:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723908334; x=1724167534;
 bh=pjjQ6/SzofMzx51HfeLaFW2R17BybGcImSMEFiILnx4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=O4/bk5mJLEUFGYRLgAY4ASL+fPD/CYGxahy7XfwQ0sQsX8Y+hNmVvXMcunVU24CsS
 dOrft7WlipAJWN0mdVVGEYiJS2nYEIbj3Qh9ooWBl/S4aMUdMgmCBes2LOwpkZBT3D
 2SQfbjDN9VogfRfon5qQkU2eF5P4PIXjhA2XHANFKmNWnI9aZ0lTNPT1+4E25rJEio
 HQ+ziIO3rl+kmo/Qo07vYbKllVZfKJk9DsoavHH/D7C2vMlSwMLsjmW8pjIxusqcEo
 kYDNkBhd/bwJP6IhkhJhAPKRZud9k6lenxUEBWTXCmp5k23L2LqJmQSImhVmOquKRz
 0n7iL9SL8gpVg==
Date: Sat, 17 Aug 2024 15:25:31 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Joelle van Dyne <j@getutm.app>
Subject: [PATCH-for-9.1 v3 1/2] hw/i386/pc: Unify vmport=auto handling
Message-ID: <v8pz1uwgIYWkidgZK-o8H-qJvnSyl0641XVmNO43Qls307AA3QRPuad_py6xGe0JAxB6yDEe76oZ8tau_n-2Y6sJBCKzCujNbEUUFhd-ahI=@szczek.dev>
In-Reply-To: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
References: <IrhtgC0oPtusYG_0cOwVYOuOr0UpK0YLNYNtxDQ2_lqgtcVBzVr-gYNUzggvmO9tHdmf65aO8Zoab-ERkyQbtjx9u2VuHEYZ_3r0Wb25huw=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: ccb779ee013ecd9b32c017226fc10513d5934360
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.22; envelope-from=kamil@szczek.dev;
 helo=mail-4022.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The code which translates vmport=3Dauto to on/off is currently separate
for each PC machine variant, while being functionally equivalent.
This moves the translation into a shared initialization function, while
also tightening the enum assertion.

Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek.dev>
---
 hw/i386/pc.c      | 5 +++++
 hw/i386/pc_piix.c | 5 -----
 hw/i386/pc_q35.c  | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c74931d577..72229a24ff 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1217,6 +1217,11 @@ void pc_basic_device_init(struct PCMachineState *pcm=
s,
         isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
     }
=20
+    assert(pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX);
+    if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
+        pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
+    }
+
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport !=3D ON_OFF_AUTO_ON);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d9e69243b4..347afa4c37 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -310,11 +310,6 @@ static void pc_init1(MachineState *machine, const char=
 *pci_type)
=20
     pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
=20
-    assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
-    if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
-        pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
-    }
-
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9d108b194e..f2d8edfa84 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -276,11 +276,6 @@ static void pc_q35_init(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
=20
-    assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
-    if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
-        pcms->vmport =3D ON_OFF_AUTO_ON;
-    }
-
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_fl=
oppy,
                          0xff0104);
--=20
2.45.0



