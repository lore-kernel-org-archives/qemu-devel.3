Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79A8D4A60E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgf6j-00078d-MQ; Fri, 16 Jan 2026 03:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgf6i-00078O-MB
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:23:00 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vgf6h-0001Es-1X
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:23:00 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b872de50c91so272274566b.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:22:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768551777; cv=none;
 d=google.com; s=arc-20240605;
 b=hsyVDYCLoG18vzeM5bGjmWnPUMceNHuDg+xS+VKTEGidy7nBvIpJ6ZlWczSyjGB/Q5
 bIpS+BYSLXhab4SUlhRVk184yG4khvh2TrWzHvckANXhWrn/qkqOMwcCrqaIf62D4B9v
 QVBg5/sLI5S+h2JuXXDWA+3CMIbuUmKkrgEk58r61fEm7Gd2NRQX5cZMloTgBLCk/Byn
 W3tySKXckPRKqgmtbmPszJ4Uau81D+9p/J1Mo4XZ6gacg/87jHKazAwsGVOli9j7UuCd
 dyCO048GhEKmZmeDoktcOLRlDCDblPw+GnSKEJIkA1oOwvCpq3C88b/ytF8GBwEkNjRt
 6+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8U9d+yHBt2iYPgbH4I+xSvjf5sSxuC6E7xKc4wJpdCQ=;
 fh=O+EccdZRT6nQIcq25wHyivePAEUmEST5Dz1qQn/OxAs=;
 b=HGKDutMnOL3zB3dPBe5s8S8jtfl2CMUxeWeIKVtobDm9u1bPMhWqQ45ZVNOAInunwF
 ihNmuC3la5pHM7hktmEPxIzwRo+YfJqlRuwmLTQEpGaf9sMZf7JeZDXUwVfHB4yAoHIg
 fhF5PhceawQEgUwvdvJjIaU3GKqa3qwbgc9RwsKpRLdOiwEPemDAlBQLyi3rHlg31Iej
 mTqwMyRQuHbweifz4UbEPyVNELPlE0haS2vbIDnuQg4qslRpWS/lhrNQ6AMwrpZt95fv
 qElgCy/xBDiJN+GCdvraDLXY5QWIbg50cN1F2tZCkrXtVkoFQdP8eDAwSF8c04zCYguF
 9Hpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768551777; x=1769156577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8U9d+yHBt2iYPgbH4I+xSvjf5sSxuC6E7xKc4wJpdCQ=;
 b=ToHq+mtD+d2MFpvwkAmQ5G5k4RAU7OWLIKn9AA/zLnsiLydNCj5J+CRWovkjoOEZnD
 nvL4XCoTq8K10auwTLB4lcqIUYE54ZVrt1YxDOIfzPsiiFJ3s2xS07sy7ulttudhQQaR
 qYzUYAnxIv2q01eg0Ewk/Om1FXQcRoN8RIHgXFnyTZ2kluhTN6fIml3dEK2l2tcFamtw
 2GCjIQ388t+jgh44lz1KIiR4gia/VbA+vyu+pZ0mt5kLQJNBRLilr28b5hrfNw5EY6z2
 prg791MiNE44GM4xF6HuC2UZBA5GP04WUI1I5zWpq1Dja7CVSpXQeTVOtIzNwXyZ+vn/
 Z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768551777; x=1769156577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8U9d+yHBt2iYPgbH4I+xSvjf5sSxuC6E7xKc4wJpdCQ=;
 b=wYVR0Hv+hlh9/CmlLPtSkNYNPJPdhF9k5Qr32TvfTFAPuZHCFlnSUA2dHuOF5gOYct
 Dim9texron0WF/k8ynOlQ23aYuantXF4slsqeLGvSlogZVQMXPTfH4lNJL2rYD4x3Dur
 1XD/8LoPAZLxtDgahPwIpgLNqyZETQE0PGDCJUt14kYey6A2eLd+O2XOONaQyL1q4E1A
 B0yxiDOYuXKm6X3jKOgBnj6VzMSbz1rir04urbo+VCD1vd+IHERVn0AxGIGeKeyr1FNe
 I/nu7tAd3H7/EbB2qRlO0GB7Cj7QAd6PhAk9kaYI4fheaeI7trJKawQQB+9Kd2AHtnbg
 8QMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbPaXXgwa5fPOX6MAWwnrrCSBEG4ZpcZwO+39h+E0B+vzFUBm6QhsLlyJl6SkMHGvYSg+0U1h2plfh@nongnu.org
X-Gm-Message-State: AOJu0YxkekLiClxV3Cs1KyWkyojkjsq+vp4hTb3mQyBf2YLEoamiM1ML
 iz1i3c8lOlYq1VCDXoHJf4pfLJ1jFtj10djBF2kdnR7zON+B6hBuOSHnh/s8aP/B/QRKsqJ4oG1
 GLrchSGaPCgYGKt023Qix7G0QBunY01jqg3SX5hw=
X-Gm-Gg: AY/fxX5lgVa6I1v6lMfuRbTsvM7gvg/B5/aAYgVhucro6L7Wv/KfN7xY7K6acG9ZLvG
 3SXnIwzKQffATYxBZXZX8N14mjDXOl0TwItotXj8ouQ2LARx5bMUVsxREl4k/KlPWpAZ4eZDQ95
 BTJ4xur0cPxQKRAIlDzjhZEoFMRrDuD/Dgj4S55zWTecgi9BoOoVyXEeKPjhadt8arzsaBMSl+R
 7gCYBR1Flp1WmRvDsjOdIlSO1VlFO/K+lqGtcvEQayWZpr62Pzfa2fdwJU9dk18KR+7nMBp
X-Received: by 2002:a17:907:7201:b0:b87:281b:1453 with SMTP id
 a640c23a62f3a-b879324d5bbmr205650366b.59.1768551776843; Fri, 16 Jan 2026
 00:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <87ecnqt6nc.fsf@pond.sub.org>
In-Reply-To: <87ecnqt6nc.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 16 Jan 2026 16:22:19 +0800
X-Gm-Features: AZwV_QhLXQVTfGaPPar14g95XxuNhDdRW0beD-UZajbOWqy588x5cyAWR6MKr_Y
Message-ID: <CAK3tnvKUXk9yvvTKC6cJOKnMJrhZz6W_ZuKze=rqj8JHAREg1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
To: Markus Armbruster <armbru@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, 
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Juan Quintela <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, zhanghailiang@xfusion.com, 
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Jan 16, 2026 at 2:26=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Lukas Straub <lukasstraub2@web.de> writes:
>
> > On Wed, 14 Jan 2026 15:11:55 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> >
> >> On Wed, Jan 14, 2026 at 02:56:57PM -0500, Peter Xu wrote:
> >> > COLO was broken for QEMU release 10.0/10.1 without anyone noticed.  =
One
> >> > reason might be that we don't have an unit test for COLO (which we
> >> > explicitly require now for any new migration feature).  The other re=
ason
> >> > should be that there are just no more active COLO users, at least ba=
sed on
> >> > the latest development of QEMU.
> >> >
> >> > I don't remember seeing anything really active in the past few years=
 in
> >> > COLO development.
> >> >
> >> > Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s la=
st
> >> > email to qemu-devel is in Dec 2021 where the patch proposed an email
> >> > change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
> >> >
> >> > We've discussed this for a while, see latest discussions here (our t=
houghts
> >> > of deprecating COLO framework might be earlier than that, but still)=
:
> >> >
> >> > https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
> >> > https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734=
bc74c71@web.de
> >> >
> >> > Let's make it partly official and put COLO into deprecation list.  I=
f
> >> > anyone cares about COLO and is deploying it, please send an email to
> >> > qemu-devel to discuss.
> >> >
> >> > Otherwise, let's try to save some energy for either maintainers or
> >> > developers who is looking after QEMU. Let's save the work if we don'=
t even
> >> > know what the work is for.
> >> >
> >> > Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >>
> >> My apologize, I copied the wrong email.
> >>
> >> Cc: Lukas Straub <lukasstraub2@web.de>
> >
> > Nack.
> >
> > This code has users, as explained in my other email:
> > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#m=
c99839451d6841366619c4ec0d5af5264e2f6464
>
> Code being useful is not enough.  We must have people to maintain it
> adequately.  This has not been the case for COLO in years.
>
> Deprecating a feature with intent to remove it is not a death sentence.
> It's a *suspended* death sentence: if somebody steps up to maintain it,
> we can revert the deprecation, or extend the grace period to give them a
> chance.
>
> I think we should deprecate COLO now to send a clear distress signal.
> The deprecation notice should explain it doesn't work, and will be
> removed unless people step up to fix it and to maintain it.  This will
> ensure progress one way or the other.  Doing nothing now virtually
> ensures we'll have the same discussion again later.
>
> "Broken for two releases without anyone noticing" and "maintainer absent
> for more than four years" doesn't exacltly inspire hope, though.  We
> should seriously consider removing it right away.
>
> Lukas, can you give us hope?
>

Hi Markus,
Maybe you missed something?
I think Lukas is ready to maintain this code in his previous emails.
https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc998=
39451d6841366619c4ec0d5af5264e2f6464

Thanks
Chen

> [...]
>

