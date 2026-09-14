Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0E7C88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x634p-0000oP-Pu; Mon, 14 Sep 2026 05:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634T-0000i1-Ma; Mon, 14 Sep 2026 05:33:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x634M-0000S2-SQ; Mon, 14 Sep 2026 05:33:51 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9WXEV020350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:32:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=AeO2yJog3gjS3iZDZPZIJ4JDg07yQG1oqIqSnGSE0KQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378358; v=1;
 b=IJzkcPl5KV7GfoYpXn7bZLcMtOFU3ORxmxcmCIJcLdLfgdSydSMjDu25KFwI0vKl
 3k/ahBLZfzzfRqmLDj3gNW3S4iWoHsQyCFloRki6hjs3mVhnl8HUCVKQIf6ud77N
 u3Lp7GF13hf5u8QoRsTZRlSFKyMz4Au9R0lee1i1oDuHyxI/CE1HoxN54AO+Z0DV
 APUSXTPbx09sr4EMTwfGypnp7/AvasMvaeYm5l/6aSbS70UaIfntfVDNusJoljEq
 kODHPyxluizoOZqvmy00Y9iKdjciGs1aX/CoyERm3LSxENSU9FlvNvnG+W7HWKGG
 Jv1YcZhegpK6ktSBNDub7A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 0/4] qdev: Clarify and enforce the device realization
 lifecycle
Date: Mon, 14 Sep 2026 18:31:48 +0900
Message-Id: <20260914-qdev-v4-0-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33MSw7CIBSF4a0YxkIut5a2jtyHcdDCRdFEKlRi0
 3Tv4iuOdPifnHwTixQcRbZeTCxQctH5c47VcsH0oT3viTuTmyFgCQ0ofjGUeEOl7ioNytqW5Ws
 fyLrbk9nuch9cHHwYn2qSj/UD1C8gSS65sVgoW2kqO7MJcS+0E05c+eBPoxetFseePbSEH0GBw
 uYtYBZqbaRpOgJT/xeKr1ChfAsFB26QEJVtAZB+CvM83wH8lvKXKQEAAA==
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=OyFvKR47TPy/Co1fUGcJQdc9St9ACLq4hBtYx1r2OTA=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9by/SpJVwqPh7MorNMzbX41P6qC9RnTmWW9K6ecZ2R6f
 YdzmVZ+RykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwES4ghn+2ac6Lrq3efrkiNNr
 px2f2fs6a++ENf/4eRSfskXWimwK42b4p2l8fO3ZpHOLkvzWy1oL2FyYKWxemmXgaPC5ncHg9ao
 OBgA=
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

The accessor conversions, const qualification of qdev_is_realized(), and
QOM-parenting fix from earlier revisions have already been merged. This
revision contains the four remaining patches.

The first patch clarifies the division of work between
TypeInfo.instance_init, pre-realize property setting, and
DeviceClass::realize, including the implications of device introspection
and property-dependent child creation.

The other three patches replace DeviceState::realized and the QOM
realized property with four explicit phases: initialized, realizing,
realized, and retired. Entering the realizing phase before invoking
callbacks prevents reentrant realization. A failure after realization
starts, or the start of unrealization, moves the device to the terminal
retired phase, so a device's realize method is invoked at most once.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v4:
- Dropped the merged accessor conversions, const qualification, and
  QOM-parenting fix.
- Split the phase conversion into three patches.
- Clarified automatic child-bus realization and explicit child-device
  realization, and removed the obsolete plan for recursive realization
  propagation.
- Documented that properties added during realization are neither
  configurable nor introspectable beforehand.
- Initialized DeviceState::phase explicitly.
- Updated the DevicePhase introduction version to 11.2.
- Link to v3: https://lore.kernel.org/qemu-devel/20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp

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
Akihiko Odaki (4):
      qdev: Clarify instantiation and realization
      hw/qdev: Introduce DevicePhase
      hw/qdev: Introduce the initialized and retired phases
      hw/qdev: Introduce the realizing phase

 qapi/common.json          |  19 ++++++++
 include/hw/core/qdev.h    |  50 ++++++++++-----------
 hw/core/qdev-clock.c      |   4 +-
 hw/core/qdev-properties.c |   4 +-
 hw/core/qdev.c            |  99 ++++++++++++++++++++++++++--------------
 hw/scsi/scsi-bus.c        |   4 +-
 qom/qom-qmp-cmds.c        |   2 +-
 system/qdev-monitor.c     |   5 ++-
 tests/unit/test-qdev.c    | 112 +++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 231 insertions(+), 68 deletions(-)
---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20250906-qdev-9e5cb7c06ffa

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


