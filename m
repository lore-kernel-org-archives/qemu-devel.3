Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6EEC28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 21:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyzka-0004Ye-HB; Sun, 30 Mar 2025 16:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tyzkO-0004WZ-2A; Sun, 30 Mar 2025 16:59:13 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tyzkM-0007SN-7f; Sun, 30 Mar 2025 16:59:11 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac73723b2d5so302790066b.3; 
 Sun, 30 Mar 2025 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743368347; x=1743973147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HA5m80PGHeMhp6Qte+bs8EECaUJOTtoErWdt8fGztaw=;
 b=IcoMEteBHbyrO3qVhexoLeiCYQ5UrHWEs6duKC97CCtfXgQuvvfiprk6P1XxbwPaCO
 5zfVUw8/bqGVcqvxru/RitOlIorKAanyQ0qG43EkxQ2rBXG0blePS1o7r8B7PvWW2SIv
 FFnv0IBlS3j/E//2OYob776hLNH5sva1coJG4qc3C3kKFKr1VyyyL7eXrjNfcR/G6wwS
 BisJdBar7skCZh1iGIfoPjuPvcGOnUCyvonPiLg0pKsEg+uvBC1CnvGzR1HfwLsMnlIf
 9T/btdfu74forEaHB1YBLjEyT1UANX+h3bPGw9NZEHSo9ccdGpM7NlX2/1DA2zhN3zp4
 9K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743368347; x=1743973147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HA5m80PGHeMhp6Qte+bs8EECaUJOTtoErWdt8fGztaw=;
 b=TQZ8JBzAAxo6gYvwAUk2ptFBbax8AdbYnu1eo7Efzr7MRgtuRmx5DIY712KJlk3kid
 Rvlt9YCEShvlQWNJcDThyff1HyzzfUGreBj7Y4OhpghMLRhv4XG1LimxA4yzgt2lcEWT
 40QccsWZ8ykNWqTQK443SXlBqIVE724+sXKI5MU041v+biSQ9/JIzTef7yHp/yGVGWof
 X45yR9wZMBOiHdIfhNxpWhrecs2m2kYT8vxoPXJs66EZBt1OuCH8GoSoxo69Bzr2gmyq
 s4Y4P1f3m6tYYSxANXx0I0+dSuM9ny2ElnA+hiGzP85y8dRLS5CDVJOneoit5tKGjpEq
 eYUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQasJIXEZHHwE0q/O7FFJlClmeF0LYe2fU7TCasavaCmJMeuKIu3wWPfUpVJwr9Af1lUwOCnQRTdo=@nongnu.org
X-Gm-Message-State: AOJu0Yz5hBHuJdlqX8SY8Djuek/pMqGu6p/RLEMsOsM8e6h1slTeIqe/
 S6ETEphaflR4x/CeBKWOT7wydpY4+v7DVuWG/bzpkcvNxNLo00Qr/PpRnA==
X-Gm-Gg: ASbGncs7K9iki6d9r7tWX+L6p5ULgN6gDeQXwj+zL6jMjz19n06Ul3EXyBXhf7ERlWL
 DoPHzkuidRobZdNESaZm8e8dukvmYvDu2ObNtPwSBdOrdBK4aKkxTyINKale/el+tHBG02sWldL
 lagQKMLMJ8XpvjtFF0VYFr8WseUx1kj3XVQGfYjUSYr2VRMOhBc5AGu8AIMGXcTUHFJek+GjqvB
 qqjsLdvO+7gWQN9BNOjKDL2z/TZs+E+3SE40gA8+1Mznh27fZw07yDbd1WES6Gb3Xip3zlAk3q7
 tGpCCTwr7lnJ/zpr8HqeO/fm6O5OE09uu9aQY59Px+VgAGB8u12o3dVkCYaWuQlv3Emw6vZEGKO
 N15bnEMjv5bSkGB5vOoTdtXU35QlvkVgS/wrX/9R11M3TeldSLLqfOhRslNqNSPN/xA==
X-Google-Smtp-Source: AGHT+IF2MZWaFC925Fs+H9r0Zm2vTNCxqZjeGB2uLkRcTbrBH9lt9YvJmnr7W2fmdFQURiFoMYNaLg==
X-Received: by 2002:a17:907:97c9:b0:ac3:8626:615 with SMTP id
 a640c23a62f3a-ac738c20c5bmr686124266b.49.1743368347148; 
 Sun, 30 Mar 2025 13:59:07 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-2ddd-7900-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2ddd:7900:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967fdbbsm520902466b.135.2025.03.30.13.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 13:59:06 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/2] rust/hw/char/pl011/src/device: Implement logging
Date: Sun, 30 Mar 2025 22:58:57 +0200
Message-ID: <20250330205857.1615-3-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330205857.1615-1-shentey@gmail.com>
References: <20250330205857.1615-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

Now that there is logging support in Rust for QEMU, use it in the pl011 device.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 rust/hw/char/pl011/src/device.rs | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bf88e0b00a..d5470fae11 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -8,9 +8,11 @@
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
+    log::{LOG_GUEST_ERROR, LOG_UNIMP},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qemu_log_mask,
     qom::{ObjectImpl, Owned, ParentField},
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
@@ -298,8 +300,7 @@ pub(self) fn write(
             DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
-                    eprintln!("pl011: DMA not implemented");
+                    qemu_log_mask!(LOG_UNIMP, "pl011: DMA not implemented\n");
                 }
             }
         }
@@ -535,7 +536,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 u64::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                qemu_log_mask!(LOG_GUEST_ERROR, "pl011_read: Bad offset {offset}\n");
                 0
             }
             Ok(field) => {
@@ -567,7 +568,10 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
                 .borrow_mut()
                 .write(field, value as u32, &self.char_backend);
         } else {
-            eprintln!("write bad offset {offset} value {value}");
+            qemu_log_mask!(
+                LOG_GUEST_ERROR,
+                "pl011_write: Bad offset {offset} value {value}\n"
+            );
         }
         if update_irq {
             self.update();
-- 
2.49.0


