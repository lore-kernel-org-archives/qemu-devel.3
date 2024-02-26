Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B85BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ree31-0008Gd-8W; Mon, 26 Feb 2024 11:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ree2v-0008F3-72
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:41:41 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ree2t-0004sJ-3G
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:41:40 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-59fd69bab3bso1383977eaf.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708965697; x=1709570497; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdj330hZUi46sTEk6G76lbYswsSOlJd0DGF2++KiUt0=;
 b=KVMaVPcDaTTCxCf54g03Nh+Zo+nh/d/oV4t80EKJvgS9FB+t8GrChTO7nb7uiSFBWu
 P5e/OthwTFacbjLv8c3ZCV5bRNzx2tcsU0bmgtti3+ZODpsE+6iyLdMDrqe6v+9+XOiv
 2GqoFdXkyq/dAl8T1kKRdJBn7chtNjA2jwKbyFomG5q4kDrlx8XrzxHH55uipJzkkxpy
 p8uajbsDqCV/CNMNIq5jYYeQCYLKSwusZvGRFq4QXWAdJzsQXxZGH6C5yu4gp5y5E7DH
 +1IoqkWAKHqgsKO6GX+MuafWNqYIPR6sbjf4rWVhIM/CheErapRlTMm2ZTmWqPuRNiBI
 lQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708965697; x=1709570497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdj330hZUi46sTEk6G76lbYswsSOlJd0DGF2++KiUt0=;
 b=nkqA5ei6TWxdBE5nGbpUwTrgkc4d+Pn27vmT0zhdR0xpMAAv8agrKLSNlQOndRYHPQ
 Hp1z3fCJEYNbkc3TlGBk/Pd5hWz49S13YGz58wGXaKOpyocHa1/26kqwQZP5wnXXPYdA
 v17fozMbz/diryNEkg4bZ8b++j63BW6RL8nWSvS8UPtK5BPXL1wvuwb48E3Dm6pZrpGY
 z2UBco//Kh59ndC5tQHSoT2YUq5LxS3uGQs98f4+nXQ+hC45TZ9Wl/yjdg/V0tbCrdZx
 58/EvoZWLAopauC17w7lzfm7U2NFU+HZdaJVoP0USSFQ0Rh3ucg86lLzwdWeUIv+ur0F
 b9/Q==
X-Gm-Message-State: AOJu0YzgbzWZto5fTYJ2XN2XfN9Ki+8tGe+MGATil8cX8Vdjowq0vjoi
 o1hrrzDVccLe3BiuZWmG7v/vGlpmO5lmUkGBme/nPhhUG0M3R0ozuCrIDJc+eaeHl5NRxWZur79
 HfYzNGRpExFP/2+d7uayPOQlC2FQ=
X-Google-Smtp-Source: AGHT+IFDMAPr0yoYnNgw3OqvPpF+1xIXZpxsGIawX99/bQe943YwnI/0MMai4UYE9NLVfoGqZzaHMMQ8bllBquBn8HY=
X-Received: by 2002:a05:6820:2602:b0:5a0:5fe8:e45f with SMTP id
 cy2-20020a056820260200b005a05fe8e45fmr4865393oob.9.1708965696955; Mon, 26 Feb
 2024 08:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20240217131934.2638382-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20240217131934.2638382-1-manos.pitsidianakis@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 26 Feb 2024 11:41:24 -0500
Message-ID: <CAJSP0QXBPPeuVW2vs0xP6m+-QMMsszSwjcN8Br3KH7KQXrugrg@mail.gmail.com>
Subject: Re: [PATCH] Print tool binary names in ./configure --help
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, 17 Feb 2024 at 08:21, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> configure --help currently outputs the following line for the tools
> option:
>
> -->8-------------------------------------------------------------------
> =E2=96=91=E2=96=91tcg=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91TCG=E2=96=
=91support=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91
>   tools           build support utilities that come with QEMU
> =E2=96=91=E2=96=91tpm=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91TPM=E2=96=
=91support=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91
> =E2=96=91=E2=96=91u2f=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91U2F=E2=96=
=91emulation=E2=96=91support=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91
> ---8<------------------------------------------------------------------
>
> Which does not convey information if you don't already know what these
> utilities are going to be.
>
> This commit uses script/meson-buildoptions.py to parse the hard-coded
> test binary names in meson.build and update the --help output to include
> their names, like as follows:
>
> -->8-------------------------------------------------------------------
> =E2=96=91=E2=96=91tcg=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91TCG=E2=96=
=91support=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91
>   tools           build utility tool binaries like qemu-edid, qemu-img,
>                   qemu-io, qemu-nbd, qemu-bridge-helper, qemu-pr-helper
> =E2=96=91=E2=96=91tpm=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91TPM=E2=96=
=91support=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91
> =E2=96=91=E2=96=91u2f=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91U2F=E2=96=
=91emulation=E2=96=91support=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91
> ---8<------------------------------------------------------------------
>
> Since it uses the meson.build AST to find those values, only hard-coded
> binary names are selected and the description is non-exhaustive.

How about updating the description in meson_options.txt to what's
shown above and dropping the meson introspect part?

I think the complexity is a little high given that the generated list
is incomplete. Less custom build system code makes it easier to
understand and reduces the chance of breakage.

>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  Makefile                      |  8 +++++--
>  meson_options.txt             |  2 +-
>  scripts/meson-buildoptions.py | 43 ++++++++++++++++++++++++++++++++---
>  scripts/meson-buildoptions.sh |  3 ++-
>  4 files changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 8f36990335..79ab594c4b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -128,8 +128,12 @@ Makefile.mtest: build.ninja scripts/mtest2make.py
>  .PHONY: update-buildoptions
>  all update-buildoptions: $(SRC_PATH)/scripts/meson-buildoptions.sh
>  $(SRC_PATH)/scripts/meson-buildoptions.sh: $(SRC_PATH)/meson_options.txt
> -       $(MESON) introspect --buildoptions $(SRC_PATH)/meson.build | $(PY=
THON) \
> -         scripts/meson-buildoptions.py > $@.tmp && mv $@.tmp $@
> +       { printf '{"buildoptions":'; \
> +               $(MESON) introspect --buildoptions $(SRC_PATH)/meson.buil=
d 2> >(grep -v "Unable to evaluate subdir(\[\])" >&2) \
> +               && printf ',"ast":' \
> +               && $(MESON) introspect --ast $(SRC_PATH)/meson.build 2> >=
(grep -v "Unable to evaluate subdir(\[\])" >&2) \
> +               && printf "}" ; } \
> +               | $(PYTHON) scripts/meson-buildoptions.py > $@.tmp && mv =
$@.tmp $@
>  endif
>
>  # 4. Rules to bridge to other makefiles
> diff --git a/meson_options.txt b/meson_options.txt
> index 0a99a059ec..53a8b6b3e2 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -58,7 +58,7 @@ option('guest_agent', type : 'feature', value : 'auto',
>  option('guest_agent_msi', type : 'feature', value : 'auto',
>         description: 'Build MSI package for the QEMU Guest Agent')
>  option('tools', type : 'feature', value : 'auto',
> -       description: 'build support utilities that come with QEMU')
> +       description: 'build utility tool binaries')
>  option('qga_vss', type : 'feature', value: 'auto',
>         description: 'build QGA VSS support (broken with MinGW)')
>
> diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.p=
y
> index 4814a8ff61..4abdfc1d05 100644
> --- a/scripts/meson-buildoptions.py
> +++ b/scripts/meson-buildoptions.py
> @@ -24,6 +24,7 @@
>  import textwrap
>  import shlex
>  import sys
> +from collections import deque
>
>  # Options with nonstandard names (e.g. --with/--without) or OS-dependent
>  # defaults.  Try not to add any.
> @@ -182,7 +183,7 @@ def cli_metavar(opt):
>      return "CHOICE"
>
>
> -def print_help(options):
> +def print_help(options, tools: list[str]):
>      print("meson_options_help() {")
>      feature_opts =3D []
>      for opt in sorted(options, key=3Dcli_help_key):
> @@ -212,6 +213,8 @@ def print_help(options):
>      sh_print()
>      for opt in sorted(feature_opts, key=3Dcli_option):
>          key =3D cli_option(opt)
> +        if key =3D=3D "tools":
> +            opt["description"] +=3D " like " + ", ".join(tools)
>          help_line(key, opt, 18, False)
>      print("}")
>
> @@ -242,7 +245,41 @@ def print_parse(options):
>      print("}")
>
>
> -options =3D load_options(json.load(sys.stdin))
> +# Returns hard-coded executables from meson.build AST
> +def tool_executables(d: dict) -> list[str]:
> +    def is_executable_fn_call(i: dict) -> bool:
> +        if not (
> +            "name" in i
> +            and i["name"] =3D=3D "executable"
> +            and "node" in i
> +            and i["node"] =3D=3D "FunctionNode"
> +            and "positional" in i["args"]
> +            and len(i["args"]) > 0
> +        ):
> +            return False
> +        first_arg =3D i["args"]["positional"][0]
> +        return first_arg["node"] =3D=3D "StringNode"
> +
> +    stack =3D deque([d])
> +    while len(stack) > 0:
> +        item =3D stack.popleft()
> +        if isinstance(item, dict):
> +            # Check if this is an `executable(....)` function call.
> +            if is_executable_fn_call(item):
> +                name =3D item["args"]["positional"][0]["value"]
> +                if name not in ("qemu-keymap",):
> +                    yield name
> +            else:
> +                stack.extend(item.values())
> +            continue
> +        if isinstance(item, list):
> +            stack.extend(item)
> +            continue
> +
> +
> +input_string =3D json.load(sys.stdin)
> +options =3D load_options(input_string["buildoptions"])
> +bins =3D list(tool_executables(input_string["ast"]))
>  print("# This file is generated by meson-buildoptions.py, do not edit!")
> -print_help(options)
> +print_help(options, bins)
>  print_parse(options)
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index 680fa3f581..ac1fad55df 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -185,7 +185,8 @@ meson_options_help() {
>    printf "%s\n" '  spice-protocol  Spice protocol support'
>    printf "%s\n" '  stack-protector compiler-provided stack protection'
>    printf "%s\n" '  tcg             TCG support'
> -  printf "%s\n" '  tools           build support utilities that come wit=
h QEMU'
> +  printf "%s\n" '  tools           build utility tool binaries like qemu=
-edid, qemu-img,'
> +  printf "%s\n" '                  qemu-io, qemu-nbd, qemu-bridge-helper=
, qemu-pr-helper'
>    printf "%s\n" '  tpm             TPM support'
>    printf "%s\n" '  u2f             U2F emulation support'
>    printf "%s\n" '  usb-redir       libusbredir support'
>
> base-commit: da96ad4a6a2ef26c83b15fa95e7fceef5147269c
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>

