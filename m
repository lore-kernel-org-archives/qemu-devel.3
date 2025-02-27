Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C2AC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnenG-0005gH-1O; Thu, 27 Feb 2025 09:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemk-0003vR-Ap
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemg-000480-8D
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4VqwNYiNiuTUzYwk2y50HzhW9i7JscSTGolkyuQe+I=;
 b=aJ7huADxQq09xuF1S4BUyntKPAjdmwiqSUm2A2nZroNoVGvlS0ypp0PFuEhJXO48EIJnap
 hMZM39q7Mpju8hEcda8/oOmS0kIxHQGEmp9hlloQZKiyUfD7Be5bIfnvAMFh5wbZECJTXE
 AnoTy4TIcmIpTV6JfMjnvIqmy0zEPtY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-sX2gfNIvMEi_l_GnAFCv5g-1; Thu, 27 Feb 2025 09:22:40 -0500
X-MC-Unique: sX2gfNIvMEi_l_GnAFCv5g-1
X-Mimecast-MFC-AGG-ID: sX2gfNIvMEi_l_GnAFCv5g_1740666159
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so89225966b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666158; x=1741270958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4VqwNYiNiuTUzYwk2y50HzhW9i7JscSTGolkyuQe+I=;
 b=AAcQaA4MW2NKrBrClk/VSrQ4wuAu8x1ZnGS7j2JG/ijC9qKVRvrxqfTs62B1rfNhjw
 xoj+DLDCVPAV4uK83pWcK4FfAm3oDYUxViuPoMcwkIBQgFbz5Y97cH2VGdv0obOVmrIa
 cWBp+2QM7+WGHDSun2di5imaNd1C62nCbwl13+2az3cgMSyPzR05dSYG4TuK4fwsAV1y
 T26F0UuTiPrEXIGazflDTgbaoys+f3qIytS4pzDvCGG9ymolnOKYEa0gZtnQ9rmSpuiT
 KVVnI+PTOUFGCqP3KuQ4RETFFGq4olBuZaV6fbsdKPc6e71g2gxpGEcjCTPFiWpGcrQF
 +hzw==
X-Gm-Message-State: AOJu0Yw/86QjnbrR4f+MEem6jxLiGyq/BwMVKx6HCYr/EyA2KcaY3eX1
 FQpA6WkwhvRkizHfTjLb1b65Yslu/18DEoGL8GNnN1wK3XnHbrT3PrryNjzOe0Eja/HFcxEITqv
 MlMQOYD0im0dhtdfrH9irn0XyW8K/CBepvKWnDhIBn2u6PmN2y2YPk/zvVGgLps2a3rYRvvYk9M
 BaF3Ni4VkQ6QeoX93hueDcoFNpwkgrOpLfFSZPgJ4=
X-Gm-Gg: ASbGncv0VQIRcwaXYUkEU0VBu5BHmxISNsehzRFol6jMVrtbKfdLKYUYcBth173UFKL
 7tcjhgpFtu82Yh5ZKdifSXjMMIT3ZC3dEHk9ZbD/G8Ey6qDjzZLORPL0yo9zM8jvPZ6u0S20pTr
 vF8R1ycDcmlc1ejZsdAt5MrrB3OqbQsi7kEh6qz3tjdTOo8wSpnlqxukmx4m/W4lsMdPuYlMIac
 vDUkL74CF2CVCL8MRrMJ++T7iM/0kA04t6grStJy2hfCzWoDBMURkq+ACm7t++EZqIlDNK18+rF
 tYURajnHZB+ZABCiC3jn
X-Received: by 2002:a17:906:3152:b0:ab7:d87f:665b with SMTP id
 a640c23a62f3a-abc0de4a2cemr2554979466b.48.1740666158163; 
 Thu, 27 Feb 2025 06:22:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvqN1jeEHL8v0Gq8g/eqXy/BrDmOdict2Vquc+f2bkWu2Ri45v5VoKyEwGFyHlGKflr5U15w==
X-Received: by 2002:a17:906:3152:b0:ab7:d87f:665b with SMTP id
 a640c23a62f3a-abc0de4a2cemr2554976466b.48.1740666157672; 
 Thu, 27 Feb 2025 06:22:37 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7bbfe2sm130718966b.171.2025.02.27.06.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 08/12] rust: hpet: do not access fields of SysBusDevice
Date: Thu, 27 Feb 2025 15:22:15 +0100
Message-ID: <20250227142219.812270-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Fields of SysBusDevice must only be accessed with the BQL taken.  Add
a wrapper that verifies that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/hpet.rs |  4 +---
 rust/qemu-api/src/sysbus.rs    | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index ce4b289d0c8..a440c9f4cb9 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -724,8 +724,6 @@ fn realize(&self) {
     }
 
     fn reset_hold(&self, _type: ResetType) {
-        let sbd = self.upcast::<SysBusDevice>();
-
         for timer in self.timers.iter().take(self.num_timers.get()) {
             timer.borrow_mut().reset();
         }
@@ -738,7 +736,7 @@ fn reset_hold(&self, _type: ResetType) {
         HPETFwConfig::update_hpet_cfg(
             self.hpet_id.get(),
             self.capability.get() as u32,
-            sbd.mmio[0].addr,
+            self.mmio_addr(0).unwrap(),
         );
 
         // to document that the RTC lowers its output on reset as well
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 48803a655f9..0790576d446 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -64,6 +64,18 @@ fn init_irq(&self, irq: &InterruptSource) {
         }
     }
 
+    // TODO: do we want a type like GuestAddress here?
+    fn mmio_addr(&self, id: u32) -> Option<u64> {
+        assert!(bql_locked());
+        let sbd = self.upcast();
+        let id: usize = id.try_into().unwrap();
+        if sbd.mmio[id].memory.is_null() {
+            None
+        } else {
+            Some(sbd.mmio[id].addr)
+        }
+    }
+
     // TODO: do we want a type like GuestAddress here?
     fn mmio_map(&self, id: u32, addr: u64) {
         assert!(bql_locked());
-- 
2.48.1


