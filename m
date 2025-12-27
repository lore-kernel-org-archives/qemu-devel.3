Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C13E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRr-0000xE-Ee; Sat, 27 Dec 2025 04:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRp-0000hZ-HJ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRn-0004Sy-PY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFYcLWaF6fd9NaYzHhETNwC24PxBBmji/jH2TTf+UfQ=;
 b=D+p7amI51HfzfXtRPeltq9PA5T4LEqVXJ9pnrOJQ7ed+AqlTW4RGXZPjnqcoezp3LfUhAT
 7MfikGdm5pYfifNkDe9eWSoOE8JzfUAYPRfKJrOPiaPtDgijAR9HkHlKzkOLfvkNGafeq0
 TvcInn1/KpFBF4PWqMfmPZYTbP4ltEs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-QA11pz_wPDS0tU7M3aoXmA-1; Sat, 27 Dec 2025 04:18:38 -0500
X-MC-Unique: QA11pz_wPDS0tU7M3aoXmA-1
X-Mimecast-MFC-AGG-ID: QA11pz_wPDS0tU7M3aoXmA_1766827116
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779b432aecso45563785e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827115; x=1767431915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VFYcLWaF6fd9NaYzHhETNwC24PxBBmji/jH2TTf+UfQ=;
 b=onpQWD7yNPXEy50vqDmTt0WtaJiRbY4YKK3tHH9uUOz0yWb+Mjqc7pO7MCYMOEyc/f
 5I4+h6b/2lm306lPYcfouscjzh3mq+BLJaUSFlx0o6UwX698nsiDuPkYK2pVbpBJu8Nw
 AC0VYbNWxpN2G4ozccbmsJDrfyYN0U354+7tIvYUb7MZzIvn8hKM1oHcr7fL2rjy4/+Z
 EmvqR7Z3Mb/yD5MfXJsiI6LjGpIKR8JF3Rh45D8sCs9pkwHYkOt16sXjaom2hawOBn8t
 KJTP0AwjpnU53IsI1P76Jv2OFeQ5NNrHLRRE0XF9UIxwqN7l/mFDMEW1RjjHaUj5LEVC
 eYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827115; x=1767431915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VFYcLWaF6fd9NaYzHhETNwC24PxBBmji/jH2TTf+UfQ=;
 b=nIleM4BY+q4+SCAbcPwujSr0vlDH+P1UQN/g2YUF8XhE+rJ+pPDfNqej+d59ZD1Teh
 mBksTFCWJRNstHW9E+DPmRZ8QTUsWQxJYd8TBQGmhrcg3h2w7aDdYZ0Rv+r8xVwtxXT3
 rA8AyAgusowGneu0u9r+EXSYjZn4KoqF160x4JDUYw+iAx4hxFrWcQYnfYdcggGOwbUt
 hVKwAvVm4/y63XiTbjw9iRgl52XEUExOLbLMwTwWSd45mC4H66S89s8aZgW4Xl+eulBV
 jlgX+Z4SEW2ALxXnMionzZq1zNx2MHlH/GqhfaAzIdOTA53LARO/oZw9mM8B8DfKiNw/
 xZeg==
X-Gm-Message-State: AOJu0YzHLPd3evss1yepcoOmIplgX2wAyjv4ioZPeDxSDr7qftfBAoP3
 3Uu4W4mMnHcW0PJaT3fazCbb+GixxDBlPYIZKYvPgWmyjFP6cpXUbECVA/vENU5Sn+362KgWraT
 YFO6qnG8il4PUFr1tKpCYhZj7KPlh5K7g3om16JPLAD0g2KxiUR8ZjuWn4fWcaViE4lOc6kgTKw
 0VnmcT7v/jxgG5abjrLB/dopb3c7B2ER/1jZsafYoP
X-Gm-Gg: AY/fxX43Zac7+3SMokI7JcsHrqzhCXM/rZ+uuGXFqO4s+yWGz2Oe90Zkrvp07zRyZRK
 8lWR8an8r+NaDia+PDALhQyaeyWIQlD5HLzLmHoVKyomZLKqSvR/bQ5tM+AOaIY1+W8FOQnuVnl
 ijgNVmXOoGTMWc3T9uVNopQSsF5U68Sb9UkY0pLXSamxyPZM25sZLUqi4eEPCGyCtR096/fRoGj
 O+W4sgW7FW0Vnkt4xzfLhDGYTxThtI+9F+NX1sFbWjrw27Em/liLXtd6ey9oR84h6EAyHaV3bsM
 MmHwdUYu3crOL5llQjQxDPPXh2W/NDdDv9opjQinA8UtTuv3gDl6kL8/28caac0o85gYoo+Cj8V
 gI8G4/5xiCdWJvo6jVgfeOW08OmLvNjjG+7AGch950VaIqplOq4LeHYyVZej8LsWO9PW2CZ88Kv
 G3UQBf5mLsyntlLu4=
X-Received: by 2002:a05:600c:4e8e:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-47d1957b120mr291175795e9.17.1766827115239; 
 Sat, 27 Dec 2025 01:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERLqjFfUpsVqODdAeXDTx0Q9NlLiWoQPmI/6aNwRUDfVBXXRjM6Kbj43CvhA2uEyyQ/xu2vw==
X-Received: by 2002:a05:600c:4e8e:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-47d1957b120mr291175525e9.17.1766827114774; 
 Sat, 27 Dec 2025 01:18:34 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbc0bsm442954365e9.11.2025.12.27.01.18.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 067/153] rust: migration: implement ToMigrationState for Timer
Date: Sat, 27 Dec 2025 10:14:54 +0100
Message-ID: <20251227091622.20725-68-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 41d5c8fea0e..375bea4c96b 100644
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
index 02efe31d72c..7748aac2f27 100644
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
+            self.modify_ns(source as u64);
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
-- 
2.52.0


