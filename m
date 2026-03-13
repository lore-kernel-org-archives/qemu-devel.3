Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB54106FD61
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 01:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0qtD-0003yW-Jg; Thu, 12 Mar 2026 21:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0qsu-0003uv-H0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:00:12 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0qsp-0008R2-92
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 21:00:12 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b96f02b4329so279094366b.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 18:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773363605; cv=none;
 d=google.com; s=arc-20240605;
 b=bM3wMyWZzQg9TebwIGJOwfQL8/TSiZ/CVR8dx1O5h2BiOQ25QZOF3sYvenckmjQViX
 L+EI/KPz1Rzrd8JWdwvIptImZDOOhREhM8JwZc9J5t1dH99R164kqmHVwD7LeoT3ASPc
 7hKyBdFxOtP4TSkHB6dFG7dtAnG2xuFWnVXjXqr7gGlXH7fwJXOL/VDddgS7/rSFPgtb
 anjxQ/W7IsXaM1QyRnrZBNa3YOuaYLGoXPidPmO0zyEG774sMINmT6F0kSYS0gpj2Kx4
 spYFeUk4aM0WXTiocZJ4xM89v6YQO0Y73XyzzmtpMlRmN/BTg6UXpmWjYRJveMAaOnJW
 UjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5ZgR8BSiF+84MD4HwyGPhFVK3y2KFoC/suNg6YBagvU=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=cz8xgiGmFxIfyLphPf/HpaO1mVOtZnOerJSBUQoN6nf9lEH3Y9QQTuYJ5axyB/N+lR
 Bq2JaGqcLj116u0zGEVUgmYrvtOXPmm2mVC5DDmOozaQpVbu1DOaUEnV4OLaKWPjHYXS
 VEfZ2LKo9+C442x3yNnuuz+EiwpNFS8cDNBH3IBIgUxhj9fwK9/iR6UmPhC8lCXOPAmY
 Dm/qw1dt0pW2jPiw2ZUzC1z6c9kBFlBE42lGlxer1cGbiutwxoTVgGwciX6QyGsks3ih
 W7qOSEMwPBcjuNQ7UqGUsopiEwjHSy436ERl9CXoprC6gib6a0dMOhZH4zXX/BOzLiAi
 dXjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773363605; x=1773968405; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZgR8BSiF+84MD4HwyGPhFVK3y2KFoC/suNg6YBagvU=;
 b=PFT56y3KHfqE7C2RY8eS5H8CVGZW/yWm41wuw76LOUQhgvUEDesNdSZqqinUEw7M32
 ellFz0Z1WLrLblZ9EJB82omMlSAQH6qQJ5nDBykLoGHvdZuUAHXcUFz9bKfOPbMRpGrf
 jDgcI0JVuv42fCNuY79PnI8Db+kUtaw6KIlk8erOVX30VSj3mRMntn/TTb2qY1WO5lBz
 CbMZc4H1lS59dYmgP/aIpB/7t6RjRKllP7vnnkbPL/B6pvd1vzEsMCCXOAhxCkSlaWPU
 HHkGhB86VNpnGlo8deZ0fWFYhXmITMxUxLLx7nxnamAFwY2HRqVEPhPCZemVdhzo+uZR
 juyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773363605; x=1773968405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ZgR8BSiF+84MD4HwyGPhFVK3y2KFoC/suNg6YBagvU=;
 b=Rjktl+e1oLMG2IiQPwPpQQqbdW4ZRu//OkgGeeWNqK9DymclJ+BrqqCZxHvFG2VRRA
 rTd0dClM5YiUClvfpGlqDROK3y3bJFg1xv4wkTHAzynbF+7aaxsvDHJ2B+qbUDbr4lhZ
 XC1Q+5sTsiCZHTcAh6o1yJ+UPkckStlbjuFfd95YvroPckTa6mfudzCuAy9qbgjysxJJ
 SoY4BJOslQQL9/Omb5K2iXBUoz1BxxZYk0gJsrPlFPjSWf57iaTh7G9NPIzuHaEpnJSN
 qELgyREWiNatbVyLBAD6RdKxJtM/bk3oD7MP3Xlvepr5wgVFRch4H2JewMihZTv3+7Sq
 HAaw==
X-Gm-Message-State: AOJu0YzonSa913TtB1Xe+7l/kcS8itH9IknohXYLYwvqIOylqG9NM4nN
 YL8krw75Fg9E7QXdg03YXO3JlK4eHlBpuXZI9n4OQxE6y6vDmxghWOpyRQBj0esoQG2U+fd0Ijk
 sKJbzERQM+1UTHBNJBsqEQgfOM05Lzz0nbDWl
X-Gm-Gg: ATEYQzx8im9oYWHzv5nNgwZIFQ3pQDh72qRGV1RXkSZvqCMaS1be5uR7j3L8xDXJQDY
 Bft6206vZ6mWy954Z3Zv9o07pCTfsMYSrFTYDwO5gGQeXINXmnxozAZFyXA+Syj9WMeqs5s0ZTJ
 p4b1k0P4J+BdSnRkDp6/Q/eW9C0ts+wgmhjuJNaGR78RyCrW+Tz4ZW2vo0nSbWHaIQEaGSV6HOu
 H/8Q6yF4aQuVlK1knh7VUhWmt/LSStiujq+8Snbm8igZZXsErcJfdjs1BNzLS4GQEV720d6NKJB
 y9XxuWiSmYRp3sVgqk/fhGrLm2J0oMxOMPdxmQ==
X-Received: by 2002:a17:906:e94e:b0:b94:2b6c:aed3 with SMTP id
 a640c23a62f3a-b9764f78040mr51836766b.3.1773363604891; Thu, 12 Mar 2026
 18:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-6-max.chou@sifive.com>
 <CAKmqyKM-mu7+gtFRK+G94szLFUDdxGaz4zxW7-bW2L5y0Kn2hw@mail.gmail.com>
 <abKlW3gA3qXR6bub@sifive.com>
In-Reply-To: <abKlW3gA3qXR6bub@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2026 10:59:38 +1000
X-Gm-Features: AaiRm53k81TF3oabmpcFRgs75qTCoudd7HXGEGgS3bbEyDyLVyY9LaSlzMzTNnQ
Message-ID: <CAKmqyKNVZmweVava8LyzEy+tu+UFDDgj+VX6Y-waYQEp8YbGbQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] target/riscv: Use the tb->cs_base as the extend tb
 flags
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Mar 12, 2026 at 9:42=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> On 2026-03-09 15:01, Alistair Francis wrote:
> > On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> w=
rote:
> > >
> > > We have more than 32-bits worth of state per TB, so use the
> > > tb->cs_base, which is otherwise unused for RISC-V, as the extend flag=
.
> > >
> > > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com=
>
> > > Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > > Signed-off-by: Max Chou <max.chou@sifive.com>
> > > ---
> > >  include/exec/translation-block.h | 1 +
> > >  target/riscv/cpu.h               | 3 +++
> > >  target/riscv/tcg/tcg-cpu.c       | 7 ++++++-
> > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/exec/translation-block.h b/include/exec/translat=
ion-block.h
> > > index 4f83d5bec9..40cc699031 100644
> > > --- a/include/exec/translation-block.h
> > > +++ b/include/exec/translation-block.h
> > > @@ -65,6 +65,7 @@ struct TranslationBlock {
> > >       * arm: an extension of tb->flags,
> > >       * s390x: instruction data for EXECUTE,
> > >       * sparc: the next pc of the instruction queue (for delay slots)=
.
> > > +     * riscv: an extension of tb->flags,
> > >       */
> > >      uint64_t cs_base;
> > >
> >
>
> Hi Alistair,
>
> I=E2=80=99m curious to know if you mean adding more details here, such as
> specifying the bit width for misa (e.g., 32 bits) or the bit width for
> ALTFMT (e.g., 1 bit).
> If so, I=E2=80=99ll include these details in the v6 version.

Oh! You did update the comment. Sorry I missed that.

No action required!

Alistair

>
> Thanks,
> rnax
>
> > We need to update the comment in `struct TranslationBlock` for
> > `target_ulong cs_base`
> >
> > Alistair
> >

