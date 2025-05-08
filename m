Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BF8C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 08:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCwdr-0001Pv-CI; Thu, 08 May 2025 04:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCwdd-0001Mk-UE
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCwdb-0008DJ-V4
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746692991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgVmgTmeCyafdTkrLAjxXKPoGVFjbr8Uvw8ZenJ36pI=;
 b=JSuWV9sq1uRg50OLdWfDiZv1Bp3Qy+TPnIBUxIP8PHiUagXJbhxCUazN/3KDL/ELbuT/p8
 aqky74Ikp/30S9u9Zo0PMgqTI6bAvNX5P5lHlOk8jXut2eeMFZGuIPRZVsBGswayRvf0OR
 6gI50JCGyRmw0u6u1wCzFF0GX0i1Fkw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-op5eBxz5PbuFVOmVzx-aEA-1; Thu, 08 May 2025 04:29:49 -0400
X-MC-Unique: op5eBxz5PbuFVOmVzx-aEA-1
X-Mimecast-MFC-AGG-ID: op5eBxz5PbuFVOmVzx-aEA_1746692988
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so3090495e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 01:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746692987; x=1747297787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CgVmgTmeCyafdTkrLAjxXKPoGVFjbr8Uvw8ZenJ36pI=;
 b=JFudbR/1ifey9Sy5RcH0Y9QAcYw4HNaQt+iNrUER1Rrme2rmCjywjmN18ziHkDjLkc
 E4eyJl/yFZ4ISffjR8oPyHqDvw44Jnwz/GPnaDu6tibmbIq7U7nDacrXpQbUxftBKm6h
 x6EyxQfP623YjI946z0rMbWQPVL7ZjhDHRzbOv6oupDlARyuRsnIh7gJDGddDCg7m4mA
 Mm6d25M8BN3nFbNe5xjk01WkHF8bb76oHAz4PD5NzAZgqdKNUR1b4mNghWIBg+FvLV+E
 YazbS9LWfXu4UMPuufCgEGWrqwVifFW1xDVWyW1uqKPxfpMD985AAmo6+meOxD6KKQ84
 YI/A==
X-Gm-Message-State: AOJu0YwGFLxqskKmuN60aBpc/q0XokO8sGDB6HyfoYnY4Fuu3l2lhi1m
 Ge2sKCFBFFM3cvexv8z5Xk3ILyOTre7E+ZCIC50jlUOzr1IOsQudPG8/RonvvAMes20VRuiRg1p
 4xyfRrqSPnZEBFazaNTfECdVtMwe45xRG90+Wr/iW62R88ws/csYgNuk/SvWU/Y3Er8XSjL7EYR
 WeR++3WfjeGWkG2iOcEH2zKfK3Y4uh5oMIL1Ad
X-Gm-Gg: ASbGncvkvKwBjuHVptAXvAGKZCrCnqG826kWg9CXgnjqCqglr9fqnYoZt37O9iQgreD
 7Hib5pN39wbYZne4bpwrp2FNpKs6YMjfSQtNzfUa5M3VH1TNfCnwd4Vc62JMNhj038kSzk1g/Ld
 qV5x/xht8HOoHD7jmNoaqPcBr3bGwgqqVcRG3OKyPInR5JXNhyG2rd1dSvo7t21mKDsAPz3SqVY
 V1BaORrmPAWVDd31rm1jRK/2tnexX81ZKjKO9l0l23jVgBcA/MvD4i9wlnY8UX4AR0fbBUVb8js
 YmFdjSlnrtxppjo=
X-Received: by 2002:a05:600c:35d3:b0:441:d437:ed19 with SMTP id
 5b1f17b1804b1-441d44c4457mr46435255e9.11.1746692987469; 
 Thu, 08 May 2025 01:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8lSGqKWZFXvAOr2WtLaLhg1mNzcPEWn2u4Lvw9DY1hoprSfL/aKo4xymOQcaB6S4grOebBA==
X-Received: by 2002:a05:600c:35d3:b0:441:d437:ed19 with SMTP id
 5b1f17b1804b1-441d44c4457mr46434895e9.11.1746692986976; 
 Thu, 08 May 2025 01:29:46 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3810c7sm28200135e9.38.2025.05.08.01.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 01:29:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/2] rust: pl011: Rename RX FIFO methods
Date: Thu,  8 May 2025 10:29:42 +0200
Message-ID: <20250508082943.446512-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508082943.446512-1-pbonzini@redhat.com>
References: <20250508082943.446512-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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


