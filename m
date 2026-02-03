Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63103E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 14:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHV9-0005j1-7c; Tue, 03 Feb 2026 09:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnHV7-0005iN-Kl
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:35:33 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vnHV5-0008BE-Kk
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 09:35:33 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b8842e5a2a1so819226266b.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 06:35:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770129328; cv=none;
 d=google.com; s=arc-20240605;
 b=kDZdxYihbYknJtPN45k205Zi06mlYV/nMAmmXrAw1tKVbTEV7eu0IHh+5Q0ihC6ox9
 A5zbjMJ1zB1Y2dSZdqBb1xNkRFOwPFuyVNxhwLm/NTftyGHHvC2Sh/Lfrcah8JiYN5ZB
 chttqPTV0BGRqhbGzf9UsKKck97oFhmkAaYx3+uVedBCkBynnahuG3TMepSRZjf5YSBE
 o73F9G4VdM3PodAChlGHLF0NdzHcrC0+p3Yti7Ivjs54LT0rW+j++5/o8suCv9e4J7Dq
 8zHKzq7Lf8Xu67u2QUUDy72efrPNzpUH//7Pg3R/lpCo06pSTUOFZc7o0+8BjAEpS0WM
 5osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k90jmOIYPmeuRfh2P5YVYBEWl2Qn4VhpwCvZrhE8rEQ=;
 fh=EAuxJ/23N9BwvVDWvV5cwEFr6Y3sgg3sQSKv94rEUkE=;
 b=CAdL6YtkxKanqPz7UvaG3iT3RvX0u3IZCxeZxYapSeOZUhXS+MtHsTYOIsXcMaXDwK
 q0hecprFNhNhcXdCq9X7V6tZuAmLeHGyndIcNzfVLKzacXYQ+K0FJmsqjxbtUyCjuqo/
 g7j4jIMSiW/bx2FbvrrlRpcJb11RU9Dbj3y3eLGYjaVQUP3OTJMVdRVEtGqIaDgMDEuy
 5DbbDkFc4IzKdlveJH62vYBREoxVyPkQeCgHDy2+nWfNxfmye/5AS3J9dSiXYYd7eFM6
 sjwM+THcjUaBmwD8rKgzjc3UuXBoQqurSCpUGt9W8SCKAX52riAXxLq2YtaX2xuZX0kx
 akCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770129328; x=1770734128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k90jmOIYPmeuRfh2P5YVYBEWl2Qn4VhpwCvZrhE8rEQ=;
 b=btx9/08bsQWU5x+ezWaG5hJTQHkn6NL2Jt3+CD6ww+6l4rMDtQDNfrZi/IINVdtGYN
 Y6fftXwoDMoVnlF1foyWFNUYPyMGh078cP715D6sD3+n+1cBkK8k1WyivCof5ZXb7Dcq
 7y2tzgJPrIag7jSKtCPr8jxKVAJ7YDOOuZ53r44KXNgJassd7RWDms12s2LjHttoI4E5
 ln02/AdJ2UHjQPa3Rwb3NidmyD+ZF5X5BdsBKGGsDxhPSF/C0p5/fvejVXHLzBINsRja
 N/ZOi8UinsGXN4Dh+J2tcdpeesz6e+tFGxVc8WgvA3Ui5yF7IxU2ZjhZpjS8lRG0anRJ
 D7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770129328; x=1770734128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k90jmOIYPmeuRfh2P5YVYBEWl2Qn4VhpwCvZrhE8rEQ=;
 b=ICFmOfP0doLak3yfOqBKz9xU1MJuAdECV97tQGYvY+iaCGQak16ldmPipurk8sDXEJ
 sbFgM0fXpzTs/yU5f7PRiPAkQNR0o+qx2iTSJZz6eO0ZTM0vRKNdV52oTzZy7Cb+dOGW
 aVh9JsZby6ASYkFWg3Us+Ng3TczWsgG8AaRAiTiHCuQFOGJ5436Vfu9BqF78jkJn+GqU
 9O2RP28pLglz3QaN3idXmmgiCB6owT+h9MaBKjUU8etHht7Ps0aDeGIWxe5VEhkNdzh7
 127aU1/Vn+fj1zaTq6PAbhJExTbsiNZsGSR2gdByYF8/KwEo8s9Kqrs2I6IEtWB1DtTX
 rT/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYqv8Lq3gYUg/xVwADyYr2CWs1qAXrSHZBcdMMlw85ssBT9ejI3+AShdd6CUsAsgPWp2qLY7j6dmE8@nongnu.org
X-Gm-Message-State: AOJu0YxX/ALDxfuNG8Q3YhSvf5ndRSqj9DoINLM+JLIEZJjqWlGWo9Iz
 kohX+kMhgGHlRt/vBWOjwTyuqVaiETKATjMsdNpdB//6XHNU1vddQpeYuFOigjJAYaBrK+Yqf89
 hcqcpaUNuwmK+CZgPah9i+X9WzZ3KjI9xbOq+6svDow==
X-Gm-Gg: AZuq6aJ8GWmnjhgE8ePVLdQ7jitkbDhSKMUk8l8sSLhZC0PXy22yypAJN32p2wMwz1q
 bN+ftlJ8X7tl+7xPdlud15mraK98n66hy5GV4j5YKplVlhZX6uk2ftiUR3VKj4tUZrnqexSXYi0
 becYrdzxSu3h9coV85201sBD1K7ewqa7i/MKpqa+OMdsC4OzBOOrDhQ9j1T0z9ALEIyC/vZJSMt
 OOE3nopesHsa2xGZJxCGPGK4VoHzNozacAQEQx3yV4tyj2hnbcr0z1hqduMDBys29TUcbxozA==
X-Received: by 2002:a17:907:e0d8:b0:b8e:8874:8391 with SMTP id
 a640c23a62f3a-b8e88748e37mr113705266b.1.1770129328435; Tue, 03 Feb 2026
 06:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20260128152348.2095427-1-jim.shu@sifive.com>
 <20260128152348.2095427-2-jim.shu@sifive.com>
 <7b65cfff-3255-4fc7-b151-80ab284dbc1e@linaro.org>
 <28846f01-a97e-4034-8f56-7bef90417f69@linaro.org>
 <CALw707q9aDMR0R7wtBoBzT1FOOgMtrVsqN1FcooA_OjJHkEeKw@mail.gmail.com>
In-Reply-To: <CALw707q9aDMR0R7wtBoBzT1FOOgMtrVsqN1FcooA_OjJHkEeKw@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Tue, 3 Feb 2026 22:35:14 +0800
X-Gm-Features: AZwV_QgqwD8OWoGwYFRNyLSdsCGZZDF7aJyBH4rSu-lx71dTJafv_ZQaxMTDT2g
Message-ID: <CALw707pRsHtDsJHFzgPROFhRMgUigCBx0KeD71ZHKQsYi1E6wQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] accel/tcg: Send the CPUTLBEntryFull struct into
 io_prepare()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x636.google.com
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

I have sent a cleanup patch:
https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg00800.html
(20260203142737.2164763-1-jim.shu@sifive.com)

Thanks,
Jim


On Tue, Feb 3, 2026 at 9:44=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> Sorry for the late reply.
> Yes, I can send a cleanup patch soon to fix the issue Richard mentioned, =
thanks!
>
> Thanks,
> Jim
>
>
> On Tue, Feb 3, 2026 at 6:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org> wrote:
> >
> > On 3/2/26 02:15, Richard Henderson wrote:
> > > On 1/29/26 01:23, Jim Shu wrote:
> > >> To let io_prepare() function use the multiple members in
> > >> CPUTLBEntryFull struct, send the full struct instead of 'xlat_sectio=
n'
> > >> member as the argument.
> > >>
> > >> It is the preliminary patch of next commit.
> > >>
> > >> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > >> ---
> > >>   accel/tcg/cputlb.c | 14 +++++++-------
> > >>   1 file changed, 7 insertions(+), 7 deletions(-)
> >
> >
> > >>   static MemoryRegionSection *
> > >> -io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
> > >> +io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full=
,
> > >>              MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
> > >>   {
> > >>       MemoryRegionSection *section;
> > >>       hwaddr mr_offset;
> > >> -    section =3D iotlb_to_section(cpu, xlat, attrs);
> > >> -    mr_offset =3D (xlat & TARGET_PAGE_MASK) + addr;
> > >> +    section =3D iotlb_to_section(cpu, full->xlat_section, attrs);
> > >> +    mr_offset =3D (full->xlat_section & TARGET_PAGE_MASK) + addr;
> > >
> > > attrs is also present in CPUTLBEntryFull; you can also drop that para=
meter.
> >
> > Jim, now that this patch got merged (commit 94c6e9cf044), do you mind
> > sending a cleanup patch?
> >
> > Thanks,
> >
> > Phil.

