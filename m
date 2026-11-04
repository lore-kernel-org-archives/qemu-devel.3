Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A11606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rqoqdvaS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOasm-0006zT-6m; Wed, 04 Nov 2026 08:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOasj-0006yU-RD
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:25 -0500
Received: from out-130.mta0.migadu.com ([2001:41d0:1004:224b::82]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOash-0002wX-I5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:25 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=q8rhVqp7dS323W8i5q45G4hGxidbIEKd0lVHKp1z56Q=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793798298; v=1; x=1794403098;
 b=rqoqdvaSj3BxI0pseP7Ts0AGCcyq8CxUR2twSmqJ6bGYEXbbKDjkxI05KWvT1XYt8X6B9USv
 4EGK1S43Y8FBmZTzdQVzOhA1p7ObakGGHnTVHDkomy76ENpriU4k9tzlHkCLU8qZee9NVJ5fx/j
 X3ow80ha/pPEHSef2oekfnto=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 99a2761450bdfb97;
 Wed, 04 Nov 2026 13:18:18 +0000
X-Mizu-Trace-ID: 99a2761450bdfb97
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 zhao1.liu@intel.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com, thuth@redhat.com,
 peter.maydell@linaro.org, kraxel@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, deller@gmx.de, clg@redhat.com,
 jamin_lin@aspeedtech.com, junjie.cao@linux.dev
Subject: [RFC PATCH 0/4] hw/i386: let -usb create qemu-xhci on new pc and q35
 machine types
Date: Wed,  4 Nov 2026 07:18:06 -0600
Message-ID: <20261104131810.2063834-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::82;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

-usb still gives the PIIX3 UHCI on pc and the ICH9 EHCI plus three
UHCI companions on q35. In May Peter asked whether -usb could give the
PC machines an xHCI on new machine versions and Gerd agreed [1].
Daniel's secure-devices series keeps UHCI/OHCI/EHCI in the
virtualization scope partly because -usb still creates them [2]; older
machine types keep doing so. From pc-i440fx-12.0 and pc-q35-12.0 on,
-usb creates qemu-xhci.

Patch 1 adds the 12.0 machine types so the rest has a version to hang
off; drop it once the real "hw: add compat machines for 12.0" lands.

Open question: where the controller sits. It takes 1d.0 on both
machines; patch 2 says why the PIIX3's own USB function is out. Slot
1d has no hardware meaning on i440fx. Alternatives: an interrupt-pin
property on qemu-xhci so 01.2 can use INTD like the UHCI, or an
automatic slot as spapr does for nec-usb-xhci, which shifts user
-device addresses on the new types by one slot. I prefer the fixed
slot.

Checked:

- SeaBIOS and OVMF (Ubuntu 24.04) drive the xHCI at 00:1d.0 and find
  the keyboard on both machines.
- Debian 12 under KVM: xhci_hcd at 1d.0, HID at 480 Mb/s, with MSI and
  with -global qemu-xhci.msi=off -global qemu-xhci.msix=off (INTx
  routed, IRQ 10 on pc and 16 on q35). pc-q35-11.2 unchanged: ehci-pci
  plus three uhci_hcd.
- pc-i440fx-11.2 and pc-q35-11.2 with -usb: a running Debian guest
  saved by master at d29412cca5 and loaded by this series keeps its
  USB devices and interrupts.
- check-qtest-x86_64 passes.

Windows 7 and earlier do not include an xHCI driver; usb.rst now says
to use an older machine type or -device piix3-usb-uhci for them.

Jamin's usbredir-server series turns auto-hub off on new machine
types [3]. With both, -usb on the new types gives four USB 2 root
ports and no automatic hub. The two series are independent; Jamin's
compat entries have to move to hw_compat_11_2 either way.

[1] https://lore.kernel.org/qemu-devel/agrz1zBDwGc9Bvlo@sirius.home.kraxel.org/
[2] https://lore.kernel.org/qemu-devel/20261029131241.2275706-29-berrange@redhat.com/
[3] https://lore.kernel.org/qemu-devel/20261102092201.1729245-1-jamin_lin@aspeedtech.com/

Junjie Cao (4):
  hw/i386: add 12.0 machine types (NOT FOR MERGE)
  hw/i386: let -usb create qemu-xhci on new pc and q35 machine types
  tests/qtest: check which host controller -usb creates on pc and q35
  docs/system/devices/usb: describe -usb after the qemu-xhci switch

 docs/system/devices/usb.rst       |  23 +++--
 hw/core/machine.c                 |   3 +
 hw/i386/Kconfig                   |   2 +
 hw/i386/pc.c                      |  21 +++++
 hw/i386/pc_piix.c                 |  24 +++++-
 hw/i386/pc_q35.c                  |  25 +++++-
 include/hw/core/boards.h          |   3 +
 include/hw/i386/pc.h              |   7 ++
 qemu-options.hx                   |   9 +-
 tests/qtest/meson.build           |   3 +
 tests/qtest/usb-pc-default-test.c | 135 ++++++++++++++++++++++++++++++
 11 files changed, 236 insertions(+), 19 deletions(-)
 create mode 100644 tests/qtest/usb-pc-default-test.c

-- 
2.43.0


