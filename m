Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4595CCA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzPe-00033t-PG; Fri, 30 Aug 2024 07:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjzPc-00033H-2D
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:03:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sjzPW-0005QW-E8
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:03:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3718acbc87fso964610f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725015797; x=1725620597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=go0ZtBPZ8DbPVKyFsfMi1c1nDuQJhnrPkl4EsAJXmHM=;
 b=Gif7DKMA07Pp6npd410x+oFmKelxGtPjgvCHbSZlPG3GQatt6KKrtNl8/IByfS5Hac
 CK2R1O5CFp2qIlFHFaEv18FJ2XKTsXa5Q0J6XJPBeJJRK03t4XcRwTyvyRyzj+C/wXuk
 nnHeJoRLGBCifiRSH1dVraQulLjSAo7tKkYsH7+GBrSemYRuLKzJexGEcctKqcuiUgKt
 HQP46YfyWGYqnLZdS1jR3lgcARQu/iRbbwokn2o/Fiwj9bH01Uh4dze9GDE65Ei4+KVb
 2dRaxIi/hReQiDKrG6vxIxxx101EUVhK0F4FLvZOvvFAXtEp0p24g+g8uQnp4Eb1+0Zc
 ns0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725015797; x=1725620597;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=go0ZtBPZ8DbPVKyFsfMi1c1nDuQJhnrPkl4EsAJXmHM=;
 b=SzYnM33FoOj0b9KSpNr8ev+bKwPxSu21tXqhS4uDW7HFqU7WrRoTaX66DKeYLyY+Wf
 aLSMUY7uhreINsZyAGXo/9L4KLG5hb2SYEgj5nnclq/RcnHTy+3f+BQUOOevyit/DRdx
 vTHzPJ5e/51vc8zeNh+Imdvqn1jIBwWibQV1yhKKuHIxVxc7b/+XYN08DrrKKUdwTFG4
 GHzNpfGGyIbtiPHxkuPv4MxivVAs3nWq4QDjQU6BB8Zq51M7puhjsDErzyZG4TeI0Jdy
 VkTDjAIs1JtoZkvXN/oU4o4EBMjkkUdBERxGxlLaeoks1moKRiUNSFZy1Ax/5uJkV4DH
 oelA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAEa6K2lBnscL1PAXYNdJv71GW48DciHB4os4b/1Ha4OnEfV7eKaMg3QqGaBL4o8dgGuRLX2LuAkpD@nongnu.org
X-Gm-Message-State: AOJu0YwK7uMpcfMoxT+7EIrWnzAZFAObUERx1LPw6AnLL4dYfnZfxYXi
 2HUnXurHAOC3mqq8Uc6af44/TysTGPafUNhY/Dgk0uiGBLPNKfYo6Hqj6ZTf2q4=
X-Google-Smtp-Source: AGHT+IEx3yR4SKgf916aCU8qudoRM8gyz+F9Uius96PE0EHRfN/5FUCImkC2nWzk8zkJFHOL7jlpfg==
X-Received: by 2002:a5d:60c1:0:b0:367:980a:6af with SMTP id
 ffacd0b85a97d-3749b58841emr4007718f8f.59.1725015796742; 
 Fri, 30 Aug 2024 04:03:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749efb458esm3699718f8f.110.2024.08.30.04.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 04:03:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1191F5F8AB;
 Fri, 30 Aug 2024 12:03:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Junjie Mao <junjie.mao@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 <qemu-devel@nongnu.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  "Richard Henderson"
 <richard.henderson@linaro.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 "Zhao Liu" <zhao1.liu@intel.com>
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
In-Reply-To: <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com> (Junjie Mao's
 message of "Fri, 30 Aug 2024 09:19:15 +0800")
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <871q284wxk.fsf@draig.linaro.org>
 <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
Date: Fri, 30 Aug 2024 12:03:15 +0100
Message-ID: <87y14e1de4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Junjie Mao <junjie.mao@intel.com> writes:

> On 8/28/2024 9:08 PM, Alex Benn=C3=A9e wrote:
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>=20
>>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>>> provides some declaration macros for symbols visible to the rest of
>>> QEMU.
>> As mentioned on IRC I'm hitting a compilation error that bisects to
>> this
>> commit:
>>    [148/1010] Generating bindings for Rust
>> rustmod-bindgen-rust_wrapper.h
>>    FAILED: bindings.rs
>>    /home/alex/.cargo/bin/bindgen ../../rust/wrapper.h --output
>> /home/alex/lsrc/qemu.git/builds/rust/bindings.rs
>> --disable-header-comment --raw-line '// @generated' --ctypes-prefix
>> core::ffi --formatter rustfmt --generate-block --generate-cstr
>> --impl-debug --merge-extern-blocks --no-doc-comments --use-core
>> --with-derive-default --allowlist-file
>> '/home/alex/lsrc/qemu.git/include/.*' --allowlist-file
>> '/home/alex/lsrc/qemu.git/.*' --allowlist-file
>> '/home/alex/lsrc/qemu.git/builds/rust/.*' --
>> -I/home/alex/lsrc/qemu.git/.
>> -I/home/alex/lsrc/qemu.git/builds/rust/.
>> -I/home/alex/lsrc/qemu.git/include
>> -I/home/alex/lsrc/qemu.git/builds/rust/include
>> -I/usr/include/capstone -I/usr/include/p11-kit-1
>> -I/usr/include/pixman-1 -I/usr/include/libpng16
>> -I/usr/include/spice-server -I/usr/include/spice-1
>> -I/usr/include/spice-1 -DSTRUCT_IOVEC_DEFINED
>> -I/usr/include/libusb-1.0 -I/usr/include/SDL2 -D_REENTRANT
>> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -pthread -I/usr/include/libmount -I/usr/include/blkid
>> -I/usr/include/gio-unix-2.0 -I/usr/include/glib-2.0
>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -pthread
>> -I/usr/include/libmount -I/usr/include/blkid -I/usr/include/slirp
>> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -DNCURSES_WIDECHAR=3D1 -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600
>> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0
>> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -I/usr/include/harfbuzz -I/usr/include/freetype2
>> -I/usr/include/libpng16 -I/usr/include/libmount -I/usr/include/blkid
>> -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/pixman-1
>> -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu
>> -I/usr/include/gio-unix-2.0 -I/usr/include/atk-1.0
>> -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0
>> -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
>> -pthread -I/usr/include/gtk-3.0 -I/usr/include/pango-1.0
>> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -I/usr/include/harfbuzz -I/usr/include/freetype2
>> -I/usr/include/libpng16 -I/usr/include/libmount -I/usr/include/blkid
>> -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/pixman-1
>> -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu
>> -I/usr/include/gio-unix-2.0 -I/usr/include/atk-1.0
>> -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0
>> -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
>> -pthread -I/usr/include/vte-2.91 -I/usr/include/glib-2.0
>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount
>> -I/usr/include/blkid -I/usr/include/pango-1.0
>> -I/usr/include/harfbuzz -I/usr/include/freetype2
>> -I/usr/include/libpng16 -I/usr/include/fribidi -I/usr/include/cairo
>> -I/usr/include/pixman-1 -I/usr/include/gtk-3.0
>> -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/x86_64-linux-gnu
>> -I/usr/include/gio-unix-2.0 -I/usr/include/atk-1.0
>> -I/usr/include/at-spi2-atk/2.0 -I/usr/include/at-spi-2.0
>> -I/usr/include/dbus-1.0 -I/usr/lib/x86_64-linux-gnu/dbus-1.0/include
>> -pthread -I/usr/include/glib-2.0
>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -I/usr/include/spice-server -I/usr/include/spice-1
>> -I/usr/include/cacard -I/usr/include/glib-2.0
>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/nss
>> -I/usr/include/nspr -I/usr/include/PCSC -pthread -D_REENTRANT
>> -I/usr/include/pipewire-0.3 -I/usr/include/spa-0.2 -D_REENTRANT
>> -I/usr/include/p11-kit-1 -I/usr/include/fuse3
>> -I/usr/include/x86_64-linux-gnu -D_FILE_OFFSET_BITS=3D64
>> -D__USE_FILE_OFFSET64 -D__USE_LARGEFILE64 -DUSE_POSIX_ACLS=3D1
>> -I/usr/include/uuid -I/usr/include/glib-2.0
>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-1
>> -I/usr/include/p11-kit-1 -I/usr/include/p11-kit-1 -D_GNU_SOURCE
>> -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -I/usr/include/glib-2.0
>> -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -std=3Dgnu11 -MD -MQ
>> ../../rust/wrapper.h -MF wrapper.h.d
>>    /usr/include/liburing.h:296:3: error: use of undeclared identifier 'm=
emory_order_release'
>>    /usr/include/liburing.h:1080:11: error: use of undeclared identifier =
'memory_order_acquire'
>>    /usr/include/liburing.h:1116:9: error: use of undeclared identifier '=
memory_order_acquire'
>>    /usr/include/liburing.h:1125:9: error: use of undeclared identifier '=
memory_order_relaxed'
>>    /usr/include/liburing.h:1161:2: error: use of undeclared identifier '=
memory_order_relaxed'
>>    /usr/include/liburing.h:1197:19: error: use of undeclared identifier =
'memory_order_acquire'
>>    /usr/include/liburing.h:1267:10: error: use of undeclared identifier =
'memory_order_relaxed'
>>    /usr/include/liburing.h:1269:10: error: use of undeclared identifier =
'memory_order_acquire'
>>    /usr/include/liburing.h:1320:2: error: use of undeclared identifier '=
memory_order_release'
>>    panicked at /home/alex/.cargo/registry/src/index.crates.io-6f17d22bba=
15001f/bindgen-cli-0.69.4/main.rs:52:36:
>>    Unable to generate bindings:
>> ClangDiagnostic("/usr/include/liburing.h:296:3: error: use of
>> undeclared identifier
>> 'memory_order_release'\n/usr/include/liburing.h:1080:11: error: use
>> of undeclared identifier
>> 'memory_order_acquire'\n/usr/include/liburing.h:1116:9: error: use
>> of undeclared identifier
>> 'memory_order_acquire'\n/usr/include/liburing.h:1125:9: error: use
>> of undeclared identifier
>> 'memory_order_relaxed'\n/usr/include/liburing.h:1161:2: error: use
>> of undeclared identifier
>> 'memory_order_relaxed'\n/usr/include/liburing.h:1197:19: error: use
>> of undeclared identifier
>> 'memory_order_acquire'\n/usr/include/liburing.h:1267:10: error: use
>> of undeclared identifier
>> 'memory_order_relaxed'\n/usr/include/liburing.h:1269:10: error: use
>> of undeclared identifier
>> 'memory_order_acquire'\n/usr/include/liburing.h:1320:2: error: use
>> of undeclared identifier 'memory_order_release'\n")
>
> Those missing identifiers should have been defined in stdatomic.h
> which is part of C11. You can check if that header exists under the
> default header search paths (which is listed by clang -E -Wp,-v -) and
> whether that file declares those enum constants. If so, you can
> further check whether there is any stdatomic.h elsewhere that shadows
> the standard one.

It is there:

  /usr/lib/llvm-14/lib/clang/14.0.6/include/stdatomic.h

in the search path:

  clang -E -Wp,-v -
  clang -cc1 version 14.0.6 based upon LLVM 14.0.6 default target x86_64-pc=
-linux-gnu
  ignoring nonexistent directory "/usr/bin/../lib/gcc/x86_64-linux-gnu/12/.=
./../../../x86_64-linux-gnu/include"
  ignoring nonexistent directory "/include"
  #include "..." search starts here:
  #include <...> search starts here:
   /usr/lib/llvm-14/lib/clang/14.0.6/include
   /usr/local/include
   /usr/include/x86_64-linux-gnu
   /usr/include
  End of search list.

but not in the list above. Have we told clang not to include system
search paths in the bindgen invocation?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

