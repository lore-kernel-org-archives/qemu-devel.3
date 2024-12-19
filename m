Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453C0E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByp-0006uy-8r; Thu, 19 Dec 2024 03:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByl-0006pl-MA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByk-0005H8-4c
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTPmYEtJQTF4LhpsXLNB3KolsGRJJ0DGDHYuyRBvOuI=;
 b=Rc7h8eiyUTqJKL1bzZpTau8hrGpUqW1jd1RaUN39oWs+rnxzvsH5s5zEC3WIl/x6QptrtW
 CtQO7koRvtFEsLfPb/4Zl2lq7BeS7FHjnoFWfd0+mqNCberryGDURlDJ66eA+TTs1CAeOG
 Y+FCQ0eR/zzIB9a5K0mrnfrZNiH8VBQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-9vpJtQ6cN0aiRgCQVpbAGw-1; Thu, 19 Dec 2024 03:33:51 -0500
X-MC-Unique: 9vpJtQ6cN0aiRgCQVpbAGw-1
X-Mimecast-MFC-AGG-ID: 9vpJtQ6cN0aiRgCQVpbAGw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-388d1f6f3b2so223123f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597229; x=1735202029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTPmYEtJQTF4LhpsXLNB3KolsGRJJ0DGDHYuyRBvOuI=;
 b=VLrL1IH5x4lpnaTbjJENXRsf6Iq/LqARDQhg1DZ+uCfu5gvYlhF9DXqfukXwBSilEF
 p+IuHNwXw1QkBOrCGDyWHn77wt3qdOTRtUBwse7fUTxI60441FuxSiAx/OKD3MEWN6Pj
 f/ZTZYDF5Qum1ui0s5l1ttzfbVARTA/f0+9kCnwTrO6Pv2lBzMnwf28cUBH1+3I6+znz
 gMTYOQX/ENKbIGQrO9nMnfpEaJJT4XImSPu5lfRWoHcDUXuuxoD2TOpyy2b9PTc9kI7q
 AeWVXxrsg8BY1XD+9Bn9hybINhst+moHYju+ZMk5kMvJUda8pcl0a0Z4ayd++0kOorrF
 4HaA==
X-Gm-Message-State: AOJu0Yyw7mMnOXcGqGvdIdFM0kROaH22hk+FNNeYDIZi0wxyljgvkQ+L
 YjrQ/gkrBmKaqiWPz7oFUUk7h8HnL5B6l7DlI79XWGflG+KsOcBdlAmodpcz1lL59srSej/nVgv
 86f0sEgEKlTaYddXr0LCJlArkarwx+li1FlSDzB3ebRDyit8cKwg5bUB66UNpZSZefwkJl3WngZ
 6z4fYWuJb/zExU0D56anYMe7awm1QlJjN6wzEf
X-Gm-Gg: ASbGncsK/GUhNYkz/oGrAdcqzBH+4NDP4EfcCY4ITN3pTulzx/6SjSdUfmo4pcDZNrD
 xXEzLmV5GLwpIURz32b+NuvAcoa87xgFsNXGK1n/efgK6Nx6CorZt4qK7RzyZukAR3I3UnIgbrl
 /8rXM4nD/p0z02m/q+coEdhTVLmvHUlEpT/LcKU9fUm7CFOquy7G5dlFfzKKmrrUE60QlVMR5Wv
 KTLSOdiMEaNut1LBq4AsETeAh/dG/zX+oH8E6+tp86ijpT98vDoJsObnuvn
X-Received: by 2002:a05:6000:400f:b0:385:fa2e:a33e with SMTP id
 ffacd0b85a97d-388e4d8e54cmr6067061f8f.43.1734597229621; 
 Thu, 19 Dec 2024 00:33:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiEagldsvaItOrlaSC7E7lbqh9Up6o720Ukb43YCjE88wzTVoXQ+ZEPO35x7L8ncb62Tw51w==
X-Received: by 2002:a05:6000:400f:b0:385:fa2e:a33e with SMTP id
 ffacd0b85a97d-388e4d8e54cmr6067027f8f.43.1734597229229; 
 Thu, 19 Dec 2024 00:33:49 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847263sm987383f8f.50.2024.12.19.00.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 37/41] rust: pl011: always use reset() method on registers
Date: Thu, 19 Dec 2024 09:32:24 +0100
Message-ID: <20241219083228.363430-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

For CR, the ugly-ish "0.into()" idiom is already hidden within the
reset method.  Do not repeat it.

For FR, standardize on reset() being equivalent to "*self = Self::default()"
and let reset_fifo toggle only the bits that are related to FIFOs.  This
commit also reproduces C commit 02b1f7f6192 ("hw/char/pl011: Split RX/TX
path of pl011_reset_fifo()", 2024-09-13).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 23 ++++++++++++++++-------
 rust/hw/char/pl011/src/lib.rs    | 13 +++++--------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 960ee38ed69..f2ee8763d8f 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -262,7 +262,7 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.update();
             }
             Ok(RSR) => {
-                self.receive_status_error_clear = 0.into();
+                self.receive_status_error_clear.reset();
             }
             Ok(FR) => {
                 // flag writes are ignored
@@ -283,7 +283,8 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 if bool::from(self.line_control.fifos_enabled())
                     ^ bool::from(new_val.fifos_enabled())
                 {
-                    self.reset_fifo();
+                    self.reset_rx_fifo();
+                    self.reset_tx_fifo();
                 }
                 if self.line_control.send_break() ^ new_val.send_break() {
                     let mut break_enable: c_int = new_val.send_break().into();
@@ -442,16 +443,24 @@ pub fn reset(&mut self) {
         self.read_trigger = 1;
         self.ifl = 0x12;
         self.control.reset();
-        self.flags = 0.into();
-        self.reset_fifo();
+        self.flags.reset();
+        self.reset_rx_fifo();
+        self.reset_tx_fifo();
     }
 
-    pub fn reset_fifo(&mut self) {
+    pub fn reset_rx_fifo(&mut self) {
         self.read_count = 0;
         self.read_pos = 0;
 
-        /* Reset FIFO flags */
-        self.flags.reset();
+        // Reset FIFO flags
+        self.flags.set_receive_fifo_full(false);
+        self.flags.set_receive_fifo_empty(true);
+    }
+
+    pub fn reset_tx_fifo(&mut self) {
+        // Reset FIFO flags
+        self.flags.set_transmit_fifo_full(false);
+        self.flags.set_transmit_fifo_empty(true);
     }
 
     pub fn can_receive(&self) -> bool {
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index d5089f78854..e3eacb0e6b9 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -230,7 +230,7 @@ pub struct ReceiveStatusErrorClear {
     impl ReceiveStatusErrorClear {
         pub fn reset(&mut self) {
             // All the bits are cleared to 0 on reset.
-            *self = 0.into();
+            *self = Self::default();
         }
     }
 
@@ -297,19 +297,16 @@ pub struct Flags {
 
     impl Flags {
         pub fn reset(&mut self) {
-            // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE are 1
-            self.set_receive_fifo_full(false);
-            self.set_transmit_fifo_full(false);
-            self.set_busy(false);
-            self.set_receive_fifo_empty(true);
-            self.set_transmit_fifo_empty(true);
+            *self = Self::default();
         }
     }
 
     impl Default for Flags {
         fn default() -> Self {
             let mut ret: Self = 0.into();
-            ret.reset();
+            // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE are 1
+            ret.set_receive_fifo_empty(true);
+            ret.set_transmit_fifo_empty(true);
             ret
         }
     }
-- 
2.47.1


