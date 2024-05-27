Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83E8C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVGx-0004of-Un; Mon, 27 May 2024 03:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGK-0004eQ-J5
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:21 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGI-0004Vj-Q7
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716796759; x=1748332759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yDnU3NpuzzE9vncxdnu3+nFMkkDKrrnqtTuk0bRk1Ps=;
 b=IP/gMv3U3pGX4NxNMthayZ0KqV+f5j2WZ3X5fOLPPb3wfD4TVzMmn1Ib
 SbaS1H4Btvmw4q/P5WAxO22GeYuphha601pWFi9G3MCZii+6RPNq+jII2
 zDk0XTDaW5oPQsWzH7svVN28t9gYhRq8rt95Kk3e1fw9hUVf4RPUXjWdk
 3O24j9lybyOeYIBTNlTrLcJiiBGcyH0TEg+1hgtTCt1pj0CbJVRYim50M
 RcZ3PGjV41TlDrAY6EvPPA0lqwKxoj8xr0GQrCRvz6VgGFq13iR5Pg9yL
 WaSL+w9hFYkI+Lmy3mkfzqtE7vkZT+XUcDSL9cBM2OqappIN+QHVYTOKj A==;
X-CSE-ConnectionGUID: k7p1A+qdRPi+OqIMFmdJhw==
X-CSE-MsgGUID: wxf/bMZ/Q2awhq2pYfrTSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12967744"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12967744"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 00:59:18 -0700
X-CSE-ConnectionGUID: 2O0Hbl4/RhiMr66BWSZhTQ==
X-CSE-MsgGUID: 1/mI9UGmTLWYatbApChIQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39085008"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 00:59:15 -0700
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
Subject: [RFC 5/6] scripts/simpletrace-rust: Format simple trace output
Date: Mon, 27 May 2024 16:14:20 +0800
Message-Id: <20240527081421.2258624-6-zhao1.liu@intel.com>
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

Format simple trace output, as in the Python version. Further, complete
the trace file input and trace log output.

Additionally, remove `#![allow(dead_code)]` and
`#![allow(unused_variables)]` to allow rustc to do related checks.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/simpletrace-rust/src/main.rs | 80 ++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/scripts/simpletrace-rust/src/main.rs b/scripts/simpletrace-rust/src/main.rs
index f9a71d8dc243..ba4b96efb066 100644
--- a/scripts/simpletrace-rust/src/main.rs
+++ b/scripts/simpletrace-rust/src/main.rs
@@ -8,23 +8,25 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#![allow(dead_code)]
-#![allow(unused_variables)]
-
 mod trace;
 
 use std::collections::HashMap;
 use std::env;
+use std::fmt;
 use std::fs::File;
+use std::io::stdout;
 use std::io::Error as IOError;
 use std::io::ErrorKind;
 use std::io::Read;
+use std::io::Write;
 use std::mem::size_of;
 
 use backtrace::Backtrace;
 use clap::Arg;
 use clap::Command;
 use thiserror::Error;
+use trace::read_events;
+use trace::Error as TraceError;
 use trace::Event;
 
 const DROPPED_EVENT_ID: u64 = 0xfffffffffffffffe;
@@ -45,8 +47,12 @@ pub enum Error
     InvalidHeaderId(u64, u64),
     #[error("Not a valid trace file, header magic {0} != {1}")]
     InvalidHeaderMagic(u64, u64),
+    #[error("Failed to open file: {0}")]
+    OpenFile(IOError),
     #[error("Failed to read file: {0}")]
     ReadFile(IOError),
+    #[error("Failed to read trace: {0}")]
+    ReadTrace(TraceError),
     #[error(
         "event {0} is logged but is not declared in the trace events \
         file, try using trace-events-all instead."
@@ -58,6 +64,8 @@ pub enum Error
     UnknownVersion(u64),
     #[error("Log format {0} not supported with this QEMU release!")]
     UnsupportedVersion(u64),
+    #[error("Failed to write trace: {0}")]
+    WriteTrace(IOError),
 }
 
 pub type Result<T> = std::result::Result<T, Error>;
@@ -254,6 +262,30 @@ impl EventArgPayload
     }
 }
 
+impl fmt::Display for EventArgPayload
+{
+    fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result
+    {
+        if let Some(s) = &self.raw_str {
+            write!(fmt, "{}", s)
+        } else {
+            write!(fmt, "")
+        }
+    }
+}
+
+impl fmt::LowerHex for EventArgPayload
+{
+    fn fmt(&self, fmt: &mut fmt::Formatter) -> fmt::Result
+    {
+        if let Some(v) = self.raw_val {
+            write!(fmt, "{:x}", v)
+        } else {
+            write!(fmt, "")
+        }
+    }
+}
+
 #[derive(Clone)]
 struct EventEntry
 {
@@ -485,10 +517,35 @@ impl Analyzer for Formatter
         event: &Event,
         timestamp_ns: u64,
         pid: u32,
-        event_id: u64,
+        _event_id: u64,
     ) -> Result<String>
     {
-        let fmt_str = String::new();
+        if self.last_timestamp_ns.is_none() {
+            self.last_timestamp_ns = Some(timestamp_ns);
+        }
+
+        let fields: Vec<String> = rec_args
+            .iter()
+            .zip(event.args.props.iter())
+            .map(|(arg, prop)| {
+                if prop.is_string() {
+                    format!("{}={}", prop.name, arg)
+                } else {
+                    format!("{}=0x{:x}", prop.name, arg)
+                }
+            })
+            .collect();
+
+        let delta_ns =
+            timestamp_ns as f64 - self.last_timestamp_ns.unwrap() as f64;
+        self.last_timestamp_ns = Some(timestamp_ns);
+        let fmt_str = format!(
+            "{} {:.3} pid={} {}\n",
+            event.name,
+            delta_ns / 1000.0,
+            pid,
+            fields.join(" "),
+        );
 
         Ok(fmt_str)
     }
@@ -501,7 +558,20 @@ fn process(
     read_header: bool,
 ) -> Result<()>
 {
+    let events = read_events(event_path).map_err(Error::ReadTrace)?;
+    let trace_fobj = File::open(trace_path).map_err(Error::OpenFile)?;
+    if read_header {
+        read_trace_header(&trace_fobj)?;
+    }
+
     analyzer.begin();
+
+    let rec_strs =
+        read_trace_records(&events, &trace_fobj, analyzer, read_header)?;
+    let mut lock = stdout().lock();
+    lock.write_all(rec_strs.join("").as_ref())
+        .map_err(Error::WriteTrace)?;
+
     analyzer.end();
 
     Ok(())
-- 
2.34.1


