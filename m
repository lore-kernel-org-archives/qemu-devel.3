Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860C606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l0INu5gD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnIc-0003SA-Qm; Tue, 24 Nov 2026 04:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnIa-0003RE-JI; Tue, 24 Nov 2026 04:58:52 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xVnIX-0003KH-Us; Tue, 24 Nov 2026 04:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795514330; x=1827050330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/3zne1QgAj1WaljEuHNbudEzQo09vHOaC/rLTguVSZc=;
 b=l0INu5gDWtojAtXkvIPE+l8dM+LZ2qKalE5krtkVJBcfHfqwiXtvy2GF
 hH4QycQBP8qsvoyE5S46qYZU2r83pFCrzxVBb8xUdOF7Ki4GYMD4xjk9l
 dE/h1A9Cghit/SoVMpYgIABuf/XIZOSzWK1M142rPR/oHC57xgiNoRheC
 dycLjd3rY/G6k24I0djZS0WzGbBjQv2Pv/WkLwAdUK6EH8Lht8dv5QVg0
 IyFpeWT7DsjEwOKgQiGeFtaSUJILpD7evLtvc1Edjyw9/nxwn423nOZbw
 Ez6GC3Jj5seJwTqzPwA7Dza1SW37VgJNvHNR1YDGFGTuS61NTU62Usdcp g==;
X-CSE-ConnectionGUID: axA3CE8cQTyAjm6HTS56yw==
X-CSE-MsgGUID: uhVUb2oDTZqTgXVkK5NhpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4398022"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4398022"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 01:58:36 -0800
X-CSE-ConnectionGUID: ik/exMJQQiu0E2i4GBlxIg==
X-CSE-MsgGUID: jUufxFK3R1+KdTRdfBd3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="13206413"
Received: from zhaoliu1-desk.sh.intel.com ([10.112.226.173])
 by fmviesa012.fm.intel.com with ESMTP; 24 Nov 2026 01:58:34 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/3] rust/hpet: Move vmstate_validate!() check into post_load
Date: Tue, 24 Nov 2026 17:58:13 +0800
Message-Id: <20261124095814.437738-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124095814.437738-1-zhao1.liu@intel.com>
References: <20261124095814.437738-1-zhao1.liu@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To pave way for removing VMSTATE_VALIDATE() (and vmstate_validate!()),
move the usage of hpet into post_load. To make it safer, loading the
timers with the num_timers, then only check against the wire number at
last.

In addition, drop the test_fn() in the VMStateField of HPETState.timers
- this was duplicated, but now the check in post_load is enough
(and test_fn should not be used for validation).

Originally-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Copy Peter's commit message from his C HPET patch because now this patch
has the (almost) same logic.
---
 rust/hw/timer/hpet/src/device.rs | 45 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 89ba7a5c4d21..c7a2b7f6c2ec 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -934,10 +934,15 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
         Ok(())
     }
 
-    fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
+    fn post_load(&self, _version_id: u8) -> Result<(), migration::InvalidError> {
         let mut regs = self.regs.borrow_mut();
         let cnt = regs.counter;
 
+        /* FIXME: use post_load_errp() to print error message. */
+        if !self.validate_num_timers() {
+            return Err(migration::InvalidError);
+        }
+
         for tn_regs in regs.tn_regs.iter_mut().take(self.num_timers) {
             tn_regs.update_cmp64(cnt);
             tn_regs.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
@@ -956,7 +961,7 @@ fn is_offset_needed(&self) -> bool {
         self.regs.borrow().is_hpet_enabled()
     }
 
-    fn validate_num_timers(&self, _version_id: u8) -> bool {
+    fn validate_num_timers(&self) -> bool {
         self.num_timers == self.num_timers_save.get().into()
     }
 }
@@ -1082,8 +1087,6 @@ fn restore_migrated_state(
 
 impl_vmstate_struct!(HPETTimerMigration, VMSTATE_HPET_TIMER);
 
-const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
-
 // HPETRegistersMigration is generated by ToMigrationState macro.
 impl_vmstate_struct!(
     HPETRegistersMigration,
@@ -1099,24 +1102,22 @@ fn restore_migrated_state(
         .build()
 );
 
-const VMSTATE_HPET: VMStateDescription<HPETState> =
-    VMStateDescriptionBuilder::<HPETState>::new()
-        .name(c"hpet")
-        .version_id(2)
-        .minimum_version_id(2)
-        .pre_save(&HPETState::pre_save)
-        .post_load(&HPETState::post_load)
-        .fields(vmstate_fields! {
-            vmstate_of!(HPETState, regs),
-            vmstate_of!(HPETState, num_timers_save),
-            vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-            vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
-        })
-        .subsections(vmstate_subsections!(
-            VMSTATE_HPET_RTC_IRQ_LEVEL,
-            VMSTATE_HPET_OFFSET,
-        ))
-        .build();
+const VMSTATE_HPET: VMStateDescription<HPETState> = VMStateDescriptionBuilder::<HPETState>::new()
+    .name(c"hpet")
+    .version_id(2)
+    .minimum_version_id(2)
+    .pre_save(&HPETState::pre_save)
+    .post_load(&HPETState::post_load)
+    .fields(vmstate_fields! {
+        vmstate_of!(HPETState, regs),
+        vmstate_of!(HPETState, num_timers_save),
+        vmstate_of!(HPETState, timers[0 .. num_timers]).with_version_id(0),
+    })
+    .subsections(vmstate_subsections!(
+        VMSTATE_HPET_RTC_IRQ_LEVEL,
+        VMSTATE_HPET_OFFSET,
+    ))
+    .build();
 
 impl DeviceImpl for HPETState {
     const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_HPET);
-- 
2.34.1


