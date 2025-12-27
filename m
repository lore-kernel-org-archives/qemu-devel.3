Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8643E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRb-0007Vu-Pl; Sat, 27 Dec 2025 04:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRM-0006vX-Ds
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRK-0003n2-QE
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIY+C6WBcDEaxjsneB4epVbDtpl9yBW5enqGVp+ga3s=;
 b=EZQQvtRQVz4Ec7bJI8JqD955Xp3wKN/lYO/4GrHiFURv7OjOczak9FXsB/hvr0tznTVfC7
 g5eNraEx3fkG9SJfWLk91aIxZVWwelf37Ic2y0rTSxSgCPwFBKuhRYxHCPFfK1IDvX/8Xl
 qYe9PSal6F/VqrI0ttVpikLSz/5K4T4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-ePmPP8tNMe6Eozv1bvZpmA-1; Sat, 27 Dec 2025 04:18:21 -0500
X-MC-Unique: ePmPP8tNMe6Eozv1bvZpmA-1
X-Mimecast-MFC-AGG-ID: ePmPP8tNMe6Eozv1bvZpmA_1766827100
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so74622825e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827099; x=1767431899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIY+C6WBcDEaxjsneB4epVbDtpl9yBW5enqGVp+ga3s=;
 b=NnWEZO78n34F822Ac2PRDf1q2tt5aCpvaORyjugODESv/7Bn2u+p7eIFtH7K7vow3Y
 dwfS7x5BSeAQlZAognJ3P1KAiZr2oPw9j3g+uxGcyo3zBPu1qxVvBo81x4jSRQ/bFP8T
 4YOcyRTxvQoRwFXYPaobM9oXKny6UiuhE2ddxP5kvsyu8WE6rt5VgHwh4V7ITzSDS8/5
 udrTkEMzmuGOqhB76bXz6W1PV3DXjYqc0mTLUgDiX+kY/gi9qLCOmh4z7JHOALvbQUIr
 wd1BD1XCEaFG5seuvCt7lpxYh9sBPJJR7fikGZkRwK4yRhODzRqzQs2l4NIEYjlKoJPm
 P7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827099; x=1767431899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SIY+C6WBcDEaxjsneB4epVbDtpl9yBW5enqGVp+ga3s=;
 b=GNjYz9ZSzqPafjl3GmBC6uWYs9pLswK87Snq/zt5jHuS6/Woh5gEGNUvEP3dzDmfOK
 C4RhQWzaTNVik6MEy5nQCzPlhUUhjaDVyjcyiownokFLoM8K4ZQ5beVOo1L3n/NqRUI3
 cf433BuMdcsWLtXf1qNkKNIhjORdoKm99BRCvJ8D5edOLveilpSnoonqkbIQFYVLwnpg
 J/6+ufitfyCPPh6T76aKju/u+IvFkSm7ljcemsis3Ur6gUowxbxvUIyrSVxkAzslDMZr
 F7xYErBkTMq98Bb3zRLXMy9rqd8MMr85Z2M93iHg+gZXUWTAlBmnb5mLmhmlH7+jNClO
 ywvA==
X-Gm-Message-State: AOJu0YxSTLBvsihscQraA7EtU/AagXJ8XAKA95v5lYzg3oo80sGuiT19
 AnL4Wmbn+T3QQV6nFb+2yD8bU46XlJ882hPnSK0LLNZiKx9p+RKeWaVxu2Zb6ZzQ16JF9UBjNkt
 N0JhFMjQRBPjGkV1Og8T7Gefb7mN6PSikw1BBkFaUQGtfutAkRblkSKAeSzSfn/rElcHfOaInQO
 EJPWSsRYxYIEL4jrpA4fA+00Q7b+Yw//4eIqkQPAnw
X-Gm-Gg: AY/fxX6GZe45qiZDmbzmLrItAluwWktEqoM5gibIUVUhpUdbYlLM741TNh0ogGlEHYn
 NuVLopPUcsuPtTq8AkRiS2AcAPBvkjuWVHth/tRVlCNI2C3wpuuNdMnVUZuYNydNzMOiiq8OAoA
 t8ldycpAPPDOa/0cI+pUSBaExP82Pv133cnr5iYBRQi8NOEuiWgf87idU6VrwwONWWRFyTQozGU
 vk2/3rawxrlM9G9zVlSjKDmeRtuCY+ATH/StT+a5x8W0Zmz/Ted82ssAsCVnFZFiZ2NqqVUTTnK
 5puuxBdcrE5vI4tG+raXlBaFauBDkoUrdcC+AoBWdL+uJF7yH8Yg/DLASJwC3VmqGRK0EsC4G1a
 jx8RP7029K5J/frBUcS7GXLWgs+vva7lDs8XGAGTnuwk20WPRTlHCwArmtErQ5ud4ODtYCegooa
 3ypDHTt6CYvDEossk=
X-Received: by 2002:a05:600c:5250:b0:479:3a86:dc1b with SMTP id
 5b1f17b1804b1-47d36243a0bmr140761465e9.37.1766827098885; 
 Sat, 27 Dec 2025 01:18:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHanS1ghInQAvwtDhSvYf6har0Q+vF093ZAOSRuiGuoI4W2lYsAuea+rJ1MYQvOuuOlvQiLPg==
X-Received: by 2002:a05:600c:5250:b0:479:3a86:dc1b with SMTP id
 5b1f17b1804b1-47d36243a0bmr140761265e9.37.1766827098479; 
 Sat, 27 Dec 2025 01:18:18 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d28a33adcsm130098485e9.18.2025.12.27.01.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 059/153] rust/hpet: Explicitly initialize complex fields in
 init()
Date: Sat, 27 Dec 2025 10:14:46 +0100
Message-ID: <20251227091622.20725-60-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Explicitly initialize more fields which are complex structures.

For simple types (bool/u32/usize), they can be omitted since C has
already initialized memory to all zeros and this is the valid
initialization for those simple types.

Previously such complex fields (InterruptSource/BqlCell/BqlRefCell) were
not explicitly initialized in init() and it's fine, because simply
setting all memory to zero aligns with their default initialization
behavior. However, this behavior is not robust. When adding new complex
struct or modifying the initial values of existing structs, this default
behavior can easily be broken.

Thus, do explicit initialization for HPET to become a good example.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-16-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index abbaebc405e..d622a6920a8 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -733,6 +733,18 @@ unsafe fn init(mut this: ParentInit<Self>) {
             HPET_REG_SPACE_LEN,
         );
 
+        // Only consider members with more complex structures. C has already
+        // initialized memory to all zeros - simple types (bool/u32/usize) can
+        // rely on this without explicit initialization.
+        uninit_field_mut!(*this, regs).write(Default::default());
+        uninit_field_mut!(*this, hpet_offset).write(Default::default());
+        // Set null_mut for now and post_init() will fill it.
+        uninit_field_mut!(*this, irqs).write(Default::default());
+        uninit_field_mut!(*this, rtc_irq_level).write(Default::default());
+        uninit_field_mut!(*this, pit_enabled).write(Default::default());
+        uninit_field_mut!(*this, num_timers_save).write(Default::default());
+        uninit_field_mut!(*this, hpet_id).write(Default::default());
+
         Self::init_timers(&mut this);
     }
 
-- 
2.52.0


