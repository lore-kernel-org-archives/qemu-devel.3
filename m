Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D2CC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVHE-0004tG-Mz; Mon, 27 May 2024 04:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGN-0004fH-QZ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:25 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVG7-0004Vy-Ao
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716796747; x=1748332747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WIiMy5ieHYZlDBKxx9ayAEu7brMWY9XnH0Rv5GgqqoE=;
 b=d4QfYj5IoW279a2StXKcrN+H9wiU84twZ8/X2u/jHefsXy7+RtpNNiG7
 V6Fxwi1yPCwmUS5AW1kIepK+XpU2UyvCNXpKA/Y89VKiJjeTyk3bn1vzg
 gdQ9hhJ2eJMxI8OnFdF1da5KC1DwFLS/HY6qcP5VzSBL5495Z9RC93j0o
 rCHs0lAMe6tHyE4QdNwDfGOj0DRA4jw31rAwg6fsUbTyR5OsDuVWAwBI+
 Dq3bLrIL0488xvSBbyfciXTtClMb/o664nFIrtOt0WMClIpM2bCqct/fw
 5G9BaDriNy2As735FKkJipaOVqoGsXzB1ClS3MSyP3O5iJqhYqBERS7mP g==;
X-CSE-ConnectionGUID: N/+X4kOuRLW6bUK7H05qyg==
X-CSE-MsgGUID: U+t4B99OS3S6d62bFe6hvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12967714"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12967714"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 00:59:06 -0700
X-CSE-ConnectionGUID: n8MBLThMSv+hxAKfJWiQyQ==
X-CSE-MsgGUID: Qo0fSpeLQPeDJeWka7rRSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39084953"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 00:59:02 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 1/6] scripts/simpletrace-rust: Add the basic cargo framework
Date: Mon, 27 May 2024 16:14:16 +0800
Message-Id: <20240527081421.2258624-2-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Define the basic cargo framework to support compiling simpletrace-rust
via cargo, and add the Rust code style (with some nightly features)
check items to make Rust style as close to the QEMU C code as possible.

With the base cargo package, define the basic code framework for
simpletrace-rust, approximating the Python version, and also abstract
Analyzer operations for simpletrace-rust. Event and other future
trace-related structures are placed in the trace module.

Additionally, support basic command line parsing for simpletrace-rust as
a start.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/simpletrace-rust/.gitignore    |   1 +
 scripts/simpletrace-rust/.rustfmt.toml |   9 +
 scripts/simpletrace-rust/Cargo.lock    | 239 +++++++++++++++++++++++++
 scripts/simpletrace-rust/Cargo.toml    |  11 ++
 scripts/simpletrace-rust/src/main.rs   | 173 ++++++++++++++++++
 scripts/simpletrace-rust/src/trace.rs  |  11 ++
 6 files changed, 444 insertions(+)
 create mode 100644 scripts/simpletrace-rust/.gitignore
 create mode 100644 scripts/simpletrace-rust/.rustfmt.toml
 create mode 100644 scripts/simpletrace-rust/Cargo.lock
 create mode 100644 scripts/simpletrace-rust/Cargo.toml
 create mode 100644 scripts/simpletrace-rust/src/main.rs
 create mode 100644 scripts/simpletrace-rust/src/trace.rs

diff --git a/scripts/simpletrace-rust/.gitignore b/scripts/simpletrace-rust/.gitignore
new file mode 100644
index 000000000000..2f7896d1d136
--- /dev/null
+++ b/scripts/simpletrace-rust/.gitignore
@@ -0,0 +1 @@
+target/
diff --git a/scripts/simpletrace-rust/.rustfmt.toml b/scripts/simpletrace-rust/.rustfmt.toml
new file mode 100644
index 000000000000..97a97c24ebfb
--- /dev/null
+++ b/scripts/simpletrace-rust/.rustfmt.toml
@@ -0,0 +1,9 @@
+brace_style = "AlwaysNextLine"
+comment_width = 80
+edition = "2021"
+group_imports = "StdExternalCrate"
+imports_granularity = "item"
+max_width = 80
+use_field_init_shorthand = true
+use_try_shorthand = true
+wrap_comments = true
diff --git a/scripts/simpletrace-rust/Cargo.lock b/scripts/simpletrace-rust/Cargo.lock
new file mode 100644
index 000000000000..4a0ff8092dcb
--- /dev/null
+++ b/scripts/simpletrace-rust/Cargo.lock
@@ -0,0 +1,239 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "anstream"
+version = "0.6.14"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "418c75fa768af9c03be99d17643f93f79bbba589895012a80e3452a19ddda15b"
+dependencies = [
+ "anstyle",
+ "anstyle-parse",
+ "anstyle-query",
+ "anstyle-wincon",
+ "colorchoice",
+ "is_terminal_polyfill",
+ "utf8parse",
+]
+
+[[package]]
+name = "anstyle"
+version = "1.0.7"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "038dfcf04a5feb68e9c60b21c9625a54c2c0616e79b72b0fd87075a056ae1d1b"
+
+[[package]]
+name = "anstyle-parse"
+version = "0.2.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c03a11a9034d92058ceb6ee011ce58af4a9bf61491aa7e1e59ecd24bd40d22d4"
+dependencies = [
+ "utf8parse",
+]
+
+[[package]]
+name = "anstyle-query"
+version = "1.0.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a64c907d4e79225ac72e2a354c9ce84d50ebb4586dee56c82b3ee73004f537f5"
+dependencies = [
+ "windows-sys",
+]
+
+[[package]]
+name = "anstyle-wincon"
+version = "3.0.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "61a38449feb7068f52bb06c12759005cf459ee52bb4adc1d5a7c4322d716fb19"
+dependencies = [
+ "anstyle",
+ "windows-sys",
+]
+
+[[package]]
+name = "clap"
+version = "4.5.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "90bc066a67923782aa8515dbaea16946c5bcc5addbd668bb80af688e53e548a0"
+dependencies = [
+ "clap_builder",
+]
+
+[[package]]
+name = "clap_builder"
+version = "4.5.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ae129e2e766ae0ec03484e609954119f123cc1fe650337e155d03b022f24f7b4"
+dependencies = [
+ "anstream",
+ "anstyle",
+ "clap_lex",
+ "strsim",
+]
+
+[[package]]
+name = "clap_lex"
+version = "0.7.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "98cc8fbded0c607b7ba9dd60cd98df59af97e84d24e49c8557331cfc26d301ce"
+
+[[package]]
+name = "colorchoice"
+version = "1.0.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0b6a852b24ab71dffc585bcb46eaf7959d175cb865a7152e35b348d1b2960422"
+
+[[package]]
+name = "is_terminal_polyfill"
+version = "1.70.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f8478577c03552c21db0e2724ffb8986a5ce7af88107e6be5d2ee6e158c12800"
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.83"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0b33eb56c327dec362a9e55b3ad14f9d2f0904fb5a5b03b513ab5465399e9f43"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.36"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "simpletrace-rust"
+version = "0.1.0"
+dependencies = [
+ "clap",
+ "thiserror",
+]
+
+[[package]]
+name = "strsim"
+version = "0.11.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7da8b5736845d9f2fcb837ea5d9e2628564b3b043a70948a3f0b778838c5fb4f"
+
+[[package]]
+name = "syn"
+version = "2.0.66"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "thiserror"
+version = "1.0.61"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c546c80d6be4bc6a00c0f01730c08df82eaa7a7a61f11d656526506112cc1709"
+dependencies = [
+ "thiserror-impl",
+]
+
+[[package]]
+name = "thiserror-impl"
+version = "1.0.61"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "46c3384250002a6d5af4d114f2845d37b57521033f30d5c3f46c4d70e1197533"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.12"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
+
+[[package]]
+name = "utf8parse"
+version = "0.2.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "711b9620af191e0cdc7468a8d14e709c3dcdb115b36f838e601583af800a370a"
+
+[[package]]
+name = "windows-sys"
+version = "0.52.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
+dependencies = [
+ "windows-targets",
+]
+
+[[package]]
+name = "windows-targets"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "6f0713a46559409d202e70e28227288446bf7841d3211583a4b53e3f6d96e7eb"
+dependencies = [
+ "windows_aarch64_gnullvm",
+ "windows_aarch64_msvc",
+ "windows_i686_gnu",
+ "windows_i686_gnullvm",
+ "windows_i686_msvc",
+ "windows_x86_64_gnu",
+ "windows_x86_64_gnullvm",
+ "windows_x86_64_msvc",
+]
+
+[[package]]
+name = "windows_aarch64_gnullvm"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7088eed71e8b8dda258ecc8bac5fb1153c5cffaf2578fc8ff5d61e23578d3263"
+
+[[package]]
+name = "windows_aarch64_msvc"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "9985fd1504e250c615ca5f281c3f7a6da76213ebd5ccc9561496568a2752afb6"
+
+[[package]]
+name = "windows_i686_gnu"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "88ba073cf16d5372720ec942a8ccbf61626074c6d4dd2e745299726ce8b89670"
+
+[[package]]
+name = "windows_i686_gnullvm"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "87f4261229030a858f36b459e748ae97545d6f1ec60e5e0d6a3d32e0dc232ee9"
+
+[[package]]
+name = "windows_i686_msvc"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "db3c2bf3d13d5b658be73463284eaf12830ac9a26a90c717b7f771dfe97487bf"
+
+[[package]]
+name = "windows_x86_64_gnu"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4e4246f76bdeff09eb48875a0fd3e2af6aada79d409d33011886d3e1581517d9"
+
+[[package]]
+name = "windows_x86_64_gnullvm"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "852298e482cd67c356ddd9570386e2862b5673c85bd5f88df9ab6802b334c596"
+
+[[package]]
+name = "windows_x86_64_msvc"
+version = "0.52.5"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "bec47e5bfd1bff0eeaf6d8b485cc1074891a197ab4225d504cb7a1ab88b02bf0"
diff --git a/scripts/simpletrace-rust/Cargo.toml b/scripts/simpletrace-rust/Cargo.toml
new file mode 100644
index 000000000000..b44ba1569dad
--- /dev/null
+++ b/scripts/simpletrace-rust/Cargo.toml
@@ -0,0 +1,11 @@
+[package]
+name = "simpletrace-rust"
+description = "Pretty-printer for simple trace backend binary trace files (Rust version)"
+version = "0.1.0"
+edition = "2021"
+authors = ["Zhao Liu <zhao1.liu@intel.com>"]
+license = "GPL-2.0-or-later"
+
+[dependencies]
+clap = "4.5.4"
+thiserror = "1.0.20"
diff --git a/scripts/simpletrace-rust/src/main.rs b/scripts/simpletrace-rust/src/main.rs
new file mode 100644
index 000000000000..2d2926b7658d
--- /dev/null
+++ b/scripts/simpletrace-rust/src/main.rs
@@ -0,0 +1,173 @@
+/*
+ * Pretty-printer for simple trace backend binary trace files (Rust version)
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Authors: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#![allow(dead_code)]
+#![allow(unused_variables)]
+
+mod trace;
+
+use std::env;
+
+use clap::Arg;
+use clap::Command;
+use thiserror::Error;
+use trace::Event;
+
+#[derive(Error, Debug)]
+pub enum Error
+{
+    #[error("usage: {0} [--no-header] <trace-events> <trace-file>")]
+    CliOptionUnmatch(String),
+}
+
+pub type Result<T> = std::result::Result<T, Error>;
+
+pub struct EventArgPayload {}
+
+trait Analyzer
+{
+    /* Called at the start of the trace. */
+    fn begin(&self) {}
+
+    /* Called if no specific method for processing a trace event. */
+    fn catchall(
+        &mut self,
+        rec_args: &[EventArgPayload],
+        event: &Event,
+        timestamp_ns: u64,
+        pid: u32,
+        event_id: u64,
+    ) -> Result<String>;
+
+    /* Called at the end of the trace. */
+    fn end(&self) {}
+
+    /*
+     * TODO: Support "variable" parameters (i.e. variants of process_event()
+     * with different parameters, like **kwargs in python), when we need a
+     * simpletrace rust module.
+     */
+    fn process_event(
+        &mut self,
+        rec_args: &[EventArgPayload],
+        event: &Event,
+        event_id: u64,
+        timestamp_ns: u64,
+        pid: u32,
+    ) -> Result<String>
+    {
+        self.catchall(rec_args, event, timestamp_ns, pid, event_id)
+
+        /*
+         * TODO: Support custom function hooks (like getattr() in python),
+         * when we need a simpletrace rust module.
+         */
+    }
+}
+
+struct Formatter
+{
+    last_timestamp_ns: Option<u64>,
+}
+
+impl Formatter
+{
+    fn new() -> Self
+    {
+        Formatter {
+            last_timestamp_ns: None,
+        }
+    }
+}
+
+impl Analyzer for Formatter
+{
+    fn catchall(
+        &mut self,
+        rec_args: &[EventArgPayload],
+        event: &Event,
+        timestamp_ns: u64,
+        pid: u32,
+        event_id: u64,
+    ) -> Result<String>
+    {
+        let fmt_str = String::new();
+
+        Ok(fmt_str)
+    }
+}
+
+fn process(
+    event_path: &str,
+    trace_path: &str,
+    analyzer: &mut Formatter,
+    read_header: bool,
+) -> Result<()>
+{
+    analyzer.begin();
+    analyzer.end();
+
+    Ok(())
+}
+
+/*
+ * Execute an analyzer on a trace file given on the command-line.
+ * This function is useful as a driver for simple analysis scripts.  More
+ * advanced scripts will want to call process() instead.
+ */
+fn run(analyzer: &mut Formatter) -> Result<()>
+{
+    let matches = Command::new("simple trace")
+        .arg(
+            Arg::new("no-header")
+                .required(false)
+                .long("no-header")
+                .action(clap::ArgAction::SetTrue)
+                .help("Disable header parsing"),
+        )
+        .arg(
+            Arg::new("trace-events")
+                .required(true)
+                .action(clap::ArgAction::Set)
+                .help("Path to trace events file"),
+        )
+        .arg(
+            Arg::new("trace-file")
+                .required(true)
+                .action(clap::ArgAction::Set)
+                .help("Path to trace file"),
+        )
+        .try_get_matches()
+        .map_err(|_| {
+            Error::CliOptionUnmatch(
+                env::current_exe()
+                    .unwrap_or_else(|_| "simpletrace".into())
+                    .to_string_lossy()
+                    .to_string(),
+            )
+        })?;
+
+    let no_header = matches.get_flag("no-header");
+    let event_path = matches.get_one::<String>("trace-events").unwrap();
+    let trace_path = matches.get_one::<String>("trace-file").unwrap();
+
+    process(event_path, trace_path, analyzer, !no_header)?;
+
+    Ok(())
+}
+
+fn main()
+{
+    let mut fmt = Formatter::new();
+
+    if let Err(e) = run(&mut fmt) {
+        println!("{:?}", e.to_string());
+    }
+}
diff --git a/scripts/simpletrace-rust/src/trace.rs b/scripts/simpletrace-rust/src/trace.rs
new file mode 100644
index 000000000000..3a4b06435b8b
--- /dev/null
+++ b/scripts/simpletrace-rust/src/trace.rs
@@ -0,0 +1,11 @@
+/*
+ * Machinery for generating tracing-related intermediate files (Rust version)
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Authors: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+pub struct Event {}
-- 
2.34.1


