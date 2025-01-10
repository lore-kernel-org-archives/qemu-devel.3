Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9598FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW9zN-0004in-JA; Fri, 10 Jan 2025 03:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW9zM-0004h7-6i
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:03:28 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW9zK-0005eM-3a
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:03:27 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso13380355e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736496203; x=1737101003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=24Xp6RUSIdTJUHRmXTfEa1fEW/jX7uYg/bhdB+B4Aps=;
 b=LvD3lq4k0qeP9IqucweMoFfZP+rsiNcFk/dfoYMzNDLD4PtYo5/AFyqJxpcjC+065q
 i5/7+Hoi11OeY9lEzMnpK06+SRLgtrlb2T5NdyIWS3Gd3r/8B4EDddM+scoJM5WCoaq3
 Nve5DHLypfZXvQlzDaQpTYXjRLarQlsZfJJMvlzKPkqtqhhOuYJkbq5YbDMIElWkVuM3
 Q9pLJsEz309u1Xs6ALwl4T3/ltfYUG/1vE3KjcUosgvZ3QQUB2soBrxK6Vju6ulu7XNt
 0SG6bobeJ2FI+P5E9EMNu3WXZBM324byFLR82l7TO5EjvSQWeUX4kwLNch043k0gG2Ev
 H12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736496203; x=1737101003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=24Xp6RUSIdTJUHRmXTfEa1fEW/jX7uYg/bhdB+B4Aps=;
 b=gV3we/El6MwlrC2AJ2VsyX4Z1pfkSkV6ma0qINd2l7qW9HYxc14ZbTv+ND95XjOmvN
 JnYgPPXh5xBV3XDcrgXEUbw5p8AU3hstRmA8r39tQ1M7kKRiCtyUQQvSB+L7bdtUxZVi
 a+ALDPYB+7vu6deC9mIUFV09qM4P90MLXEpKOLnQMBSgSDtJTTYmEVW4frgDrOSiUfxZ
 rGCeqccLhUmSXnDBPaXbzpPwQmgCXDczbq/A/9CbRl93r9Yc+LDELJo+AdxChqPso07A
 Bf25V1i1bJmUEbH092M2nJKD+884JOclWOpV6Xeo4vF1rDYTO7i7XCIyg2ZMM1XgXhC8
 oucQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTThpNm3YCVfFSBUMOXYrILnICdyx1UJ2kKYI9a5Mvds8VE8WmrqTdW6U3M959DU4XnSi8YYQWhTxC@nongnu.org
X-Gm-Message-State: AOJu0YwJ1XqfppzcIdYv96y0VAP7g03x4mzdCi7Py8jfDi5qvd5920o6
 EcbUnd4z3UcbI3LgiCFsgw3GNGgeMifY1dEmL2ZVQnBCjlxfeYz0xmoW/n9royQ=
X-Gm-Gg: ASbGnctYu2XMFoAAQAU4kZexuNZ/koV6+LzSpdSwD2WSI9eLAKu4+8mKCa2Kk5Q+jhj
 HJTWiNjkW7cZ19RxhLcDoBa9TJXmDHT+yxRNzQrIHX/qqePpS0uM+wHxPhy3Jtq/7vetAqCCcff
 iHBe0QylnTZXvVTqgmUPG/e0+QratFWh8HLH9+BLe+YhIJ1/vL56hrkBgCYYNc8plk9QVuBnBxO
 n9DsO5qXo9+7hziu6vIEOG9DnMGgGdSTNVuRY0WVmmy824CBX4b+gs2xqbfshMFN1dQmYthlSJF
 NJgixfKzTqLW4Fm7bOO4pUyoBiI=
X-Google-Smtp-Source: AGHT+IHar2s6b+o5E6tIAwRL6iTUaPJjOPf2msJBAXfaSXT5Ri/rrLu6MNtHhdNsccJF7uC3OuGJzA==
X-Received: by 2002:a05:600c:19ce:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-436e26f857fmr94822905e9.31.1736496203380; 
 Fri, 10 Jan 2025 00:03:23 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89e14sm78722395e9.33.2025.01.10.00.03.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 00:03:22 -0800 (PST)
Message-ID: <c51d143c-1936-4661-af4a-21c3447579ec@linaro.org>
Date: Fri, 10 Jan 2025 09:03:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] plugins: enable linking with clang/lld
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241128201510.869974-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+Akihiko & Yonggang for
https://lore.kernel.org/qemu-devel/20201006120900.1579-1-luoyonggang@gmail.com/

On 28/11/24 21:15, Pierrick Bouvier wrote:
> Windows uses a special mechanism to enable plugins to work (DLL delay
> loading). Option for lld is different than ld.
> 
> MSYS2 clang based environment use lld by default, so restricting to this
> config on Windows is safe, and will avoid false bug reports.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   meson.build                   |  5 +++++
>   contrib/plugins/meson.build   |  2 +-
>   plugins/meson.build           | 24 ++++++++++++++++++++----
>   tests/tcg/plugins/meson.build |  3 +--
>   4 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 97cefb7cdd7..f286fb4f4a0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -354,6 +354,11 @@ elif host_os == 'sunos'
>     qemu_common_flags += '-D__EXTENSIONS__'
>   elif host_os == 'haiku'
>     qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
> +elif host_os == 'windows'
> +  # plugins use delaylib, and clang needs to be used with lld to make it work.
> +  if compiler.get_id() == 'clang' and compiler.get_linker_id() != 'ld.lld'
> +    error('On windows, you need to use lld with clang - use msys2 clang64/clangarm64 env')
> +  endif
>   endif
>   
>   # Choose instruction set (currently x86-only)
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 63a32c2b4f0..484b9a808c8 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -12,7 +12,7 @@ if get_option('plugins')
>         t += shared_module(i, files(i + '.c') + 'win32_linker.c',
>                           include_directories: '../../include/qemu',
>                           link_depends: [win32_qemu_plugin_api_lib],
> -                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
> +                        link_args: win32_qemu_plugin_api_link_flags,
>                           dependencies: glib)
>       else
>         t += shared_module(i, files(i + '.c'),
> diff --git a/plugins/meson.build b/plugins/meson.build
> index 98542e926f8..d60be2a4d6d 100644
> --- a/plugins/meson.build
> +++ b/plugins/meson.build
> @@ -17,14 +17,15 @@ if not enable_modules
>         capture: true,
>         command: ['sed', '-ne', 's/^[[:space:]]*\\(qemu_.*\\);/_\\1/p', '@INPUT@'])
>       emulator_link_args += ['-Wl,-exported_symbols_list,plugins/qemu-plugins-ld64.symbols']
> +  elif host_os == 'windows' and meson.get_compiler('c').get_id() == 'clang'
> +    # LLVM/lld does not support exporting specific symbols. However, it works
> +    # out of the box with dllexport/dllimport attribute we set in the code.
>     else
>       emulator_link_args += ['-Xlinker', '--dynamic-list=' + qemu_plugin_symbols.full_path()]
>     endif
>   endif
>   
>   if host_os == 'windows'
> -  dlltool = find_program('dlltool', required: true)
> -
>     # Generate a .lib file for plugins to link against.
>     # First, create a .def file listing all the symbols a plugin should expect to have
>     # available in qemu
> @@ -33,12 +34,27 @@ if host_os == 'windows'
>       output: 'qemu_plugin_api.def',
>       capture: true,
>       command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
> +
>     # then use dlltool to assemble a delaylib.
> +  # The delaylib will have an "imaginary" name (qemu.exe), that is used by the
> +  # linker file we add with plugins (win32_linker.c) to identify that we want
> +  # to find missing symbols in current program.
> +  win32_qemu_plugin_api_link_flags = ['-Lplugins', '-lqemu_plugin_api']
> +  if meson.get_compiler('c').get_id() == 'clang'
> +    # With LLVM/lld, delaylib is specified at link time (-delayload)
> +    dlltool = find_program('llvm-dlltool', required: true)
> +    dlltool_cmd = [dlltool, '-d', '@INPUT@', '-l', '@OUTPUT@', '-D', 'qemu.exe']
> +    win32_qemu_plugin_api_link_flags += ['-Wl,-delayload=qemu.exe']
> +  else
> +    # With gcc/ld, delay lib is built with a specific delay parameter.
> +    dlltool = find_program('dlltool', required: true)
> +    dlltool_cmd = [dlltool, '--input-def', '@INPUT@',
> +                   '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
> +  endif
>     win32_qemu_plugin_api_lib = configure_file(
>       input: win32_plugin_def,
>       output: 'libqemu_plugin_api.a',
> -    command: [dlltool, '--input-def', '@INPUT@',
> -              '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
> +    command: dlltool_cmd
>     )
>   endif
>   specific_ss.add(files(
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index f847849b1b7..87a17d67bd4 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -5,9 +5,8 @@ if get_option('plugins')
>         t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
>                           include_directories: '../../../include/qemu',
>                           link_depends: [win32_qemu_plugin_api_lib],
> -                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
> +                        link_args: win32_qemu_plugin_api_link_flags,
>                           dependencies: glib)
> -
>       else
>         t += shared_module(i, files(i + '.c'),
>                           include_directories: '../../../include/qemu',


