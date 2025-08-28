Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DF0C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIh-00089Y-US; Thu, 28 Aug 2025 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urdTL-0000kL-35; Thu, 28 Aug 2025 10:19:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urdTE-0005se-7w; Thu, 28 Aug 2025 10:19:26 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57SEICLM097958
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 23:18:25 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=qnvNBRk/k2ji9GR/TCV7p/ZPIyvw3f4h7mAHQM6jeUk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756390705; v=1;
 b=jKY5colu/UHyKHD0tI50oy0BBtD12tbYfBlvM9ieVxW75UjXGP5efpOZVeibmCpn
 +OpgjTgeU41IoV0JH1mDcouNL1ND4JRLUk1Jdlwo6Xm2/yNlm6znKw7o1Meo6Olf
 DjZpwqaVFZbdopOJvq9iPhWSvDHb0XSD3Li1KVGxcqXO+wNFGPbG8cY8OPzvSdhH
 dgH4HTgml2YsQcyWY98R2I0RWrGQWbGEQ0CoyDkmrnFX0zONWOeNU14g8HJi4/Jp
 0cCQP8A5iCKU7lTlT73/aYlZZIzbHVrMR2o2pHdafLIenkJG0tZ4ArGIj8GpHmDX
 Kul6c/9z0fT0PumAUNZ+YQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 Aug 2025 23:18:12 +0900
Subject: [PATCH v9 2/2] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-san-v9-2-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
References: <20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250828-san-v9-0-c0dff4b8a487@rsg.ci.i.u-tokyo.ac.jp>
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

memory_region_update_container_subregions() used to call
memory_region_ref(), which creates a reference to the owner of the
subregion, on behalf of the owner of the container. This results in a
circular reference if the subregion and container have the same owner.

memory_region_ref() creates a reference to the owner instead of the
memory region to match the lifetime of the owner and memory region. We
do not need such a hack if the subregion and container have the same
owner because the owner will be alive as long as the container is.
Therefore, create a reference to the subregion itself instead ot its
owner in such a case; the reference to the subregion is still necessary
to ensure that the subregion gets finalized after the container.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 system/memory.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 56465479406f4a264bfe13e6a2bc7d9b6565410f..1f4111fc24f5a8dda9ee8c277f68f839f5277906 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1848,6 +1848,31 @@ void memory_region_unref(MemoryRegion *mr)
     }
 }
 
+static void memory_region_ref_subregion(MemoryRegion *mr,
+                                        MemoryRegion *subregion)
+{
+    subregion->container = mr;
+
+    if (mr->owner == subregion->owner) {
+        object_ref(OBJECT(subregion));
+    } else {
+        memory_region_ref(subregion);
+    }
+}
+
+static void memory_region_unref_subregion(MemoryRegion *subregion)
+{
+    MemoryRegion *mr = subregion->container;
+
+    subregion->container = NULL;
+
+    if (mr->owner == subregion->owner) {
+        object_unref(OBJECT(subregion));
+     } else {
+        memory_region_unref(subregion);
+     }
+}
+
 uint64_t memory_region_size(MemoryRegion *mr)
 {
     if (int128_eq(mr->size, int128_2_64())) {
@@ -2618,14 +2643,15 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     memory_region_transaction_commit();
 }
 
-static void memory_region_update_container_subregions(MemoryRegion *subregion)
+static void memory_region_update_container_subregions(MemoryRegion *mr,
+                                                      MemoryRegion *subregion)
 {
-    MemoryRegion *mr = subregion->container;
     MemoryRegion *other;
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    memory_region_ref_subregion(mr, subregion);
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2645,12 +2671,11 @@ static void memory_region_add_subregion_common(MemoryRegion *mr,
     MemoryRegion *alias;
 
     assert(!subregion->container);
-    subregion->container = mr;
     for (alias = subregion->alias; alias; alias = alias->alias) {
         alias->mapped_via_alias++;
     }
     subregion->addr = offset;
-    memory_region_update_container_subregions(subregion);
+    memory_region_update_container_subregions(mr, subregion);
 }
 
 void memory_region_add_subregion(MemoryRegion *mr,
@@ -2677,13 +2702,13 @@ void memory_region_del_subregion(MemoryRegion *mr,
 
     memory_region_transaction_begin();
     assert(subregion->container == mr);
-    subregion->container = NULL;
     for (alias = subregion->alias; alias; alias = alias->alias) {
         alias->mapped_via_alias--;
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+    memory_region_unref_subregion(subregion);
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.51.0


