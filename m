Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FEAE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZ7-0001xE-63; Wed, 11 Dec 2024 11:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZ0-00017Z-Gq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYy-0000HB-LD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCokOk3/ugPdPRCt0q5O4jE4HdSTP094Z8xqn4aCSq0=;
 b=fxdxMkkLVIFP3NrrOyxXJN599rzGuuClurH83zKvA34e+gbMKl9XplHV2FAdmZvYhmJaxN
 VqiKsTUUnN3QvDRP4zxI6aAP2FoZ2ZgTq73R2aV/cyR6/PaL+l3cNtZB9io4x/M+RNH94f
 Dw5tXe6Qj5NJ+u+x3PvJRilxPyg4ARc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-yGTUkCuDNyy7uhRp1DZRcA-1; Wed, 11 Dec 2024 11:27:46 -0500
X-MC-Unique: yGTUkCuDNyy7uhRp1DZRcA-1
X-Mimecast-MFC-AGG-ID: yGTUkCuDNyy7uhRp1DZRcA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6d2ae6bc0so635707285a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934466; x=1734539266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aCokOk3/ugPdPRCt0q5O4jE4HdSTP094Z8xqn4aCSq0=;
 b=Tt9HJkFCjM2nZ+6VN5NxjZDBWBz4F1CHEmDX0GdmOSyMXKqRgtJKZSUIVSqRITwLgn
 GyGU1LxrV2ml5Zhr8mGFFfodlFaXTRlZScvqzk7y6NRxY/lrYR6XgZcdbJGmo3Cy7Yc2
 Bci1HunFoc3cb0spr3YXuErML4/O5ajatN0Io0EYiFQTkuI4IxsIDEe2PWln5q+l12Gn
 nMz963FOHpJ2TUuWc2v4WEO0Kewh158m02TogAlNj5+g0hcdssAuKlAcdAo4DcG82S7N
 VMOY574qEi5vGkc4DjtHthYHMcPiKYZt3bbmjf46hWkIhwXjf6haa/5vvn+Qzk4zM7B5
 Fgzg==
X-Gm-Message-State: AOJu0YwmL1oVinSoKzye9Mw/Yscuks8vJBklmvjng1uCS0Ugg5jAurvP
 wVTJY1TMusQh6xfuOdKBtXRv6AclC56rWQ7pZiu10xSw8NKTtUMEmRXLIgGjZTqRAAfBLqr2h6V
 551gDnDaUnk+EX6lufgOqcLhvzBSjdO8HQQQmBSnRaIIXiMbrksCEg9F77wKn/eqRbcV958X3f5
 BIV0jTqY9y29c8eGk8EerXw5rH17dEXX7ZpbG8
X-Gm-Gg: ASbGncsXnvt3P0NJqwtR+6gXM3GvveT6PkytfLub2R+PSBBYF2a3mAncm2szGtDTmER
 B7Af9zQT+eYGEgHJhIFIb0NobkIWU1gLgYBHbJphvhpb94IMciOhJGZTrK9sxEdmGzh6tdXSLHD
 IrA7X5Kv0agEWyauukFCeE8+pKCNbgSnzrFT584n5uvth3+HS5Ij3KI6ZUEfGbU9q0yVf+dTm0X
 OuvVEHluRj+Pv/7CjN8NUplJgvMI8dednolC8leEiYXqozk+UFysp08
X-Received: by 2002:a05:620a:1a9d:b0:7b1:5089:485b with SMTP id
 af79cd13be357-7b6eb4202abmr624675985a.3.1733934465163; 
 Wed, 11 Dec 2024 08:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS/4SqzqsAHfG9+nQsmZ4AVU87E5NRsWfBZmoh+8vHmlaHeKAX7VWcUJy2yTzF97D7gBHkxg==
X-Received: by 2002:a05:620a:1a9d:b0:7b1:5089:485b with SMTP id
 af79cd13be357-7b6eb4202abmr624672285a.3.1733934464801; 
 Wed, 11 Dec 2024 08:27:44 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6ed704f9csm57196185a.32.2024.12.11.08.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>
Subject: [PULL 10/49] rust: build: establish a baseline of lints across all
 crates
Date: Wed, 11 Dec 2024 17:26:40 +0100
Message-ID: <20241211162720.320070-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml               | 68 +++++++++++++++++++++++++++++++++++
 rust/hw/char/pl011/src/lib.rs | 19 ++--------
 rust/qemu-api/src/bindings.rs |  6 ++--
 3 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 358c517bc56..6ec19b67297 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -19,3 +19,71 @@ unknown_lints = "allow"
 
 # Prohibit code that is forbidden in Rust 2024
 unsafe_op_in_unsafe_fn = "deny"
+
+[workspace.lints.rustdoc]
+private_intra_doc_links = "allow"
+
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
+# can be for a reason, e.g. in callbacks
+unused_self = "allow"
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
2.47.1


