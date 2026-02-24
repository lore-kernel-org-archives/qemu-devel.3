Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1D8E9B258
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vusJZ-0000G8-K7; Tue, 24 Feb 2026 08:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vusJX-0000FT-Mb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:18:59 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vusJV-0003ns-TJ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:18:59 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad46a44easo5239769d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 05:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771939136; cv=none;
 d=google.com; s=arc-20240605;
 b=D9XpnOOV82u8gS78Ry3WwaMjvGPBaOwJRVGBcbkD5kegOeZQckVe57oqF2xlImQnv3
 eAT/U+6FF/TgQn057r2E7wFCNUpcUFPFGGVA07BjotrqRZFUD6B7YcvjlDhQuqCiPk8w
 qLtW4Kn+172wq5e4pWdsbsTyKsJOyLbfV5g6jItb7f+kD459gIt3mivWE5I5DNW1nsWF
 4iTnXwLFUXaKpoRcWLHJGZkF6pBEVRhfMa6dXE8AZJpE2s/028ZSNbtEiPD6We84RGev
 NAgkG7331NDInFSf3HkRa2lpfHb5fxiUkwdpCSLz5jhlofLQaH/bqnwKwo+pTHyhSQ2u
 NVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7psvHBv/aOAz6m9zzEmsJBb2AAaFv8Bp92UVIA1sRPA=;
 fh=A5uudPlXg9IRufHgpi3H0hvgje+XKwuINeKYasTY4jE=;
 b=JJzw84sWksPpl/mjpCxsZNpzqZUmeYOBFdrxRBb8JTJkq4meSskwooxc6+ldXDsgEm
 BnOjKI4ShHHHKDKsjF0iQ9AEwvdEwi3QxU8uIP76EQwVTH2L+v0t2u66S76UB8NLrpU4
 SImWZ77FJyUbpSkdc/20Q/+DKPF6IN5xtknkek/KOId9mDy92QL7HfLq3c4qV7f4x65x
 bl9Aqj0J/O0hfz8VY441uOwV6XdYSyWrF1w3LjhZmChEo9AgSvEv/W8ICI9HPTVTpdXz
 Tu+Xg746kKXmw0k/N2/CLMaZxiMNcvdimm3K67lV4Yw/7Zxa9S7ZkCqzmPpXok/Tspn4
 eiQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771939136; x=1772543936; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7psvHBv/aOAz6m9zzEmsJBb2AAaFv8Bp92UVIA1sRPA=;
 b=BgmDYTAjF/Srk0b5Ypi9dEpmKkR0KkLRM4DzKxe4JRB13l/4955vOgv2JE9dL2aeIw
 6JMLRw7jcS90U05wfIc9oDU4++bIRzJskFCRjReh/6LMbgs6+E0AdqIq2TaVeV3A94WL
 TFU/wRtpj0BRWEM6bdJiPAm+bI8e3Ah99zWVZudBBgdLyrHavT21wWhcrj1GfNE9vIND
 tw6GlpE0JtYXY6wKKglX7lGscI+dI1hsXRuwj2mTK84qoGnHrH4omd2IWRhYmsnsWDAE
 KvTozRLadelisnz2Augv4DoeAMKqhqBwAJW0Q25X4qpbMq6Cdyhn5jstyNEd6KUkwrzP
 Iq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771939136; x=1772543936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7psvHBv/aOAz6m9zzEmsJBb2AAaFv8Bp92UVIA1sRPA=;
 b=JZY647Om5kUjDPRRyi0s76QQkiT8A6P85jHvUa/KG+ZPAhSr6b7xdLlA7q3DVmnkWN
 /DLWyPv1k1SLTLhUkA9JWzSLII+kB6N70dW7PMuqn4BW4dnVMaSr6tdT8hVjQvK7oK21
 wvEfvYqtLOl+xeiPmWUlyo9hRBuygXc9Ugfvf8ZH30YagLAk+PfqIHdLmaYZ91lO/DCk
 kACY72ZkOnGRE/6z78WlNABUbIGeZaCyomxC0cYXFCXisycdEEwdJ5i8AV3OkO0QvxMr
 EGSvSQ++jsvLbvtRqv3ZHTPy6XU7SAzH5M6Hp9YcIKTUMcE3NBxEYZugvRpSGi8BZHqE
 jFjA==
X-Gm-Message-State: AOJu0YwvDBTo98zaGwei9GCnxxXlaRsm+L8e85wHZnq9kR3Nsk9H++BY
 QKBS6z5+dBVvK/qt/w5XZlavV+dr4GFSvKOAzbLJkqmjhIiJ3lTDo5OFo9ra79R9XvZjkL+mAnW
 uhIJ37XAIv+70r6D4dZlqSPczffDcmR/ScUBsPbQdZg==
X-Gm-Gg: ATEYQzy3Mj9s3+jvBk52B+uey9jI5sbfD4cVhyitiOlk9yrqQnPK6lWgK4dnuSvrxFp
 wsVrQVXnV/D+TaX4qB5jo/hNQWBWud5cAdhsFsKYdRJiuPqvwzJ+ytKmgLq0Xrpww5EfP29jGQT
 cJUBsVGumRMpv1APw0UIZOZCVpgG+nCN5eSwIPbxGEDzjtm6HLD/AfTUj4KHzqt6Jv36t6XQ3Va
 yiLXZdpQJX86zffk9GamZW6qHq56qGjbFTzg1UiEMD++DT6jvjkv3gy9qSHEZ3xXKWyLK9xbzZE
 YaUME1epdPgLMYgzR4RP4n6hFaX1Ha6fo9KvZi3HAzrTsfNKTD2cVp9dQTHUxnEyakY=
X-Received: by 2002:a05:690e:d01:b0:64c:973e:8747 with SMTP id
 956f58d0204a3-64c973e8825mr3743013d50.81.1771939136444; Tue, 24 Feb 2026
 05:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-82-marcandre.lureau@redhat.com>
 <CAFEAcA_JDh++oFZ9+bHoPvxP4LuqjXUFWehqHdSZm16B=+iqCg@mail.gmail.com>
 <CAJ+F1C+TV3mQ0uqYF0txyiW9jKENMoYncLAAqUhFF3fFax9eAg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+TV3mQ0uqYF0txyiW9jKENMoYncLAAqUhFF3fFax9eAg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 13:18:44 +0000
X-Gm-Features: AaiRm5315KfQSbhskhqEA5T_z3YVKt2GaPuzjC-lhApmYMqUyPycIzWu7OeCjWc
Message-ID: <CAFEAcA_U44dM51_ssJrTVEAGR0yx5v=q8tRzP=i7Bn40YqUUVw@mail.gmail.com>
Subject: Re: [PULL v3 81/85] audio: rework audio_bug()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 24 Feb 2026 at 11:12, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Feb 24, 2026 at 11:30=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > On Mon, 23 Feb 2026 at 13:51, <marcandre.lureau@redhat.com> wrote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > @@ -498,9 +498,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE)=
 (
> > >      AudioMixengBackendClass *k;
> > >      AudiodevPerDirectionOptions *pdo;
> > >
> > > -    if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
> > > -        dolog("backend=3D%p name=3D%p callback_fn=3D%p as=3D%p\n",
> > > -              be, name, callback_fn, as);
> > > +    if (!be || !name || !callback_fn || !as) {
> > > +        audio_bug("backend=3D%p name=3D%p callback_fn=3D%p as=3D%p",
> > > +                  be, name, callback_fn, as);
> > >          goto fail;
> > >      }
> >
> > In this error-exit check, we will go to the "fail" label if be is NULL.
> > But the code at 'fail:' does:
> >
> >     glue(audio_be_close_, TYPE)(be, sw);
> >
> > and those functions will crash if passed a NULL AudioBackend pointer.
> >
> > Presumably we should simply return in the be =3D=3D NULL case ?
>
> I think so. abort() may be an option too imho

If it's a "can't happen unless programming bug" case, than
maybe "assert(be)".

Am I right in reading the code that we only call this function from
audio_be_open_in() and audio_be_open_out() ? Those two callsites
already assert() that name, callback_fn and as are all non-NULL.
So perhaps we should assert(be) there also, and drop this if(...)
check in this function entirely as redundant ?

> Do you want me to send a patch?

Yes, please.

thanks
-- PMM

