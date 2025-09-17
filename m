Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918D1CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 10:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uypUh-0002Rb-Fk; Wed, 17 Sep 2025 06:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uypUP-0002HP-0G; Wed, 17 Sep 2025 06:34:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uypU4-0005ur-MF; Wed, 17 Sep 2025 06:34:09 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HAWmAY099616
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Sep 2025 19:32:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VRGEF2ly3qK0gu1IVUttjA0buRSsAPYB0GDOnSXM14c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1758105176; v=1;
 b=inSk6TudEMcsxo/y16lKSlJgCAnG1CVS4QrvLCCch9MaYYvtKKxtbLMJQWq+8nuP
 tA5E+vVCWW0/QDK9y3n3zMUZiZY3i9smh+J9ZcxOAVW9eQR52GpoKXk7wxQQXP9f
 DiKgtTCWKB9XRdt95QTx6HYmvVB/Gn6n5yopMZCWGpR58dzi+gxVvr93Shq0UCQ7
 XiXewgVdylOc2dClvDDd40pVLWoczUqklQvV8Yr/UYkCqZDdOqzmFnbLrgoWLndh
 eX9hYDLZHr4grN580FL52I3AUzZKAWaiEac1vRUavOVEQddF2L+0fa7E4dXuY8ck
 Lu75o9Xwos699qS+qJS7cg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 00/14] Fix memory region use-after-finalization
Date: Wed, 17 Sep 2025 19:32:46 +0900
Message-Id: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+OymgC/0XMQQ6DIBSE4asY1iV5iIh4lcYFwmhZqC2oaWK8e
 2lddPlPJt/BEmJAYm1xsIg9pLDMOcStYO5h5xE8+NyspFKREZqnrY8Y84sb0g5eeyvgWf4/I4b
 w/ln37uqI15bJ9Rr/YltcHtV8S+BSwzlD0hpQu8sv1tu8u2WawtoWECS8lNqUShIZOVjqydZQQ
 yVR+cYNqFQjwLrz/ABqluqP0gAAAA==
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

Based-on: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH v3 0/7] Do not unparent in instance_finalize()")

This patch series was spun off from "[PATCH v2 00/15] Fix memory region
leaks and use-after-finalization":
https://lore.kernel.org/qemu-devel/20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp/

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
Akihiko Odaki (14):
      hw/pci-bridge: Do not assume immediate MemoryRegion finalization
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
 include/hw/pci/pci.h       |  1 +
 include/hw/qdev-core.h     |  1 +
 hw/char/diva-gsp.c         |  1 -
 hw/char/serial-pci-multi.c |  1 -
 hw/core/qdev.c             | 14 +++++++
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
 stubs/memory.c             |  9 +++++
 stubs/meson.build          |  1 +
 19 files changed, 80 insertions(+), 156 deletions(-)
---
base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
change-id: 20250917-subregion-907ced7da1ed
prerequisite-change-id: 20250906-use-37ecc903a9e0:v3
prerequisite-patch-id: d464fda86a3c79ff8e6d7a2e623d979b2a47019b
prerequisite-patch-id: 17b153237f69c898b9c5b93aad0d5116d0bfe49f
prerequisite-patch-id: ac51d9c4ac483054ee91cecbb5575def67dbb602
prerequisite-patch-id: 205aa86c0ef087c97dbcf736062661a45c287bf3
prerequisite-patch-id: 26e18a249afaf9cd1b72961f9e2e3ebf97966a3c
prerequisite-patch-id: d3e0b87f84a216e05bd4aa3dee8ae77cf9df062a
prerequisite-patch-id: 510a59304274e1bc35f8fbe77c91fc2f32a2f087

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


