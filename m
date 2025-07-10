Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B065C83F20
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqE3-0005yp-UX; Thu, 10 Jul 2025 08:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqDw-0005sG-7I
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:18:02 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqDr-0003is-NR
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:17:58 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70a57a8ffc3so9508717b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752149873; x=1752754673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFArDah2ssTeH+v280YDihlQ7P+RuuQADEL1JggCiFo=;
 b=xSNwBBH2A4xIwyUiULEcZ8hASci8XHDEY9cDPVEPrXwSkZ/kOGjDwDOy2+Tu2y5EJr
 SVzGpCCyfwTBZWuNd8we+MHMJPl0X8Xbls5soYHhNkVKdzWzEmnidPmDMfos7hjIZrRp
 qHq26yMSvgXh7jgk5gmiI484B4+KVOikH8va1slJkSV1Q5/tEmPe9Lwhb1W95HwymnGE
 naj+7t6wykvb1/aWaJOm4IqGu6IOhpQbYVKqOa5VVKl38CxwnkQ5swtNC+yFfWWHnUVK
 7hB81nTple2b+7JnDClIUAu42XniuQORnWVpdH+e52ipOgkTMvNfeJ5w/UUAzSLzv36R
 jx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752149873; x=1752754673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFArDah2ssTeH+v280YDihlQ7P+RuuQADEL1JggCiFo=;
 b=d9OMSZtCjDV/fdCNAaffkbDUH8B/9pBLyHU21vVjHcGVuM0ACd+Y8qUvqZ50moMGra
 fpGY5QTH81MHR47kOuWqw13NdlAD5sdoCHSNUYfGHdqRG0KIDAzmngSsP5QjMu/MLDil
 Zq1pYBxGSMvBHN5Ud7AS0pZOkki8pyRV/zGBxfqokNkU/jqqFQvIcE3N5oNGx53Hw28g
 eTIzNEVttLQCoFUIano4uGTnbAtECd0wLwE0714Lobejq3dv/cMyUaiY0KcbC1I2NZ4H
 wYwDL4aBeiJfu3rJUFHsZ/Sbpvy37zDYf1FDbMENVyc/1P26sptCTFdugnZZnDzb/XEy
 vDXg==
X-Gm-Message-State: AOJu0Yw0KiF76ge1+LtwGHyFmZdW/2v+EtZqTGbZP6SFsNWER8bjwNJ/
 /8t8No0zDR3wZZ+/p77mMduHGsjFSgPRm77Uzo2Ew5FbywhlS6Lue21O3BoBxDV16nt6YE7NCrD
 qO87UxwFY8w3QEP8yYe4EIhfc64SkUoJDRyVuRWl9lw==
X-Gm-Gg: ASbGncvA8AwJBWLnH4DSktg2Fj1RxuCRjNimAwSRyvzjzyF5iYm7RpfonP+LAyxwDj/
 +wh8jo2sLm3/swfbw50XmgL4xd++a6BnD5KHrhw9I9IDctIx4bgZU8q4Vl24pdrL6mb6ENqd4p3
 wtrCnRQlBkWhOB3KirrMUzUFTI6fvvU5T3tj/LwALRwIqwEu/LJE3ihN8=
X-Google-Smtp-Source: AGHT+IGP4JQZeup6/doDZNz1GaDN13PpljYSGwOFljkBeej2Absml6SsiCmE9Fel8kW/i+gH0sni2BQ5oDZ/44EeoEM=
X-Received: by 2002:a05:690c:14:b0:711:9770:161f with SMTP id
 00721157ae682-717c15e3018mr50689987b3.2.1752149872790; Thu, 10 Jul 2025
 05:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-20-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-20-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 13:17:40 +0100
X-Gm-Features: Ac12FXzO4DBHWLYxhLABJgKWVx68G8Eozip7pNRbGpSQ-404RZX9fykzK5gdUGY
Message-ID: <CAFEAcA9jxiazMKEyoPQQdqRBKydgkbKQobtLPyszSHT1M-LHGA@mail.gmail.com>
Subject: Re: [PULL 19/23] util/qemu-sockets: Refactor success and failure
 paths in inet_listen_saddr()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 22 May 2025 at 11:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> From: Juraj Marcin <jmarcin@redhat.com>
>
> To get a listening socket, we need to first create a socket, try binding
> it to a certain port, and lastly starting listening to it. Each of these
> operations can fail due to various reasons, one of them being that the
> requested address/port is already in use. In such case, the function
> tries the same process with a new port number.
>
> This patch refactors the port number loop, so the success path is no
> longer buried inside the 'if' statements in the middle of the loop. Now,
> the success path is not nested and ends at the end of the iteration
> after successful socket creation, binding, and listening. In case any of
> the operations fails, it either continues to the next iteration (and the
> next port) or jumps out of the loop to handle the error and exits the
> function.
>
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 51 ++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 24 deletions(-)
>
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 4a878e0527..329fdbfd97 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c


Hi; Coverity complains about this code (CID 1610306):

> @@ -303,11 +303,20 @@ static int inet_listen_saddr(InetSocketAddress *sad=
dr,
>          port_min =3D inet_getport(e);
>          port_max =3D saddr->has_to ? saddr->to + port_offset : port_min;
>          for (p =3D port_min; p <=3D port_max; p++) {
> +            if (slisten >=3D 0) {
> +                /*
> +                 * We have a socket we tried with the previous port. It =
cannot
> +                 * be rebound, we need to close it and create a new one.
> +                 */
> +                close(slisten);
> +                slisten =3D -1;

Here we set slisten to -1 ...

> +            }
>              inet_setport(e, p);

...but then two lines later we unconditionally set slisten to
something else, so the -1 assignment is overwritten without being
used.

>              slisten =3D create_fast_reuse_socket(e);

What was the intention here ?

thanks
-- PMM

