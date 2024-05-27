Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC19DC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVGj-0004lU-O8; Mon, 27 May 2024 03:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGI-0004e6-V9
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:19 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGF-0004WD-Ln
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716796756; x=1748332756;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yDPEzWhxxW02VCtTc002sd0aS9LHwc20MSP+Cf+0a50=;
 b=BhJrSc14LR1iWmd7y6l23e4euJiKVdxbZCXIo1BmDxQZqQ5Lds44W8tj
 q/KWmOnMcXOKS+lPSF93grgcN5iDWrEEs4bLQdzL1KF3QJU4cbxDGMpm7
 lZoETuxwXDEJZk7PgruFXWIsVE4osDXczs9he9rIR522bKVru/HqxqfG9
 5t2Oim3rDHH9C8m5Bs626iR9mQ5w9fSzv8s3LCyAtUq5Vdzb9hiUT/iMe
 7FvoZZLYD+Na16kQTnUiAOeVlvkoNcL1YTqgCdAPOMi35UBVtbW+t1mkr
 nIF2mk2UoaNrh3z5pPPGjmb+5lVa0Veh/cHMMbOO67cLic2QYbZdGT9o9 Q==;
X-CSE-ConnectionGUID: sK6v5+q0Timi6Q/WkKvreg==
X-CSE-MsgGUID: HbXGj1cqTleeCHvLEZh/lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12967735"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12967735"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 00:59:15 -0700
X-CSE-ConnectionGUID: sDKw6Tu4SwiBxSLROdAUCg==
X-CSE-MsgGUID: btAnab6dQImBbzT0Pzq7TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39084995"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 00:59:11 -0700
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
Subject: [RFC 4/6] scripts/simpletrace-rust: Parse and check trace recode file
Date: Mon, 27 May 2024 16:14:19 +0800
Message-Id: <20240527081421.2258624-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Refer to scripts/simpletrace.py, parse and check the simple trace
backend binary trace file.

Note, in order to keep certain backtrace information to get frame,
adjust the cargo debug level for release version to "line-tables-only",
which slows down the program, but is necessary.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/simpletrace-rust/Cargo.lock  |  79 +++++++++
 scripts/simpletrace-rust/Cargo.toml  |   4 +
 scripts/simpletrace-rust/src/main.rs | 253 ++++++++++++++++++++++++++-
 3 files changed, 329 insertions(+), 7 deletions(-)

diff --git a/scripts/simpletrace-rust/Cargo.lock b/scripts/simpletrace-rust/Cargo.lock
index 3d815014eb44..37d80974ffe7 100644
--- a/scripts/simpletrace-rust/Cargo.lock
+++ b/scripts/simpletrace-rust/Cargo.lock
@@ -2,6 +2,21 @@
 # It is not intended for manual editing.
 version = 3
 
+[[package]]
+name = "addr2line"
+version = "0.21.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "8a30b2e23b9e17a9f90641c7ab1549cd9b44f296d3ccbf309d2863cfe398a0cb"
+dependencies = [
+ "gimli",
+]
+
+[[package]]
+name = "adler"
+version = "1.0.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "f26201604c87b1e01bd3d98f8d5d9a8fcbb815e8cedb41ffccbeb4bf593a35fe"
+
 [[package]]
 name = "aho-corasick"
 version = "1.1.3"
@@ -60,6 +75,33 @@ dependencies = [
  "windows-sys",
 ]
 
+[[package]]
+name = "backtrace"
+version = "0.3.71"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "26b05800d2e817c8b3b4b54abd461726265fa9789ae34330622f2db9ee696f9d"
+dependencies = [
+ "addr2line",
+ "cc",
+ "cfg-if",
+ "libc",
+ "miniz_oxide",
+ "object",
+ "rustc-demangle",
+]
+
+[[package]]
+name = "cc"
+version = "1.0.98"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "41c270e7540d725e65ac7f1b212ac8ce349719624d7bcff99f8e2e488e8cf03f"
+
+[[package]]
+name = "cfg-if"
+version = "1.0.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "baf1de4339761588bc0619e3cbc0120ee582ebb74b53b4efbf79117bd2da40fd"
+
 [[package]]
 name = "clap"
 version = "4.5.4"
@@ -93,18 +135,48 @@ version = "1.0.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "0b6a852b24ab71dffc585bcb46eaf7959d175cb865a7152e35b348d1b2960422"
 
+[[package]]
+name = "gimli"
+version = "0.28.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "4271d37baee1b8c7e4b708028c57d816cf9d2434acb33a549475f78c181f6253"
+
 [[package]]
 name = "is_terminal_polyfill"
 version = "1.70.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "f8478577c03552c21db0e2724ffb8986a5ce7af88107e6be5d2ee6e158c12800"
 
+[[package]]
+name = "libc"
+version = "0.2.155"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
+
 [[package]]
 name = "memchr"
 version = "2.7.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "6c8640c5d730cb13ebd907d8d04b52f55ac9a2eec55b440c8892f40d56c76c1d"
 
+[[package]]
+name = "miniz_oxide"
+version = "0.7.3"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "87dfd01fe195c66b572b37921ad8803d010623c0aca821bea2302239d155cdae"
+dependencies = [
+ "adler",
+]
+
+[[package]]
+name = "object"
+version = "0.32.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a6a622008b6e321afc04970976f62ee297fdbaa6f95318ca343e3eebb9648441"
+dependencies = [
+ "memchr",
+]
+
 [[package]]
 name = "once_cell"
 version = "1.19.0"
@@ -158,10 +230,17 @@ version = "0.8.3"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "adad44e29e4c806119491a7f06f03de4d1af22c3a680dd47f1e6e179439d1f56"
 
+[[package]]
+name = "rustc-demangle"
+version = "0.1.24"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "719b953e2095829ee67db738b3bfa9fa368c94900df327b3f07fe6e794d2fe1f"
+
 [[package]]
 name = "simpletrace-rust"
 version = "0.1.0"
 dependencies = [
+ "backtrace",
  "clap",
  "once_cell",
  "regex",
diff --git a/scripts/simpletrace-rust/Cargo.toml b/scripts/simpletrace-rust/Cargo.toml
index 24a79d04e566..23a3179de01c 100644
--- a/scripts/simpletrace-rust/Cargo.toml
+++ b/scripts/simpletrace-rust/Cargo.toml
@@ -7,7 +7,11 @@ authors = ["Zhao Liu <zhao1.liu@intel.com>"]
 license = "GPL-2.0-or-later"
 
 [dependencies]
+backtrace = "0.3"
 clap = "4.5.4"
 once_cell = "1.19.0"
 regex = "1.10.4"
 thiserror = "1.0.20"
+
+[profile.release]
+debug = "line-tables-only"
diff --git a/scripts/simpletrace-rust/src/main.rs b/scripts/simpletrace-rust/src/main.rs
index b3b8baee7c66..f9a71d8dc243 100644
--- a/scripts/simpletrace-rust/src/main.rs
+++ b/scripts/simpletrace-rust/src/main.rs
@@ -13,17 +13,24 @@
 
 mod trace;
 
+use std::collections::HashMap;
 use std::env;
 use std::fs::File;
 use std::io::Error as IOError;
 use std::io::ErrorKind;
 use std::io::Read;
+use std::mem::size_of;
 
+use backtrace::Backtrace;
 use clap::Arg;
 use clap::Command;
 use thiserror::Error;
 use trace::Event;
 
+const DROPPED_EVENT_ID: u64 = 0xfffffffffffffffe;
+const HEADER_MAGIC: u64 = 0xf2b177cb0aa429b4;
+const HEADER_EVENT_ID: u64 = 0xffffffffffffffff;
+
 const RECORD_TYPE_MAPPING: u64 = 0;
 const RECORD_TYPE_EVENT: u64 = 1;
 
@@ -32,10 +39,25 @@ pub enum Error
 {
     #[error("usage: {0} [--no-header] <trace-events> <trace-file>")]
     CliOptionUnmatch(String),
+    #[error("Invalid event name ({0})")]
+    InvalidEventName(String),
+    #[error("Not a valid trace file, header id {0} != {1}")]
+    InvalidHeaderId(u64, u64),
+    #[error("Not a valid trace file, header magic {0} != {1}")]
+    InvalidHeaderMagic(u64, u64),
     #[error("Failed to read file: {0}")]
     ReadFile(IOError),
+    #[error(
+        "event {0} is logged but is not declared in the trace events \
+        file, try using trace-events-all instead."
+    )]
+    UnknownEvent(String),
     #[error("Unknown record type ({0})")]
     UnknownRecType(u64),
+    #[error("Unknown version {0} of tracelog format!")]
+    UnknownVersion(u64),
+    #[error("Log format {0} not supported with this QEMU release!")]
+    UnsupportedVersion(u64),
 }
 
 pub type Result<T> = std::result::Result<T, Error>;
@@ -98,19 +120,22 @@ struct LogHeader
     version: u64,
 }
 
+const LOG_HDR_LEN: usize = size_of::<LogHeader>();
+
 impl ReadHeader for LogHeader
 {
     fn read_header(mut fobj: &File) -> Result<Self>
     {
-        let mut raw_hdr = [0u8; 24];
+        let mut raw_hdr = [0u8; LOG_HDR_LEN];
         fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
 
         /*
          * Safe because the size of log header (struct LogHeader)
          * is 24 bytes, which is ensured by simple trace backend.
          */
-        let hdr =
-            unsafe { std::mem::transmute::<[u8; 24], LogHeader>(raw_hdr) };
+        let hdr = unsafe {
+            std::mem::transmute::<[u8; LOG_HDR_LEN], LogHeader>(raw_hdr)
+        };
         Ok(hdr)
     }
 }
@@ -142,6 +167,8 @@ struct RecordHeader
     record_pid: u32,
 }
 
+const REC_HDR_LEN: usize = size_of::<RecordHeader>();
+
 impl RecordHeader
 {
     fn extract_record(&self, mut fobj: &File) -> Result<RecordInfo>
@@ -167,20 +194,232 @@ impl ReadHeader for RecordHeader
 {
     fn read_header(mut fobj: &File) -> Result<Self>
     {
-        let mut raw_hdr = [0u8; 24];
+        let mut raw_hdr = [0u8; REC_HDR_LEN];
         fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
 
         /*
          * Safe because the size of record header (struct RecordHeader)
          * is 24 bytes, which is ensured by simple trace backend.
          */
-        let hdr: RecordHeader =
-            unsafe { std::mem::transmute::<[u8; 24], RecordHeader>(raw_hdr) };
+        let hdr: RecordHeader = unsafe {
+            std::mem::transmute::<[u8; REC_HDR_LEN], RecordHeader>(raw_hdr)
+        };
         Ok(hdr)
     }
 }
 
-pub struct EventArgPayload {}
+#[derive(Clone)]
+pub struct EventArgPayload
+{
+    raw_val: Option<u64>,
+    raw_str: Option<String>,
+}
+
+impl EventArgPayload
+{
+    fn new(raw_val: Option<u64>, raw_str: Option<String>) -> Self
+    {
+        EventArgPayload { raw_val, raw_str }
+    }
+
+    fn get_payload_str(
+        offset: &mut usize,
+        args_payload: &[u8],
+    ) -> Result<EventArgPayload>
+    {
+        let length = u32::from_le_bytes(
+            args_payload[*offset..(*offset + 4)].try_into().unwrap(),
+        );
+        *offset += 4;
+        let raw_str: &[u8] = args_payload
+            .get(*offset..(*offset + length as usize))
+            .unwrap();
+        *offset += length as usize;
+        Ok(EventArgPayload::new(
+            None,
+            Some(String::from_utf8_lossy(raw_str).into_owned()),
+        ))
+    }
+
+    fn get_payload_val(
+        offset: &mut usize,
+        args_payload: &[u8],
+    ) -> Result<EventArgPayload>
+    {
+        let raw_val = u64::from_le_bytes(
+            args_payload[*offset..(*offset + 8)].try_into().unwrap(),
+        );
+        *offset += 8;
+        Ok(EventArgPayload::new(Some(raw_val), None))
+    }
+}
+
+#[derive(Clone)]
+struct EventEntry
+{
+    event: Event,
+    event_id: u64,
+    timestamp_ns: u64,
+    record_pid: u32,
+    rec_args: Vec<EventArgPayload>,
+}
+
+impl EventEntry
+{
+    fn new(
+        event: &Event,
+        event_id: u64,
+        timestamp_ns: u64,
+        record_pid: u32,
+    ) -> Self
+    {
+        EventEntry {
+            event: event.clone(),
+            event_id,
+            timestamp_ns,
+            record_pid,
+            rec_args: Vec::new(),
+        }
+    }
+}
+
+fn get_mapping(mut fobj: &File) -> Result<(u64, String)>
+{
+    let mut event_id_buf = [0u8; 8];
+    fobj.read_exact(&mut event_id_buf)
+        .map_err(Error::ReadFile)?;
+    let event_id = u64::from_le_bytes(event_id_buf);
+
+    let mut len_buf = [0u8; 4];
+    fobj.read_exact(&mut len_buf).map_err(Error::ReadFile)?;
+
+    let len = u32::from_le_bytes(len_buf);
+    let mut name_buf = vec![0u8; len as usize];
+    fobj.read_exact(&mut name_buf).map_err(Error::ReadFile)?;
+    let name = String::from_utf8(name_buf.clone())
+        .map_err(|_| Error::InvalidEventName(format!("{:?}", name_buf)))?;
+
+    Ok((event_id, name))
+}
+
+fn read_record(fobj: &File) -> Result<RecordInfo>
+{
+    let hdr = RecordHeader::read_header(fobj)?;
+    let info = hdr.extract_record(fobj)?;
+    Ok(info)
+}
+
+fn read_trace_header(fobj: &File) -> Result<()>
+{
+    let log_hdr = LogHeader::read_header(fobj)?;
+    if log_hdr.event_id != HEADER_EVENT_ID {
+        return Err(Error::InvalidHeaderId(log_hdr.event_id, HEADER_EVENT_ID));
+    }
+    if log_hdr.magic != HEADER_MAGIC {
+        return Err(Error::InvalidHeaderMagic(log_hdr.magic, HEADER_MAGIC));
+    }
+    if ![0, 2, 3, 4].contains(&(log_hdr.version as i64)) {
+        return Err(Error::UnknownVersion(log_hdr.version));
+    }
+    if log_hdr.version != 4 {
+        return Err(Error::UnsupportedVersion(log_hdr.version));
+    }
+    Ok(())
+}
+
+fn read_trace_records(
+    events: &Vec<Event>,
+    fobj: &File,
+    analyzer: &mut Formatter,
+    read_header: bool,
+) -> Result<Vec<String>>
+{
+    /* backtrace::Backtrace needs this env variable. */
+    env::set_var("RUST_BACKTRACE", "1");
+    let bt = Backtrace::new();
+    let raw_frame = bt.frames().first().unwrap();
+    let frameinfo = raw_frame.symbols().first().unwrap();
+
+    let dropped_event = Event::build(
+        "Dropped_Event(uint64_t num_events_dropped)",
+        frameinfo.lineno().unwrap() + 1,
+        frameinfo.filename().unwrap().to_str().unwrap(),
+    )
+    .unwrap();
+
+    let mut event_mapping = HashMap::new();
+    for e in events {
+        event_mapping.insert(e.name.clone(), e.clone());
+    }
+
+    let drop_str = "dropped".to_string();
+    event_mapping.insert(drop_str.clone(), dropped_event.clone());
+    let mut event_id_to_name: HashMap<u64, String> = HashMap::new();
+    event_id_to_name.insert(DROPPED_EVENT_ID, drop_str.clone());
+
+    if !read_header {
+        for (event_id, event) in events.iter().enumerate() {
+            event_id_to_name.insert(event_id as u64, event.name.clone());
+        }
+    }
+
+    let mut fmt_strs = Vec::new();
+    loop {
+        let rtype = RecordType::read_type(fobj)?;
+        match rtype {
+            RecordType::Empty => {
+                break;
+            }
+            RecordType::Mapping => {
+                let (event_id, event_name) =
+                    get_mapping(fobj).expect("Error reading mapping");
+                event_id_to_name.insert(event_id, event_name);
+                continue;
+            }
+            RecordType::Event => {
+                let rec = read_record(fobj).expect("Error reading record");
+                let event_name =
+                    event_id_to_name.get(&rec.event_id).unwrap().to_string();
+                let event = event_mapping
+                    .get(&event_name)
+                    .ok_or(Error::UnknownEvent(event_name))?;
+
+                let mut entry = EventEntry::new(
+                    event,
+                    rec.event_id,
+                    rec.timestamp_ns,
+                    rec.record_pid,
+                );
+                let mut offset = 0;
+
+                for arg in &event.args.props {
+                    let payload = if arg.is_string() {
+                        EventArgPayload::get_payload_str(
+                            &mut offset,
+                            &rec.args_payload,
+                        )?
+                    } else {
+                        EventArgPayload::get_payload_val(
+                            &mut offset,
+                            &rec.args_payload,
+                        )?
+                    };
+                    entry.rec_args.push(payload);
+                }
+
+                let fmt = analyzer.process_event(
+                    &entry.rec_args,
+                    &entry.event,
+                    entry.event_id,
+                    entry.timestamp_ns,
+                    entry.record_pid,
+                )?;
+                fmt_strs.push(fmt);
+            }
+        }
+    }
+    Ok(fmt_strs)
+}
 
 trait Analyzer
 {
-- 
2.34.1


