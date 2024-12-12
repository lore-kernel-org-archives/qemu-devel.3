Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D05E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmtd-0006th-Lw; Thu, 12 Dec 2024 12:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtZ-0006rU-SV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtV-0006pE-9p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734024152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSm79oz08FdIlTp31rLzEqSvbz1oNHscAzWwfiPVPzw=;
 b=NlXU0sidiUWDFLsBaOzmwOiyD0XsOPrcKAjRQsY+F9i3s05e4XjRFc9bvct0LVL4TlNpaS
 nMQS4WsJX6DZnYgI+E7hPaT5sgaqwWUcI77jLtr6y8gRsMhs6EhC1BLr/PsHixIRHT+2pu
 JsVJEIOcL8HW6AbL8YHYg6+1uOt4UlM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-3l1RppL7PUGfdPMBZ4iMeg-1; Thu, 12 Dec 2024 12:22:31 -0500
X-MC-Unique: 3l1RppL7PUGfdPMBZ4iMeg-1
X-Mimecast-MFC-AGG-ID: 3l1RppL7PUGfdPMBZ4iMeg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so411746f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024149; x=1734628949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSm79oz08FdIlTp31rLzEqSvbz1oNHscAzWwfiPVPzw=;
 b=bUa2C3GzdMkYz0SxAS+r8hQm+vXtOsP2Eab11lw5AsuWKNImWUY0o7thFHLqi5Hv5V
 CmXY6LTu1wwbk7pog4R1GyFSKD09dKZezdCmbcVS/c9HWy7oDproliMtdC+eXOO1SY3r
 ofmL8hH6aoYMfeRTyRmjYr5HOmJG8QhSXh1JX6zXmvCYTUYb0IK8w2WcddlCdvlIGibM
 JhEoK4v8jMvoJutCHMOxR8XfS0unZRI2gv64ac96zVPLmRsTtfBkLhgfXRpxqkLZdsC0
 5juFO8XwgVQ+qP5XT/a9CMuMZYLgOFm1kcLYoCrtMUC3mfTK2vOZ3DMvFv3XVvBg/4H9
 ywQQ==
X-Gm-Message-State: AOJu0Ywck+qF//YWUxnSl/Ij8pueKzTN3kgPCv0Xk5ZlFITJ48t+XZer
 OOkX7Sjhtu7sgPfEzYphwXgsRe29okBtHctbKZweFlxenpt4bbcnTd4tkkREMQZhzqcsOX8BjJA
 csgYR6R26PnzMUNqnsCBoFaO3sT2sP/UHlQ8OuUXKAIgf0ka+g42hzRzhEyC1yONOadM2LhWFLB
 9ffGpJtet1JpvJzu5ZVfVpD/sClzHbY3CEqlNT
X-Gm-Gg: ASbGnct1Hr+yndPCTiWHdRB1GX2i3YVcQ1lGfklEtxnsI18uJ1hLaSsHmA/ogLbzxiX
 Rth1ySdlcBAh16+mAyoscjvdciTIMtocQQI0elX+8nk6rnRqU/+dASckGSCaZZwSKl+3imYa2ih
 1WVFRhowtnq5lHzPwmGZCXwnqS0wIA5yw2LsRuo3tZx1P52IuwgBfoU9pykh66Zz7ZpKy+Xcuqc
 EPiltSetrpCCuYU4TphEv+oZbxISHPrSq70siIPwd+NRrUbDaf5z1lmRTnV
X-Received: by 2002:a5d:588b:0:b0:385:e2c4:1f8d with SMTP id
 ffacd0b85a97d-3864ce96ed1mr6918670f8f.19.1734024149514; 
 Thu, 12 Dec 2024 09:22:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERL4Pz7X8hJNKtOv0Z7DJ23nsR1ReastYOYfmmQ5wyeBe1Qf2yPsHd+ZqVQEJy/Mj+1+eu/A==
X-Received: by 2002:a5d:588b:0:b0:385:e2c4:1f8d with SMTP id
 ffacd0b85a97d-3864ce96ed1mr6918651f8f.19.1734024149076; 
 Thu, 12 Dec 2024 09:22:29 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361ec87bc3sm37435585e9.1.2024.12.12.09.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:22:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 7/7] rust: pl011: simplify handling of the FIFO enabled bit in
 LCR
Date: Thu, 12 Dec 2024 18:22:04 +0100
Message-ID: <20241212172209.533779-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212172209.533779-1-pbonzini@redhat.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use ==/!= instead of going through bool and xor.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 6 ++----
 rust/hw/char/pl011/src/lib.rs    | 6 ------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index cfe2734703e..169ff3779c6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -307,9 +307,7 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
             Ok(LCR_H) => {
                 let new_val: registers::LineControl = value.into();
                 // Reset the FIFO state on FIFO enable or disable
-                if bool::from(self.line_control.fifos_enabled())
-                    ^ bool::from(new_val.fifos_enabled())
-                {
+                if self.line_control.fifos_enabled() != new_val.fifos_enabled() {
                     self.reset_rx_fifo();
                     self.reset_tx_fifo();
                 }
@@ -502,7 +500,7 @@ pub fn event(&mut self, event: QEMUChrEvent) {
 
     #[inline]
     pub fn fifo_enabled(&self) -> bool {
-        matches!(self.line_control.fifos_enabled(), registers::Mode::FIFO)
+        self.line_control.fifos_enabled() == registers::Mode::FIFO
     }
 
     #[inline]
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 0747e130cae..69064d6929b 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -419,12 +419,6 @@ pub enum Mode {
         FIFO = 1,
     }
 
-    impl From<Mode> for bool {
-        fn from(val: Mode) -> Self {
-            matches!(val, Mode::FIFO)
-        }
-    }
-
     #[bitsize(2)]
     #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
     /// `WLEN` Word length, field of [Line Control register](LineControl).
-- 
2.47.1


