Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B37CEACF3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 17:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw36K-0002YQ-Cg; Wed, 02 Oct 2024 13:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sw36J-0002Xy-0d
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 13:25:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sw36H-0006xW-6P
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 13:25:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso7121065e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727889919; x=1728494719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sD44ncMEuMvqAzpxO9P/T/TLuuECMjOtP4kjBWrocoM=;
 b=vnqL9EpsA7QKcfsSpbbad4KQfqY2oyKc+bKSsN2OVGuDyERigw+nslDiMBA9KFaszO
 MbSMk9NfJPHwyZOQ8QZgGkiDyUZ4jG+63p7p1xRDDjki724Rvg/h5g1ltHmITxfcD+FO
 nhqJfENc8IZKSoMps7jKL6961Krv6QrUKjVgysz2mcegQRfU9GQXUGxEGvTIosg35I1O
 o9Z1gHjJHRO2YXPLJu1zVIdgg7K5oVuGAKR3C1Vx+/dsN+sMIgp6pYBVBl4f8Ixjg2WT
 EuwRFFoRnzdwwXWOORIMsXoyoMT0QsrxdrHQwhzQI45o2zjCz4nBFMOssJP7m1oGoX+0
 4Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727889919; x=1728494719;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sD44ncMEuMvqAzpxO9P/T/TLuuECMjOtP4kjBWrocoM=;
 b=FfbHR49FwdXa7drfjj8Ofju85IuQsABqOzHUTnFv+448SpgsoPJqU1ad71EMZ6mqP6
 cuHF3AECt73fisWxG9BkPQ2us4TsqfS/Le0YDXfL1vt1VXLSobDPSvitMfqnRiT7qn0M
 u3BD3El7cSLJaJUUwD7STGEcK1ujyFgWAtIwl6l+TioJVtqwEHLFLcAExLEld9yr+/rU
 vUQwC23jIwKG2MT0iZ0Pv5gwD4805ql7naKrX7XuIjupNHdCtQ9DxiEh40a3imnHdmMF
 vbStC04AcHPVgDLD830AxIMbydOhmOAoK4KiKiPTOKkayF0BvqM81xctQfBZJzDe2CoC
 js0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVPOUZb1YQbsoHvANRuv8HfllLdQLJCLQtOrmZfpLSqqSDTgCi2SGNV+N7V7vICKnIOBIe5gav8ejl@nongnu.org
X-Gm-Message-State: AOJu0YxTIoE8ZRdBs7rRD+qNeB5k/ISzScZsIUUYHmHJzTKu2A/M0Ws+
 io6B8RTwAnhw+6pyCDgg+B59Ao/bomSb42cvTo0xdcaCtKZsdzsNMP1kjKhxzKo=
X-Google-Smtp-Source: AGHT+IGW9+UNdJoSoMQWQLLa+nKhbXkPBRIXb/hDHxwYLWkd9V/9I/tnlcBc7b+3OJdi0V+PDC3PLA==
X-Received: by 2002:adf:f3cb:0:b0:374:c2bb:8387 with SMTP id
 ffacd0b85a97d-37d04a57f53mr225935f8f.30.1727889919147; 
 Wed, 02 Oct 2024 10:25:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5730e9dsm14363501f8f.71.2024.10.02.10.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 10:25:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71A295F780;
 Wed,  2 Oct 2024 18:25:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@kernel.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel@nongnu.org,
 linux-parisc@vger.kernel.org
Subject: Re: {PATCH] accel/tcg: Fix CPU specific unaligned behaviour
In-Reply-To: <CAFEAcA81YtAGO0iFZRWXGjJb91DhWEDTGr+cjWbNWEW4yJDksQ@mail.gmail.com>
 (Peter Maydell's message of "Wed, 2 Oct 2024 16:47:14 +0100")
References: <Zvyx1kM4JljbzxQW@p100> <87cykimsb9.fsf@draig.linaro.org>
 <CAFEAcA81YtAGO0iFZRWXGjJb91DhWEDTGr+cjWbNWEW4yJDksQ@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 02 Oct 2024 18:25:17 +0100
Message-ID: <877caqmn7m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 2 Oct 2024 at 16:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Helge Deller <deller@kernel.org> writes:
>>
>> > When the emulated CPU reads or writes to a memory location
>> > a) for which no read/write permissions exists, *and*
>> > b) the access happens unaligned (non-natural alignment),
>> > then the CPU should either
>> > - trigger a permission fault, or
>> > - trigger an unalign access fault.
>> >
>> > In the current code the alignment check happens before the memory
>> > permission checks, so only unalignment faults will be triggered.
>> >
>> > This behaviour breaks the emulation of the PARISC architecture, where =
the CPU
>> > does a memory verification first. The behaviour can be tested with the=
 testcase
>> > from the bugzilla report.
>> >
>> > Add the necessary code to allow PARISC and possibly other architecture=
s to
>> > trigger a memory fault instead.
>> >
>> > Signed-off-by: Helge Deller <deller@gmx.de>
>> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219339
>> >
>> >
>> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> > index 117b516739..dd1da358fb 100644
>> > --- a/accel/tcg/cputlb.c
>> > +++ b/accel/tcg/cputlb.c
>> > @@ -1684,6 +1684,26 @@ static void mmu_watch_or_dirty(CPUState *cpu, M=
MULookupPageData *data,
>> >      data->flags =3D flags;
>> >  }
>> >
>> > +/* when accessing unreadable memory unaligned, will the CPU issue
>> > + * a alignment trap or a memory access trap ? */
>> > +#ifdef TARGET_HPPA
>> > +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  1
>> > +#else
>> > +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  0
>> > +#endif
>>
>> I'm pretty certain we don't want to be introducing per-guest hacks into
>> the core cputlb.c code when we are aiming to make it a compile once
>> object.
>
> There's also something curious going on here -- this patch
> says "we check alignment before permissions, and that's wrong
> on PARISC". But there's a comment in target/arm/ptw.c that
> says "we check permissions before alignment, and that's
> wrong on Arm":
>
>      * Enable alignment checks on Device memory.
>      *
>      * Per R_XCHFJ, this check is mis-ordered. The correct ordering
>      * for alignment, permission, and stage 2 faults should be:
>      *    - Alignment fault caused by the memory type
>      *    - Permission fault
>      *    - A stage 2 fault on the memory access
>      * but due to the way the TCG softmmu TLB operates, we will have
>      * implicitly done the permission check and the stage2 lookup in
>      * finding the TLB entry, so the alignment check cannot be done soone=
r.
>
> So do we check alignment first, or permissions first, or does
> the order vary depending on what we're doing?

If it varies by architecture and operation that is even more reason to
encode the wanted behaviour in the MemOp.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

