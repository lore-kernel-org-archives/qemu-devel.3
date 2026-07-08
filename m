Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFF7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMw8-0004Nn-H7; Wed, 08 Jul 2026 03:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvp-0003zJ-3n; Wed, 08 Jul 2026 03:42:57 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvn-0004ox-IV; Wed, 08 Jul 2026 03:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496576; x=1815032576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iU39p6y9+8iUwssZDQG7wjvu6B8h4ifB2KTeCJq8KHU=;
 b=S3UymKG8klMyD2pnSXkt3V3Crb7iDHOak+MHBODhJvuIvgzGhf5+4Zxs
 7bYjZxrk1RIYC6v7PayBZDw/KROEI+JQ12ENy+DXnEof4Pbw7lM/7aVto
 uRiWTJoJeYZjBSOuo1VUfs8CJxmAuu3Ji3qKx1gFZ6ac4n35hEZSp6K9d
 +vAasnz6PPZsKdprZm+mFaSinhZsE3w2qb9QArp4tBMQrBy6O7kVIeJtl
 Wyj8j/uKE9yCWvWsLsHI5Y5D185ntTEcOMmgpFlHcLEzjrul3wAoOI42F
 Ika4D/U0+jSH6NLtb/EnaFRiAPtinvR2tINEDelLZVYhFosrSBZZrpVkb g==;
X-CSE-ConnectionGUID: NnQLs9wBTxa/4tfMgX08Zw==
X-CSE-MsgGUID: R0uN/bChSOyN732pFwaumw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343254"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343254"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:54 -0700
X-CSE-ConnectionGUID: 8DlX7vkMQVaOhNoHiUWf0g==
X-CSE-MsgGUID: uUU5xOkIRZqjswroCTBqlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555942"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:49 -0700
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
Subject: [RFC v2 07/26] rcu: Add rust wrappers for rcu_read_lock &
 rcu_read_unlock
Date: Wed,  8 Jul 2026 16:10:33 +0800
Message-Id: <20260708081052.2276617-8-zhao1.liu@intel.com>
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

Add rust wrappers for rcu_read_lock & rcu_read_unlock, then bindgen
could generate the bindings.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Add rust wrappers instead of dropping inline.
---
 include/qemu/rcu.h | 18 ++++++++++++++++++
 util/rcu.c         | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 020dbe4d8b77..126ec52ba38f 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -118,6 +118,24 @@ static inline void rcu_read_unlock(void)
     }
 }
 
+/**
+ * rust_rcu_read_lock:
+ *
+ * A wrapper over rcu_read_lock().
+ * Called from Rust to acquire an RCU read lock.
+ * Do not touch.
+ */
+void rust_rcu_read_lock(void);
+
+/**
+ * rust_rcu_read_unlock:
+ *
+ * A wrapper over rcu_read_unlock().
+ * Called from Rust to release an RCU read lock.
+ * Do not touch.
+ */
+void rust_rcu_read_unlock(void);
+
 void synchronize_rcu(void);
 
 /*
diff --git a/util/rcu.c b/util/rcu.c
index acac9446ea98..e9ba2c57bce6 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -171,6 +171,16 @@ static void wait_for_readers(void)
     QLIST_SWAP(&registry, &qsreaders, node);
 }
 
+void rust_rcu_read_lock(void)
+{
+    rcu_read_lock();
+}
+
+void rust_rcu_read_unlock(void)
+{
+    rcu_read_unlock();
+}
+
 void synchronize_rcu(void)
 {
     QEMU_LOCK_GUARD(&rcu_sync_lock);
-- 
2.34.1


