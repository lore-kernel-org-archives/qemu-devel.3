Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FF7C5474A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjCzo-0000GC-OU; Wed, 28 Aug 2024 03:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sjCzi-0008LX-9o
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:21:30 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sjCzc-0002Y3-0T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:21:30 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d3bae081efso4990587a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1724829682; x=1725434482; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jqeix1skPtALjiDJbkIsc7n6IBQ36vPKsvgZoH9TSVE=;
 b=RM7vDozGz9PqfB9lojAdvvWbcxwcyv3jpV6zUhDjIVWma5AIEs2pccXEp8+OmBEMKS
 QqoAXukAqbWUajJq8pCiWOvxfeua1zCnnKOAsE5IyKqlW20yp9mTpyKPmI0PM/5axcnC
 v8oh2wC8980PTqWP4G+4FKV95ApSjLIfoZg1LzUM9F5K6UT0MiA7GAuNmBZrISzxIC83
 PTUEBvAj0NVSIjc0m84bmUte3ZA53ewQqfc8NQnK0YO4A261p8qYYI1mBLKJOlgKrmX8
 OT7ud9Fqi4xqLrm6HL1Elxh3cOugf1LQjbqC348UJMk1HlPbM1+BHQLguuid0Uy/lW+b
 0XWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724829682; x=1725434482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jqeix1skPtALjiDJbkIsc7n6IBQ36vPKsvgZoH9TSVE=;
 b=b87PgWaKohlNf4aSda1Fa0jRKK6X9wwQtiaeesJOcev3gN3epnB/hJIeosvZwq+RJc
 bCidzazi1Bt48+qEOabf8cx5srsHd2wbJqYbiU/7fN+np3PHRbxV3IUsj3e4skDiLbKB
 efL3jwBT2rMHtAKGIDXB4GsZwxzKLVTgg618wx1YtHnKnJJfAo0XEFPdleNcDBDOvIyI
 ARk3tVbCpdKVnT3F9/z6c6XpbxWy023bFkY3wSHfgr1yGs60HhPQ/G6fyObkcd4pe6E+
 MwAxDLVgHnWC4wlB2UqtC/4qq1/ywPxuYqL7Pl0piYn00qvaMUFAB+tPQ1yE/LcOTIXn
 Zm6A==
X-Gm-Message-State: AOJu0YwZomf1N0QkTxUzWT4mEaTCssEoe469JippOHEJjinhVo6dhzME
 T+aEDBbkiDL5c56DU9kzhW7HfLFEQ4gIgxjaVXP/IMvVXRSoekLIOcutB8bJBe1xxhkvPPaLKVw
 RatSFIAoIrnKCCjXLrZuxTYYpyADynCR7US73
X-Google-Smtp-Source: AGHT+IGgIuaDfwIZxXDe+fUNxOEFCDVmo9sLn/9b1ayA5YPwYKpQe5ntBDvNNl3frhLzHRP0K4YmBvxDk8oaH42x08s=
X-Received: by 2002:a17:90a:780b:b0:2c9:5a87:f17c with SMTP id
 98e67ed59e1d1-2d646bf9f21mr16175477a91.15.1724829682112; Wed, 28 Aug 2024
 00:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084639.983127-1-chigot@adacore.com>
 <42fe0e65-e1c1-47be-9ba1-9a43e4a05192@kaod.org>
In-Reply-To: <42fe0e65-e1c1-47be-9ba1-9a43e4a05192@kaod.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 28 Aug 2024 09:21:11 +0200
Message-ID: <CAJ307Eg_w1K63Q7YmsAw6mSnwgPrC9R2UOvi+fUDjam4n0mvDg@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 7:40=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> Hello Cl=C3=A9ment,
>
> On 7/15/24 10:46, Cl=C3=A9ment Chigot wrote:
> > The BookE decrementer stops at 0, meaning that it won't decremented
> > towards "negative" values.
> > However, the current logic is inverted: decr is updated solely when
> > the resulting value would be negative.
>
> How did you hit the issue ? which machine ? I didn't see any error
> when booting Linux 6.6.3 on mpc8544ds, e500mc, e5500 and e6500.

I hit this issue while running some version of VxWorks on a custom
machine: p3041ds (description [1] and our local implementation [2]).
So, I'm not that surprised you were not able to reproduce.

> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
>
> LGTM,
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
> We have some automated tests with the ppce500 machine which it would be
> interesting  to extend to have a better coverage of booke.

Thanks for the pointer, I'll see if I can extend them.

> Thanks,
>
> C.
>

[1] https://www.nxp.com/design/design-center/software/qoriq-developer-resou=
rces/p3041-qoriq-development-system:P3041DS
[2] https://github.com/AdaCore/qemu/blob/qemu-stable-9.0.0/hw/ppc/p3041ds.c

>
> > ---
> >   hw/ppc/ppc.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index e6fa5580c0..9fc85c7de0 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -729,7 +729,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCSta=
te *env, int64_t now,
> >       int64_t decr;
> >
> >       n =3D ns_to_tb(tb_env->decr_freq, now);
> > -    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
> > +
> > +    /* BookE timers stop when reaching 0.  */
> > +    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
> >           decr =3D 0;
> >       } else {
> >           decr =3D next - n;
>
>

