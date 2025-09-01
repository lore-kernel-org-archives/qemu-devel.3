Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F533CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxm0-0000vh-82; Mon, 01 Sep 2025 02:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlb-0000me-QI; Mon, 01 Sep 2025 02:11:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxlU-0002Yu-0q; Mon, 01 Sep 2025 02:11:47 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5816ACAX076640
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 15:10:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Jqr8P+bWn9/t6f+kXj3iAqWRCxcJIhzvpyYZplXrOeo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756707025; v=1;
 b=rss782Ak4QRV616rnZzznzDZ+KU1TyzWzJtyB347whZIJHUDP1UdBB+ptHsz7FAJ
 0CLMJ1Z2n4YNqKuH+664JZEMPV+i05L2PMBMT394cpHTi7fyeXqjC1ZVOu97jSea
 QMocdpjhM7j3ZHHdprv4tnZ9z8Gf7vthwZRUd179+CLQ0ivgEzZf1nxsdV2tQWqK
 aAmCTXzjd0SD5qWRlra8LPomKeqxQLd51WU9k9gmgrmLNDWECY4oI24XHwpjeDFG
 D/X7zDI3UEKk/19Or2pP1cWT2IvcArUG0TlyZBuJZY6eeA0MeifbljvPpwRxlmOK
 xVOWiNP9rgL922zfYmviqQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 01 Sep 2025 15:10:01 +0900
Subject: [PATCH 03/16] qdev: Automatically delete memory subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mr-v1-3-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
References: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
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

A common pattern is that to delete memory subregions during realization
error handling and unrealization. pci automatically automatically
deletes the IO subregions, but the pattern is manually implemented
in other places, which is tedious and error-prone.

Implement the logic to delete subregions in qdev to cover all devices.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/qdev-core.h |  2 ++
 hw/core/qdev.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 530f3da70218df59da72dc7a975dca8265600e00..c2582a4d59b38152a00d066351492c2e2ae0718f 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -226,6 +226,7 @@ typedef QLIST_HEAD(, BusState) BusStateHead;
 struct DeviceState {
     /* private: */
     Object parent_obj;
+
     /* public: */
 
     /**
@@ -526,6 +527,7 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
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

-- 
2.51.0


