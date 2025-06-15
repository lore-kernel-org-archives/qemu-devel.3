Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A83FC61CE8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 11:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQlQT-0003gE-RR; Sun, 15 Jun 2025 07:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQL-0003eG-Ly; Sun, 15 Jun 2025 07:21:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQI-0007y2-U3; Sun, 15 Jun 2025 07:21:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so31189935e9.0; 
 Sun, 15 Jun 2025 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749986472; x=1750591272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8ZAY6eIGVrJzx52bkDggMM638/7q1R15DHDcagaO4c=;
 b=bBouAGmjp+EKpkQUAvuw3YMu+LsmZqesjGKBezJ0Lvop1ieZC64pf6vKc/wfBAUJVL
 ZIqjt2ETfUQkpxRfIDOnvUMv2FlPwIIK4n00e4nFriguEDoKAPE6YUvDo79ev1/Pwu5W
 IIRT56NG2+e0kScMF30D2dtOQlfg3PkGWieVsIWhP6Uzz4ATnBayQ6i/hSWzTUTCPJbB
 3c55CLVnZoCuq9pcu3pi6Oz08ayBKupWn1NFCAkKDxKsP3DvDc+4m+K87Ln0iFx6ylXz
 D8N9E8Hxb3AvgA9WRvusGk3dfXwr30xilBmvX/DzPfW4Lb4FrDC//dxE+mjl3g/n0nNS
 POdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749986472; x=1750591272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8ZAY6eIGVrJzx52bkDggMM638/7q1R15DHDcagaO4c=;
 b=aOcsxOctRhehxFg4ue3LVEQGkkySpAfTsRDbMVzlBylRaheeVC4EB9rHB4weyPpFGo
 FSDVAaHX6iMct473h+vjdYfBc0AY1rl8xWsegLYUu1P2jDkudbWz5hfl65llXLc55o+1
 f+YoBy95z4enUSgRqA5ZN6mlbpqTuUzWkZzE98ojfVGegEj+92WZdMeQtt1APOsZ0YCn
 QheWwFriXGTpZkPA8hFdgDpyZZsTPdaAX1dxjGMT/1CARlVQuESrRyqWzPbWTzBYIWvC
 R3F3/CV4Lhapu/sbTsWGpSuWh47v7uPVOwLnoGjvemFyAvagjXbe12EzYMyX6ODixbQ8
 Uqqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuvN23sM6s9NTYnb5MZLbfDPBPjM7nBJfrFaqatPC4kGVSx8mbd6weU7z59iq7BMvnsMwzCh+qzvo=@nongnu.org
X-Gm-Message-State: AOJu0Yx0JYzB7vlcVSXkcQZPn2pZUJLZS6Z4JT5oSo3LqwON4cDWZ0Bu
 6LAJoUWyI8nfoTaKPQxJRv9mXXINkTYIprBNLVLK5omLF3cVPZSvde9HGQQdoQ==
X-Gm-Gg: ASbGncsJzdihlHDTBhJVxmVWWvYg1VKwsuaboJxTylnvfV7xFW2oMXXajR93fU1HPWM
 qVaS8M38/BvtzaosBpvxDEsqZ9EKSNcfI2pSsAsCDGlQ+8T8miSN3fhHvDsYvPS+i/66VT89/W4
 NcSt73OSZM00B4uKhDAQgHxZRTnek9t1pfOdUYoO3eFR04aKBKHzks7X/bdsV9HHpfXI8X1sxhR
 GNENbZReVJf8fIS7f1feaPGHoJQscf2Yg68xXl2MkIHH6adRIoO+kihzYtTT5gcle4A9ANNS548
 0MI5/UTF4/0XUg+doMIKnfbfZmGy7w1632WfwUFR72wF2hsoNMTAFPac/sWwYhvwHSI/KquTjWQ
 rkQ9mdQ5APuzsar2gxBpytmxPuS1tcErQ3FW3UrpH6ptCi8YCvZV2rvKceKxRgmhmg6D0Z8S3OY
 YxmbWCjuRYi6KThdFY
X-Google-Smtp-Source: AGHT+IFScch2F8u1V6k+XUxgjGw6Hq6dhWt9obagz53Lc3uwHX9XfJhcJloREcz49cMl0bqImtWC8w==
X-Received: by 2002:adf:9d92:0:b0:3a5:7895:7f6b with SMTP id
 ffacd0b85a97d-3a578958019mr2801870f8f.7.1749986472088; 
 Sun, 15 Jun 2025 04:21:12 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-231b-9b00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:231b:9b00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm7327099f8f.89.2025.06.15.04.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 04:21:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 2/4] rust/hw/char/pl011/src/device: Implement logging
Date: Sun, 15 Jun 2025 13:20:35 +0200
Message-ID: <20250615112037.11992-3-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250615112037.11992-1-shentey@gmail.com>
References: <20250615112037.11992-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
index be8387f6f2..fa591c3ef6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -8,6 +8,8 @@
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
+    log::Log,
+    log_mask_ln,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
@@ -275,8 +277,7 @@ pub(self) fn write(
             DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-                    eprintln!("pl011: DMA not implemented");
+                    log_mask_ln!(Log::Unimp, "pl011: DMA not implemented");
                 }
             }
         }
@@ -538,7 +539,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 u64::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                log_mask_ln!(Log::GuestError, "PL011State::read: Bad offset {offset}");
                 0
             }
             Ok(field) => {
@@ -570,7 +571,10 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
                 .borrow_mut()
                 .write(field, value as u32, &self.char_backend);
         } else {
-            eprintln!("write bad offset {offset} value {value}");
+            log_mask_ln!(
+                Log::GuestError,
+                "PL011State::write: Bad offset {offset} value {value}"
+            );
         }
         if update_irq {
             self.update();
-- 
2.49.0


