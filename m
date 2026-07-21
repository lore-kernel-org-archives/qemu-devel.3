Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DF5C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5hB-0001Qf-LN; Tue, 21 Jul 2026 04:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5h9-0001FX-7Y; Tue, 21 Jul 2026 04:19:19 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wm5h5-0001Zg-Nz; Tue, 21 Jul 2026 04:19:18 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66L8GsBj050170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 21 Jul 2026 17:17:30 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QUBJRRaBwI6YuxGcgOV5El7ScpP8jVakZ+A2xhA0+Mk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784621851; v=1;
 b=Glq243S84ANSirhEeOPefno4HFiAfL14/oucGZHmdrdOp7Vb/5fO4NQck7xe3paV
 liGqdEYNzME6RbJ7jC9BFtZ5Ef8GAZfwjFEwFC3PpNIrUsjOeAxBBmPsRu6K8z1q
 BokCQDV+oT+lqS1pPmTiBqOq7tLvsYw0v+y43OTvMdgROsUwIvSHjbC7pzGBjWFT
 Cqmrm71czxz8nVv0gD8qHN4atsvWpketN6OTbK6oT2VRpEpIJBiuetnHzY83xZ83
 dNxqnfVBm7Y4bQvl8QviwjUWXCDiaG49YdO7kydY/zG1FIXIHvP30Gshm9Fgphg7
 ZXQ3/YlvrXpN17LytzLmaA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH for-11.2 v3 00/15] qdev: Clarify and enforce the device
 realization lifecycle
Date: Tue, 21 Jul 2026 17:16:50 +0900
Message-Id: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ6DIBRF0a2YPy4EMKJ21H00HSh8lDYRC5bUG
 PdeQu2ww5f7cjYI6C0GOBcbeIw2WDelUZ4KUGM3DUisThsEExVrmSRPjZG0WKm+Vkwa00G6zh6
 NfWfmCsZ5wjkVcEtltGFxfs1+5LkfVPOlIiecaCNKaWqFVa8vPgxUWWrpiyzusTraKXqfsxbFT
 5BMivYQRBIapblue2S6+S/s+/4BcGm8t/EAAAA=
X-Change-ID: 20250906-qdev-9e5cb7c06ffa
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4820;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=BN/eXHnD1VZPxPM3nwjmCEIhG7t4WXjySTU6vcs5GgU=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1a8NkuO2sSMNex5htuVtp2Peq21XEtvTtXL285FEu/NA
 3O+NFd2lLIwiHExyIopsqQU7ebWiK79VJgQ3wIzh5UJZAgDF6cATOTka0aGnwc2l++++GW1AePB
 S4eWRrX2xW2o5z14/8B5YcXTtXNSJjD8Uws7llTM9u5XbM0KvosbAneW5auvzf0WrcjuV7c5Wns
 pHwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qdev currently represents a device's realization state with a single
boolean. This cannot distinguish a device that has never been realized
from one whose realization has failed or that has been unrealized, nor
can it represent realization in progress. Consequently, the same device
can enter DeviceClass::realize() reentrantly or more than once.
Supporting that complicates device implementations, and the behavior is
untested and likely broken.

This series first clarifies the division of work between
TypeInfo.instance_init, pre-realize property setting, and
DeviceClass::realize, including the implications of device introspection
and property-dependent child creation.

The remaining direct reads of DeviceState::realized are then converted
to qdev_is_realized(). Keeping users behind this accessor allows the
underlying lifecycle representation to change without exposing it; the
accessor is also made const so callers with a const DeviceState can use
it.

Before changing that representation, the series fixes an existing
qdev invariant. qdev_realize() can attach an unparented device to a
bus before giving it a QOM parent. A failure between those operations
leaves a bus child that object_unparent() cannot remove, causing
bus_unparent() to loop indefinitely. qdev_realize() now establishes
the QOM parent before attaching the device to its bus and rolls the
parent back on failure.

Finally, DeviceState::realized and the QOM realized property are
replaced with four explicit phases: initialized, realizing, realized,
and retired.
Entering the realizing phase before invoking callbacks prevents
reentrant realization. A failure after realization starts, or the start
of unrealization, moves the device to the terminal retired phase, so a
device's realize method is invoked at most once.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v3:
- Ensured devices are QOM-parented before attaching them to a bus,
  avoiding unparentable bus children when realization fails.
- Clarified property-dependent child creation.
- Removed documentation references to the QOM realized property.
- Replaced DeviceState::realized and the QOM realized property with
  device phases. The realizing phase prevents reentrant realization, and
  the terminal retired phase prevents another attempt after realization
  fails or unrealization begins.
- Link to v2: https://lore.kernel.org/qemu-devel/20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp

Changes in v2:
- Clarified the ordering of #TypeInfo.instance_init, pre-realize
  property setting, and realization.
- Clarified that #TypeInfo.instance_init is for per-instance properties,
  not class properties.
- Link to v1: https://lore.kernel.org/qemu-devel/20250908-qdev-v1-1-df236f7ce5bd@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (15):
      qdev: Clarify instantiation and realization
      qdev: Make qdev_is_realized() take a const DeviceState *
      hw/hyperv/balloon: Use qdev_is_realized()
      hw/intc/apic: Use qdev_is_realized()
      hw/mem/memory-device: Use qdev_is_realized()
      hw/mem/pc-dimm: Use qdev_is_realized()
      hw/nvram: Use qdev_is_realized()
      hw/ppc/pnv_xscom: Use qdev_is_realized()
      hw/vfio: Use qdev_is_realized()
      hw/virtio/virtio-mem: Use qdev_is_realized()
      hw/virtio/virtio-qmp: Use qdev_is_realized()
      target/i386/cpu: Use qdev_is_realized()
      target/s390x: Use qdev_is_realized()
      hw/qdev: Parent device before setting parent bus
      hw/qdev: Prevent devices from being realized more than once

 qapi/common.json           |  19 ++++++
 include/hw/core/qdev.h     |  62 ++++++++++---------
 hw/core/qdev-clock.c       |   4 +-
 hw/core/qdev-properties.c  |   4 +-
 hw/core/qdev.c             | 147 ++++++++++++++++++++++++++++-----------------
 hw/hyperv/hv-balloon.c     |   2 +-
 hw/intc/apic_common.c      |   2 +-
 hw/mem/memory-device.c     |   4 +-
 hw/mem/pc-dimm.c           |   2 +-
 hw/nvram/xlnx-bbram.c      |   2 +-
 hw/nvram/xlnx-efuse.c      |   2 +-
 hw/ppc/pnv_xscom.c         |   2 +-
 hw/scsi/scsi-bus.c         |   4 +-
 hw/vfio/container-legacy.c |   4 +-
 hw/vfio/device.c           |   4 +-
 hw/vfio/iommufd.c          |   2 +-
 hw/virtio/virtio-mem.c     |   4 +-
 hw/virtio/virtio-qmp.c     |   4 +-
 qom/qom-qmp-cmds.c         |   2 +-
 system/qdev-monitor.c      |   5 +-
 target/i386/cpu.c          |   2 +-
 target/s390x/cpu_models.c  |   4 +-
 tests/unit/test-qdev.c     | 125 +++++++++++++++++++++++++++++++++++++-
 23 files changed, 301 insertions(+), 111 deletions(-)
---
base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
change-id: 20250906-qdev-9e5cb7c06ffa

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


