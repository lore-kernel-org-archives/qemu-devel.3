Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA0E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQr-0005NN-Kp; Sat, 27 Dec 2025 04:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQp-0005Lg-V4
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQo-0003JK-Fr
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsRfJ17Tv3k56iygc1dJWL298tqHmSNxwclb6VwBO0g=;
 b=hwGiaceLoMrPKEfQVRsKCO/eMMSGs+PwWLCnvzZDyo/GfM0npjn7X+gcn13Es2HbO61np4
 85D4M0VSsvgb3tKy3G6+DFtH1NN7jyIRbqFNOEna/yoU0BhRcnz3K7o5R5G131Um8Y2A52
 hF0OBAIOv+Gl7O6SMCwghiPluf9hmwc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-ISCKBvEwPmWZ0BbK4RWF-A-1; Sat, 27 Dec 2025 04:17:44 -0500
X-MC-Unique: ISCKBvEwPmWZ0BbK4RWF-A-1
X-Mimecast-MFC-AGG-ID: ISCKBvEwPmWZ0BbK4RWF-A_1766827063
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso2497420f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827063; x=1767431863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fsRfJ17Tv3k56iygc1dJWL298tqHmSNxwclb6VwBO0g=;
 b=g4TTJzqnNGgtuDRk44JtpVphZTdWJkKUMfj5VhlpF2BmFmMtm9A6sPzLTFyR4oS/88
 g7IWHuj4ZVFxx8CIZ1FgP/h6PD12MKghzJsQbZDrYS6tZ6n1iNErfCZMmxQ0VCFZBri0
 fa7kTzOsazD+t6PxjC8fFkDUyjGcN1ewiF5vCRSV5/B1tQE91L1QzZEztNpWRnvj5f/e
 IR5AufR+GYFAN/QJxbeW5ObxC+CJFOrYnkzcCm3TFjgqPxbq9rG1yYE1SDlSDGk9kIaB
 9iLpT/3MPqWxHhOaJ0w6M5Pop6kX87FkCaZh0QubpTq6YA24DGCqM4UQDBPGHj0vQvrw
 T6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827063; x=1767431863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fsRfJ17Tv3k56iygc1dJWL298tqHmSNxwclb6VwBO0g=;
 b=le02nlMCSK1ztO9FGw4AdIqpIYP0d3v9Bhn7lWhRZ2RPC10Nyeb/arteJVpJ89NPoj
 bQUFSV98hr06rn8lf8O/xp/qilH2rMoFhDGsEGpdmnnIV2HlnczoAWLexywTL7DC8oAk
 rmH0CKjjgQccOv+5K9xiDhB9GeETwFWFGQonhMljNs5snk1UV73xQTAXKaqF45nNVMUJ
 hn71ISpxKtm9qIwqrI7N8aukYSAig9nNe/AtZsXj/wQyM49he3oWhOO0LRmnEXPAzs/7
 liqHwJoLfCl0NXv7ydOzDlvAETTav0yoNQQ/pZA6GaMbUaSpKnMW7jLlui9ra7BcEqOv
 W4qw==
X-Gm-Message-State: AOJu0Yy0tSkNvBaDMt/9UrqI+8vLhYxFpOqxroMsPfeDpWtKLKDzsIjN
 2GnMFeqhDIfzqvBtce/HoHfh/ajRO6fomkd37g9AZAKymK6yun+FLhpV0ochzITDRHoSsCEVV3Z
 ALDXurhP3xv2pc0eLmjEAjjBgVg/n6thuiPpTs6EUMr4xW81ZKOjpHx1GLXKAhBKkcqk+d2jpWF
 OSoYxxJtoBkkF3BVbSa2gLdPQa0ew2Keke4vaeX3kj
X-Gm-Gg: AY/fxX6S2y3hHuxH7+uxcuI0Tx+5VNgwbhecV2m9SrGGrxIudFy3jPtLicUK4VZLrCO
 o+0Uy4a+9/fYkrxQ4FCRVRX2S3DbuUCd25v3OftH5DcyySJgichIavJ+IjPdX8F+5Nbt787ldHh
 iebCrDnzNTr7cfFt2W6Jl5HESa3bloQ158ZuZgxjN7FTe0FVzSDqsqNvgIsTy080FFzTfwTem/w
 nty8cFsjLuYzyPa7sxniSs53jiyZdtb0ApdCmUc4ARXOim6zF1YayaJkV89s5j/842JI4IGPfYa
 P/3FVM5oGvMpeDXUAaSAzVRif0z1LM++UXgWqkp+mY0eeEYQm/3gPpl8u9u0AEr9pPrEHif35B4
 1Iiqlp799/DQtUY6A1LJn/Ta26ITIBcRH6xS4gKARwop7saIBY2l11X0hkc0VmnLk3xOfYpY6Tn
 wP7E/CtwpyJxa1t1Y=
X-Received: by 2002:a05:6000:40de:b0:432:851d:23e2 with SMTP id
 ffacd0b85a97d-432851d2633mr4205088f8f.49.1766827062842; 
 Sat, 27 Dec 2025 01:17:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZgUyTignmUNVGcnYrV8ZqNnWSrdz2zQ0J4yerIydqlD+JEwFe8zx9r14iCsiDpyDCkf0IbQ==
X-Received: by 2002:a05:6000:40de:b0:432:851d:23e2 with SMTP id
 ffacd0b85a97d-432851d2633mr4205062f8f.49.1766827062298; 
 Sat, 27 Dec 2025 01:17:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm50634584f8f.37.2025.12.27.01.17.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 041/153] chardev: add prelude
Date: Sat, 27 Dec 2025 10:14:28 +0100
Message-ID: <20251227091622.20725-42-pbonzini@redhat.com>
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
 rust/chardev/meson.build         | 1 +
 rust/chardev/src/lib.rs          | 5 +++++
 rust/chardev/src/prelude.rs      | 4 +++-
 rust/hw/char/pl011/src/device.rs | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 6b681c609ad..54bb2962528 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -30,6 +30,7 @@ _chardev_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/chardev.rs',
+      'src/prelude.rs',
     ],
     {'.': _chardev_bindings_inc_rs}
   ),
diff --git a/rust/chardev/src/lib.rs b/rust/chardev/src/lib.rs
index 2e549f99d91..93a28725932 100644
--- a/rust/chardev/src/lib.rs
+++ b/rust/chardev/src/lib.rs
@@ -4,3 +4,8 @@
 
 mod chardev;
 pub use chardev::*;
+
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
diff --git a/rust/chardev/src/prelude.rs b/rust/chardev/src/prelude.rs
index 9f0b561bfab..f949d925399 100644
--- a/rust/chardev/src/prelude.rs
+++ b/rust/chardev/src/prelude.rs
@@ -1,3 +1,5 @@
 //! Essential types and traits intended for blanket imports.
 
-pub use crate::chardev::{Chardev, CharFrontend, Event};
\ No newline at end of file
+pub use crate::chardev::Chardev;
+pub use crate::chardev::CharFrontend;
+pub use crate::chardev::Event;
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2e4ccc9b231..ff929e60993 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,7 +5,7 @@
 use std::{ffi::CStr, mem::size_of};
 
 use bql::BqlRefCell;
-use chardev::{CharFrontend, Chardev, Event};
+use chardev::prelude::*;
 use common::prelude::*;
 use hwcore::{prelude::*, ClockEvent, IRQState};
 use migration::{self, prelude::*};
-- 
2.52.0


