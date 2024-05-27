Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E2C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVGx-0004ob-Uw; Mon, 27 May 2024 03:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGE-0004ZR-2C
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:15 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGA-0004WD-SG
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716796751; x=1748332751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C/uavNm9TPbuPaD5VN1/gZbyddHCNXdVHsl2V4ClR0Q=;
 b=WQ7keHJ3fDzxiQ4t1+YIzuhqY39jLJnSq+oe+WEwl/TKvO66rBz8tbRm
 2iEdLld30Fd4QrW4rYQltU0j6q2jti1xbKn6bXLPCSwYfUbZUhbAYyrs7
 nKREo6phIAMXXZj+L3F7nk0PVnKpC37ree0ymRDBvOW/5aRdTK3C6QkjE
 B3o8O/LNCykKFwb814TlPUhRnHuzb5n5jo1kkx9gcstvnQ1SrzMqg+rAt
 8mN4S4mfZBypUEMHsqpMtDXP6JXEnCFNRxT/2XR+RKKFAQEytjsk8qssy
 +foObHVVWRmXpFgfYRHGMpTR+l8BpdjBbvVgrZ5xxJR9NkaZFORRyVbgz w==;
X-CSE-ConnectionGUID: y4PTYw7sQ8uIdzUNZ7OVTg==
X-CSE-MsgGUID: veOVoYhNRR2GNrMU6NXYkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12967721"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12967721"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 00:59:09 -0700
X-CSE-ConnectionGUID: ZsNg3/yMS06F/eWhHl4JBw==
X-CSE-MsgGUID: Ca4lDMgESfyYZ8tNP5x3cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39084961"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 00:59:05 -0700
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
Subject: [RFC 2/6] scripts/simpletrace-rust: Support Event & Arguments in
 trace module
Date: Mon, 27 May 2024 16:14:17 +0800
Message-Id: <20240527081421.2258624-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Refer to scripts/tracetool/__init__.py, add Event & Arguments
abstractions in trace module.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/simpletrace-rust/Cargo.lock   |  52 ++++
 scripts/simpletrace-rust/Cargo.toml   |   2 +
 scripts/simpletrace-rust/src/trace.rs | 330 +++++++++++++++++++++++++-
 3 files changed, 383 insertions(+), 1 deletion(-)

diff --git a/scripts/simpletrace-rust/Cargo.lock b/scripts/simpletrace-rust/Cargo.lock
index 4a0ff8092dcb..3d815014eb44 100644
--- a/scripts/simpletrace-rust/Cargo.lock
+++ b/scripts/simpletrace-rust/Cargo.lock
@@ -2,6 +2,15 @@
 # It is not intended for manual editing.
 version = 3
 
+[[package]]
+name = "aho-corasick"
+version = "1.1.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8e60d3430d3a69478ad0993f19238d2df97c507009a52b3c10addcd7f6bcb916"
+dependencies = [
+ "memchr",
+]
+
 [[package]]
 name = "anstream"
 version = "0.6.14"
@@ -90,6 +99,18 @@ version = "1.70.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "f8478577c03552c21db0e2724ffb8986a5ce7af88107e6be5d2ee6e158c12800"
 
+[[package]]
+name = "memchr"
+version = "2.7.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "6c8640c5d730cb13ebd907d8d04b52f55ac9a2eec55b440c8892f40d56c76c1d"
+
+[[package]]
+name = "once_cell"
+version = "1.19.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3fdb12b2476b595f9358c5161aa467c2438859caa136dec86c26fdd2efe17b92"
+
 [[package]]
 name = "proc-macro2"
 version = "1.0.83"
@@ -108,11 +129,42 @@ dependencies = [
  "proc-macro2",
 ]
 
+[[package]]
+name = "regex"
+version = "1.10.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c117dbdfde9c8308975b6a18d71f3f385c89461f7b3fb054288ecf2a2058ba4c"
+dependencies = [
+ "aho-corasick",
+ "memchr",
+ "regex-automata",
+ "regex-syntax",
+]
+
+[[package]]
+name = "regex-automata"
+version = "0.4.6"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "86b83b8b9847f9bf95ef68afb0b8e6cdb80f498442f5179a29fad448fcc1eaea"
+dependencies = [
+ "aho-corasick",
+ "memchr",
+ "regex-syntax",
+]
+
+[[package]]
+name = "regex-syntax"
+version = "0.8.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "adad44e29e4c806119491a7f06f03de4d1af22c3a680dd47f1e6e179439d1f56"
+
 [[package]]
 name = "simpletrace-rust"
 version = "0.1.0"
 dependencies = [
  "clap",
+ "once_cell",
+ "regex",
  "thiserror",
 ]
 
diff --git a/scripts/simpletrace-rust/Cargo.toml b/scripts/simpletrace-rust/Cargo.toml
index b44ba1569dad..24a79d04e566 100644
--- a/scripts/simpletrace-rust/Cargo.toml
+++ b/scripts/simpletrace-rust/Cargo.toml
@@ -8,4 +8,6 @@ license = "GPL-2.0-or-later"
 
 [dependencies]
 clap = "4.5.4"
+once_cell = "1.19.0"
+regex = "1.10.4"
 thiserror = "1.0.20"
diff --git a/scripts/simpletrace-rust/src/trace.rs b/scripts/simpletrace-rust/src/trace.rs
index 3a4b06435b8b..f41d6e0b5bc3 100644
--- a/scripts/simpletrace-rust/src/trace.rs
+++ b/scripts/simpletrace-rust/src/trace.rs
@@ -8,4 +8,332 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-pub struct Event {}
+#![allow(dead_code)]
+
+use std::fs::read_to_string;
+
+use once_cell::sync::Lazy;
+use regex::Regex;
+use thiserror::Error;
+
+#[derive(Error, Debug)]
+pub enum Error
+{
+    #[error("Empty argument (did you forget to use 'void'?)")]
+    EmptyArg,
+    #[error("Event '{0}' has more than maximum permitted argument count")]
+    InvalidArgCnt(String),
+    #[error("{0} does not end with a new line")]
+    InvalidEventFile(String),
+    #[error("Invalid format: {0}")]
+    InvalidFormat(String),
+    #[error(
+        "Argument type '{0}' is not allowed. \
+        Only standard C types and fixed size integer \
+        types should be used. struct, union, and \
+        other complex pointer types should be \
+        declared as 'void *'"
+    )]
+    InvalidType(String),
+    #[error("Error at {0}:{1}: {2}")]
+    ReadEventFail(String, usize, String),
+    #[error("Unknown event: {0}")]
+    UnknownEvent(String),
+    #[error("Unknown properties: {0}")]
+    UnknownProp(String),
+}
+
+pub type Result<T> = std::result::Result<T, Error>;
+
+/*
+ * Refer to the description of ALLOWED_TYPES in
+ * scripts/tracetool/__init__.py.
+ */
+const ALLOWED_TYPES: [&str; 20] = [
+    "int",
+    "long",
+    "short",
+    "char",
+    "bool",
+    "unsigned",
+    "signed",
+    "int8_t",
+    "uint8_t",
+    "int16_t",
+    "uint16_t",
+    "int32_t",
+    "uint32_t",
+    "int64_t",
+    "uint64_t",
+    "void",
+    "size_t",
+    "ssize_t",
+    "uintptr_t",
+    "ptrdiff_t",
+];
+
+const STRING_TYPES: [&str; 4] =
+    ["const char*", "char*", "const char *", "char *"];
+
+/* TODO: Support 'vcpu' property. */
+const VALID_PROPS: [&str; 1] = ["disable"];
+
+fn validate_c_type(arg_type: &str) -> Result<()>
+{
+    static RE_TYPE: Lazy<Regex> = Lazy::new(|| Regex::new(r"\*").unwrap());
+    let bits: Vec<String> =
+        arg_type.split_whitespace().map(|s| s.to_string()).collect();
+    for bit in bits {
+        let res = RE_TYPE.replace_all(&bit, "");
+        if res.is_empty() {
+            continue;
+        }
+        if res == "const" {
+            continue;
+        }
+        if !ALLOWED_TYPES.contains(&res.as_ref()) {
+            return Err(Error::InvalidType(res.to_string()));
+        }
+    }
+    Ok(())
+}
+
+pub fn read_events(fname: &str) -> Result<Vec<Event>>
+{
+    let fstr = read_to_string(fname).unwrap();
+    let lines = fstr.lines().map(|s| s.trim()).collect::<Vec<_>>();
+    let mut events = Vec::new();
+
+    /*
+     * lines() in Rust: Line terminators are not included in the lines
+     * returned by the iterator, so check whether line_str is empty.
+     */
+    for (lineno, line_str) in lines.iter().enumerate() {
+        if line_str.is_empty() || line_str.starts_with('#') {
+            continue;
+        }
+
+        let event = Event::build(line_str, lineno as u32 + 1, fname);
+        if let Err(e) = event {
+            return Err(Error::ReadEventFail(
+                fname.to_owned(),
+                lineno,
+                e.to_string(),
+            ));
+        } else {
+            events.push(event.unwrap());
+        }
+    }
+
+    Ok(events)
+}
+
+#[derive(Clone)]
+pub struct ArgProperty
+{
+    pub c_type: String,
+    pub name: String,
+}
+
+impl ArgProperty
+{
+    fn new(c_type: &str, name: &str) -> Self
+    {
+        ArgProperty {
+            c_type: c_type.to_string(),
+            name: name.to_string(),
+        }
+    }
+
+    pub fn is_string(&self) -> bool
+    {
+        let arg_strip = self.c_type.trim_start();
+        STRING_TYPES.iter().any(|&s| arg_strip.starts_with(s))
+            && arg_strip.matches('*').count() == 1
+    }
+}
+
+#[derive(Default, Clone)]
+pub struct Arguments
+{
+    /* List of (type, name) tuples or arguments properties. */
+    pub props: Vec<ArgProperty>,
+}
+
+impl Arguments
+{
+    pub fn new() -> Self
+    {
+        Arguments { props: Vec::new() }
+    }
+
+    pub fn len(&self) -> usize
+    {
+        self.props.len()
+    }
+
+    pub fn build(arg_str: &str) -> Result<Arguments>
+    {
+        let mut args = Arguments::new();
+        for arg in arg_str.split(',').map(|s| s.trim()) {
+            if arg.is_empty() {
+                return Err(Error::EmptyArg);
+            }
+
+            if arg == "void" {
+                continue;
+            }
+
+            let (arg_type, identifier) = if arg.contains('*') {
+                /* FIXME: Implement rsplit_inclusive(). */
+                let p = arg.rfind('*').unwrap();
+                (
+                    /* Safe because arg contains "*" and p exists. */
+                    unsafe { arg.get_unchecked(..p + 1) },
+                    /* Safe because arg contains "*" and p exists. */
+                    unsafe { arg.get_unchecked(p + 1..) },
+                )
+            } else {
+                arg.rsplit_once(' ').unwrap()
+            };
+
+            validate_c_type(arg_type)?;
+            args.props.push(ArgProperty::new(arg_type, identifier));
+        }
+        Ok(args)
+    }
+}
+
+/* TODO: Support original, event_trans, event_exec if needed. */
+#[derive(Default, Clone)]
+pub struct Event
+{
+    /* The event name. */
+    pub name: String,
+    /* Properties of the event. */
+    pub properties: Vec<String>,
+    /* The event format string. */
+    pub fmt: Vec<String>,
+    /* The event arguments. */
+    pub args: Arguments,
+    /* The line number in the input file. */
+    pub lineno: u32,
+    /* The path to the input file. */
+    pub filename: String,
+}
+
+impl Event
+{
+    #[allow(clippy::too_many_arguments)]
+    pub fn new(
+        name: &str,
+        mut props: Vec<String>,
+        fmt: Vec<String>,
+        args: Arguments,
+        lineno: u32,
+        filename: &str,
+    ) -> Result<Self>
+    {
+        let mut event = Event {
+            name: name.to_string(),
+            fmt: fmt.clone(),
+            args,
+            lineno,
+            filename: filename.to_string(),
+            ..Default::default()
+        };
+
+        event.properties.append(&mut props);
+
+        if event.args.len() > 10 {
+            return Err(Error::InvalidArgCnt(event.name));
+        }
+
+        let unknown_props: Vec<String> = event
+            .properties
+            .iter()
+            .filter_map(|p| {
+                if !VALID_PROPS.contains(&p.as_str()) {
+                    Some(p.to_string())
+                } else {
+                    None
+                }
+            })
+            .collect();
+        if !unknown_props.is_empty() {
+            return Err(Error::UnknownProp(format!("{:?}", unknown_props)));
+        }
+
+        if event.fmt.len() > 2 {
+            return Err(Error::InvalidFormat(
+                format!("too many arguments ({})", event.fmt.len()).to_string(),
+            ));
+        }
+
+        Ok(event)
+    }
+
+    pub fn build(line_str: &str, lineno: u32, filename: &str) -> Result<Event>
+    {
+        static RE: Lazy<Regex> = Lazy::new(|| {
+            Regex::new(
+                r#"(?x)
+                ((?P<props>[\w\s]+)\s+)?
+                (?P<name>\w+)
+                \((?P<args>[^)]*)\)
+                \s*
+                (?:(?:(?P<fmt_trans>".+),)?\s*(?P<fmt>".+))?
+                \s*"#,
+            )
+            .unwrap()
+        });
+
+        let caps_res = RE.captures(line_str);
+        if caps_res.is_none() {
+            return Err(Error::UnknownEvent(line_str.to_owned()));
+        }
+        let caps = caps_res.unwrap();
+        let name = caps.name("name").map_or("", |m| m.as_str());
+        let props: Vec<String> = if caps.name("props").is_some() {
+            caps.name("props")
+                .unwrap()
+                .as_str()
+                .split_whitespace()
+                .map(|s| s.to_string())
+                .collect()
+        } else {
+            Vec::new()
+        };
+        let fmt: String =
+            caps.name("fmt").map_or("", |m| m.as_str()).to_string();
+        let fmt_trans: String = caps
+            .name("fmt_trans")
+            .map_or("", |m| m.as_str())
+            .to_string();
+
+        if fmt.contains("%m") || fmt_trans.contains("%m") {
+            return Err(Error::InvalidFormat(
+                "Event format '%m' is forbidden, pass the error 
+                as an explicit trace argument"
+                    .to_string(),
+            ));
+        }
+        if fmt.ends_with(r"\n") {
+            return Err(Error::InvalidFormat(
+                "Event format must not end with a newline 
+                character"
+                    .to_string(),
+            ));
+        }
+        let mut fmt_vec = vec![fmt];
+        if !fmt_trans.is_empty() {
+            fmt_vec.push(fmt_trans);
+        }
+
+        let args =
+            Arguments::build(caps.name("args").map_or("", |m| m.as_str()))?;
+        let event = Event::new(name, props, fmt_vec, args, lineno, filename)?;
+
+        Ok(event)
+    }
+}
-- 
2.34.1


