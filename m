Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FF2CF2576
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0IV3-0002kA-Iv; Mon, 14 Oct 2024 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0IV1-0002jv-DF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:40:27 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0IUz-0005JS-8M
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:40:27 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb3da341c9so17421011fa.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728902423; x=1729507223; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ab78TDx8C1Wbl089WnGd9yQcmNN4qg4Gs+nyo8p76U=;
 b=mH3JrnNWOAl4HagdlisUFgiUhteSMc00ukh7WLAfyoGEG4vPU/dWYGzzVrR71xyv+r
 J4SRfAsoTUxb8UzD8RyiZkAivSkAg6SZp6DZJoCHFUlrLvK8NdVOsGGzc9iGmhhN1wFn
 4CxgCS/rlRnzdHLHXBQwXBwdY4g+ESLQpcQY/M3A+vN5xwdTaWuvLtkIyPAPcEJdiR/k
 On02TvHLe3hADycNTHg2Mdmp+I5/pvhPw2Y70ZkdaOudnmQCLX7H7t0XMkXva7C1bqYQ
 wBz9771/s0PwIS8JKYOFlRYSujn36jzXPcPRyu41565uyMzUhuy5MONGPISuO0dWdHvn
 s0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728902423; x=1729507223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Ab78TDx8C1Wbl089WnGd9yQcmNN4qg4Gs+nyo8p76U=;
 b=YSi6m73fpFD4iBG/4KR++J/fxJWILMG5uY9GtReaIAvrB3ETmuUP+IawTwgYVzfbZ+
 E7dBcoAPIRAilikh8DBfngYoR9rEgkKFKVmpVoSAJDIaSpDuCOp2NRzwn4us9Y5w7yB+
 T6VgUc75qfyAUTv/VZXGFQxTcJ49VcNR7gI7CXUlNdnL4yVCbtkO+07dKLJNviEaZk5v
 E+vurpOSsi/nyD5o+kZ0r91mBP05v50E29IqUEOtSboTY/CJQseEzYOH8V9tQ2L60Gat
 HPeSgNR8TYhAEE6fdfIg807wyHe8CVB5dY+nbipxeEb4F7Ta0I3/bWpn8awSorjlc73V
 dJ2w==
X-Gm-Message-State: AOJu0YzDh9glYTsYHlB+NEyNKjOvHDtFgfdC3Yp+fxJfO5w7bwrJrEgZ
 SXuLNt3EELsPvFVptQpPHKerzaB67T/4Ddg9lT5cflhhGFChav9J891zmgXdDzpsJCiTMGrTdx9
 9JA8T8zDxgmUJZZVko4pv2aV08hV5hQ18YYUICQ==
X-Google-Smtp-Source: AGHT+IGv0T42jHK1X7BdIdOmcpizigmug8PXJpEiJqvrjX7NccTfMysB67RyF7NoOAxLlMQcNQHXyZZs6M/baII5M9Y=
X-Received: by 2002:a05:651c:2126:b0:2f7:4cf1:d6b1 with SMTP id
 38308e7fff4ca-2fb3f164ffdmr34018041fa.1.1728902422822; Mon, 14 Oct 2024
 03:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153227.81770-1-pbonzini@redhat.com>
 <CAFEAcA-2dR26AvpbV0dRob-Gc=wbN0Mh9rYYB19WH4Yr6ugXHQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-2dR26AvpbV0dRob-Gc=wbN0Mh9rYYB19WH4Yr6ugXHQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 11:40:11 +0100
Message-ID: <CAFEAcA-hhdXwfD6Bn5yR6by3h-SkYaNd6dsj8d7J-zc2zK7E8Q@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Mon, 14 Oct 2024 at 11:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 11 Oct 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > v2->v3: new patches
> > - scripts/archive-source: find directory name for subprojects
> > - docs: fix invalid footnote syntax
> > - docs: avoid footnotes consisting of just URLs
> > - docs: use consistent markup for footnotes
> >
> > ----------------------------------------------------------------
> > * first commit for Rust support
> > * add CI job using Fedora + Rust nightly
> > * fix detection of ATOMIC128 on x86_64
> > * fix compilation with Sphinx 8.1.0

> Applied, thanks.

With this applied, I find that on one of my personal
local dev branches an incremental rebuild fails, because
meson complains about not finding a new enough bindgen,
even though I did not --enable-rust. Meson also complains
about a bogus coredata.dat and we end up running meson
three times before it eventually decides the error is fatal.

It looks like meson is incorrectly defaulting to "rust
enabled" rather than "rust disabled" here ?

e104462:jammy:qemu$ make -C build/x86 -j8
make: Entering directory '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86'
config-host.mak is out-of-date, running configure
python determined to be '/usr/bin/python3'
python version: Python 3.10.12
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=1.5.0
mkvenv: checking for pycotap>=1.1.0
mkvenv: installing meson==1.5.0, pycotap==1.3.1
mkvenv: checking for sphinx>=3.4.3
mkvenv: checking for sphinx_rtd_theme>=0.5
[0/1] Regenerating build files.
WARNING: Regenerating configuration from scratch.
Reason: Coredata file
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/meson-private/coredata.dat'
references functions or classes that don't exist. This probably means
that it was generated with an old version of meson.
The Meson build system
Version: 1.5.0
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86
Build type: native build
Project name: qemu
Project version: 9.1.50
C compiler for the host machine: ccache gcc -m64 (gcc 11.4.0 "gcc
(Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0")
C linker for the host machine: gcc -m64 ld.bfd 2.38
Host machine cpu family: x86_64
Host machine cpu: x86_64
Program scripts/symlink-install-tree.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/symlink-install-tree.py)
Program sh found: YES (/usr/bin/sh)
Program python3 found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3)
Rust compiler for the host machine: rustc -C linker=gcc -C
link-arg=-m64 (rustc 1.81.0)
Rust linker for the host machine: rustc -C linker=gcc -C link-arg=-m64
ld.bfd 2.38
Program iasl found: YES (/usr/bin/iasl)
Program bzip2 found: YES (/usr/bin/bzip2)
[trimmed a bunch of uninteresting meson output]
Executing subproject keycodemapdb

keycodemapdb| Project name: keycodemapdb
keycodemapdb| Project version: undefined
keycodemapdb| Program tools/keymap-gen found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/subprojects/keycodemapdb/tools/keymap-gen)
keycodemapdb| Build targets in project: 272
keycodemapdb| Subproject keycodemapdb finished.

Program scripts/decodetree.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/decodetree.py)
Program ../scripts/modules/module_block.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/block/../scripts/modules/module_block.py)
Program ../scripts/block-coroutine-wrapper.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/block/../scripts/block-coroutine-wrapper.py)
Program scripts/modinfo-collect.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/modinfo-collect.py)
Program scripts/modinfo-generate.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/modinfo-generate.py)
Program nm found: YES
Program scripts/undefsym.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/undefsym.py)
Program scripts/rust/rustc_args.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/rust/rustc_args.py)
Program bindgen found: NO found 0.53.1 but need: '>=0.69.4'
(/home/petmay01/.cargo/bin/bindgen)

../../meson.build:3965:31: ERROR: Program 'bindgen' not found or not executable

A full log can be found at
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/meson-logs/meson-log.txt
FAILED: build.ninja
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/meson
--internal regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu .
ninja: error: rebuilding 'build.ninja': subcommand failed
[0/1] Regenerating build files.
WARNING: Regenerating configuration from scratch.
Reason: Coredata file
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/meson-private/coredata.dat'
references functions or classes that don't exist. This probably means
that it was generated with an old version of meson.

The Meson build system
Version: 1.5.0
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86
Build type: native build
Project name: qemu
Project version: 9.1.50
[more stuff trimmed]
Program scripts/undefsym.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/undefsym.py)
Program scripts/rust/rustc_args.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/rust/rustc_args.py)
Program bindgen found: NO found 0.53.1 but need: '>=0.69.4'
(/home/petmay01/.cargo/bin/bindgen)

../../meson.build:3965:31: ERROR: Program 'bindgen' not found or not executable

A full log can be found at
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/meson-logs/meson-log.txt
FAILED: build.ninja
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/meson
--internal regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu .
ninja: error: rebuilding 'build.ninja': subcommand failed
[0/1] Regenerating build files.
WARNING: Regenerating configuration from scratch.
Reason: Coredata file
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/meson-private/coredata.dat'
references functions or classes that don't exist. This probably means
that it was generated with an old version of meson.
The Meson build system
Version: 1.5.0
Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86
Build type: native build
Project name: qemu
Project version: 9.1.50
[more stuff trimmed]

Program scripts/decodetree.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/decodetree.py)
Program ../scripts/modules/module_block.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/block/../scripts/modules/module_block.py)
Program ../scripts/block-coroutine-wrapper.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/block/../scripts/block-coroutine-wrapper.py)
Program scripts/modinfo-collect.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/modinfo-collect.py)
Program scripts/modinfo-generate.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/modinfo-generate.py)
Program nm found: YES
Program scripts/undefsym.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/undefsym.py)
Program scripts/rust/rustc_args.py found: YES
(/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/python3
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/scripts/rust/rustc_args.py)
Program bindgen found: NO found 0.53.1 but need: '>=0.69.4'
(/home/petmay01/.cargo/bin/bindgen)

../../meson.build:3965:31: ERROR: Program 'bindgen' not found or not executable

A full log can be found at
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/meson-logs/meson-log.txt
ninja: error: rebuilding 'build.ninja': subcommand failed
FAILED: build.ninja
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86/pyvenv/bin/meson
--internal regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu .
make: *** [Makefile:168: run-ninja] Error 1

(Side note -- for some reason meson generates colourised
markup on its first two runs but not the third...)

-- PMM

