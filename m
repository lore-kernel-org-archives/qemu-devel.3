Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F43CE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQq-0005Lh-18; Sat, 27 Dec 2025 04:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQo-0005KE-UY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQn-0003JC-Ak
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9Ri2pVpELCUzvf62fElrJ9WA+/Vh+qWfkWU/RNk9CM=;
 b=czcmZneBHulT/KxMxs5DxvLmowChPpQT6D4AYNKbWluV5ZuUCA7TfFyuuYo7kLId3uC1E1
 5yVe7RrYhQFtYzzypM5t9NQTKod1h0QmvkmhHe0p4h49ezAdYmi2C3rDMDsmWA+dtEdcfp
 ZWvOICrfT0jpInOE4LmzJQ4vVc5FJ6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-J3QTCiD-MVaqD8Gfn4-riA-1; Sat, 27 Dec 2025 04:17:47 -0500
X-MC-Unique: J3QTCiD-MVaqD8Gfn4-riA-1
X-Mimecast-MFC-AGG-ID: J3QTCiD-MVaqD8Gfn4-riA_1766827066
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47775585257so54467015e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827065; x=1767431865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w9Ri2pVpELCUzvf62fElrJ9WA+/Vh+qWfkWU/RNk9CM=;
 b=EmbWHpWsRT7acOeKk+jO6sdyrjua8z/zUQjalMh0mglyCwFCpWU3gQr28FirvlEY25
 ZvQnVg0BEF0RJc+5jMF1aLXMOfZkyH0iA5U231QSLPa98uByGVs7Tv7ywYPSDEr2HhHn
 LuJoEWi8Sex5zrKhp0IRh8GNSPEmqieBbtc4zTTeOj17fGZsyad+F+oXXDoHUnHCQa/x
 Pai1z964acx5fLxx9Wi5SuCxBGA8IU7fOahtxTVpV9sLkcwz66rZmc06QeZ1MBv6uUrs
 LSftIl50z+2yE93OBEq6dIfn2nfLljibJtt6h8u2yMubMGQP46wVaak9ewe6O+w0VRYW
 n0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827065; x=1767431865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w9Ri2pVpELCUzvf62fElrJ9WA+/Vh+qWfkWU/RNk9CM=;
 b=U/KNjb23gr73EI8r19C+ODLD6D638hOJavcL3GwXLEjWkqRc7l8YJDDKBOcRs2zDEs
 bEyL4RvAEk7vmsbwXSATOjpiLkdZUVQ6z6sPPOCKICB5Pluvs/4tp9y9o1Qtssj2405D
 INd7Qbkc291SFPOd+kja2QePzyg1PBDgn5Fs3cfps+znu6aBRVTtgO6NFnnF6/SDOgBi
 XD9q6MdYn1UML2ipR8qql3Y1j/LLVQRPfTXRMksrKTsFx7NSnfhTC20aEZF+HDwSnBg/
 zxIfRkemaog6y6aBy/NEoIx1y9Zf6JWqJuusrGDPORKsA9+IXAzUtiWHc5XlqttD1W3P
 KtMw==
X-Gm-Message-State: AOJu0YwucPs+VeQFQYkuqh/KyyxEZZjxPvL+SlcUpr8/i5YA6DrIlK5j
 oYn90EYsd+MJK/lM1Y1zvrEoXv7VwUe+3A8u4uTf6gvcwD5zWz74c33UhaPmf6znT9X5MuEJNdp
 7ZX5N3PFXLoKfpjqVud7HmCuE1S56/Hf/jjEh7ot8B9sqThWIpFkGKTD6XRwKBjIqHb5Iakz2Wp
 Uheph+ecmLzMxidpUoDRM8EhmooGVgBmzcUAsC0D4o
X-Gm-Gg: AY/fxX7Vsk8xKiUIaW2XhGqohHtAHOF69aiP9DYkymeRfJYBSDYHC5EGBh8q6HlK/UG
 ygbF4063gednLi/VMQlDWmwvJidKa00beuTPJnPxRD2rdI2p9jhTPtP8TiE+Fw52/JJ+4XPNMuG
 7s2SvjyL0Bj+hZrNxncCCbnTowzd/YcuMyP1AWxNuTu6nL98NGPxXi4aDJY0cP6IlKahhqxYpHh
 soJCpcq3hP1fOxSFmfBkg9fOqqfmbNebHAhk8+seAqgc7Mp76xQ8hxbK6/xK4LpKO/IBqI+U7IL
 qOEs5oSL1UQeE1o/Nq5wJx92kOPCI3bVan/YEQJEXE5LFXji28rr4dwsB/jkBpnNXMfd8cTdyz7
 qhXFdb0FEg3bYO1wLcprC97W5Xq/xzJn9m/R2/tk9r1vjtBI4ooXmSOsBZqx+j07+IJoGkcsQWK
 PAFpMG74RGzjiN5Zo=
X-Received: by 2002:a05:600c:3b07:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-47d195917d2mr264795275e9.35.1766827065358; 
 Sat, 27 Dec 2025 01:17:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7tP8Ocwm5SXjPjY2VZdH8eCz/OcFkuPaayTunLa9U+dq6nWLy8B1Sq7PEfBIDe0vNvUNhsg==
X-Received: by 2002:a05:600c:3b07:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-47d195917d2mr264794975e9.35.1766827064820; 
 Sat, 27 Dec 2025 01:17:44 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4e91sm421394035e9.13.2025.12.27.01.17.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 043/153] system: add prelude
Date: Sat, 27 Dec 2025 10:14:30 +0100
Message-ID: <20251227091622.20725-44-pbonzini@redhat.com>
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
index 2cd2dd36679..e9f36ed8554 100644
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
2.52.0


