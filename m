Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3C9D2169C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRW-0002AJ-T7; Tue, 15 Oct 2024 09:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRW-0002A5-5a
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRU-0001Pd-Mh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7x7nS4Xh6lw88VcJcF60YqjvT0tzg3gAq71y1ldvMM8=;
 b=TIvOlI4kSVU0ASX0zNAuxw4Fa+QJdWEg+FDgfxNxSy3ns+Cwe2O0Pkgaei0fFXsP/T482g
 LlLjr9B+ZhgVcI7JQFDFV4SlD5PVrfH7TNoeDUfhfnnPyrytxjmAFX9nfkcLsbe4Ks+I4t
 3R7kzBJgMuBSEbqGt21g9sHBd8YB0Nw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-n6KMFbOtPqaZ2UDScpayRg-1; Tue, 15 Oct 2024 09:18:26 -0400
X-MC-Unique: n6KMFbOtPqaZ2UDScpayRg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4af408dcso2209726f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998305; x=1729603105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7x7nS4Xh6lw88VcJcF60YqjvT0tzg3gAq71y1ldvMM8=;
 b=ajox/wPVKKKSGMQH0iFM2s/5H6ji0WpNkt09sdBHj6qqRBnRKd0DRpLWDHlIzhpNFA
 C6eH2Nsn2Jqw1PsOK6kmJDPXpJx7EJKDmvq45MUo9RkwLGqrB0KHOE7liUhHfr9nTYm+
 cdWO7HT7nnU7LZrl/+tIXLjM4EvQotUyZsNnYkA4mglUAJ92CINrd8JeWGQuLSeq8jSe
 Yuv3d5nUm11Rb+dY8RLNw01YRZEVeUMW7aIqF1Oq4z8LYWTYY+seHLGItGgqGl1rYbjJ
 0XBnSWEhLYwj5PIj7caqJQf0/AosGMUmg7H15p2Mx1llBb/i94DF74ZWusodeZ+5Cs7B
 pCtg==
X-Gm-Message-State: AOJu0YzutlPbmY8pEp/Uy5AqG5mUe9x/KWGmEj3H3nC5r+8po3Mjfkp0
 BOVM6iBCSs21Rrtjj5aER/cfRkNNwwmEGU8x/LxVAsEXZ3o2EXAXaK7Qj2laIfAAu4EGcJy5/Z0
 cCeS8d0tTuIy0QUC7AyK3fuxRArYjBobcNY5S8fGCXVKt5DnWxh7UCebcCgqZgAhbYIsCOhy3sT
 TOl0X7u+Y4RYAuQKJx6z85vj/Q7tuPSSA8+Sn5EFg=
X-Received: by 2002:a5d:5051:0:b0:37d:4fab:c194 with SMTP id
 ffacd0b85a97d-37d86bd59b0mr179247f8f.25.1728998305098; 
 Tue, 15 Oct 2024 06:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUPYyOliZu+SnSEXEgyGHGOQ2YnYJ97rxHKe0rzJMmnHNpaZDACcfVpC2WNzaPFfQa2MRXGg==
X-Received: by 2002:a5d:5051:0:b0:37d:4fab:c194 with SMTP id
 ffacd0b85a97d-37d86bd59b0mr179230f8f.25.1728998304498; 
 Tue, 15 Oct 2024 06:18:24 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa92741sm1576533f8f.60.2024.10.15.06.18.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] rust: do not use --generate-cstr
Date: Tue, 15 Oct 2024 15:17:33 +0200
Message-ID: <20241015131735.518771-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--generate-cstr is a good idea and generally the right thing to do,
but it is not available in Debian 12 and Ubuntu 22.04.  Work around
the absence.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       | 4 +++-
 rust/hw/char/pl011/src/device.rs  | 1 +
 rust/qemu-api/src/device_class.rs | 8 +++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 3b35fcb3feb..e08f226ee8a 100644
--- a/meson.build
+++ b/meson.build
@@ -3920,13 +3920,15 @@ common_all =3D static_library('common',
                             dependencies: common_ss.all_dependencies())
=20
 if have_rust and have_system
+  # We would like to use --generate-cstr, but it is only available
+  # starting with bindgen 0.66.0.  The oldest supported versions
+  # are in Ubuntu 22.04 (0.59.1) and Debian 12 (0.60.1).
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
     '--ctypes-prefix', 'std::os::raw',
     '--formatter', 'rustfmt',
     '--generate-block',
-    '--generate-cstr',
     '--impl-debug',
     '--merge-extern-blocks',
     '--no-doc-comments',
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index ca67d452e7e..ec82a2619f2 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,6 +13,7 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
+    device_class::TYPE_SYS_BUS_DEVICE,
     with_offsets,
 };
=20
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index d2535125c48..f4eec2f748a 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,7 +2,9 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use crate::bindings::Property;
+use std::ffi::CStr;
+
+use crate::bindings::{self, Property};
=20
 #[macro_export]
 macro_rules! device_class_init {
@@ -129,3 +131,7 @@ macro_rules! vm_state_description {
         };
     }
 }
+
+// workaround until we can use --generate-cstr in bindgen.
+pub const TYPE_SYS_BUS_DEVICE: &CStr =3D
+    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DE=
VICE) };
--=20
2.46.2


