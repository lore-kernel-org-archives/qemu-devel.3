Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07870C982D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7JkO-0007wI-5m; Thu, 17 Sep 2026 17:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7JkI-0007ve-AA; Thu, 17 Sep 2026 17:34:18 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7JkG-0005ue-7K; Thu, 17 Sep 2026 17:34:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B17DE40573;
 Thu, 17 Sep 2026 21:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B956C1F000FF;
 Thu, 17 Sep 2026 21:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789680846;
 bh=i/0cqO8UqS8eRoD1xdlKmZEHVdHPRqmOb5LU+qsppiQ=;
 h=From:To:Cc:Subject:Date;
 b=IeRNG2TfVqefAXD2+Fmlme3yz7wsIDczYru36c3AW/0+L+khdIiK8W9wK0Z3Qv0YH
 SL0P0xPq866u2IqjEUGxAMGakYUaz08NCoiw11evkzU5H7P7KFZM7+HOy7O71wCVKF
 spEAwyUAbHax/c7wvhKZsrsHSwyCAzAQol6FexOiqcv4Vokd+JJh7w+9ZgyVdNxu90
 bajmga35JKa4VGBL8Cjf7Fhpou6gPxfMhKL5SxEASkvx0qv7PgKK3tLlpOeMAN9cs4
 FdLH7Fakjkwa+SWxnRPfvgbJGRS65ORhohM2tbaENtz2BQ5+2NsQO+azGMto3ODIgg
 vBlHjH2PU1Znw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Helge Deller <deller@gmx.de>, John Snow <jsnow@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>,
 qemu-block@nongnu.org
Subject: [PATCH 0/7] NS 87560 SuperIO chip
Date: Thu, 17 Sep 2026 23:33:53 +0200
Message-ID: <20260917213402.3127-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

This series adds the emulation of a "NS 87560 SuperIO chip".
The SuperIO chip includes a floppy controller, two serial ports, one parallel
port, an IDE controller and one OHCI USB port.

This National Semiconductor SuperIO chip was commonly used in many HP PA-RISC
B- and C-class workstations, as in the HP C3700 machine which is being
emulated by QEMU already. The last patch wires up this SuperIO driver to the
existing C3700 machine emulation.

This driver was developed during the last few months by Abizer Lokhandwala
<abizerlokhandwalastd10@gmail.com> and mentored and reviewed by me.
Originally Abizer applied for the SCSI TAPE emulation program which I offered
for the Google-Summer-of-Code 2026 program, but since the TAPE project was
dropped by Google, he instead stepped up to develop this driver - even without
receiving sponsoring by Google.
So, I'm very grateful that he nevertheless invested his spare time to develop
this driver!

I've already reviewed the patches off-list, but it would be great if
other people could review the code as well.

Helge

Abizer Lokhandwala (6):
  hw/isa/pc87560: Add main isa code for NS 87560 SuperIO chip
  hw/ide/pc87560-ide: Add IDE emulation of NS 87560 SuperIO chip
  hw/usb/hcd-ohci: Add big endian and consistency check support
  hw/usb/pc87560-ohci: Add USB OHCI emulation of NS 87560 SuperIO chip
  hw/pc87560: Wire up emulation of NS 87560 SuperIO chip
  hw/hppa: Add NS 87560 SuperIO chip to HP C3700 machine

Helge Deller (1):
  hw/pci/pci_ids: Add PCI vendor ID and IDs for NS chips

 MAINTAINERS              |   4 +
 hw/hppa/machine.c        |  41 +++-
 hw/ide/meson.build       |   1 +
 hw/ide/pc87560-ide.c     | 358 +++++++++++++++++++++++++++
 hw/ide/trace-events      |   4 +
 hw/isa/Kconfig           |  11 +
 hw/isa/meson.build       |   1 +
 hw/isa/pc87560.c         | 510 +++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ohci.c        |  35 +++
 hw/usb/hcd-ohci.h        |   5 +
 hw/usb/meson.build       |   1 +
 hw/usb/pc87560-ohci.c    | 355 +++++++++++++++++++++++++++
 include/hw/isa/pc87560.h |  96 ++++++++
 include/hw/pci/pci_ids.h |   5 +
 14 files changed, 1420 insertions(+), 7 deletions(-)
 create mode 100644 hw/ide/pc87560-ide.c
 create mode 100644 hw/isa/pc87560.c
 create mode 100644 hw/usb/pc87560-ohci.c
 create mode 100644 include/hw/isa/pc87560.h

-- 
2.54.0


