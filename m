Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2076AFE51F5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCzC-0007zX-JK; Fri, 24 Apr 2026 05:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wGCyu-0007rg-SF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:37:56 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1wGCys-0004dN-Dn
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:37:52 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-50335b926c2so59649631cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 02:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777023469; cv=none;
 d=google.com; s=arc-20240605;
 b=h/MBn9lr0mFDK/ku7KfwAa3APH9D9S3cF9oj4fq0PekP7mAr7J7cr15I52Kz/r5hBo
 N72sfD45i7GdHotIwLqKjq7FBQ8vmAX+DgoBcyVVwdqgjUTYu2JYbXixMSsNPo9C5HYV
 mWE84W5HhnRBMgAnRHFPsS4mFEeW+ypYuDd06Ng5BYz7VAQKND7ISDj9bcHWlniRrbty
 Sdz1jtRYZv17/z656SvDWyfps82epI1q13V+IxFA/+QnCuc3OqtViIXsKucoVqiy4CNO
 Is9yYSqKXqBEgkCPKKN6eRhL5vwhwnkNPgsi0mHb8MAuury7z0yElezm3OHwPxAwwQbK
 pq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Nh9lMzsGCzpxGxgA+xl/9Qq5hGURu9ZhNKe5ypNKxc=;
 fh=huUyQFm5TluVBbLcqggc93ZVpvVU9XRZAzl+wX4rr8E=;
 b=l1d6Cg0Uxa/tpz0PJ2IBcXSem43udveqGRchhE03YMG98bEIKEG72uBpyedfkfybap
 xEvPpx2rKVfNZ6mTK37HXiEvBoN4dLyTWCyykfNrKtZoDvrFlAetImU7hbHrttXADpdC
 AsO68sq1phVCMqdZR4uL1WYa/4X8I1gEQhkWHouFGdNcx6GZG6Ff+OnWlVC1qgFlKohY
 PDwrW+Hq/8n+qx6S/f+ACKuanyeCvhF7W8sfYFwhrG4FnzYe8qddGcnQ//9mNjlQyW8k
 XcYTzhi69s/LKaRguEZcCsXa15SfhfLBDA7sMklqjLnU0NahyshZMq7DD+7PQb4Vc78b
 ALeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777023469; x=1777628269; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Nh9lMzsGCzpxGxgA+xl/9Qq5hGURu9ZhNKe5ypNKxc=;
 b=cKGSApkgxtvZiXq4TIDLzamP034+04C5vT7mgn7yNy8aHh2UuPQxFshJASlrE8NPu8
 uBglXWbxtx1U368EuTHLpaZWE+NtE6B3t3MruV30BnpFiYJ4sXSw2Ui0wiEaZrbNtzLU
 67eNxbT+1KIzVCWpV/WS7bT/pVjBmvVD7jzWnPsNrNarlezChos+BQCPD5odiJA59CsD
 98s3Y1/mVYiIMqIf+gVG+yhOR2kaIr1AKadNh1GrK9lLYH5/8Tcn5BV2td5KDURWxSGH
 y1p6HFEhLLb2M03STNaFgXVDAYzBxDH2QwStQOLBr8MJTOfkJh8ceZg/Nio7Ce+bYx23
 J6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777023469; x=1777628269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Nh9lMzsGCzpxGxgA+xl/9Qq5hGURu9ZhNKe5ypNKxc=;
 b=ndqn3VBzmhT1RtwHMEHVNCeBfQqTkq71X4aAOavsnz3cD1b+WqlqHNaq8vK8KDYNwR
 GE8C6lkY6KxP0mJuB9P/VQOHK7NFv3u05TTo1uOM1iRMtAlTmlbvtRovZ5yF/AxKPnBo
 yRMzxbI02bfJqF0q1dIsquda1i6UKRySslOgorW3CO51t6sLSHpi7N82L0TffuNGUSCu
 WTrlhNrCeKy+FZekxU3Ux1HTg9t/y/ycNYMAbESSLINNyWOY5cEPF36AEKpZDXco5Tzt
 Cj87vBgUXWkN3cII/ukqJPdR4W3zHFfWdD60YwVAteeidic6Ts/iPPLM/ew8zvuVKR1m
 vbHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XcBYpnzXyZhVgwZzCjwgeEAjfMoAq8+1dXG9RpAIdgRk41hQosNdjRzV/a0Em6/iXn2evH5AEgy+G@nongnu.org
X-Gm-Message-State: AOJu0YxO2bPtCO3ciVAn1kAvgz4zIo73PcTzZMfQxUBQ2zaqKFr9pnVq
 cqhfwYXAj1KgqIWH8P3m2HQ+3THuOz7Yo6CXo/pSuRHsbw1I0kv+PFeh7vB7Xo2V+jsn2b3qGIL
 2brh30TzRlN9K2m7fU84tOOjZ4/tWkKY=
X-Gm-Gg: AeBDiesBuvrfA3iYc7PMaxLO//0iNDQCIQQUHv4gU2CXkz8szQ2zExK1F5OD8TOOUt0
 VcBeP1uoX9KndegMtBTagrSk1haC4RhsgSYWAvp7DYEjkFr6xyyrSPV2OXskJxfvWjEmc9Gp11L
 +S8+Tmt0V0IytLk/r3LmvyaezWJaFxc45Vzl1+X6Uuz8FV+LtJwyWrRrdC4qEx5/Itb+6s+v9ZT
 8o3Lcjmlo4uxZl3wxea5JxGKg1rCwAZ0uCyj7G1NCSKXFuhnVU6r/HzHassPwWzvZckTjOW2PTO
 Orm/RKhVDH/85ZF3aXkpuH3nZ9oXtUecVa04xo0tIG1DYs51vT9L1FuFcEkJT0ia031FlyyCjzQ
 en9Gwj6HbaemFCXdqMMcdHphCiG1XLkpK4n08
X-Received: by 2002:a05:622a:1994:b0:50b:404a:746e with SMTP id
 d75a77b69052e-50e36ee74c4mr466498961cf.47.1777023468935; Fri, 24 Apr 2026
 02:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-4-cjchen@igel.co.jp>
 <3a80c5e5-9889-4830-9a00-5d4d92141a3a@linaro.org> <aLdA4uH5CGbfz9Gd@x1.local>
 <CAFEAcA_TjVAzntgxdLF7rn4fwMk+YH6eiPdTVEQopRWceHGfrQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_TjVAzntgxdLF7rn4fwMk+YH6eiPdTVEQopRWceHGfrQ@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 24 Apr 2026 02:37:37 -0700
X-Gm-Features: AQROBzA4oNtGbgnyXqLpR4x5SgTfzheXqThJ0oWd9vt2hFm6mUPFHjKj7SoR4CA
Message-ID: <CAMo8Bf+XAgaXsmQiURQXOicq9LkCfLpNVMz8dDSHHVfGttwvJw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/9] hw: npcm7xx_fiu and mx_pic change
 .impl.unaligned = true
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Apr 24, 2026 at 2:09=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 2 Sept 2025 at 20:09, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Aug 25, 2025 at 01:00:21PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > Hi,
> > >
> > > On 22/8/25 11:24, CJ Chen wrote:
> > > > By setting .impl.unaligned =3D true, we allow QEMU to pass along
> > > > unaligned requests directly as-is, rather than splitting them into
> > > > multiple aligned sub-requests that might cause repeated device
> > > > callbacks or unintended side effects.
> > > >
> > > > Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> > > > Tested-by: CJ Chen <cjchen@igel.co.jp>
> > > > Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> > > > Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
> > > > ---
> > > >   hw/ssi/npcm7xx_fiu.c | 3 +++
> > > >   hw/xtensa/mx_pic.c   | 3 +++
> > > >   2 files changed, 6 insertions(+)
> > >
> > >
> > > > diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
> > > > index 8211c993eb..6bf524a918 100644
> > > > --- a/hw/xtensa/mx_pic.c
> > > > +++ b/hw/xtensa/mx_pic.c
> > > > @@ -270,6 +270,9 @@ static const MemoryRegionOps xtensa_mx_pic_ops =
=3D {
> > > >       .valid =3D {
> > > >           .unaligned =3D true,
> > > >       },
> > > > +    .impl =3D {
> > > > +        .unaligned =3D true,
> > > > +    },
> > > >   };
> > >
> > > Surely a distinct patch.
> >
> > Besides that, I also don't understand how it used to work even before t=
his
> > change..
> >
> > E.g., both of the xtensa mx_pic read/write ignores size, that doesn't l=
ook
> > right already when there's totally no limitation of impl.*_access_size.
> >
> > Meanwhile, taking xtensa_mx_pic_ext_reg_read() as example, it'll return=
 a
> > u32 by offset smaller than MX_MAX_IRQ (where MIROUT=3D=3D0):
> >
> >     if (offset < MIROUT + MX_MAX_IRQ) {
> >         return mx->mirout[offset - MIROUT];
> >     }
> >
> > But it returns different u32 for different offsets.. so reading 0x0 ret=
urns
> > the 1st u32, then 0x1 returns the 2nd (rather than reading 0x4 returns
> > that).
> >
> > Even if there might be a driver that works with it, it still doesn't lo=
ok
> > like the traditional way of doing MMIOs.. irrelevant of setting unalign=
ed
> > or not in its .impl.
>
> I had a look at this. Unfortunately there doesn't seem to be any
> publicly available hardware documentation for this, but it looks
> from the kernel driver like the hardware really does work in this
> weird way. arch/xtensa/include/asm/mxregs.h has:
>
> /*
>  * RER/WER at, as       Read/write external register
>  *      at: value
>  *      as: address
>  *
>  * Address      Value
>  * 00nn         0...0p..p       Interrupt Routing, route IRQ n to process=
or p
>  * 01pp         0...0d..d       16 bits (d) 'ored' as single IPI to proce=
ssor p
>  * 0180         0...0m..m       Clear enable specified by mask (m)
>  * 0184         0...0m..m       Set enable specified by mask (m)
>  * 0190         0...0x..x       8-bit IPI partition register
>  *                              VVVVVVVVPPPPUUUUUUUUUUUUUUUUU
>  *                              V (10-bit) Release/Version
>  *                              P ( 4-bit) Number of cores - 1
>  *                              U (18-bit) ID
>  * 01a0         i.......i       32-bit ConfigID
>  * 0200         0...0m..m       RunStall core 'n'
>  * 0220         c               Cache coherency enabled
>  */
>
> #define MIROUT(irq)     (0x000 + (irq))
> #define MIPICAUSE(cpu)  (0x100 + (cpu))
> #define MIPISET(cause)  (0x140 + (cause))
> #define MIENG           0x180
> #define MIENGSET        0x184
> (etc)
>
> so the MIROUT and MIPICAUSE parts are more than byte wide but
> the address decode puts them a byte apart. (This is kind of similar
> to x86 PC in/out IO ports -- you can have a 32-bit IO port that
> is immediately followed by another IO port, you don't have to
> space the port numbers 4 apart.)

That's correct, the address register in rer/wer xtensa opcodes identifies
the register, and it looks like the usage pattern of this address space has
changed over time. MX interrupt distributor uses addresses as indices,
but in the more recent designs 32-bit wide registers are placed at addresse=
s
that are multiples of 4.

> So I think this device definitely does need to have both
> .valid and .impl set unaligned =3D true.

--=20
Thanks.
-- Max

