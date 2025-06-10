Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360FEC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5Ta-000069-Aq; Tue, 10 Jun 2025 16:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5TM-0008VV-Am; Tue, 10 Jun 2025 16:21:28 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5TJ-0001JE-NV; Tue, 10 Jun 2025 16:21:28 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so9435648a12.2; 
 Tue, 10 Jun 2025 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749586882; x=1750191682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mwAkV2ZVpCuhcQmhWwgDu1m1Z/Imf1J6IuSoGrizlU=;
 b=I16UH0Ch32G3s/85rdXh4yvF9r3Qvuk22tbhx11t6vQ1/gcFiFqbT0IwshoezIDRe+
 vIn7Qj33mBcld0FmFj1yTk+Mm5dJeYxXOV4Ln1zmWVxcB+eCuzfgzcm8fhi0H2C/OIgc
 GVBZ5lTCPrjD/ILzOzfBEO1EVSuCiLxgG4aRuETxkGhtdVLghGp0S7Y+10CZ+h12Y1IP
 FShae+82jo/qUnQuTks3z3VsurpYjX5cVkf8dROWduUUhPjO+7od4Ntxkh9Wc6tnG8wx
 TACtWSfq01/35yu9XS/ss+/1RCe39amdhsqulP6jl0yO5cKpoqFC6Oug8X+JASLx2EvP
 OwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749586882; x=1750191682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mwAkV2ZVpCuhcQmhWwgDu1m1Z/Imf1J6IuSoGrizlU=;
 b=w1xHOPY2eZKzBddhuWBBjqxgiixSRsfzjoPk5XIS+yJR2KCqzF5LHYTZGFgIu3qLjy
 32kGZW99blrNIU/IVql/+btpUgllSs4+6OsSt4bd9UAQMthRz0tO4iCZWLF06KMpZjn4
 Uy6+oP7S+6R+8AmmlTb8ug2FyMx3uCiarPTek39qyu6UWPj8vGDIBQ6aJloTaGc7HaJU
 NHLAvUcziHKC06FvNA5eW0UyF/aOKxmB3/wqtFI10dYtrXW9foNF1/Tr+ojHJJp44JgO
 pkboyeqzqK+WNNd/ESGn39f5VzuBPcCZ86K9t7ehGHqA3yxRfqrzxbQmJbJxk81W+84r
 TnPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFJyeNcHFnu9pAB0d6al1oDi//UmfFDbphKn4/6DruBTHwxG5rZRisP9C0oKURwOzomT+JlGCIyw8=@nongnu.org
X-Gm-Message-State: AOJu0Yx5HefZkHXmYycX89/29pMqxf9fLpMIfB8g9e+u6uE5sy3Kcyhb
 dl517Hd2Qwb024GX86M0cDRF86QarpDa1hW1pkYgJ4mHtO8r71dFS6h0oJKN3A==
X-Gm-Gg: ASbGncvK9FDWfD4jtjRrPvN+/03GoH0HJvWGy49XcHALN7gQpC5qeRK8VkHoM1Vc1BJ
 lKekCybnctqopo+kxwi1a2o1qrf6m7iD99n+zII8K6ThbcNiMuN+nXob0hlGL8I7RBR7XpMY1uR
 VyStTnuBMyx5DlbxkxmAISrrUM5wq73v5FCzWdQgF7aeEggRVcCKWb7FNeCgCmtpbC1Y4+kcAbC
 BBbsqL3InK1wYZHpQ3xzWlErmcLBlO93L+47Tn5ZsYuvCDxxxIzcEJDCPRA5phczjwx5V54fVFH
 QeHsXYycizj2/W9BfC5lJXB5y/TnJfrCqsB0EvzWrpvcVcO/M/rl6l5op4oz4mOsc0KHA1gPKDK
 oV8Pn0KVIn0jyD/ixQEC/Y/TqyIHL5VYc8sOmCHZZk43aNRKKDw+Qii7cfiU480e80mnrwA4H8L
 Usx/hTAA==
X-Google-Smtp-Source: AGHT+IHiq3rlRmGcm6c+92AV20ASDAvlReFEmP6CyyYhP84jS9T8i2qP1KPimywoB6Yp/zhldmu1iw==
X-Received: by 2002:a17:907:868b:b0:ad8:8efe:3205 with SMTP id
 a640c23a62f3a-ade8c996df0mr17918766b.55.1749586882134; 
 Tue, 10 Jun 2025 13:21:22 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2cbf-5d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2cbf:5d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc7c786sm793135166b.172.2025.06.10.13.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 13:21:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 2/2] rust/hw/char/pl011/src/device: Implement logging
Date: Tue, 10 Jun 2025 22:21:10 +0200
Message-ID: <20250610202110.2243-3-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610202110.2243-1-shentey@gmail.com>
References: <20250610202110.2243-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that there is logging support in Rust for QEMU, use it in the pl011
device.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 rust/hw/char/pl011/src/device.rs | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index be8387f6f2..17a4e9269c 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -8,6 +8,8 @@
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
+    log::Log,
+    log_mask,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
@@ -275,8 +277,7 @@ pub(self) fn write(
             DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-                    eprintln!("pl011: DMA not implemented");
+                    log_mask!(Log::Unimp, "pl011: DMA not implemented\n");
                 }
             }
         }
@@ -538,7 +539,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 u64::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                log_mask!(Log::GuestError, "pl011_read: Bad offset {offset}\n");
                 0
             }
             Ok(field) => {
@@ -570,7 +571,10 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
                 .borrow_mut()
                 .write(field, value as u32, &self.char_backend);
         } else {
-            eprintln!("write bad offset {offset} value {value}");
+            log_mask!(
+                Log::GuestError,
+                "pl011_write: Bad offset {offset} value {value}\n"
+            );
         }
         if update_irq {
             self.update();
-- 
2.49.0


