Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D608C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 19:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvMva-0007lZ-T3; Fri, 12 Apr 2024 15:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rvMvZ-0007lR-Bp
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 15:51:13 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rvMvX-0004wd-IL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 15:51:13 -0400
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-6962a97752eso9651296d6.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 12:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712951470; x=1713556270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JuTxckrOnt77M3pRoWH01c3airIKIweKEGeN7yukrR4=;
 b=cvDAu90FkMUvUV7SYW23Jo2+9PiLkkNeVF689syLfk5fafHAX/yGYFs9mSzjQ4rLTS
 of7n584KvzR/J2Fxy+yWoxb87/UFzQ2ZhGsGsk41e7HnAJhwLmCV9kDtN4MYrJnRe0vJ
 DwWNgSrmUTLew7upLtPC9k4xNzJV2xqair3BGdS9AMfc+T5nIqE3XQLaKQoxSPA+vdI4
 qbvJe7GzN+pWjqp1xdKPfc/DkEmuJA69HgZLsIEujL9w7d8Y7j40XGqyoLCluMhvbWC7
 oxSqjHloa9VWku3NlE+n9LMS9eZGzy3/rdxVJpjmU+tEOaAyjI30nCTMikmH8EUnofJ6
 bwKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXadYPuzBpCDI7XuPfFYigHTCf+HeEq+y6P+1wcIk/3XVJG287dS/Q2L1PZumBuMWD+SBnpLWY86sxWsIFBotm9S2zvUwY=
X-Gm-Message-State: AOJu0YxZTjrH45O0S75766dDMvwNBVqum1L7ZirPsCF7+a/CmUb3bdLZ
 RpCPVL3fylHgR2VUkVE7GeJuPhJfiG+clHZPDiqYeT4MPi5yJTkLoOEZkjKpXZ4=
X-Google-Smtp-Source: AGHT+IG7wuzkczuBAMNzSjuji/o/LM9sr6OLeLcRwQ4YhThjlLdpQU3r1ii1Vqw3ejt3z1hKqfuCfQ==
X-Received: by 2002:a0c:eb05:0:b0:69b:2f64:6240 with SMTP id
 j5-20020a0ceb05000000b0069b2f646240mr4056343qvp.45.1712951470323; 
 Fri, 12 Apr 2024 12:51:10 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com.
 [209.85.222.176]) by smtp.gmail.com with ESMTPSA id
 u7-20020a0cdd07000000b00690c9256676sm2711750qvk.49.2024.04.12.12.51.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 12:51:10 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-78d575054c8so78351685a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 12:51:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUD01aCVR+xiBcQn6UqoPZ1hjSqR+TzBtagax/RLXmROnpbOnCkyvhuu937RpaAsoQwkxrXYr5l45Ii6vUknWr3oxTBmLo=
X-Received: by 2002:a05:6214:1765:b0:69b:155c:a793 with SMTP id
 et5-20020a056214176500b0069b155ca793mr3950706qvb.39.1712951469667; Fri, 12
 Apr 2024 12:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240412021509.145502-1-richard.henderson@linaro.org>
 <CAMFqb-bp48=Kd23AzwZ2U3AsPbnwUBUiyv=37ua1V_RDQ3wdyg@mail.gmail.com>
 <921ae82a-3007-4435-af7d-91a08a5acae7@linaro.org>
In-Reply-To: <921ae82a-3007-4435-af7d-91a08a5acae7@linaro.org>
From: M Bazz <bazz@bazz1.com>
Date: Fri, 12 Apr 2024 15:49:32 -0400
X-Gmail-Original-Message-ID: <CAMFqb-afq2RwkKZx1kAeEFRf=VUhoUk_Nsp6NCDVWP-qfNZEHg@mail.gmail.com>
Message-ID: <CAMFqb-afq2RwkKZx1kAeEFRf=VUhoUk_Nsp6NCDVWP-qfNZEHg@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and
 ASI_USERTXT
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.44; envelope-from=bazz1tv2@gmail.com;
 helo=mail-qv1-f44.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Philippe,

On Fri, Apr 12, 2024 at 7:14=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Bazz,
>
> On 12/4/24 06:18, M Bazz wrote:
> > On Thu, Apr 11, 2024, 10:15 PM Richard Henderson
> > <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wr=
ote:
> >
> >     Reads are done with execute access.  It is not clear whether writes
> >     are legal at all -- for now, leave helper_st_asi unchanged, so that
> >     we continue to raise an mmu fault.
> >
> >     This generalizes the exiting code for ASI_KERNELTXT to be usable fo=
r
> >     ASI_USERTXT as well, by passing down the MemOpIdx to use.
> >
> >     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
> >     <https://gitlab.com/qemu-project/qemu/-/issues/2281>
> >     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
> >     <https://gitlab.com/qemu-project/qemu/-/issues/2059>
> >     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
> >     <https://gitlab.com/qemu-project/qemu/-/issues/1609>
> >     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
> >     <https://gitlab.com/qemu-project/qemu/-/issues/1166>
> >     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> >     <mailto:richard.henderson@linaro.org>>
> >     ---
> >       target/sparc/helper.h      |  3 ++
> >       target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++-------=
-----
> >       target/sparc/translate.c   | 49 ++++++++++++++++++++++++++--
> >       3 files changed, 95 insertions(+), 22 deletions(-)
>
> > Hi Richard,
> >
> > I see this is in your hands now. I agree with your take on leaving
> > writes alone. I'm also grateful for the opportunity to collaborate with=
 you.
> >
> > It brings a smile for the community members who will be touched by this
> > amazing contribution. I see them happily realizing that this perplexing
> > bug has been solved, and in our case finally able to use the debuggers
> > we love! :D
>
> Does that mean you tested this patch and it resolves your issues?
>
> If so, could you add your 'Tested-by: M Bazz <bazz@bazz1.com>' tag
> when committing this patch?
>
> Regards,
>
> Phil.

Yes, I can confirm the issue is resolved. Richard has already made the
pull request. I am appreciative of the fast movement on this.

I would like to have my "Tested-by" tag added to the PR, if it's no
trouble. How might I get it there?

Tested-by: M Bazz <bazz@bazz1.com>

>
> > Thanks for the proper fix, qemu sensei!
> >
> > -bazz
> >
>

