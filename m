Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9A4109B46F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Zgk-0007kY-AK; Tue, 31 Mar 2026 10:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w7Zgi-0007jI-9v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:03:24 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w7Zgg-000341-GB
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 10:03:24 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2c56aa62931so2109563eec.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 07:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774965801; cv=none;
 d=google.com; s=arc-20240605;
 b=gF/nayGnboxN27ak/hinrXo32xRIr+B1jMfYRpkVrJkB+oXaU7fo5x9TVV87MwV55A
 Xj973xLV/5nIAljaxbx1q+u/tg0i01unRJp5v/gfSxhAWygpjAEoLKuMLNiLYnuEV5MO
 I7c7TIp6kqKcDcyA6xfdpYOggrvF9lgWWUJOeJi3A2bpmsWICKXWxBRoe+cyqsaO6dCT
 XceDQdn39lIK1h2i3kv2Tqw6HKdTgN0nwMgzXRBQubWaTFUuRvaRAjlRIiy6VkIjGfFP
 upjhegwwpWSRagpoQBsxEbZUvu4B1gJif8nCTMhK8MXdFSqD0z/eWPSGC/8AiaQYxhoA
 bASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ynOzswXCtzjghJqPKDYZbvbQzJ1ybrthrnZSWnFd9bo=;
 fh=OhYinQ0HyhTM2igkDvDPLECxbeOrY6f0ndbTXidgUYY=;
 b=BUF5/Mw8mIBymaNP6svCNa5j7pZKNzK/EfYbs9IdglC1MHm0GJJxadWNLrxNND6q4z
 aMLiPBFfly8iCJBwdtyWSYXvwtU7XbHM6C05o25yKS5DhdAqmHALpAOvItuvI5gZKBhK
 x7HvjKnCnbvXEJgcQN6ItgK7BR5ouHFafesTDqTeoTA1C+IV+4llESCi5EFB1V6UOSrW
 QkyRdrsMKoNZeh42g9EGiWNos/ilU35A5giH9jc+PebH+GLstcuTIUDnvjHvSk1hmW93
 DjfRQ8YwGbISW1Qo58dsKXkmafojOTGGPwHaxehR0oba0IXBw0iN3TEliBD09YsJWSQc
 Hgmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774965801; x=1775570601; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynOzswXCtzjghJqPKDYZbvbQzJ1ybrthrnZSWnFd9bo=;
 b=GMXKGeJSWKI8Y8gft24/xT/qNexFPvHCG7/zpO2nflVwHPMGCdMlZqcsgJ3zp1oWdJ
 HAtLAb670lCipIiwzct70n3QFtpSCQ9gUS/PK4/IjPG8+z0YKww9JFG8Fjx7aRLD6hXG
 Wv2PopNlz9iBQXmBVZiZkGb8ZXz2u0wTUWePLEnhbordG+KhxIDPktGw8DOcisskKtrw
 k5rjG3irdY8N5ovVzF0oxMtilWz4pHnhfusxmavDKnvxmzqXCMUXl3r0Bpq1M91Rqep2
 gUbV+5Etb6aqHSu9JpU/hEmbaB1u0UmHVRszh/W3z6KsKcs14abu94Jtpr39qjMKZy49
 Soeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774965801; x=1775570601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ynOzswXCtzjghJqPKDYZbvbQzJ1ybrthrnZSWnFd9bo=;
 b=XaYOAnyzP/dYjPvNAbacITyCuuwkUiK0v879pkDrSg2vUNGd8CJ/Xcw1H0rm+N9BUk
 dzfp7ZiyELRExsV91hpv/dQD3HkX6SqYTuOYKsx33xmoZ+0dYoBPW7O6ioqZc2jxqFYK
 4nSByVNdJeuzVTu493uVgq1XaG5u7F8h327de68r5aQ669koA+zM9RNvPU+heozEQvVx
 +srdnhOandFSD1dhhtp+kZRtSx3IISBRxvMRpDYd1epRH4oI475/8JC9tZx2w5enjKNK
 TLMvzePEkl8e5L8uYAsZ70HxpiMDkdbmRVHjw8JVI87uVUyWG3RWlr+SiWWkdOnqRhiR
 JYkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHZ6WLU4lx3ZYfaBfGdD4EEQuF7cCqjo7rbr2KnAAxkIPdFq2hIESeYYaNFN54b7gcJOjjZlkbxbcM@nongnu.org
X-Gm-Message-State: AOJu0Yya6RSrZ+tuiNVeSUiAsGQ6O9aNH1YL2Tz/Snxy57p5Fz6C7KVE
 Nw7scibC7PaSaWRaCkHT54LbHywNfrS5bHqI9UZ37hpc2PLvyBYVxJh1Yw1J7VyRB4BfDOw8IqD
 4WsIcASFrHf7WyNGD3zSUkgRAw1iTFdk=
X-Gm-Gg: ATEYQzz9hNMUhLuX+Pp8QYF1WdXo5MxBFIqbgNqWO+CnNNpNlBsaoZpyQqMQYdfzna0
 rrGH01x0TI/7dqcSLYsT1K0ri/zpPgV8I1cqpaw3EdbFlsubHAMLmHNxHJA4Cb7BrOeD93kl74F
 slfFl7xSxnMnjF14J/GQxunoCP4Eo/LQyMdXJM8cw5QqHWCg2tfDPkXJsrjFnSiU1N/Nv11AD80
 gYgaXUM0IZ/KK/vLLknFeZ2W1DUcwCoboYX797fQP1Q/pP9EtA3MhJ6NTSmVy1BjsOd8igC67le
 3p++LhjGwtNLJXvIFZ6NFVBuC6sJigE10iiUtXU=
X-Received: by 2002:a05:7300:ec0a:b0:2c5:50fe:c795 with SMTP id
 5a478bee46e88-2c550ff2592mr6460423eec.29.1774965800686; Tue, 31 Mar 2026
 07:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
 <20260223134731.2377432-73-marcandre.lureau@redhat.com>
 <9a0eda08-0474-4283-8060-e8b31193ed59@collabora.com>
 <CAMxuvazuUAzB7gU1RzAgf12WEQHTiF86Z1R8+dZ8CE7noEvRgQ@mail.gmail.com>
 <CAFEAcA-AV2T1wdKueMAWGL8Q8co-kCBxi=fPWDeiNs3WD28y5Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-AV2T1wdKueMAWGL8Q8co-kCBxi=fPWDeiNs3WD28y5Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Mar 2026 18:03:08 +0400
X-Gm-Features: AQROBzCnTGxFMkRAjeOcDzpFrk9FG2-fZCAkv18KolNY4tbLlJ8_gvYUqlCGwoY
Message-ID: <CAJ+F1CK6D1jnKapiPhF3o5tL-inSnk_6un6Bth_Pj6z9kHFi+Q@mail.gmail.com>
Subject: Re: [PULL v3 72/85] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
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

Hi Peter

On Tue, Mar 31, 2026 at 5:55=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 17 Mar 2026 at 14:02, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi Dmitry
> >
> > On Thu, Mar 5, 2026 at 7:55=E2=80=AFAM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> > > Audio (driver=3Dpipewire,model=3Dvirtio) is broken/distorted on stagi=
ng tree
> > > and I bisected it to this patch. Can't see anything obviously wrong i=
n
> > > the code, any ideas where the problem could be?
> >
> > I can reproduce this. I'll look into it for rc1 and let you know.
> > Thanks for the report.
>
> Hi -- did you figure out the cause of this? As a regression in
> this release it would be good to fix this.
>
> This has been reported also as
> https://gitlab.com/qemu-project/qemu/-/work_items/3368

The fix is part of my last PR:
https://patchew.org/QEMU/20260331095302.644608-1-marcandre.lureau@redhat.co=
m/


thanks



--=20
Marc-Andr=C3=A9 Lureau

