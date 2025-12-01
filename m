Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAA0D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ20O-0008U0-55; Mon, 01 Dec 2025 06:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20F-0008Qz-1a
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:23:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20D-0006V6-51
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTK98tro9wmYGZ1MH4F+lDO9TW79M2ScIbCtTuhv8hA=;
 b=YSZ5S90JC/+nr/50+jCrS6povzjEs4yqH51Vxt77Mx1l8H6ShcXkSQSHuLwUfP2bN8uo0t
 L+GXXYcJt+1QQN551qDIwuaziN3O+tUjhH2z5Til87Acjht5oF+SsK+2Oh5Qs0tXZPxuYg
 ilYEG+12S/Ei79RkBt3+Jn4bjz0Kbr0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-8oC3YkLsPsyynibW5Mn4uA-1; Mon,
 01 Dec 2025 06:23:25 -0500
X-MC-Unique: 8oC3YkLsPsyynibW5Mn4uA-1
X-Mimecast-MFC-AGG-ID: 8oC3YkLsPsyynibW5Mn4uA_1764588203
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09D2518002C2; Mon,  1 Dec 2025 11:23:23 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA438180047F; Mon,  1 Dec 2025 11:23:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 01/24] rust: patch thiserror to work with meson
Date: Mon,  1 Dec 2025 15:22:42 +0400
Message-ID: <20251201112309.4163921-2-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Some dependencies introduced in the following patches require thiserror.
Since 2.0.17, it "Use differently named __private module per patch
release", using build.rs time generated code. This is not handled by meson.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .../packagefiles/syn-2-rs/meson/meson.build        |  3 +++
 .../packagefiles/thiserror-2.0.17-include.patch    | 14 ++++++++++++++
 .../thiserror-impl-2.0.17-include.patch            | 13 +++++++++++++
 subprojects/syn-2-rs.wrap                          | 11 ++++++-----
 subprojects/thiserror-2-rs.wrap                    | 10 ++++++++++
 subprojects/thiserror-impl-2-rs.wrap               | 10 ++++++++++
 6 files changed, 56 insertions(+), 5 deletions(-)
 create mode 100644 subprojects/packagefiles/syn-2-rs/meson/meson.build
 create mode 100644 subprojects/packagefiles/thiserror-2.0.17-include.patch
 create mode 100644 subprojects/packagefiles/thiserror-impl-2.0.17-include.patch
 create mode 100644 subprojects/thiserror-2-rs.wrap
 create mode 100644 subprojects/thiserror-impl-2-rs.wrap

diff --git a/subprojects/packagefiles/syn-2-rs/meson/meson.build b/subprojects/packagefiles/syn-2-rs/meson/meson.build
new file mode 100644
index 0000000000..02439c2b58
--- /dev/null
+++ b/subprojects/packagefiles/syn-2-rs/meson/meson.build
@@ -0,0 +1,3 @@
+extra_args += [
+    '--cfg', 'feature="full"',
+]
diff --git a/subprojects/packagefiles/thiserror-2.0.17-include.patch b/subprojects/packagefiles/thiserror-2.0.17-include.patch
new file mode 100644
index 0000000000..a061aeea57
--- /dev/null
+++ b/subprojects/packagefiles/thiserror-2.0.17-include.patch
@@ -0,0 +1,14 @@
+diff --git a/src/lib.rs b/src/lib.rs
+index 155272d..7683f4c 100644
+--- a/src/lib.rs
++++ b/src/lib.rs
+@@ -288,4 +288,8 @@ pub use thiserror_impl::*;
+ 
+ mod private;
+ 
+-include!(concat!(env!("OUT_DIR"), "/private.rs"));
++#[doc(hidden)]
++pub mod __private_MESON {
++    #[doc(hidden)]
++    pub use crate::private::*;
++}
diff --git a/subprojects/packagefiles/thiserror-impl-2.0.17-include.patch b/subprojects/packagefiles/thiserror-impl-2.0.17-include.patch
new file mode 100644
index 0000000000..372862dffa
--- /dev/null
+++ b/subprojects/packagefiles/thiserror-impl-2.0.17-include.patch
@@ -0,0 +1,13 @@
+diff --git a/impl/src/lib.rs b/impl/src/lib.rs
+index 25890f2..1559a41 100644
+--- a/src/lib.rs
++++ b/src/lib.rs
+@@ -48,7 +48,7 @@ struct private;
+ impl ToTokens for private {
+     fn to_tokens(&self, tokens: &mut proc_macro2::TokenStream) {
+         tokens.append(Ident::new(
+-            concat!("__private", env!("CARGO_PKG_VERSION_PATCH")),
++            concat!("__private", "_MESON"),
+             Span::call_site(),
+         ));
+     }
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index 8ec7fd0052..82675e8723 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -1,9 +1,10 @@
 [wrap-file]
-directory = syn-2.0.104
-source_url = https://crates.io/api/v1/crates/syn/2.0.104/download
-source_filename = syn-2.0.104.0.tar.gz
-source_hash = 17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40
+directory = syn-2.0.110
+source_url = https://crates.io/api/v1/crates/syn/2.0.110/download
+source_filename = syn-2.0.110.tar.gz
+source_hash = a99801b5bd34ede4cf3fc688c5919368fea4e4814a4664359503e6015b280aea
 method = cargo
+patch_directory = syn-2-rs
 
 # bump this version number on every change to meson.build or the patches:
-# v3
+# v4
diff --git a/subprojects/thiserror-2-rs.wrap b/subprojects/thiserror-2-rs.wrap
new file mode 100644
index 0000000000..432d99d937
--- /dev/null
+++ b/subprojects/thiserror-2-rs.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = thiserror-2.0.17
+source_url = https://crates.io/api/v1/crates/thiserror/2.0.17/download
+source_filename = thiserror-2.0.17.tar.gz
+source_hash = f63587ca0f12b72a0600bcba1d40081f830876000bb46dd2337a3051618f4fc8
+method = cargo
+diff_files = thiserror-2.0.17-include.patch
+
+# bump this version number on every change to meson.build or the patches:
+# v2
diff --git a/subprojects/thiserror-impl-2-rs.wrap b/subprojects/thiserror-impl-2-rs.wrap
new file mode 100644
index 0000000000..f0eb263607
--- /dev/null
+++ b/subprojects/thiserror-impl-2-rs.wrap
@@ -0,0 +1,10 @@
+[wrap-file]
+directory = thiserror-impl-2.0.17
+source_url = https://crates.io/api/v1/crates/thiserror-impl/2.0.17/download
+source_filename = thiserror-impl-2.0.17.tar.gz
+source_hash = 3ff15c8ecd7de3849db632e14d18d2571fa09dfc5ed93479bc4485c7a517c913
+method = cargo
+diff_files = thiserror-impl-2.0.17-include.patch
+
+# bump this version number on every change to meson.build or the patches:
+# v2
-- 
2.51.1


