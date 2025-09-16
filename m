Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5A4CAC59A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9C-0006ui-29; Tue, 16 Sep 2025 04:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8y-0006b0-3v; Tue, 16 Sep 2025 04:34:33 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8r-0005zx-J8; Tue, 16 Sep 2025 04:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011666; x=1789547666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QhXn4b+aoCS1lHYLjiS4gbHnpewKQmdQNLfqddQ4+oA=;
 b=XBY/1tDAd7iFfVMsjvvrid9FmeB8k6TziwiFexrfCwmVvcth0noQ96xG
 +UuPt29UrnqUu86uZWuRlte3GuASovJgnNHbwqAzHCv1YFsx6rwSn9a1a
 8W1HyQOU1QwaHlbPXQoqfN5l5eZS484NVsgK62NcVPi0+DCnBRKDFBzow
 BTlJ3ui8dVHJdZmvLZYqqH5QK2zyG6N39RoR/Dxv59UJkKs316IWrV4Ya
 uPfhaeiKO5YlUrCMD+XIUqTIJ093ESkCkB8ujIvx89V+mkIWo/ozhhToA
 sFSScFkAwdjw1ZFYP4IjXc+D318K5yOkIvgcskSRBVAmhDIFY55pL2haz Q==;
X-CSE-ConnectionGUID: 63bpz2jcTQWSH6KqADCkQA==
X-CSE-MsgGUID: 5iFKl4t3RRmS3GfpL7Edsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725154"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725154"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:17 -0700
X-CSE-ConnectionGUID: cJCjiq65TgO2funTpBcsPQ==
X-CSE-MsgGUID: uS2wbcb0QOa2PfeEeP6tLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691037"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:15 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/12] rust/common/uninit: Fix Clippy's complaints about
 lifetime
Date: Tue, 16 Sep 2025 16:55:49 +0800
Message-Id: <20250916085557.2008344-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Clippy complains about the following cases and following its suggestion
to fix these warnings.

warning: the following explicit lifetimes could be elided: 'a
  --> common/src/uninit.rs:38:6
   |
38 | impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
   |      ^^                                   ^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_lifetimes
   = note: `#[warn(clippy::needless_lifetimes)]` on by default
help: elide the lifetimes
   |
38 - impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
38 + impl<T, U> Deref for MaybeUninitField<'_, T, U> {
   |

warning: the following explicit lifetimes could be elided: 'a
  --> common/src/uninit.rs:49:6
   |
49 | impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
   |      ^^                                      ^^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_lifetimes
help: elide the lifetimes
   |
49 - impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
49 + impl<T, U> DerefMut for MaybeUninitField<'_, T, U> {
   |

warning: `common` (lib) generated 2 warnings (run `cargo clippy --fix --lib -p common` to apply 2 suggestions)

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/common/src/uninit.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/common/src/uninit.rs b/rust/common/src/uninit.rs
index e7f9fcd2e3fb..8d021b1dfc6e 100644
--- a/rust/common/src/uninit.rs
+++ b/rust/common/src/uninit.rs
@@ -35,7 +35,7 @@ pub const fn parent_mut(f: &mut Self) -> *mut T {
     }
 }
 
-impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
+impl<T, U> Deref for MaybeUninitField<'_, T, U> {
     type Target = MaybeUninit<U>;
 
     fn deref(&self) -> &MaybeUninit<U> {
@@ -46,7 +46,7 @@ fn deref(&self) -> &MaybeUninit<U> {
     }
 }
 
-impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
+impl<T, U> DerefMut for MaybeUninitField<'_, T, U> {
     fn deref_mut(&mut self) -> &mut MaybeUninit<U> {
         // SAFETY: self.child was obtained by dereferencing a valid mutable
         // reference; the content of the memory may be invalid or uninitialized
-- 
2.34.1


