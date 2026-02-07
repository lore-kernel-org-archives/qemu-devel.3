Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E3EE0AE0
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 17:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vom2m-0002nt-Fv; Sat, 07 Feb 2026 12:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vom2l-0002nQ-6P
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 12:24:27 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vom2j-0004SO-Oi
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 12:24:26 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79518cc2bb4so28945297b3.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 09:24:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770485063; cv=none;
 d=google.com; s=arc-20240605;
 b=F0EX+e2tBiRfHyOnPYOpNqaNsdB+m07ftHjmh3+UhqHwsRxlLRpPh/6OcO0x7LMZTy
 iwpCz/1M1AU35N+J/bJcOx8TfVcgPP7XKalcHrgUeebqDdXVFvZnM28Uh7dz9WHqUCOY
 yaBH9oezkLSGp5ve9St59PSG+P6j9ukNuCBiWnji0BvYGWSP7oboKX3D41soOAIE7cWK
 jdktoGxXXFxMbHBoMRLN6VZK0tMtcm/ixfDEAisgGRz2dzfc1yDoJc13gbGOTSjQr6P7
 HzeA281IzSEiGfukFLklmccRAGcNxnJZUe5F+/T3KnT1Zav5q5BEdgTmym7ECLOJmnWS
 nBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fG9u+rhxAnoWtIzvg4BuCMilcgm3foUHCd2T822XsRU=;
 fh=NJvA+NjT+zC/TtqXLu7zu89CQzUbnrg3KKbKPzV7ePs=;
 b=awajo9GjorRYwsGvk4t8SJBqRBXDoX/u0WBXKZPk3Xm8niSYmsvES6WUenVdy51LOZ
 uNQAmY0qsh0tfWdlK4/H8j4DOf8hhphOzDBZYc6iGBtZfxjZcq7TiMmfsLCCwfGedOy9
 mCWL5+V1jyuWXWVd02K+xeHXcU4BS5MLuWlrgDQd2Nhj6NXS5Jn6iHTBkOIyYTFT+MwF
 RNN/prQUZh8pji1f2yefuAc97IhnbY3I1RUOV7vfdtxtfWNyH0Fe/0MW/XwvcFYgRBsV
 kbDN0+s4RylQI1n1CDP7i/p6tdWdTUlB73zYxx0cL3CQtX9LYVQN3HXH5J4vpYitpkRL
 FrOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770485063; x=1771089863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fG9u+rhxAnoWtIzvg4BuCMilcgm3foUHCd2T822XsRU=;
 b=DD4E6RvwaDZuZsx6C7DtMTZ+kC1s/5LZDdDVkMSLeZ7Nl8YAY3vQTiBvDLbdshm+2Q
 50DIlkxRfnL19kM7/45ETrGczqW6SHDf2DAPX4EJwKg5JCSpDGc/n7+qJM1ZUcUY6lEH
 qjEqximjpuzEaMD5nDFDZQoAE9db+rhNIJ2iQ6KrmfV9a4OR1BPqvyr//KlKOPEAVZEq
 YSbxLXc14RIajVoJXzzR69gjfG3kS5yCX8GIa+x00ZV2MmueILMHsrWJsf8/IAtG7vkq
 +zPUjGefRuGHmvTmCq/+PxTZFn05C3ZD4kXK6syI/csOSB/KwLI5QO89rvyqnysC9GR/
 +tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770485063; x=1771089863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fG9u+rhxAnoWtIzvg4BuCMilcgm3foUHCd2T822XsRU=;
 b=V1BLU4Gx4WCpkt70PHjTpwhwmADXhslnP+GXgFJ0UE8diiVt/O7Sem+6cn1O4j4NP+
 mD81Md7NSgVQlCZ9x/fFzNGlCQHA2ghHfsIJNGq3t/IRXkFbICOdBmujlJ/2QGcNCyCu
 AGaV2M0fsgLOHkJ7X9TjXPRoWD40ikR2qlZ//QX8I+TTkPBytApBJ8fcOgPwYmAzkBb+
 7wSmKLdy8yU/qPyDsXHVLF7mqRkRBKKvp4jyuzRFWsYTSb+MdF7t42Okp+7ED2frQNQK
 USN2pUDbqkEXeYW4ouwVe9t0PWiL458JaINaoQXlGY3KBRbY4KsCCjIMu2HrutTxVL6f
 DYQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU4g1cQYiJLfDHCOY9wqdCYrzblaUTG33kwUUfD9zDPSQnQri9t8fT+8yV1Y82LO3KYZsxShGCfKlv@nongnu.org
X-Gm-Message-State: AOJu0Yz1K39PMb2FCS4EI1NhS9+pZRkm6MyU1JnGF4OAIfaWPUVI8vMl
 9NzOY0t774xavNs0YFdRtcluIWHlY+rGX8QbeCmgy6dexGBaLhqNXnybK1Yx8k5lvv4cdY19FNW
 No0er8BQDk0mBH8KgHe5/MHykOpJK3WbT5VQNS9s58Hf0dUK/503N
X-Gm-Gg: AZuq6aKbZmecb/9b6DfrXc3thMK3DxPFxcbsxQNWSRH+3GUZL8jU6WR2TKr1B80DmFH
 MYzDaDNoTA1kPWwqE1Af4s23iglLI+/fu2LvHbtG2/zzoduUz6We9oNSS2C4pVoGx4cAZp2IIjM
 rrBzZtHd2Zzt5WHtyuXe78TDkJBuF/NhWVjPzRJwtQhOx+vY/TxJ85gIK3NqFp7wWbPLoeTlQH5
 A4EG7QP7nvWQLA03h1inMxL5eyGfLjoNpuIBGZ9M/Gn240V31IiUVnrTeXxgnSWnkZ0plPWpI8I
 fYMnKJ5tnfLQ3iZ/Nyibs7fMqgAKflyHEBvAnNw/Z7vlEX2W5/0Tj3Q=
X-Received: by 2002:a05:690c:ed5:b0:796:371c:7afd with SMTP id
 00721157ae682-796371c7fbcmr13257257b3.13.1770485063503; Sat, 07 Feb 2026
 09:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20260204075754.21078-1-heifetz@yandex-team.com>
 <20260204075754.21078-4-heifetz@yandex-team.com>
 <722eb7df-0eb2-49c1-af07-90004ad46a8e@vivier.eu>
 <14605571-e078-4d93-9f0b-411889a70076@yandex-team.com>
In-Reply-To: <14605571-e078-4d93-9f0b-411889a70076@yandex-team.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Feb 2026 17:24:11 +0000
X-Gm-Features: AZwV_QgEBrWldqgA2gYP70QraDkDO_XqjXSe-RWbno73vDrTGCEFxif4EnAZyO8
Message-ID: <CAFEAcA_Kzy9DCnwM0CyO+X_RveRavhkSrBGoW_MXEeGstkgWsA@mail.gmail.com>
Subject: Re: [PATCH 3/4] system/physmem.c: reorder usage and assertion of block
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Sat, 7 Feb 2026 at 10:24, Sergei Heifetz <heifetz@yandex-team.com> wrote=
:
>
> On 2/4/26 17:53, Laurent Vivier wrote:
> > Le 04/02/2026 =C3=A0 08:57, Sergei Heifetz a =C3=A9crit :
> >> Reorder the code so the assertion of block occurs before it is
> >> used in the subsequent lines.
> >>
> >> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> >> ---
> >>   system/physmem.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/system/physmem.c b/system/physmem.c
> >> index b0311f4531..4308e02940 100644
> >> --- a/system/physmem.c
> >> +++ b/system/physmem.c
> >> @@ -2054,11 +2054,11 @@ static int memory_try_enable_merging(void
> >> *addr, size_t len)
> >>    */
> >>   int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **err=
p)
> >>   {
> >> +    assert(block);
> >> +
> >>       const ram_addr_t oldsize =3D block->used_length;
> >>       const ram_addr_t unaligned_size =3D newsize;
> >>   -    assert(block);
> >> -
> >
> > According to coding style (docs/devel/style.rst):
> >
> > Mixed declarations (interleaving statements and declarations within
> > blocks) are generally not allowed.
> >
> >>       newsize =3D TARGET_PAGE_ALIGN(newsize);
> >>       newsize =3D REAL_HOST_PAGE_ALIGN(newsize);
> >
> > Thanks,
> > Laurent
>
> Should I remove the assertion altogether, then? I think the const
> qualifier on oldsize is more useful than the assertion.

I think personally I would drop the assertion. This falls into a
category I think of as "assertion doesn't buy us anything".
If block is NULL we're going to crash immediately when we
dereference it, so the assert doesn't help to turn a hard-to-debug
bug into an easy-to-debug bug (e.g. by catching incorrect values
long before they're used) or to turn a nasty kind of failure
into a safer one (e.g. by turning an array overrun into
an assertion).

And looking more closely, we call this function in only
two places:
 * migration/ram.c, where we've already dereferenced block
   in the code just before the call
 * system/memory.c, which asserts mr->ram_block before passing it in

So I think the assert in this function isn't buying us anything,
and the simplest thing is to delete it.

thanks
-- PMM

