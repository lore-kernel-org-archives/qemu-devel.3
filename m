Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D2FCA1013
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 02:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuiSs-0004Qo-Hr; Fri, 05 Sep 2025 22:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiSe-0004JR-9i; Fri, 05 Sep 2025 22:15:33 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiSV-00070C-7j; Fri, 05 Sep 2025 22:15:26 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862Btnf041566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:14:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3y3lEmcLsExfyPyQNVoE1PMNFbkUoglqqUOlB+qqwB8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757124861; v=1;
 b=W0KNsFF4cTDuBm5v0uby09jrWUkmqmSW7rKzcfOpNBXLXLCs5pd4iaoS8DsMCHyv
 fAa5U+CYTIPvoaiW/26YOZBp+RKCjpEr6RpRaTUpRMCnV3UWMBXUqHtAhAjyvrqZ
 175VWkn7gCb9X2zeAFtYA6OmyjH3pIPIeH8JTqfP/2DBOAB9thlVHMmJqjsg9gVn
 AFDK1LjClpsqIeGlOGi+b1WUsJ4lHqam3RDE5SNMbj5PyfAQtz8D6QYHUWIoEa0R
 bre6Lz8RFg+RHfTNCt1Af+gyZbDJ/MZFNRTewrYTwejuAKMNmdQgrFm/M07zzzX5
 J3TLfZrJcy0Tkg5Vaa0rQg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 06 Sep 2025 04:11:19 +0200
Subject: [PATCH 10/22] qdev: Automatically delete memory subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-use-v1-10-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
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

A common pattern is that to delete memory subregions during realization
error handling and unrealization. pci automatically automatically
deletes the IO subregions, but the pattern is manually implemented
in other places, which is tedious and error-prone.

Implement the logic to delete subregions in qdev to cover all devices.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 MAINTAINERS            |  1 +
 include/hw/qdev-core.h |  1 +
 hw/core/qdev.c         | 14 ++++++++++++++
 stubs/memory.c         |  9 +++++++++
 stubs/meson.build      |  1 +
 5 files changed, 26 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8147fff3523eaa45c4a0d2c21d40b4ade3f419ff..4665f0a4b7a513c5863f6d5227a0173c836505e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3212,6 +3212,7 @@ F: include/system/memory.h
 F: include/system/ram_addr.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
+F: stubs/memory.c
 F: system/dma-helpers.c
 F: system/ioport.c
 F: system/memory.c
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 530f3da70218df59da72dc7a975dca8265600e00..8f443d5f8ea5f31d69181cc1ec53a0b022eb71cc 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -526,6 +526,7 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
  *  - unrealize any child buses by calling qbus_unrealize()
  *    (this will recursively unrealize any devices on those buses)
  *  - call the unrealize method of @dev
+ *  - remove @dev from memory
  *
  * The device can then be freed by causing its reference count to go
  * to zero.
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f600226176871361d7ff3875f5d06bd4e614be6e..8fdf6774f87ec8424348e8c9652dc4c99a2faeb5 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -451,6 +451,17 @@ static bool check_only_migratable(Object *obj, Error **errp)
     return true;
 }
 
+static int del_memory_region(Object *child, void *opaque)
+{
+    MemoryRegion *mr = (MemoryRegion *)object_dynamic_cast(child, TYPE_MEMORY_REGION);
+
+    if (mr && mr->container) {
+        memory_region_del_subregion(mr->container, mr);
+    }
+
+    return 0;
+}
+
 static void device_set_realized(Object *obj, bool value, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
@@ -582,6 +593,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (dc->unrealize) {
             dc->unrealize(dev);
         }
+        object_child_foreach(OBJECT(dev), del_memory_region, NULL);
         dev->pending_deleted_event = true;
         DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
     }
@@ -606,6 +618,8 @@ post_realize_fail:
     }
 
 fail:
+    object_child_foreach(OBJECT(dev), del_memory_region, NULL);
+
     error_propagate(errp, local_err);
     if (unattached_parent) {
         /*
diff --git a/stubs/memory.c b/stubs/memory.c
new file mode 100644
index 0000000000000000000000000000000000000000..9c36531ae542d804dc19ed2a3c657005881a2bca
--- /dev/null
+++ b/stubs/memory.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/memory.h"
+
+void memory_region_del_subregion(MemoryRegion *mr,
+                                 MemoryRegion *subregion)
+{
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e6854ddaa9f12714c317a541ea75b8d412..b4df4e60a1af89c9354d5b92449ce5409095b9f1 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -95,5 +95,6 @@ if have_system or have_user
 
   # Also included in have_system for tests/unit/test-qdev-global-props
   stub_ss.add(files('hotplug-stubs.c'))
+  stub_ss.add(files('memory.c'))
   stub_ss.add(files('sysbus.c'))
 endif

-- 
2.51.0


