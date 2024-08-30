Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2D9CA0EE5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 06:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjvMV-00006G-8W; Fri, 30 Aug 2024 02:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjvMT-000054-I1
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 02:43:57 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjvMP-0001Ll-5D
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 02:43:57 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5beb6ea9ed6so1523120a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 23:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725000231; x=1725605031; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rGoDqIKDra4SHAZMcKmuE8kq3KSl6lBGnAg2BCVAt30=;
 b=Q1+01f+mMBRPUYuIQFrJtx2CcGvxz2ChudkntI9MOaYDfS8dxhHDmaxZ9gBfzCygc5
 H9y3r3ZV83ongYAqTl8XrS0o/z5CsdsVSjqVTRgHSqNeXb13FL7CGTfJYgj5QIju4kvb
 FNb4LGOAzcYz3I9GA3LCjz6i63eUffIfJT0oaL7g9fbN/Oc+ow6Kd6QQL0EBUwYQkEMW
 CJvJ2SvnoYm6kr5YzdRjdmxAIuyHrQi6nEiZe1iIrejh3UBqAh1yP8kfnxHesjgIOok5
 ow3s6VFpSuOFOHC9ydGqyDtU0I1BukZKvGYRXfIhA9V4VqKKJCa1Z2S8oWIGo1pGr4Fq
 rINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725000231; x=1725605031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGoDqIKDra4SHAZMcKmuE8kq3KSl6lBGnAg2BCVAt30=;
 b=Bu5oSFOpL9L4RFXWBRUV55PXyw2C4oKprTiP9od5JbZzE0LAjuEL/WpKKDIcNGOzjn
 E1r1MqJFAZbiKIYhlBQifKDtKNTpxRfGOZ6zfEBnFGZTbqZjdumYw2+CK3wr1VnaFPnx
 TZQwJhoMdJ4fF+8M2aX+/3XsS6qFL8pKsp9Eri92Xfn5ijy7j8JzZgP4cAZ8qQ33yLkf
 aHN4Ummh0q0YD9Z15MwV/2rBoy8pryA0NxKXLnY2a1i6/pFQ5wj8MCCD7FyjqkoFcPB7
 0sdfGRwo81QP4HFCF/m7bM7KApQWHyK+uYjJt4JnzzO80pdke+U2cJDXc10Lbt4fYDpS
 s7UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVckmtWNiH6cvHYDKZltQNI3f8sCD7r7Fjbw2DfuikniCO5UhnTMKD48/ZaDDOPj4aiK7Z22GSqk1qy@nongnu.org
X-Gm-Message-State: AOJu0YzD0ByUEBK+HiHcplPhNLn53FoK2/WgEEtxpbvP/27axKcRVxu9
 NXDX7dh14Qu0Pffh4qnTAJuGoMfR8jQzJjeBVPNtvc8jL4rn7QbN+9HQ84+jisrLgJluNIEby0l
 M5SN9nrse8SaStAKEN2yo/VN+PEF7yPIQCk67JA==
X-Google-Smtp-Source: AGHT+IHD9nzqIIpu2eIhkaOhKBS93IuP4kSb6/phG8kC6RWTOOaYQ7iat2V9Ym/lTXPyvLEXylZy1ehaugNkCX226gc=
X-Received: by 2002:a05:6402:35d6:b0:5c0:a8b1:ca8a with SMTP id
 4fb4d7f45d1cf-5c21ed42ac9mr3888946a12.11.1725000230260; Thu, 29 Aug 2024
 23:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <871q284wxk.fsf@draig.linaro.org>
 <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
In-Reply-To: <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 30 Aug 2024 09:43:38 +0300
Message-ID: <CAAjaMXZhvq3qppgEhs5zB-M=hfDFNT993XCUp0ZKPFmVxFXL2Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
To: Junjie Mao <junjie.mao@intel.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="000000000000f669bb0620e0e98f"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--000000000000f669bb0620e0e98f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=8E=B1

On Fri, 30 Aug 2024, 04:19 Junjie Mao, <junjie.mao@intel.com> wrote:

> On 8/28/2024 9:08 PM, Alex Benn=C3=A9e wrote:
> > Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >
> >> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings a=
nd
> >> provides some declaration macros for symbols visible to the rest of
> >> QEMU.
> >
> > As mentioned on IRC I'm hitting a compilation error that bisects to thi=
s
> > commit:
> >
> >    [148/1010] Generating bindings for Rust rustmod-bindgen-rust_wrapper=
.h
> >    FAILED: bindings.rs
> >    /home/alex/.cargo/bin/bindgen ../../rust/wrapper.h --output
> /home/alex/lsrc/qemu.git/builds/rust/bindings.rs --disable-header-comment
> --raw-line '// @generated' --ctypes-prefix core::ffi --formatter rustfmt
> --generate-block --generate-cstr --impl-debug --merge-extern-blocks
> --no-doc-comments --use-core --with-derive-default --allowlist-file
> '/home/alex/lsrc/qemu.git/include/.*' --allowlist-file
> '/home/alex/lsrc/qemu.git/.*' --allowlist-file
> '/home/alex/lsrc/qemu.git/builds/rust/.*' -- -I/home/alex/lsrc/qemu.git/.
> -I/home/alex/lsrc/qemu.git/builds/rust/. -I/home/alex/lsrc/qemu.git/inclu=
de
> -I/home/alex/lsrc/qemu.git/builds/rust/include -I/usr/include/capstone
> -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/usr/include/libpng16
> -I/usr/include/spice-server -I/usr/include/spice-1 -I/usr/include/spice-1
> -DSTRUCT_IOVEC_DEFINED -I/usr/include/libusb-1.0 -I/usr/include/SDL2
> -D_REENTRANT -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -pthread
> -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/gio-unix-2.0
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -pthread -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/slir=
p
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -DNCURSES_WIDECHAR=3D1 -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/harfbuzz
> -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/cairo
> -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0
> -I/usr/include/x86_64-linux-gnu -I/usr/include/gio-unix-2.0
> -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0
> -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0
> -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread
> -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/harfbuzz
> -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/cairo
> -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0
> -I/usr/include/x86_64-linux-gnu -I/usr/include/gio-unix-2.0
> -I/usr/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0
> -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0
> -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread
> -I/usr/include/vte-2.91 -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/pango-1.0 -I/usr/include/harfbuzz
> -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/fribidi
> -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/gtk-3.0
> -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu
> -I/usr/include/gio-unix-2.0 -I/usr/include/atk-1.0
> -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0
> -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
> -pthread -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/spice-server
> -I/usr/include/spice-1 -I/usr/include/cacard -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/nss
> -I/usr/include/nspr -I/usr/include/PCSC -pthread -D_REENTRANT
> -I/usr/include/pipewire-0.3 -I/usr/include/spa-0.2 -D_REENTRANT
> -I/usr/include/p11-kit-1 -I/usr/include/fuse3
> -I/usr/include/x86_64-linux-gnu -D_FILE_OFFSET_BITS=3D64
> -D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1
> -I/usr/include/uuid -I/usr/include/glib-2.0
> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/p11-kit-1
> -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-=
1
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -std=3Dgnu11 -MD -MQ ../../rust/wrapper.h -MF wrapper.h.d
> >    /usr/include/liburing.h:296:3: error: use of undeclared identifier
> 'memory_order_release'
> >    /usr/include/liburing.h:1080:11: error: use of undeclared identifier
> 'memory_order_acquire'
> >    /usr/include/liburing.h:1116:9: error: use of undeclared identifier
> 'memory_order_acquire'
> >    /usr/include/liburing.h:1125:9: error: use of undeclared identifier
> 'memory_order_relaxed'
> >    /usr/include/liburing.h:1161:2: error: use of undeclared identifier
> 'memory_order_relaxed'
> >    /usr/include/liburing.h:1197:19: error: use of undeclared identifier
> 'memory_order_acquire'
> >    /usr/include/liburing.h:1267:10: error: use of undeclared identifier
> 'memory_order_relaxed'
> >    /usr/include/liburing.h:1269:10: error: use of undeclared identifier
> 'memory_order_acquire'
> >    /usr/include/liburing.h:1320:2: error: use of undeclared identifier
> 'memory_order_release'
> >    panicked at
> /home/alex/.cargo/registry/src/index.crates.io-6f17d22bba15001f/bindgen-c=
li-0.69.4/main.rs:52
> :36:
> >    Unable to generate bindings:
> ClangDiagnostic("/usr/include/liburing.h:296:3: error: use of undeclared
> identifier 'memory_order_release'\n/usr/include/liburing.h:1080:11: error=
:
> use of undeclared identifier
> 'memory_order_acquire'\n/usr/include/liburing.h:1116:9: error: use of
> undeclared identifier
> 'memory_order_acquire'\n/usr/include/liburing.h:1125:9: error: use of
> undeclared identifier
> 'memory_order_relaxed'\n/usr/include/liburing.h:1161:2: error: use of
> undeclared identifier
> 'memory_order_relaxed'\n/usr/include/liburing.h:1197:19: error: use of
> undeclared identifier
> 'memory_order_acquire'\n/usr/include/liburing.h:1267:10: error: use of
> undeclared identifier
> 'memory_order_relaxed'\n/usr/include/liburing.h:1269:10: error: use of
> undeclared identifier
> 'memory_order_acquire'\n/usr/include/liburing.h:1320:2: error: use of
> undeclared identifier 'memory_order_release'\n")
>
> Those missing identifiers should have been defined in stdatomic.h which i=
s
> part
> of C11. You can check if that header exists under the default header
> search
> paths (which is listed by clang -E -Wp,-v -) and whether that file
> declares
> those enum constants. If so, you can further check whether there is any
> stdatomic.h elsewhere that shadows the standard one.
>

Indeed. These are in the compiler's own header files. I had problems on
Debian when using clang-14 and clang-15 but I got rid of them after I
upgraded to newer versions. If anyone can confirm/reproduce this we can add
a meson warning check?


>
> > And I wasn't able to force the newer clang with:
> >
> >    env CLANG_PATH=3D/usr/bin/clang-15 ../../configure '--disable-docs'
> --target-list=3Daarch64-softmmu --enable-rust
> >
> > So if clang is required for bindgen we at least need:
> >
> >    - to probe for clang (separately from --cc)
> >    - allow the user to override the default
> >    - pass the clang we want to use somehow to bindgen
> >
> > Briefly looking at the bindgen code I see:
> >
> >    fn main() {
> >        let out_dir =3D PathBuf::from(env::var("OUT_DIR").unwrap());
> >
> >        let mut dst =3D
> >
> File::create(Path::new(&out_dir).join("host-target.txt")).unwrap();
> >        dst.write_all(env::var("TARGET").unwrap().as_bytes())
> >            .unwrap();
> >
> >        // On behalf of clang_sys, rebuild ourselves if important
> configuration
> >        // variables change, to ensure that bindings get rebuilt if the
> >        // underlying libclang changes.
> >        println!("cargo:rerun-if-env-changed=3DLLVM_CONFIG_PATH");
> >        println!("cargo:rerun-if-env-changed=3DLIBCLANG_PATH");
> >        println!("cargo:rerun-if-env-changed=3DLIBCLANG_STATIC_PATH");
> >        println!("cargo:rerun-if-env-changed=3DBINDGEN_EXTRA_CLANG_ARGS"=
);
> >        println!(
> >            "cargo:rerun-if-env-changed=3DBINDGEN_EXTRA_CLANG_ARGS_{}",
> >            std::env::var("TARGET").unwrap()
> >        );
> >        println!(
> >            "cargo:rerun-if-env-changed=3DBINDGEN_EXTRA_CLANG_ARGS_{}",
> >            std::env::var("TARGET").unwrap().replace('-', "_")
> >        );
> >    }
>
> This is build.rs which is a build script invoked by cargo. The entry of
> the
> bindgen executable is in the bindgen-cli crate.
>
> ---
> Best Regards
> Junjie Mao
>
> >
> > So I wonder if this depends on what libclang versions can be found when
> > cargo builds it? Although if it does it must do so dynamically:
> >
> >    $ ldd /home/alex/.cargo/bin/bindgen
> >            linux-vdso.so.1 (0x00007f7cb43d8000)
> >            libgcc_s.so.1 =3D> /lib/x86_64-linux-gnu/libgcc_s.so.1
> (0x00007f7cb438c000)
> >            libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6
> (0x00007f7cb42ad000)
> >            libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> (0x00007f7cb3a1f000)
> >            /lib64/ld-linux-x86-64.so.2 (0x00007f7cb43da000)
> >
>

--000000000000f669bb0620e0e98f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>=F0=9F=8E=B1<br><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Fri, 30 Aug 2024, 04:19 Junjie Mao, &lt=
;<a href=3D"mailto:junjie.mao@intel.com">junjie.mao@intel.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 8/28/2024 9=
:08 PM, Alex Benn=C3=A9e wrote:<br>
&gt; Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.o=
rg" target=3D"_blank" rel=3D"noreferrer">manos.pitsidianakis@linaro.org</a>=
&gt; writes:<br>
&gt; <br>
&gt;&gt; Add rust/qemu-api, which exposes rust-bindgen generated FFI bindin=
gs and<br>
&gt;&gt; provides some declaration macros for symbols visible to the rest o=
f<br>
&gt;&gt; QEMU.<br>
&gt; <br>
&gt; As mentioned on IRC I&#39;m hitting a compilation error that bisects t=
o this<br>
&gt; commit:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 [148/1010] Generating bindings for Rust rustmod-bindgen-r=
ust_wrapper.h<br>
&gt;=C2=A0 =C2=A0 FAILED: <a href=3D"http://bindings.rs" rel=3D"noreferrer =
noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt;=C2=A0 =C2=A0 /home/alex/.cargo/bin/bindgen ../../rust/wrapper.h --outp=
ut /home/alex/lsrc/qemu.git/builds/rust/<a href=3D"http://bindings.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">bindings.rs</a> --disable-head=
er-comment --raw-line &#39;// @generated&#39; --ctypes-prefix core::ffi --f=
ormatter rustfmt --generate-block --generate-cstr --impl-debug --merge-exte=
rn-blocks --no-doc-comments --use-core --with-derive-default --allowlist-fi=
le &#39;/home/alex/lsrc/qemu.git/include/.*&#39; --allowlist-file &#39;/hom=
e/alex/lsrc/qemu.git/.*&#39; --allowlist-file &#39;/home/alex/lsrc/qemu.git=
/builds/rust/.*&#39; -- -I/home/alex/lsrc/qemu.git/. -I/home/alex/lsrc/qemu=
.git/builds/rust/. -I/home/alex/lsrc/qemu.git/include -I/home/alex/lsrc/qem=
u.git/builds/rust/include -I/usr/include/capstone -I/usr/include/p11-kit-1 =
-I/usr/include/pixman-1 -I/usr/include/libpng16 -I/usr/include/spice-server=
 -I/usr/include/spice-1 -I/usr/include/spice-1 -DSTRUCT_IOVEC_DEFINED -I/us=
r/include/libusb-1.0 -I/usr/include/SDL2 -D_REENTRANT -I/usr/include/glib-2=
.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -pthread -I/usr/include/lib=
mount -I/usr/include/blkid -I/usr/include/gio-unix-2.0 -I/usr/include/glib-=
2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -pthread -I/usr/include/li=
bmount -I/usr/include/blkid -I/usr/include/slirp -I/usr/include/glib-2.0 -I=
/usr/lib/x86_64-linux-gnu/glib-2.0/include -DNCURSES_WIDECHAR=3D1 -D_DEFAUL=
T_SOURCE -D_XOPEN_SOURCE=3D600 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-li=
nux-gnu/glib-2.0/include -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I=
/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/i=
nclude/harfbuzz -I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/inc=
lude/libmount -I/usr/include/blkid -I/usr/include/fribidi -I/usr/include/ca=
iro -I/usr/include/pixman-1 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x8=
6_64-linux-gnu -I/usr/include/gio-unix-2.0 -I/usr/include/atk-1.0 -I/usr/in=
clude/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/=
usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread -I/usr/include/gtk-3.0 -=
I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu=
/glib-2.0/include -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/i=
nclude/libpng16 -I/usr/include/libmount -I/usr/include/blkid -I/usr/include=
/fribidi -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/gdk-pi=
xbuf-2.0 -I/usr/include/x86_64-linux-gnu -I/usr/include/gio-unix-2.0 -I/usr=
/include/atk-1.0 -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -=
I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthrea=
d -I/usr/include/vte-2.91 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-g=
nu/glib-2.0/include -I/usr/include/libmount -I/usr/include/blkid -I/usr/inc=
lude/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/incl=
ude/libpng16 -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/pix=
man-1 -I/usr/include/gtk-3.0 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x=
86_64-linux-gnu -I/usr/include/gio-unix-2.0 -I/usr/include/atk-1.0 -I/usr/i=
nclude/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I=
/usr/lib/x86_64-linux-gnu/dbus-1.0/include -pthread -I/usr/include/glib-2.0=
 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/spice-server -=
I/usr/include/spice-1 -I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/=
lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/nss -I/usr/include/nsp=
r -I/usr/include/PCSC -pthread -D_REENTRANT -I/usr/include/pipewire-0.3 -I/=
usr/include/spa-0.2 -D_REENTRANT -I/usr/include/p11-kit-1 -I/usr/include/fu=
se3 -I/usr/include/x86_64-linux-gnu -D_FILE_OFFSET_BITS=3D64 -D__USE_FILE_O=
FFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1 -I/usr/include/uuid -I/usr=
/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/inclu=
de/p11-kit-1 -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-1 -I/usr/inclu=
de/p11-kit-1 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -I/=
usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -std=3Dgn=
u11 -MD -MQ ../../rust/wrapper.h -MF wrapper.h.d<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:296:3: error: use of undeclared i=
dentifier &#39;memory_order_release&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1080:11: error: use of undeclared=
 identifier &#39;memory_order_acquire&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1116:9: error: use of undeclared =
identifier &#39;memory_order_acquire&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1125:9: error: use of undeclared =
identifier &#39;memory_order_relaxed&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1161:2: error: use of undeclared =
identifier &#39;memory_order_relaxed&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1197:19: error: use of undeclared=
 identifier &#39;memory_order_acquire&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1267:10: error: use of undeclared=
 identifier &#39;memory_order_relaxed&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1269:10: error: use of undeclared=
 identifier &#39;memory_order_acquire&#39;<br>
&gt;=C2=A0 =C2=A0 /usr/include/liburing.h:1320:2: error: use of undeclared =
identifier &#39;memory_order_release&#39;<br>
&gt;=C2=A0 =C2=A0 panicked at /home/alex/.cargo/registry/src/index.crates.i=
o-6f17d22bba15001f/bindgen-cli-0.69.4/main.rs:52:36:<br>
&gt;=C2=A0 =C2=A0 Unable to generate bindings: ClangDiagnostic(&quot;/usr/i=
nclude/liburing.h:296:3: error: use of undeclared identifier &#39;memory_or=
der_release&#39;\n/usr/include/liburing.h:1080:11: error: use of undeclared=
 identifier &#39;memory_order_acquire&#39;\n/usr/include/liburing.h:1116:9:=
 error: use of undeclared identifier &#39;memory_order_acquire&#39;\n/usr/i=
nclude/liburing.h:1125:9: error: use of undeclared identifier &#39;memory_o=
rder_relaxed&#39;\n/usr/include/liburing.h:1161:2: error: use of undeclared=
 identifier &#39;memory_order_relaxed&#39;\n/usr/include/liburing.h:1197:19=
: error: use of undeclared identifier &#39;memory_order_acquire&#39;\n/usr/=
include/liburing.h:1267:10: error: use of undeclared identifier &#39;memory=
_order_relaxed&#39;\n/usr/include/liburing.h:1269:10: error: use of undecla=
red identifier &#39;memory_order_acquire&#39;\n/usr/include/liburing.h:1320=
:2: error: use of undeclared identifier &#39;memory_order_release&#39;\n&qu=
ot;)<br>
<br>
Those missing identifiers should have been defined in stdatomic.h which is =
part <br>
of C11. You can check if that header exists under the default header search=
 <br>
paths (which is listed by clang -E -Wp,-v -) and whether that file declares=
 <br>
those enum constants. If so, you can further check whether there is any <br=
>
stdatomic.h elsewhere that shadows the standard one.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Indeed. These are in th=
e compiler&#39;s own header files. I had problems on Debian when using clan=
g-14 and clang-15 but I got rid of them after I upgraded to newer versions.=
 If anyone can confirm/reproduce this we can add a meson warning check?</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt; <br>
&gt; And I wasn&#39;t able to force the newer clang with:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 env CLANG_PATH=3D/usr/bin/clang-15 ../../configure &#39;-=
-disable-docs&#39; --target-list=3Daarch64-softmmu --enable-rust<br>
&gt; <br>
&gt; So if clang is required for bindgen we at least need:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - to probe for clang (separately from --cc)<br>
&gt;=C2=A0 =C2=A0 - allow the user to override the default<br>
&gt;=C2=A0 =C2=A0 - pass the clang we want to use somehow to bindgen<br>
&gt; <br>
&gt; Briefly looking at the bindgen code I see:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 fn main() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 let out_dir =3D PathBuf::from(env::var(&quo=
t;OUT_DIR&quot;).unwrap());<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 let mut dst =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 File::create(Path::new(&amp;o=
ut_dir).join(&quot;host-target.txt&quot;)).unwrap();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst.write_all(env::var(&quot;TARGET&quot;).=
unwrap().as_bytes())<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .unwrap();<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 // On behalf of clang_sys, rebuild ourselve=
s if important configuration<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 // variables change, to ensure that binding=
s get rebuilt if the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 // underlying libclang changes.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 println!(&quot;cargo:rerun-if-env-changed=
=3DLLVM_CONFIG_PATH&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 println!(&quot;cargo:rerun-if-env-changed=
=3DLIBCLANG_PATH&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 println!(&quot;cargo:rerun-if-env-changed=
=3DLIBCLANG_STATIC_PATH&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 println!(&quot;cargo:rerun-if-env-changed=
=3DBINDGEN_EXTRA_CLANG_ARGS&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 println!(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cargo:rerun-if-env-chan=
ged=3DBINDGEN_EXTRA_CLANG_ARGS_{}&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 std::env::var(&quot;TARGET&qu=
ot;).unwrap()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 println!(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cargo:rerun-if-env-chan=
ged=3DBINDGEN_EXTRA_CLANG_ARGS_{}&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 std::env::var(&quot;TARGET&qu=
ot;).unwrap().replace(&#39;-&#39;, &quot;_&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
&gt;=C2=A0 =C2=A0 }<br>
<br>
This is <a href=3D"http://build.rs" rel=3D"noreferrer noreferrer" target=3D=
"_blank">build.rs</a> which is a build script invoked by cargo. The entry o=
f the <br>
bindgen executable is in the bindgen-cli crate.<br>
<br>
---<br>
Best Regards<br>
Junjie Mao<br>
<br>
&gt; <br>
&gt; So I wonder if this depends on what libclang versions can be found whe=
n<br>
&gt; cargo builds it? Although if it does it must do so dynamically:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 $ ldd /home/alex/.cargo/bin/bindgen<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 linux-vdso.so.1 (0x00007f7cb4=
3d8000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libgcc_s.so.1 =3D&gt; /lib/x8=
6_64-linux-gnu/libgcc_s.so.1 (0x00007f7cb438c000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libm.so.6 =3D&gt; /lib/x86_64=
-linux-gnu/libm.so.6 (0x00007f7cb42ad000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc.so.6 =3D&gt; /lib/x86_64=
-linux-gnu/libc.so.6 (0x00007f7cb3a1f000)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /lib64/ld-linux-x86-64.so.2 (=
0x00007f7cb43da000)<br>
&gt; <br>
</blockquote></div></div></div>

--000000000000f669bb0620e0e98f--

