Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4EECEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKttk-0003Yt-9u; Mon, 17 Nov 2025 02:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtt9-0003Su-SN
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:43:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtt7-0005xG-Pd
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S14Zo44EQMwZqqZohNEqtSrNdlsFQNx9pJq4LX6ET20=;
 b=BRFsUSaBus5DOTjj2x4qLpypdbjbhcI2ePPFf0+gWLhLi5dVNYZSjhRNAQub4piSaVRXYT
 b14IFkbeqAoVR/QDp8SiEjp6SNd3jcDJNkG2R/VkIL1CD6ILdJ+kWBKksC+rIE7GNZvsAS
 utHt3lRx4xoHctJe8U3PB1Acxexomk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-FsDHj1t7PEC1xwQza2soFg-1; Mon, 17 Nov 2025 02:42:59 -0500
X-MC-Unique: FsDHj1t7PEC1xwQza2soFg-1
X-Mimecast-MFC-AGG-ID: FsDHj1t7PEC1xwQza2soFg_1763365379
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779c35a66bso10498625e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 23:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763365378; x=1763970178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S14Zo44EQMwZqqZohNEqtSrNdlsFQNx9pJq4LX6ET20=;
 b=mAdfQxxG1mlttrDKSk10FcRLFzoobx624adySQNJDIiggRUZFT8EVxa0muowOaUs6v
 QzxVbzcN2TF0Ytq/7zKY3GuIf37mBrObW5NHeIvYig2C63AlJ4hXYM/u4fvJdAXzDo0j
 f3Zp8D6/b7iArEq5pBmbjkUvR+CbRkuz1XCLiL5EerBCfe/h3HlwEuBz8lO/V392qcKw
 WVKt0K6NH/9huShmUGX+jhIjaQqTEFPVrQqQ/UXF6ZbtnPn3GYNo26MlqkLAqJZUEqKI
 5Ht7EyzBBiby7uPnBLVPkxN9IYZoaL2SVvXDHHnQHgW0XLcInNr9qWEV00KSaOry82LF
 2NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365378; x=1763970178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S14Zo44EQMwZqqZohNEqtSrNdlsFQNx9pJq4LX6ET20=;
 b=EDnBIf8HZ2JCn/+19oCktE3HXH/SWu0ms1O9M4Bx2ycjJm1bk75nwEX0qpiT80piTb
 TzzGFI+ihVdpREh+EQIolT22qRMhSas0Y6BFK+Gy/DtG+bhCrzjhATWJT6TAQRAU2swL
 qTkEzHQMkPl2Tp/y4dtogxwb/k3gj01fBNAWv/t600CNiDktstf91nj3HZhsjYRTjr2G
 ni4bAbLqhryqQEIkI3ZiPsDiSI4ENhD3jlf5wk+hUJLzCcunDA8BpRFjsAEi23SosLHr
 uwacUv2JmOsdhzGbJBexg7jICHAbXmwHy/9AOeN9ahD4Xt4S69OZynDDKP8W6rxdMzmR
 XFZw==
X-Gm-Message-State: AOJu0YybfKHnU2Xye4K9hOwFyoyBhrwWdp3JXzrYOIZdP7/5TwOwCb2B
 acfQY5DexE5XTvhnlzL8sPkNn0Luy3H+uv3dOsOoZJF2FCHPxGeCTuz8mzy8lJZBITcZBYlDWAI
 cMrty8JlC6YdoO1pUmjhc7N/ha93liDRm7So79jBvzPKjO4EmGHMwqNq/TDT3EhKSQdQBPohKkb
 YGLE1WHCh/e1Mdqnmzh2JIl6M5kczpyjQr8u5AMdV5
X-Gm-Gg: ASbGncvx3C19HguPDBjzvhjuKvPCH4QyzwqRRN9ehQbqmU/e+BU+EfEZ9e0hWU0LP+9
 7ninvNGu+B7w37OroTt690PYDHJvEnAX1Jah7gPeq7UnGpwGGAZ8EphsPhTntGU46ZBWubaKq2/
 dnkl9q562oDj2kImolb6X2JT+f4xzAGQy6eGitQnoLckwso6wtnUs7nxkk0G89xjSJXU7xnv2vt
 ZwtT3tALwcV35NbOLOLrMCu9onjVCZ1m5/GxRBaImiEGralZnoQQlTcEvV/E0be/sbGyYeADdPj
 KERcXd0o7fOVJ/HTnTro3YAW7uvf2Z82ZMrNJfMvNKrCaWopeMahQnl0Bd/OXUGADfAKcISG2kY
 aAg+ID8SiuEmsDfgVh07J4dHIWZhxFF3c1tNNw4egCSJo6Y2GrcyGwFoynA68RvAu8V/c6GZSbt
 sBYl0R
X-Received: by 2002:a05:6000:1849:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-42b59385bcemr10641346f8f.33.1763365377780; 
 Sun, 16 Nov 2025 23:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE38zZInzdapEkJdUv3e6VVXFW01Gnj8qybY3ivmSyNdEyYireH9aeebVHim+VB9yoQdUAvxA==
X-Received: by 2002:a05:6000:1849:b0:3e7:45c7:828e with SMTP id
 ffacd0b85a97d-42b59385bcemr10641325f8f.33.1763365377306; 
 Sun, 16 Nov 2025 23:42:57 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85cc0sm25527950f8f.17.2025.11.16.23.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 23:42:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 7/8] system: add prelude
Date: Mon, 17 Nov 2025 08:42:37 +0100
Message-ID: <20251117074239.190424-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117074239.190424-1-pbonzini@redhat.com>
References: <20251117074239.190424-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 rust/hw/timer/hpet/src/device.rs | 5 +++--
 rust/system/meson.build          | 1 +
 rust/system/src/lib.rs           | 5 +++++
 rust/system/src/prelude.rs       | 8 ++++++++
 5 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 rust/system/src/prelude.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index be1bdf5ab12..0b1bb2d5a3b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,7 +10,7 @@
 use hwcore::{prelude::*, ClockEvent, IRQState};
 use migration::{self, prelude::*};
 use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
-use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
+use system::prelude::*;
 use util::prelude::*;
 
 use crate::registers::{self, Interrupt, RegisterOffset};
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index b7153a46e31..c5cdb87b073 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -16,8 +16,9 @@
 use migration::{self, prelude::*};
 use qom::{prelude::*, ObjectImpl, ParentField, ParentInit};
 use system::{
-    bindings::{address_space_memory, address_space_stl_le, hwaddr},
-    MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
+    bindings::{address_space_memory, address_space_stl_le},
+    MEMTXATTRS_UNSPECIFIED,
+    prelude::*,
 };
 use util::prelude::*;
 
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 73d61991146..6624fa6cee5 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -30,6 +30,7 @@ _system_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/memory.rs',
+      'src/prelude.rs',
     ],
     {'.': _system_bindings_inc_rs}
   ),
diff --git a/rust/system/src/lib.rs b/rust/system/src/lib.rs
index aafe9a866c9..5fb83b65d8d 100644
--- a/rust/system/src/lib.rs
+++ b/rust/system/src/lib.rs
@@ -4,3 +4,8 @@
 
 mod memory;
 pub use memory::*;
+
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
diff --git a/rust/system/src/prelude.rs b/rust/system/src/prelude.rs
new file mode 100644
index 00000000000..2d98524c36e
--- /dev/null
+++ b/rust/system/src/prelude.rs
@@ -0,0 +1,8 @@
+//! Essential types and traits intended for blanket imports.
+
+// Core memory types
+pub use crate::memory::hwaddr;
+pub use crate::memory::MemoryRegion;
+pub use crate::memory::MemoryRegionOps;
+pub use crate::memory::MemoryRegionOpsBuilder;
+pub use crate::memory::MemTxAttrs;
-- 
2.51.1


