Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6BCCD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8Oe-0002sS-Po; Thu, 04 Jun 2026 09:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8O1-0001ei-Vw
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wV8Nx-0000lv-S1
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780580725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aH6Eqk16uEEVgv59pgvAwDG2vlInhXcrzcoLd+raoTs=;
 b=ROrHLvCoW0CpIAImftiYXLU0XsqWfk9JUo9YPhOFr2uecanEvVSZoJJQ1xwfTzj/5yvPRE
 13/Qta/tULBmdGDqIkuQE09vs7YXstiQfHszEwaQlg1kzd/FL3qxpmva32MeCq/2+CZ9qi
 eklYZ86iOmAsV7MyRr8yVj25W+zglkA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-SMMecOxFN9Cyl8NUcN-big-1; Thu,
 04 Jun 2026 09:45:23 -0400
X-MC-Unique: SMMecOxFN9Cyl8NUcN-big-1
X-Mimecast-MFC-AGG-ID: SMMecOxFN9Cyl8NUcN-big_1780580722
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B1CF19560AF; Thu,  4 Jun 2026 13:45:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E4AF195608E; Thu,  4 Jun 2026 13:45:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:55 +0400
Subject: [PATCH v5 09/12] system/memory: add RamDiscardManager reference
 counting and cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-9-5768e6a0943d@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
In-Reply-To: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2561;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xibSwiLSpvPuooM/HvA6wtCkxyx7qnL4hNrMlkAzRkA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYExpKbg/LwepGCYR9pYZ3/BEmPej2pbcVndO
 mQaZhcwNLuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMQAKCRDa6OEJdZac
 5W+5D/47xePRGJNbZvGYkwXmXgP0LZbMiUUhMv2DI+QEsRdpF7wOIA5clZ51zIN808rcijNf2yW
 XQsNfnrzJ4nsSZh2MQKJ5eQmL4h2D0KqIgLyHHX1Og+bthiXns7vbefF3daipOOQl52+DtEG3rz
 MZmkhjwnNKXQ+Ckz9HfDnZxdoO/wmyjrbM6DfQlGuUzgIYaDYWJXuH1BNlKUG+r23c4/hFt7uwH
 U3M0JWTeuqArKobCd7z+kTfn+BSa9ucotKNXW7ugSG3UmGsTQnhjXeQre0oHAp9FuWE6fj/9ISA
 h6C+s5s00KJCmhrP+98roNSCnBZwUUNSHM3dJnodTvO5oNciRBXMcwFZNEaU1HzAjPKc6ByB1Ve
 vEA37D4yYw0N7ItCcf9gPivAdvQ3v6+FxVP2ocs/amrlvu6ocCCfOX/AHQhcTj2lj2Txy+lyRzb
 1yCQ/ByUGixYict5RAcNYVzjGVc4CXrm/kPKHCnREqFnBr8CgLNWEmR1/w6JjbA78LRD9Iwa771
 CAHY1TCaBNuTYePrV1x5gZz8tG3KggN4gf+AB96ULI8X3ewK+1D++eYup0mTgKS4jInRDAQt3G3
 ShnsdBQb6qgPsctZIkQXMbz/yGAyNa1DE27cuQxu1AUUwAK+OM45cKfrOgbF7pzFBYBvur4tQ1l
 IvPTyGf4HWkc6kQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Listeners now hold a reference to the RamDiscardManager, ensuring it
stays alive while listeners are registered. The RDM is eagerly freed
when the last source and listener are removed, and also unreffed during
MemoryRegion finalization as a safety net.

This completes the TODO left in the previous commit and prevents both
use-after-free and memory leaks of the RamDiscardManager.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c              | 14 +++++++++++---
 system/ram-discard-manager.c |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 7c75eef1cec..ee1a1a1cd53 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1755,6 +1755,7 @@ static void memory_region_finalize(Object *obj)
     memory_region_clear_coalescing(mr);
     g_free((char *)mr->name);
     g_free(mr->ioeventfds);
+    object_unref(mr->rdm);
 }
 
 Object *memory_region_owner(const MemoryRegion *mr)
@@ -2058,11 +2059,18 @@ int memory_region_add_ram_discard_source(MemoryRegion *mr,
 int memory_region_del_ram_discard_source(MemoryRegion *mr,
                                           RamDiscardSource *source)
 {
+    int ret;
     g_assert(mr->rdm);
 
-    return ram_discard_manager_del_source(mr->rdm, source);
-
-    /* if there is no source and no listener left, we could free rdm */
+    ret = ram_discard_manager_del_source(mr->rdm, source);
+    if (ret != 0) {
+        return ret;
+    }
+    if (QLIST_EMPTY(&mr->rdm->source_list) && QLIST_EMPTY(&mr->rdm->rdl_list)) {
+        object_unref(mr->rdm);
+        mr->rdm = NULL;
+    }
+    return 0;
 }
 
 /* Called with rcu_read_lock held.  */
diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 7da91bf648a..4e8816e5a2f 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -549,6 +549,7 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
 
     g_assert(section->mr == rdm->mr);
 
+    object_ref(rdm);
     rdl->section = memory_region_section_new_copy(section);
     QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
 
@@ -570,6 +571,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
     memory_region_section_free_copy(rdl->section);
     rdl->section = NULL;
     QLIST_REMOVE(rdl, next);
+    object_unref(rdm);
 }
 
 int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)

-- 
2.54.0


