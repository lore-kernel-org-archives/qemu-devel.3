Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE44E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFX-0001nu-EL; Thu, 19 Dec 2024 11:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFPW-0006Hr-3S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:13:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFPU-0008LE-En
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBnoMQiocVwxb195C5dPLUMqfWHTI2r8yktVChDs01k=;
 b=FTEpGmb4Is5jezR053KsUydt2hDTuPl8SNY4HR7rslIVX30g1lLnnU5V1p1GAu4w5bdUmC
 O8PWdhYx7Aa4VoC9izFW9yty5sGDFA1katkq6TRvvPy2WvNkg1fOcPytG4Ehc+RODQhtdX
 UxvUw4tGTld48v6aqlhVezMOeNakuko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-3NbD55LEPbaRRZu_03e4rw-1; Thu, 19 Dec 2024 07:12:35 -0500
X-MC-Unique: 3NbD55LEPbaRRZu_03e4rw-1
X-Mimecast-MFC-AGG-ID: 3NbD55LEPbaRRZu_03e4rw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385d52591d6so397470f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610353; x=1735215153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBnoMQiocVwxb195C5dPLUMqfWHTI2r8yktVChDs01k=;
 b=Gwb6VoNve8i05fhclpsg60Rts1yFbXWG8qCId4gOyy6cEgr+J1/NIDwlvTo3VaPgjL
 p/vYxcGaWL/wxazzKE1HoPLYl95hO7qu+1Mh2jBJcQJaw9boq5QUf/l93YtZyTsSYrn7
 qx+mLB9x+8tasJ22iPOANXUFtaOVmkSTIobujByRRP6js830Yp/i1/UWq/YAteMh68T1
 39QrgDZy4J1ibVvd2RrCd+eRDNgelmWG4p/cwZyPIJSD/YZ4W5YoLB6rQK5hbjRHPUGY
 cbfgweALbQay3E2TdKWaFC9Ws7KrkdUliFSa1xhQcuxOCtAEelMK/j3W4N1ftaJsWMEB
 ulUw==
X-Gm-Message-State: AOJu0YxnJ4pS8MaCGCiEMHtHQPvDxIoYidTI8HzdFTc43bRUUPIlp24g
 57jnTMFIGIulxGvVfjYjQitCsgrDbZZTAcnhTDrrxjsbGpEEFycUHnPugDtDJs3y9dPqFDoYL37
 QrItKXSrqoOOp3LwW8RGYdjHI+shpe+7TQMgFNFXwDTSAP6CAFXuqZw6eHLOii6AV7QdKAYyh3z
 ElcwM20fuXInNuWmzMG8+cwpniFGPLxgaE0MKe
X-Gm-Gg: ASbGncvvKMkaT2auovBv6U0MO+tFZUAWzBdASKt6DWXeKl4BSQ2/wG99aL6majXT5j9
 tuUGava3d19MVCvBSEaATPuJNKAee21bDLZWa5dW6OjMjz43v2FXnJ4a3okDstVcOQlQmingqxE
 Wyn35KWMoTwbWTaE1JJmw+DNzu5dpp7qYySM1mU5uGEDid40/sUkb+EUZA/bMBqtT+PJZ1c3Kr0
 H1q+WpcbvkqrbhL7vM4ISCZVaZo+zoYPD6mDqY9fL//262eZhN72kbvAafQ
X-Received: by 2002:a5d:6485:0:b0:386:3711:ffa9 with SMTP id
 ffacd0b85a97d-38a1a233376mr2455803f8f.16.1734610352716; 
 Thu, 19 Dec 2024 04:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn/X+VXeH/+Y5BjvHR60r7gdL4D1WUB5BT0zlWbiCN6CfHyBEuRhAAwI+7HuyMC6fkQ/mttg==
X-Received: by 2002:a5d:6485:0:b0:386:3711:ffa9 with SMTP id
 ffacd0b85a97d-38a1a233376mr2455779f8f.16.1734610352291; 
 Thu, 19 Dec 2024 04:12:32 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436604e9c2csm18193875e9.43.2024.12.19.04.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 07/10] rust: pl011: only leave embedded object initialization
 in instance_init
Date: Thu, 19 Dec 2024 13:12:13 +0100
Message-ID: <20241219121216.416905-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Leave IRQ and MMIO initialization to instance_post_init.  In Rust the
two callbacks are more distinct, because only instance_post_init has a
fully initialized object available.

While at it, add a wrapper for sysbus_init_mmio so that accesses to
the SysBusDevice correctly use shared references.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 18 ++++++++++--------
 rust/qemu-api/src/sysbus.rs      | 12 ++++++++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 215f94a6e4a..72a4cea042c 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -145,6 +145,7 @@ impl ObjectImpl for PL011State {
     type ParentType = SysBusDevice;
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
+    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = Some(Self::post_init);
 }
 
 impl DeviceImpl for PL011State {
@@ -183,14 +184,6 @@ unsafe fn init(&mut self) {
                 Self::TYPE_NAME.as_ptr(),
                 0x1000,
             );
-
-            let sbd: &mut SysBusDevice = self.upcast_mut();
-            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
-        }
-
-        for irq in self.interrupts.iter() {
-            let sbd: &SysBusDevice = self.upcast();
-            sbd.init_irq(irq);
         }
 
         // SAFETY:
@@ -213,6 +206,15 @@ unsafe fn init(&mut self) {
         }
     }
 
+    fn post_init(&mut self) {
+        let sbd: &SysBusDevice = self.upcast();
+
+        sbd.init_mmio(&self.iomem);
+        for irq in self.interrupts.iter() {
+            sbd.init_irq(irq);
+        }
+    }
+
     pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
         use RegisterOffset::*;
 
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 8193734bde4..b96eaaf25f2 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -38,6 +38,18 @@ const fn as_mut_ptr(&self) -> *mut SysBusDevice {
         addr_of!(*self) as *mut _
     }
 
+    /// Expose a memory region to the board so that it can give it an address
+    /// in guest memory.  Note that the ordering of calls to `init_mmio` is
+    /// important, since whoever creates the sysbus device will refer to the
+    /// region with a number that corresponds to the order of calls to
+    /// `init_mmio`.
+    pub fn init_mmio(&self, iomem: &bindings::MemoryRegion) {
+        assert!(bql_locked());
+        unsafe {
+            bindings::sysbus_init_mmio(self.as_mut_ptr(), addr_of!(*iomem) as *mut _);
+        }
+    }
+
     /// Expose an interrupt source outside the device as a qdev GPIO output.
     /// Note that the ordering of calls to `init_irq` is important, since
     /// whoever creates the sysbus device will refer to the interrupts with
-- 
2.47.1


