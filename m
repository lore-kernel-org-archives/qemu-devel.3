Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFABCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISW8-0006YK-2U; Mon, 10 Nov 2025 09:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vISVa-0006MG-3B
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:04:38 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vISVT-0008Tr-RR
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:04:37 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6417313bddaso2456924a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762783470; x=1763388270; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syjgwIM3b8qxD12w75PkW3b43QcHXx4/qIrEDjoOAEE=;
 b=Rnti7JPM2JM4VuCqvOevzEGokiEhxa/K2ufeAiPctb39TZ9YulYxvyeraHgztlkaGp
 UzEAL506rTSN+Y3uG6dNHB1KgC9BaBMzxucJNmiG7GT5JseJ8fQDsJjHq2JafJxZHXCM
 Yr0VH5HwuoyS30hPU26v0WBQ2TCchH6ikvllld8gfq//xLBrxRhN9UC1W/TFdQY5tiMB
 858Gv3ueSuzbAQKZ369om/rZcitTMY35haVG00tGfSLcQQnZTsY9vw/rk9vy8yYR3sTf
 t/7guSIdVq/XN2pH/4LNrckdBndyAH7m3LOUSAevODWGil9kyPZWjSpAHl2ptjttGZ9X
 AW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762783470; x=1763388270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=syjgwIM3b8qxD12w75PkW3b43QcHXx4/qIrEDjoOAEE=;
 b=Q9DowJC5zXECj6Ko8lAfITkRScMrnxErctfTxaKK5Uo53UCrWAOkxisrA/v46YPE65
 /FCp3ZMrrNNITJnZtGUrR1KFJ6YkXTvv6jF7xUlXhgxNQkQaY773ruuJmqDz7QS9W3gQ
 LAfvF6M/aHCnSEFVylG/cXgDzV6PZwGFj+/kitcUcdnDWoHIla6SePuDYJ0Gm94pOwKC
 cWNtKTvp6WJcTqFUpmXHSMkpPCgtATIL6qs2H89BhJl5g96IU1CA1Odh9NtLqNwH1Flq
 hNyx0l8ANifmeFLMaezyb9txWtPgj3ftVmkjypGVkLm8fgFfEhI8hwKmSKrrtXfloM/z
 WshQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXr18UIiWpersQAy3bFO6climKB80fMdaGjs+MtGA+Z0EPcs8rxi1SdLkvsr1/i2Zcf513RWHG/gw6@nongnu.org
X-Gm-Message-State: AOJu0YyEj+n8KhXG52TiIltcpfkJATOIzUE2Tl10tgWULvCoLTd5ugL4
 WpLT8mXBxBrKjmoE16NbeIlLmdW78pPoyI9MwCDVQoAtDF5+8Wr4S7Fo55NhihGdHsi//L8hLPR
 hqBMxBi4BprvWzXrz4wNQBxScua6QEvjZkfoavMvQ
X-Gm-Gg: ASbGnctSHAsbJs3HZvw4L0aV5dS3GpUFOXWnwgdCjuGr4yScEMQU6vzSbyceCdqhQQJ
 n7VVM1em1gcbifBx+cJr0fA8TZbMN9K/vA3oQZ4tdu2SdnYh6/7TNZDDy+0h2HMtvGiEsqqlLXl
 TfWryG/NszdsGj+X66rJF79bmF/ezNcMaqIBCAEJ3GQMtrGFqQydhklsoGFSwbcBiAku+eYmz4R
 t/ykKRzYEdUab0KYTUp1FO+0h2OQVUUWMouGVB3n/mDg5Kzl/KZv2BojoJou4Sgv7LbyKU=
X-Google-Smtp-Source: AGHT+IGnZat1Ja7VBI00lHDVFE9CIoXvpSSMCwPjCJY/snrNF1go2pp3Lm5zwa56GHMCAmApAoj8qGZUHakNsZMiJu8=
X-Received: by 2002:a17:907:7ea0:b0:b72:5a54:1712 with SMTP id
 a640c23a62f3a-b72e053d5camr720767066b.55.1762783464663; Mon, 10 Nov 2025
 06:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
 <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
 <87o6paj96k.fsf@pond.sub.org>
In-Reply-To: <87o6paj96k.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 10 Nov 2025 15:04:12 +0100
X-Gm-Features: AWmQ_blNTlP3aP4VxvD-wlMadcMVkpFQcRmWHVCkH1n_1bRcME-glr2Kz5f-kMw
Message-ID: <CAJ307EgVTOPm6OTaKmg4XkyosAQ9baEJHiqMQEegQ=gkGAW6GQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 10, 2025 at 2:42=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>
> > On Mon, Nov 10, 2025 at 2:09=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> >>
> >> > On Mon, Nov 10, 2025 at 11:13=E2=80=AFAM Markus Armbruster <armbru@r=
edhat.com> wrote:
> >> >>
> >> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> >> >>
> >> >> > This allows more flexibility to vvfat backend. The values of "Num=
ber of
> >> >> > Heads" and "Sectors per track" are based on SD specifications Par=
t 2.
> >> >> >
> >> >> > Due to the FAT architecture, not all sizes are reachable. Therefo=
re, it
> >> >> > could be round up to the closest available size.
> >> >> >
> >> >> > FAT32 has not been adjusted and thus still default to 504 Mib.
> >> >> >
> >> >> > For floppy, only 1440 Kib and 2880 Kib are supported.
> >> >> >
> >> >> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >> >>
> >> >> [...]
> >> >>
> >> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> > index 8a479ba090..0bcb360320 100644
> >> >> > --- a/qapi/block-core.json
> >> >> > +++ b/qapi/block-core.json
> >> >> > @@ -3478,11 +3478,17 @@
> >> >> >  #     (default: true)
> >> >> >  #     (since 10.2)
> >> >> >  #
> >> >> > +# @fat-size: size of the device in bytes.  Due to FAT underlying
> >> >> > +#     architecture, this size can be rounded up to the closest v=
alid
> >> >> > +#     size.
> >> >> > +#     (since 10.2)
> >> >> > +#
> >> >>
> >> >> Can you explain again why you moved from @size to @fat-size?
> >> >
> >> > Just to be sure, you mean in the above comment, in the commit messag=
e or both ?
> >>
> >> Just to me, because I'm not sure I like the change, but that may well =
be
> >> due to a lack of understanding of your reasons.
> >
> > Naming `fat-size` instead of `size` ensures the parameter is only
> > recognized by the vvfat backend. In particular, it will be refused by
> > the default raw format, avoiding confusion:
> >  "-drive file=3Dfat:<path>,size=3D256M" results in a 504M FAT disk
> > truncated to 256M, raw format being implicit.
> >  "-drive file=3Dfat:<path>,fat-size=3D256M" is refused. "fat-size" is
> > unsupported by raw format.
>
> I figure throwing in format=3Draw to make raw format explicit doesn't
> change anything.  Correct?
>
> >  "-drive file=3Dfat:<path>,format=3Dvvfat,fat-size=3D256M" results in a=
 256M FAT disk.
> >  "-drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M" is refused. "siz=
e" is
> > unsupported by vvfat format.
>
> If it was called @size, what behavior would we get?  Just two cases, I
> think:
>
> 1. With raw format:
>
>     -drive file=3Dfat:<path>,size=3D256M
>
> 2. Without raw format:
>
>     -drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M

Yes and both result in a FAT system having different sizes. The only
difference being "format=3Dvvfat". When @size is renamed @fat-size, you
are certain to get an error when forgetting that format=3Dvvfat.
Moreover, one could think that one day,
`format=3Dvvfat,size=3D256M,fat-size=3D128M` could coexist, creating a 256M
disk with a 128M FAT partition.

Again, I'm not against renaming @size, but I like Kevin's idea to
avoid confusing errors just because you forgot "format".

