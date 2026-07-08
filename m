Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19786C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwF-0004c2-Pm; Wed, 08 Jul 2026 03:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMw0-00045e-AK; Wed, 08 Jul 2026 03:43:08 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvy-0004ox-JE; Wed, 08 Jul 2026 03:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496587; x=1815032587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+TOjti12wyjh6ysGSnrBZJk6dQHbvzcpbuZZnC8azsA=;
 b=avBwEriNu4IYj8EUvGE2OKw/GtR0JrZTuy84t0Z7tGxau+JsfLGcIk/q
 nQThn7axv5HRzawS4r7iP/RtXk97upBy/yjSG4jDYo8bP+BkImB+fsurp
 Td+h9b1vXQpeKG+KXqDRRl/sOtH0Glv432AHvyIUw+GbH80jAOAMzoKUW
 jFFFTPp+DobmbRdkeEmM2ArGpTIkHQJCUyrmUBZdsbge2p0RtNP+G3ZiJ
 I/4Ny9OZFB4ndjOnxVHsS+A3L40GWOMla/MgNZlkUt31vow8hWapQmpY2
 5ps0vlxiF5DuvvbuhF0zzoOTFQg/KvC43OvRrzUWZ6PsNDOVrYq0acMSM w==;
X-CSE-ConnectionGUID: uMcilWatTHqEwoAYYd7/1Q==
X-CSE-MsgGUID: awDyd9Z6TbSxugKdgmKL1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343302"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:06 -0700
X-CSE-ConnectionGUID: b33HJGF6SmmFT3RagQTHvA==
X-CSE-MsgGUID: UnFZ5/2hR1ywbmMOrCf8Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555974"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:01 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 10/26] memory: Expose FlatView refcount interfaces to Rust
Date: Wed,  8 Jul 2026 16:10:36 +0800
Message-Id: <20260708081052.2276617-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Move the declarations of the following functions to memory.h so that
Rust can generate bindings for them:
* flatview_ref
* flatview_unref

In addition, add documentation for these two interfaces.

Note that these interfaces serve the address_space_to_flatview()
logic. However, address_space_to_flatview() is not exposed to Rust
because Rust can perform qatomic_rcu_read() itself. Furthermore,
acquiring the RCU lock in Rust while C reads "current_map" via
qatomic_rcu_read() would make for a very dangerous cross-FFI design.

Instead, Rust should either use address_space_get_flatview() directly,
or implement the logic entirely on the Rust side. The latter is a more
worthwhile approach, as the RCU reader pattern (qatomic_rcu_read()
within an RCU critical section) is a general pattern in QEMU.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Do not expose address_space_to_flatview() to Rust anymore.
---
 include/system/memory.h  | 34 ++++++++++++++++++++++++++++++++++
 system/memory-internal.h |  1 -
 system/memory.c          |  2 +-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 47a0e06fbf8a..bf5bfa7164fb 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -948,6 +948,40 @@ static inline FlatView *address_space_to_flatview(const AddressSpace *as)
     return qatomic_rcu_read(&as->current_map);
 }
 
+/**
+ * flatview_ref: Atomically increment the reference count of a #FlatView.
+ *
+ * @view: The #FlatView whose reference count is to be incremented.
+ *
+ * This function attempts to atomically increment the reference count
+ * of the given @view. This operation is conditional and will only
+ * succeed if the current reference count is non-zero.
+ *
+ * A non-zero reference count indicates that the #FlatView is live and
+ * in use. If the reference count is already zero, it indicates that the
+ * #FlatView is being deinitialized, and no new references can be
+ * acquired.
+ *
+ * Returns:
+ * true if the reference count was successfully incremented (i.e., it
+ * was non-zero before the call).
+ * false if the reference count was already zero and could not be
+ * incremented.
+ */
+bool flatview_ref(FlatView *view);
+
+/**
+ * flatview_unref: Atomically decrement the reference count of a
+ * #FlatView.
+ *
+ * @view: The #FlatView to be unreferenced.
+ *
+ * This function atomically decrements the reference count of the given
+ * @view. When the reference count drops to zero, the #FlatView will be
+ * destroyed via RCU.
+ */
+void flatview_unref(FlatView *view);
+
 /**
  * typedef flatview_cb: callback for flatview_for_each_range()
  *
diff --git a/system/memory-internal.h b/system/memory-internal.h
index b2b9b5b0c5eb..c9264a239689 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -28,7 +28,6 @@ AddressSpaceDispatch *address_space_to_dispatch(const AddressSpace *as)
 }
 
 FlatView *address_space_get_flatview(const AddressSpace *as);
-void flatview_unref(FlatView *view);
 
 extern const MemoryRegionOps unassigned_mem_ops;
 
diff --git a/system/memory.c b/system/memory.c
index 5fc36708ec34..a18885dfd423 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -305,7 +305,7 @@ static void flatview_destroy(FlatView *view)
     g_free(view);
 }
 
-static bool flatview_ref(FlatView *view)
+bool flatview_ref(FlatView *view)
 {
     return qatomic_fetch_inc_nonzero(&view->ref) > 0;
 }
-- 
2.34.1


