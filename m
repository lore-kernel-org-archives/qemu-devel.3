Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC1C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uettI-0005vM-BP; Thu, 24 Jul 2025 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uettF-0005sL-0u
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:13:33 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uettD-0004Of-Ag
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:13:32 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so1475156a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355609; x=1753960409; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSoVFTJPenVgcfO5mcfZXQWTQXpJCNT8yze8wn3wrUA=;
 b=Kn4N42pZWp8UVNhefv03fLfTU65iPI9Oek3zAivhp10eAgzS6N1zsV1Gmg/FphJ55j
 IJxCdqIWBjnZ5BJ1HVGc2XWOI2TRKBmoQ+UsM44Jh5vw2hvPeoRxDRgudszFnuprlUY7
 R5+Y9lGXlXykZiKjqPLwBPNUiOLjeJGnhYUlTJ45scNcOxJXbL3CLFlUHxOaLkKoZqQW
 eCy+Nmi1qd/mKSw3CfMHwyqznNMD6vKu7InLuxkfcLoLmsDdP4XmTcno3aje5jgSAPmy
 Ye8aMIcN6JbjYJKJukr41B24y7kgDzT9zoF3S/60W7+wwx07niAve0ddGGaKoB5y2rZE
 6NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355609; x=1753960409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSoVFTJPenVgcfO5mcfZXQWTQXpJCNT8yze8wn3wrUA=;
 b=auKjwDmlJgTsek9TNfCSLtk4TKD5kpFBxpfrlfEmz1AzNPRpKC/JCdMCP1StF+DOcv
 aAfE2lYDlO6B2gTo7AzHTVI3ca+TIVYxYa4/UDOH9CRdQkvUN9YlVwE+a/oUW4RNttN4
 SoA5bbaUIHuRZpFuULNYSAeorbKsxrdImsyxHyNb0GXpcIVetHHdz85QSgHVlMmtFWvj
 5WVshVHusn/u/lKhsZBwZTGdWEVBi+QEgiirY2h4j3x8EIruJT77jsX0Run0aCeRQGDA
 AX7JrDdVHVaZR1mYscmuFNGkbgrciuIunXN83Kgd8ZJCTl4mo1A/oky7GcrHHsrTL1ji
 1UAA==
X-Gm-Message-State: AOJu0YwvslIUeDwk1FEp0phSj/Kpmu4w4y4sXRkYEINQOKGT4P1V+n7t
 toCIUUP/4f9BMsXKSfW79JJOBvOywWGcl0HAbfQAZ1rmmVB6NqoiGVMGOrnP/QWvqubj1J0Zt/6
 0MxhFQ0ken3d+htEHXjkcHhZ8CiJ84bKu3rvqkliNWg==
X-Gm-Gg: ASbGncs03Cmke9K4DfUVGKw5JXQmpd1/X2X5tpVMmgJdnR+rslQYaml3Kjpx+OB4Dtq
 F8NyMDuODu380OL3lFXD5U1aoccU6Ebd+rAtz8GpnsTqwA1piZVH0XbSGJBpSw+mt1vr3HjIGea
 XNMjBKBvenFv9cmng5Ih4PnttuLsPMkaflU/bZHraNPCdVD0n4GtssfmylJlpgNfBBBwQCqgF88
 tF6EA==
X-Google-Smtp-Source: AGHT+IEI7/Qo8Zs6opOzvTlk+a1B4I04MJxyvNhxVGexO81AMOwPCF1GGmPOYsGjKGr+QPEhyAHurHXGqmB8Xp/7qqs=
X-Received: by 2002:a05:6402:34c4:b0:612:dc41:c622 with SMTP id
 4fb4d7f45d1cf-6149b42ee6fmr5876465a12.9.1753355609482; Thu, 24 Jul 2025
 04:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-6-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-6-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:13:01 +0300
X-Gm-Features: Ac12FXwE54V8rnzUk_t4sutDzLg4OBu_z6t8BZamH-emXhv2BaKL2IXoomRFoVY
Message-ID: <CAAjaMXYw-cva47LOk0KHxDYOOXm+LfpDRtGTzhgnTyqKAQ_Xog@mail.gmail.com>
Subject: Re: [PATCH for 10.1 05/13] docs/user: expand section on threading
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, Jul 24, 2025 at 2:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Potentially too many weasel words when describing atomic and memory
> order issues.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/user/main.rst | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/docs/user/main.rst b/docs/user/main.rst
> index 05de904225c..449acd4a324 100644
> --- a/docs/user/main.rst
> +++ b/docs/user/main.rst
> @@ -46,9 +46,14 @@ Threading
>
>  On Linux, QEMU can emulate the ``clone`` syscall and create a real
>  host thread (with a separate virtual CPU) for each emulated thread.
> -Note that not all targets currently emulate atomic operations
> -correctly. x86 and Arm use a global lock in order to preserve their
> -semantics.
> +However as QEMU relies on the system libc to call ``clone`` on its
> +behalf we are limit the flags accepted to those it uses. Specifically

s/we are limit/we limit

> +this means flags affecting namespaces (e.g. container runtimes) are
> +not supported. QEMU guest can still be run inside containers though.

QEMU guest? Maybe write "QEMU user-mode" instead?


> +
> +While QEMU does its best to emulate atomic operations properly
> +differences between the host and guest memory models can cause issues
> +for software that makes assumptions about the memory model.
>
>  QEMU was conceived so that ultimately it can emulate itself. Although it
>  is not very useful, it is an important test to show the power of the
> --
> 2.47.2
>
>


--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

