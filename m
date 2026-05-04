Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6A6CD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsSN-0001hv-Br; Mon, 04 May 2026 08:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSL-0001fI-UI
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSK-0006nA-Cr
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F25ZlBQCQpJlrHIOLQDay01wp6wQvanMqsOb7pMMeHU=;
 b=JcsId6QK7NICGvlYpSygXPvYjwJfpm3pl48wzv44p6w2/Y6F2pyzfXhd7ttGzfSrpoDBFM
 H/2hRqsN74arOMECHsOqRbBPvWN77+qup9hnEO56BtDUJ1R75yVVk4EXixdwfsVKZrFfBK
 sTq2+D8u13Rue4VZm9SjvgG5XC9Bk1w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-f6mugTS8NMmxHUUr0f2cAw-1; Mon,
 04 May 2026 08:31:21 -0400
X-MC-Unique: f6mugTS8NMmxHUUr0f2cAw-1
X-Mimecast-MFC-AGG-ID: f6mugTS8NMmxHUUr0f2cAw_1777897880
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ABA1195605A
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:31:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FAE21800446; Mon,  4 May 2026 12:31:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:15 +0400
Subject: [PATCH v4 09/13] system/memory: add RamDiscardManager reference
 counting and cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-9-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2265;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vi2VOuHXpEjSessO+Cx2ie/4yF25z0idrB4HFDsNg5E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFZqgIICyFBCB8F9oljSanL9PhgZHWX4OQAM
 Pb3e0z6eXyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWQAKCRDa6OEJdZac
 5YI0D/9m4FJdO372Zis3DSn5MCfDdKW+4OyekBXnfFZg8hAFcnJHmqKMru9DBKeo9qY29X8F8bJ
 uwIyAOoB57iQn0Us+SPUI0Eza+20S5vBuxpRrktyadLbmCIuHYZSlwCge5GmaIK1d8f/GqwwNPP
 yiBkCCi28E9w2MP3HdO+4uuVapB82LgFKDJUf78gMaoiOHcuPnwA+9+9e71Ni9CSRQVgwSDHRO8
 vlzihPG70Jk+AXs4aOAJuFH57nUg0Opu+w26Fv29T+NCuuzXj7kRIXDzPPbU8VWgi7aB2xInIU7
 I5sKM2W3eMFc1piDE2eNvS4cX8tt3y8ZX6ehjpfPHcjE5+TohPq4sdDfh0ucTbe7L2z9SUUOZv7
 /s+AZt7/sgj/r4+6/yEzwB7OmdQiaxSNjVHwxuWpF34o1jD5lFlUcr9/97TZ397mtLWzha1eFWl
 OuES+QuvJLptph2bdUmHT6tPXAGXFp5Oo6uPq9g4PwtnfuEJoqahNMqDLFuDIcqh1lz+DTtPFJw
 kpriRMkUjGbRiPZwaacorNxJQe4onr9jlEt1omXAmTmUxbgfbZt30XhIe1m58wwQKJIWOLRBY2/
 GMiD9Y/mhy+/RGNVd/q95//2GiUFb4fefpRh/+3xRMf5NupQ/F2FP4Cs2RSqy+CzzPD4eIBWmXa
 G2cidvCNhcoGSwQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 system/memory.c              | 7 +++++--
 system/ram-discard-manager.c | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 4768375053a..456c53a1af4 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1754,6 +1754,7 @@ static void memory_region_finalize(Object *obj)
     memory_region_clear_coalescing(mr);
     g_free((char *)mr->name);
     g_free(mr->ioeventfds);
+    object_unref(mr->rdm);
 }
 
 Object *memory_region_owner(const MemoryRegion *mr)
@@ -2060,8 +2061,10 @@ void memory_region_del_ram_discard_source(MemoryRegion *mr,
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


