Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71383D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzOM-0007jB-Lt; Fri, 15 Nov 2024 11:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNd-0006TP-Kh
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBzNb-0002Me-UM
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731688867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKxjJcV0JChOUSaR9ARk6UGjcpUxEbTMXigv0cQguQU=;
 b=Gi7oRxpWzZoFxSTWLHTqvBxC+5yRDpjySP2urBNiQu7dGtQJmPVi80hVBGA9brAyhwF0Dq
 dIKBu3wyF/Gr2Cqmzz2WJSqeU92e8LScyg/F6d6aK2AiZh384FrxxugU/y/Q7BK1MKtJPN
 fpQmLjhpq6605W5WLQHgXKjrWOgVbV0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-_iOvyWHgOIWPMmxE2LTVZQ-1; Fri, 15 Nov 2024 11:41:06 -0500
X-MC-Unique: _iOvyWHgOIWPMmxE2LTVZQ-1
X-Mimecast-MFC-AGG-ID: _iOvyWHgOIWPMmxE2LTVZQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38223a3262bso501037f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688864; x=1732293664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKxjJcV0JChOUSaR9ARk6UGjcpUxEbTMXigv0cQguQU=;
 b=n/+95ucs91BWGz+8UusAK78fn1Y9lvtQcnR9OV5og/WZWpaVAm/jiSlTIG8EA9pg5A
 gr5OxBLOLUBdt6EQnrRLtVJbVjCrnOwNs2pl6CUIfAcX9Z01eVtkXz6jtZ5o/T66Xgtv
 9KSZIuJIkHx5i0oWB1GrFJlpzCGCiIKhETkT7U+/8P7tOC17zzvjniwx/deTS3QdWxgX
 igYD0Inv3J8eI/8+1HzSAzPx63GZx65sqkeh0CeNSYkmCHvDRmR0Qw6s4Xb86OMGsmWT
 cchjfTzxzHpeyNTrYGTLHDlChUJbcXuMTrTOaiN154xi8xi8Lu2wwmqNjEl6sZpl8Mr5
 X+wA==
X-Gm-Message-State: AOJu0Yzr4jkdaMSHdNOuohbO4h1cDcWP61XFmDma+L22lN1no+27cXtN
 dL8mVEjiubzjQv+2Ys96mYRZ2ICesrgozJ4mVK9U5BM05ucfQm57hHBEvXYMkTnhinc3iFPj0J7
 45PLgS9lC6L67XAknAaenEk4mRF41hCEiR1JmGhYqW4ZgL7l/8gveCjrquSckUxu3B18qn53hZe
 LpIx6Lec/Mmv3SUllJorOeFVE8cPBVsTcZ9qRW+GY=
X-Received: by 2002:a05:6000:782:b0:37c:f3e0:b436 with SMTP id
 ffacd0b85a97d-38225a3999dmr2298718f8f.30.1731688863846; 
 Fri, 15 Nov 2024 08:41:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT2sxcga4Kr7D6NafnKd1hr4plVsuaoNEaJe4ZsnJtodjW2mk49DUZE6GhxKC1S4X4YgCufg==
X-Received: by 2002:a05:6000:782:b0:37c:f3e0:b436 with SMTP id
 ffacd0b85a97d-38225a3999dmr2298694f8f.30.1731688863459; 
 Fri, 15 Nov 2024 08:41:03 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3e65sm4768683f8f.13.2024.11.15.08.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:41:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, berrange@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, kwolf@redhat.com
Subject: [PATCH 09/12] rust: build: establish a baseline of lints across all
 crates
Date: Fri, 15 Nov 2024 17:40:22 +0100
Message-ID: <20241115164025.1917618-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115163944.1917393-1-pbonzini@redhat.com>
References: <20241115163944.1917393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Many lints that default to allow can be helpful in detecting bugs or
keeping the code style homogeneous.  Add them liberally, though perhaps
not as liberally as in hw/char/pl011/src/lib.rs.  In particular, enabling
entire groups can be problematic because of bitrot when new links are
added in the future.

For Clippy, this is actually a feature that is only present in Cargo
1.74.0 but, since we are not using Cargo to *build* QEMU, only developers
will need a new-enough cargo and only to run tools such as clippy.
The requirement does not apply to distros that are building QEMU.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml               | 65 +++++++++++++++++++++++++++++++++++
 rust/hw/char/pl011/src/lib.rs | 19 ++--------
 rust/qemu-api/src/bindings.rs |  6 ++--
 3 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 358c517bc56..c3f7142d264 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -19,3 +19,68 @@ unknown_lints = "allow"
 
 # Prohibit code that is forbidden in Rust 2024
 unsafe_op_in_unsafe_fn = "deny"
+
+[workspace.lints.rustdoc]
+broken_intra_doc_links = "deny"
+invalid_html_tags = "deny"
+invalid_rust_codeblocks = "deny"
+bare_urls = "deny"
+unescaped_backticks = "deny"
+redundant_explicit_links = "deny"
+
+[workspace.lints.clippy]
+# default-warn lints
+result_unit_err = "allow"
+should_implement_trait = "deny"
+
+# default-allow lints
+as_underscore = "deny"
+assertions_on_result_states = "deny"
+bool_to_int_with_if = "deny"
+borrow_as_ptr = "deny"
+cast_lossless = "deny"
+dbg_macro = "deny"
+debug_assert_with_mut_call = "deny"
+derive_partial_eq_without_eq = "deny"
+doc_markdown = "deny"
+empty_structs_with_brackets = "deny"
+ignored_unit_patterns = "deny"
+implicit_clone = "deny"
+macro_use_imports = "deny"
+missing_const_for_fn = "deny"
+missing_safety_doc = "deny"
+multiple_crate_versions = "deny"
+mut_mut = "deny"
+needless_bitwise_bool = "deny"
+needless_pass_by_ref_mut = "deny"
+no_effect_underscore_binding = "deny"
+option_option = "deny"
+or_fun_call = "deny"
+ptr_as_ptr = "deny"
+pub_underscore_fields = "deny"
+redundant_clone = "deny"
+redundant_closure_for_method_calls = "deny"
+redundant_else = "deny"
+redundant_pub_crate = "deny"
+ref_binding_to_reference = "deny"
+ref_option_ref = "deny"
+return_self_not_must_use = "deny"
+same_name_method = "deny"
+semicolon_inside_block = "deny"
+shadow_unrelated = "deny"
+significant_drop_in_scrutinee = "deny"
+significant_drop_tightening = "deny"
+suspicious_operation_groupings = "deny"
+transmute_ptr_to_ptr = "deny"
+transmute_undefined_repr = "deny"
+type_repetition_in_bounds = "deny"
+unused_self = "deny"
+used_underscore_binding = "deny"
+
+# nice to have, but cannot be enabled yet
+#wildcard_imports = "deny"   # still have many bindings::* imports
+#ptr_cast_constness = "deny" # needs 1.65.0 for cast_mut()/cast_const()
+
+# these may have false positives
+#option_if_let_else = "deny"
+cognitive_complexity = "deny"
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index cd0a49acb91..4dc0e8f345f 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -14,28 +14,15 @@
 //! the [`registers`] module for register types.
 
 #![deny(
-    rustdoc::broken_intra_doc_links,
-    rustdoc::redundant_explicit_links,
     clippy::correctness,
     clippy::suspicious,
     clippy::complexity,
     clippy::perf,
     clippy::cargo,
     clippy::nursery,
-    clippy::style,
-    // restriction group
-    clippy::dbg_macro,
-    clippy::as_underscore,
-    clippy::assertions_on_result_states,
-    // pedantic group
-    clippy::doc_markdown,
-    clippy::borrow_as_ptr,
-    clippy::cast_lossless,
-    clippy::option_if_let_else,
-    clippy::missing_const_for_fn,
-    clippy::cognitive_complexity,
-    clippy::missing_safety_doc,
-    )]
+    clippy::style
+)]
+#![allow(clippy::upper_case_acronyms)]
 #![allow(clippy::result_unit_err)]
 
 extern crate bilge;
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 0b76ec58bee..8a9b821bb91 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -7,10 +7,10 @@
     non_snake_case,
     non_upper_case_globals,
     unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
     clippy::missing_const_for_fn,
-    clippy::too_many_arguments,
-    clippy::approx_constant,
-    clippy::use_self,
     clippy::useless_transmute,
     clippy::missing_safety_doc
 )]
-- 
2.47.0


