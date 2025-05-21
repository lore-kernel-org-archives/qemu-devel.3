Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91029C54E92
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHefQ-0004pl-9W; Wed, 21 May 2025 04:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefI-0004n9-Ti
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefA-0000AQ-UK
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkexbcE3Ct1IaeE/EpP007cd4zT7zhozCvcoCpvD4Pg=;
 b=ajrgAU3rXuVv6QZIPExy002rtkYgfUE3sSNMvdUloSrJ/IT+C1XmkxJcGDKp8IV9LPSaA0
 clmHz8zm6oaxOzn4VWYCgwILjGstwq3/E7jVrWB/8aGwv7/XvJptedFfcC9GgWsKWozbSh
 1wAN07Hl+gQ/sJIZhSRjs+ZKAtKkhCI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-phUuMzNYPa65FUS0MKI7NQ-1; Wed, 21 May 2025 04:18:53 -0400
X-MC-Unique: phUuMzNYPa65FUS0MKI7NQ-1
X-Mimecast-MFC-AGG-ID: phUuMzNYPa65FUS0MKI7NQ_1747815533
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so31120065e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815532; x=1748420332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkexbcE3Ct1IaeE/EpP007cd4zT7zhozCvcoCpvD4Pg=;
 b=TPCxL4QbaxFUU4e0SY/K7AOdYcvSPzY0fLh4vX+LOXskiALUrMHmDrz4/sgLNY1EA3
 Akrlbmai+Up9a4sf9KjDkziooIj3/dKN/oBPNBKzMIn/aZuHXZE5eyvRTOsgjhyEQSXT
 IyXuLt4qFikMR+wVbJB7UU+0bTpzNBRnfGqItgZ0iCTKhrLR5UBQiFjwYgeIZ17ZwY6P
 vxGu+mGCgNi6074I7hCkD0AFo4iyKWKIhlsbI2spOZFOCcgzYDFRN9r5DofqCVrj7zIZ
 4RqXkwjX3ltD2MkM6PQBop9f8vBSVIhVFGW1G6nvC1HJBNKLKGu2tnQBOYAAMJfzc4Qn
 oF7A==
X-Gm-Message-State: AOJu0YwsEAxYO36fUCR1W+7QtIAo5jYcRmVqohP234IV5mWgbnVZzIx/
 FHNQ2rhHQXjMbyePhnWIjKEpwLqt8pISACSDMc++1hvy/Lank+UlqS6Kzf8Pi5oglD8q82g/sg1
 wJRUp28WV4VEjHfBvHAWBqZm9KqQEnb8Jigge4P1K9h5lKVSreOlmN19xp/QYwQmWnxDUvcGGH9
 EnFZpxDCMqwjKVVEVZBQE8YqSe6FqGsp9fm4qnVb74
X-Gm-Gg: ASbGncu7NwmURWPpuKecWfZ53ampGbgKI3+fkDWB4+qLlD4yqKOmc5mGE+SgUiRl1IH
 P634oFXAvp6Ui1WuohUqYqa9PoGbZPoRhJXKadnS9z5If34ZSei7pR9M8FtXmTA7pgWuxwAG1sv
 JXY4Hcxgel7bfQz0eRCmyy11hMsAcKjjMjNnepb4Kbez/+GpqftaYbvxzskxYMt6LguESLUZgMj
 Vz1oKzib/ExT1ysWCtMjB8O4krQTPTSysLdllKN1h6OnaieQ9yVKtW5NzakbfoQ+VYvoIxAp93n
 pYMhw+9HPlrZ/A==
X-Received: by 2002:a05:600c:3114:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-442fd6444c4mr214127605e9.15.1747815531489; 
 Wed, 21 May 2025 01:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/6nUcZiSuErZZc0W8D31IsWShGhVm8gljvv4BgZ09FIQ2PpzOCUXmO6iBT4qu92wcz3A2WA==
X-Received: by 2002:a05:600c:3114:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-442fd6444c4mr214127045e9.15.1747815530838; 
 Wed, 21 May 2025 01:18:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a362997dc8sm17276234f8f.46.2025.05.21.01.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:18:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 1/6] rust: add "bits", a custom bitflags implementation
Date: Wed, 21 May 2025 10:18:40 +0200
Message-ID: <20250521081845.496442-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521081845.496442-1-pbonzini@redhat.com>
References: <20250521081845.496442-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

One common thing that device emulation does is manipulate bitmasks, for example
to check whether two bitmaps have common bits.  One example in the pl011 crate
is the checks for pending interrupts, where an interrupt cause corresponds to
at least one interrupt source from a fixed set.

Unfortunately, this is one case where Rust *can* provide some kind of
abstraction but it does so with a rather Perl-ish There Is More Way To
Do It.  It is not something where a crate like "bilge" helps, because
it only covers the packing of bits in a structure; operations like "are
all bits of Y set in X" almost never make sense for bit-packed structs;
you need something else, there are several crates that do it and of course
we're going to roll our own.

In particular I examined three:

- bitmask (https://docs.rs/bitmask/0.5.0/bitmask/) does not support const
  at all.  This is a showstopper because one of the ugly things in the
  current pl011 code is the ugliness of code that defines interrupt masks
  at compile time:

    pub const E: Self = Self(Self::OE.0 | Self::BE.0 | Self::PE.0 | Self::FE.0);

  or even worse:

    const IRQMASK: [u32; 6] = [
      Interrupt::E.0 | Interrupt::MS.0 | Interrupt::RT.0 | Interrupt::TX.0 | Interrupt::RX.0,
      ...
    }

  You would have to use roughly the same code---"bitmask" only helps with
  defining the struct.

- bitmask_enum (https://docs.rs/bitmask-enum/2.2.5/bitmask_enum/) does not
  have a good separation of "valid" and "invalid" bits, so for example "!x"
  will invert all 16 bits if you choose u16 as the representation -- even if
  you only defined 10 bits.  This makes it easier to introduce subtle bugs
  in comparisons.

- bitflags (https://docs.rs/bitflags/2.6.0/bitflags/) is generally the most
  used such crate and is the one that I took most inspiration from with
  respect to the syntax.  It's a pretty sophisticated implementation,
  with a lot of bells and whistles such as an implementation of "Iter"
  that returns the bits one at a time.

The main thing that all of them lack, however, is a way to simplify the
ugly definitions like the above.  "bitflags" includes const methods that
perform AND/OR/XOR of masks (these are necessary because Rust operator
overloading does not support const yet, and therefore overloaded operators
cannot be used in the definition of a "static" variable), but they become
even more verbose and unmanageable, like

  Interrupt::E.union(Interrupt::MS).union(Interrupt::RT).union(Interrupt::TX).union(Interrupt::RX)

This was the main reason to create "bits", which allows something like

  bits!(Interrupt: E | MS | RT | TX | RX)

and expands it 1) add "Interrupt::" in front of all identifiers 2) convert
operators to the wordy const functions like "union".  It supports boolean
operators "&", "|", "^", "!" and parentheses, with a relatively simple
recursive descent parser that's implemented in qemu_api_macros.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                  |   7 +
 rust/Cargo.toml                  |   1 +
 rust/bits/Cargo.toml             |  19 ++
 rust/bits/meson.build            |  12 +
 rust/bits/src/lib.rs             | 441 +++++++++++++++++++++++++++++++
 rust/meson.build                 |   1 +
 rust/qemu-api-macros/src/bits.rs | 227 ++++++++++++++++
 rust/qemu-api-macros/src/lib.rs  |  12 +
 8 files changed, 720 insertions(+)
 create mode 100644 rust/bits/Cargo.toml
 create mode 100644 rust/bits/meson.build
 create mode 100644 rust/bits/src/lib.rs
 create mode 100644 rust/qemu-api-macros/src/bits.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 13d580c693b..0dfe0fb6ced 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -31,6 +31,13 @@ dependencies = [
  "syn",
 ]
 
+[[package]]
+name = "bits"
+version = "0.1.0"
+dependencies = [
+ "qemu_api_macros",
+]
+
 [[package]]
 name = "either"
 version = "1.12.0"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index d9faeecb10b..165328b6d01 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -1,6 +1,7 @@
 [workspace]
 resolver = "2"
 members = [
+    "bits",
     "qemu-api-macros",
     "qemu-api",
     "hw/char/pl011",
diff --git a/rust/bits/Cargo.toml b/rust/bits/Cargo.toml
new file mode 100644
index 00000000000..1ff38a41175
--- /dev/null
+++ b/rust/bits/Cargo.toml
@@ -0,0 +1,19 @@
+[package]
+name = "bits"
+version = "0.1.0"
+authors = ["Paolo Bonzini <pbonzini@redhat.com>"]
+description = "const-friendly bit flags"
+resolver = "2"
+publish = false
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[dependencies]
+qemu_api_macros = { path = "../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/bits/meson.build b/rust/bits/meson.build
new file mode 100644
index 00000000000..2cd4121a546
--- /dev/null
+++ b/rust/bits/meson.build
@@ -0,0 +1,12 @@
+_bits_rs = static_library(
+  'bits',
+  'src/lib.rs',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [qemu_api_macros],
+)
+
+bits_rs = declare_dependency(link_with: _bits_rs)
+
+rust.test('rust-bits-tests', _bits_rs,
+          suite: ['unit', 'rust'])
diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
new file mode 100644
index 00000000000..d80a6263f1e
--- /dev/null
+++ b/rust/bits/src/lib.rs
@@ -0,0 +1,441 @@
+/// # Definition entry point
+///
+/// Define a struct with a single field of type $type.  Include public constants
+/// for each element listed in braces.
+///
+/// The unnamed element at the end, if present, can be used to enlarge the set
+/// of valid bits.  Bits that are valid but not listed are treated normally for
+/// the purpose of arithmetic operations, and are printed with their hexadecimal
+/// value.
+///
+/// The struct implements the following traits: [`BitAnd`](std::ops::BitAnd),
+/// [`BitOr`](std::ops::BitOr), [`BitXor`](std::ops::BitXor),
+/// [`Not`](std::ops::Not), [`Sub`](std::ops::Sub); [`Debug`](std::fmt::Debug),
+/// [`Display`](std::fmt::Display), [`Binary`](std::fmt::Binary),
+/// [`Octal`](std::fmt::Octal), [`LowerHex`](std::fmt::LowerHex),
+/// [`UpperHex`](std::fmt::UpperHex); [`From`]`<type>`/[`Into`]`<type>` where
+/// type is the type specified in the definition.
+///
+/// ## Example
+///
+/// ```
+/// # use bits::bits;
+/// bits! {
+///     pub struct Colors(u8) {
+///         BLACK = 0,
+///         RED = 1,
+///         GREEN = 1 << 1,
+///         BLUE = 1 << 2,
+///         WHITE = (1 << 0) | (1 << 1) | (1 << 2),
+///     }
+/// }
+/// ```
+///
+/// ```
+/// # use bits::bits;
+/// # bits! { pub struct Colors(u8) { BLACK = 0, RED = 1, GREEN = 1 << 1, BLUE = 1 << 2, } }
+///
+/// bits! {
+///     pub struct Colors8(u8) {
+///         BLACK = 0,
+///         RED = 1,
+///         GREEN = 1 << 1,
+///         BLUE = 1 << 2,
+///         WHITE = (1 << 0) | (1 << 1) | (1 << 2),
+///
+///         _ = 255,
+///     }
+/// }
+///
+/// // The previously defined struct ignores bits not explicitly defined.
+/// assert_eq!(
+///     Colors::from(255).into_bits(),
+///     (Colors::RED | Colors::GREEN | Colors::BLUE).into_bits()
+/// );
+///
+/// // Adding "_ = 255" makes it retain other bits as well.
+/// assert_eq!(Colors8::from(255).into_bits(), 255);
+///
+/// // all() does not include the additional bits, valid_bits() does
+/// assert_eq!(Colors8::all().into_bits(), Colors::all().into_bits());
+/// assert_eq!(Colors8::valid_bits().into_bits(), 255);
+/// ```
+///
+/// # Evaluation entry point
+///
+/// Return a constant corresponding to the boolean expression `$expr`.
+/// Identifiers in the expression correspond to values defined for the
+/// type `$type`.  Supported operators are `!` (unary), `-`, `&`, `^`, `|`.
+///
+/// ## Examples
+///
+/// ```
+/// # use bits::bits;
+/// bits! {
+///     pub struct Colors(u8) {
+///         BLACK = 0,
+///         RED = 1,
+///         GREEN = 1 << 1,
+///         BLUE = 1 << 2,
+///         // same as "WHITE = 7",
+///         WHITE = bits!(Self as u8: RED | GREEN | BLUE),
+///     }
+/// }
+///
+/// let rgb = bits! { Colors: RED | GREEN | BLUE };
+/// assert_eq!(rgb, Colors::WHITE);
+/// ```
+#[macro_export]
+macro_rules! bits {
+    {
+        $(#[$struct_meta:meta])*
+        $struct_vis:vis struct $struct_name:ident($field_vis:vis $type:ty) {
+            $($(#[$const_meta:meta])* $const:ident = $val:expr),+
+            $(,_ = $mask:expr)?
+            $(,)?
+        }
+    } => {
+        $(#[$struct_meta])*
+        #[derive(Clone, Copy, PartialEq, Eq)]
+        #[repr(transparent)]
+        $struct_vis struct $struct_name($field_vis $type);
+
+        impl $struct_name {
+            $( #[allow(dead_code)] $(#[$const_meta])*
+                pub const $const: $struct_name = $struct_name($val); )+
+
+            #[doc(hidden)]
+            const VALID__: $type = $( Self::$const.0 )|+ $(|$mask)?;
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn empty() -> Self {
+                Self(0)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn all() -> Self {
+                Self($( Self::$const.0 )|+)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn valid_bits() -> Self {
+                Self(Self::VALID__)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn valid(val: $type) -> bool {
+                (val & !Self::VALID__) == 0
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn any_set(self, mask: Self) -> bool {
+                (self.0 & mask.0) != 0
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn all_set(self, mask: Self) -> bool {
+                (self.0 & mask.0) == mask.0
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn none_set(self, mask: Self) -> bool {
+                (self.0 & mask.0) == 0
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn from_bits(value: $type) -> Self {
+                $struct_name(value)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn into_bits(self) -> $type {
+                self.0
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub fn set(&mut self, rhs: Self) {
+                self.0 |= rhs.0;
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub fn clear(&mut self, rhs: Self) {
+                self.0 &= !rhs.0;
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub fn toggle(&mut self, rhs: Self) {
+                self.0 ^= rhs.0;
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn intersection(self, rhs: Self) -> Self {
+                $struct_name(self.0 & rhs.0)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn difference(self, rhs: Self) -> Self {
+                $struct_name(self.0 & !rhs.0)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn symmetric_difference(self, rhs: Self) -> Self {
+                $struct_name(self.0 ^ rhs.0)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn union(self, rhs: Self) -> Self {
+                $struct_name(self.0 | rhs.0)
+            }
+
+            #[allow(dead_code)]
+            #[inline(always)]
+            pub const fn invert(self) -> Self {
+                $struct_name(self.0 ^ Self::VALID__)
+            }
+        }
+
+        impl ::std::fmt::Binary for $struct_name {
+            fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
+                // If no width, use the highest valid bit
+                let width = f.width().unwrap_or((Self::VALID__.ilog2() + 1) as usize);
+                write!(f, "{:0>width$.precision$b}", self.0,
+                       width = width,
+                       precision = f.precision().unwrap_or(width))
+            }
+        }
+
+        impl ::std::fmt::LowerHex for $struct_name {
+            fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
+                <$type as ::std::fmt::LowerHex>::fmt(&self.0, f)
+            }
+        }
+
+        impl ::std::fmt::Octal for $struct_name {
+            fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
+                <$type as ::std::fmt::Octal>::fmt(&self.0, f)
+            }
+        }
+
+        impl ::std::fmt::UpperHex for $struct_name {
+            fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
+                <$type as ::std::fmt::UpperHex>::fmt(&self.0, f)
+            }
+        }
+
+        impl ::std::fmt::Debug for $struct_name {
+            fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
+                write!(f, "{}({})", stringify!($struct_name), self)
+            }
+        }
+
+        impl ::std::fmt::Display for $struct_name {
+            fn fmt(&self, f: &mut ::std::fmt::Formatter<'_>) -> ::std::fmt::Result {
+                use ::std::fmt::Display;
+                let mut first = true;
+                let mut left = self.0;
+                $(if Self::$const.0.is_power_of_two() && (self & Self::$const).0 != 0 {
+                    if first { first = false } else { Display::fmt(&'|', f)?; }
+                    Display::fmt(stringify!($const), f)?;
+                    left -= Self::$const.0;
+                })+
+                if first {
+                    Display::fmt(&'0', f)
+                } else if left != 0 {
+                    write!(f, "|{left:#x}")
+                } else {
+                    Ok(())
+                }
+            }
+        }
+
+        impl ::std::cmp::PartialEq<$type> for $struct_name {
+            fn eq(&self, rhs: &$type) -> bool {
+                self.0 == *rhs
+            }
+        }
+
+        impl ::std::ops::BitAnd<$struct_name> for &$struct_name {
+            type Output = $struct_name;
+            fn bitand(self, rhs: $struct_name) -> Self::Output {
+                $struct_name(self.0 & rhs.0)
+            }
+        }
+
+        impl ::std::ops::BitAndAssign<$struct_name> for $struct_name {
+            fn bitand_assign(&mut self, rhs: $struct_name) {
+                self.0 = self.0 & rhs.0
+            }
+        }
+
+        impl ::std::ops::BitXor<$struct_name> for &$struct_name {
+            type Output = $struct_name;
+            fn bitxor(self, rhs: $struct_name) -> Self::Output {
+                $struct_name(self.0 ^ rhs.0)
+            }
+        }
+
+        impl ::std::ops::BitXorAssign<$struct_name> for $struct_name {
+            fn bitxor_assign(&mut self, rhs: $struct_name) {
+                self.0 = self.0 ^ rhs.0
+            }
+        }
+
+        impl ::std::ops::BitOr<$struct_name> for &$struct_name {
+            type Output = $struct_name;
+            fn bitor(self, rhs: $struct_name) -> Self::Output {
+                $struct_name(self.0 | rhs.0)
+            }
+        }
+
+        impl ::std::ops::BitOrAssign<$struct_name> for $struct_name {
+            fn bitor_assign(&mut self, rhs: $struct_name) {
+                self.0 = self.0 | rhs.0
+            }
+        }
+
+        impl ::std::ops::Sub<$struct_name> for &$struct_name {
+            type Output = $struct_name;
+            fn sub(self, rhs: $struct_name) -> Self::Output {
+                $struct_name(self.0 & !rhs.0)
+            }
+        }
+
+        impl ::std::ops::SubAssign<$struct_name> for $struct_name {
+            fn sub_assign(&mut self, rhs: $struct_name) {
+                self.0 = self.0 - rhs.0
+            }
+        }
+
+        impl ::std::ops::Not for &$struct_name {
+            type Output = $struct_name;
+            fn not(self) -> Self::Output {
+                $struct_name(self.0 ^ $struct_name::VALID__)
+            }
+        }
+
+        impl ::std::ops::BitAnd<$struct_name> for $struct_name {
+            type Output = Self;
+            fn bitand(self, rhs: Self) -> Self::Output {
+                $struct_name(self.0 & rhs.0)
+            }
+        }
+
+        impl ::std::ops::BitXor<$struct_name> for $struct_name {
+            type Output = Self;
+            fn bitxor(self, rhs: Self) -> Self::Output {
+                $struct_name(self.0 ^ rhs.0)
+            }
+        }
+
+        impl ::std::ops::BitOr<$struct_name> for $struct_name {
+            type Output = Self;
+            fn bitor(self, rhs: Self) -> Self::Output {
+                $struct_name(self.0 | rhs.0)
+            }
+        }
+
+        impl ::std::ops::Sub<$struct_name> for $struct_name {
+            type Output = Self;
+            fn sub(self, rhs: Self) -> Self::Output {
+                $struct_name(self.0 & !rhs.0)
+            }
+        }
+
+        impl ::std::ops::Not for $struct_name {
+            type Output = Self;
+            fn not(self) -> Self::Output {
+                $struct_name(self.0 ^ Self::VALID__)
+            }
+        }
+
+        impl From<$struct_name> for $type {
+            fn from(x: $struct_name) -> $type {
+                x.0
+            }
+        }
+
+        impl From<$type> for $struct_name {
+            fn from(x: $type) -> Self {
+                $struct_name(x & Self::VALID__)
+            }
+        }
+    };
+
+    { $type:ty: $expr:expr } => {
+        ::qemu_api_macros::bits_const_internal! { $type @ ($expr) }
+    };
+
+    { $type:ty as $int_type:ty: $expr:expr } => {
+        (::qemu_api_macros::bits_const_internal! { $type @ ($expr) }.into_bits()) as $int_type
+    };
+}
+
+#[cfg(test)]
+mod test {
+    bits! {
+        pub(crate) struct InterruptMask(u32) {
+            OE = 1 << 10,
+            BE = 1 << 9,
+            PE = 1 << 8,
+            FE = 1 << 7,
+            RT = 1 << 6,
+            TX = 1 << 5,
+            RX = 1 << 4,
+            DSR = 1 << 3,
+            DCD = 1 << 2,
+            CTS = 1 << 1,
+            RI = 1 << 0,
+
+            E = bits!(Self as u32: OE | BE | PE | FE),
+            MS = bits!(Self as u32: RI | DSR | DCD | CTS),
+        }
+    }
+
+    #[test]
+    pub fn test_not() {
+        assert_eq!(
+            !InterruptMask::from(InterruptMask::RT),
+            InterruptMask::E | InterruptMask::MS | InterruptMask::TX | InterruptMask::RX
+        );
+    }
+
+    #[test]
+    pub fn test_and() {
+        assert_eq!(
+            InterruptMask::from(0),
+            InterruptMask::MS & InterruptMask::OE
+        )
+    }
+
+    #[test]
+    pub fn test_or() {
+        assert_eq!(
+            InterruptMask::E,
+            InterruptMask::OE | InterruptMask::BE | InterruptMask::PE | InterruptMask::FE
+        );
+    }
+
+    #[test]
+    pub fn test_xor() {
+        assert_eq!(
+            InterruptMask::E ^ InterruptMask::BE,
+            InterruptMask::OE | InterruptMask::PE | InterruptMask::FE
+        );
+    }
+}
diff --git a/rust/meson.build b/rust/meson.build
index 91e52b8fb8e..f370b0ec939 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1,4 +1,5 @@
 subdir('qemu-api-macros')
+subdir('bits')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/qemu-api-macros/src/bits.rs b/rust/qemu-api-macros/src/bits.rs
new file mode 100644
index 00000000000..b6e07d4e890
--- /dev/null
+++ b/rust/qemu-api-macros/src/bits.rs
@@ -0,0 +1,227 @@
+// shadowing is useful together with "if let"
+#![allow(clippy::shadow_unrelated)]
+
+use proc_macro2::{
+    Delimiter, Group, Ident, Punct, Spacing, Span, TokenStream, TokenTree, TokenTree as TT,
+};
+
+use crate::utils::MacroError;
+
+pub struct BitsConstInternal {
+    typ: TokenTree,
+}
+
+fn paren(ts: TokenStream) -> TokenTree {
+    TT::Group(Group::new(Delimiter::Parenthesis, ts))
+}
+
+fn ident(s: &'static str) -> TokenTree {
+    TT::Ident(Ident::new(s, Span::call_site()))
+}
+
+fn punct(ch: char) -> TokenTree {
+    TT::Punct(Punct::new(ch, Spacing::Alone))
+}
+
+/// Implements a recursive-descent parser that translates Boolean expressions on
+/// bitmasks to invocations of `const` functions defined by the `bits!` macro.
+impl BitsConstInternal {
+    // primary ::= '(' or ')'
+    //           | ident
+    //           | '!' ident
+    fn parse_primary(
+        &self,
+        tok: TokenTree,
+        it: &mut dyn Iterator<Item = TokenTree>,
+        out: &mut TokenStream,
+    ) -> Result<Option<TokenTree>, MacroError> {
+        let next = match tok {
+            TT::Group(ref g) => {
+                if g.delimiter() != Delimiter::Parenthesis && g.delimiter() != Delimiter::None {
+                    return Err(MacroError::Message("expected parenthesis".into(), g.span()));
+                }
+                let mut stream = g.stream().into_iter();
+                let Some(first_tok) = stream.next() else {
+                    return Err(MacroError::Message(
+                        "expected operand, found ')'".into(),
+                        g.span(),
+                    ));
+                };
+                let mut output = TokenStream::new();
+                // start from the lowest precedence
+                let next = self.parse_or(first_tok, &mut stream, &mut output)?;
+                if let Some(tok) = next {
+                    return Err(MacroError::Message(
+                        format!("unexpected token {tok}"),
+                        tok.span(),
+                    ));
+                }
+                out.extend(Some(paren(output)));
+                it.next()
+            }
+            TT::Ident(_) => {
+                let mut output = TokenStream::new();
+                output.extend([
+                    self.typ.clone(),
+                    TT::Punct(Punct::new(':', Spacing::Joint)),
+                    TT::Punct(Punct::new(':', Spacing::Joint)),
+                    tok,
+                ]);
+                out.extend(Some(paren(output)));
+                it.next()
+            }
+            TT::Punct(ref p) => {
+                if p.as_char() != '!' {
+                    return Err(MacroError::Message("expected operand".into(), p.span()));
+                }
+                let Some(rhs_tok) = it.next() else {
+                    return Err(MacroError::Message(
+                        "expected operand at end of input".into(),
+                        p.span(),
+                    ));
+                };
+                let next = self.parse_primary(rhs_tok, it, out)?;
+                out.extend([punct('.'), ident("invert"), paren(TokenStream::new())]);
+                next
+            }
+            _ => {
+                return Err(MacroError::Message("unexpected literal".into(), tok.span()));
+            }
+        };
+        Ok(next)
+    }
+
+    fn parse_binop<
+        F: Fn(
+            &Self,
+            TokenTree,
+            &mut dyn Iterator<Item = TokenTree>,
+            &mut TokenStream,
+        ) -> Result<Option<TokenTree>, MacroError>,
+    >(
+        &self,
+        tok: TokenTree,
+        it: &mut dyn Iterator<Item = TokenTree>,
+        out: &mut TokenStream,
+        ch: char,
+        f: F,
+        method: &'static str,
+    ) -> Result<Option<TokenTree>, MacroError> {
+        let mut next = f(self, tok, it, out)?;
+        while next.is_some() {
+            let op = next.as_ref().unwrap();
+            let TT::Punct(ref p) = op else { break };
+            if p.as_char() != ch {
+                break;
+            }
+
+            let Some(rhs_tok) = it.next() else {
+                return Err(MacroError::Message(
+                    "expected operand at end of input".into(),
+                    p.span(),
+                ));
+            };
+            let mut rhs = TokenStream::new();
+            next = f(self, rhs_tok, it, &mut rhs)?;
+            out.extend([punct('.'), ident(method), paren(rhs)]);
+        }
+        Ok(next)
+    }
+
+    // sub ::= primary ('-' primary)*
+    pub fn parse_sub(
+        &self,
+        tok: TokenTree,
+        it: &mut dyn Iterator<Item = TokenTree>,
+        out: &mut TokenStream,
+    ) -> Result<Option<TokenTree>, MacroError> {
+        self.parse_binop(tok, it, out, '-', Self::parse_primary, "difference")
+    }
+
+    // and ::= sub ('&' sub)*
+    fn parse_and(
+        &self,
+        tok: TokenTree,
+        it: &mut dyn Iterator<Item = TokenTree>,
+        out: &mut TokenStream,
+    ) -> Result<Option<TokenTree>, MacroError> {
+        self.parse_binop(tok, it, out, '&', Self::parse_sub, "intersection")
+    }
+
+    // xor ::= and ('&' and)*
+    fn parse_xor(
+        &self,
+        tok: TokenTree,
+        it: &mut dyn Iterator<Item = TokenTree>,
+        out: &mut TokenStream,
+    ) -> Result<Option<TokenTree>, MacroError> {
+        self.parse_binop(tok, it, out, '^', Self::parse_and, "symmetric_difference")
+    }
+
+    // or ::= xor ('|' xor)*
+    pub fn parse_or(
+        &self,
+        tok: TokenTree,
+        it: &mut dyn Iterator<Item = TokenTree>,
+        out: &mut TokenStream,
+    ) -> Result<Option<TokenTree>, MacroError> {
+        self.parse_binop(tok, it, out, '|', Self::parse_xor, "union")
+    }
+
+    pub fn parse(
+        it: &mut dyn Iterator<Item = TokenTree>,
+    ) -> Result<proc_macro2::TokenStream, MacroError> {
+        let mut pos = Span::call_site();
+        let mut typ = proc_macro2::TokenStream::new();
+
+        // Gobble everything up to an `@` sign, which is followed by a
+        // parenthesized expression; that is, all token trees except the
+        // last two form the type.
+        let next = loop {
+            let tok = it.next();
+            if let Some(ref t) = tok {
+                pos = t.span();
+            }
+            match tok {
+                None => break None,
+                Some(TT::Punct(ref p)) if p.as_char() == '@' => {
+                    let tok = it.next();
+                    if let Some(ref t) = tok {
+                        pos = t.span();
+                    }
+                    break tok;
+                }
+                Some(x) => typ.extend(Some(x)),
+            }
+        };
+
+        let Some(tok) = next else {
+            return Err(MacroError::Message(
+                "expected expression, do not call this macro directly".into(),
+                pos,
+            ));
+        };
+        let TT::Group(ref _group) = tok else {
+            return Err(MacroError::Message(
+                "expected parenthesis, do not call this macro directly".into(),
+                tok.span(),
+            ));
+        };
+        let mut out = TokenStream::new();
+        let state = Self {
+            typ: TT::Group(Group::new(Delimiter::None, typ)),
+        };
+
+        let next = state.parse_primary(tok, it, &mut out)?;
+
+        // A parenthesized expression is a single production of the grammar,
+        // so the input must have reached the last token.
+        if let Some(tok) = next {
+            return Err(MacroError::Message(
+                format!("unexpected token {tok}"),
+                tok.span(),
+            ));
+        }
+        Ok(out)
+    }
+}
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index f97449bb304..ceb79f09f97 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -12,6 +12,9 @@
 mod utils;
 use utils::MacroError;
 
+mod bits;
+use bits::BitsConstInternal;
+
 fn get_fields<'a>(
     input: &'a DeriveInput,
     msg: &str,
@@ -219,3 +222,12 @@ pub fn derive_tryinto(input: TokenStream) -> TokenStream {
 
     TokenStream::from(expanded)
 }
+
+#[proc_macro]
+pub fn bits_const_internal(ts: TokenStream) -> TokenStream {
+    let ts = proc_macro2::TokenStream::from(ts);
+    let mut it = ts.into_iter();
+
+    let expanded = BitsConstInternal::parse(&mut it).unwrap_or_else(Into::into);
+    TokenStream::from(expanded)
+}
-- 
2.49.0


