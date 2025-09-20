Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7856FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyba-0007Nd-Ud; Sat, 20 Sep 2025 10:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybY-0007L8-0r
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybV-0005Td-BI
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pbC1Ps+dAzTsqIP6WX+wZIGyK3TQi+fmkaYLXqHka4=;
 b=gd049jE5FnPGLTdA/Z8nXgxtvJLMvk9aL74b9A5Ju7Bv/SH3MLgHls0VmuFeDcnq2T23Hn
 lq/1KZA0/UUhvqMJwpQNyigqs+0lvcnXf3RL0SMf+V/VwG7EMmrrFzpkeu7bFJZhv6nzmk
 Si21c1WYfirqQwOX4+BpYZ5mPRkCL9M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-ynGdb7-dNHm4Zw015DGTDg-1; Sat, 20 Sep 2025 10:30:18 -0400
X-MC-Unique: ynGdb7-dNHm4Zw015DGTDg-1
X-Mimecast-MFC-AGG-ID: ynGdb7-dNHm4Zw015DGTDg_1758378617
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso3387025f8f.2
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378616; x=1758983416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pbC1Ps+dAzTsqIP6WX+wZIGyK3TQi+fmkaYLXqHka4=;
 b=b1+pBsdYAbc6scu/yMOx0pHKak0Xl5fTjWbkeACWik4mC53Ig6dh73Ev5Arg1jNajW
 v21Y1mQGvHCwwRfHb8glDMuiNSwPrRbbaPQBR3lyV9t+Ic+7tmYVhX5AbIjB40Xvndp1
 nk7KW2Sa8sRX9Eg6jCKFn28aKbz5p9t4E5V12wd+Jtsst3Zmf47/mdZsfwGjPZCVE0ph
 WQEHcfUMToH8/He7c0oQlWgpYsiQ4akgsLuPPVCc3fS90Q9l9BMAOuw9b9boNIh0Ul9r
 fHpv1hoVIRZM0qo+ePyYCsUG5bnPrUN7vkcL8PDc1Ve7EVtuVt1AeY2uql7iyAPZhJAp
 LRVA==
X-Gm-Message-State: AOJu0YwTYWZBwNvZaoNaQu3h6n8BRP2ryAGOsDdw2HZsNSAP75LRTvUM
 8wy3FhQUTeTwUvPlmeVT9PrdH0y3L4LWDDaUSd3M5GHBywMzMzVZHTySjpSCWOCd1Vhz2r5cmkV
 VMNRMRN/EDf5LgFc9sxVF/NWqzis3ZffTiZJGPdxKHEvG9Yhnoge16WwE7iAlUK2rCi5v1Uo/W/
 fa6njtr/j6+5SrkctjwgrPHUWIzRqad8KVOlsPu2Wp
X-Gm-Gg: ASbGncsC1D/HwF3pu1KvUP5y1EwODHED4eFis/HPgDRCGNW0hPDt6zHC6/UyR91zKQ8
 0VJrxSD6MzG2lLKQHwtuVxb/C/AkCydkPIaYV4SMh1ASrrT1LDFWa3BA9jSynZu5fIRwR4/mwnW
 /rQyyX9wDYrBBQXi2vWBL7o55IuhreQZPWoxmXW2oftvwmax6nbQquF9ZQSym1s7gUJbG4FQbnm
 G3mDrO2XsaANnqBy+y3HiIcEicNx+0P+lb7rwGmYNrvhA5XpnaeaA4TFr8eFR0gMoX745GrSW7w
 Iy8TM4tWJJjWhsNDexpSh/0CJjOncjVAAhadUEvNVHByU6y+TVbXMcPHIzCL6UGBHrrndg/OXG4
 RU13vxuKBHGhZGaUxJ18Wah30xgh00we72weMqc8J8RA=
X-Received: by 2002:a05:600c:4ed1:b0:45d:dbf4:8880 with SMTP id
 5b1f17b1804b1-467eb048bbcmr52826305e9.27.1758378615804; 
 Sat, 20 Sep 2025 07:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtpQlVrIBjGRymU78+iTO0yanR7FsyLJIrN/bi/H48KCbH18Ao8LVGUxN9TCaPjw6s6r9nVw==
X-Received: by 2002:a05:600c:4ed1:b0:45d:dbf4:8880 with SMTP id
 5b1f17b1804b1-467eb048bbcmr52826105e9.27.1758378615388; 
 Sat, 20 Sep 2025 07:30:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbf3bfcsm12532849f8f.58.2025.09.20.07.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:30:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [PATCH 6/7] rust: migration: implement ToMigrationState for Timer
Date: Sat, 20 Sep 2025 16:29:57 +0200
Message-ID: <20250920142958.181910-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920142958.181910-1-pbonzini@redhat.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/migratable.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index fa25317eea8..c4ad4f73d5c 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -202,6 +202,37 @@ fn restore_migrated_state(
     ) -> Result<(), InvalidError>;
 }
 
+impl ToMigrationState for util::timer::Timer {
+    type Migrated = i64;
+
+    fn snapshot_migration_state(&self, target: &mut i64) -> Result<(), InvalidError> {
+        // SAFETY: as_ptr() is unsafe to ensure that the caller reasons about
+        // the pinning of the data inside the Opaque<>.  Here all we do is
+        // access a field.
+        *target = unsafe { &*self.as_ptr() }.expire_time;
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
-- 
2.51.0


