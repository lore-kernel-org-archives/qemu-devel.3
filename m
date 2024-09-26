Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2099CDE012
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 15:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stq2G-0004Gw-E7; Thu, 26 Sep 2024 11:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1stq28-0004F7-T9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 11:03:58 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1stq27-0003di-42
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 11:03:56 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3e034fac53bso603788b6e.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727363033; x=1727967833; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BujPZmf8NWFlSlBx3lR2BWQ1g12rkES/UEZe9LkULwg=;
 b=G6F66qr2+xCmLO1pgQr4psrwGa7INM0vgPIIqxNKN+eZgO5KynZLOWIvWSb2u1YuYR
 4nLsVawbEbQjO1TjH7v2GuDc42ZR6cuZVF9qw4DCLEDLLnekY5H9QhglLmQMTedXzUHM
 hIY/ffj45UbgtNFuqa0YqbD7WEIXgF6kBLFtSJdlqn3Rpj0YtdFyRImtjWRj8ZwRtRys
 VzzMPQz2HzOYFrqD5oEOSoqS5CJajgEw0GoGz4xyYvXoZVEcW1wW0QzSlVM1eAYvbFS+
 nvZAoT5OpzIDyEcVJFkE8KyZyDXoklNr3QyfCMieVTomm1qeOaOV5yP6zcw/Wfz9/igX
 Odag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727363033; x=1727967833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BujPZmf8NWFlSlBx3lR2BWQ1g12rkES/UEZe9LkULwg=;
 b=I3etzz1xIyFSANrM1NKEu1BXyF/ZIpDamFZAD9swe5znCREhNzh2+VvDGHDNRwzwYr
 Z0TZMrT2L18w6UWptzZgi7LUVd6nyz8/+EMX35/UE5y4gZjFoqhsOLW5K0KuhjBfKljS
 SccgTh2Hpbiye9iUUrYBYff7bN1n5h6ULcA51sblS6pSCD1WRn/E8anBThBjfC+WoqlP
 P5h05TaLL4dVhSJTnsd1YUdtstkROwSjksklaRVHsTyPc8gRd90VIIYCtSxNmi1W8+Qi
 LC9g5tsoXpqZOwSiDKrMKDKmSpVbRnsnvVZDLRzQ/fwirWD6qpOlf07JwuP9G1B2PFhH
 kUdg==
X-Gm-Message-State: AOJu0Yw/Hrrs6Yj/p+3n5n9tWUfTZj0245KMukF+RBsM4AI7CIJEsef1
 Phjw43FegiS358SH9JFORXhk683firzx3ryd9u2nLuIxwf8oSwnxTo5pOZ05epZXKNEdjGV/qbs
 Sm+ntKistVSY05DqDEKcf3drfZSQ=
X-Google-Smtp-Source: AGHT+IHPDgGypSOtmz49ZJ1yFvqQYC7XSCLy71+Tz2/t8UnM/5J0cGzxxUDhTHlTbdlb/gjjUHlOm4BPj5MyxILE+MM=
X-Received: by 2002:a05:6808:1b07:b0:3e0:6809:ab27 with SMTP id
 5614622812f47-3e29b813eadmr5825888b6e.41.1727363033215; Thu, 26 Sep 2024
 08:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <871q16fq9c.fsf@draig.linaro.org>
In-Reply-To: <871q16fq9c.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 26 Sep 2024 11:03:40 -0400
Message-ID: <CAJSP0QVB+e1JSyQ3iMRivyh=ufyDkz12AESvJhoPnYJEnt9eug@mail.gmail.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, 
 Michael Tokarev <mjt@tls.msk.ru>, ncopa@alpinelinux.org, bofh@freebsd.org, 
 emulation@freebsd.org, virtualization@gentoo.org, dilfridge@gentoo.org, 
 hi@alyssa.is, edolstra+nixpkgs@gmail.com, brad@comstyle.com, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 26 Sept 2024 at 10:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> What are candidates for conversion?

"Conversion" means "rewrite in Rust" to me. There are other ways of
integrating Rust without converting existing code:

- Writing new subsystems in Rust where there is no existing C code.
- Adding Rust bindings to existing subsystems so that new code (e.g.
device models) can optionally be written in Rust while still allowing
new C code.

Let's speak more broadly about "integrating Rust" rather than
"conversion", which is just one of the ways to use Rust in QEMU.

> Hanna and Stefan were keen to see more use of Rust in the block layer.
> Hanna cautioned that it was hard to find a reasonable starting point for
> the conversion. Originally she had started with the core sub-system but
> it quickly ran into thousands of lines of code which would be hard to
> get well reviewed before switching for such a crucial sub-system. Maybe
> this is an ordering problem and it would make more sense to start with
> individual block drivers first and work up from there.

Hanna's Rust Storage Daemon (basically a Rust version of the QEMU
block layer as an external process) is here:
https://gitlab.com/hreitz/rsd

> Another potential area for conversion was the VirtIO device and
> vhost-user code which could expect to re-use a lot of the crates from
> the rust-vmm project. However this did bring up the point of maintainer
> buy in. Stefan brought up the example of the simpletrace rewrite which
> while it may have brought some advantages he felt he was unable to take
> as a maintainer as he was not familiar with Rust at that point.

Familiarity with Rust was not the issue with simpletrace. I had
already worked on libblkio in Rust and was able to understand the Rust
simpletrace patches.

It was a question of when rewriting in Rust is appropriate. Surprising
maintainers with a rewrite is risky because they may not be convinced
by the rewrite after all the work to write it has been done.

In the case of simpletrace there wasn't a clear benefit to a rewrite:
performance was potentially better in Rust (performance hadn't been a
problem for users though) but usability was impacted by converting a
scriptable Python module to Rust (requiring users to rewrite their
scripts). The rewrite was dropped.

What I tried to express at the Rust BoF was: talk to maintainers
before embarking on a rewrite.

> With relative inexperience there was a concern we could inadvertently
> introduce technical debt in the code base (C-like Rust vs Rusty rust).
> What can we do to mitigate that issue?

My suggestion is that every `unsafe` needs a comment explaining why it
is safe. That increases the cost of using `unsafe` and encourages safe
abstractions.

There are plenty of unidiomatic ways of using Rust, but none are as
bad as sprinkling `unsafe` everywhere (i.e. writing C in Rust) since
that's how undefined behavior is introduced.

Stefan

