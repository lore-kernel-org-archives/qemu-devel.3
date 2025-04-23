Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93DAC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wd7-0008Vc-9w; Wed, 23 Apr 2025 05:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wcd-0006Jd-EK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7Wcb-0008RP-C9
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+glD85tLMU4Zh0YpUWT/RyU8gRb7iUdvIPG8JxMkRCI=;
 b=J2uTnU8W1/Y3TpU+vOcQE9MgrbZFg2ZE0bYRC3fTYizB9LEm/if28qRj9MijaPMD3zRsQT
 W624pdpVpxvM0oL9KRjPjqy4lF35NTGw+OPGoQOxIkqWwGXaDIkoR3Br5diDOWwmbEn1nM
 fVMn7RvCp8c0TaVUihPEupCWZme7+2g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-R7yGQqZLNSiSNPQbIegP1Q-1; Wed, 23 Apr 2025 05:42:22 -0400
X-MC-Unique: R7yGQqZLNSiSNPQbIegP1Q-1
X-Mimecast-MFC-AGG-ID: R7yGQqZLNSiSNPQbIegP1Q_1745401342
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac6b047c0dcso461335666b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401341; x=1746006141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+glD85tLMU4Zh0YpUWT/RyU8gRb7iUdvIPG8JxMkRCI=;
 b=iJ+qQ3FL7oYwM0hk0vU78NXyQL/Oqt0emjO1L6Af44YCQHyHG8Fr/GVWR1FM9lwkeV
 jVM4kCtSLzMMmLqz74IL6NZQ0A2niRkF+1181Del8VkeijWgrQP3R5vbMOCuJGKPc/CK
 BTAoSiNOye0Cj00He4CkrvIQ3aXy1q19TzliEjJIkwVRS/aWg/8K8RhfqGLh/BBY7MY8
 6TalmreCgB44H163+9GkZXi0J+wJzb1A6fxp489XLBrGxpC9AkOGmKL5hFpLFY32U/eF
 x8kalBxACkuOYqd5XNwPTazZbFglYsjvEmHe7hP51wrOUB8Z6W6hg0y3oe7LYLRV2OpJ
 Ur2g==
X-Gm-Message-State: AOJu0Yyg256jsl5F8kNz4dCkc/B9K7QIJ1Bf5OjCgIKmKQ9S01t7nwNd
 fY8fTglHtbtU1rsyJXSQN2oPd09aRGOdSWAT1Lr9/QLmytq7Pb7KqD3Ybl/fAI98AGf/Hi8wimi
 MshRO/htUjORFT8bpl0F1JVEiGwkSr7QlyVJTqC/Vdd0jIZHUQoTDuPxpQWVsxXkDz4UfHfmiVZ
 RYzkBVa1Odz434I0E2S7Th42h0Vb73tMV0NifM
X-Gm-Gg: ASbGncshXohVZ+q0rSCyJkuEiDqlk6hz63Mhsk5/JKF5h3c+Eb487Ow2yqxqkJO9vmP
 GV/vlDdTQVr61iRP6zFkvzYQX3dFzOkWs0DszobE+Q8pOvtvmkqqNnGvKo8Pt7lxoJGz2RyPG/6
 F71fxy/1J6ViexC/GRN6iFvM0lYrQD8IjnLhu6AaoI5nVzJYGB0TVq8dkHypP0FmhzHpO0B0B4A
 bEpm6hpkf9CQUvsviPl1sFgBi+8QqxSN71w3l1vaGjwsHXNtsvZ6J7/GWQ/9kP54sRjRMjYkntk
 28eHndILHRc952GM
X-Received: by 2002:a05:6402:35d0:b0:5ec:9e6e:c48f with SMTP id
 4fb4d7f45d1cf-5f62860dc21mr13830249a12.29.1745401340805; 
 Wed, 23 Apr 2025 02:42:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm0S3AUronm7c5jd0bqMm3chWH327AmKAhciuk4oM1SmeCfpU9Ws9MgTP2WsIeXtim8Ytn7Q==
X-Received: by 2002:a05:6402:35d0:b0:5ec:9e6e:c48f with SMTP id
 4fb4d7f45d1cf-5f62860dc21mr13830233a12.29.1745401340406; 
 Wed, 23 Apr 2025 02:42:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f6255778b3sm7199046a12.19.2025.04.23.02.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Subject: [PULL 33/34] rust/hw/char/pl011: Extract extract DR read logic into
 separate function
Date: Wed, 23 Apr 2025 11:41:03 +0200
Message-ID: <20250423094105.40692-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

From: Rakesh Jeyasingh <rakeshjb010@gmail.com>

- Split `read()` DR case into `read_data_register()`

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Link: https://lore.kernel.org/r/20250407181327.171563-2-rakeshjb010@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bf88e0b00a0..87153cdae13 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -190,25 +190,7 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
 
         let mut update = false;
         let result = match offset {
-            DR => {
-                self.flags.set_receive_fifo_full(false);
-                let c = self.read_fifo[self.read_pos];
-                if self.read_count > 0 {
-                    self.read_count -= 1;
-                    self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
-                }
-                if self.read_count == 0 {
-                    self.flags.set_receive_fifo_empty(true);
-                }
-                if self.read_count + 1 == self.read_trigger {
-                    self.int_level &= !Interrupt::RX.0;
-                }
-                // Update error bits.
-                self.receive_status_error_clear.set_from_data(c);
-                // Must call qemu_chr_fe_accept_input
-                update = true;
-                u32::from(c)
-            }
+            DR => self.read_data_register(&mut update),
             RSR => u32::from(self.receive_status_error_clear),
             FR => u32::from(self.flags),
             FBRD => self.fbrd,
@@ -306,6 +288,25 @@ pub(self) fn write(
         false
     }
 
+    fn read_data_register(&mut self, update: &mut bool) -> u32 {
+        self.flags.set_receive_fifo_full(false);
+        let c = self.read_fifo[self.read_pos];
+
+        if self.read_count > 0 {
+            self.read_count -= 1;
+            self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
+        }
+        if self.read_count == 0 {
+            self.flags.set_receive_fifo_empty(true);
+        }
+        if self.read_count + 1 == self.read_trigger {
+            self.int_level &= !Interrupt::RX.0;
+        }
+        self.receive_status_error_clear.set_from_data(c);
+        *update = true;
+        u32::from(c)
+    }
+
     #[inline]
     #[must_use]
     fn loopback_tx(&mut self, value: registers::Data) -> bool {
-- 
2.49.0


