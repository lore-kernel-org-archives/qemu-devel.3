Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E29CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN0kv-00086O-AP; Tue, 12 May 2026 23:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0kt-00086C-9Z
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:59:31 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wN0ko-00019V-S1
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:59:30 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c801b30188dso2729005a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778644764; x=1779249564; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6IaU3SqsHhAmhDLcCCphqad6fYjahycylMRTzDd5Cho=;
 b=Z0sUu0AkaC7t0Yh493yue3NSUt8uo92z2c2RbI2BBIu1MRycy5e4HZh1HrK+Wa8RME
 KlVrpRLfCaiCNU5Iz9y+4cG4LG06RSU2YjFJ3IKiGvGkHSZLUbex+hWN/AgYCRoK9JRT
 dwVHId9auCa5c44yN60t3m4AkRYhF3Eoh6Lj/yPTuJ+g42QU9qKndHiyhvSBhr5MUzJh
 RQs28RTOm/MuISdPBy1599gFSsyUvmaW2+n5Xj0rg9nruPahkh2kQXWrqBBl5YketLHH
 P3a7BlMP/ZM53pikhQHUj5eWAxOCcrjDCJTk29qvHZperTJ8rmGa8nOEhTC4WRekfQbC
 bAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778644764; x=1779249564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IaU3SqsHhAmhDLcCCphqad6fYjahycylMRTzDd5Cho=;
 b=prLti6eqt66UtBOrXDzZXYjfGW6EclcN/+3i9rG6NVFMC2SA9M+cSEHoXDa15BEDL5
 UtlfJYMhZNXTjcTwlH7+ewqLqFMj0gfl/63W3Ns251BS/HIi7RUzYFg9FNLSd2nsiNc1
 iwGDItaJ1UPQGxJeVimwoQaq8bArU9eltueuNh5lC7wSk41aPoRqlUqryqxC4oUusmHg
 Gde4X0EGbVpvA/fNDvlemmLPAx9KfRTQdXRb4zm76IR+YKxcZOohwmAsf2MiU3UrWDjp
 Cv+aWigL6tZy9jC8cZjf9H4mIV4F1pzt5pXwYTM7pQZ/Xeh2RIKVEOi8HKhCUSwDM5GM
 QEqw==
X-Gm-Message-State: AOJu0YzkDA7ZORk30t4ZZcxyE/oZYJ7fdfDVsPg3Ee1ogPLk9L2vAi9V
 CP2DBonZ1zUhIdYot12H1Yac2yrOQM4a8JRsAuBYe1IVw/+is8QOauwq5+4H2ccU9tbcrk0n6qM
 pvRpuz9CrZOwpuVP6ArsKg9yIyXTbKUPdRRBg1iBSkw7jQmcu4fe66wgY+Sdt7rMS+5BpWv4GIZ
 MTqUXF0x4hpFtUytlSUDWXC8aZIEjC1+UDMeCHzXpbXz5h4A==
X-Gm-Gg: Acq92OG5gj45ZsQbWm0BQBPc3/04TDY1Rma2iv33QS7/dkTciVJLiC7j8FJk81n0NBo
 688yT+5dFXqisdxP9ZCpU9iYhkuQlq7Mng0JncYYGwmDFmXeLoKzprSbCEiwbe5ng2YIHfkSL2r
 lAs8yAvyTMGDoW7xf3RcRXkbFje19+EpGnDFfSG44h0SgY8N1b2iCSHIj/s9gqUOwLUSs7Lrr9P
 RjbNpIkRWhnNFApht5b3ZF5g9h6WpXp2ICJcFujH39SKt+0ssdf5cADuYwu6GADcyMdYKbNrUPh
 RA0lbyS3rFNfPcbZQ46hSSPn5xYZg7tX491dszoImmL8VypGZFNpWg+W0Yi4jzlNLVZkz4dqYUn
 ocbEk23C5d+Tqmx1OIWmXSG6I7WLrKpi8NjUJgggeRHYMkDErwi4KruhLQwg6m0J40SsmvVSpJE
 jwRds14Uo2p/o6gavIrCXjOz+YippNCO6uxcXbenV5ldwQyEBFfnWM4QIYxXUKvgaF5g==
X-Received: by 2002:a05:6300:508:20b0:3a0:c2b4:d976 with SMTP id
 adf61e73a8af0-3af8327f7c1mr1135527637.44.1778644764161; 
 Tue, 12 May 2026 20:59:24 -0700 (PDT)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com.
 [74.125.82.172]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c826768a27fsm13547041a12.12.2026.05.12.20.59.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 20:59:23 -0700 (PDT)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so15148497eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:59:23 -0700 (PDT)
X-Received: by 2002:a05:7301:292e:b0:2da:44ac:6d0d with SMTP id
 5a478bee46e88-30118da9d18mr1109445eec.20.1778644762883; Tue, 12 May 2026
 20:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260424102800.24022-1-frank.chang@sifive.com>
 <20260424102800.24022-4-frank.chang@sifive.com>
 <058f177b-b8ab-4fb1-9998-ba21b559a30e@linaro.org>
In-Reply-To: <058f177b-b8ab-4fb1-9998-ba21b559a30e@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Wed, 13 May 2026 11:59:11 +0800
X-Gmail-Original-Message-ID: <CANzO1D2xex3ifDnt9jAQ4fhbaacXkVquw9uNPpdbk2wzb6EBQg@mail.gmail.com>
X-Gm-Features: AVHnY4L1I73FCV6qJH4ktKjAtkpt4sBqjGctEHHNVQkxqGW4zw-RaBKqa4cLh18
Message-ID: <CANzO1D2xex3ifDnt9jAQ4fhbaacXkVquw9uNPpdbk2wzb6EBQg@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/riscv: Support raising misaligned exceptions
 for vector loads/stores
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000045fa980651ab01eb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000045fa980651ab01eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Henderson <richard.henderson@linaro.org> =E6=96=BC 2026=E5=B9=B44=
=E6=9C=8824=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:21=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On 4/24/26 20:27, frank.chang@sifive.com wrote:
> > +static MemOpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)
> > +{
> > +    int mmu_idx =3D riscv_env_mmu_index(env, false);
> > +    MemOp memop;
> > +
> > +    switch (size) {
> > +    case 1:
> > +        memop =3D MO_UB;
> > +        break;
> > +    case 2:
> > +        memop =3D MO_LEUW;
> > +        break;
> > +    case 4:
> > +        memop =3D MO_LEUL;
> > +        break;
> > +    case 8:
> > +        memop =3D MO_LEUQ;
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
>    memop =3D size_memop(size) | mo_endian_env(env);
>
>
> r~

Thanks Richard,

I've updated the patchset and sent out the v2 patchset:
https://lore.kernel.org/qemu-devel/20260513035310.3764218-4-frank.chang@sif=
ive.com/T/#u

Regards,
Frank Chang
>

--00000000000045fa980651ab01eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Richard Henderson &lt;<a href=3D"mailto:richard.henderson@=
linaro.org">richard.henderson@linaro.org</a>&gt; =E6=96=BC 2026=E5=B9=B44=
=E6=9C=8824=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:21=E5=AF=AB=E9=
=81=93=EF=BC=9A<br>&gt;<br>&gt; On 4/24/26 20:27, <a href=3D"mailto:frank.c=
hang@sifive.com">frank.chang@sifive.com</a> wrote:<br>&gt; &gt; +static Mem=
OpIdx vext_make_memop_idx(CPURISCVState *env, size_t size)<br>&gt; &gt; +{<=
br>&gt; &gt; + =C2=A0 =C2=A0int mmu_idx =3D riscv_env_mmu_index(env, false)=
;<br>&gt; &gt; + =C2=A0 =C2=A0MemOp memop;<br>&gt; &gt; +<br>&gt; &gt; + =
=C2=A0 =C2=A0switch (size) {<br>&gt; &gt; + =C2=A0 =C2=A0case 1:<br>&gt; &g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0memop =3D MO_UB;<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;<br>&gt; &gt; + =C2=A0 =C2=A0case 2:<br>&gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0memop =3D MO_LEUW;<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>&gt; &gt; + =C2=A0 =C2=A0case 4:<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0memop =3D MO_LEUL;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>&gt; &gt; + =C2=A0 =C2=A0case 8:<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0memop =3D MO_LEUQ;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>&gt; &gt; + =C2=A0 =C2=A0default:<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&=
gt; =C2=A0 =C2=A0memop =3D size_memop(size) | mo_endian_env(env);<br>&gt;<b=
r>&gt;<br>&gt; r~<br><br>Thanks Richard,<br><br>I&#39;ve updated the patchs=
et and sent out the v2 patchset:<br><a href=3D"https://lore.kernel.org/qemu=
-devel/20260513035310.3764218-4-frank.chang@sifive.com/T/#u">https://lore.k=
ernel.org/qemu-devel/20260513035310.3764218-4-frank.chang@sifive.com/T/#u</=
a><br><br>Regards,<br>Frank Chang<br>&gt;</div>

--00000000000045fa980651ab01eb--

