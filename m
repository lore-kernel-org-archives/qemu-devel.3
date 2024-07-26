Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F61C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHOo-0002BB-9u; Fri, 26 Jul 2024 05:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sXHOi-000280-24
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:38:01 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sXHOf-0007VJ-JQ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:37:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso2373116a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721986675; x=1722591475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UcAH1+L4Yv+zlJoqvFyEVMRobQJWoqCLRd9rImdOTU=;
 b=nHNKcMzdkIuuNKqqkHTw8gpwqlmxOd7Ip0s3omcZvhSoamNKBnNnE518WcbIVk2JdN
 CKAZTNjL9yv8uLLrCQL+DXpns8ULAwT2jQayx5uQ9KvtN43j+hjZUzPl+TdkmV7C7wdf
 1qA6aInbhRmGla1SfhyYkhdvV8JvRf5kiAE5BqXTjtpFtgIoBJKMhfWV1jUKlKoaLgym
 oFQ6nKERUk5Aap/taGtzRssWiuuR8jVdyPW906s9LfFaFWJfdM50Jv50/jjlGl7uoPAP
 AOoRGI0uawWrxzwFcWPfFzZYs0IiEuAk6p6X4k/WhojymYhS48XnsrvfE9kCYlLjM4sN
 9Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721986675; x=1722591475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2UcAH1+L4Yv+zlJoqvFyEVMRobQJWoqCLRd9rImdOTU=;
 b=j1xHdDuXFbCiYn7vomOjcFiuUSn27V89LRNgTgAvHx4njSTFx5+6tkN7ihU8I84zCS
 nA1mjogIih2QdfcOEEBbetk0H534lq9H6QKhByYvXy+J4wvBblU9168ivi2prKlU2wTp
 Pr1UKmv4g+8I6mhJEV/jFaSgq5nJ0ROFU4pBBQF/O71gWEh4c6uldoKYzJBLhZr0Zuuc
 /FzhbdLe2osE2IQ0sSxGY6lg5m60ku8wE2chmcrnBPnlJRZa7jp5tWMYVWBgT8Jbsb5L
 PnYqpCA59dhjMDCRNBtt8nTGbXeedMe/hHyJnv3pblDuQ0agmz8miyuUuTyTQNq0dmMr
 GciA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXicAP3bMfXVj8DcDJujsIG5jvGn1Io7r5svmIUVPoGT+ti8E+SljxTRooYgYj9NEbmCdn4k2NJNEAw7uusWDMh++bINHk=
X-Gm-Message-State: AOJu0YwUQu0t5bAgJctlSYvt6uRy34v9mMf7w16EgMezjTeyiuDU34Ox
 hCGkdua+hjJz8dTWNomMtBsiELsiresCuGL+hh5i1j/MJrhHA2MjFB6sSUDmx3lUPMfjfrDTAHw
 Z1Q9/O2T4g9Qs0Y8BXewzJHfSOZP0nulis2EJMA==
X-Google-Smtp-Source: AGHT+IEuXLDEUaO7o3i+po0oWT3pBCNfcaxmJjOt/LdcYGX8/0SBw+vr386RnxBVF1dORKGASRRyGkoANvquLGwHnRc=
X-Received: by 2002:a50:a451:0:b0:5a1:7d68:62d8 with SMTP id
 4fb4d7f45d1cf-5ac657865a6mr2696044a12.38.1721986674897; Fri, 26 Jul 2024
 02:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
 <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <CAFEAcA_rBrA=Fy_m+U_OZaznbBn3wykTCyUf3S5aMA36YHXNkg@mail.gmail.com>
 <OSZPR01MB645328F814AD0BC9629BF2A18DB42@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB645328F814AD0BC9629BF2A18DB42@OSZPR01MB6453.jpnprd01.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2024 10:37:43 +0100
Message-ID: <CAFEAcA-D1=SzRwgHv6KL7wrSAY3GBHszF1W=XHYJ9xzcz9cp2g@mail.gmail.com>
Subject: Re: [PATCH 00/13] make range overlap check more readable
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 26 Jul 2024 at 01:16, Xingtao Yao (Fujitsu)
<yaoxt.fnst@fujitsu.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Sent: Thursday, July 25, 2024 11:14 PM
> > To: Yao, Xingtao/=E5=A7=9A =E5=B9=B8=E6=B6=9B <yaoxt.fnst@fujitsu.com>
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>; qemu-devel@nongnu.=
org
> > Subject: Re: [PATCH 00/13] make range overlap check more readable
> >
> > On Mon, 22 Jul 2024 at 08:00, Xingtao Yao (Fujitsu) via
> > <qemu-devel@nongnu.org> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > > Sent: Monday, July 22, 2024 2:43 PM
> > > > To: Yao, Xingtao/=E5=A7=9A =E5=B9=B8=E6=B6=9B <yaoxt.fnst@fujitsu.c=
om>; qemu-devel@nongnu.org
> > > > Subject: Re: [PATCH 00/13] make range overlap check more readable
> > > >
> > > > Hi Yao,
> > > >
> > > > On 22/7/24 06:07, Yao Xingtao via wrote:
> > > > > Currently, some components still open-coding the range overlap ch=
eck.
> > > > > Sometimes this check may be fail because some patterns are missed=
.
> > > >
> > > > How did you catch all these use cases?
> > > I used the Coccinelle to match these use cases, the pattern is below
> > > range_overlap.cocci:
> > >
> > > // use ranges_overlap() instead of open-coding the overlap check
> > > @@
> > > expression E1, E2, E3, E4;
> > > @@
> > > (
> > > - E2 <=3D E3 || E1 >=3D E4
> > > + !ranges_overlap(E1, E2, E3, E4)
> > > |
> >
> > Maybe I'm misunderstanding the coccinelle patch here, but
> > I don't see how it produces the results in the patchset.
> > ranges_overlap() takes arguments (start1, len1, start2, len2),
> > but an expression like "E2 <=3D E3 || E1 >=3D E4" is working
> > with start,end pairs to indicate the ranges. And looking
> > at e.g. patch 9:
> >
> > - if (cur->phys_addr >=3D begin + length ||
> > - cur->phys_addr + cur->length <=3D begin) {
> > + if (!ranges_overlap(cur->phys_addr, cur->length, begin, length)) {
> >
> > the kind of if() check you get for start, length pairs
> > has an addition in it, which I don't see in any of these
> > coccinelle script fragments.
> I understand your confusion, but it is difficult to match the region over=
lap check because
> it has many variations, like below:
> case1:
> start >=3D old_start +old_len || start + len <=3D old_start
>
> case2:
> start >=3D old_end || end <=3D old_start
>
> case3:
> cur->phys_addr >=3D begin + length || cur->phys_addr + cur->length <=3D b=
egin
>
> case4:
> new->base >=3D old.base +old.size || new->base + new->size <=3D old.base
> ......
> and sometimes the length or end may be also an expression, I can not find=
 a way to
> handle all the variants.
>
> So I decided to use the above pattern to find out the region overlap chec=
ks as much as possible,
> then manually drop the cases that does not meet the requirements, and the=
n manually modify
> the cases that meets the requirements.

Ah, I see -- you just used coccinelle as a more flexible grep,
effectively. That's fine -- it just means that when we review
the series we need to review each patch for e.g. off-by-one
errors rather than being able to do that only on the
coccinelle patch.

thanks
-- PMM

