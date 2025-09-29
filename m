Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B9ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 22:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3MF4-0007fw-OE; Mon, 29 Sep 2025 18:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MF1-0007fI-Pa
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 18:21:07 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3MEu-00028x-DT
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 18:21:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso4096327b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759184453; x=1759789253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IUCiUliMax4cyCxq3lhy/C1UElmsAMDKsIa9C583Qs4=;
 b=MHhv3XnaPsBkhSDQYiFgDd2afsUUVxX5BazWMhC1gq+iNfivmG2sNXo/r5FGP//0uV
 VgAOXRVkgRaDKz/RsiNTkcaEkFc/vN8rLo3pc73PzBJFUmE3eevE5g07IlmxrtviCE9g
 IyTltN+BqLLIZnvzs8Ukjcnd3yA8kEMwDKVdFzPUMNhEfBszKBOXddKroRY+lxpGN2Nk
 LwuEYh0ujXvmdetiLoWistY+ELk8kJw00DOtZOMvSNX4Ini6vJGA91NokWS+vzJ2WfDk
 +eaA33wnJS98yqEWnee79fp+cu3YcHYt+FxytoyV3rqQMXS97l0+M+JfJ8rm0+RTeBnN
 cpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759184453; x=1759789253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IUCiUliMax4cyCxq3lhy/C1UElmsAMDKsIa9C583Qs4=;
 b=XZYx5FIRqyeRb8eTvfH2tmAIvOTBN7gUagdvhdBRFcSz9cY/vHMA/bMygrND8I8Z2M
 wmZI5dhzFx1IGbxVSzkN82/7oynrQHf58sDQoKILm8lHKQWxFnI0w4sMPWSqUOlsfVtE
 tHrxjqVwA/vEKdQWc0/K7WmUJrcEILt+UZQCw2+MYJUGde6tGRizdfEwYEA1al4jGV5E
 GOE9q59JjFOC8DOCnu5eFTbwy7S0oaSIxUpuvj+lM6sz/YAOlFqJ5iDX1q1EfGgr7g5p
 KlIAvFoCeFIh/EFP5dmT6ds/EJmomGRqxNkh0sbpAP0Fg5u/2o9feLKH6a2lvRxzStT+
 IC/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUQlrfjbw1oy2F02TnJXiEanDBQg9UQteBXlepXptjB3JLma4V1w0G+Qye+DG6exM4LjeNseNq2Ox1@nongnu.org
X-Gm-Message-State: AOJu0YwpacQMjfHPt29jPKgB4FIQLIu2Kg1/jLO6BdG059gaxEfh0SI/
 scaOZhEl8gYp7Wsq9ZYgPLtdCmsdZxtXHlfDSXEaObljhNvINZiVhZoyBy+1SV80WvU=
X-Gm-Gg: ASbGncuWX4LisbqL14553FC+Ej+ev2ZRhSG8bhnK/8vgBW66SiUQ4f1G6Edu2XaEA+q
 +DQB6DPvaYsMMIDE+1vh+Etu9VOiFNxWyAXoW9ps/wiPMGlFpcvu1UqKLpF3ArNW33AGcFbqaZo
 4VynrsHvJLWznn5UhCVkIBI7LCjDQvvZI57/Fat4r09Ix6mSduoIYtQaCohkoF31MeupbDqSSmN
 cJcrDCt5mUEZZ6+qo7Mcp8U3N1HXhNTlWEJm++U3g/YjZtIQNQKRibHufzBQjtnwPBCFtzILJ+H
 TEFjABo0tFGncKwy/ZleityDxTZyF4f/PZYFNlXYKY3xUkJ93pPbH7eip6Fh2poYdMIY1/IHisK
 VI7BtjM/1QFZ50z6nfvJwbVah6+slIQrmqvKFi87AWJ8v1g==
X-Google-Smtp-Source: AGHT+IHkes0ktozQy1e76FB+touSVp81KcH62U5D+oAw+gymzgMLaix8ce3S8YEAJqncy8CpmAAitQ==
X-Received: by 2002:a17:90b:1b4a:b0:330:72fb:ac13 with SMTP id
 98e67ed59e1d1-3342a22cc80mr18293339a91.5.1759184453451; 
 Mon, 29 Sep 2025 15:20:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-338387256cdsm2333136a91.20.2025.09.29.15.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 15:20:53 -0700 (PDT)
Message-ID: <ba60c570-fff0-4ab8-b3bc-d191663d2912@linaro.org>
Date: Mon, 29 Sep 2025 15:20:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/35] wasm: Add Wasm TCG backend based on wasm64
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Kohei,

On 9/1/25 4:44 AM, Kohei Tokunaga wrote:
> V3:
> - Fixed init_wasm_js to correctly cast pointers to Numbers when passing the
>    arguments to the getInt32 and setInt32 methods.
> - Lowered the the maximum number of instances (MAX_INSTANCES) to avoid the
>    out of memory error in recent versions of FireFox.
> 
> V2:
> 
> - Reorganized commits to implement the backend incrementally from a clean
>    state.
> - Removed the andc, orc, eqv, nand and nor operations to rely on default
>    expansion.
> - Removed the bswap operations to use default expansion.
> - Removed the extract and deposit oprations to use default expansion.
> - Updated the sextract to emit only when the corresponding Wasm instruction
>    is available
> - Removed the not operation to rely on default expansion.
> - Fixed the neg implementation to "ret = 0 - arg"
> - Added Wasm implementation of the mb operation using the atomic.fence
>    instruction.
> 
> Note:
> The first four commits are temporarily imported from a separated patch
> series which enables 64bit guests using wasm64 [2]. These commits are under
> review in that series and are included here only to allow subsequent patches
> to build. Please ignore them when reviewing this series.
> 
> V1:
> 
> This patch series adds a TCG backend for WebAssembly. Unlike eariler
> attempts [1], it is implemented using Emscripten's wasm64 target to support
> 64bit guests.
> 
> The first four commits are temporarily imported from a separated patch
> series which enables 64bit guests using wasm64 [2]. These commits are under
> review in that series and are included here only to allow subsequent patches
> to build. Please ignore them when reviewing this series.
> 
> # New TCG Backend for Browsers
> 
> A new TCG backend translates IR instructions into Wasm instructions and runs
> them using the browser's WebAssembly APIs (WebAssembly.Module and
> WebAssembly.instantiate). To minimize compilation overhead and avoid hitting
> the browser's limitation of the number of instances, this backend integrates
> a forked TCI. TBs run on TCI by default, with frequently executed TBs
> compiled into WebAssembly.
> 
> # 64bit guests support by wasm64
> 
> Support for 64bit guests is being reviewed in a separated patch series [2],
> which enables QEMU to use 64bit pointers by compiling with the --cpu=wasm64
> flag. The Wasm TCG backend is based on this feature and also requires
> --cpu=wasm64.
> 
> QEMU compiled with --cpu=wasm64 runs on wasm64-capable engines. To support
> engines which don't support wasm64 (e.g. Safari), the Wasm backend can use
> the compatibility flag "--enable-wasm64-32bit-address-limit" also introduced
> in [2]. This flag enables 64bit pointers in the C code while Emscripten
> lowers the output binary to wasm32 and limits the maximum memory size to
> 4GB. As a result, the Wasm backend can run on wasm32 engiens while
> supporting 64bit guests.
> 
> Note: The flag was originally named --wasm64-32bit-address-limit but this
> patch series moved it from the configure script into meson_options.txt. To
> follow Meson's naming conventions, it was renamed to
> --enable-wasm64-32bit-address-limit.
> 
> # Overview of build process
> 
> To compile QEMU with Emscripten, the following dependencies are required.
> The emsdk-wasm-cross.docker environment includes all necessary components
> and can be used as the build environment:
> 
> - Emscripten SDK (emsdk) v4.0.10
> - Libraries cross-compiled with Emscripten (please see also
>    emsdk-wasm-cross.docker for build steps)
>    - GLib v2.84.0
>    - zlib v1.3.1
>    - libffi v3.5.2
>    - Pixman v0.44.2
> 
> The configure script supports --cpu=wasm64 flag to compile QEMU with 64bit
> pointer support.
> 
> emconfigure ./configure --cpu=wasm64 \
>                          --static --disable-tools \
>                          --target-list=x86_64-softmmu
> emmake make -j$(nproc)
> 
> If the output needs to run on wasm32 engines, use
> "--enable-wasm64-32bit-address-limit" flag.
> 
> emconfigure ./configure --cpu=wasm64 --enable-wasm64-32bit-address-limit \
>                          --static --disable-tools \
>                          --target-list=x86_64-softmmu
> emmake make -j$(nproc)
> 
> Either of the above commands generates the following files:
> 
> - qemu-system-x86_64.js
> - qemu-system-x86_64.wasm
> 
> Guest images can be packaged using Emscripten's file_packager.py tool.
> For example, if the images are stored in a directory named "pack", the
> following command packages them, allowing QEMU to access them through
> Emscripten's virtual filesystem:
> 
> /path/to/file_packager.py qemu-system-x86_64.data --preload pack > load.js
> 
> This process generates the following files:
> 
> - qemu-system-x86_64.data
> - load.js
> 
> Emscripten allows passing arguments to the QEMU command via the Module
> object in JavaScript:
> 
> Module['arguments'] = [
>      '-nographic', '-m', '512M',
>      '-L', 'pack/',
>      '-drive', 'if=virtio,format=raw,file=pack/rootfs.bin',
>      '-kernel', 'pack/bzImage',
>      '-append', 'earlyprintk=ttyS0 console=ttyS0 root=/dev/vda loglevel=7',
> ];
> 
> The sample repository [3] (tcgdev64 branch) provides a complete setup,
> including an HTML file that implements a terminal UI.
> 
> [1] https://patchew.org/QEMU/cover.1747744132.git.ktokunaga.mail@gmail.com/
> [2] https://patchew.org/QEMU/cover.1754534225.git.ktokunaga.mail@gmail.com/
> [3] https://github.com/ktock/qemu-wasm-sample/tree/tcgdev64
> 
> Kohei Tokunaga (35):
>    meson: Add wasm64 support to the --cpu flag
>    configure: Enable to propagate -sMEMORY64 flag to Emscripten
>    dockerfiles: Add support for wasm64 to the wasm Dockerfile
>    .gitlab-ci.d: Add build tests for wasm64
>    tcg/wasm: Add tcg-target.h and tcg-target-reg-bits.h
>    tcg/wasm: Add register-related definitions
>    tcg/wasm: Add constraint definitions
>    tcg/wasm: Add relocation callbacks
>    tcg/wasm: Add and/or/xor instructions
>    tcg/wasm: Add add/sub/mul instructions
>    tcg/wasm: Add shl/shr/sar instructions
>    tcg/wasm: Add setcond/negsetcond/movcond instructions
>    tcg/wasm: Add sextract instruction
>    tcg/wasm: Add load and store instructions
>    tcg/wasm: Add mov/movi instructions
>    tcg/wasm: Add ext instructions
>    tcg/wasm: Add div/rem instructions
>    tcg/wasm: Add neg/ctpop instructions
>    tcg/wasm: Add rot/clz/ctz instructions
>    tcg/wasm: Add br/brcond instructions
>    tcg/wasm: Add exit_tb/goto_tb/goto_ptr instructions
>    tcg/wasm: Add call instruction
>    tcg/wasm: Add qemu_ld/qemu_st instructions
>    tcg/wasm: Add mb instruction
>    tcg/wasm: Mark unimplemented instructions
>    tcg/wasm: Add initialization of fundamental registers
>    tcg/wasm: Write wasm binary to TB
>    tcg/wasm: Implement instantiation of Wasm binary
>    tcg/wasm: Allow switching coroutine from a helper
>    tcg/wasm: Enable instantiation of TBs executed many times
>    tcg/wasm: Enable TLB lookup
>    tcg/wasm: Add tcg_target_init function
>    meson.build: enable to build Wasm backend
>    meson.build: Propagate optimization flag for linking on Emscripten
>    .gitlab-ci.d: build wasm backend in CI
> 
>   .gitlab-ci.d/buildtest.yml                    |   26 +-
>   .gitlab-ci.d/container-cross.yml              |   20 +-
>   .gitlab-ci.d/container-template.yml           |    4 +-
>   MAINTAINERS                                   |    9 +-
>   configure                                     |   14 +-
>   include/accel/tcg/getpc.h                     |    2 +-
>   include/tcg/helper-info.h                     |    4 +-
>   include/tcg/tcg.h                             |    2 +-
>   meson.build                                   |   16 +-
>   meson_options.txt                             |    3 +
>   scripts/meson-buildoptions.sh                 |    5 +
>   tcg/aarch64/tcg-target.c.inc                  |   11 +
>   tcg/arm/tcg-target.c.inc                      |   11 +
>   tcg/i386/tcg-target.c.inc                     |   11 +
>   tcg/loongarch64/tcg-target.c.inc              |   11 +
>   tcg/meson.build                               |    5 +
>   tcg/mips/tcg-target.c.inc                     |   11 +
>   tcg/ppc/tcg-target.c.inc                      |   11 +
>   tcg/region.c                                  |   10 +-
>   tcg/riscv/tcg-target.c.inc                    |   11 +
>   tcg/s390x/tcg-target.c.inc                    |   11 +
>   tcg/sparc64/tcg-target.c.inc                  |   11 +
>   tcg/tcg.c                                     |   21 +-
>   tcg/tci/tcg-target.c.inc                      |   11 +
>   tcg/wasm.c                                    |  855 +++++
>   tcg/wasm.h                                    |  117 +
>   tcg/wasm/tcg-target-con-set.h                 |   19 +
>   tcg/wasm/tcg-target-con-str.h                 |   14 +
>   tcg/wasm/tcg-target-has.h                     |   14 +
>   tcg/wasm/tcg-target-mo.h                      |   20 +
>   tcg/wasm/tcg-target-opc.h.inc                 |   18 +
>   tcg/wasm/tcg-target-reg-bits.h                |   11 +
>   tcg/wasm/tcg-target.c.inc                     | 2843 +++++++++++++++++
>   tcg/wasm/tcg-target.h                         |   61 +
>   ...2-cross.docker => emsdk-wasm-cross.docker} |   29 +-
>   35 files changed, 4218 insertions(+), 34 deletions(-)
>   create mode 100644 tcg/wasm.c
>   create mode 100644 tcg/wasm.h
>   create mode 100644 tcg/wasm/tcg-target-con-set.h
>   create mode 100644 tcg/wasm/tcg-target-con-str.h
>   create mode 100644 tcg/wasm/tcg-target-has.h
>   create mode 100644 tcg/wasm/tcg-target-mo.h
>   create mode 100644 tcg/wasm/tcg-target-opc.h.inc
>   create mode 100644 tcg/wasm/tcg-target-reg-bits.h
>   create mode 100644 tcg/wasm/tcg-target.c.inc
>   create mode 100644 tcg/wasm/tcg-target.h
>   rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)
> 

I tried to build this series to test it, but unfortunately, I have some 
errors:

$ podman build -t wasm - --build-arg TARGET_CPU=wasm64 \
   --build-arg WASM64_MEMORY64=1 \
   < ./tests/docker/dockerfiles/emsdk-wasm-cross.docker
$ podman run -it --rm -w $(pwd) -v $(pwd):$(pwd) wasm bash
$ emconfigure ./configure --cpu=wasm64 \
   --static --disable-tools --target-list=x86_64-softmmu
$ emmake make -j$(nproc)

* /builddeps/target/include/ffi.h:430:6: error: 'FFI_NATIVE_RAW_API' is 
not defined, evaluates to 0 [-Werror,-Wundef]
* various "format specifies type 'long long' but the argument has type 
'long' [-Werror,-Wformat]"

Is it working fine on your side? If yes, what am I missing?

Note: To build with podman, I needed those changes (that you can 
probably integrate as they are compatible with docker also):
--- a/tests/docker/dockerfiles/emsdk-wasm-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
@@ -10,7 +10,7 @@ ARG MESON_VERSION=1.5.0
  ARG TARGET_CPU=wasm32
  ARG WASM64_MEMORY64=0

-FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
+FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
  ARG TARGET_CPU
  ARG MESON_VERSION
  ENV TARGET=/builddeps/target
@@ -130,8 +130,8 @@ RUN mkdir -p /glib
  RUN curl -Lks 
https://download.gnome.org/sources/glib/${GLIB_MINOR_VERSION}/glib-$GLIB_VERSION.tar.xz 
| \
      tar xJC /glib --strip-components=1

-COPY --link --from=zlib-dev /builddeps/ /builddeps/
-COPY --link --from=libffi-dev /builddeps/ /builddeps/
+COPY --from=zlib-dev /builddeps/ /builddeps/
+COPY --from=libffi-dev /builddeps/ /builddeps/

  WORKDIR /glib
  RUN <<EOF
@@ -156,5 +156,5 @@ RUN sed -i -E "/#define HAVE_PTHREAD_GETNAME_NP 1/d" 
./_build/config.h
  RUN meson install -C _build

  FROM build-base
-COPY --link --from=glib-dev /builddeps/ /builddeps/
-COPY --link --from=pixman-dev /builddeps/ /builddeps/
+COPY --from=glib-dev /builddeps/ /builddeps/
+COPY --from=pixman-dev /builddeps/ /builddeps/

Regards,
Pierrick

