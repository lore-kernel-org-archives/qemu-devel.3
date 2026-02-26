Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5B6FCE08C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbvN-0002yG-0o; Thu, 26 Feb 2026 09:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbvI-0002n3-Ux
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:01:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vvbvF-0006MD-Eh
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772114456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2KGzf0HMEkIVAc9UiJzuxWJ25Lw3QMqbgo+wk0wHYQ=;
 b=hlFdaDzh3IXG7pwJnbmM6iWxuaLVgFuph6eK+I/qB8m5IJiQl+VqpTvoXGEPIifPBexbYQ
 7Ii7ZGxfml1tles5eYtzIPC9Lw9WGQcWEzSZlmHSSk+66HM7H8rd0N7XQ/hGfFQ1gGXVpl
 u5HAXCgyiT60udG8+C7BdQ+zCld7NvI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-76BAIdJaMIKA4SHAsDz84g-1; Thu,
 26 Feb 2026 09:00:53 -0500
X-MC-Unique: 76BAIdJaMIKA4SHAsDz84g-1
X-Mimecast-MFC-AGG-ID: 76BAIdJaMIKA4SHAsDz84g_1772114450
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D8AD1956058; Thu, 26 Feb 2026 14:00:50 +0000 (UTC)
Received: from localhost (unknown [10.45.242.29])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C4D130001A5; Thu, 26 Feb 2026 14:00:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 14/15] system/memory: add RamDiscardManager reference
 counting and cleanup
Date: Thu, 26 Feb 2026 14:59:59 +0100
Message-ID: <20260226140001.3622334-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Listeners now hold a reference to the RamDiscardManager, ensuring it
stays alive while listeners are registered. The RDM is eagerly freed
when the last source and listener are removed, and also unreffed during
MemoryRegion finalization as a safety net.

This completes the TODO left in the previous commit and prevents both
use-after-free and memory leaks of the RamDiscardManager.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c              | 7 +++++--
 system/ram-discard-manager.c | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 8a4cb7b59ac..664d24109ab 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1817,6 +1817,7 @@ static void memory_region_finalize(Object *obj)
     memory_region_clear_coalescing(mr);
     g_free((char *)mr->name);
     g_free(mr->ioeventfds);
+    object_unref(mr->rdm);
 }
 
 Object *memory_region_owner(MemoryRegion *mr)
@@ -2123,8 +2124,10 @@ void memory_region_del_ram_discard_source(MemoryRegion *mr,
     g_assert(mr->rdm);
 
     ram_discard_manager_del_source(mr->rdm, source);
-
-    /* if there is no source and no listener left, we could free rdm */
+    if (QLIST_EMPTY(&mr->rdm->source_list) && QLIST_EMPTY(&mr->rdm->rdl_list)) {
+        object_unref(mr->rdm);
+        mr->rdm = NULL;
+    }
 }
 
 /* Called with rcu_read_lock held.  */
diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 5592bfd3486..904a98cbef1 100644
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
2.53.0


