Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C6EE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQR0-0005UZ-Ck; Sat, 27 Dec 2025 04:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQs-0005OR-RB
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQr-0003Qy-AA
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTCXqPXLE/4/zflAMpw7ZRNXVyd9ZRmA4bEXl/HdzsQ=;
 b=Z5NZ3PpiNYZDhp0pD/P+3dVd6d1oCxiiBS5Qu3SKIkiD8Ub0nzASTqts8G81qsNL9ZSxwQ
 2tGnhWhQ5l5ctnUD6XL77NNhcCb0vyopGa+LlFl8c618d2uzsNy1IvOwX9dh/DEffEiwLZ
 h0qpuMPTmNEDnRKbaNCHOVz/D/hNIYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-HMNuaH1nMmWoFaIqOQ1R4Q-1; Sat, 27 Dec 2025 04:17:50 -0500
X-MC-Unique: HMNuaH1nMmWoFaIqOQ1R4Q-1
X-Mimecast-MFC-AGG-ID: HMNuaH1nMmWoFaIqOQ1R4Q_1766827069
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so44886055e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827068; x=1767431868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GTCXqPXLE/4/zflAMpw7ZRNXVyd9ZRmA4bEXl/HdzsQ=;
 b=RZcsniPYu8075+pfxnUyjP2/td+q4ZTXCm3i9sJm+e9hlsBkoQPfImJ9QqaDLAvZwe
 oyxEHGHvaZ9HA5u6LuF0tw8EN3HTITjloSY+zFoT5KllKWqz4wiSSf91fekAV1ELLyWn
 +AXeD5BmPHuMi+7R9P8PSPsz5VVpj8WfGAvC8d1xvoLanyS2B29ZWPnCHOiBtT0f437s
 XhYkvRJmPhvxAn7608X770a0yWeieGmnUFhuVee6E3vOXB1fRQbwU3uW3ijwU6B3QQU7
 axA3Rk7cLTrcnSaeg8zvcNMmWnc/zeunX66pBg1LU3LY36yybGmnzapzXcIFBAcLlpqF
 TieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827068; x=1767431868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GTCXqPXLE/4/zflAMpw7ZRNXVyd9ZRmA4bEXl/HdzsQ=;
 b=smbDLOakjuZ0MSSp8NDcDVVA655/HExjvsoEZcvEp4Zo06e0cv+0kIRytrmOaiKw9d
 eb13SSK+jNciZrG/m5cRjnBpa2qIy7FBOKyaZ+t5mS9famZT28jEvc6FqFD87S85EygO
 yadQPprCqByy7ba+/U/HoSQYV9wF3An+IwWRz2zJsXtZTTaqrEH/B1qAb0/dnsoLTEqN
 OzUYJvS5D9x7Ft0U22L8wRiv4Zsxxe7c2lRFYk46FJyEcTyeOPhAQO718fQpqEjXxqOM
 /hAoQJlOojvwCFl4eKJqvP96fqe+YtCm3ydfe2X1WnLp6PCjhm11USRbvzbRnTR95dwt
 Dqsw==
X-Gm-Message-State: AOJu0YxDgS+KPQxv4WFuNyRqKPbBjDdTMo50y54lQhkgWL35z4iEUpss
 hbGB5bGxcswerwsFewMRbIjmnQuTYu/UcEQ13D3ZmkstZ2WU+MiPzr1Aeu8TIsJQ7bge66K5Cuq
 Mki9Q9r4wWsM28LeMp3glIU0evGOqrdDE8fluCR5YKthLe8hDXgUGt3uidyaxhLES5v82wm6GIM
 IEvKhOAbgRkSF2wbZ1NMLGDqNoHhv1DCCJD6LQ6Jwo
X-Gm-Gg: AY/fxX54MCrfaHs1n3e177nfz9dz367Gm8vJ0JUQO2gGnBYMdY8vKJjCpU5xN1WaX4S
 37up4z6dpvaYDVM9cRxCT+NIgkH6op2WqoMHZwEAfKcsfuz919RmGNBLilv3kg9DZSOUUH+da62
 QfTwNEi3yrsiP1tSXw2JC+QEZ9GKH9bk2jLD+vluiCN+VSlue4PNIxhfmvxPFep0ofH7J7Ef7dz
 07Oa41OnIKTADPP+Cv836UMo3l8f+kvVZ085vYEQm2oXAB2qM4m0bhzOa/I9oX17CS65xhMHH0Y
 jaysU+1Os6L1nyyC2xtncHb6xWg++KA1J3wXVYfgHKZY1GF36Y/0k8Q8p3cfLRlQ7OuJAwwqsDY
 0J07hKzBY/gNhJRtkVfRydKPAvK8XbvX/VSnrWrjeXX8S4LRm2EYR/tArbIGU8T5SgecfVqoLtc
 powfcvOSGXpdePJRE=
X-Received: by 2002:a05:600c:4f15:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-47d19538dfbmr317525265e9.1.1766827063903; 
 Sat, 27 Dec 2025 01:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5KReWIw8WM1LxCWxZJuE8zgYNxjy/NLlXont3WePdUDPzweAcHAHbxQW1cgw9qgqnLm8bmQ==
X-Received: by 2002:a05:600c:4f15:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-47d19538dfbmr317525045e9.1.1766827063417; 
 Sat, 27 Dec 2025 01:17:43 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279d6d8sm483809325e9.10.2025.12.27.01.17.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 042/153] bql: add prelude
Date: Sat, 27 Dec 2025 10:14:29 +0100
Message-ID: <20251227091622.20725-43-pbonzini@redhat.com>
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
 rust/bql/meson.build              | 1 +
 rust/bql/src/lib.rs               | 5 +++++
 rust/bql/src/prelude.rs           | 4 ++++
 rust/chardev/src/chardev.rs       | 2 +-
 rust/hw/char/pl011/src/device.rs  | 2 +-
 rust/hw/core/tests/tests.rs       | 2 +-
 rust/hw/timer/hpet/src/device.rs  | 2 +-
 rust/migration/src/migratable.rs  | 2 +-
 rust/tests/tests/vmstate_tests.rs | 2 +-
 9 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 rust/bql/src/prelude.rs

diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index e5836e3f566..728c9e4dacf 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -31,6 +31,7 @@ _bql_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/cell.rs',
+      'src/prelude.rs',
     ],
     {'.': _bql_bindings_inc_rs}
   ),
diff --git a/rust/bql/src/lib.rs b/rust/bql/src/lib.rs
index ef08221e9c1..d2fea5db1ac 100644
--- a/rust/bql/src/lib.rs
+++ b/rust/bql/src/lib.rs
@@ -6,6 +6,11 @@
 mod cell;
 pub use cell::*;
 
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
 /// An internal function that is used by doctests.
 pub fn start_test() {
     // SAFETY: integration tests are run with --test-threads=1, while
diff --git a/rust/bql/src/prelude.rs b/rust/bql/src/prelude.rs
new file mode 100644
index 00000000000..42031ec18ab
--- /dev/null
+++ b/rust/bql/src/prelude.rs
@@ -0,0 +1,4 @@
+//! Essential types and traits intended for blanket imports.
+
+pub use crate::cell::BqlCell;
+pub use crate::cell::BqlRefCell;
diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
index f0b7975dbf7..fb9674b3fb4 100644
--- a/rust/chardev/src/chardev.rs
+++ b/rust/chardev/src/chardev.rs
@@ -18,7 +18,7 @@
     slice,
 };
 
-use bql::{BqlRefCell, BqlRefMut};
+use bql::{prelude::*, BqlRefMut};
 use common::{callbacks::FnCall, errno, Opaque};
 use qom::prelude::*;
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index ff929e60993..be1bdf5ab12 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -4,7 +4,7 @@
 
 use std::{ffi::CStr, mem::size_of};
 
-use bql::BqlRefCell;
+use bql::prelude::*;
 use chardev::prelude::*;
 use common::prelude::*;
 use hwcore::{prelude::*, ClockEvent, IRQState};
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index f38376d0016..e60c9d018f5 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -4,7 +4,7 @@
 
 use std::{ffi::CStr, ptr::addr_of};
 
-use bql::BqlCell;
+use bql::prelude::*;
 use hwcore::prelude::*;
 use migration::prelude::*;
 use qom::{prelude::*, ObjectImpl, ParentField};
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 4ff1779a3d2..b7153a46e31 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -10,7 +10,7 @@
     slice::from_ref,
 };
 
-use bql::{BqlCell, BqlRefCell};
+use bql::prelude::*;
 use common::prelude::*;
 use hwcore::prelude::*;
 use migration::{self, prelude::*};
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index ded6fe8f4a6..ce603867502 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -9,7 +9,7 @@
     sync::{Arc, Mutex},
 };
 
-use bql::{BqlCell, BqlRefCell};
+use bql::prelude::*;
 use common::Zeroable;
 
 use crate::{
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index c3f9e1c7436..87176a80990 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -9,7 +9,7 @@
     slice,
 };
 
-use bql::BqlCell;
+use bql::prelude::*;
 use common::Opaque;
 use migration::{
     bindings::{
-- 
2.52.0


