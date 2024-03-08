Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3A6C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYNA-00058b-2F; Fri, 08 Mar 2024 06:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riYN6-00053K-Mw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:26:40 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riYN1-0005eN-Aq
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:26:40 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5682f48532eso652101a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709897189; x=1710501989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Q24CXDpJ+dS6HroGo0RNGcjcBqU028t38MlOIGXUCg=;
 b=W4jxk/0UG1OfurEphAMW/6D3Eex7M1kvF6oCpsB3boMpx33dp1LP3ijq2RHPYmnH0K
 PVNQ44vPy4KwekBFflXHS9w63PLgG5XqTKQBjk7Z/NCEHyzzh7CQ8q0ZVEOUhg6bo2b1
 Ud7FqRQkCrK43b2ysR44+1ZihMKO7E1NARNr0c2Ic6CIcAW4JF1IKGTcwQ7W1fScyS5N
 4u0JbtY8DmSPPMmlPWjFT6cS4XPsPDkwd28zy8J7qcw34rcYeGVevU1JeQHgJ6SSAgdu
 nV5EYzBdxpQrUfSbdiUPbbXT+kZwH3ImYnlfiBQHNrdmRt9VklkJwJYDkrIlFtJdseYB
 gnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709897189; x=1710501989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Q24CXDpJ+dS6HroGo0RNGcjcBqU028t38MlOIGXUCg=;
 b=HZhBDtoE/C/HDZOCsG0zeUxJWtH6AwQIEFseCmuLJWZ+Sqm68r/Svgn1FBpgg4nSBl
 3BAcTMR6C7jv4Vh/ggI2aG2fFht/7VxMvYH/tDzSF0MLAiB+jcuf+1Esqkj2MYhm14Mi
 /VVm1TTFnj0oN2nejBhRvnK08csYMLGHkJBgAs3abqpExbSPdrllB0SUvSHycRYp3pAv
 0tCZVKwE7ywnW5TMxDokBT/bidC0JS/HMjBZhUiZMaaPLfxEIzQgcwu11Jbey2S4o5eT
 YJWpzXyznsITcxoSMqxKqHE6GlPVJ55gOLDNovoxj1BtR3bTDNzBomsmMkcIGBPFy8SB
 wq6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOBM4tpGbdrOFVsrZkGBkaeGL9v1j/b6E61Uus/1do0Wi9XAJP9E6SmVD2t9ll+IHnFZHySSSO1Tn1eF1zeuCxJao6LMA=
X-Gm-Message-State: AOJu0Yxlzqm2tC7P/+KNGsfPl2cBxYPPA2Bbp5kphTBx6SdJUmJJ/90K
 D94NyM+KoGFobCQ7PnstMm/NWFJwyaWnMS42WpmenEf4OXnFoeAAjf2jImUsP1WXZhbN5bprkYI
 EBja+qJyF2C2dbiWBCeze49x7IKlkQqklXA+o4w==
X-Google-Smtp-Source: AGHT+IFLmkbQhMMFzFPLR5+/4afIZWgezSOjpnbcOkxVjXHCcPlRYO4eHVPAvmbwSwJ3wzIpi7CDzzIwnCt/ZoXSarw=
X-Received: by 2002:a50:bb44:0:b0:566:13f8:bcc with SMTP id
 y62-20020a50bb44000000b0056613f80bccmr2485828ede.0.1709897189262; Fri, 08 Mar
 2024 03:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20240308060034.139670-1-thuth@redhat.com>
In-Reply-To: <20240308060034.139670-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 11:26:17 +0000
Message-ID: <CAFEAcA-0kNwed8SbceWuR89mFMvfwfPpQaJJfdoRoM3az8vttQ@mail.gmail.com>
Subject: Re: [PATCH] configure: Fix error message when C compiler is not
 working
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 8 Mar 2024 at 06:01, Thomas Huth <thuth@redhat.com> wrote:
>
> If you try to run the configure script on a system without a working
> C compiler, you get a very misleading error message:
>
>  ERROR: Unrecognized host OS (uname -s reports 'Linux')
>
> We should rather tell the user that we were not able to use the C
> compiler instead, otherwise they will have a hard time to figure
> out what was going wrong.
>
> Fixes: 264b803721 ("configure: remove compiler sanity check")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/configure b/configure
> index 3cd736b139..a036923dee 100755
> --- a/configure
> +++ b/configure
> @@ -411,7 +411,7 @@ else
>    # Using uname is really broken, but it is just a fallback for architectures
>    # that are going to use TCI anyway
>    cpu=$(uname -m)
> -  echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
> +  echo "WARNING: could not determine host CPU, proceeding with 'uname -m' output '$cpu'"
>  fi
>
>  # Normalise host CPU name to the values used by Meson cross files and in source
> @@ -1000,10 +1000,12 @@ if test -z "$ninja"; then
>  fi
>
>  if test "$host_os" = "bogus"; then
> -    # Now that we know that we're not printing the help and that
> -    # the compiler works (so the results of the check_defines we used
> -    # to identify the OS are reliable), if we didn't recognize the
> -    # host OS we should stop now.
> +    # Now that we know that we're not printing the help, we should stop now
> +    # if we didn't recognize the host OS (or the C compiler is not working).
> +    write_c_skeleton;
> +    if ! compile_object ; then
> +        error_exit "C compiler \"$cc\" is not usable"
> +    fi
>      error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
>  fi

Why doesn't it work to check the C compiler works before we
do the "what is the host CPU" test ? Does that make the
--help output not work when there's no C compiler?

thanks
-- PMM

