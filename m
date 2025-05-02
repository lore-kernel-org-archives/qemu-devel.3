Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE9C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAxw1-0001xn-0F; Fri, 02 May 2025 17:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1uAxvx-0001wo-Tz
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:28:38 -0400
Received: from out-172.mta1.migadu.com ([2001:41d0:203:375::ac])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <git@zabka.it>) id 1uAxvv-0007pY-NM
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:28:37 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zabka.it; s=key1;
 t=1746221303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G81BfccK7MS0TBnTZXSLUThuwTkKFovrgmmnJbtd21Y=;
 b=ZcqySQORLN+gZw5Tlw/4q0rMZNWH04pvErjaRkd5ZriLchxuHZp9GrSb7XnuR4JFEelP4u
 tBTUvFK2+niv+U0BrhYmGdZJyWr3BJZowFHLSmGaxxBtuD0Jfq+pkHNk87aa3UW6eiOl00
 XbeozJv4lXnDK7iD5GOKzxXgg6hMhso=
From: Stefan Zabka <git@zabka.it>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Stefan Zabka <git@zabka.it>
Subject: [PATCH] rust: centralize config in workspace root
Date: Fri,  2 May 2025 23:27:48 +0200
Message-ID: <20250502212748.124953-1-git@zabka.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ac; envelope-from=git@zabka.it;
 helo=out-172.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

This commit bundles common config option in the workspace
root and applies them through <config>.workspace = true

Signed-off-by: Stefan Zabka <git@zabka.it>
---
 rust/Cargo.toml                 |  7 +++++++
 rust/hw/char/pl011/Cargo.toml   | 11 ++++++-----
 rust/hw/timer/hpet/Cargo.toml   |  9 ++++++---
 rust/qemu-api-macros/Cargo.toml | 11 ++++++-----
 rust/qemu-api/Cargo.toml        | 15 +++++++--------
 5 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index ab1185a8143..5ace47c69be 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -7,6 +7,13 @@ members = [
     "hw/timer/hpet",
 ]
 
+[workspace.package]
+edition = "2021"
+homepage = "https://www.qemu.org"
+license = "GPL-2.0-or-later"
+repository = "https://gitlab.com/qemu-project/qemu/"
+rust-version = "1.63.0"
+
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
     'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index f2296cad58b..a1f431ab4a3 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -1,15 +1,16 @@
 [package]
 name = "pl011"
 version = "0.1.0"
-edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-license = "GPL-2.0-or-later"
 description = "pl011 device model for QEMU"
 resolver = "2"
 publish = false
-keywords = []
-categories = []
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 147f216e725..6f075027843 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -1,11 +1,14 @@
 [package]
 name = "hpet"
 version = "0.1.0"
-edition = "2021"
 authors = ["Zhao Liu <zhao1.liu@intel.com>"]
-license = "GPL-2.0-or-later"
 description = "IA-PC High Precision Event Timer emulation in Rust"
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index 89dee1cfb39..0cd40c8e168 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -1,15 +1,16 @@
 [package]
 name = "qemu_api_macros"
 version = "0.1.0"
-edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-license = "GPL-2.0-or-later"
 description = "Rust bindings for QEMU - Utility macros"
 resolver = "2"
 publish = false
-keywords = []
-categories = []
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [lib]
 proc-macro = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 57747bc9341..ca1b04269fd 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -1,18 +1,17 @@
 [package]
 name = "qemu_api"
 version = "0.1.0"
-edition = "2021"
 authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-license = "GPL-2.0-or-later"
-readme = "README.md"
-homepage = "https://www.qemu.org"
 description = "Rust bindings for QEMU"
-repository = "https://gitlab.com/qemu-project/qemu/"
+readme = "README.md"
 resolver = "2"
 publish = false
-keywords = []
-categories = []
-rust-version = "1.63.0"
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
-- 
2.49.0


