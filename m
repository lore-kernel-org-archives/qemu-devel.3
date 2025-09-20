Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B9ECAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkn-0007zw-M6; Sat, 20 Sep 2025 11:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzke-0007vb-V5; Sat, 20 Sep 2025 11:43:54 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkb-0001zT-Ij; Sat, 20 Sep 2025 11:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383030; x=1789919030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IFeVZke/HWz43jXrNgwIElT7PX2TkqZW6CE4stypwe0=;
 b=jDxmMI1/ILn7peS301bL+Nao+e4O72D2cTWI9Bly7J4Q+fOW4j9PTHHn
 rifr4k+ih9Cf93muIDCXRKyaBWJRHxk7bCcl9QI/f/Nbb0gWo1r1WWpeB
 Lg83/8q4pY4VbIZAGfh/j+K6ENyqJmPcUppWOiFYdUf2Xxiw33PXR3+Al
 K01LAnGf+4yiyXXYo22omEytRoOtVdRGmgHbkVAnlOF8GuQn9kh51qjWe
 GlnpChdG5heISq38cENIf8C7YCw/y/1Qjh9GT0/FUDhpqql2xv4OWsrsO
 nw/rdNPwKHj8k2LygFxxSuQ2VQV5CUextsULeRBBk/LF0LVSojPsksSc+ A==;
X-CSE-ConnectionGUID: TZEAcpPSRPOj4wKBxwG61w==
X-CSE-MsgGUID: StN1+M9MQ4aEDVVEpo+NXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955520"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955520"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:46 -0700
X-CSE-ConnectionGUID: H/BeRLvgQnqBWnjE65lokw==
X-CSE-MsgGUID: qWJixoeuRvCx9lYSolKF6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349451"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:44 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 04/12] rust/common/uninit: Fix Clippy's complaints about
 lifetime
Date: Sun, 21 Sep 2025 00:05:12 +0800
Message-Id: <20250920160520.3699591-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920160520.3699591-1-zhao1.liu@intel.com>
References: <20250920160520.3699591-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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


