Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0391EC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzSD-0003Ze-Vm; Thu, 07 Aug 2025 08:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRJ-0008Al-F9; Thu, 07 Aug 2025 08:09:46 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRH-0005AS-Gp; Thu, 07 Aug 2025 08:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568583; x=1786104583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0eAU/mU1IVyjxZrqAptdRp3Py54WmvSs7NPummwpoe0=;
 b=adfinu97wpid4tu8RwagqTUEC9YSyE7kW/Hm+J3G5o7o0bJwgedPF2ig
 zMoMt1pgeJdKWxRFAyOOHDljTPa4er5eAAL5eJOGEvnXGLiEK0lufvRZs
 G2XbPeya8rrrcE8WP1CmBt+o8+YwYtsa6Lswd84620+3LJ3xIYfCTvmdZ
 flgZ9CmYS26nbx1kswC8Qs4EPXIJMzZGizQ/PCvVFK/wBieoVV4c3xVRs
 i8z8lCqSV8aF5ShARKDw6+u1ymjKWc5Eref2aw37c4L7q5YrgE3NJCrps
 bC2tjmZ7kNLpC8eg/BOVs7042zEjkWez9DwUtY//wmtM9EoAygOdq3VkA Q==;
X-CSE-ConnectionGUID: ZfHCbucORMSzo8jsj30oYg==
X-CSE-MsgGUID: 0/aJEPCBQB+/FXvm0mZCCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036799"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:41 -0700
X-CSE-ConnectionGUID: eOAHi3cMTLWg6dG0LYe7YQ==
X-CSE-MsgGUID: Q8vO1LQFT5WLmLedjY/kQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701129"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:38 -0700
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
Subject: [RFC 12/26] rcu: Make rcu_read_lock & rcu_read_unlock not inline
Date: Thu,  7 Aug 2025 20:30:13 +0800
Message-Id: <20250807123027.2910950-13-zhao1.liu@intel.com>
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

Make rcu_read_lock & rcu_read_unlock not inline, then bindgen could
generate the bindings.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qemu/rcu.h | 45 ++-------------------------------------------
 util/rcu.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 020dbe4d8b77..34d955204b81 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -75,49 +75,8 @@ struct rcu_reader_data {
 
 QEMU_DECLARE_CO_TLS(struct rcu_reader_data, rcu_reader)
 
-static inline void rcu_read_lock(void)
-{
-    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
-    unsigned ctr;
-
-    if (p_rcu_reader->depth++ > 0) {
-        return;
-    }
-
-    ctr = qatomic_read(&rcu_gp_ctr);
-    qatomic_set(&p_rcu_reader->ctr, ctr);
-
-    /*
-     * Read rcu_gp_ptr and write p_rcu_reader->ctr before reading
-     * RCU-protected pointers.
-     */
-    smp_mb_placeholder();
-}
-
-static inline void rcu_read_unlock(void)
-{
-    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
-
-    assert(p_rcu_reader->depth != 0);
-    if (--p_rcu_reader->depth > 0) {
-        return;
-    }
-
-    /* Ensure that the critical section is seen to precede the
-     * store to p_rcu_reader->ctr.  Together with the following
-     * smp_mb_placeholder(), this ensures writes to p_rcu_reader->ctr
-     * are sequentially consistent.
-     */
-    qatomic_store_release(&p_rcu_reader->ctr, 0);
-
-    /* Write p_rcu_reader->ctr before reading p_rcu_reader->waiting.  */
-    smp_mb_placeholder();
-    if (unlikely(qatomic_read(&p_rcu_reader->waiting))) {
-        qatomic_set(&p_rcu_reader->waiting, false);
-        qemu_event_set(&rcu_gp_event);
-    }
-}
-
+void rcu_read_lock(void);
+void rcu_read_unlock(void);
 void synchronize_rcu(void);
 
 /*
diff --git a/util/rcu.c b/util/rcu.c
index b703c86f15a3..2dfd82796e1e 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -141,6 +141,49 @@ static void wait_for_readers(void)
     QLIST_SWAP(&registry, &qsreaders, node);
 }
 
+void rcu_read_lock(void)
+{
+    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
+    unsigned ctr;
+
+    if (p_rcu_reader->depth++ > 0) {
+        return;
+    }
+
+    ctr = qatomic_read(&rcu_gp_ctr);
+    qatomic_set(&p_rcu_reader->ctr, ctr);
+
+    /*
+     * Read rcu_gp_ptr and write p_rcu_reader->ctr before reading
+     * RCU-protected pointers.
+     */
+    smp_mb_placeholder();
+}
+
+void rcu_read_unlock(void)
+{
+    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
+
+    assert(p_rcu_reader->depth != 0);
+    if (--p_rcu_reader->depth > 0) {
+        return;
+    }
+
+    /* Ensure that the critical section is seen to precede the
+     * store to p_rcu_reader->ctr.  Together with the following
+     * smp_mb_placeholder(), this ensures writes to p_rcu_reader->ctr
+     * are sequentially consistent.
+     */
+    qatomic_store_release(&p_rcu_reader->ctr, 0);
+
+    /* Write p_rcu_reader->ctr before reading p_rcu_reader->waiting.  */
+    smp_mb_placeholder();
+    if (unlikely(qatomic_read(&p_rcu_reader->waiting))) {
+        qatomic_set(&p_rcu_reader->waiting, false);
+        qemu_event_set(&rcu_gp_event);
+    }
+}
+
 void synchronize_rcu(void)
 {
     QEMU_LOCK_GUARD(&rcu_sync_lock);
-- 
2.34.1


