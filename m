Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD92BCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr0s-000158-8i; Fri, 31 Oct 2025 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr0q-000139-Ie
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr0j-0000nw-0R
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yq29Dg28MtHToBMDyjMkNHHVvYBx9/maalG2F5iiQUk=;
 b=TxQChlmbiftbsEJzfVovzhLVbq/O87A3F08O3LS+Tb4Wmv6afWE9BkHu3sAcM0EiVrAI0w
 ZZsRv4FDCkrQghABgWXWVXK+uVpQ1aMM3/JSU+DjTp//XZOuhB+A1UyjarjjFEjazwHm+o
 tsEe5sv3xiLftaxBtS7utxpobCXkMAw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-y1GqENMbPmi8duaNuuFCkA-1; Fri, 31 Oct 2025 11:25:48 -0400
X-MC-Unique: y1GqENMbPmi8duaNuuFCkA-1
X-Mimecast-MFC-AGG-ID: y1GqENMbPmi8duaNuuFCkA_1761924348
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4270a61ec48so2483975f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761924347; x=1762529147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yq29Dg28MtHToBMDyjMkNHHVvYBx9/maalG2F5iiQUk=;
 b=L7ViMiAogBrE7lnZeOF5sgPQTm1gIGwEtwrRdkp/ezygYhvalamKyBETIs7vF3xg3g
 DxT3GegYf1gUeu/ObShN8NQ3WRFkRKslJyBzrUdcWvUlBS1uUKBbrwhYL5uJpvQ3aBGI
 W0dZal8Y6zIwDumGdWmw6O56/NDw53vxTC9us0LxihuC+cwz3f0G3t4I50Fdi/UlHGxy
 OFSW4PgSs7n4Sd8sYUkCHEppP0527uk+uirPITLX2o2eQFqhwrp09z2xOwrI8/+UDPGS
 7xPE3SPoFBgT2XyKJ2nhrjf/EZXRn/uMPqiWvl0bPnWEFzj83ata3g+pekLNYVPgncNm
 HNzg==
X-Gm-Message-State: AOJu0YxtO3E3dMASxPWc7tCt4MOTIUDfzEtvIGp/6SQ9qc8oIA6ATaz8
 kF1mxf/0OFTPcgWB2iClvVTgElepg4+435DCnzCMx3xvIOZ9QSpOtssdr2FrOQDVyA7gq11pNnG
 28y0LLWDwQlvHxExymQ+VdNTSjwOXFq1VxwejtR7cZBeJTbu74JS5Ict3V9aqdvvemxa9Yxq9eR
 sSAY8Qy2/O5ca95JxDa9gPaSLzEk1sOdF/HnBheht8
X-Gm-Gg: ASbGncuVv8WA+rAvSQvzinB5yIDA6Cm1lt8Z+jc5oJreolStTDBAy4z+DX6irTvSXMF
 9bNU72o6KtMRgPejUlEsA0g63qcC6qOh+t+qSJ+jJnsZN8YO0EaKrpgX2V/WbXDu/bbQrJeCxZK
 0O1pw4N/m98ieCvvYQSqae+ukjjLhB/oogGDBteFA9pB/RbNgpYNpk98U7Gh0Kc7aSbNclo7ST/
 TIXiXMzCmcBtsR2gmXPocY1OU4vg6rlvbr+SY8aOQ+btmUbARzmpaTbiJdSYVGmEgJrPeLTsSlh
 O2WRKS7KjqQ5B5LVbPVj4JkQV5eOVqAm2gIi04yotj0LXllOrCfcLGdjiuCd6XpKPr4iptuRlY2
 o/H50snTMiaXedVIWrb4YLff/ey8pPBFLL45co34n3CCqNjDMw58T86RL3mbwwaeAHKqbQCNr8v
 b1i0X5
X-Received: by 2002:a05:6000:178d:b0:429:b6e2:1ecf with SMTP id
 ffacd0b85a97d-429bd682973mr3607042f8f.22.1761924346537; 
 Fri, 31 Oct 2025 08:25:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+AE6S2+Hnk6TlxexEo9pNzi7wHPxmlDA3dLqnAnfopUDJHyzaRgkMPQVjDKCi6dc3ADB8/A==
X-Received: by 2002:a05:6000:178d:b0:429:b6e2:1ecf with SMTP id
 ffacd0b85a97d-429bd682973mr3607011f8f.22.1761924345963; 
 Fri, 31 Oct 2025 08:25:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13f1d4csm3735435f8f.39.2025.10.31.08.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:25:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/4] rust/util: add ensure macro
Date: Fri, 31 Oct 2025 16:25:36 +0100
Message-ID: <20251031152540.293293-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031152540.293293-1-pbonzini@redhat.com>
References: <20251031152540.293293-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The macro is similar to anyhow::ensure but uses QEMU's variation
on anyhow::Error.  It can be used to easily check a condition
and format an error message.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 21 ++++++----
 rust/hw/timer/hpet/src/fw_cfg.rs |  7 ++--
 rust/util/src/error.rs           | 71 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 23f2eefd1cd..3564aa79c6e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -25,7 +25,10 @@
     bindings::{address_space_memory, address_space_stl_le, hwaddr},
     MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
 };
-use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
+use util::{
+    ensure,
+    timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
+};
 
 use crate::fw_cfg::HPETFwConfig;
 
@@ -728,14 +731,14 @@ fn post_init(&self) {
     }
 
     fn realize(&self) -> util::Result<()> {
-        if self.num_timers < HPET_MIN_TIMERS || self.num_timers > HPET_MAX_TIMERS {
-            Err(format!(
-                "hpet.num_timers must be between {HPET_MIN_TIMERS} and {HPET_MAX_TIMERS}"
-            ))?;
-        }
-        if self.int_route_cap == 0 {
-            Err("hpet.hpet-intcap property not initialized")?;
-        }
+        ensure!(
+            (HPET_MIN_TIMERS..=HPET_MAX_TIMERS).contains(&self.num_timers),
+            "hpet.num_timers must be between {HPET_MIN_TIMERS} and {HPET_MAX_TIMERS}"
+        );
+        ensure!(
+            self.int_route_cap != 0,
+            "hpet.hpet-intcap property not initialized"
+        );
 
         self.hpet_id.set(HPETFwConfig::assign_hpet_id()?);
 
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index bb4ea8909ad..777fc8ef45e 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -5,6 +5,7 @@
 use std::ptr::addr_of_mut;
 
 use common::Zeroable;
+use util::{self, ensure};
 
 /// Each `HPETState` represents a Event Timer Block. The v1 spec supports
 /// up to 8 blocks. QEMU only uses 1 block (in PC machine).
@@ -36,7 +37,7 @@ unsafe impl Zeroable for HPETFwConfig {}
 };
 
 impl HPETFwConfig {
-    pub(crate) fn assign_hpet_id() -> Result<usize, &'static str> {
+    pub(crate) fn assign_hpet_id() -> util::Result<usize> {
         assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
@@ -47,9 +48,7 @@ pub(crate) fn assign_hpet_id() -> Result<usize, &'static str> {
             fw_cfg.count = 0;
         }
 
-        if fw_cfg.count == 8 {
-            Err("Only 8 instances of HPET are allowed")?;
-        }
+        ensure!(fw_cfg.count != 8, "Only 8 instances of HPET are allowed");
 
         let id: usize = fw_cfg.count.into();
         fw_cfg.count += 1;
diff --git a/rust/util/src/error.rs b/rust/util/src/error.rs
index bfa5a8685bc..2a57c7fd5fd 100644
--- a/rust/util/src/error.rs
+++ b/rust/util/src/error.rs
@@ -86,6 +86,19 @@ fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
     }
 }
 
+impl From<Cow<'static, str>> for Error {
+    #[track_caller]
+    fn from(msg: Cow<'static, str>) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: Some(msg),
+            cause: None,
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+}
+
 impl From<String> for Error {
     #[track_caller]
     fn from(msg: String) -> Self {
@@ -126,6 +139,17 @@ fn from(error: anyhow::Error) -> Self {
 }
 
 impl Error {
+    #[track_caller]
+    #[doc(hidden)]
+    pub fn format(args: fmt::Arguments) -> Self {
+        if let Some(msg) = args.as_str() {
+            Self::from(msg)
+        } else {
+            let msg = fmt::format(args);
+            Self::from(msg)
+        }
+    }
+
     /// Create a new error, prepending `msg` to the
     /// description of `cause`
     #[track_caller]
@@ -311,6 +335,53 @@ unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
     }
 }
 
+/// Ensure that a condition is true, returning an error if it is false.
+///
+/// This macro is similar to [`anyhow::ensure`] but returns a QEMU [`Result`].
+/// If the condition evaluates to `false`, the macro returns early with an error
+/// constructed from the provided message.
+///
+/// # Examples
+///
+/// ```
+/// # use util::{ensure, Result};
+/// # fn check_positive(x: i32) -> Result<()> {
+/// ensure!(x > 0, "value must be positive");
+/// #   Ok(())
+/// # }
+/// ```
+///
+/// ```
+/// # use util::{ensure, Result};
+/// # const MIN: i32 = 123;
+/// # const MAX: i32 = 456;
+/// # fn check_range(x: i32) -> Result<()> {
+/// ensure!(
+///     x >= MIN && x <= MAX,
+///     "{} not between {} and {}",
+///     x,
+///     MIN,
+///     MAX
+/// );
+/// #   Ok(())
+/// # }
+/// ```
+#[macro_export]
+macro_rules! ensure {
+    ($cond:expr, $fmt:literal, $($arg:tt)*) => {
+        if !$cond {
+            let e = $crate::Error::format(format_args!($fmt, $($arg)*));
+            return $crate::Result::Err(e);
+        }
+    };
+    ($cond:expr, $err:expr $(,)?) => {
+        if !$cond {
+            let s = ::std::borrow::Cow::<'static, str>::from($err);
+            return $crate::Result::Err(s.into());
+        }
+    };
+}
+
 #[cfg(test)]
 mod tests {
     use std::ffi::CStr;
-- 
2.51.1


