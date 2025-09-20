Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E19CAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkn-0007zs-Ib; Sat, 20 Sep 2025 11:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzke-0007va-UX; Sat, 20 Sep 2025 11:43:54 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkb-0001zC-Hc; Sat, 20 Sep 2025 11:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383030; x=1789919030;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e2m8PPZayoxqwvYik36u1YFgyjvQ2yQsYIRZWJ/B+oc=;
 b=ZGUmHXvIELot7WBiaJ5EttDbZz/gxyI/G2N0iy7OcjY1ZkmrMtQizpmj
 dkOBkXikB+Xza7LNN9KH3Uk/ecMyWSNYxCTrLs58jJkyLbpj68vxzq898
 AXY7wMME8TXh0bxy+PRjOwA10wTAiTnw+qvwVu9p3a63z9wS8/7HqLvGO
 Fj/uk5sYRa1pCy1ivgg1tCjRM1qzJonq9H3Pwj+0ofAkonjWiXXjKoLGD
 UF4AA/gbHFpU+9LSJLg9XHVi5wHme104SP3GMCESqBf+Vuh8mXvYgBMn+
 it7aind9ZLmFhu7DZX0q1vUgPFOCATBPWqg8XJPkrRFXjmSJ6W4mCFO4H w==;
X-CSE-ConnectionGUID: WxP2DggDSnilSN42Za8ujw==
X-CSE-MsgGUID: 14InECDLSaWG8UgJf98F5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955509"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955509"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:44 -0700
X-CSE-ConnectionGUID: tf4WPbhGT2io0nZ715Y6CQ==
X-CSE-MsgGUID: KBXVuPVlSW+cXm450W2Wvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349441"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:42 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 03/12] rust/qemu-macros: Fix Clippy's complaints about
 lambda parameter naming
Date: Sun, 21 Sep 2025 00:05:11 +0800
Message-Id: <20250920160520.3699591-4-zhao1.liu@intel.com>
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-macros/src/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 8151fb6d4e1e..ed2b997b24a4 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -246,8 +246,8 @@ macro_rules! str_to_c_str {
 
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


