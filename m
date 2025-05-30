Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2FCC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiU-0002bg-FJ; Fri, 30 May 2025 04:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiJ-0002Y4-SY
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiG-0004d6-VR
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElGaxLGiSIb6e5dqiWIlm8oesZYBfD74a0jBFqGIj5Q=;
 b=ZiF+ka29QJWKqQHgmwvz8ZsG1RJTXzaqFQxLpf/Yv2/rDb2QHWtTAuDOkooAN2T5rbqnSG
 f2xIsJ7CJRT27/XlCFE6sKdYjWKudiOr7Paqq8+P5mOSsxhIbZCEeMUAEI55s5deKAyKo9
 6lI+OLUhyY3qvDuBR9X4ccblBHxrxtk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-QEDzb3LKOq2sr2C8KEdWWw-1; Fri, 30 May 2025 04:03:34 -0400
X-MC-Unique: QEDzb3LKOq2sr2C8KEdWWw-1
X-Mimecast-MFC-AGG-ID: QEDzb3LKOq2sr2C8KEdWWw_1748592213
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac3e0c1336dso108190566b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592212; x=1749197012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElGaxLGiSIb6e5dqiWIlm8oesZYBfD74a0jBFqGIj5Q=;
 b=X6k/yGsF/fDs7U13puy7S039Nbou6XQmwPWYrjmEB1cDLvHWGyTnM9EB7pojYsE/vk
 BYpfVhKmISK4R9mxxXeYTg/XVEb1+3eWzfCb3GhTygMIee5Rg7KJMFtZkKWyMmiSdT8S
 Qz7nHe5L9lrd5TvTw/1nxQHtL7ewAkkbRR25a+UYV/YPKB2Gmz0g4sm9nF258QY6J/ut
 vcamZulndKs5WWyqbiwAO+FhI15I+8pswXuEF52kfAPBXg4dONX6s2WCJb4ShRFpzzTR
 NqP0H667mASR+MORSWubZUzXgdD9o0FFvQ2UPQjHifI8vh/+N4YKHanhFgcXujYlM5y2
 KgCA==
X-Gm-Message-State: AOJu0YwAgxJ6c+aPjWPspcnMcM+pWMBbqkKb2Z/O7BihondDY5k+f9Zj
 fQpZdTFwLOQKXWC5hQ2I/tg7dYkzOeWbQXe2iM57MmMD1RL7nK3nsDcGBigX9I3JkUIMtCp+aoe
 UyepxttKJiM6hVs8LRtVpY/1iPHN5T1F6jzcMhNNWoMDENYHMFBFC8b3JbfgkM+fup/Bd9o6cS4
 KpxtQ/OKrqb5m5QwLZZOy5MJeIc3L2/vdlbIorz0fL
X-Gm-Gg: ASbGncuLWb4yXtSs6/6zYMlLy8mUuMr0x/H3rt46/1UaAndAVV/3t5R+L3iZVhTqn3X
 wGo9yYuV0Aq0LvuD27shOy6BHVS/lHARYb6Thoij3T6h2yJwN1dxEmQnKCzZt/yNpid52b0eZr5
 bcaCjGF03Q4bjgi3d9zAz8HQuUIu1dUFX0PqNYxqU4CS/Kn6PpIdxukbTK0LCOrmars1qNcn3fE
 H7iDexnE/GKudU4mkveKJwxmyGW1b4D7KVnHRIsN/7QAMq0pFOZ0qx5WUCGh/2pVZ6b2SFsy26H
 e6PpcX7qi+Ylhw==
X-Received: by 2002:a17:907:2dab:b0:ad5:a121:6ebc with SMTP id
 a640c23a62f3a-adb369a920emr115420466b.0.1748592211854; 
 Fri, 30 May 2025 01:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzlWwk+vNhNWbAmh9fEidfaKWhOYah4lEW53NzQosW8rlOvJbnHMfQ5hG1ycPNy1U7ojTbtg==
X-Received: by 2002:a17:907:2dab:b0:ad5:a121:6ebc with SMTP id
 a640c23a62f3a-adb369a920emr115414566b.0.1748592211359; 
 Fri, 30 May 2025 01:03:31 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fecc5sm287680966b.10.2025.05.30.01.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/14] rust/hpet: change type of num_timers to usize
Date: Fri, 30 May 2025 10:03:01 +0200
Message-ID: <20250530080307.2055502-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove the need to convert after every read of the BqlCell.  Because the
vmstate uses a u8 as the size of the VARRAY, this requires switching
the VARRAY to use num_timers_save; which in turn requires ensuring that
the num_timers_save is always there.  For simplicity do this by
removing support for version 1, which QEMU has not been producing for
~15 years.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 68c82b09b60..a957de1e767 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -12,7 +12,7 @@
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_uint8,
+        qdev_prop_uint32, qdev_prop_usize,
     },
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
@@ -36,9 +36,9 @@
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
 /// Minimum recommended hardware implementation.
-const HPET_MIN_TIMERS: u8 = 3;
+const HPET_MIN_TIMERS: usize = 3;
 /// Maximum timers in each timer block.
-const HPET_MAX_TIMERS: u8 = 32;
+const HPET_MAX_TIMERS: usize = 32;
 
 /// Flags that HPETState.flags supports.
 const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
@@ -561,8 +561,8 @@ pub struct HPETState {
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
-    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS as usize],
-    num_timers: BqlCell<u8>,
+    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
+    num_timers: BqlCell<usize>,
     num_timers_save: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
@@ -572,7 +572,7 @@ pub struct HPETState {
 impl HPETState {
     // Get num_timers with `usize` type, which is useful to play with array index.
     fn get_num_timers(&self) -> usize {
-        self.num_timers.get().into()
+        self.num_timers.get()
     }
 
     const fn has_msi_flag(&self) -> bool {
@@ -854,7 +854,7 @@ fn pre_save(&self) -> i32 {
          * also added to the migration stream.  Check that it matches the value
          * that was configured.
          */
-        self.num_timers_save.set(self.num_timers.get());
+        self.num_timers_save.set(self.num_timers.get() as u8);
         0
     }
 
@@ -884,7 +884,7 @@ fn is_offset_needed(&self) -> bool {
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-        self.num_timers.get() == self.num_timers_save.get()
+        self.num_timers.get() == self.num_timers_save.get().into()
     }
 }
 
@@ -911,7 +911,7 @@ impl ObjectImpl for HPETState {
         c"timers",
         HPETState,
         num_timers,
-        unsafe { &qdev_prop_uint8 },
+        unsafe { &qdev_prop_usize },
         u8,
         default = HPET_MIN_TIMERS
     ),
@@ -1016,16 +1016,16 @@ impl ObjectImpl for HPETState {
 static VMSTATE_HPET: VMStateDescription = VMStateDescription {
     name: c"hpet".as_ptr(),
     version_id: 2,
-    minimum_version_id: 1,
+    minimum_version_id: 2,
     pre_save: Some(hpet_pre_save),
     post_load: Some(hpet_post_load),
     fields: vmstate_fields! {
         vmstate_of!(HPETState, config),
         vmstate_of!(HPETState, int_status),
         vmstate_of!(HPETState, counter),
-        vmstate_of!(HPETState, num_timers_save).with_version_id(2),
+        vmstate_of!(HPETState, num_timers_save),
         vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-        vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+        vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
     },
     subsections: vmstate_subsections! {
         VMSTATE_HPET_RTC_IRQ_LEVEL,
-- 
2.49.0


