Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76070CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 10:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruUoC-0007II-SG; Wed, 10 Apr 2024 06:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ruUoB-0007I0-Nd
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 06:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ruUoA-0005EU-2P
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 06:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712743436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYQeA+wWYtJQ0eyYnnv+4qhKcpC9BVa2JlqlKNbRL3U=;
 b=B9Zo0lF2GiE+zM+GU34j5e3UT0IjSt0LzHdEz9eL56Wzh95ap9wyohhU01lToxOwe5ChwC
 44v1bUc6MQFPBhRDg3UFou/jxLVyzgsxrEnZGjy0MZZZFfSJDtGPeY+92wpQVN7D/v1Cgx
 bR1jOA/KdDeNQ5jqiqUu2a36MnlfImI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-JNGWog0ZPIq90kljcBcMdw-1; Wed,
 10 Apr 2024 06:03:55 -0400
X-MC-Unique: JNGWog0ZPIq90kljcBcMdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F294E29ABA0D;
 Wed, 10 Apr 2024 10:03:54 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.192.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B148C04227;
 Wed, 10 Apr 2024 10:03:53 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Subject: [RFC 1/2] iova_tree: add an id member to DMAMap
Date: Wed, 10 Apr 2024 12:03:44 +0200
Message-ID: <20240410100345.389462-2-eperezma@redhat.com>
In-Reply-To: <20240410100345.389462-1-eperezma@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

IOVA tree is also used to track the mappings of virtio-net shadow
virtqueue.  This mappings may not match with the GPA->HVA ones.

This causes a problem when overlapped regions (different GPA but same
translated HVA) exists in the tree, as looking them by HVA will return
them twice.  To solve this, create an id member so we can assign unique
identifiers (GPA) to the maps.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/qemu/iova-tree.h | 5 +++--
 util/iova-tree.c         | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 2a10a7052e..34ee230e7d 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -36,6 +36,7 @@ typedef struct DMAMap {
     hwaddr iova;
     hwaddr translated_addr;
     hwaddr size;                /* Inclusive */
+    uint64_t id;
     IOMMUAccessFlags perm;
 } QEMU_PACKED DMAMap;
 typedef gboolean (*iova_tree_iterator)(DMAMap *map);
@@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
  * @map: the mapping to search
  *
  * Search for a mapping in the iova tree that translated_addr overlaps with the
- * mapping range specified.  Only the first found mapping will be
- * returned.
+ * mapping range specified and map->id is equal.  Only the first found
+ * mapping will be returned.
  *
  * Return: DMAMap pointer if found, or NULL if not found.  Note that
  * the returned DMAMap pointer is maintained internally.  User should
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 536789797e..0863e0a3b8 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
 
     needle = args->needle;
     if (map->translated_addr + map->size < needle->translated_addr ||
-        needle->translated_addr + needle->size < map->translated_addr) {
+        needle->translated_addr + needle->size < map->translated_addr ||
+        needle->id != map->id) {
         return false;
     }
 
-- 
2.44.0


