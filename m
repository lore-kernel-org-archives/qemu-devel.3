Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB03AC54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIPW-0002gg-Jr; Wed, 28 Aug 2024 09:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjIPW-0002g5-0n
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:08:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjIPT-0006xU-Hy
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:08:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-428e3129851so60573855e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724850505; x=1725455305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EWt4BP4cxUI8Jn+lriRURGFDNwMkCcLiOOgHE3sjtr4=;
 b=jFHsiHH7zMkj4yAOgTDcLNLObhPBLaFGuEOXM0H6axL1UgW51i5Q5OhakEN20UJUXD
 /5Yn1MKW4jQuY4LCvnXNVLNlmkfYeq10sZoEYOLKfpMEu8EwDby60APAa56KCYg/r+uS
 my5V4mG6nZvRD82BxlJbxXdMSAz0hoi8G2BdZziu0lTzkpP24okt6HwZElHKKK3K4DRz
 +zqCiTObu8zH/o0oSmHORVXPtZXvhKP2qSJ8APPdBVo8NHTNkXfZfzjAYLgxoSEtdr+t
 ZnEEtuQIoFid6/aXmWyMke1CSSG+dcTkCF8FOKlFjd27gxYfS+5zTkyVkR84wYNWgrhE
 BNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724850505; x=1725455305;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWt4BP4cxUI8Jn+lriRURGFDNwMkCcLiOOgHE3sjtr4=;
 b=wDneVTbBvhkjl4H09hB8J9QnPBh503M1sW40IEKY9St1Ghb9LCVK7xjwJRavh7L7Uz
 YchqE0PbevUQpjsjaJv3vchIij/QOAl4JY+XmCk4OkVnWhS9/sH1F3hZORsndu5Xx6Tx
 vFK0y1mUu4Ac+pezQCGY6iOqziZ3Ghwf8IONI89dYKxYkpfFes5Mo+YxTHROzSSWuMIV
 494nX5HBWeAxrLdJn1L63djVhapexTTUlPvyB12+zNbbJvOA4z2YAedIkAvM2Zjz69oF
 mM/36VAg2kTQk39ycWljaHB2fVRxe/zSD4mA33KvkQFrHKDNkcXvVE/o5Eociacnnjvm
 8IdQ==
X-Gm-Message-State: AOJu0YymRVnfNWefuO52M5DXL7m9W4d/81WIR3gvrbfiZeXwUhTB6NSn
 Sy8NrBTNTnEQPGLT5Wy2UO4ZG2HJ5zEbICrVeOdOUNJVpcCfmSF5Q6QOeAbXrdY=
X-Google-Smtp-Source: AGHT+IGhtWeNv3Cd0mAUPRGqJeLnsnl0KfHLQeS4cmbU6SbQKqViLC6MwOiLv6CrCqzhO7d+20kOJA==
X-Received: by 2002:a05:600c:1908:b0:426:5f02:7b05 with SMTP id
 5b1f17b1804b1-42ba668f7e1mr14252655e9.2.1724850504698; 
 Wed, 28 Aug 2024 06:08:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730813c0dcsm15564861f8f.37.2024.08.28.06.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:08:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CC645F796;
 Wed, 28 Aug 2024 14:08:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Junjie Mao <junjie.mao@intel.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
In-Reply-To: <20240828-rust-pl011-v9-7-35579191f17c@linaro.org> (Manos
 Pitsidianakis's message of "Wed, 28 Aug 2024 07:11:48 +0300")
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
Date: Wed, 28 Aug 2024 14:08:23 +0100
Message-ID: <871q284wxk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
> provides some declaration macros for symbols visible to the rest of
> QEMU.

As mentioned on IRC I'm hitting a compilation error that bisects to this
commit:

  [148/1010] Generating bindings for Rust rustmod-bindgen-rust_wrapper.h
  FAILED: bindings.rs
  /home/alex/.cargo/bin/bindgen ../../rust/wrapper.h --output /home/alex/ls=
rc/qemu.git/builds/rust/bindings.rs --disable-header-comment --raw-line '//=
 @generated' --ctypes-prefix core::ffi --formatter rustfmt --generate-block=
 --generate-cstr --impl-debug --merge-extern-blocks --no-doc-comments --use=
-core --with-derive-default --allowlist-file '/home/alex/lsrc/qemu.git/incl=
ude/.*' --allowlist-file '/home/alex/lsrc/qemu.git/.*' --allowlist-file '/h=
ome/alex/lsrc/qemu.git/builds/rust/.*' -- -I/home/alex/lsrc/qemu.git/. -I/h=
ome/alex/lsrc/qemu.git/builds/rust/. -I/home/alex/lsrc/qemu.git/include -I/=
home/alex/lsrc/qemu.git/builds/rust/include -I/usr/include/capstone -I/usr/=
include/p11-kit-1 -I/usr/include/pixman-1 -I/usr/include/libpng16 -I/usr/in=
clude/spice-server -I/usr/include/spice-1 -I/usr/include/spice-1 -DSTRUCT_I=
OVEC_DEFINED -I/usr/include/libusb-1.0 -I/usr/include/SDL2 -D_REENTRANT -I/=
usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -pthread =
-I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I=
/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -pthread=
 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/slirp -I/usr/i=
nclude/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -DNCURSES_WIDE=
CHAR=3D1 -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -I/usr/include/glib-2.0 -I=
/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/gtk-3.0 -I/usr/in=
clude/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.=
0/include -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/l=
ibpng16 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/fribidi=
 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0=
 -I/usr/include/x86_64-linux-gnu -I/usr/include/gio-unix-2.0 -I/usr/include=
/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/in=
clude/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread -I/usr=
/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/li=
b/x86_64-linux-gnu/glib-2.0/include -I/usr/include/harfbuzz -I/usr/include/=
freetype2 -I/usr/include/libpng16 -I/usr/include/libmount -I/usr/include/bl=
kid -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/pixman-1 -I/=
usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu -I/usr/include/g=
io-unix-2.0 -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/in=
clude/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1=
.0/include -pthread -I/usr/include/vte-2.91 -I/usr/include/glib-2.0 -I/usr/=
lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/includ=
e/blkid -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/fre=
etype2 -I/usr/include/libpng16 -I/usr/include/fribidi -I/usr/include/cairo =
-I/usr/include/pixman-1 -I/usr/include/gtk-3.0 -I/usr/include/gdk-pixbuf-2.=
0 -I/usr/include/x86_64-linux-gnu -I/usr/include/gio-unix-2.0 -I/usr/includ=
e/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/i=
nclude/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread -I/us=
r/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/incl=
ude/spice-server -I/usr/include/spice-1 -I/usr/include/cacard -I/usr/includ=
e/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/nss =
-I/usr/include/nspr -I/usr/include/PCSC -pthread -D_REENTRANT -I/usr/includ=
e/pipewire-0.3 -I/usr/include/spa-0.2 -D_REENTRANT -I/usr/include/p11-kit-1=
 -I/usr/include/fuse3 -I/usr/include/x86_64-linux-gnu -D_FILE_OFFSET_BITS=
=3D64 -D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1 -I/usr=
/include/uuid -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/=
include -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-1 -I/usr/include/p1=
1-kit-1 -I/usr/include/p11-kit-1 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_=
LARGEFILE_SOURCE -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2=
.0/include -std=3Dgnu11 -MD -MQ ../../rust/wrapper.h -MF wrapper.h.d
  /usr/include/liburing.h:296:3: error: use of undeclared identifier 'memor=
y_order_release'
  /usr/include/liburing.h:1080:11: error: use of undeclared identifier 'mem=
ory_order_acquire'
  /usr/include/liburing.h:1116:9: error: use of undeclared identifier 'memo=
ry_order_acquire'
  /usr/include/liburing.h:1125:9: error: use of undeclared identifier 'memo=
ry_order_relaxed'
  /usr/include/liburing.h:1161:2: error: use of undeclared identifier 'memo=
ry_order_relaxed'
  /usr/include/liburing.h:1197:19: error: use of undeclared identifier 'mem=
ory_order_acquire'
  /usr/include/liburing.h:1267:10: error: use of undeclared identifier 'mem=
ory_order_relaxed'
  /usr/include/liburing.h:1269:10: error: use of undeclared identifier 'mem=
ory_order_acquire'
  /usr/include/liburing.h:1320:2: error: use of undeclared identifier 'memo=
ry_order_release'
  panicked at /home/alex/.cargo/registry/src/index.crates.io-6f17d22bba1500=
1f/bindgen-cli-0.69.4/main.rs:52:36:
  Unable to generate bindings: ClangDiagnostic("/usr/include/liburing.h:296=
:3: error: use of undeclared identifier 'memory_order_release'\n/usr/includ=
e/liburing.h:1080:11: error: use of undeclared identifier 'memory_order_acq=
uire'\n/usr/include/liburing.h:1116:9: error: use of undeclared identifier =
'memory_order_acquire'\n/usr/include/liburing.h:1125:9: error: use of undec=
lared identifier 'memory_order_relaxed'\n/usr/include/liburing.h:1161:2: er=
ror: use of undeclared identifier 'memory_order_relaxed'\n/usr/include/libu=
ring.h:1197:19: error: use of undeclared identifier 'memory_order_acquire'\=
n/usr/include/liburing.h:1267:10: error: use of undeclared identifier 'memo=
ry_order_relaxed'\n/usr/include/liburing.h:1269:10: error: use of undeclare=
d identifier 'memory_order_acquire'\n/usr/include/liburing.h:1320:2: error:=
 use of undeclared identifier 'memory_order_release'\n")

And I wasn't able to force the newer clang with:

  env CLANG_PATH=3D/usr/bin/clang-15 ../../configure '--disable-docs' --tar=
get-list=3Daarch64-softmmu --enable-rust

So if clang is required for bindgen we at least need:

  - to probe for clang (separately from --cc)
  - allow the user to override the default
  - pass the clang we want to use somehow to bindgen

Briefly looking at the bindgen code I see:

  fn main() {
      let out_dir =3D PathBuf::from(env::var("OUT_DIR").unwrap());

      let mut dst =3D
          File::create(Path::new(&out_dir).join("host-target.txt")).unwrap(=
);
      dst.write_all(env::var("TARGET").unwrap().as_bytes())
          .unwrap();

      // On behalf of clang_sys, rebuild ourselves if important configurati=
on
      // variables change, to ensure that bindings get rebuilt if the
      // underlying libclang changes.
      println!("cargo:rerun-if-env-changed=3DLLVM_CONFIG_PATH");
      println!("cargo:rerun-if-env-changed=3DLIBCLANG_PATH");
      println!("cargo:rerun-if-env-changed=3DLIBCLANG_STATIC_PATH");
      println!("cargo:rerun-if-env-changed=3DBINDGEN_EXTRA_CLANG_ARGS");
      println!(
          "cargo:rerun-if-env-changed=3DBINDGEN_EXTRA_CLANG_ARGS_{}",
          std::env::var("TARGET").unwrap()
      );
      println!(
          "cargo:rerun-if-env-changed=3DBINDGEN_EXTRA_CLANG_ARGS_{}",
          std::env::var("TARGET").unwrap().replace('-', "_")
      );
  }

So I wonder if this depends on what libclang versions can be found when
cargo builds it? Although if it does it must do so dynamically:

  $ ldd /home/alex/.cargo/bin/bindgen
          linux-vdso.so.1 (0x00007f7cb43d8000)
          libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f7=
cb438c000)
          libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007f7cb42ad00=
0)
          libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7cb3a1f00=
0)
          /lib64/ld-linux-x86-64.so.2 (0x00007f7cb43da000)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

