Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B501BE7DF19
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 18:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmync-0000O1-DJ; Mon, 02 Feb 2026 13:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vmynb-0000Nt-Ec
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:37:23 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vmynZ-0001SD-Th
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 13:37:23 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-794e0e933ccso9692197b3.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770057440; x=1770662240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lLDSH1VvnnRG3Tzj7upv7X/NbN1arCIvcL+H83Sc9w0=;
 b=dQD7S1YrlN6Q/z2gLlKxYRqNWOKe6au5bZMKUbevEp05WG4D9GEt68eqSjB7AtOfUj
 dMqeAQ3MAGo9t1oIf2PpqL52XxlquiejEUe6TURpL/2NsgNEyVAs3Lspf91uN7mx1hYY
 2MMePysPJ1RVzTJnF+IvhBZ10By3T3XLdbSKfjAlCJjEevsel8tfoxHULcOb1lBEvSMQ
 bEaPkSuJOhklQRi7YQEz1WpWEgUc9dnTcttGlABFIb36MM39NC28Q1dUc4I3yIbLwRB0
 iZspNfgvEnWRHj2QJGWnb5mnhqFCvibu2MjTffdePPodGgT3aOintse+BxGFGtY9FsfI
 CpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770057440; x=1770662240;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lLDSH1VvnnRG3Tzj7upv7X/NbN1arCIvcL+H83Sc9w0=;
 b=w4pwJQR5k3UO9MmMSOlta7/ZtbXOJlaxQ9siFlFcnMza5l1EZg6LgutflEkas/Latb
 T6flceEjIo99dcbzCh4/+s62/04h9dtGZL4XWMVVU/5Y3+Ew68RnnDbqKez2E17Qzevu
 1OwVOnSk+m3Utr3NtAlbybkBkmcsGho+4SvRlEqFoC4Qn/0FIrVFNABreiKEJlYVM/zV
 hffxoA203XcRzFWiX+73UAgRoaTh70bEITqyK6g3mL+ADhCd89lHXOE+ZMbZIhp1GqSU
 mb46NSLUfV1KlZBfytOLCgU+ADzaokglr4WRpf+K4U202xyzrEVu9h5vhxr9YfWaIAu+
 tAxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXglU/v66HcgzF8e/02T7YEGjclPm/BvOxOxY486bd9z4ypqaRQFFatnCr98JdlfzPK3MYDv2+mqj4w@nongnu.org
X-Gm-Message-State: AOJu0YzMUKlLb0501Gu7BCuH/G5IQT7z6dP65WC76MB2iWgFigkf1UFJ
 akHX0OmBeURinJGuo5MMKXF9KCSTIQe0/qhoJL+JbH8ydBd+d7p/pK26U1fQKU3bess=
X-Gm-Gg: AZuq6aIVxJMlbsaeeZngWIsmJ6I/lgNQWvkvxASRSem8cfqksiDZ/HsApZer8TD5eDD
 IatVQbjKbXnNjwqfUabqwFTCWasu9N8w6W/tDYs9gVo6dIti0JhWj42Xt7oI2vqW8WukLBQUJ02
 9vM8YPxZRUy3rSW59H8CUoaCNo/otQbgao/RZBDddD30uQz9NzP68+mMBoNtncxy6zLVtr/Szje
 TwiecpQcacZo4bzrdrZNS1YNAGu/9BkWMuNeZue27tyo63nvpiMHyx4NzWneZymLErwmbIu/3cs
 8AxFjyAjranyudd1fLrwIVeL8ERzh6qfbDyGksYddhZBHQ0x6XPG5syyjl97bYAlLY/t+2MmOWw
 9Q7megdjSs61j3y/EFK3AEtcVI07IiyZrtzS5hNEMwpPTmMd3HOVjAdnpwo3btlOTg89ssoqtYO
 dSzmB4UOZguGXCdPTBBkvr8vdsdWZ1wHKi2Sl3sBA90/NlJSj0uw42jn/v7yfz5mvoW9yOAKfhX
 VM=
X-Received: by 2002:a05:690c:10d:b0:78c:68f3:1ac3 with SMTP id
 00721157ae682-7949dfa88fdmr102349007b3.32.1770057440034; 
 Mon, 02 Feb 2026 10:37:20 -0800 (PST)
Received: from ?IPV6:2804:7f0:b403:fa9a:2608:2372:752c:1f85?
 ([2804:7f0:b403:fa9a:2608:2372:752c:1f85])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794dec12f5csm19639577b3.17.2026.02.02.10.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 10:37:19 -0800 (PST)
Message-ID: <81dd546c-2fd0-40bb-9ce3-b49855d17103@linaro.org>
Date: Mon, 2 Feb 2026 15:37:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] meson-buildoptions: Remove duplicated entry of --gdb
 in the help text
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260202174123.1943748-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260202174123.1943748-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x112b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,

On 2/2/26 14:41, Alex Bennée wrote:
> Since --gdb has recently been added to meson_options.txt, the help
> text shows up twice in the output of "./configure --help":
> 
>   $ ./configure --help | grep gdb
>     --gdb=GDB-path           gdb to use for gdbstub tests [/usr/bin/gdb]
>     --gdb=VALUE              Path to GDB
> 
> As the probed value is of interest we want to keep the configure text
> so make meson-buildoptions able to handle deferring to configure.
> 
> Fixes: b46b3818cf8 ("tests/functional: Provide GDB to the functional tests")
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

oops :)

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> ---
> AJB:
>    - This is an alternative take on Thomas's approach in 20260114155355.82096-1-thuth@redhat.com
> ---
>   scripts/meson-buildoptions.py | 9 ++++++++-
>   scripts/meson-buildoptions.sh | 1 -
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
> index e636d258e8a..9e3a75c8b11 100644
> --- a/scripts/meson-buildoptions.py
> +++ b/scripts/meson-buildoptions.py
> @@ -53,6 +53,11 @@
>       "werror",
>   }
>   
> +# Options that configure prints help for, so we can skip
> +CONFIGURE_HELP = {
> +    "gdb",
> +}
> +
>   # Builtin options that should be definable via configure.  Some of the others
>   # we really do not want (e.g. c_args is defined via the native file, not
>   # via -D, because it's a mix of CFLAGS and --extra-cflags); for specific
> @@ -189,7 +194,9 @@ def print_help(options):
>           key = cli_help_key(opt)
>           # The first section includes options that have an arguments,
>           # and booleans (i.e., only one of enable/disable makes sense)
> -        if require_arg(opt):
> +        if opt["name"] in CONFIGURE_HELP:
> +            pass
> +        elif require_arg(opt):
>               metavar = cli_metavar(opt)
>               left = f"--{key}={metavar}"
>               help_line(left, opt, 27, True)
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 3d0d1323446..e8edc5252a3 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -58,7 +58,6 @@ meson_options_help() {
>     printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
>     printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
>     printf "%s\n" '                           firmware]'
> -  printf "%s\n" '  --gdb=VALUE              Path to GDB'
>     printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
>     printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
>     printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'


