Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D374C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 08:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVHn-0005I0-Ai; Mon, 27 May 2024 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGF-0004bf-Jh
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:15 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBVGC-0004Vj-Bh
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716796752; x=1748332752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=n5LwkxBtgvJ3BNcCx2oxBYNjJJlOnu7VIcbHmrqwRto=;
 b=eq9b3PgKxC8k/qw7kUXAqxke/LOP5vOSNpIDmH0+bZ0cTrWpgw/QRd/o
 BX24ouQItwukfqlt2Dbg7qpZqFHejoxSxWym7kKzg957mDrNrVbxh2c3r
 AzjxrjmEM9+Be+2cUUVsWcxragE50ruABq/pXpSJ0W6Mg8Jr6o/SIF9Th
 VpBW/8zb0wjUnBtd2JTYHwA/4PLelqB/H1tiIZjQbrA9z7577NC9ItG7A
 eVMQWqYcjsU9bxWzgOGzVVUo7Ebcr94isd90aiZnmS3hjsG/IKeYc8lbC
 OAtWEYxoNK0TB+SagK+rCwoScOjAObN2Qx+k2pHBJ+3mYjhVa82ojeah6 w==;
X-CSE-ConnectionGUID: XMMTgtu+RXqtfmMUWe2yFA==
X-CSE-MsgGUID: IKOiw6V9SDKMOzwyepnFFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12967727"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="12967727"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 00:59:12 -0700
X-CSE-ConnectionGUID: 5aVS/fsZRwCU+YxWJ0yL3A==
X-CSE-MsgGUID: rJq9qp6qS3qUKbuVsXIIQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; d="scan'208";a="39084975"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 00:59:09 -0700
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
Subject: [RFC 3/6] scripts/simpletrace-rust: Add helpers to parse trace file
Date: Mon, 27 May 2024 16:14:18 +0800
Message-Id: <20240527081421.2258624-4-zhao1.liu@intel.com>
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

Refer to scripts/simpletrace.py, add the helpers to read the trace file
and parse the record type field, record header and log header.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/simpletrace-rust/src/main.rs | 151 +++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/scripts/simpletrace-rust/src/main.rs b/scripts/simpletrace-rust/src/main.rs
index 2d2926b7658d..b3b8baee7c66 100644
--- a/scripts/simpletrace-rust/src/main.rs
+++ b/scripts/simpletrace-rust/src/main.rs
@@ -14,21 +14,172 @@
 mod trace;
 
 use std::env;
+use std::fs::File;
+use std::io::Error as IOError;
+use std::io::ErrorKind;
+use std::io::Read;
 
 use clap::Arg;
 use clap::Command;
 use thiserror::Error;
 use trace::Event;
 
+const RECORD_TYPE_MAPPING: u64 = 0;
+const RECORD_TYPE_EVENT: u64 = 1;
+
 #[derive(Error, Debug)]
 pub enum Error
 {
     #[error("usage: {0} [--no-header] <trace-events> <trace-file>")]
     CliOptionUnmatch(String),
+    #[error("Failed to read file: {0}")]
+    ReadFile(IOError),
+    #[error("Unknown record type ({0})")]
+    UnknownRecType(u64),
 }
 
 pub type Result<T> = std::result::Result<T, Error>;
 
+enum RecordType
+{
+    Empty,
+    Mapping,
+    Event,
+}
+
+#[repr(C)]
+#[derive(Clone, Copy, Default)]
+struct RecordRawType
+{
+    rtype: u64,
+}
+
+impl RecordType
+{
+    fn read_type(mut fobj: &File) -> Result<RecordType>
+    {
+        let mut tbuf = [0u8; 8];
+        if let Err(e) = fobj.read_exact(&mut tbuf) {
+            if e.kind() == ErrorKind::UnexpectedEof {
+                return Ok(RecordType::Empty);
+            } else {
+                return Err(Error::ReadFile(e));
+            }
+        }
+
+        /*
+         * Safe because the layout of the trace record requires us to parse
+         * the type first, and then there is a check on the validity of the
+         * record type.
+         */
+        let raw_t =
+            unsafe { std::mem::transmute::<[u8; 8], RecordRawType>(tbuf) };
+        match raw_t.rtype {
+            RECORD_TYPE_MAPPING => Ok(RecordType::Mapping),
+            RECORD_TYPE_EVENT => Ok(RecordType::Event),
+            _ => Err(Error::UnknownRecType(raw_t.rtype)),
+        }
+    }
+}
+
+trait ReadHeader
+{
+    fn read_header(fobj: &File) -> Result<Self>
+    where
+        Self: Sized;
+}
+
+#[repr(C)]
+#[derive(Clone, Copy)]
+struct LogHeader
+{
+    event_id: u64,
+    magic: u64,
+    version: u64,
+}
+
+impl ReadHeader for LogHeader
+{
+    fn read_header(mut fobj: &File) -> Result<Self>
+    {
+        let mut raw_hdr = [0u8; 24];
+        fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
+
+        /*
+         * Safe because the size of log header (struct LogHeader)
+         * is 24 bytes, which is ensured by simple trace backend.
+         */
+        let hdr =
+            unsafe { std::mem::transmute::<[u8; 24], LogHeader>(raw_hdr) };
+        Ok(hdr)
+    }
+}
+
+#[derive(Default)]
+struct RecordInfo
+{
+    event_id: u64,
+    timestamp_ns: u64,
+    record_pid: u32,
+    args_payload: Vec<u8>,
+}
+
+impl RecordInfo
+{
+    fn new() -> Self
+    {
+        Default::default()
+    }
+}
+
+#[repr(C)]
+#[derive(Clone, Copy)]
+struct RecordHeader
+{
+    event_id: u64,
+    timestamp_ns: u64,
+    record_length: u32,
+    record_pid: u32,
+}
+
+impl RecordHeader
+{
+    fn extract_record(&self, mut fobj: &File) -> Result<RecordInfo>
+    {
+        let mut info = RecordInfo::new();
+
+        info.event_id = self.event_id;
+        info.timestamp_ns = self.timestamp_ns;
+        info.record_pid = self.record_pid;
+        info.args_payload = vec![
+            0u8;
+            self.record_length as usize
+                - std::mem::size_of::<RecordHeader>()
+        ];
+        fobj.read_exact(&mut info.args_payload)
+            .map_err(Error::ReadFile)?;
+
+        Ok(info)
+    }
+}
+
+impl ReadHeader for RecordHeader
+{
+    fn read_header(mut fobj: &File) -> Result<Self>
+    {
+        let mut raw_hdr = [0u8; 24];
+        fobj.read_exact(&mut raw_hdr).map_err(Error::ReadFile)?;
+
+        /*
+         * Safe because the size of record header (struct RecordHeader)
+         * is 24 bytes, which is ensured by simple trace backend.
+         */
+        let hdr: RecordHeader =
+            unsafe { std::mem::transmute::<[u8; 24], RecordHeader>(raw_hdr) };
+        Ok(hdr)
+    }
+}
+
 pub struct EventArgPayload {}
 
 trait Analyzer
-- 
2.34.1


