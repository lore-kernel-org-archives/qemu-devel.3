Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7CFD64077
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJL-00027G-PB; Fri, 08 Nov 2024 13:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJB-0001wG-CR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ9-0001x9-9s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRie6B2XwMU0zHx1ZvLnYMj1lxmNXlFqwCtyK6n296w=;
 b=gb5OtWoZUZAmm6LnplGKp4Vqmuv3yYq9IIDGjr2yKFjxbQP/O9iAMeiacUM4eXcUXp/dor
 dczz7yy7JdfkN+jYzbNAqgl1R5SAQg8elnXrUsZ9blEEmBWwZG9ktdN0aLKJPNDTSEM2g7
 JrrOd56NalB6q5Ez5/Q8gfIddvSyQxg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-H_q54tkUOLmHzzD-dEF6yA-1; Fri, 08 Nov 2024 13:02:05 -0500
X-MC-Unique: H_q54tkUOLmHzzD-dEF6yA-1
X-Mimecast-MFC-AGG-ID: H_q54tkUOLmHzzD-dEF6yA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso14056755e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088924; x=1731693724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRie6B2XwMU0zHx1ZvLnYMj1lxmNXlFqwCtyK6n296w=;
 b=kWQVCRR3blvwIp8FlwUBYMBTpCowt5ZGDfhJxHpV1W2bGqmqLhJvEcRo/fKUm9QfH6
 22rBOIHQReY804N+knChxYvPvOej2dC5jb61cL6VelHV6/2GfARrn4y2OE/i0qo9NxEl
 ONlxcTd3qF+GC4RRb9maYF7Ce5CIi7koyFXctwzObh+ToZLb4h3X35u2anQ9rKNqn/Gb
 mmvsOcynoRJg4okGeYpqynsMhD4C5EwRqtrg/k+DaALRRNrqRU51w5JbNOKKKSHqA8jP
 GiP2UXPjWe8KHLLObB1XAPoUIPzRzarW9wF/Gea+kAH30Bg/I4r97yA1qZNL1XhcjIHy
 9PGg==
X-Gm-Message-State: AOJu0YwDgrK1YC4ancHFufY2MyC1wFsCo0K9hbX/Kg3SwRURWsiMKiW/
 UCCDMwll2+nno0k5G9JkF58tQOA8uMMObBxztpFxGWiorWWqp6XJ0Qh7lHXn+WYpqhjs12Sxq4S
 9+azKAhj9NjW79mOPekLd5zekGli8hcaLb9lmv3Y2CW66mjjvPciYy0S9+nRwy7vFBPm+JkCKOV
 1ARcoVifXUwxPjyeXZ6o+qb3ubIfAGw1g2a7Vw4cQ=
X-Received: by 2002:a05:600c:4ecf:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-432b74ce3d1mr30667225e9.14.1731088923547; 
 Fri, 08 Nov 2024 10:02:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM866rkMICirYWcCwnUjyUaInIOr2ho1v2OsM8Rf6FAwsNub8IXTuUByiv9YwghmNglIabqA==
X-Received: by 2002:a05:600c:4ecf:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-432b74ce3d1mr30666585e9.14.1731088922821; 
 Fri, 08 Nov 2024 10:02:02 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9707d3sm5523154f8f.19.2024.11.08.10.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:02:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 08/11] rust: build: establish a baseline of lints across
 all crates
Date: Fri,  8 Nov 2024 19:01:36 +0100
Message-ID: <20241108180139.117112-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml               | 66 +++++++++++++++++++++++++++++++++++
 rust/hw/char/pl011/src/lib.rs | 18 ++--------
 rust/qemu-api/src/bindings.rs |  6 ++--
 3 files changed, 71 insertions(+), 19 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 1ff8f5c2781..43cca33a8d8 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -19,3 +19,69 @@ unknown_lints = "allow"
 
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
+too_many_arguments = "allow"
+upper_case_acronyms = "allow"
+
+# default-allow lints
+as_ptr_cast_mut = "deny"
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
+ptr_cast_constness = "deny"
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
+#wildcard_imports = "deny"
+
+# these may have false positives
+#option_if_let_else = "deny"
+cognitive_complexity = "deny"
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index cd0a49acb91..3fa178cded0 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -14,28 +14,14 @@
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
 #![allow(clippy::result_unit_err)]
 
 extern crate bilge;
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 1dac310594d..972b1f1ee90 100644
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


