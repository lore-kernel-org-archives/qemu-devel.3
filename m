Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ABECD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAuD-0006Os-AX; Thu, 05 Sep 2024 07:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smAuB-0006ON-Em
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:44:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smAu9-0000Dl-Oc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:44:03 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so425695f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725536639; x=1726141439; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrEFj/qFaciF552jG9NFgSGE3yPMh1VsiGUlAbyVrzs=;
 b=HVQHLlQNTYEUOkuiW+BFFavm4+HSNHH+QqaDzHqYR/rSY6uku/noFMeWwoS18Qqjaa
 igLYf3eyG1WOLhNCmJLTPzHq3CI/JFkZFAArp+OGttn9YnaGJvIOpXjYD6QXmGUXuc2E
 b4PYfb1iiiGRScEdZ+SJlXeHDz1SUlxuKbX2gK1xsAjKOTVH2tHfzNBCOeAYpouUXrts
 LUsBdTFlevCjrdyi6TK36z9mWQnd+hCsDtJtG2VHpIua8Ur+YyPf0B/VKoPk3mL8uh1W
 XsYJvnQR/1fjGSpaz1MFLBRS7uaiGI0vgNNe/A0Y4M3vAoj4M8s00fF2RTUquOkgs7+i
 TEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725536639; x=1726141439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrEFj/qFaciF552jG9NFgSGE3yPMh1VsiGUlAbyVrzs=;
 b=Y7QhacKOMIXscBdIJb2C3HKG2t+G3FwUQ8ZDyM8zfvN8EOEtRO+Zhq0QyeuQ/kikqQ
 4F36wMugJmMQP7dijhR2/fvS2Ly/7B7dbwzbLe5PUvXxdDvuMoGD6DzWs7ACfkQ+cCaA
 qpqIkpG3FP8K/dn9H+lXsqElkx0CdQCZeSWWuisCvRpbzW9noLObZ8xHdyMs/NqSGP6W
 JSjYFMZnGoAKWHdHtnaJ4hgXL1Gs5FskU6wACWQ0G4hU1Gs97LWH9GZt7KhoB8Xk1Guc
 Vs1nj3D5ohju5bQqJxbGCDKixcHZr/5npNRNZu/E9XxKeeseKyM21DIhWTER4bIxms5n
 pj/Q==
X-Gm-Message-State: AOJu0YxZYIYUwo1W9IlsFEHCaLdoTO9BUn/2dncp5hf1wQH5nIHy5zLx
 iW2Ho+0tTetoqrYt83VKXLFjVMnYjZ2tc4rbUTzgCAaxPFYYWqYBAbq8jkYfukQK0um++JHsdDB
 hvQhn6sOnsA7eXNixl5hD89x9Wlv2Ddq03A8/Tg==
X-Google-Smtp-Source: AGHT+IFmHwi6BPxrKBEyghk2GKLqbrLuankV2tfRxwP06pNT69TyDU19ugLYV3c1KxtsHELmyHG8qCUUQ4T1httWVl4=
X-Received: by 2002:adf:e411:0:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-3776f452f6bmr3302314f8f.14.1725536638940; Thu, 05 Sep 2024
 04:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240905111153.786500-1-alex.bennee@linaro.org>
In-Reply-To: <20240905111153.786500-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 12:43:47 +0100
Message-ID: <CAFEAcA_OP2eNw0zQKCRi37cR-1eLPCnVC5dh0+dcPVuJ1YF3-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] deprecation: don't enable TCG plugins by default on
 32 bit hosts
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 5 Sept 2024 at 12:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The existing plugins already liberally use host pointer stuffing for
> passing user data which will fail when doing 64 bit guests on 32 bit
> hosts. We should discourage this by officially deprecating support and
> adding another nail to the 32 bit host coffin.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/about/deprecated.rst | 11 +++++++++++
>  configure                 | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 88f0f03786..8a4e249717 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -184,6 +184,17 @@ be an effective use of its limited resources, and th=
us intends to discontinue
>  it. Since all recent x86 hardware from the past >10 years is capable of =
the
>  64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
>
> +TCG Plugin support not enabled by default on 32-bit hosts (since 9.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +While it is still possible to enable TCG plugin support for 32-bit
> +hosts there are a number of potential pitfalls when instrumenting
> +64-bit guests. The plugin APIs typically pass most addresses as
> +uint64_t but practices like encoding that address in a host pointer
> +for passing as user-data will loose data. As most software analysis

"lose"

> +benefits from having plenty of host memory it seems reasonable to
> +encourage users to use 64 bit builds of QEMU for analysis work
> +whatever targets they are instrumenting.


> diff --git a/configure b/configure
> index d08b71f14b..8acb311527 100755
> --- a/configure
> +++ b/configure
> @@ -424,6 +424,7 @@ fi
>  # Note that this case should only have supported host CPUs, not guests.
>  # Please keep it sorted and synchronized with meson.build's host_arch.
>  host_arch=3D
> +host_bits=3D64
>  linux_arch=3D
>  case "$cpu" in
>    aarch64)
> @@ -434,12 +435,14 @@ case "$cpu" in
>    armv*b|armv*l|arm)
>      cpu=3Darm
>      host_arch=3Darm
> +    host_bits=3D32
>      linux_arch=3Darm
>      ;;
>
>    i386|i486|i586|i686)
>      cpu=3D"i386"
>      host_arch=3Di386
> +    host_bits=3D32
>      linux_arch=3Dx86
>      CPU_CFLAGS=3D"-m32"
>      ;;

This is pretty awkward. We should only put stuff into this
"switch per CPU architecture" where we absolutely cannot
automatically determine it. Host bitness can be automatically
determined (see what the compiler has set __SIZEOF_POINTER__
to), so we should do that.

thanks
-- PMM

