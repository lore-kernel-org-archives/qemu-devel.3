Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C36CA1013
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 02:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuiRu-00043S-7B; Fri, 05 Sep 2025 22:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiRd-0003wZ-J6; Fri, 05 Sep 2025 22:14:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiRO-0006PE-FA; Fri, 05 Sep 2025 22:14:25 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862BtnV041566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:12:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=fp/49Htcu3bFrQ3I9AAANI36POmz44LdypKV4NzMOks=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1757124736; v=1;
 b=HSEinkOnDD9ic82KdilmWuOGMgUvH88twoJAPV3vpSUHd/UK6I8/MfmHKgRTKNah
 Osoc2XWWpFEV7QPaY47cqeX6CZhZ2Zv8aqzNoP2ByymZATm2m1Ce1KDAJEvHPP5A
 6DYhAp+AhBPOgvVK0TawbuVyrFhPcYHVxrubewoAvIsHRVGki+OzF4qda9JB5yeq
 Hd2HTB7uivngsJ2LzhXmAWV0TJWUWBb90Ew8pjKE4cYFoWnuER7B6brSOcBXeTjN
 Qoh+GbeiWvxED4TDwc65P6IzsdgUaspUFGcXeyHmZhufuHuzs0doPJZlkTqX6nnB
 MlQyypJHIZhAXVPQunDy/g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 00/22] Fix memory region leaks and use-after-finalization
Date: Sat, 06 Sep 2025 04:11:09 +0200
Message-Id: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2Yu2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMz3dLiVF1j89TkZEsD40TLVAMloMqCotS0zAqwKdGxtbUAKPJ67VU
 AAAA=
X-Change-ID: 20250906-use-37ecc903a9e0
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When developing the next version of "[PATCH 00/16] memory: Stop
piggybacking on memory region owners*", I faced multiple memory region
leaks and use-after-finalization. This series extracts their fixes so
that the number of Cc: won't explode.

Patch "qdev: Automatically delete memory subregions" and the succeeding
patches are for refactoring, but patch "vfio-user: Do not delete the
subregion" does fix use-after-finalization.

* https://lore.kernel.org/qemu-devel/20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp/

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (22):
      docs/devel: Do not unparent in instance_finalize()
      vfio/pci: Do not unparent in instance_finalize()
      hw/pci-bridge: Do not assume immediate MemoryRegion finalization
      target/mips: Fix AddressSpace exposure timing
      target/xtensa: Fix AddressSpace exposure timing
      auxbus: Fix AddressSpace exposure timing
      hw/pci-host/raven: Fix AddressSpace exposure timing
      sun4m: Fix AddressSpace exposure timing
      sun4u: Fix AddressSpace exposure timing
      qdev: Automatically delete memory subregions
      vfio-user: Do not delete the subregion
      hw/char/diva-gsp: Do not delete the subregion
      hw/char/serial-pci-multi: Do not delete the subregion
      secondary-vga: Do not delete the subregions
      cmd646: Do not delete the subregions
      hw/ide/piix: Do not delete the subregions
      hw/ide/via: Do not delete the subregions
      hw/nvme: Do not delete the subregion
      pci: Do not delete the subregions
      hw/ppc/spapr_pci: Do not delete the subregions
      hw/usb/hcd-ehci: Do not delete the subregions
      hw/usb/hcd-xhci: Do not delete the subregions

 MAINTAINERS                |  1 +
 docs/devel/memory.rst      | 19 +++------
 include/hw/pci/pci.h       |  1 +
 include/hw/qdev-core.h     |  1 +
 hw/char/diva-gsp.c         |  1 -
 hw/char/serial-pci-multi.c |  1 -
 hw/core/qdev.c             | 14 +++++++
 hw/display/vga-pci.c       |  8 ----
 hw/ide/cmd646.c            | 12 ------
 hw/ide/piix.c              | 13 -------
 hw/ide/via.c               | 12 ------
 hw/misc/auxbus.c           |  2 +-
 hw/nvme/ctrl.c             |  2 -
 hw/pci-host/raven.c        | 27 ++++++-------
 hw/pci/pci.c               | 22 +----------
 hw/pci/pci_bridge.c        | 96 +++++++++++++++++++++++++---------------------
 hw/ppc/spapr_pci.c         | 22 -----------
 hw/sparc/sun4m_iommu.c     |  9 ++++-
 hw/sparc64/sun4u_iommu.c   |  9 ++++-
 hw/usb/hcd-ehci.c          |  4 --
 hw/usb/hcd-xhci.c          | 10 -----
 hw/vfio-user/pci.c         |  6 ---
 hw/vfio/pci.c              |  4 --
 stubs/memory.c             |  9 +++++
 target/mips/cpu.c          |  9 ++++-
 target/xtensa/cpu.c        |  8 ++--
 stubs/meson.build          |  1 +
 27 files changed, 129 insertions(+), 194 deletions(-)
---
base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
change-id: 20250906-use-37ecc903a9e0

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


