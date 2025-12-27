Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02657E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQg-0004vh-Os; Sat, 27 Dec 2025 04:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQf-0004vH-R7
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQe-00032r-6O
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npP6lBXv8yluOnouSv/I/yZNTQJ/85K9PXZ3liTT2JQ=;
 b=OMg2mN0EirGz6N8NK9hjIy8mNIxqyGRU7DWnr9ijMXRV6QCtME2IkbkPrQPsem/gRHzxCl
 FLTUd91l+FgFf5f9wK3wYcQXtAQKh0WHx3rf58xvEdfPGJ5rsTJNY+FqLF6bqxw/4OX+ty
 MmNjdExpGKi/hfi+Pu+yqwgU8AndjAI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-pwbDrNd4OJu_X03NwDyLwQ-1; Sat, 27 Dec 2025 04:17:37 -0500
X-MC-Unique: pwbDrNd4OJu_X03NwDyLwQ-1
X-Mimecast-MFC-AGG-ID: pwbDrNd4OJu_X03NwDyLwQ_1766827056
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325b182e3cso3054652f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827055; x=1767431855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=npP6lBXv8yluOnouSv/I/yZNTQJ/85K9PXZ3liTT2JQ=;
 b=GzI6BcSn9dBva+IOrPG+shVJBhE6mLHnfisamqT/j1csWktkkGwOKkKOEXBm/0bpHr
 LjNMy5c8AEV/GnRwZmUX8Qu0RFJ+ojP7J5RBAMhjqTIB4/v0wlAhjizrvvoTkSUYpXve
 gFICf3XVur2LW2sZkigYhC9N6xKcgTCyVTSIXrD0SJvt3WlB2jLJ92hBuN2lPjyVkc1N
 rIK5zbjG7mwIJhaQthdF8Z8XO/YH4zI1nxMh9zo04c+Vq9MJTroVJCj0TgHEVInSv7iP
 cmMaJoTCWPbeYTzyF6cPAaYEoFX2/rSuiS0k+ZcXgTmTpA8lV/jkkls/sYGHCtAKKL2n
 +sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827055; x=1767431855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=npP6lBXv8yluOnouSv/I/yZNTQJ/85K9PXZ3liTT2JQ=;
 b=GE9KfePighwsPSW3Bt1/s9L92hdJgFteN0T16rTHev7RH2hmtM1B/jwYdRq2A7SACf
 1ZAxzNvzbDOCyDhkNNMQaMX7qeUDeBVWRJjx54vmUoVBnl5hMF3kizL4fiIIJeDq2LpL
 IXoiN60qLw5N8Uiq4uTIVTTuIq8Ob9ikRj9rjjBQIA/6lexYMkG7vlyzi8H+1vHPsfdv
 oubwEMXm5X7VWiJDpOklTfrcAiEoyEOWJ1JrYkpIFgz8o5su79SX0hL6mOSzeuhpayk0
 ZGnnLK2iZyY+Or0tUg+KHi7+O/IIW0waj4Zjilpw3UP2wAjuoIW/3WAs4O231hk55yl0
 TINQ==
X-Gm-Message-State: AOJu0YylAq8WADKHms/Y6/VCkjIcBerFlUEw60moFAGWx5O3kkZlbR1S
 kHRYtrXSZf9lrnOEiR9iF1ll7R4WBydNTGcybis+TGaXchJgV/cp7hvCKTu1chmwrrloxSmzoBr
 QJMMMvEAWw40o0xD6Aj8GXHl3hu+5EIlyfCX9BWQ7rGlQbgSjlyq4ylynJ7pt4YhYILHUqfIT1S
 xSSQZXC8HpMpouIoKny+Qi6QWtogCUcCU2foHpkw45
X-Gm-Gg: AY/fxX4gE9NMrTM9Vf61kxzB/89Njv8yZVt1lYAkuLd0rl8KNol6a6zjbbjIv56qyUe
 udr2iYv3k4pyztV9tK9gcNEr4xn05qG0M4Hzn75jyqRfhlh4SQsV0DkP7upBqWZPxm29GzctLd7
 23OLe1osDga4GbNfOsErqJMXajQ16Lab/I/VYZN48gEbYl88s4rFubwze2HccYKtE6wpliza25B
 QEp6aUhhzuNWf41Fxi9LnQZx/j8zYtLJ4/MJsw23C6SCs6AijNR/mUd0dgTz+ppPUcikPl8Kw/f
 6aU66UYdVxwpEyqccUB2EnbFZHTVU9EEAApgTPPZoEDM1sx1ffdFLyI/8hGtl4xnvmejPTrR7hB
 r/QHIdm7w2aJZZrH6IzhGn8yf3nlZL0NVBJ0Tw89DX9T3u4Q3U9GjV0ZGY1exGwoXewNoV4LtNC
 078VtVzH57ma/4fkA=
X-Received: by 2002:a05:6000:611:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-4324e4c70e5mr25675141f8f.3.1766827055178; 
 Sat, 27 Dec 2025 01:17:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrKB4MYlE58YQiODrimvgOYLPwJRoz7zmW8GXjiXHvr5xEITVHgC4ICIl/4yWEV11td/YI9A==
X-Received: by 2002:a05:6000:611:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-4324e4c70e5mr25675113f8f.3.1766827054664; 
 Sat, 27 Dec 2025 01:17:34 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea22674sm51317229f8f.10.2025.12.27.01.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 037/153] util: add prelude
Date: Sat, 27 Dec 2025 10:14:24 +0100
Message-ID: <20251227091622.20725-38-pbonzini@redhat.com>
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
 rust/hw/char/pl011/src/device.rs |  2 +-
 rust/hw/timer/hpet/src/device.rs |  5 +----
 rust/hw/timer/hpet/src/fw_cfg.rs |  2 +-
 rust/util/meson.build            |  1 +
 rust/util/src/lib.rs             |  5 +++++
 rust/util/src/prelude.rs         | 11 +++++++++++
 6 files changed, 20 insertions(+), 6 deletions(-)
 create mode 100644 rust/util/src/prelude.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 04155dabe1a..18f40fdc58b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -17,7 +17,7 @@
 };
 use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
 use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
-use util::{log::Log, log_mask_ln, ResultExt};
+use util::prelude::*;
 
 use crate::registers::{self, Interrupt, RegisterOffset};
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3564aa79c6e..6e9c004ecae 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -25,10 +25,7 @@
     bindings::{address_space_memory, address_space_stl_le, hwaddr},
     MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
 };
-use util::{
-    ensure,
-    timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
-};
+use util::prelude::*;
 
 use crate::fw_cfg::HPETFwConfig;
 
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index 777fc8ef45e..ad80acd998c 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -5,7 +5,7 @@
 use std::ptr::addr_of_mut;
 
 use common::Zeroable;
-use util::{self, ensure};
+use util::{self, prelude::*};
 
 /// Each `HPETState` represents a Event Timer Block. The v1 spec supports
 /// up to 8 blocks. QEMU only uses 1 block (in PC machine).
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 18d67a4b374..95b44f7c670 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -34,6 +34,7 @@ _util_rs = static_library(
       'src/error.rs',
       'src/log.rs',
       'src/module.rs',
+      'src/prelude.rs',
       'src/timer.rs',
     ],
     {'.': _util_bindings_inc_rs}
diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
index d14aa14ca77..7d2de3ed811 100644
--- a/rust/util/src/lib.rs
+++ b/rust/util/src/lib.rs
@@ -4,6 +4,11 @@
 pub mod error;
 pub mod log;
 pub mod module;
+
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
 pub mod timer;
 
 pub use error::{Error, Result, ResultExt};
diff --git a/rust/util/src/prelude.rs b/rust/util/src/prelude.rs
new file mode 100644
index 00000000000..f52e7100e9f
--- /dev/null
+++ b/rust/util/src/prelude.rs
@@ -0,0 +1,11 @@
+//! Essential types and traits intended for blanket imports.
+
+pub use crate::error::ResultExt;
+pub use crate::log::Log;
+pub use crate::timer::Timer;
+pub use crate::timer::CLOCK_VIRTUAL;
+pub use crate::timer::NANOSECONDS_PER_SECOND;
+
+// Re-export commonly used macros
+pub use crate::ensure;
+pub use crate::log_mask_ln;
-- 
2.52.0


