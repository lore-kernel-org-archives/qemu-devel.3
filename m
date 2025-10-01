Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3098CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3re5-0006tu-3Y; Wed, 01 Oct 2025 03:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdu-0006cr-0w
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdj-0003AE-2B
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9M+JXFjjYaGik7uRmhhb/Emdc0Kj2h52R5hWa4pUnpw=;
 b=CLbaX2KzI0tgBmjs0MLYahkiJ/nApZ4ODrc0wyRqyR+zVl+ibiBBrf+Hu3nH/4RN3RknzP
 mc+JKj2XEsDTcrI7VJ2lOHC6mrw76VVDxm3uFBOBU+gCfpULTErM2MWZ0eAPZ0gimqeY3X
 6btfp2YMQA4QniDUVjpq19SCbgjIv88=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-VJlWji_6MhauCCr_677HtA-1; Wed, 01 Oct 2025 03:52:36 -0400
X-MC-Unique: VJlWji_6MhauCCr_677HtA-1
X-Mimecast-MFC-AGG-ID: VJlWji_6MhauCCr_677HtA_1759305155
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b4635c413a7so82878766b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305154; x=1759909954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9M+JXFjjYaGik7uRmhhb/Emdc0Kj2h52R5hWa4pUnpw=;
 b=wKE4qBDm7viC5B9tkoWxq7I8+CyPQUFUqwPYutsV8i8BiPqwNrsNgX/Cikn2K9SZzA
 v60YnYYUsUW5Pl8Y8GnCtmQj9euFVlrMaPWpZmChkusr3g22sxDcgvPYlO+2iz4iMtlW
 d9knChRbU+ClHSk/XjtOqRUq7quoGpEOF1H3v63X/7YB39St6c0pJ8t3ncb0e6bS1RJq
 MJ3mBcIKS5QXtaXc8ds9wR1/saeRcOktBKC7fFUudFLNThJIW8G9cCVwqtsNMH9HPdZZ
 AFvV5kT//NhTOKoQstVti1NI4Ejdco1F369yI8/mBLjysZH3GJJg0ecuh4ZipxOrBHR/
 3YLw==
X-Gm-Message-State: AOJu0YwGP+c8cuPnGFxKd8Vh9K9yqDqWiky51GN/EiKkYZNZOWTeE2CV
 MzImbeuG8g4v8ztZuXy8yJDJGOgYRsOu+PsRBRvmoNOR6JKbciDxfKXg/H4rL287oxbOoND+MRP
 nTimJvQV/jY1Iz6vdvCKDwv9tlyt1kokN7jOv7A2EbNQWKnVRAq5KVlQ0j60JB5ioNaPRPJGZml
 yFlv73qjzeCiNe+vR9kuGw06Sc/i7CXE1R5l84i33v
X-Gm-Gg: ASbGnctqt416paLw4+IDj3/riGB2hLyY7e8CD+7UuKZRM5NwIUNSphkrSYSiJo46/Zz
 KTRKv4LGdPU81RzrfDFWwyZmxQZpbGa3Os1r6j4oc/cW9x7hil+9jFK2s036Otlq5qecw2a5Eqg
 UueZACPVBH7HWn37y+ZQWEVwLdUzn6wm41YgCzICZDRSRCw9gVS1msMIcdiiqIe/BaHocx42uMR
 QeS6tnON0mKgqeXZLWgejG3v2zdXfrElUiVQAGkRrZHAF942OT8YmzeZrttgOnQypH3RJl9qKf2
 ii3hqrhEgmmqQrPGD1ihttqpTs0qTmJUUew9Z7cYd1T7M7PXuoeE/SGQywtAg+hHb2NvVHnebAN
 DbWfFHft7O/O0Hea/YspP/FkAX3Tb2SS4cce4lnpglXOI6MdvZvY=
X-Received: by 2002:a17:907:1b29:b0:b40:a71b:152e with SMTP id
 a640c23a62f3a-b46e8894987mr299772366b.40.1759305153913; 
 Wed, 01 Oct 2025 00:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6WP6hJ6UkCJTgM7/xWFgRIC7iT5TLWIGuL8x6esCRYsMDqsRILHgMiO6b/08bnE8KXdV6Fw==
X-Received: by 2002:a17:907:1b29:b0:b40:a71b:152e with SMTP id
 a640c23a62f3a-b46e8894987mr299769366b.40.1759305153459; 
 Wed, 01 Oct 2025 00:52:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3c9ab5d70esm720656366b.21.2025.10.01.00.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 10/11] rust: migration: implement ToMigrationState for Timer
Date: Wed,  1 Oct 2025 09:52:09 +0200
Message-ID: <20251001075210.1042479-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Timer is a complex struct, allow adding it to a struct that
uses #[derive(ToMigrationState)]; similar to vmstate_timer, only
the expiration time has to be preserved.

In fact, because it is thread-safe, ToMigrationStateShared can
also be implemented without needing a cell or mutex that wraps
the timer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/migratable.rs | 31 +++++++++++++++++++++++++++++++
 rust/util/src/timer.rs           | 10 +++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index ded6fe8f4a6..e85ef810efc 100644
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
index c6b3e4088ec..a99ff5e7ef7 100644
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
@@ -86,6 +87,13 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
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
2.51.0


