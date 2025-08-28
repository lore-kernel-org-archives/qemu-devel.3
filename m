Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C9CCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEa-0007Zu-Q2; Thu, 28 Aug 2025 13:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urdT8-0000en-LK; Thu, 28 Aug 2025 10:19:14 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urdT4-0005qI-Si; Thu, 28 Aug 2025 10:19:14 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57SEICLK097958
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 23:18:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7hINc+siy0L/C8+kFQTnrlvRNXJm/VGbmuKid1T4BLM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Subject:Date:Message-Id:To;
 s=rs20250326; t=1756390705; v=1;
 b=VEhczf7r2EaELgO4AH03u1MJ6S1nz5HTYF6751M4mpHkESN3bweNmmwDn1C7k6ts
 n3Gz/QI7sRsUp0aWz9XUPrWF/G6foRi45L2hrXxUv0p2vHtKCKCrWZ6MSPX+Wen6
 7xtQU020XRQqDRbJx/OYhvMognCf2IbY/xjZEPCo3gYzqovbqGadU8PIlKBRwMtl
 Bfud/OooXS5cIYqHS+CD8yz4FNnWZ5jFwUd0t24bPFWoBLySIj4XTQVH62pA1iKi
 8A5hg0u6dHXO+Pwg2lFhm6r5UbfJxeVVgjHCx8UOc/6H742L6nHoAGM0BgIWkSds
 8jsdjq4I1YI0o8M+dRx+IA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v9 0/2] Fix check-qtest-ppc64 sanitizer errors
Date: Thu, 28 Aug 2025 23:18:10 +0900
Message-Id: <20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACJlsGgC/2XQz2rDMAwG8FcpPi9DtuV/O+09xg62Yq8+LBnJC
 C0l7z41pjQjx0/o9yF0E3Oeap7F2+kmprzUuY4Dh/ByEnSOw1fuas9ZKFAIVplujkMHwcUSCxZ
 JSvDmz5RLvWwtH5+cz3X+HafrVrrI+/Th7eYX2UFXNBEqDUr68N7H61AvrzR+i3vBovbINaQYO
 QMpQUDbp/6A9BM58A1pRgl0sU4SAtkDwifySjeEjKJCsn2JSDkdkHkgAxKwIcPIJ9SAxvGJx/P
 sHrVHLpaRlIW8CSmE5A7I7VFoyDEKmlCr6Ph/eEB+hyQ05BkZF02UKctE5R9a1/UPtYx4wgoCA
 AA=
X-Change-ID: 20240625-san-097afaf4f1c2
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
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

I saw various sanitizer errors when running check-qtest-ppc64. While
I could just turn off sanitizers, I decided to tackle them this time.

Unfortunately, GLib versions older than 2.81.0 do not free test data in
some cases so some sanitizer errors remain. All sanitizer errors will be
gone with this patch series combined with the following change for GLib:
https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v9:
- Fixed a NULL pointer dereference.
- Link to v8: https://lore.kernel.org/r/20250110-san-v8-0-57a5a1be1bcf@daynix.com

Changes in v8:
- Clarified that the memory region should be passed to object_ref()
  when creating a reference internal to owner.
- Link to v7: https://lore.kernel.org/r/20250109-san-v7-0-93c432a73024@daynix.com

Changes in v7:
- Don't open code memory_region_ref(). (Peter Xu)
- Link to v6: https://lore.kernel.org/r/20250105-san-v6-0-11fc859b99b7@daynix.com

Changes in v6:
- Avoid referring owner as "the object that tracks the region's
  reference count".
- Noted that memroy_region_ref() and memroy_region_unref() do nothing
  if the owner is not present.
- Explicitly stated that memory_region_unref() may destroy the owner
  along with the memory region itself.
- Link to v5: https://lore.kernel.org/r/20250104-san-v5-0-8b430457b09d@daynix.com

Changes in v5:
- Rebased.
- Merged four patches to update inline documentation into one
- Link to v4: https://lore.kernel.org/r/20240823-san-v4-0-a24c6dfa4ceb@daynix.com

Changes in v4:
- Changed to create a reference to the subregion instead of its owner
  when its owner equals to the container's owner.
- Dropped R-b from patch "memory: Do not create circular reference with
  subregion".
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240708-san-v3-0-b03f671c40c6@daynix.com

Changes in v3:
- Added patch "memory: Clarify that we use owner's reference count".
- Added patch "memory: Refer to docs/devel/memory.rst for 'owner'".
- Fixed the message of patch
  "memory: Do not create circular reference with subregion".
- Dropped patch "cpu: Free cpu_ases" in favor of:
  https://lore.kernel.org/r/20240607115649.214622-7-salil.mehta@huawei.com/
  ("[PATCH V13 6/8] physmem: Add helper function to destroy CPU
  AddressSpace")
- Dropped patches "hw/ide: Convert macio ide_irq into GPIO line" and
  "hw/ide: Remove internal DMA qemu_irq" in favor of commit efb359346c7a
  ("hw/ide/macio: switch from using qemu_allocate_irq() to qdev input
  GPIOs")
- Dropped patch "hw/isa/vt82c686: Define a GPIO line between vt82c686
  and i8259" in favor of:
  https://patchew.org/QEMU/20240704205854.18537-1-shentey@gmail.com/
  ("[PATCH 0/3] Resolve vt82c686 and piix4 qemu_irq memory leaks")
- Dropped pulled patches.
- Link to v2: https://lore.kernel.org/r/20240627-san-v2-0-750bb0946dbd@daynix.com

Changes in v2:
- Rebased to "[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'".
  (Philippe Mathieu-Daudé)
- Converted IRQs into GPIO lines and removed one qemu_irq usage.
  (Peter Maydell)
- s/suppresses/fixes/ (Michael S. Tsirkin)
- Corrected title of patch "hw/virtio: Free vqs after vhost_dev_cleanup()"
  (was "hw/virtio: Free vqs before vhost_dev_cleanup()")
- Link to v1: https://lore.kernel.org/r/20240626-san-v1-0-f3cc42302189@daynix.com

---
Akihiko Odaki (2):
      memory: Update inline documentation
      memory: Do not create circular reference with subregion

 include/system/memory.h | 59 +++++++++++++++++++++++--------------------------
 system/memory.c         | 39 ++++++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 38 deletions(-)
---
base-commit: e5859141b9b6aec9e0a14dacedc9f02fe2f15844
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


