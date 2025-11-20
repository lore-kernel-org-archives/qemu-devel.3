Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04F5CF8861
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5Lw-000306-9d; Thu, 20 Nov 2025 09:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5Lu-0002zZ-Bt; Thu, 20 Nov 2025 09:09:38 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5Lr-0001zT-Rm; Thu, 20 Nov 2025 09:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763647776; x=1795183776;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Q8KeSbdWaGONmhL/JAY67x/dYgup8wjYuXIA5QQXZyQ=;
 b=dvvjcxFNeotUvrBht1gOUKkcRomhD1XHHhlvUKqsWaVdO4Dv165shYGH
 uTaDdWVl9aIIbDBrkB8xdiIV7TRYXzc7DR9hm9YJlXodgvDJNuBdSyRJS
 G3ww4/MWERHdRoq1L4vudrKdAp3OY3WLn3l3xdiFhBfKBBSsLuKMpu7YP
 IA/JKX9+A3Z2wKh58J/VJtvxJO5ah9ldLCKym3NNtMAbxdhbsco25pst2
 /vnTuLdgsY0WYSq9V+4wNRQ8G2lLNLLtO5HuSLnqOGMJAibxLTt0yg4xD
 YvvzTUv8i1YR6ojb5Mb2jnMLB0PAU+kNUUMgfcDbIsnyvPQG7KLuSKDYm Q==;
X-CSE-ConnectionGUID: C+zEj1dJTnKjtmiTavXumA==
X-CSE-MsgGUID: 9bfR1u7nTl27Bm8ERGLIxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="77185545"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="77185545"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:09:32 -0800
X-CSE-ConnectionGUID: VVO3mw4KTHO6SfZ7l8tBmg==
X-CSE-MsgGUID: c9OHG9NLQMSsHndYMuJAbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="228682253"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 20 Nov 2025 06:09:30 -0800
Date: Thu, 20 Nov 2025 22:31:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/5] rust: migration: implement ToMigrationState for Timer
Message-ID: <aR8mVll8OeclCBxs@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
 <20251117084752.203219-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084752.203219-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Mon, Nov 17, 2025 at 09:47:51AM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Nov 2025 09:47:51 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/5] rust: migration: implement ToMigrationState for Timer
> X-Mailer: git-send-email 2.51.1
> 
> Timer is a complex struct, allow adding it to a struct that
> uses #[derive(ToMigrationState)]; similar to vmstate_timer, only
> the expiration time has to be preserved.
> 
> In fact, because it is thread-safe, ToMigrationStateShared can
> also be implemented without needing a cell or mutex that wraps
> the timer.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/device.rs |  1 -
>  rust/migration/src/migratable.rs | 31 +++++++++++++++++++++++++++++++
>  rust/util/src/timer.rs           | 10 +++++++++-
>  3 files changed, 40 insertions(+), 2 deletions(-)

I just, based on previous discussion, try to complete the timer's
ToMigrationState - use modify_ns() instead of modify(). This is on top
of this series.

From eb8b99a45ffccba7e0508141553c2c24c5efa410 Mon Sep 17 00:00:00 2001
From: Zhao Liu <zhao1.liu@intel.com>
Date: Thu, 20 Nov 2025 22:26:35 +0800
Subject: [PATCH] rust/timer: Use modify_ns() in restore_migrated_state()

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qemu/timer.h             | 11 +++++++++++
 rust/migration/src/migratable.rs |  2 +-
 rust/util/src/timer.rs           | 21 +++++++++++++++++----
 util/qemu-timer.c                |  4 ++++
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8b561cd6960b..4c6a51d600fb 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -392,6 +392,17 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg);
  * QEMUTimer
  */

+/**
+ * timer_get_scale
+ * @ts: the timer to be accessed
+ *
+ * Get the scale value of the specified timer. The scale represents
+ * the number of nanoseconds per unit of time for this timer.
+ *
+ * Returns: the scale of the timer (nanoseconds per unit)
+ */
+int timer_get_scale(QEMUTimer *ts);
+
 /**
  * timer_init_full:
  * @ts: the timer to be initialised
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index c82a6b9a7cf2..7748aac2f27d 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -260,7 +260,7 @@ fn restore_migrated_state(
 impl ToMigrationStateShared for util::timer::Timer {
     fn restore_migrated_state(&self, source: i64, _version_id: u8) -> Result<(), InvalidError> {
         if source >= 0 {
-            self.modify(source as u64);
+            self.modify_ns(source as u64);
         } else {
             self.delete();
         }
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index 4109d84c398a..6114892f084f 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -10,8 +10,8 @@
 use common::{callbacks::FnCall, Opaque};

 use crate::bindings::{
-    self, qemu_clock_get_ns, timer_del, timer_expire_time_ns, timer_init_full, timer_mod,
-    QEMUClockType,
+    self, qemu_clock_get_ns, timer_del, timer_expire_time_ns, timer_get_scale, timer_init_full,
+    timer_mod_ns, QEMUClockType,
 };

 /// A safe wrapper around [`bindings::QEMUTimer`].
@@ -96,10 +96,23 @@ pub fn expire_time_ns(&self) -> Option<i64> {
         i64::try_from(ret).ok()
     }

-    pub fn modify(&self, expire_time: u64) {
+    fn scale(&self) -> u32 {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned. And when Timer
+        // is created, its fields (including scale) are initialized to zero.
+        unsafe { timer_get_scale(self.as_mut_ptr()) }
+            .try_into()
+            .unwrap()
+    }
+
+    pub fn modify_ns(&self, expire_time: u64) {
         // SAFETY: the only way to obtain a Timer safely is via methods that
         // take a Pin<&mut Self>, therefore the timer is pinned
-        unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
+        unsafe { timer_mod_ns(self.as_mut_ptr(), expire_time.try_into().unwrap()) }
+    }
+
+    pub fn modify(&self, expire_time: u64) {
+        self.modify_ns(expire_time * u64::from(self.scale()))
     }

     pub fn delete(&self) {
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 2a6be4c7f958..233fdb2aa847 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -346,6 +346,10 @@ int qemu_poll_ns(GPollFD *fds, guint nfds, int64_t timeout)
 #endif
 }

+int timer_get_scale(QEMUTimer *ts)
+{
+    return ts->scale;
+}

 void timer_init_full(QEMUTimer *ts,
                      QEMUTimerListGroup *timer_list_group, QEMUClockType type,
--
2.34.1




