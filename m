Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595A8C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4yyM-000593-Rv; Wed, 16 Apr 2025 05:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4yyJ-000582-H4
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:22:19 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4yyF-0000pT-RT
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:22:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso32571795e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744795333; x=1745400133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O9DmSrSvp+/D4+V2cx49ZZK5Qu5Xoook/Yq/s+DSIa4=;
 b=E0jzvr9etwehs0O6eyMovhCzKlo+MDtNXk+AMv75DHvWprzpcDopkvHfssbwICgt/8
 6umSGkSmFkWwp+qjjudJRk4/KryY4tJfi0fYeW6smGn1ojJJh8cZui1/Wt/AUVjizCtV
 xSRyJsVo97bFKw4k3lPZ/e+EQy/c4vJgpJTk3mMlpGPyiIMJEkhLMg3ssN+lmGNya0Ew
 eiuTFTuZH73sMYQiNlndKhxLo52+QNRdRgV0NIGFaRRfiN9uzEjZtcaRlGOENx+5HMJT
 kGBw3/sWrR8S5EeULOx5F26+pp31nKHND7nnm6u1ucMMMJVypP04IQgujLfu+7vMd6Es
 MzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744795333; x=1745400133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9DmSrSvp+/D4+V2cx49ZZK5Qu5Xoook/Yq/s+DSIa4=;
 b=iB/DliTUVXL3udETy5tGIAcSthunQGrAaHzaWofPRFJpitfkVtl8xHNq+hixoyle21
 TVknrwP5aUUMtEshE9s1i+a92CFPmU3kPJl5m+C4WHX7V/bvglR9l0SaZ37i7qZKgcL7
 sgQAfuwBlB6LsJ+fmkNSI7vXVhuyZsDq8iJYfv7On6g/UUGdqWnNyMAWfbZrlREnrhBY
 nVonlqO43gUYi/aNOcPm62ulLgcycJrB8I/M8ELFG4K1rKk556Ku7kbSYRAriHshDY3k
 Ol6+M+KFk1qgYmJ/es0rmyhOVQmRRiTUhyIPwRdONU0RAhRElCshJnen6K+btpfMGtyQ
 unXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJlTNZW/6wxIwQualIfXic7PI3RbNVVDUwbfERMGtGg9/yZehmirN2xunpwHVhRWbhMxFJLTgGCoY@nongnu.org
X-Gm-Message-State: AOJu0YzncZr1RgeY0ZNM7T2e+NTHZ7iLMAXzKPjtwM0GEKv6TphPlwOM
 nOK00bSefhrOuFjsHBGCRKgVuVVcX9fdnEPBhawKApVG4M84FHjw0nshicF7aY8=
X-Gm-Gg: ASbGncsF50vD8pHYEJN/HgjnymVEfh0bQV2JhhyTpWzsrx45nIALbI2zvgIdpappzG5
 3OyhMJNVbwGUSOH8GuRlwqWKk+zLSwMQmEXj4icv/1vn+jkbo+r2SchKoBfxRePvpySrDKsg422
 eI/mGcoMmmqplnCMqkMqE/KsgZk3AZ2rv7IXOELNd/6u5wHwK9ZdfPM5juhLr1Za4HYCMOB/bxo
 1XYg5nR3sDR9OKKGzROMcOMbgLWSyaEpWZyp8Xg8vpt8xFK9NRe+BYm+ZmrvJOiP0xz3Kg2oZDC
 9ePCcXU2D45twZKaUbbMkYwX13jCVRmhMsmUCo7zA8zaSNlAFGNY1U+Kx20kM1XnoGmIJY7cAFM
 RrRYqwa8yasJyAQ==
X-Google-Smtp-Source: AGHT+IH/5/Fc9I2DlZUhZUcAfXrdb3493WfekOWHZJ/g9slKP5w0pM4osO2SziGppYoFnMSTAiNOqQ==
X-Received: by 2002:a05:600c:c0e:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-4405d6168ccmr10836195e9.8.1744795333597; 
 Wed, 16 Apr 2025 02:22:13 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f2b72sm15214025e9.19.2025.04.16.02.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 02:22:12 -0700 (PDT)
Message-ID: <c00e2bc8-3248-44a7-bf4a-87441f6f9c19@linaro.org>
Date: Wed, 16 Apr 2025 11:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] meson: Add wasm build in build scripts
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <835dfef61307a941cdb58331607c308238d37e00.1744787186.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <835dfef61307a941cdb58331607c308238d37e00.1744787186.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 16/4/25 10:14, Kohei Tokunaga wrote:
> has_int128_type is set to false on emscripten as of now to avoid errors by
> libffi. Tests are disabled on emscripten because they rely on host
> features that aren't supported by emscripten (e.g. fork and unix
> socket).
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   configs/meson/emscripten.txt  |  8 ++++++++
>   configure                     |  7 +++++++
>   meson.build                   | 25 ++++++++++++++++++++-----
>   meson_options.txt             |  2 +-
>   scripts/meson-buildoptions.sh |  2 +-
>   stubs/meson.build             |  4 ++++
>   6 files changed, 41 insertions(+), 7 deletions(-)
>   create mode 100644 configs/meson/emscripten.txt


> diff --git a/meson.build b/meson.build
> index 41f68d3806..c9aa5016d6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -50,9 +50,9 @@ genh = []
>   qapi_trace_events = []
>   
>   bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
> -supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
> +supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
>   supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
> -  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
> +  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32']
>   
>   cpu = host_machine.cpu_family()
>   
> @@ -353,6 +353,8 @@ foreach lang : all_languages
>         # endif
>         #endif''')
>       # ok
> +  elif compiler.get_id() == 'emscripten'
> +    # ok
>     else
>       error('You either need GCC v7.4 or Clang v10.0 (or XCode Clang v15.0) to compile QEMU')
>     endif
> @@ -470,7 +472,10 @@ endif
>   # instead, we can't add -no-pie because it overrides -shared: the linker then
>   # tries to build an executable instead of a shared library and fails.  So
>   # don't add -no-pie anywhere and cross fingers. :(
> -if not get_option('b_pie')
> +#
> +# Emscripten doesn't support -no-pie but meson can't catch the compiler
> +# warning. So explicitly omit the flag for Emscripten.
> +if not get_option('b_pie') and host_os != 'emscripten'
>     qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
>   endif
>   
> @@ -514,6 +519,8 @@ ucontext_probe = '''
>   supported_backends = []
>   if host_os == 'windows'
>     supported_backends += ['windows']
> +elif host_os == 'emscripten'
> +  supported_backends += ['wasm']
>   else
>     if host_os != 'darwin' and cc.links(ucontext_probe)
>       supported_backends += ['ucontext']
> @@ -2962,7 +2969,9 @@ config_host_data.set('CONFIG_ATOMIC64', cc.links('''
>       return 0;
>     }''', args: qemu_isa_flags))
>   
> -has_int128_type = cc.compiles('''
> +# has_int128_type is set to false on Emscripten to avoid errors by libffi
> +# during runtime.
> +has_int128_type = host_os != 'emscripten' and cc.compiles('''
>     __int128_t a;
>     __uint128_t b;
>     int main(void) { b = a; }''')
> @@ -3774,6 +3783,8 @@ if have_block
>     # os-win32.c does not
>     if host_os == 'windows'
>       system_ss.add(files('os-win32.c'))
> +  elif host_os == 'emscripten'
> +    blockdev_ss.add(files('os-wasm.c'))
>     else
>       blockdev_ss.add(files('os-posix.c'))
>     endif
> @@ -4456,7 +4467,11 @@ subdir('scripts')
>   subdir('tools')
>   subdir('pc-bios')
>   subdir('docs')
> -subdir('tests')
> +# Tests are disabled on emscripten because they rely on host features that aren't
> +# supported by emscripten (e.g. fork and unix socket).
> +if host_os != 'emscripten'
> +  subdir('tests')
> +endif
>   if gtk.found()
>     subdir('po')
>   endif
> diff --git a/meson_options.txt b/meson_options.txt
> index 59d973bca0..45772484cc 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -34,7 +34,7 @@ option('fuzzing_engine', type : 'string', value : '',
>   option('trace_file', type: 'string', value: 'trace',
>          description: 'Trace file prefix for simple backend')
>   option('coroutine_backend', type: 'combo',
> -       choices: ['ucontext', 'sigaltstack', 'windows', 'auto'],
> +       choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
>          value: 'auto', description: 'coroutine backend to use')

Does wasm depend on TCI at this point (no TCG backend)? If so, should
we check TCI is enabled? (I wonder if configuring with the
--disable-tcg-interpreter option succeed).

