Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3769CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxmC-0001DY-Ri; Mon, 01 Sep 2025 02:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlb-0000md-Qu; Mon, 01 Sep 2025 02:11:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlU-0002Yn-He; Mon, 01 Sep 2025 02:11:47 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5816ACAU076640
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 15:10:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Rte9kNYqlo5kvgMqXc5x5ukQ/m2csYorQsnbrvuIXSk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1756707024; v=1;
 b=bWkRDby3HdquQjKUi1UW4zrNKKIYTJh1hXlHevp2Mc7CiAjEBDlIrVg3TA7BZwd0
 9Em9SwlcKvaHqY4aBTHxTdRC+wSkJwRv+rcBAvW1ZobMjw5nEMa4d2HsBpEqJ7aR
 GnCSRy45diRbuoQYIMso1+HbHfGt2ed7G/fGSEtdgCIp/sbEOh3sjnDmAi3nnxvn
 xfUA676lOwYnRkyr+Hlg96ORdYoOjGL2kShvD0E3RIgRMXnFCol5cI6S8yx8wUk4
 eOOK9DXIff/jkDC3P100mTM0B8htTDOv/rSAQNAosW3qLfiqWyuOcFJBOJZPJY/8
 Wg+AkvfweKU/McnWD7m3bA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 00/16] memory: Stop piggybacking on memory region owners
Date: Mon, 01 Sep 2025 15:09:58 +0900
Message-Id: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALY4tWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC2ND3dwi3RSDlGQTS9OkxBRDQyWgwoKi1LTMCrAh0bG1tQAjO5rRVAA
 AAA==
X-Change-ID: 20250831-mr-d0dc495bad11
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
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
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

Supersedes: https://lore.kernel.org/qemu-devel/20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer errors")

MemoryRegions used to "piggyback" on their owners instead of using their
reference counters due to the circular dependencies between them, which
caused memory leak.

I tried to fix it with "[PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer
errors" but it resulted in a lengthy discussion; ultimately it is
attributed to the fact that "piggybacking" is hard to understand and
forces us design trade-offs. It was also insufficient because it only
deals with the container-subregion pattern and did not deal with DMA.

With this series, I remove the "piggyback" hack altogather.
The key insight here is that the owners explicitly call
memory_region_del_subregion() to stop accepting new accesses to
its MemoryRegions when they are no longer needed. I code the fact by 
calling object_unparent() along with it.

While I could write a function like memory_region_unparent() and replace
such memory_region_del_subregion() calls, I used a few other insights to
simplify the code:
- Deletable MemoryRegions are of hotpluggable devices.
- Devices do no longer accept new accesses after unrealization.

So I made the common qdev code call memory_region_del_subregion() and
object_unparent(). In the end, this series makes the code simpler and
semantically robust, and kills the entire class of memory leak.

Patch [1, 2] removes object_unparent() calls in instance_finalize(),
which are incorrect.

Patch 3 makes the qdev code automatically call
memory_region_del_subregion().

Patch [4, 15] removes memory_region_del_subregion() calls that are
obviously no longer needed, demonstrating the benefit of automatic
automatic subregion deletion.

Patch 16 adds the object_unparent() call and stop piggybacking.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (16):
      docs/devel: Do not unparent in instance_finalize
      vfio/pci: Do not unparent in instance_finalize
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
      vfio-user: Do not delete the subregion
      memory: Stop piggybacking on memory region owners

 MAINTAINERS                |  1 +
 docs/devel/memory.rst      | 45 +++++++++++++++++-----------------------
 include/hw/qdev-core.h     |  2 ++
 include/system/memory.h    | 51 +++++++++++++++++++++++-----------------------
 hw/char/diva-gsp.c         |  1 -
 hw/char/serial-pci-multi.c |  1 -
 hw/core/qdev.c             | 29 ++++++++++++++++++++++++++
 hw/display/vga-pci.c       |  8 --------
 hw/ide/cmd646.c            | 12 -----------
 hw/ide/piix.c              | 13 ------------
 hw/ide/via.c               | 12 -----------
 hw/nvme/ctrl.c             |  2 --
 hw/pci/pci.c               | 20 ------------------
 hw/ppc/spapr_pci.c         | 22 --------------------
 hw/usb/hcd-ehci.c          |  4 ----
 hw/usb/hcd-xhci.c          | 10 ---------
 hw/vfio-user/pci.c         |  6 ------
 hw/vfio/pci.c              |  4 ----
 stubs/memory.c             |  9 ++++++++
 system/memory.c            | 11 +++-------
 stubs/meson.build          |  1 +
 21 files changed, 89 insertions(+), 175 deletions(-)
---
base-commit: e101d33792530093fa0b0a6e5f43e4d8cfe4581e
change-id: 20250831-mr-d0dc495bad11

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


