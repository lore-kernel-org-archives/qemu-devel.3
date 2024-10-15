Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCB1CFC271
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 07:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0btf-0003I5-8L; Tue, 15 Oct 2024 03:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0btd-0003HG-5a
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 03:23:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0btb-0002Pe-3z
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 03:23:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-430576ff251so43872745e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728976985; x=1729581785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/2K0ewoYyCHZ5DwjqrySt79/viBqdA6IcoUH48TXYY=;
 b=vwe1RWw4c74oYTzWmL2OfCCl81cxDGK8OJsGuGLnD8iBn1DzsUaXotf9uNTCdUaCZC
 SsAvvMPFoBHVwjwnuQvWsd3VLRzQQV3jRkaAVFEzmp0qP34LtrizSgivIJsyzfaAzwL/
 fNLzChUrreAizu8uQVf9G1CVuPxPn4hR6rjDqhdQHuIhXjJLuSmQjnuTNJVUI+kgw9ul
 6shwtk3kJBa2nLklt/lsW4uysS/6jcOiF2gQZU62fXis6nxU8llFws/OB237er8DVMXH
 C3oebjJ2rykLNt4iu/r5p5TH+m/RHNqhYYiFj/WPcRi409+yrZbieeg+qha6pckSL1ma
 TKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728976985; x=1729581785;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N/2K0ewoYyCHZ5DwjqrySt79/viBqdA6IcoUH48TXYY=;
 b=H5YP5AspyVO2ZcpLR6vj1g03jD7WP0q6loZos3irii5J6FyteTyB96wM/bI81GRgye
 QafTYFu9Umq0QkK9dxPuMF2uUoHIZzFGKOz8dc7YU/27mwS2lmAdzOlb/U6X2Hsjzwmx
 hAIuPH266tnOGqiP/cBmbONdKgaFcbCF+GWuhA7OaFfPhpZKxlFtUeuXFnR+mVNTddgX
 4NTAFcWox9jv3jvcHffmrYs6sKJHSslyx9U9E6LILSJ06QghDCtZNmBu7MKmIlTRzPg6
 3lp2h4h1iy/qgLtleTBfc6qStu1ttvtkDRIlEtbcBTh24Gv2m2blCo99R7QhdvGhAbWA
 ynXg==
X-Gm-Message-State: AOJu0YwE4XBBBjn9LsbR827e09/esWwoxr/W2Rvqnmt0qVH++VfTz74N
 0g+QA2EwWHzcAddHk1X33ZfxLt4Hq8d219iSjG3EnRo7RRGJAscDPv4RifyQPSY=
X-Google-Smtp-Source: AGHT+IEXZfyrkfqm9Mdg7bMWqYQnzKq9Dd9irQTDfWYvI/flOOt+JIWlqiZy1nE6zMwp8W4L9Nho/g==
X-Received: by 2002:a05:600c:1551:b0:42f:8515:e48c with SMTP id
 5b1f17b1804b1-4311deb6142mr123586585e9.3.1728976984660; 
 Tue, 15 Oct 2024 00:23:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56eaa7sm9049875e9.26.2024.10.15.00.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 00:23:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E4C45F753;
 Tue, 15 Oct 2024 08:23:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  ncopa@alpinelinux.org,  bofh@freebsd.org,
 virtualization@gentoo.org,  dilfridge@gentoo.org,  hi@alyssa.is,
 edolstra+nixpkgs@gmail.com,  brad@comstyle.com,  Daniel P . =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  dvzrv@archlinux.org,
 anatol.pomozov@gmail.com,  Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
In-Reply-To: <CANCZdfq85yJTkTR3TZQ=XmaeLmfxrQCQj6g-0viFaCidsOKwWQ@mail.gmail.com>
 (Warner Losh's message of "Mon, 14 Oct 2024 16:45:10 -0600")
References: <871q16fq9c.fsf@draig.linaro.org>
 <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
 <CANCZdfpWN+nYGLBtMb5xdpFW+=iGZ473UhknLN0vW6PyHSQScQ@mail.gmail.com>
 <87v7y9ldbu.fsf@draig.linaro.org>
 <CANCZdfq85yJTkTR3TZQ=XmaeLmfxrQCQj6g-0viFaCidsOKwWQ@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 15 Oct 2024 08:23:02 +0100
Message-ID: <87zfn5akyx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

> [[ sorry for the lag $LIFE has been over-full lately ]]

No worries.
>=20=20
>  Obviously you don't have to worry
>  about the Linux kernel but I wonder how much rust userspace you
>  currently have packaged? Do you have the rust-vmm vhost-device binaries
>  for example?
>
> Yes. I believe we build those today.
>
> I expect it to mostly work, most of the time, to be honest on FreeBSD. I =
also
> expect there to be more breakage than we see with llvm/clang...

I would hope if llvm/clang is working you shouldn't see any additional
breakage due to rust (I don't believe they overly hack llvm for their
use).

> So the bottom line should be that we'll be able to make it work, but there
> is likely going to be more work since rust is less mature than C. However,
> it's not clear if this is an occasional minor thing, or if it becomes maj=
or and
> frequent. And the only way to know that is to take the plunge, so don't
> let this stop your plans.

Absolutely. The aim of this exercise was to make sure downstreams are
aware this is coming so it doesn't come as a surprise. I did CC
emulation at freebsd but I got bounced as I was not subscribed. Could
you make the wider FreeBSD community aware of the thread?

>
> Warner

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

