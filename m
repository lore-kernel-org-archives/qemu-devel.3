Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60F2CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6BD-0002iw-Jh; Mon, 15 Sep 2025 06:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6B9-0002hL-TW; Mon, 15 Sep 2025 06:11:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uy6B2-0006hu-PS; Mon, 15 Sep 2025 06:11:23 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58FA8uMD006344
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Sep 2025 19:08:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nsD5d6OPDnuvZuramUVkEmo0r3tVX99OGlg66wyt93Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1757930939; v=1;
 b=UHQJKOhfYoWbtvDEE3Y//NZhsjvx+aYuoCNVhxv5d/s0XJMuwBQC9mSLRPrrI3ei
 buZCIhvlIl9TKxznhgNhhVLOVDDDHCIpuPRVZsPE5BE2+FzZBMI4YYHUjBH15z9k
 gHuIMLJd2V42i0hHF3Ixw7DvCWh7aGpdwj5KgoYFRaO6NJ0XL0svQJhFOasl06k1
 sXzeXozB2umzxvWbw8XmSbBu0Pv1CYKHWX9wS97c6nfQSVk8IIGisEDo8Nr4aQ1k
 eiEJRQ8vvcqdlnCxFD/k1m8t79c4dOtYUxP+39vStgcYghzqvPrOp0tMEmcR1wx2
 uEJaB5yaCP5+TYnKlSm+kA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 00/15] Fix memory region leaks and
 use-after-finalization
Date: Mon, 15 Sep 2025 19:08:41 +0900
Message-Id: <20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnlx2gC/1WMQQ6DIBBFr2JmXQhgrKGr3qNxQcdRp03EgJIaw
 91L3XX5fv57B0QKTBFu1QGBEkf2cwFzqQAnN48kuC8MRplGWXUVWyRRt4RoVe0sKSjPJdDAn7P
 y6ApPHFcf9jOa9G/995MWSmCj0bmh1/Rs7yGOElmy3MTq37uXDuVrgS7n/AWXOtJRowAAAA==
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
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Based-on: <cover.1751493467.git.balaton@eik.bme.hu>
("[PATCH v2 00/14] hw/pci-host/raven clean ups")

Supersedes: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
("[PATCH] docs/devel: Prohibit calling object_unparent() for memory region")

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
Changes in v2:
- Added a reference to "[PATCH] docs/devel: Prohibit calling
  object_unparent() for memory region", which does something similar to
  patch "docs/devel: Do not unparent in instance_finalize()" but I
  forgot I sent it in the past.
- Fixed a typo in patch
  "docs/devel: Do not unparent in instance_finalize()" and
  "[PATCH 02/22] vfio/pci: Do not unparent in instance_finalize()".
- Dropped patches to move address_space_init() calls; I intend to
  QOM-ify to fix memory leaks automatically as discussed in the
  following thread:
  https://lore.kernel.org/qemu-devel/cd21698f-db77-eb75-6966-d559fdcab835@eik.bme.hu/
  But the QOM-ification will be big so I'll send it as a separate
  series.
- Rebased on top of "[PATCH v2 00/14] hw/pci-host/raven clean ups".
  https://lore.kernel.org/qemu-devel/cover.1751493467.git.balaton@eik.bme.hu/
- Link to v1: https://lore.kernel.org/qemu-devel/20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (15):
      docs/devel: Do not unparent in instance_finalize()
      vfio/pci: Do not unparent in instance_finalize()
      hw/pci-bridge: Do not assume immediate MemoryRegion finalization
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

 docs/devel/memory.rst      | 19 +++------
 include/hw/pci/pci.h       |  1 +
 hw/char/diva-gsp.c         |  1 -
 hw/char/serial-pci-multi.c |  1 -
 hw/display/vga-pci.c       |  8 ----
 hw/ide/cmd646.c            | 12 ------
 hw/ide/piix.c              | 13 -------
 hw/ide/via.c               | 12 ------
 hw/nvme/ctrl.c             |  2 -
 hw/pci/pci.c               | 22 +----------
 hw/pci/pci_bridge.c        | 96 +++++++++++++++++++++++++---------------------
 hw/ppc/spapr_pci.c         | 22 -----------
 hw/usb/hcd-ehci.c          |  4 --
 hw/usb/hcd-xhci.c          | 10 -----
 hw/vfio-user/pci.c         |  6 ---
 hw/vfio/pci.c              |  4 --
 16 files changed, 60 insertions(+), 173 deletions(-)
---
base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
change-id: 20250906-use-37ecc903a9e0

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


