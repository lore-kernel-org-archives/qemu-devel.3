Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A651ACE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKttg-0003VB-I7; Mon, 17 Nov 2025 02:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtsx-0003Rj-GR
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtsv-0005um-SU
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3DOmTTtUlRI29oyMtkqRVQpm1BCXvndErwb6vVQTDc=;
 b=ECdMUz1gydLzT4Qqmjzu9ByOKl1R99ZFB4N2GZrqpuQTMNeAcPff/RoSGip0QN4V5fbhe8
 polAiZb9SM1G7tSV+iPB1QlhVrUYd8DT3x2Kj3DUtE/0lKhlQPXMM7de6P7gcAE8yqK57H
 gfuEvxTHEYMEk6RbbGdV+5hyWGelhrg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-QKBOIeYIO2KohkrB6XUxcw-1; Mon, 17 Nov 2025 02:42:45 -0500
X-MC-Unique: QKBOIeYIO2KohkrB6XUxcw-1
X-Mimecast-MFC-AGG-ID: QKBOIeYIO2KohkrB6XUxcw_1763365365
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so10053175e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 23:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763365364; x=1763970164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3DOmTTtUlRI29oyMtkqRVQpm1BCXvndErwb6vVQTDc=;
 b=GLfgAiGGV9dmjd5h3OO17MoI33rUYd4lFyu7fJjJT/FQw78EW5xwJJekW5Rx9d1PMu
 tzEimoD2Y0FgZ80N/5gowz5mA8AHvFgt/kZdBEPMtLmNBGDWtgWhrdnMJb/+7ZUchxhx
 i2U1nXkVfERBpHQY+tdW2r46kPqnoETaraaFx016SxwpLQ9cV5KfGKaf4v3elo6okiYW
 rINMfNyHPK92He4vpVTjQqAguO7IrlA+oc9qGsismP0Amokh3ooDT4snXvrzGQo5TcKt
 2VOd4ll1AMIewKV4CMvsNGndKKweafhzfFM4vX1Oapuu+POX/0sf80TDlPjZzjvAOg8W
 CYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365364; x=1763970164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A3DOmTTtUlRI29oyMtkqRVQpm1BCXvndErwb6vVQTDc=;
 b=HP2BO/sAaREqMUehtum6UANvUoLmfQtixsWHIYuRCGXogfAEFv12qjYmXB5jE4ZXMO
 8fBdxJkL3o+/0DRMV2Ma4FTOj33KAkDaRpySeXE7gwy9417M7ncrczXmlENzdKtruQPn
 /X0IifcEc1erB3Fp5s95Qcy1fFBtP22gTKSr4SqlX7UuzTtqC4Eo7g9oLSe4IDruzhbf
 9QWijyeTE3qOQY2Dmr1Po4q5xBzmCdb0CLDDBh7HxBeIqU44YqeEaO4xkcIG9KN/0vM0
 z9TurrzDyA011nMJnfokz09ZhkXU9wOwwE+qJIsmushFLbgg1KQW1F6iSMMiI2qf0/6Q
 tUZA==
X-Gm-Message-State: AOJu0Ywx4VHhccQmp08CTdPnV8scAD7v6nQo20vlZhU50HL1cw0g29lu
 /BrqJgFkWzK6/oictfkTFQN+rfZKvQ2J+illVIue7EAe8zuozvixJL3l/wG9FLj/gsZw3oji+x3
 SmHavuS8EI8UEkrnX58+UELZg56y/a/qOe8Nl9wBxjvm/PH8584ZZ45ajtTJO0N49sNEFvjS414
 kBURotKlFafNbEOZUbzSk7tizi2PtctjpD4LJ5+wJ7
X-Gm-Gg: ASbGncuVXiNiiF0uLLfdeJ5XMt9PSN7+NulxFyhFc75jBivinicSgtFkLeQDtQXT6FH
 Nei4/1XjDURlRKdni+tWZUzRHTLZ95JykfJAW7siS+bjORVGl3zhV1PmPKujyQ6CtM2+2ypHJDO
 UL03WNysIRdz/gx/zQ14Vb5eOG5l29hmT610S45HSrcN1DtMxR4us2F2mKvkSecQYLya5FJGhNB
 mossgPwnKtSmBmbsOxDFFr8h3iYoL4NYxmp70szIN/Qz+zcS1TLnV7zjYCT5zUIr3CXVN06+f8j
 8JriD50v2LV4DINH07OLGE5/H5BnxDEbBbXmr4sh5dZG4GnrQshMHE+/UEFr2n71QyM1Bhw90hI
 l/0aVJFzQ8kq6mzPcwk9tU5IdzdkzBmDT6eOsgMeBdoP12nQAfnVMjLrt6ZamZjGc+uH70e4End
 6BFQmg
X-Received: by 2002:a05:600c:c4a1:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-4778fe96c46mr94795825e9.35.1763365364221; 
 Sun, 16 Nov 2025 23:42:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSxxfwKIqmVC45rPVAwvXfEMRLb+nGUQiQ9mYHEyIDE8dNbU1NYcZ49MsAqNBzM+bIaH1UnQ==
X-Received: by 2002:a05:600c:c4a1:b0:475:dd7f:f6cd with SMTP id
 5b1f17b1804b1-4778fe96c46mr94795525e9.35.1763365363713; 
 Sun, 16 Nov 2025 23:42:43 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779973ddcfsm116793655e9.15.2025.11.16.23.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 23:42:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/8] util: add prelude
Date: Mon, 17 Nov 2025 08:42:31 +0100
Message-ID: <20251117074239.190424-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117074239.190424-1-pbonzini@redhat.com>
References: <20251117074239.190424-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 8ad344dccbd..da5d0f779d1 100644
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
2.51.1


