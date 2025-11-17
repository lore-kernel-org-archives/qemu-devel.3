Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44224CEBF97
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuuE-0004Aq-Sd; Mon, 17 Nov 2025 03:48:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuuC-000471-CC
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:48:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuuA-00071v-CM
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763369289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13wjDJAbYFD10gI6Zr7kk4dq3n61G4FXpl1Z3qYzA6A=;
 b=Awaf1xNnb7mCXJLjHsJ0H6NjXrk06oZwul3h7FsSZ104FjjJqQ9+Quf0DPJHqzUcE5ZQK+
 041+oO4i4rMQ4iRktgi0tSqhRgnmXYWWjd1E6Lx1+oFtoR1jsYY+4V9rfQt8CDWnH9kL1B
 MhxP5TUiTEEM10AQIvIJheRjGhyKny0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-9sHBLJIXNMGUTRDVMYbZBg-1; Mon, 17 Nov 2025 03:48:07 -0500
X-MC-Unique: 9sHBLJIXNMGUTRDVMYbZBg-1
X-Mimecast-MFC-AGG-ID: 9sHBLJIXNMGUTRDVMYbZBg_1763369287
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso56033555e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 00:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763369286; x=1763974086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13wjDJAbYFD10gI6Zr7kk4dq3n61G4FXpl1Z3qYzA6A=;
 b=oXFL5bxMCw1U6QyfF8NSve5jsM5d0teFaCCe3yumih5u8lTBrVEseGtsGVljWEOZnb
 ZPxQufaPNQNV8ixwiPOfZt8zCytOTMoPElhdX+t1hGduc5xdx1O8Cswsg2Xnhyej/21B
 chLIe2pmTQV5AEXiDeWRG8em/mfSCba01rji1MrYzzjEw5qtkEgredKQOAGWQfnRVz83
 HGycXldGOQIu766bbBjMT+XQ+/BdYzXLFpQwQdvp4UxfWlRy2pPqgkSOygpsdO7iXy1u
 GL6VGnS/zsii6yrqWic3Sx/dRgkA3jRA5FqTEf+VQkPnu8Z7WussRW4pJcY6PQ63XGh1
 u40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763369286; x=1763974086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=13wjDJAbYFD10gI6Zr7kk4dq3n61G4FXpl1Z3qYzA6A=;
 b=l8WDT4WL2NDyCoAPQYrGT7mxI3d2GlHgHT9bCoNMaD+fehK5r9emJ6Nm8R+Qm9YpKk
 Hh3reyNithQSuJzguSmvzq6ORj2KSbqY6Of9X1vKPQWxqudr9JYnJEvZnj3DsoCgomo6
 TybIAwSsSgAWhtKgm0T4PQI0BRDoSbNFbR+fK6Q86DNIeif9Eam3/l1hHd8+ogX+/a/X
 Pc+bqNv7y5FogdAko/ufWs9K+3pAUJE647i2OuvtR5KDNuhEYu86YvZdaX8xcjzComW0
 ySAcG5TbitDfH1OlI4r5tterLiGmN05P+NpbGwcfbt5i4pY5kBTQTVWQHjwzcMMpx7gX
 Qltw==
X-Gm-Message-State: AOJu0Yw2S/wa9mB9u1IWBbMXhOzH0J60hfC/FcbITH/nv5anV6FnFX+X
 DgclvuuO++U0ofF6TnKwV5mBmLztv2cRkPNvtTqJvRuVwIT2bgYkOFYRXpCF1VS3sVPv6GSBCt+
 THEEC1mtn+MzxNfio1GnowV+MeJP29nNln298bWMyBAqt0NKLCzGF93CqdKUSn0K+Ns4BIsPMFe
 ghmopwH2vtx6BFjKnNSJCdbMGMHU0xwkRj6hv6vIoB
X-Gm-Gg: ASbGnct0aoe2AJvoijIVwbmEVDQfHds96zEptSM5QkCdh3pA8N5bze1GSxoCqjSRwAK
 Odc7vPoLHZdqGRwwty27qYosDA14LbQht8DameXsw7IxXHUxj++Q3BaqSRiMnBoBshq9lXa9N4D
 qGh1WU4iIcu0dHh02JsoStIFDNbZoA2dFncazQkQApxJDM4eFsUPsIFolxk3oIKss2NCIpkObW4
 0dev0N6/04iORGe5UI4JLZ2enwOAbOcY2W32VaB56JePLgy/se+1DXnyvYU3JrqIdmaNIiv3Enf
 SjGuuOziyJkRsrxkRAwcvsLJS3ctxJh8sFHq7H3L0N+7x3CiGuk5IXsDkhszHuUHy4lfimgzwIh
 SKZTk26tt988lF1CyJfIa1A/y/V3FQ4hdYeDiouJsMnDnb/LcFKqo291h4VD5akxxxlbQ9ZFCfY
 LiJMOw
X-Received: by 2002:a05:600c:8b4b:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-4778fe55405mr120246565e9.8.1763369286151; 
 Mon, 17 Nov 2025 00:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO3LBJn+YbU5X+iaa8JqvmzPeaJKA7gO3VOUKYsFmhe8jI/H7VeCvb+7GHo+9dafbY/erqlQ==
X-Received: by 2002:a05:600c:8b4b:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-4778fe55405mr120246225e9.8.1763369285641; 
 Mon, 17 Nov 2025 00:48:05 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779920f2cdsm135766415e9.10.2025.11.17.00.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 00:48:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 4/5] rust: migration: implement ToMigrationState for Timer
Date: Mon, 17 Nov 2025 09:47:51 +0100
Message-ID: <20251117084752.203219-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117084752.203219-1-pbonzini@redhat.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Timer is a complex struct, allow adding it to a struct that
uses #[derive(ToMigrationState)]; similar to vmstate_timer, only
the expiration time has to be preserved.

In fact, because it is thread-safe, ToMigrationStateShared can
also be implemented without needing a cell or mutex that wraps
the timer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs |  1 -
 rust/migration/src/migratable.rs | 31 +++++++++++++++++++++++++++++++
 rust/util/src/timer.rs           | 10 +++++++++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 5bcf151a680..373ec37bbd3 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -250,7 +250,6 @@ const fn get_individual_route(&self) -> usize {
 }
 
 /// HPET Timer Abstraction
-#[repr(C)]
 #[derive(Debug)]
 pub struct HPETTimer {
     /// timer N index within the timer block (`HPETState`)
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index 02efe31d72c..c82a6b9a7cf 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -140,6 +140,26 @@ fn restore_migrated_state_mut(
 
 impl_for_primitive!(u8, u16, u32, u64, i8, i16, i32, i64, bool);
 
+impl ToMigrationState for util::timer::Timer {
+    type Migrated = i64;
+
+    fn snapshot_migration_state(&self, target: &mut i64) -> Result<(), InvalidError> {
+        // SAFETY: as_ptr() is unsafe to ensure that the caller reasons about
+        // the pinning of the data inside the Opaque<>.  Here all we do is
+        // access a field.
+        *target = self.expire_time_ns().unwrap_or(-1);
+        Ok(())
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.restore_migrated_state(source, version_id)
+    }
+}
+
 impl<T: ToMigrationState, const N: usize> ToMigrationState for [T; N]
 where
     [T::Migrated; N]: Default,
@@ -237,6 +257,17 @@ fn restore_migrated_state(
     ) -> Result<(), InvalidError>;
 }
 
+impl ToMigrationStateShared for util::timer::Timer {
+    fn restore_migrated_state(&self, source: i64, _version_id: u8) -> Result<(), InvalidError> {
+        if source >= 0 {
+            self.modify(source as u64);
+        } else {
+            self.delete();
+        }
+        Ok(())
+    }
+}
+
 impl<T: ToMigrationStateShared, const N: usize> ToMigrationStateShared for [T; N]
 where
     [T::Migrated; N]: Default,
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index 829f52d111e..4109d84c398 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -10,7 +10,8 @@
 use common::{callbacks::FnCall, Opaque};
 
 use crate::bindings::{
-    self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
+    self, qemu_clock_get_ns, timer_del, timer_expire_time_ns, timer_init_full, timer_mod,
+    QEMUClockType,
 };
 
 /// A safe wrapper around [`bindings::QEMUTimer`].
@@ -88,6 +89,13 @@ pub fn init_full<T, F>(
         }
     }
 
+    pub fn expire_time_ns(&self) -> Option<i64> {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned
+        let ret = unsafe { timer_expire_time_ns(self.as_ptr()) };
+        i64::try_from(ret).ok()
+    }
+
     pub fn modify(&self, expire_time: u64) {
         // SAFETY: the only way to obtain a Timer safely is via methods that
         // take a Pin<&mut Self>, therefore the timer is pinned
-- 
2.51.1


