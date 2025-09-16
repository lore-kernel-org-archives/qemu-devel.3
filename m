Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA18CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR99-0006lA-54; Tue, 16 Sep 2025 04:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8z-0006bh-Q1; Tue, 16 Sep 2025 04:34:35 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR8r-0005zs-JF; Tue, 16 Sep 2025 04:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011666; x=1789547666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GuzeBHtL/53MAiPhgK+s+BNAuq5u5mNGV7VJ0Ymk0BQ=;
 b=b1pXEs7rEfKI7ro7vHKZ3spBVTI2RuaEeKRPlZcY2LebBlBPGaGLRyh/
 z5EiYlUOcwzIRTYE3uiFJ3cRZObKtPy2GZEAwqU1U0y5q+w2aJ4cFOS5U
 0M3BwxLSZs7loXmMoynxgoeZL0vRP/fLE55N7cUhLgoO61NYKPkGRT1vE
 1njR9kl2tDxGflDa5p4ZMYw4+zlaXeTD14i+Y2EftDmj1VdsIIVikENvu
 wrDzLaJKZjP4geeTwj/XRvSgKb7sC2Cm1swB+IjOFd7vpd/Oy1DkHkndA
 td5sosHUDO7CkFECKsqO1qSWcieA9XT+IfMsHamOMm+ye55fhfb638nw8 w==;
X-CSE-ConnectionGUID: j7ouXmT0QaS/53AIXtgkKA==
X-CSE-MsgGUID: Odwg114mRVeJue2z7UAm1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725147"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725147"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:16 -0700
X-CSE-ConnectionGUID: Oy3GDtaSQ5CHkw+dK+LgMA==
X-CSE-MsgGUID: ik8W7+iQToi/4jB30uGitw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691025"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:13 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 03/12] rust/qemu-macros: Fix Clippy's complaints about lambda
 parameter naming
Date: Tue, 16 Sep 2025 16:55:48 +0800
Message-Id: <20250916085557.2008344-4-zhao1.liu@intel.com>
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

error: `rename` shadows a previous, unrelated binding
   --> qemu-macros/src/lib.rs:265:14
    |
265 |             |rename| -> Result<proc_macro2::TokenStream, Error> {
    |              ^^^^^^
    |
note: previous binding is here
   --> qemu-macros/src/lib.rs:245:30
    |
245 |         let DeviceProperty { rename, defval } = prop;
    |                              ^^^^^^
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#shadow_unrelated
    = note: requested on the command line with `-D clippy::shadow-unrelated`

Rename the lambda parameter to "prop_rename" to fix the above clippy
error.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-macros/src/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 830b4326985b..ed4064d6e110 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -262,8 +262,8 @@ macro_rules! str_to_c_str {
 
         let prop_name = rename.map_or_else(
             || str_to_c_str!(field_name.to_string(), field_name.span()),
-            |rename| -> Result<proc_macro2::TokenStream, Error> {
-                match rename {
+            |prop_rename| -> Result<proc_macro2::TokenStream, Error> {
+                match prop_rename {
                     DevicePropertyName::CStr(cstr_lit) => Ok(quote! { #cstr_lit }),
                     DevicePropertyName::Str(str_lit) => {
                         str_to_c_str!(str_lit.value(), str_lit.span())
-- 
2.34.1


