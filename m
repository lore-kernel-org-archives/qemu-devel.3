Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E87C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTQ-0005Tc-7F; Mon, 12 May 2025 15:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYT9-0005S8-UC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYT8-0007Un-Bi
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rRJjZJliGh6hgVUcZDujfGoc4FtIeQ+1jIdIdwQh1g=;
 b=Ll0pEo2/UMi+poHKGkYF5wssxP/TfHOwLW1HuHeEiLyI9ha8LrwgIFEFYBIziNC7FoJCjP
 YwxTgV7yMa85ra9LUIhmu9TcsoYk6oLt70nVTwE9BQ2rskHHqH4fYeVcoNjRFJo2Pxr5oK
 tAQRVy3HBnOnz3H+rdoS98ETzuBAMfo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-8vLnEx8SMIa8ZVgQgtGlwg-1; Mon, 12 May 2025 15:05:39 -0400
X-MC-Unique: 8vLnEx8SMIa8ZVgQgtGlwg-1
X-Mimecast-MFC-AGG-ID: 8vLnEx8SMIa8ZVgQgtGlwg_1747076739
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0af6219a5so2206530f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076738; x=1747681538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9rRJjZJliGh6hgVUcZDujfGoc4FtIeQ+1jIdIdwQh1g=;
 b=NZLlufFpZnAUtiBqKMfhJXQk35nTuj96tyHTYkj5q8ZKuC5FXoGIpIPhdB5wNOUvWl
 jwighQKJT821LEf3RzDxEE/rtY+dtDtmhXTJE1GDqK4nttI3/zmk4EAltl6Q5bem09F5
 Nv7fOaYUkAQ3FqnQxEIr6Pq8DoJeu5eO8y0MseXDin/s3wE4Y/Xiyxv24HrTY2Ov9Qgd
 qmPBMyZNqlwkWhYCg1DEX6b4zQuLHuVwaTRLT7/yXW1dY0DGlufM2Ws3TPKLNATkCtId
 MQNN7Adf6mjbONWPfgsrNSSJHhsJ04n66OVO2Hxngpm2WDj2hccPs5KiIHSR9QJAMnfg
 pVpA==
X-Gm-Message-State: AOJu0YwVaeZ/dMB6bgc1HRbfcAlqa8PlcEmahu56JRr6haK4JmFI8jWY
 CNyBXaDD2zTkMfE1L9joyR1MxX7QijI37PlOjva1naoMHRZpIIdBDyq34uVJOZkK69cXZ722vIB
 IUVkpcdJ8LD6mwxJoIkcEuXY32A5/ExDtSzI6P/j0LE5m69ORob9OYJbZp9N88wElnLCHN2ER5G
 cucs9ISqx/e/1dmmYHzAbM9sDzY1Q6vsjQZW0P
X-Gm-Gg: ASbGnctrB4wdBbhSkZ8Bzb/MOGm5LTz4q/9XAee13VomsoGfOjK6UwyCufAGEIEkLQh
 lMDfQuS4lSiGH6R+iWDT+eiVX1ya6oPeDf7rKy3OY/GOrgvx7KAI/1M7Wo2ftN3Ey/jzfj1US13
 hXFqv9xE4erk4MXsKSIqbs4hH7dOwOyGzMXowSd7zM6TUeQP0TIE8zikdRp2AHiOL4DjSafiU21
 S0nVJqTVYriPcOSFMS8E26ICkI5D5LZM55S3ESk9BLm+IIX4vWex66IkGDz3fZxtBrPZYcYD19Y
 cWH+erUcoii93Ik=
X-Received: by 2002:a5d:648a:0:b0:3a1:f70a:1f65 with SMTP id
 ffacd0b85a97d-3a33f9e5a81mr622668f8f.0.1747076737953; 
 Mon, 12 May 2025 12:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDcK5dIk6tJCLaXP2z83N/9DziM9BCdrcE+cFNm3TygWjzbR0sJftZL8iTTjWIVI1c4XwqCg==
X-Received: by 2002:a5d:648a:0:b0:3a1:f70a:1f65 with SMTP id
 ffacd0b85a97d-3a33f9e5a81mr622650f8f.0.1747076737610; 
 Mon, 12 May 2025 12:05:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4d21esm13582685f8f.99.2025.05.12.12.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/16] rust: pl011: Rename RX FIFO methods
Date: Mon, 12 May 2025 21:05:13 +0200
Message-ID: <20250512190524.179419-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of having a TX FIFO, rename the RX FIFO methods.
This is the Rust version of commit 40871ca758cf ("hw/char/pl011:
Rename RX FIFO methods").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 7c563ade9cd..94b31659849 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -329,7 +329,7 @@ fn loopback_tx(&mut self, value: registers::Data) -> bool {
         // hardware flow-control is enabled.
         //
         // For simplicity, the above described is not emulated.
-        self.loopback_enabled() && self.put_fifo(value)
+        self.loopback_enabled() && self.fifo_rx_put(value)
     }
 
     #[must_use]
@@ -439,7 +439,7 @@ pub fn fifo_depth(&self) -> u32 {
     }
 
     #[must_use]
-    pub fn put_fifo(&mut self, value: registers::Data) -> bool {
+    pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         let depth = self.fifo_depth();
         assert!(depth > 0);
         let slot = (self.read_pos + self.read_count) & (depth - 1);
@@ -589,7 +589,7 @@ fn receive(&self, buf: &[u8]) {
         }
         let mut regs = self.regs.borrow_mut();
         let c: u32 = buf[0].into();
-        let update_irq = !regs.loopback_enabled() && regs.put_fifo(c.into());
+        let update_irq = !regs.loopback_enabled() && regs.fifo_rx_put(c.into());
         // Release the BqlRefCell before calling self.update()
         drop(regs);
 
@@ -602,7 +602,7 @@ fn event(&self, event: Event) {
         let mut update_irq = false;
         let mut regs = self.regs.borrow_mut();
         if event == Event::CHR_EVENT_BREAK && !regs.loopback_enabled() {
-            update_irq = regs.put_fifo(registers::Data::BREAK);
+            update_irq = regs.fifo_rx_put(registers::Data::BREAK);
         }
         // Release the BqlRefCell before calling self.update()
         drop(regs);
-- 
2.49.0


