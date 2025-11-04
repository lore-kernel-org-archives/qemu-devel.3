Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B558CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwp-0007jg-Dh; Tue, 04 Nov 2025 11:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwI-0007cd-7D
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwA-0003xw-MB
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5zycgEsXQM6pRKEG7JhYUW0ECHZFhS5oVojreimnMA=;
 b=TfTPqXt9fgROtMKIR+l7UnYeysQ6uLm7fu4WTWm+h/wVoDlI4mL+/zNUqrmOSJkepxwpO4
 ffPYeNUXTR/0EH6Wf/Nr21qXgPjtEahsOQUQEb9FA9BvXw06CVgPtWpk8pIbEbmGClm+Wo
 2bydusWRODL0LWyOHbfL8Fsq+4hPB2Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-4oQdSMysOqKfWR0uoR8T3g-1; Tue, 04 Nov 2025 11:31:11 -0500
X-MC-Unique: 4oQdSMysOqKfWR0uoR8T3g-1
X-Mimecast-MFC-AGG-ID: 4oQdSMysOqKfWR0uoR8T3g_1762273870
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b707e22ebeeso695253766b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273869; x=1762878669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5zycgEsXQM6pRKEG7JhYUW0ECHZFhS5oVojreimnMA=;
 b=gmZHZU52hrQmQOq2jMOQS9GfbxEyxczqySFw7tffhLRbbb5t0wsbQK1LJtxILikCtF
 iS8EkGn8d/kf42412i1RfBKByEJimbIb8Zu5/EO/2W5WUH4u8k2GmLC5JaAXiGMYOUGu
 i4WHEiOenpqlcSfgWyssyNcr7jMgTDQSvWhmHlA+gJXwFENlH68V9Es16pvjVeCiTMIY
 EhaRRAar9qQ/8fofUkbRB9bdhCI0mHYdEqD8UhJQ3OT5l6K4DsGQVJbSLp7X1NmMzCc8
 KkA+dwshmaJSih88gGhTzxcYUJNRmdhARClkn8qOzvsM6Xx3vuaI2P/ow27hUnYXeIf3
 nQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273869; x=1762878669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5zycgEsXQM6pRKEG7JhYUW0ECHZFhS5oVojreimnMA=;
 b=LaaZybtom/M+25lhSrGoP0KpqGRBCQh8RCMMr27qQ6TsHvZ0ycVXktTJKylN2NCe6P
 ajGN7I9Aq7iTRjh5LN5oKZjBJJHLGoKj94eya6vNcymItGaUKXcYNLXc6ocdj1wPZoTl
 cUP3Zbw1eXYXMsuU/QI7f8bOF+kaHG9wVc/yavtQGBc3uFho3nd2tXePgg/drP3crk1f
 JHANldSbzFMe2DB1v39tSzB6ZOWt9zTb22u19Ra4C00+yM7JAEsleGT5fdNC0JvH/wWX
 NS5xp6mHPzcry0GBQkdiWHocV4tyrxMJ5w25L72+mflk2btIPEPtV0P0zr2XUkyi3pf2
 vKPA==
X-Gm-Message-State: AOJu0YySm7M8KKReptizV6ACJl+5p4/WXHd1WyBKjUXlv6wH14Gpg9wd
 UcT5ua02hU9S2AZVEMLw1YeGs58t6XhLPYIMb/CXrvrBWxcUN3WiZEuDoey8EgM6d6DWKdlgTEg
 MZGwmnQIfWxxKx+BBKloKzo8OgNBtnQ27R4oqRmPPaYlnOkh5UsytKdch5dNfGI/8/rEyyIpVPg
 gcRXcBSyheSrI0xCDtEk9DHFb6jbhLmmYocSQ/VMBA
X-Gm-Gg: ASbGnctMjLCGi7YU9CdBMCyikmHaxJ5K1Kbr18l9n/dLUamoG1j63jzkXt5jKSxXfrQ
 aTzndoxA4h8k1a0x67f45KZbsV/yy235IHw47HESWywrl1McX9Hk9H1K6yGoznPOD5R5/fiXHmw
 t3wp3xNdCWgDE4iKHfeTfKPxMuTLQHGDYGqzKRIE/5UJTtP83NU+aAYZfJsSoj516nYdn6onJCg
 rZtvG4xDP7oz7UnbbwRixltTocfqq+5divo7H2IN+c2yBLibuYm+udgHsyuSr7V+EtT2Z0FrxMW
 KFezXcjdUbW8vZR1ocuOIq4T/LCJv6TOy435NF8Q6PQSumpUK4hDuquP4kSI/i+V+gpsLUttEYZ
 KRzigTJTrfxJdL9JAqSp9J24HGtFMmGujtacMzKz6kSy8mi0/gidPbULrRI3Py7NPlkdo9KmBgH
 YlSUmR
X-Received: by 2002:a17:907:1c11:b0:b72:5640:ac15 with SMTP id
 a640c23a62f3a-b725640b0dcmr238405066b.26.1762273868950; 
 Tue, 04 Nov 2025 08:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcUxRkaAmXVlf6EtOp0/PfR6MwhnGZAM7MiUYN4UCAdpSDqkK7O15ewQZempzi+oh53FJbhw==
X-Received: by 2002:a17:907:1c11:b0:b72:5640:ac15 with SMTP id
 a640c23a62f3a-b725640b0dcmr238401966b.26.1762273868370; 
 Tue, 04 Nov 2025 08:31:08 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7240348d93sm244411266b.68.2025.11.04.08.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 2/8] rust/util: add ensure macro
Date: Tue,  4 Nov 2025 17:30:56 +0100
Message-ID: <20251104163102.738889-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
References: <20251104163102.738889-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The macro is similar to anyhow::ensure but uses QEMU's variation
on anyhow::Error.  It can be used to easily check a condition
and format an error message.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


