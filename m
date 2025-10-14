Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17500CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 23:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ol3-0005pz-GH; Tue, 14 Oct 2025 19:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8oky-0005pY-0n
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 19:48:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8okq-0001SG-BI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 19:48:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46f53f88e0bso33930935e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 16:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760485707; x=1761090507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UH3QDvFtmGKSmUVe57xoqA6TZLSc/XQEQYquC6LjKck=;
 b=JfOncp4jjb+rmr8MSYsJfTptK62LP09HLI80YUcB83y2B0uUtjiiYgv5EkuooK+F/u
 EKF0om6yOLFYvvLdibsxx9wCahuMLzGWcVpty6ce0iQJG+TM4G46ZlYfUogokOFTkMtR
 8yisI3eHh/JXvNct+YwvuCgx1mX918/KDSVpgvp+FwdUzSKeOKO0exLt3KlD2KVtujiA
 JP8+84OJgDt6Jp3qPOBX2JZpv2KdOLprSnGMJSPUE96wzUzun6uwZVjc85SuZrFloXJu
 ufiORwf2ZClQz2pMssQjc1yqPMDoNEDTebcb1vrNXrxgOszzCUQhVCevJNGj/suZuJHt
 lScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760485707; x=1761090507;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UH3QDvFtmGKSmUVe57xoqA6TZLSc/XQEQYquC6LjKck=;
 b=MyQt8eNZGCJsB9evWC9dqqA+xODYXMiOWRmUNHtbSH3s37e13Q7u6k2lsrOSBvz00u
 SEspv5kJfzusOiYweBnTXkOPej5J74uB840rbzQyVScpainQ24WeKDl2g57EISJ5FlwN
 mAv9DdbuwndLYypQjuRDJ2tzZsBG8p46Pl5mBqsU6pPHvzBSRzQdDI7eJceQjA40Uuvl
 ffPDOh16/RaEx9sgEef0aowiTzRaADn1zEMiGTIxPRuLo+8W9yu+iBnvVQMdy4ApzUkq
 PK8UNQ11G98lcsA6TcjKV8ikJNC47bjHrJiGFjC8CkHAqPwGHOWipZVuud9CXkTCUhr8
 9+DQ==
X-Gm-Message-State: AOJu0YyA5XIvIFXsDbe+c0a5r3fQPOL3PHFJEe+0a4v1941sbnPwgt6y
 Xhs2zgwFhDpiUEcv3YMtzL9y6vkY4duUFq20lE55mzeF5bWiv86cIkexQtpxfzruAYw=
X-Gm-Gg: ASbGncsvTbpxgEGZvSqHAW1+1D3T8NyzZMZ1fLzJKkLslL56ez3KMa8z2qksoO2lw9s
 4bFWupiimfah7gwZtgwh1m7mcO8JOEJSz69A4E+CV2l98Z9rtQDgnpi6cGxpFPFzA7CcAaVp0nt
 DPhBeH3bSPa0pjFn3TlR8afD+jqQi1JtD6y3uJKQRbRLIuZDw5J5uN8GZ7jPfl4fvfAKCaFblly
 7c1rDbkL1wFnxwGefN5tdOofnciZ6YqzwJdNdgtNjChVhEXMP4qqvHRIn5eNX/U3rUbI1YP5kPy
 r6c7N12QrLlyLSIX+ame3atZsrw2D7ubdbTEkWepXOm0VDVuafkwPlSeq+Y7nWWx60dEXpX+GJn
 QVYh1np3pjMS6mRh0gxWpUl/g4QCKm8YT6O4IOhH3yrNofg==
X-Google-Smtp-Source: AGHT+IFI2Ky7UbTGWPLvGJ2PaLH7ucu2FZ5Iy3dRBcY6orqmWSTWY9TyHMHEuAPdHmDEizRBg0o32w==
X-Received: by 2002:a05:600c:628e:b0:46e:38f7:625f with SMTP id
 5b1f17b1804b1-46fa9aa2123mr159778255e9.10.1760485707185; 
 Tue, 14 Oct 2025 16:48:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab36ed3bsm174239745e9.0.2025.10.14.16.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 16:48:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7332F5F83C;
 Wed, 15 Oct 2025 00:48:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-ppc@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/3] docker: Stop building 32-bit PowerPC images
In-Reply-To: <20251014173900.87497-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 14 Oct 2025 19:38:58
 +0200")
References: <20251014173900.87497-1-philmd@linaro.org>
 <20251014173900.87497-3-philmd@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 15 Oct 2025 00:48:25 +0100
Message-ID: <87y0pdjb92.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> 32-bit host support is deprecated since commit 6d701c9bac1
> ("meson: Deprecate 32-bit host support"). Besides, the Ubuntu
> distribution we are using to cross-build dropped support for
> 32-bit PPC as of Ubuntu 18.04 LTS [*].

Erm NAK. debian-all-test-cross.docker holds the cross compilers for
building test cases and we are not dropping 32 bit guest support.

We may need to hive more off into legacy-test-cross if they are being
dropped from Trixie.

>
>   Given the recent announcement that the powerpc architecture
>   would be dropped from the upcoming Debian release, there
>   has been a good deal of discussion about the future of this
>   architecture in Ubuntu as well [...].
>
>   Unlike the ppc64el architecture, there is no longer upstream
>   support for the 32-bit, big-endian powerpc architecture [...].
>
>   The Technical Board has therefore determined that the powerpc
>   port should not be included in the Ubuntu 17.04 (zesty) release.
>
>   The powerpc architecture will continue to be supported as part
>   of existing stable releases.  Since powerpc is included in
>   Ubuntu 16.04 LTS, security updates for existing packages can be
>   expected until April 2021.
>
> Next commits will remove support for 32-bit PPC hosts. Stop
> building the powerpc Docker image.
>
> [*] https://lists.ubuntu.com/archives/ubuntu-devel-announce/2016-December=
/001199.html
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  configure                                             | 1 -
>  tests/docker/dockerfiles/debian-all-test-cross.docker | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/configure b/configure
> index 461b53dd605..ce76a00aff1 100755
> --- a/configure
> +++ b/configure
> @@ -1362,7 +1362,6 @@ fi
>  : ${cross_prefix_mips64=3D"mips64-linux-gnuabi64-"}
>  : ${cross_prefix_mipsel=3D"mipsel-linux-gnu-"}
>  : ${cross_prefix_mips=3D"mips-linux-gnu-"}
> -: ${cross_prefix_ppc=3D"powerpc-linux-gnu-"}
>  : ${cross_prefix_ppc64=3D"powerpc64-linux-gnu-"}
>  : ${cross_prefix_ppc64le=3D"$cross_prefix_ppc64"}
>  : ${cross_prefix_riscv64=3D"riscv64-linux-gnu-"}
> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/test=
s/docker/dockerfiles/debian-all-test-cross.docker
> index 420a4e33e60..08361cbe6b5 100644
> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
> @@ -58,7 +58,6 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>  RUN if dpkg-architecture -e amd64; then \
>    export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS} gcc-hppa-linux-gn=
u libc6-dev-hppa-cross"; \
>    export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS} gcc-m68k-linux-gn=
u libc6-dev-m68k-cross"; \
> -  export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS} gcc-powerpc-linux=
-gnu libc6-dev-powerpc-cross"; \
>    export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS} gcc-powerpc64-lin=
ux-gnu libc6-dev-ppc64-cross"; \
>    export AVAILABLE_COMPILERS=3D"${AVAILABLE_COMPILERS} gcc-sparc64-linux=
-gnu libc6-dev-sparc64-cross"; \
>    fi && \

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

