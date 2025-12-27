Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A0BE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQn-0005Fa-G6; Sat, 27 Dec 2025 04:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQl-000541-Ex
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQj-0003FR-N7
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwekjZinjWJMgWeTKWwSXEYnWdIxsqhWLTJE90n1OPI=;
 b=VCfcWmE3a/UTAtNmJSc2WZad3zJUKyT+bljEY1b/koMGgfLnaVs3VWxRi2tMGybp4bOC8X
 eoclOsxLPYXw7GFMSxuIYVwUQd5xiSpk+txA93Gv1DjvcvIgyiHwZY0G1LonUcmTZUj1W/
 S151j+XIy3ucUQhDcIYm99NcvAskwnU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-X-kt2YoDNdGVIy3KXTFAxA-1; Sat, 27 Dec 2025 04:17:42 -0500
X-MC-Unique: X-kt2YoDNdGVIy3KXTFAxA-1
X-Mimecast-MFC-AGG-ID: X-kt2YoDNdGVIy3KXTFAxA_1766827061
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso4347552f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827061; x=1767431861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FwekjZinjWJMgWeTKWwSXEYnWdIxsqhWLTJE90n1OPI=;
 b=ivnTbBgZn3QzIeo+C4iL2LgkHBRyf7FHFMGtNqN8RTX6cJIDnR9oSGk7IuaGD7NSjo
 skWQXqNbdwRSCfPGfkbFv7S9aIn9fb2S5mhStdjePS+z6h4g7nV3tm5nruLQkW0plgc4
 PddpZmY5zQs+6fzPDs72fvJE0uo5OHCyzB7ItGDydkJVgw7GXbpfAT0+fv5+R9peLJwl
 SdLIdeqOxy7SjIZ2dwbVQEhEJ1bMhGhYOemkfalyttTWKsHk5uZnwcbC/DstCjau91L4
 +dmNkOTBlu7QkQp2cTysxX042IRmYsjvL2SKQ/ZSTgX4uj6WNBM8Am0evgBlObXZ51Ct
 Yt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827061; x=1767431861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FwekjZinjWJMgWeTKWwSXEYnWdIxsqhWLTJE90n1OPI=;
 b=JxyFZbvKLnuUq1dLmb9YH1typJU9Ydbk9TTWBKcMR6rg5DVWcx6bPybfQEOkhPumh5
 bFjDBA04hbR3W/jljmdRSG2KG1OGA1viBzTm7MXVQZcQYzQKI12lD9ppQJVvTvt0B3T7
 5+R/c/2rfVHToL1quvMv9eJEI+0kVibrdiGaiwssVSoWknL+jZPyWmEUbDBFxekQRAg/
 tFFwuOvnlGSApR7utfxv2wAST3zbD9qObmdZJk7Ryz7z7/4Q0KSRfnVjUhiICIOAljPZ
 ptDcT5GImMzF3aaAx2XzwPYlX3yEsJOrtfrfLWPEeutk3IoIwieRgH+qjRqwaRRmD0mz
 ad5A==
X-Gm-Message-State: AOJu0YyutcDX5+uhADlbEjCG+C55iQBH0Cy3QZO2Prp49GzkBaTgbeSc
 nwz/PiFmeODj036DDOc+iGLVV6c1v/ZK+jNuovJ896bkRK+HX0qq6899yVvVKTTEqLZ5wvrfsLW
 FM7nLGYOMcCgR+gJmhda+vA/BATHIj6MgQSEdJttkfKnKAZMM64pFT/dHhcD20P4QRKWtNtsdV5
 NQR2p4/2CQIJvo0aDqY0k4kZ7aTyTRxuDLKTl27WE/
X-Gm-Gg: AY/fxX7N9YBiQSKp45B2tCGHM3NafT9RknhD/x8XF45yFUmrPLvOr1qeJhAiizvBH9J
 3U7YOpLgAuew9wWPhEFwOldNFQAP14Arj4ZhyTTanVdguDOX8YYKPFbKk01yWuBjn/bxrSiXe9E
 J1FXm9iWM8KFytAnwIwihRw+xMu8mL0Eh1w3Ta5RK5espr0fzzMNGjtt7QZBCNxL45AVrxP+kMT
 OKfzVJT1PdK6WYdkvTihIZ0VLWRdbI5dPXBw7oZpdp7HObgKiOhx48fkx9oGHyKHvk/JWJ3wR/w
 pMHtmrEeSH+U012sCG73IVzddgxFwqT76KK/lxkpIRmEuutnB4FmpAkn34ZtyEGGk3CgZDOBYRq
 oTbSC4CdHITSgYrzuhGYQlH+6NtkPWupIcxSg4BKXthN3dQxfQvVJosVZqDRvMS8z4WOjWdQYLx
 F1rvJECFH9QRMB5qk=
X-Received: by 2002:a05:6000:24c4:b0:430:fc3a:fbce with SMTP id
 ffacd0b85a97d-4324e4c9d45mr34443861f8f.15.1766827060937; 
 Sat, 27 Dec 2025 01:17:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE9bb0R5f+0u58pO69zWp65EnjxxVRVrAvKPl359NUjwK8hb5k+6GwJyKKe/a9+dSPFcVPkw==
X-Received: by 2002:a05:6000:24c4:b0:430:fc3a:fbce with SMTP id
 ffacd0b85a97d-4324e4c9d45mr34443833f8f.15.1766827060415; 
 Sat, 27 Dec 2025 01:17:40 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm50395867f8f.20.2025.12.27.01.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 040/153] migration: add prelude
Date: Sat, 27 Dec 2025 10:14:27 +0100
Message-ID: <20251227091622.20725-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 rust/chardev/src/prelude.rs       |  3 +++
 rust/hw/char/pl011/src/device.rs  |  5 +----
 rust/hw/core/tests/tests.rs       |  2 +-
 rust/hw/timer/hpet/src/device.rs  |  5 +----
 rust/migration/meson.build        |  1 +
 rust/migration/src/lib.rs         |  5 +++++
 rust/migration/src/prelude.rs     | 19 +++++++++++++++++++
 rust/tests/tests/vmstate_tests.rs |  5 ++---
 8 files changed, 33 insertions(+), 12 deletions(-)
 create mode 100644 rust/chardev/src/prelude.rs
 create mode 100644 rust/migration/src/prelude.rs

diff --git a/rust/chardev/src/prelude.rs b/rust/chardev/src/prelude.rs
new file mode 100644
index 00000000000..9f0b561bfab
--- /dev/null
+++ b/rust/chardev/src/prelude.rs
@@ -0,0 +1,3 @@
+//! Essential types and traits intended for blanket imports.
+
+pub use crate::chardev::{Chardev, CharFrontend, Event};
\ No newline at end of file
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 164f27d5bb2..2e4ccc9b231 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -8,10 +8,7 @@
 use chardev::{CharFrontend, Chardev, Event};
 use common::prelude::*;
 use hwcore::{prelude::*, ClockEvent, IRQState};
-use migration::{
-    self, impl_vmstate_forward, impl_vmstate_struct, vmstate_fields, vmstate_of,
-    vmstate_subsections, vmstate_unused, VMStateDescription, VMStateDescriptionBuilder,
-};
+use migration::{self, prelude::*};
 use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
 use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
 use util::prelude::*;
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index b39d1501d5b..f38376d0016 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -6,7 +6,7 @@
 
 use bql::BqlCell;
 use hwcore::prelude::*;
-use migration::{VMStateDescription, VMStateDescriptionBuilder};
+use migration::prelude::*;
 use qom::{prelude::*, ObjectImpl, ParentField};
 use util::bindings::{module_call_init, module_init_type};
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 7ab9897cdfb..4ff1779a3d2 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -13,10 +13,7 @@
 use bql::{BqlCell, BqlRefCell};
 use common::prelude::*;
 use hwcore::prelude::*;
-use migration::{
-    self, impl_vmstate_struct, vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
-    VMStateDescription, VMStateDescriptionBuilder,
-};
+use migration::{self, prelude::*};
 use qom::{prelude::*, ObjectImpl, ParentField, ParentInit};
 use system::{
     bindings::{address_space_memory, address_space_stl_le, hwaddr},
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 94590dc1b87..76d86b0ac0f 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -32,6 +32,7 @@ _migration_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/migratable.rs',
+      'src/prelude.rs',
       'src/vmstate.rs',
     ],
     {'.' : _migration_bindings_inc_rs},
diff --git a/rust/migration/src/lib.rs b/rust/migration/src/lib.rs
index c9bdf0d4133..32e182e716a 100644
--- a/rust/migration/src/lib.rs
+++ b/rust/migration/src/lib.rs
@@ -7,5 +7,10 @@
 pub mod migratable;
 pub use migratable::*;
 
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
 pub mod vmstate;
 pub use vmstate::*;
diff --git a/rust/migration/src/prelude.rs b/rust/migration/src/prelude.rs
new file mode 100644
index 00000000000..797e7ec59d1
--- /dev/null
+++ b/rust/migration/src/prelude.rs
@@ -0,0 +1,19 @@
+//! Essential types and traits intended for blanket imports.
+
+// Core migration traits and types
+pub use crate::vmstate::VMState;
+pub use crate::vmstate::VMStateDescription;
+pub use crate::vmstate::VMStateDescriptionBuilder;
+
+// Migratable wrappers
+pub use crate::migratable::Migratable;
+pub use crate::ToMigrationState;
+
+// Commonly used macros
+pub use crate::impl_vmstate_forward;
+pub use crate::impl_vmstate_struct;
+pub use crate::vmstate_fields;
+pub use crate::vmstate_of;
+pub use crate::vmstate_subsections;
+pub use crate::vmstate_unused;
+pub use crate::vmstate_validate;
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index fa9bbd6a122..c3f9e1c7436 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -16,9 +16,8 @@
         vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
         vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
-    impl_vmstate_forward, impl_vmstate_struct,
-    vmstate::{VMStateDescription, VMStateDescriptionBuilder, VMStateField},
-    vmstate_fields, vmstate_of, vmstate_unused, vmstate_validate,
+    prelude::*,
+    vmstate::VMStateField,
 };
 
 const FOO_ARRAY_MAX: usize = 3;
-- 
2.52.0


