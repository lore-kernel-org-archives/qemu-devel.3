Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62438E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4jt-0006Ae-37; Thu, 05 Dec 2024 00:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4js-0006AP-5d; Thu, 05 Dec 2024 00:49:24 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4jo-00077P-My; Thu, 05 Dec 2024 00:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377761; x=1764913761;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u4ULxLbBoMZS1PFeI3YxwZ6tEeXAKH8bdHoJ0zJEbDo=;
 b=NY/CRAKGVTzb9ofv5qTZlv7DhPY6Qd01G89G6HZIbThX1BUqWqrs2Hp4
 F/Fatw0PK+BIoLxTWZqp6DLqRY1SscyC/Ua1ZSR0Ueqx1Ns8xghgdUzbo
 ZTfpRR/1B2nGxaJxtEB6FBhZUGTctkt5McAugVkOre+XlZK2si94zRTss
 KHjEKpyKoTdT9qYAu47AI0nAME8s9xKf8+IP19DdbyPrb8okDwheYmHCa
 BTNQ1RRLXhpifnl5o3k3bnyZEYPClJxanifz9eVxQIQ5IkTDjPKFpuJHV
 46dcRbkqw1ElEOw9G+uuTfYilJFb279RxUn/18ar0aC7j4FKUXngawBwW A==;
X-CSE-ConnectionGUID: AcLTKBurROyFsFvBO8jIag==
X-CSE-MsgGUID: P8+K/3U1Su6dg64iijPVPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815604"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:17 -0800
X-CSE-ConnectionGUID: bAZlyB9+Tn67qaLo02lmMQ==
X-CSE-MsgGUID: rvtGDoXxTwqC9yftYwTyHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94454950"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:14 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 01/13] bql: check that the BQL is not dropped within marked
 sections
Date: Thu,  5 Dec 2024 14:07:02 +0800
Message-Id: <20241205060714.256270-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

The Big QEMU Lock (BQL) is used to provide interior mutability to Rust
code.  While BqlCell performs indivisible accesses, an equivalent of
RefCell will allow the borrower to hold to the interior content for a
long time.  If the BQL is dropped, another thread could come and mutate
the data from C code (Rust code would panic on borrow_mut() instead).
In order to prevent this, add a new BQL primitive that can mark
BQL-atomic sections and aborts if the BQL is dropped within them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qemu/main-loop.h | 15 +++++++++++++++
 stubs/iothread-lock.c    | 15 +++++++++++++++
 system/cpus.c            | 15 +++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 5764db157c97..646306c272f7 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -262,6 +262,21 @@ AioContext *iohandler_get_aio_context(void);
  */
 bool bql_locked(void);
 
+/**
+ * bql_block: Allow/deny releasing the BQL
+ *
+ * The Big QEMU Lock (BQL) is used to provide interior mutability to
+ * Rust code, but this only works if other threads cannot run while
+ * the Rust code has an active borrow.  This is because C code in
+ * other threads could come in and mutate data under the Rust code's
+ * feet.
+ *
+ * @increase: Whether to increase or decrease the blocking counter.
+ *            Releasing the BQL while the counter is nonzero triggers
+ *            an assertion failure.
+ */
+void bql_block_unlock(bool increase);
+
 /**
  * qemu_in_main_thread: return whether it's possible to safely access
  * the global state of the block layer.
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index d7890e5581c5..54676598950f 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -1,6 +1,8 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 
+static uint32_t bql_unlock_blocked;
+
 bool bql_locked(void)
 {
     return false;
@@ -12,4 +14,17 @@ void bql_lock_impl(const char *file, int line)
 
 void bql_unlock(void)
 {
+    assert(!bql_unlock_blocked);
+}
+
+void bql_block_unlock(bool increase)
+{
+    uint32_t new_value;
+
+    assert(bql_locked());
+
+    /* check for overflow! */
+    new_value = bql_unlock_blocked + increase - !increase;
+    assert((new_value > bql_unlock_blocked) == increase);
+    bql_unlock_blocked = new_value;
 }
diff --git a/system/cpus.c b/system/cpus.c
index a1b46f68476a..793c4698c7ad 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -514,6 +514,20 @@ bool qemu_in_vcpu_thread(void)
 
 QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
 
+static uint32_t bql_unlock_blocked;
+
+void bql_block_unlock(bool increase)
+{
+    uint32_t new_value;
+
+    assert(bql_locked());
+
+    /* check for overflow! */
+    new_value = bql_unlock_blocked + increase - !increase;
+    assert((new_value > bql_unlock_blocked) == increase);
+    bql_unlock_blocked = new_value;
+}
+
 bool bql_locked(void)
 {
     return get_bql_locked();
@@ -540,6 +554,7 @@ void bql_lock_impl(const char *file, int line)
 void bql_unlock(void)
 {
     g_assert(bql_locked());
+    g_assert(!bql_unlock_blocked);
     set_bql_locked(false);
     qemu_mutex_unlock(&bql);
 }
-- 
2.34.1


