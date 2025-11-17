Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43822CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKttl-0003Zv-HO; Mon, 17 Nov 2025 02:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtt5-0003SP-Ou
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtt3-0005wE-UL
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uQzjTFfWRdSW8gNz8omUuliKS/DL3l6Q/I07/brxsKY=;
 b=DI4BEUnEXlAobcPyZF59cf5j/6nNs6Aov40vsviAYViR9AOB4pjfFrpE28i/wRsFyVNe3d
 JzOFYUMUykafZxEBdMPOQ1CaJvWij3Z2Kz0bsqXLVuWc59bycvBqgCHLTgcLI6rF5A7fAO
 6isamaHFy1LhtwBXSVqRYnVqng5tr9Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-1GX3c8V7MHKqSzDV9YcuAw-1; Mon, 17 Nov 2025 02:42:55 -0500
X-MC-Unique: 1GX3c8V7MHKqSzDV9YcuAw-1
X-Mimecast-MFC-AGG-ID: 1GX3c8V7MHKqSzDV9YcuAw_1763365374
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b3ed2c3e3so2825787f8f.1
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763365373; x=1763970173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQzjTFfWRdSW8gNz8omUuliKS/DL3l6Q/I07/brxsKY=;
 b=dE5MJqOflrPRlXEn00Xri8EN3yheaoa8x2me//fgQzBAOD4FqjhAxNlENE0GHnWIPG
 FZPU9l54DWPNKapYTGUrvY8oJhynjS1C9WQHo/a9BR0kCFPJtXnIj6hPxd3/vu5/sFnt
 iu54iMQgVEqN4EXdtE9XCoFVGe9eHieYyFGDFrhkohPXMN5/uDL/obYfRt19aB5MjjXb
 mppULlULlb74E7S/6/QSH+vVLJNdHjOKbuVy5G2PLkBZ1Hg3+dSu12xMcUFd03GLEz/1
 IWZko9YGuHzGjMPWl6p6l3xpU0Nc0OVO4/8wBvlGZ9IKK/4BiDYqgefMZI4NKUuQ4DbC
 K0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365373; x=1763970173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uQzjTFfWRdSW8gNz8omUuliKS/DL3l6Q/I07/brxsKY=;
 b=I47TNeDQB+loGVaLPx7Gikj9mJ+rwtaeAM/b4MeZGR3gJqxnEYjX//KubJi3hxMJ0/
 uBwxdDYwDCyljd4gLbKD1Jzsr1vnJU7Xe9bjRPYt/1TZjgzeTByZhUyWMvxx8qAfauWn
 rsP3REhiz3i36kBZwp1EfFt5UgQyvkaOz4jv1TWgskQ5SjajqhoWq2zD6RXjefzGNIdg
 6P3I99FVE85G9b5qthJd6/qd7eXWFIWUuQ9F3RTWj1Upa3BNqgf/aZnmIACoxWTXn4Ee
 ef2Hx5R2TTcFvvWL0voB1Tv/iqbMaNip2D01ufGL8MgjsOv/eiQ/cl8GHWOFIsuV7MzN
 SuAg==
X-Gm-Message-State: AOJu0YzjAu7mKZJ8oI6bvJ7IUkSxkmsOMliZtVtsvGkV5/BLN4LAwXU0
 g5y1z98eMDWpIqbaQELHA6mn6j+pw7EFRM/e6hPQg8ZQA8a6oiiS3aCY8CeXFJtffdjHV4Y34vU
 bFgbwRGkppJkqDCCy0UXrTK+fliq7R3er5H3m0oRCfM8RffhAeIoquWDQBL4TVGJCt/Z3Y0WWud
 JZobtgN3zMOQIYxDcgQUagFS2WNRvW+2umsIOAh0lt
X-Gm-Gg: ASbGnctiopAhLzjChc+NYW0CHoCNd6BYj0edolw5vdvi4dOZK4xS6ipjAX2TWPTEpRN
 316PAt/f05KwlTinudxJpQIMWCx8dKjhRw3Qi8YfCRe1BWb6ASsHV14tOXgetPwpnxR2IoH0wUJ
 pNxgHTp9e7/YSmRj6TAcJaqvqSwBcoUYTAZz4K9y7AkP2xLiYR5c7dbbvtpuUeTst54fC4eH+Lo
 Bo86C7lEndnGTgOAcICaZv29mhTywb2/qy7oAcE1ESMN80DponE/kKDj8hf36sGpkajIZIQlpCS
 a8ZPxxXmj9JOFoyc9H3YgxEJKVAyWG8S6XNWlgAxg34k/j5MYCqtYBOHniqpjGbchu25dg2ZJ7n
 CKzRappiVnnbCx03ermC6hALAp/4LWZZ6y7IKyjeq8Ht+SmBMDk73fuBeycoEOttuLKYJUld+Zl
 N1ynWG
X-Received: by 2002:a05:6000:26c3:b0:42b:5448:7ae8 with SMTP id
 ffacd0b85a97d-42b59372315mr10909489f8f.29.1763365372771; 
 Sun, 16 Nov 2025 23:42:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnIN/NNJVK3bNuBHUK3xJ4h2qsSBtlJJIi+oqggakdn0dlueBMskOY27cwQbEtC5ckGivvQw==
X-Received: by 2002:a05:6000:26c3:b0:42b:5448:7ae8 with SMTP id
 ffacd0b85a97d-42b59372315mr10909469f8f.29.1763365372346; 
 Sun, 16 Nov 2025 23:42:52 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85e6fsm25033505f8f.18.2025.11.16.23.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 23:42:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/8] chardev: add prelude
Date: Mon, 17 Nov 2025 08:42:35 +0100
Message-ID: <20251117074239.190424-6-pbonzini@redhat.com>
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
index 36ada7c4546..d89baba8e20 100644
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
2.51.1


