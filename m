Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F178C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WdR-0001CP-Ss; Wed, 23 Apr 2025 05:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcW-00065l-OT
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcV-0008Qg-1l
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TQ80bs6fUiw4Xf8E7Rq7/mDk9FxrtXt7TWMkZhTJWIA=;
 b=N/GwWLjKWQPS+n0GVrKyhGat1jY3mYj4HFzHS74TayVF63fe7HfrHvlAS7fCf934xXLu7+
 tyayDKn/4E7GRgfXMnIVLrrRao1vUdGdLwDoyLWEAD8+wm0KGA7tvXUp4U5vV85aAAw2p2
 0cO6litDRlKUflYF6dMNetarV/kvZ7Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-4rJntOMsOk66no1QPQo8pg-1; Wed, 23 Apr 2025 05:42:16 -0400
X-MC-Unique: 4rJntOMsOk66no1QPQo8pg-1
X-Mimecast-MFC-AGG-ID: 4rJntOMsOk66no1QPQo8pg_1745401335
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb8d1231ffso227099466b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401334; x=1746006134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQ80bs6fUiw4Xf8E7Rq7/mDk9FxrtXt7TWMkZhTJWIA=;
 b=tyCRP4RDYjvtARKiC70RGLSj+GSabvtoaouydbs4hogQUOTj6SVbFs+NIMESf4VD7/
 eQm4q/IKBFoiHD4iHVnflOvZjZFcX7zY8CBdpX+ejS5zWOsgwgUcR4R+iFrrW0xwBb36
 kWuvonvpv5lJD3fCB0fUMR5Cn+YH2zv899ta8/Zj+z3suV8m+cFYazrmAWB3F0UAh+V4
 r1XII8xduIKc8uNIByGq9Nw91Ok1XNfer4MTJTpWYkmEjuC4FtFbp5k0/ROTNJX4rz4S
 UdOVF1Y7LG1t/BfQ2c4hFqXeR9s0l4hR9cuCPmmen7ludUvvRngPaM9t7q0yZx+CaAw+
 b46g==
X-Gm-Message-State: AOJu0Yw0kYaznWVwSPZb163jM+WiwlakzzVXpi97LUpyDyR8emyoV/m4
 rzDpfWezm54tnNZ23boB/HGNiLDh1iBEYJ3+rzbugvVFGh6Es0GXMh66zpeuEgLsRkZtCOVvQir
 IL/m93ob3pziblj1qwB5GKF79QSCS99E8NGnWOYk04LHYXWEHGdIxIOIjdPn0m5oBIlO4spzvzg
 yCrn3GXXKJaHyMnef/5jxY6ZSlDs+6vs0/zDOn
X-Gm-Gg: ASbGncsy0SKAA43q3bjyD98k4rU/1/0LikYT6LJNQJ08CUCjgNFTtQHILZJAbgH5bUU
 ca4tQO6CJy7ATT8HSiQjOU3lR69ZA9EMAGdi+OreOnmGfS05sPKRK2pWC6lo2HyQfT2d4QiB9Kb
 K7TmEdwlBME4kDkM67okwPMRqhulV91098ir6Pl5t4uxCQhMqqc3Pct+toha6a3XVhJ4EJgLnh0
 WVw6hKn5hkhk5C2dd3tiJhBL8/JBA+P4IkvYJP5rEyjPhna3dfhgAMwJf8h1XpkvPDnllYRSOWE
 Jwsjc3LvqAWB5VqJ
X-Received: by 2002:a17:907:9712:b0:aca:a687:a409 with SMTP id
 a640c23a62f3a-acb74b0593fmr1482537866b.17.1745401334652; 
 Wed, 23 Apr 2025 02:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnKtqenSL8MaGycmXWEFRwQDLU/tWzCJETCZ/nF9y7XA30LVgzeZ2IV3n+GKuCPs2iNH+2sQ==
X-Received: by 2002:a17:907:9712:b0:aca:a687:a409 with SMTP id
 a640c23a62f3a-acb74b0593fmr1482536166b.17.1745401334181; 
 Wed, 23 Apr 2025 02:42:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62594985bsm7231725a12.74.2025.04.23.02.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 30/34] rust/hpet: convert HPETTimer index to u8 type
Date: Wed, 23 Apr 2025 11:41:00 +0200
Message-ID: <20250423094105.40692-31-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

The C version of HPET uses the uint8_t type for timer index ("tn"), and
usize type in Rust version will break migration between the C and Rust
versions.

So convert HPETTimer index' type to u8 (consistent with the C version of
HPET) to make it friendly for vmstate support.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 1afa891362f..dc8a23f29d9 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -184,7 +184,7 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
 pub struct HPETTimer {
     /// timer N index within the timer block (`HPETState`)
     #[doc(alias = "tn")]
-    index: usize,
+    index: u8,
     qemu_timer: Timer,
     /// timer block abstraction containing this timer
     state: NonNull<HPETState>,
@@ -210,7 +210,7 @@ pub struct HPETTimer {
 }
 
 impl HPETTimer {
-    fn init(&mut self, index: usize, state: &HPETState) {
+    fn init(&mut self, index: u8, state: &HPETState) {
         *self = HPETTimer {
             index,
             // SAFETY: the HPETTimer will only be used after the timer
@@ -235,7 +235,7 @@ fn init(&mut self, index: usize, state: &HPETState) {
             Timer::NS,
             0,
             timer_handler,
-            &state.timers[self.index],
+            &state.timers[self.index as usize],
         )
     }
 
@@ -246,7 +246,7 @@ fn get_state(&self) -> &HPETState {
     }
 
     fn is_int_active(&self) -> bool {
-        self.get_state().is_timer_int_active(self.index)
+        self.get_state().is_timer_int_active(self.index.into())
     }
 
     const fn is_fsb_route_enabled(&self) -> bool {
@@ -611,7 +611,7 @@ fn handle_legacy_irq(&self, irq: u32, level: u32) {
 
     fn init_timer(&self) {
         for (index, timer) in self.timers.iter().enumerate() {
-            timer.borrow_mut().init(index, self);
+            timer.borrow_mut().init(index.try_into().unwrap(), self);
         }
     }
 
-- 
2.49.0


