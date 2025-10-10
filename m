Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1083FCCD187
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 10:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7AVd-0002vn-7M; Fri, 10 Oct 2025 06:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v7AVY-0002sL-OW; Fri, 10 Oct 2025 06:37:56 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v7AVN-0006sv-83; Fri, 10 Oct 2025 06:37:56 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59AAaVSS065199
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 19:36:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vDS3EWBEvsBwpNU5uZUE4XlgStIIxz7Om7dQPeWvjLw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1760092601; v=1;
 b=okM3fa5SDGPbx46F5zHyWJQQymjDUpjBlBn3t2QpeauAMKQAmdZiKxz2PlDowmmG
 1GyXrwQJ7R/cnI4fMoJakiWq8VdMryZATKJlGd+eXIzC0JKvlfl+5d65xtoq9vzV
 RaiQY1c1FyPA/IIOBeEH5SueNmRRdMCrEGq859rRwAyjxhlXEvsOXmDwmCayg7fA
 rNkHSz9YMm/rmO+GoZ0VOnHnaC2fpzhWGr83ud+p2YwODr5F8W0Lod3CJx0ZPCOO
 2Mpk9mhA2XxaVYx3Q7YliUekJPxJ3DTiS24x4rdqvlrCfrqveUOsWR1v6gftt6nk
 5W4id3gE1aYV3UHP/d84xw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 00/12] qdev: Automatically delete memory subregions
Date: Fri, 10 Oct 2025 19:35:28 +0900
Message-Id: <20251010-subregion-v2-0-435a472bc9cd@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHDh6GgC/22NQQ6CMBBFr0JmbZu2aBpceQ/DAtoBRhMKUyASw
 t2tuHDj8r38vL9BRCaMcM02YFwoUugTmFMGrqv6FgX5xGCUuahCWxHnmrFNK1Eo69BbX2n0kPY
 DY0Ovo3Uvv8w4zik5/WRHcQq8Hn+L/th/6UULJWpscuuL+tzY/MaxlY4kyVlM4bkGWTn5GKDc9
 /0N8I5nQ8QAAAA=
X-Change-ID: 20250917-subregion-907ced7da1ed
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
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This patch series was spun off from "[PATCH v2 00/15] Fix memory region
leaks and use-after-finalization":
https://lore.kernel.org/qemu-devel/20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp/

It is a common requirement of qdev to delete memory subregions to hide
them from address spaces during unrealization. pci automatically
deletes the IO subregions, but this process is manually implemented
in other places, which is tedious and error-prone.

Implement the logic to delete subregions in qdev to cover all devices.

Note that some code removed in this series to delete subregions are
apparently just unnecessary and can be removed without a change of qdev.
They are still included in this series and follows the qdev change since
removing them without the qdev change will cause regression if I fail to
distinguish necessary and unnecessary code.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Dropped patch "hw/pci-bridge: Do not assume immediate MemoryRegion
  finalization" as it was unnecessary as pointed out by Peter Xu.
- Dropped patch "[PATCH] vfio-user: Do not delete the subregion". It is
  a fix unlike the other patches so I submitted it separately.
- Expanded the patch message of "qdev: Automatically delete memory
  subregions" to explain that existing memory_region_del_subregion()
  calls in the device-specific code will be no-op.
- Link to v1: https://lore.kernel.org/qemu-devel/20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (12):
      qdev: Automatically delete memory subregions
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
 include/hw/qdev-core.h     |  1 +
 hw/char/diva-gsp.c         |  1 -
 hw/char/serial-pci-multi.c |  1 -
 hw/core/qdev.c             | 14 ++++++++++++++
 hw/display/vga-pci.c       |  8 --------
 hw/ide/cmd646.c            | 12 ------------
 hw/ide/piix.c              | 13 -------------
 hw/ide/via.c               | 12 ------------
 hw/nvme/ctrl.c             |  2 --
 hw/pci/pci.c               | 20 --------------------
 hw/ppc/spapr_pci.c         | 22 ----------------------
 hw/usb/hcd-ehci.c          |  4 ----
 hw/usb/hcd-xhci.c          | 10 ----------
 stubs/memory.c             |  9 +++++++++
 stubs/meson.build          |  1 +
 16 files changed, 26 insertions(+), 105 deletions(-)
---
base-commit: 94474a7733a57365d5a27efc28c05462e90e8944
change-id: 20250917-subregion-907ced7da1ed

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


