Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2286BCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSU-000669-AK; Mon, 08 Sep 2025 06:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSO-00064G-SE
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZS8-0005z3-Op
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI1XhBWNIHRUVnlu/wwcs/sxgPv11l5+fgbf0HE5qR0=;
 b=ENsXjuzgyaSzaQrJIPhz01Y/NzL1dTnZdwxnPkhJSbMC5ojB58W9A8ymWGttzxJm2SPF2m
 YVmH6ORSdozMn6fpsORAnAAvbyjIQ5VyIUz5iJjFZOHu3Ec7B0U/4bDAZX+qfSEatFOTFH
 FPQRhvGdtaNxlCYCg+g9b+8ZCp1zy/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Z7R2csb0PBSS1uClpPOt4Q-1; Mon, 08 Sep 2025 06:50:18 -0400
X-MC-Unique: Z7R2csb0PBSS1uClpPOt4Q-1
X-Mimecast-MFC-AGG-ID: Z7R2csb0PBSS1uClpPOt4Q_1757328616
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e1260394dcso2165836f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328615; x=1757933415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fI1XhBWNIHRUVnlu/wwcs/sxgPv11l5+fgbf0HE5qR0=;
 b=mRSwVVCvXUI5NBjkpdBlxyiTjBere09/a16eo+hHY65w4/vvn3OjdyQZfW0VaHmvsg
 U4ZjNkCzAf6T1Q6OwHxwAGeQNvUHOhDuSGBAecFShkt2WocybwB/KFz3cycSQFi4Ryk0
 k9OEoC8wDmVo1PCQSH6/c1Q74UIl0+379llQr87ECw12GPvgSGTdTDHGU8ME+0rBedAR
 DJM5nIPkmp4a5bnOLZUV7Th+DuFg4rO4CQHVSgoKxhb2oKqCY7X8jqy6qXkYpPI10PCP
 loCtaeGksr3GAZCzG8JxItqnPfhirA1Nkr7RE0B7DiUu+jySBulAylLpOTza3V2iIyxy
 zpQw==
X-Gm-Message-State: AOJu0YwP1ml9hE3tzNw7emamEEx47qkrkxE1O81Eo2CBWARMl6B0vRKa
 h2oOdVvadjImO9BGEfFGj7neJUVIb/3+A0RIFplaqY0e4P0jjDI9RPrF76ib2QtkhJnX82j2Opc
 P3NuYtN0Nt+fpWqBqID23qiX9TMo8ONbD2CLBaJF34gz8fR9jQ0cfE4YNaMDQKlD6SPRd+2ZrC5
 adBBDvwwcsijZi5A2FW+Cw3G4l3YRwWOifgb6CPK8K
X-Gm-Gg: ASbGncuw5PP0ITfFyInaZWnNIPmS/SHxpNv6ri2OFlXq0oGn6GZq6oaT/K3nscpSBlN
 h5mbV7wq/E1gEEtWJ4zt7dH/yXWMwR5jW3WhyVZoX1OHHzKk+dLzrai6J6H7hz7BQJuqeSAyWMf
 zPpM3c/zSO1bc5DwNOCOSS3DMsLF7e5JZATvM/0acbSdfgpplv1MtGlyXA3eYgSmq3PKDaU+ace
 N3/eVoacPX0mVuaq0ZY5oe+fngDmlnCJEGI2dfK4f0WpOjK6DFLN8KRlwRTZ+iNDaASFclrLfMt
 uCcDX8PCxz8GOCdjrBGq1NU35aeN7V4FAV2tRXqnzU5UfUNoLHuqDeyBvEMNnBex+hlqQ5T+EqP
 PzNhMAXl3mPLk3n0rL0orCYa9AlgVOhbUlmYZjWQpT3w=
X-Received: by 2002:a05:6000:40c9:b0:3e5:4ad:2b38 with SMTP id
 ffacd0b85a97d-3e642309230mr4334448f8f.9.1757328615551; 
 Mon, 08 Sep 2025 03:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBIHIzNIveWykpOKQT3gRJv+7FFTWv/DDyKBhKft+mcfpTwu4cx+nbdbEw/hf3xm2ysFtLbA==
X-Received: by 2002:a05:6000:40c9:b0:3e5:4ad:2b38 with SMTP id
 ffacd0b85a97d-3e642309230mr4334412f8f.9.1757328614975; 
 Mon, 08 Sep 2025 03:50:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45deab47e5dsm9890975e9.2.2025.09.08.03.50.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/33] meson, cargo: require Rust 1.83.0
Date: Mon,  8 Sep 2025 12:49:35 +0200
Message-ID: <20250908105005.2119297-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 docs/devel/rust.rst | 14 +++++---------
 meson.build         |  6 +++---
 clippy.toml         |  2 +-
 rust/Cargo.toml     |  2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index b6737536c69..e0ee4a9837d 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -75,21 +75,17 @@ Note that doctests require all ``.o`` files from the build to be available.
 Supported tools
 '''''''''''''''
 
-QEMU supports rustc version 1.77.0 and newer.  Notably, the following features
-are missing:
+QEMU supports rustc version 1.83.0 and newer.  The following features
+from relatively new versions of Rust are not used for historical reasons;
+patches are welcome:
 
 * inline const expression (stable in 1.79.0), currently worked around with
   associated constants in the ``FnCall`` trait.
 
-* associated constants have to be explicitly marked ``'static`` (`changed in
+* associated constants are still explicitly marked ``'static`` (`changed in
   1.81.0`__)
 
-* ``&raw`` (stable in 1.82.0).  Use ``addr_of!`` and ``addr_of_mut!`` instead,
-  though hopefully the need for raw pointers will go down over time.
-
-* ``new_uninit`` (stable in 1.82.0).  This is used internally by the ``pinned_init``
-  crate, which is planned for inclusion in QEMU, but it can be easily patched
-  out.
+* ``&raw`` (stable in 1.82.0).
 
 * referencing statics in constants (stable in 1.83.0).  For now use a const
   function; this is an important limitation for QEMU's migration stream
diff --git a/meson.build b/meson.build
index fa6186db334..ef3f52b951d 100644
--- a/meson.build
+++ b/meson.build
@@ -94,12 +94,12 @@ have_rust = have_rust and add_languages('rust', native: true,
     required: get_option('rust').disable_auto_if(not have_system))
 if have_rust
   rustc = meson.get_compiler('rust')
-  if rustc.version().version_compare('<1.77.0')
+  if rustc.version().version_compare('<1.83.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.77.0')
+      error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.83.0')
     else
       warning('rustc version ' + rustc.version() + ' is unsupported, disabling Rust compilation.')
-      message('Please upgrade to at least 1.77.0 to use Rust.')
+      message('Please upgrade to at least 1.83.0 to use Rust.')
       have_rust = false
     endif
   endif
diff --git a/clippy.toml b/clippy.toml
index 90161729838..204f5713c00 100644
--- a/clippy.toml
+++ b/clippy.toml
@@ -1,3 +1,3 @@
 doc-valid-idents = ["IrDA", "PrimeCell", ".."]
 allow-mixed-uninlined-format-args = false
-msrv = "1.77.0"
+msrv = "1.83.0"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 6f8884eb30b..99c275f2d9f 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -13,7 +13,7 @@ edition = "2021"
 homepage = "https://www.qemu.org"
 license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
-rust-version = "1.77.0"
+rust-version = "1.83.0"
 
 [workspace.dependencies]
 anyhow = "~1.0"
-- 
2.51.0


