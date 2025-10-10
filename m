Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C07CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ElQ-0008LA-9e; Fri, 10 Oct 2025 11:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7ElK-0008IH-QF
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7El7-00042W-8s
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCuQFa5fX4KQKF7cPe8uVRBcotSflZGTjBWBJT+Gw1A=;
 b=CUEZPO0MmUV8onUngrlXt+EVf7ZLiP1J3ZMocvG78bYdWKyZm48KVXQ5gi8hqr+k17vzo+
 Lt1zFbDtq/2x92M50oGW0GqkI1/E8uBoV36g66S5HucODENLzixJ0xd/jNfyW75/6gXajl
 oEJ3GVVkzBm2z7o2ModRzgYau/HxkRw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-jef618aBNuSVrW4vuVYYJA-1; Fri, 10 Oct 2025 11:10:12 -0400
X-MC-Unique: jef618aBNuSVrW4vuVYYJA-1
X-Mimecast-MFC-AGG-ID: jef618aBNuSVrW4vuVYYJA_1760109012
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6349af0e766so2508832a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109011; x=1760713811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCuQFa5fX4KQKF7cPe8uVRBcotSflZGTjBWBJT+Gw1A=;
 b=smCFdhm38ExnLq7LCkHGy0rBjKOHdVlc+FFXx9E41I42iXMlRpg3RMdd095rVT2m9c
 aQ/sSrlgxLp0VIDQeW0zTdP3CTdHNvKGgHjXeD6RdsELmLm3C2WZcFVexoHsh2e3F7P+
 hkdkHyKqBpnzod6xj6j4BJQ/mNP4bbphtgbpYDuAN2THuMWNrHWONCckoufnUEoYvuto
 Tv/wAuMbAAF0bSZ50Oc6gngt0tH2y1WYeo2y794yfemTB8j/DD7Abhx3tTlvTarkf5qh
 H7oi7KFZhHg94EbJMu+u6C26qx8vxYKg+qVCAgI2TjbgJz3iYIPIp/1LvqY430eWYGH+
 dyhA==
X-Gm-Message-State: AOJu0YziCjkdt2T748RlJGsiO88SITj5sZVCuteC8zZtwqRsWF9+SNut
 5UJyNbKNBp2MnzcCJP7WJ3rP8rwT0MCavFI9GvMAE+x0i+dzVwRqeQz1WW15LUSnsk0EmqvGEGZ
 WX8Xf9hM/6tt2u8fU/PgJa7xEiaqtEKxybOXQWTXJKcjszIyq7dG9CI35lQSlthjyscS+pBuMZi
 ZNPxqKTugmtixtXKp5+8C9CgoW7rO5sEuDcpMjdZXV
X-Gm-Gg: ASbGnctZEwT21OndyX6V65s9V16Vf2Q3lWjlJm8PgmmEMrBo2093Eomye2wIvc86eQa
 Oq8EkvFZRvv66PDLl4FhRk4o32hxE+eXTwPI3JKb22BKTX72KyH9dq4vlb+KLWuzyjiYXeZFUi1
 SwA28M2SRBScvR5g4p0wWp/qrW6248VxCbeagMz7WFqVYuSj6YB+wNd/S68bXQP1Y2JtgMi+wbO
 +D77x/cNOKneJK6CODX3pyoqy5RKR3Wwr82E+2h8LRZ7zmhG7A21LLfcDdL4yY6HmpdZUe8YuX5
 hs09lVRSS5B8iC/wuwbCtOvsWkYnoH4+d2E4Z1GyKceSjvb+jOrbBiWEj4qEq3WQCLSqRmP6Byp
 UqzKkO7uTYJvce2iAQI/eCt1PtZTvp0f5bpZs7yxxoNVj
X-Received: by 2002:aa7:dcca:0:b0:636:240f:9ece with SMTP id
 4fb4d7f45d1cf-639d5c75d2amr8827969a12.34.1760109010808; 
 Fri, 10 Oct 2025 08:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWT7mfaLiPP25ccYmgmOyWXrCLTdr+R4Lpky3/nq8T98ppQJkLXVDDiXep81ijjnycbqtbSg==
X-Received: by 2002:aa7:dcca:0:b0:636:240f:9ece with SMTP id
 4fb4d7f45d1cf-639d5c75d2amr8827942a12.34.1760109010199; 
 Fri, 10 Oct 2025 08:10:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c32249esm2454971a12.41.2025.10.10.08.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 01/19] util: add ensure macro
Date: Fri, 10 Oct 2025 17:09:46 +0200
Message-ID: <20251010151006.791038-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 rust/hw/timer/hpet/src/device.rs | 21 ++++++-----
 rust/hw/timer/hpet/src/fw_cfg.rs |  7 ++--
 rust/util/src/error.rs           | 65 ++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 86638c07666..4218372a2a1 100644
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
index e569b57b93b..27b3b2495a0 100644
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
index bfa5a8685bc..20b8e7d5af5 100644
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
+            let msg = std::fmt::format(args);
+            Self::from(msg)
+        }
+    }
+
     /// Create a new error, prepending `msg` to the
     /// description of `cause`
     #[track_caller]
@@ -311,6 +335,47 @@ unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
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
+/// ensure!(x >= MIN && x <= MAX, "{} not between {} and {}", x, MIN, MAX);
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
2.51.0


