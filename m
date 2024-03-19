Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E212FC54E69
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZGe-0008Dv-P9; Tue, 19 Mar 2024 09:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmZGa-0008DP-TT
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:12:33 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmZGY-00067R-9z
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:12:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56b85146589so2448231a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710853948; x=1711458748; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BI5NCQC0D/VwA3OMYGlCK/6otl+pj0AK7i6Cxt1V3lg=;
 b=jbPK2bXUMZYanjMQTZeHs/9dXrGNt76JUzbugrP3zNXmEPa2H3+LcMXvFVRiB68exh
 r4L2SPDOSF04d9nsPHx2ZMy/R+Tptl9LRyxBMRYBg9woMNwYG0sdTOBdTY9LuvqPZpKt
 FY8Gsu+fg2wcoszmhdYYMLJ7/6ZlwG6V8vg1UuGEHcKYP8QxVfn/0HPw6E2cXFKt13t6
 S5kVYaS4F4TEl/kP9YT00pHbaRxwua6vyrxfLYOZ3PMY0X7ae8QHWAYyKess3+Rsub6B
 oEZbLgazCiLbmBoxfmm0fNUpH3yQlaGjWvNj1rCpRV7UDhdXOl5a4HpurVa25/Nslsu2
 AYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853948; x=1711458748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BI5NCQC0D/VwA3OMYGlCK/6otl+pj0AK7i6Cxt1V3lg=;
 b=O/pvgDGNyob/LadM5+wklahGbDXc/gRQ5yAWxRsFUPnCq4EO3HmCWKU0ogBbToeCuP
 00gwXQIBwee26Ybj5zfWpD1LYDIBbWMxUKIbVS9fvaztAygI1UqAso7lvgOb6DNpxDFf
 VZPIDZ6zTzWuuID0o6FPbUaW4PxKOkeUNjyXS1nC4SDvmK8GyHAOyY4tx5P7ZNi1G3eP
 GHCJr6jG8QWuyjWpg7iHfPOCyFwsqQqrIFzR63CFg/qrdrrm97EtMMSYT3uQdVWXBeeM
 W2mlU6MdGdL2svgo1Zu+wE0C4Cui5eEucabJ/6PCp7H/PWFgFgzKM/3mB06m+dKiwKx/
 n+0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsof10OXquZdT/VXiqTsZCN9nzqcwU67kwK6JzmsbiYVy6reygZByzDO6lDuOqRGVAdqPwHb0ZgG9ViCsPXSgO619VMqk=
X-Gm-Message-State: AOJu0Yxs3av/csRvvgbSco07FiWvMDmWJr3Yx6wryN86ovZ+78KaBNLY
 UuoLY4VxT7XXbXdrJlThopCpPO3DyfqG+5tO9WgSnzK9O8RMYitLWdqoK/cz98uKC6Arh52ujer
 0Lea5KbC9aAI3X73exNSq59KIUNnjt82BgodQJQ==
X-Google-Smtp-Source: AGHT+IGo5eBhrrq9hnm0Dx0oKhMXXEtjnOuBeSUQep4E8Qq+C2eLtCfH18FdlxSmxnPx9Q+95oaJx4TjKtglbeg581M=
X-Received: by 2002:a50:a6d9:0:b0:568:aced:e5a0 with SMTP id
 f25-20020a50a6d9000000b00568acede5a0mr2600859edc.14.1710853948339; Tue, 19
 Mar 2024 06:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240308060034.139670-1-thuth@redhat.com>
In-Reply-To: <20240308060034.139670-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 13:12:17 +0000
Message-ID: <CAFEAcA_L7FQB9dUe1pCTTRN6XKbKa6ne2KZu6=-4YgTDzWW1aA@mail.gmail.com>
Subject: Re: [PATCH] configure: Fix error message when C compiler is not
 working
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

I think I would prefer as a structure:

(1) suppress the "unrecognized host CPU" message if "$host_os" == "bogus"
(2) do the "check the C compiler works" test as its own test immediately
    after we print the help message (and not guarded by testing $host_os)
(3) leave the "Unrecognized host OS" check code as it is

thanks
-- PMM

