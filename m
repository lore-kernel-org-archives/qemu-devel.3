Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A8BC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzS7-0002ym-5T; Thu, 07 Aug 2025 08:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRk-0001E9-0r; Thu, 07 Aug 2025 08:10:16 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRh-0005Bp-Rz; Thu, 07 Aug 2025 08:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568610; x=1786104610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6OOXwbQJVmFdR82woS1dR8ruocVbES2DG+qHdDaUOcA=;
 b=jRaP2f3Hlu8aQogqs2HKjsWEerEd0nqawWKcPgLK/XmA6QlcZZS4pIN5
 d1cUgh3qKxIKypUWWtWb8Fml0CtnS4njjqhCC5ltH8VJlSo5dV7xUcUqx
 UhmLpf/y5cmTEKaUTDSjlzQ/fPytopUj7JTv9y8DMcfhi5ApWTpg9aA2S
 9yxe6U7/6Pskyk01h5YHMHmNcKuDPoOQ27VeAO+9o5nq+sim7AoKtt9EF
 Fy7/7Vvw31HAB/khLtkBtCZd9TeYW5pYAiwmLR68VMDBdBgrQ14l3Ze4r
 XU7Bcb8iuMqZf0xhJT1cCrZw7pEZwaXz9u0+c4UkKnnk3J1sEbj+fb42R A==;
X-CSE-ConnectionGUID: 6XRjV1JzS3OdXJLFg8W/wA==
X-CSE-MsgGUID: +zmjyEJ1TEOvkiikrluWYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036811"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036811"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:48 -0700
X-CSE-ConnectionGUID: jyeXBOXOSBOwEh2ZakcNyA==
X-CSE-MsgGUID: UfTu5LChQJSVMyaGEkeRMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701135"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:45 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 14/26] memory: Expose interfaces about Flatview reference count
 to Rust side
Date: Thu,  7 Aug 2025 20:30:15 +0800
Message-Id: <20250807123027.2910950-15-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Expose the following interfaces in include/system/memory.h without
`inline`:

* address_space_to_flatview
* flatview_ref
* flatview_unref

Then Rust side could generate related bindings.

In addtion, add documentations for these 3 interface.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/system/memory.h  | 69 +++++++++++++++++++++++++++++++++++++---
 system/memory-internal.h |  1 -
 system/memory.c          |  7 +++-
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index e2cd6ed12614..4b9a2f528d86 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1203,10 +1203,71 @@ struct FlatView {
     MemoryRegion *root;
 };
 
-static inline FlatView *address_space_to_flatview(AddressSpace *as)
-{
-    return qatomic_rcu_read(&as->current_map);
-}
+/**
+ * address_space_to_flatview: Get a transient RCU-protected pointer to
+ * the current FlatView.
+ *
+ * @as: The #AddressSpace to be accessed.
+ *
+ * This function retrieves a pointer to the current #FlatView for the
+ * given #AddressSpace.
+ *
+ * Note: This is a low-level, RCU-based accessor. It DOES NOT increment
+ * the FlatView's reference count. The returned pointer is only
+ * guaranteed to be valid within an RCU read-side critical section.
+ *
+ * Difference from address_space_get_flatview():
+ *
+ * For address_space_to_flatview() (this function), it is a lightweight
+ * "peek" operation. It is fast but unsafe for long-term use. Use it
+ * only for very short-lived access where performance is critical.
+ *
+ * For address_space_get_flatview(), it acquires a "strong" reference
+ * by safely incrementing the reference count. The returned pointer is
+ * stable and can be used for long-lived operations, even outside an
+ * RCU lock. It is the safer and generally preferred method, but it
+ * MUST be paired with a call to flatview_unref() after the use of
+ * #FlatView.
+ *
+ * Returns:
+ * A transient pointer to the current #FlatView, valid only under RCU
+ * protection.
+ */
+FlatView *address_space_to_flatview(AddressSpace *as);
+
+/**
+ * flatview_ref: Atomically increment the reference count of #FlatView.
+ *
+ * @view: The #FlatView whose reference count is to be incremented.
+ *
+ * This function attempts to atomically increment the reference count
+ * of the given @view. This operation is conditional and will only
+ * succeed if the current reference count is non-zero.
+ *
+ * A non-zero reference count indicates that the FlatView is live and
+ * in use. If the reference count is already zero, it indicates that the
+ * FlatView is being deinitialized, and no new references can be
+ * acquired.
+ *
+ * Returns:
+ * 'true' if the reference count was successfully incremented (i.e., it
+ * was non-zero before the call).
+ * 'false' if the reference count was already zero and could not be
+ * incremented.
+ */
+bool flatview_ref(FlatView *view);
+
+/**
+ * flatview_unref: Atomically decrement the reference count of
+ * #FlatView.
+ *
+ * @view: The #FlatView to be unreferenced.
+ *
+ * This function atomically decrements the reference count of the given
+ * @view. When the reference count drops to zero, #FlatView will be
+ * destroied via RCU.
+ */
+void flatview_unref(FlatView *view);
 
 /**
  * typedef flatview_cb: callback for flatview_for_each_range()
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 46f758fa7e47..b0870a6359c3 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -26,7 +26,6 @@ static inline AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
 }
 
 FlatView *address_space_get_flatview(AddressSpace *as);
-void flatview_unref(FlatView *view);
 
 extern const MemoryRegionOps unassigned_mem_ops;
 
diff --git a/system/memory.c b/system/memory.c
index 56465479406f..2a749081fb50 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -304,7 +304,7 @@ static void flatview_destroy(FlatView *view)
     g_free(view);
 }
 
-static bool flatview_ref(FlatView *view)
+bool flatview_ref(FlatView *view)
 {
     return qatomic_fetch_inc_nonzero(&view->ref) > 0;
 }
@@ -818,6 +818,11 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
     }
 }
 
+FlatView *address_space_to_flatview(AddressSpace *as)
+{
+    return qatomic_rcu_read(&as->current_map);
+}
+
 FlatView *address_space_get_flatview(AddressSpace *as)
 {
     FlatView *view;
-- 
2.34.1


