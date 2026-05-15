Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CB7CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwr0-0007f0-I4; Fri, 15 May 2026 14:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNwqu-0007TX-T4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:37 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNwqs-0001lw-O9
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:01:36 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so228781d50.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778868092; cv=none;
 d=google.com; s=arc-20240605;
 b=WDiPsU5VMIQo9P7ucgT8IP8DQhWQKF3nJ9BJ5jOw8WjmnduKf1hWyYKftoaIefjDYl
 Skizj9Q2bmQNPPBJv7hUsoDofPMUbl832w8WzjNzN4O8drpdW7hTfXztNt0uVlwZ6iPM
 4gQAsiE8xWErJxUQlEN1QCw7f4HHGiE3Sd/kMPW7BMbznZlVyhaEH/q1buxCFCcBDXwP
 mwJxjIhxJrWLDObmCCpSNoZqQMof2zoPYr0FObYZ3mO3vMYJTwBewthle8p7gw+oufbI
 1tW50xbzwvZ4fG1GNM7hiFlmYid9QQmSEGH3+RJW4V+toWNEegikp4KsyhCCPMFwq8Z4
 2OAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7V44O8pPeJV3YhxTSWf+khK4atctVy8Ji2oVCqljjo8=;
 fh=SSPAuRuN9Di/Zg7cwUZyVJ9LLTQJWChUgqSw0Vl/4Qg=;
 b=L/LJ6VKO1B/dUlpZfcaPWid03OR/nFawvaGK6YC1IHOnjQOAyKhClXwe61vKAPuV96
 vcVvWwQ/Y3O9sU0ErgYdPXc5HrZxfUahLk6AjkkCU9HsH8xwDszguNlTX83MtWoQ8xn1
 BSy+CzPG0bVIDm/EgOJd3/GQrqjopSaOzJUhTg4iqoiPhOJVtIRXH7BHBPuo+4P6lddj
 /HYPARUAZeZWGaMTJV1qtY39y/g6nGM6mh0mZMSjn5nqUXrOj6uKmlyiZhQuFMFPx2l3
 IVb8h0BcMpBjvN6l9STXaTOFw7rlA/Cctaog1Rr5FkcdS12Aqjl3h3S/g8sJoIPfMZTC
 NWnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778868092; x=1779472892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V44O8pPeJV3YhxTSWf+khK4atctVy8Ji2oVCqljjo8=;
 b=gOlCF9uGJ5g9fUSRJ/+zH6WIUN3TqEPyseWZ53mfZBnqPZOacNhS8qr//9fdct2k7E
 ZqctR634WT01RbrZ0u6qQaRTR5FsusjC1Mk0EJoxscecqHc99fNgbLdxd6YfYL/fCzii
 B/tGXhEzh/8JpWnWjETU3kKlXlfwDBcoV6E38gDv3awu/MUhBKU5kV/6tINFRMNlbF8i
 yWkg1Q50fiTGqpcnTlOYpK04AnSlxgtBwqC679CD1pqm9cjEWf5+HSHyntGEdshJFn4+
 r9IvGsSWKnvNg1v0Lvtkws7FxzkniLqhmKQD8ywDhw8yepCq8LdfmOOd9hs6h6/V1xrW
 ZXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868092; x=1779472892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7V44O8pPeJV3YhxTSWf+khK4atctVy8Ji2oVCqljjo8=;
 b=gHEehnd561/mrdlWTBQY4XFQMRJ2Oy61dHOK3zyNWMDpHqwzqSxwIvJdNvxi2I41m3
 T6riQLAjH6zJ7xYVv/XswPl83u0+cHnsPcNo8YN8eTd4JKVXoKOSoBVaKYSXK0B8FxSq
 baB1cpdVJv7ADZvZEtsK0uPTjUEXU4y/3g0y8KgYx0i6JfZ0V4AgzbsdFK5ILUaANKSY
 /GuMUSp1ACBdOjRLcYfqBXqNjcbS/jYOtDnRHvMKwilyOvgsyPFF8+noz+D8HvQaBidJ
 2ldFB8C3zaPH4x91oII5yX2cmsduOeYUKAFnlasgWytRATysLS3ec1JnokRpN7ZTR/af
 DZKg==
X-Gm-Message-State: AOJu0YxhUN/mM3G+FewpnQhcw42uA/y2/uQyRgro32eFhtZilPeLgmO9
 yl8hv7eATbwMSL4d2fZW9PMvW9LIlnLCvQeK23o8txA5PLtMzaCdwgQLXeWMXS0FuJDuovCQBgG
 Mv/Cy4KG2kZb4SZnb/ftt3YzF/f+sK0l5suDWA1DkiaIkwQXMnV7Cp98=
X-Gm-Gg: Acq92OGUixijUToSU7lDs+W94MfJll1EJA68GukQKOWqJOdW2JoTm3OvJM6ClIq+1Fw
 ULfGgW8tm9pdO0Ed/+W9NlNduZP4GjuCrVlgUrlg/8s94nG8A2jCVHhC96i48k1xXPFnYYszIFk
 lPenmLHviJgEoPeFBSY2FQc74UrfnZqQ/mRnCmQ8YgGrJsALT8Eu6ltJWTmSVvZZCZ0b3tLywJ9
 9ZOQfHWMQYNg66WnnV6y6KP9FODedDoRe5Z4stqFztNBwplh/qiOTCI9x823fgirIABt4f8UsZI
 upyauRNZvsDzan3+IFfuD6QEBza/P24qmECoVmtmDKkwzaCcL9br/WF0cYLoEAnotl8=
X-Received: by 2002:a05:690e:4407:10b0:654:5a37:dec5 with SMTP id
 956f58d0204a3-65e2267807dmr4295442d50.9.1778868091594; Fri, 15 May 2026
 11:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260515170658.187252-1-clg@redhat.com>
In-Reply-To: <20260515170658.187252-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 19:01:19 +0100
X-Gm-Features: AVHnY4KUIsmAoStDzlWThdrgBSjxyq6Gbeyc9Fgjzqwm_UezWX0A1Z7u5ViCPWg
Message-ID: <CAFEAcA8aPNGu0w2sFZWt7q0KECwbRPAO9tx9G4YEwL61apQNPQ@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Fix const qualifier build errors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 15 May 2026 at 18:07, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> A recent change in glibc 2.42.9000 [1] changes the return type of
> strstr() and other string functions to be 'const char *' when the
> input is a 'const char *'. This breaks the build in :
>
> ../tests/qtest/libqtest.c: In function =E2=80=98qtest_verbose=E2=80=99:
> ../tests/qtest/libqtest.c:2175:15: error: assignment discards =E2=80=98co=
nst=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualif=
iers]
>  2175 |         found =3D strstr(log, domain);
>
> Fix this by changing the type of the variable that store the result to
> 'const char *'.
>
> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3Dcd748a63ab1a=
7ae846175c532a3daab341c62690
>
> Fixes: f606321be88c ("tests/qtest: Individual verbose switches")
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  tests/qtest/libqtest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index bf9284b9a131..b1e06ea364ec 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -2146,7 +2146,7 @@ bool mkimg(const char *file, const char *fmt, unsig=
ned size_mb)
>  bool qtest_verbose(const char *domain)
>  {
>      const char *log =3D getenv("QTEST_LOG");
> -    char *found;
> +    const char *found;
>
>      assert(domain);

Same fix posted slightly earlier:

https://lore.kernel.org/qemu-devel/20260514191844.105888-1-matt@matthewpenn=
ey.net/

thanks
-- PMM

