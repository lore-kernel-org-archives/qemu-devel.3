Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73430CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 17:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Shw-0001O8-RF; Sun, 05 Oct 2025 13:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sge-0000WJ-SI; Sun, 05 Oct 2025 13:38:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sgc-0004g1-4s; Sun, 05 Oct 2025 13:38:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7936F15AA93;
 Sun, 05 Oct 2025 20:37:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8117829973E;
 Sun,  5 Oct 2025 20:37:34 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 55/58] memory: New AS helper to serialize destroy+free
Date: Sun,  5 Oct 2025 20:37:04 +0300
Message-ID: <20251005173712.445160-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Xu <peterx@redhat.com>

If an AddressSpace has been created in its own allocated
memory, cleaning it up requires first destroying the AS
and then freeing the memory. Doing this doesn't work:

    address_space_destroy(as);
    g_free_rcu(as, rcu);

because both address_space_destroy() and g_free_rcu()
try to use the same 'rcu' node in the AddressSpace struct
and the address_space_destroy hook gets overwritten.

Provide a new address_space_destroy_free() function which
will destroy the AS and then free the memory it uses, all
in one RCU callback.

(CC to stable because the next commit needs this function.)

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250929144228.1994037-3-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 041600e23f2fe2a9c252c9a8b26c7d147bedf982)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2ad3f93344..ef6af5caee 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2635,11 +2635,24 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
  * Note that destruction of the AddressSpace is done via RCU;
  * it is therefore not valid to free the memory the AddressSpace
  * struct is in until after that RCU callback has completed.
+ * If you want to g_free() the AddressSpace after destruction you
+ * can do that with address_space_destroy_free().
  *
  * @as: address space to be destroyed
  */
 void address_space_destroy(AddressSpace *as);
 
+/**
+ * address_space_destroy_free: destroy an address space and free it
+ *
+ * This does the same thing as address_space_destroy(), and then also
+ * frees (via g_free()) the AddressSpace itself once the destruction
+ * is complete.
+ *
+ * @as: address space to be destroyed
+ */
+void address_space_destroy_free(AddressSpace *as);
+
 /**
  * address_space_remove_listeners: unregister all listeners of an address space
  *
diff --git a/system/memory.c b/system/memory.c
index 4c829793a0..94cb60c83b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3254,7 +3254,14 @@ static void do_address_space_destroy(AddressSpace *as)
     memory_region_unref(as->root);
 }
 
-void address_space_destroy(AddressSpace *as)
+static void do_address_space_destroy_free(AddressSpace *as)
+{
+    do_address_space_destroy(as);
+    g_free(as);
+}
+
+/* Detach address space from global view, notify all listeners */
+static void address_space_detach(AddressSpace *as)
 {
     MemoryRegion *root = as->root;
 
@@ -3269,9 +3276,20 @@ void address_space_destroy(AddressSpace *as)
      * values to expire before freeing the data.
      */
     as->root = root;
+}
+
+void address_space_destroy(AddressSpace *as)
+{
+    address_space_detach(as);
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
+void address_space_destroy_free(AddressSpace *as)
+{
+    address_space_detach(as);
+    call_rcu(as, do_address_space_destroy_free, rcu);
+}
+
 static const char *memory_region_type(MemoryRegion *mr)
 {
     if (mr->alias) {
-- 
2.47.3


