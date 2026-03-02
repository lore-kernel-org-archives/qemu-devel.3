Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8064EB3637
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 21:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxAR8-0005vb-JV; Mon, 02 Mar 2026 16:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxAR6-0005um-BN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:04:16 -0500
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vxAR3-0000FR-GY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:04:15 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 bbad38fcc903f08aac8a34fb38bf4536185f8411583b835b7bb0c42ea97dc03e with SMTP id
 69a5fb4af227232ceb134712; Mon, 02 Mar 2026 21:04:10 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1772485450;
 bh=TaHXCAjZhZ76Y7rDpLiKc5iju9aeSOdgEEvn1m9xgEc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=JeSgzPIOfVmM6GJvdusXMh1fal/Z0qLQyvPS5/BSC+I1oqmer9eecKyum12ys/TeS
 QljyLAvy2wIBfFclBDnbwtovhZNWJCv1/FcjA76TONnP9Um2Bt4GTrM4Ocb3NJZxp+
 NkJ05xvAiqO2jjrC1odmkWet/nmT9VPfKY1wpjkK86tWKUqA8r8RiD6qAhQ0p3htYm
 rVlEyyIunomrHIJGUb8dGJika0X9MG+cVt7/W8A6lcZwthX8V4UAtoPxvL14nZEtcj
 gJroCWicdKbfiJpoL0enwfS9PT+MM8+Fzs+nbnT+VFhPdpoIylUtZCL7mieApv7/ti
 J3hzO+bZkIlaw==
Message-ID: <e29cdf76-a705-421f-b774-3e1b8ea3aa1b@yodel.dev>
Date: Mon, 2 Mar 2026 15:04:09 -0600
MIME-Version: 1.0
Subject: Re: [RFC PATCH] configure: Use clang for sanitizer builds or disable
 Werror
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260302210039.261325-1-yodel.eldar@yodel.dev>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260302210039.261325-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/03/2026 15:00, Yodel Eldar wrote:
> From: Yodel Eldar <yodel.eldar@yodel.dev>
> 
> Builds with --enable-{asan,tsan,stack-trace} fail under GCC, so use

Oops, s/stack-trace/safe-stack/

> clang if available, otherwise disable the treatment of warnings as
> errors.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3006
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
> I didn't see ubsan break builds with GCC, so I excluded it from the
> check, but maybe we want to preemptively include it, too?
> 
> Please review.
> 
> Link:
> https://lore.kernel.org/qemu-devel/CAFEAcA88hc4UsgpuPXBWpbeN0tW26159kPn7jx2J9erBA5DLBw@mail.gmail.com/
> 
> Thanks,
> Yodel
> ---
>   configure | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 5e114acea2..0b75b8bb93 100755
> --- a/configure
> +++ b/configure
> @@ -762,6 +762,12 @@ for opt do
>     ;;
>     --wasm64-32bit-address-limit)
>     ;;
> +  --enable-asan) asan="yes"
> +  ;;
> +  --enable-tsan) tsan="yes"
> +  ;;
> +  --enable-safe-stack) safe_stack="yes"
> +  ;;
>     # everything else has the same name in configure and meson
>     --*) meson_option_parse "$opt" "$optarg"
>     ;;
> @@ -771,6 +777,20 @@ for opt do
>     esac
>   done
>   
> +if test "$asan" = "yes" || test "$tsan" = "yes" || \
> +    test "$safe_stack" = "yes"
> +then
> +    if has clang; then
> +        echo "Sanitizer requested: setting compiler suite to clang"
> +        cc=clang
> +        cxx=clang++
> +        host_cc=clang
> +    else
> +        echo "Sanitizer requested: disabling Werror for non-clang compilers"
> +        force_disable_werror="yes"
> +    fi
> +fi
> +
>   if ! test -e "$source_path/.git"
>   then
>       git_submodules_action="validate"
> @@ -1890,7 +1910,8 @@ if test "$skip_meson" = no; then
>     echo "# environment defaults, can still be overridden on " >> $cross
>     echo "# the command line" >> $cross
>     if test -e "$source_path/.git" && \
> -      { test "$host_os" = linux || test "$host_os" = "windows"; }; then
> +      { test "$host_os" = linux || test "$host_os" = "windows"; } && \
> +       test "$force_disable_werror" != "yes"; then
>         echo 'werror = true' >> $cross
>     fi
>     echo "[project options]" >> $cross


