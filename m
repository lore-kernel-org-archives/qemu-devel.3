Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC38CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 13:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIRle-0004qk-5y; Mon, 10 Nov 2025 08:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIRHq-0004oW-EH
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 07:46:49 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIRHo-0004WE-9M
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 07:46:22 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-640a3317b89so4485866a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 04:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762778777; x=1763383577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8Qyeepfh5H+K/I4CAX9F0zVpJB9rap0MN1Sbk4QktU=;
 b=GVJp4GYDA3fWPhXorA/+Rg3Mx7B2jNhQWhKJQicUdmIVdsSSK7CUTUqc+AY5teRSii
 Y3zBbx6NTRwJ1KDJP8+VrHbZyexb535Jry69LvRvJqt8VSdjMrwsByfvSX9Ii55U6jIf
 2Ucab8nsu5WrAfM32e8zJbt2kr6H91TsOSZyyzfhzV8gIpoTijLkjkjJ0Wd/k09/n+dG
 Ir4UzeuNleuEbysv0+FX9VucaiRjjTfXdmAIz+SgJqkRGRBKJWlaQHZtRRCYLyBfjTHE
 p6qVehKGoaVJ2KP5WZRxSuQGWN0+HtRv/5TT/12m+oCe2uiOIOp3wUGW/PnQPja/3RLF
 4gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762778777; x=1763383577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+8Qyeepfh5H+K/I4CAX9F0zVpJB9rap0MN1Sbk4QktU=;
 b=oCqPE6hB7ga6YOgvKkPYjtQagQ3Qj6n+JSgW2V/J7CtZmQBQF+2UqT2ocoGFZNm5V9
 GjVqdkn2FN9uS98gJALl5PFKetpLs2vldy9axB5P/5SmMgPZaA1E5SOai2Bw3JpJGUAV
 vfp/459lmLkDOHUXCpFcgB6EDCdaiUtiTsgm3KD2IhVUxlA0YWuyJwK6BKEOg9NirQju
 1jyvdOvsQv+DI/l6w6XQ9ROPVjtCAddyD6GaqV/bL9OExhvZT0P1hhmwxh+sTUACCkNy
 3SlhOJ3V19IxNzNtD2rQco4mlNmjlR2J4WIg//ir41fnGsVOPNN2duH3d7GseOy3g2gB
 MaXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDgtTSn9Vx6uywe/IRBFXrYK1T8dt3QJolMzrRUpUjdUZKsjYR5v647SZEDO+EKwDiiZ/84ujAKiMV@nongnu.org
X-Gm-Message-State: AOJu0Ywb04Nwx3/7t3p00ViJkIh7rUKa+lsS+YZRYjJnoFuC6Imne24Q
 4I1EvcfZq3UsgjBBUABhmQ4Q3GLAvWO+mEWnjbwkF5E9ex+UrzYzfCVh1WwMd5HaXiyWSzDmVSI
 yVWJznRQJMgtVR0TgVckV+W2Ibu5AntIPdW3gpgXi
X-Gm-Gg: ASbGnctviMnjuDRtBFVBIvDR3+x8gD7mfhorXVkn7yHpKcj9LFUofXec++Om4CJKrV1
 N1tTqjXxtvUhd3rJgXJkuqydzo6B5eGf9sT2+WQ3upDjZnk5+Anb8A6ukjhw3U8rA6lB4N3oGe6
 QDzSaBfrbd0xQ/QDByc6koSHbligrijbZ+zFFZVsSUkTytovR1H3FWiEC2ihSNbrPVVMkAl9a0m
 fTY3wWTs7563DDVmgUt0W/vTD56oAb6UwesH+AOUFPuB0U1f2OR/ssjpsmI
X-Google-Smtp-Source: AGHT+IGuAE8NjZX4CC1GsSz7iYQdfl5IjtZxCCzYO3a1mLKsNv/kMkYXGNU3axidJW38Cq5za8yzwUtfxnGL97Pyklc=
X-Received: by 2002:a17:907:2daa:b0:b46:6718:3f30 with SMTP id
 a640c23a62f3a-b72e04c75bcmr804868166b.51.1762778776522; Mon, 10 Nov 2025
 04:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
In-Reply-To: <87zf8umbzh.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 10 Nov 2025 13:46:05 +0100
X-Gm-Features: AWmQ_bmoje3ecwelmMYgTmrR4vqDbiQ9IONV3oJFHZFJm6hID9bRrLSRml7FCxA
Message-ID: <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x531.google.com
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

On Mon, Nov 10, 2025 at 11:13=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>
> > This allows more flexibility to vvfat backend. The values of "Number of
> > Heads" and "Sectors per track" are based on SD specifications Part 2.
> >
> > Due to the FAT architecture, not all sizes are reachable. Therefore, it
> > could be round up to the closest available size.
> >
> > FAT32 has not been adjusted and thus still default to 504 Mib.
> >
> > For floppy, only 1440 Kib and 2880 Kib are supported.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> [...]
>
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 8a479ba090..0bcb360320 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3478,11 +3478,17 @@
> >  #     (default: true)
> >  #     (since 10.2)
> >  #
> > +# @fat-size: size of the device in bytes.  Due to FAT underlying
> > +#     architecture, this size can be rounded up to the closest valid
> > +#     size.
> > +#     (since 10.2)
> > +#
>
> Can you explain again why you moved from @size to @fat-size?

Just to be sure, you mean in the above comment, in the commit message or bo=
th ?

> I assume you dropped the horrible special floppy sizes because ordinary
> sizes suffice.  Correct?

Yes. Clearly better that way.

> >  # Since: 2.9
> >  ##
> >  { 'struct': 'BlockdevOptionsVVFAT',
> >    'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
> > -            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
> > +            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool',
> > +            'fat-size': 'int' } }
> >
> >  ##
> >  # @BlockdevOptionsGenericFormat:
>

