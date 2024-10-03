Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFE9CF8577
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJ4q-0006hf-JE; Thu, 03 Oct 2024 06:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swJ4p-0006gk-MS
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:28:55 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swJ4o-0005xq-4O
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 06:28:55 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c881aa669fso837142a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727951332; x=1728556132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GqAHjBy+G8XruRtArgbTuGwGG+dhyxJP+rbn47KwBkM=;
 b=nvsYTexe9mOF2pwCeuEJpf9lHY1XohIOzROp6xOKUAf6+STXugbBihBhx22lom+fDG
 lIzg1ezErhu/mDH0JhMdlVFvjq2s1BONdlrafJmwG72bkBmWGxhYygVL8PVqNTVcFtmp
 s1JmK5PVUSe4z6RUruCayXoT865chTvVbyShcI10yU64up5bBmrDeRnrJx8xrwlamiPM
 vNooYyr3ZeD6mPj9XMy/EPBWnkFelQwaGZ6u8l55+hVCYC7iYfdSfAbHWSCKCjhHRypc
 fMNmkcmrkxA0iQHkyNYExHFkWY6p6U41wBoIZ97XshBLQrYDpUU2WD5fOiyiCsaZoqz+
 szBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727951332; x=1728556132;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GqAHjBy+G8XruRtArgbTuGwGG+dhyxJP+rbn47KwBkM=;
 b=xGi9ctE9TNaJ4uehSbzYNoe+v1znw5XzMGQZ0Juz21cq5/ZAB98VWLeb3l9JCuOqsC
 d2sFMoqbssdqN5mV+s+OSIPZirl2ad2jmulsCs4HSkQVfOtOQ1aMDkAxplBcouhxk+LG
 FDPjfegd0S12fq57BrdMcWqlEqfqg+qQwKUmihxvwj0uxwiCtZWFKx6HWw9Q08yZ03kR
 pgAVsmY0VaU0xwvhbX4J4n87egt/yWk7D4WgcJ6fixEXyN3eZS9gbyf/BwsLR71vM7wR
 omPbFxUURBnDe5CznTxMdcx7fxPKc6or/kKa8ZoXQjfivlXowVICs1+ov+BicOOSZ1MN
 mHCw==
X-Gm-Message-State: AOJu0YwDUdOBoD72xHElRNPLiI9wzE15QXgKr74bRQveIcTjCYiEOnaK
 YPeBtuhJcPRDIcQTYQfd9VvY+pwTNNBdVwiPyyQOSzgl3Msg+rfNWcKETCt30FENkjICQah23v4
 4
X-Google-Smtp-Source: AGHT+IFe4k5S3cYHYWnBijCi43P7h8tnmWZJaSjXTA8ZR/K/ZQnUgYciIqKVgMr8kXnh2y1fuA/m8A==
X-Received: by 2002:adf:a388:0:b0:37c:cd7e:6638 with SMTP id
 ffacd0b85a97d-37cfb8b2d6emr3579245f8f.19.1727949383202; 
 Thu, 03 Oct 2024 02:56:23 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08234048sm901584f8f.47.2024.10.03.02.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 02:56:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 923555F756;
 Thu,  3 Oct 2024 10:56:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  ncopa@alpinelinux.org,  bofh@freebsd.org,
 emulation@freebsd.org,  virtualization@gentoo.org,  dilfridge@gentoo.org,
 hi@alyssa.is,  edolstra+nixpkgs@gmail.com,  brad@comstyle.com,  Daniel P
 . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  dvzrv@archlinux.org,
 anatol.pomozov@gmail.com,  Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
In-Reply-To: <CANCZdfpWN+nYGLBtMb5xdpFW+=iGZ473UhknLN0vW6PyHSQScQ@mail.gmail.com>
 (Warner Losh's message of "Thu, 3 Oct 2024 02:55:47 -0600")
References: <871q16fq9c.fsf@draig.linaro.org>
 <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
 <CANCZdfpWN+nYGLBtMb5xdpFW+=iGZ473UhknLN0vW6PyHSQScQ@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 03 Oct 2024 10:56:21 +0100
Message-ID: <87v7y9ldbu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Warner Losh <imp@bsdimp.com> writes:

> On Thu, Oct 3, 2024 at 2:53=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote:
>
>  On Thu, Sep 26, 2024 at 8:24=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
>
>  One output from this discussion should be a clear statement that we are
>  going forward with this work and the road map. A rough roadmap might
>  look like:
>
>    - 9.2   --enable-rust is available and developers can build with it.
>            rust devices have -x-device or -rust-device CLI flags for
>            runtime selection.
>
>    - 10.x  rust devices feature complete and migration compatible, enabled
>            by default when rust compiler detected. No CLI selection
>            required as legacy portions won't be built. Any partial
>            conversions should be behind --enable-prototype-rust configure
>            flag.
>
>    - 11.x  distros have enough infrastructure to build on supported
>            platforms. Rust becomes a mandatory dependency, old C versions
>            of converted code removed from build.
>
>    - xx.y  QEMU becomes a pure native rust program and all C is expunged.
>            We may never get to this point.
>
>  We should publish the intention and the road map prominently although it
>  was unclear if a blog post would be the best place vs expanding a
>  section in the developers manual. Perhaps both make sense with a blog
>  post for the statement of intent and rough timeline and the developer
>  manual being expanded with any new rules and standards to follow?
>
>  FreeBSD is Tier 1 in rust only for amd64 (x86_64). It's Tier 2 for i386 =
(which
>  admittedly is going away) and Tier 3 for everything else.
>
> oops, I should have said it's Tier 2 with hosts for amd64, Tier 2 w/o hos=
ts and
> tier 3 for aarch64 (and everything else). In FreeBSD, amd64 and aarch64 a=
re
> tier 1 supported platforms and I got those confused. It is an important d=
ifference
> and later in my email I refer to it, so I thought a correction was in
> order.

Are there any other big projects coming down the line that have
indicated a need for rust support? Obviously you don't have to worry
about the Linux kernel but I wonder how much rust userspace you
currently have packaged? Do you have the rust-vmm vhost-device binaries
for example?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

