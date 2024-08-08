Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2E5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 00:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbr0F-0006YL-V8; Wed, 07 Aug 2024 20:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbr0D-0006UZ-3D; Wed, 07 Aug 2024 20:27:37 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbr0A-0006RD-AD; Wed, 07 Aug 2024 20:27:35 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f52cc4d3beso152185e0c.3; 
 Wed, 07 Aug 2024 17:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723076852; x=1723681652; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFn6ZBvk+7iPhdLc5yE6mp5/vDSL/nn4LQe763p1BN4=;
 b=MVlKK6EbBoboiwjxT6thZFjUUDGKo/E1hIgUo1yaaq+9Doam3tIjhyhRQsBWO20iyt
 cXq9LO60Iq8hFHW2px4NX8W7TdMA2FMGsWCHuSsqtTEVNEJcoU6QHl3qjuTsRsWgD9lj
 N525SOp0jv1X8ZL8/uEkKMhjCHENtXr9ZmtZYMs1lRXuXLQyFI+JWI0qOjOwr3dTNMeK
 LTdsjzjkxcl8unmzOeIgwV83W/YjoKn1fac/KujfQYy+8xIXkQ2wq9RVLf3DNPJKmVej
 DA5a8vbndXRPJ0EOaLGU5fo+qf9Q3YchsIVf3BklnNDenDFuLYKFnS+ColtdVOFYh6Fl
 spcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723076852; x=1723681652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFn6ZBvk+7iPhdLc5yE6mp5/vDSL/nn4LQe763p1BN4=;
 b=fNgxeigxJaNWOI1Piw0scWhACKNAoPCZluBxZWo259WrFS9qKd0090P9ev+BtzKAJB
 vMQtkTn1UwOSUZPF2zU6SluleMC10ZiH5OGta5vrh31vgNSa+m0RmEjrG6lXm7R4kjvw
 t/0bba6v/5e2xWbnrjHK3DPKW/YdYueSGw6UQ8YN+x9m6dRtWz9W645fVMhdlr0AYj6v
 /J29x/zmPV9w6l/Zqhn9bgw4Gzuoh2ZS56Y2LJvldaBP7AA0mi7pZQrANe38YysQs4/M
 3Q6aIvOk7PA2YNJ7kGaay6x8cpVdghzZR99xk7/JR7rbjVfAKztOGnDx9u1I9VGBjenm
 O9ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCURMHCBe9STM93Q0x8HdTRirFb1Yk8GVT7cHCxz5PIvX41Xg/SGwHANnlJ0YBmWfZIdsXYl8pp9CrGZC1Lt/87atKZueps1tlTb86fK7ZTytvqW7g0s4Sel2NWp4g==
X-Gm-Message-State: AOJu0YxsEE1PL7YNAEnSpOL+xt6lFd/+mZbJr24nYriT8ikTyDtiUEEe
 7xFT49e3pQSQuqhy+VF/SmOL7eZcjBhaky5DjaAXB6uCsNEsQvsramSSeDru+/Tj6QUTiMuMpBR
 i1vGYHemnw3Y/yr33U7mAPh9vqbM=
X-Google-Smtp-Source: AGHT+IHOEcuFgc/LlvqAFTY5LKTuRg1U4xmhyiBi2SjkuRH3PYrQC768O7KJgFZ5Dru8jX++Fr6iWIz2KWrfDKwpEKA=
X-Received: by 2002:a05:6102:3584:b0:494:829:835b with SMTP id
 ada2fe7eead31-495c5b57439mr558935137.9.1723076852148; Wed, 07 Aug 2024
 17:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
 <20240806-9fdad33468ec103d83a85e77@orel>
 <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
 <CAKmqyKNgJKBFw7OnwbgbqxA65PR4GSjdUEKdKVw-nYv+e0P58w@mail.gmail.com>
 <CAHBxVyFFa7mQaS4jPkT=aK4gTF3AshpQZNeRhBiZOHX7bhQQsg@mail.gmail.com>
In-Reply-To: <CAHBxVyFFa7mQaS4jPkT=aK4gTF3AshpQZNeRhBiZOHX7bhQQsg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 10:27:05 +1000
Message-ID: <CAKmqyKOX883p+sgFs6s649pkH0BA9aKcrTr7=XOT=Xy8mNLzng@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] target/riscv: Enable PMU related extensions to
 preferred rule
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, Aug 7, 2024 at 5:44=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc.c=
om> wrote:
>
> On Tue, Aug 6, 2024 at 7:01=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 2:06=E2=80=AFAM Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> > >
> > >
> > >
> > > On 8/6/24 5:46 AM, Andrew Jones wrote:
> > > > On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
> > > >> Counter delegation/configuration extension requires the following
> > > >> extensions to be enabled.
> > > >>
> > > >> 1. Smcdeleg - To enable counter delegation from M to S
> > > >> 2. S[m|s]csrind - To enable indirect access CSRs
> > > >> 3. Smstateen - Indirect CSR extensions depend on it.
> > > >> 4. Sscofpmf - To enable counter overflow feature
> > > >> 5. S[m|s]aia - To enable counter overflow feature in virtualizatio=
n
> > > >> 6. Smcntrpmf - To enable privilege mode filtering for cycle/instre=
t
> > > >>
> > > >> While first 3 are mandatory to enable the counter delegation,
> > > >> next 3 set of extension are preferred to enable all the PMU relate=
d
> > > >> features.
> > > >
> > > > Just my 2 cents, but I think for the first three we can apply the c=
oncept
> > > > of extension bundles, which we need for other extensions as well. I=
n those
> > > > cases we just auto enable all the dependencies. For the three prefe=
rred
> > > > extensions I think we can just leave them off for 'base', but we sh=
ould
> > > > enable them by default for 'max' along with Ssccfg.
> >
>
> Max cpu will have everything enabled by default. The problem with max
> cpu is that you
> may not want to run all the available ISA extensions while testing perf.
>
> > Agreed
> >
> > >
> > > I like this idea. I would throw in all these 6 extensions in a 'pmu_a=
dvanced_ops'
> > > (or any other better fitting name for the bundle) flag and then 'pmu_=
advanced_ops=3Dtrue'
> > > would enable all of those. 'pmu_advanced_ops=3Dtrue,smcntrpmf=3Dfalse=
' enables all but
> > > 'smcntrpmf' and so on.
> > >
>
> I thought distinguishing preferred vs implied would be useful because
> it would allow the user
> to clearly understand which is mandated by ISA vs which would be good to =
have.

It's not really clear though what extensions are good to have. Other
people might think differently about the extensions. It also then
means we end up with complex combinations of extensions to manage.

>
> The good to have extensions can be disabled similar to above but not
> the mandatory ones.
>
> > > As long as we document what the flag is enabling I don't see any prob=
lems with it.
> > > This is how profiles are implemented after all.
> >
> > I only worry that we end up with a huge collection of flags that users
> > need to decipher.
> >
>
> My initial idea was a separate flag as well. But I was not sure if
> that was good for the
> above reason. This additional custom pmu related option would be lost
> in that huge collection.

I do feel a separate flag is better than trying to guess what extra
extensions the user wants enabled.

I don't love either though, isn't this what profiles is supposed to fix!

>
> > I guess with some good documentation this wouldn't be too confusing tho=
ugh.
> >
>
> Sure. It won't be confusing but most users may not even know about it
> without digging.

At that point they can use the max CPU or just manually enable the
extensions though.

Alistair

> That's why I chose to use a standard extension which covers the basic
> PMU access directly in S-mode.
>
> The future extensions such as CTR or Sampling events would also
> benefit by just adding the Ssccfg in the preferred rule
> which in turn will enable other preferred/mandatory extensions.
>
> > Alistair
> >
> > >
> > > With this bundle we can also use implied rule only if an extension re=
ally needs
> > > (i.e. it breaks without) a dependency being enabled, instead of overl=
oading it
> > > with extensions that 'would be nice to have together' like it seems t=
o be the
> > > case for the last 3 extensions in that list.
> > >
> > > I believe users would benefit more from a single flag to enable every=
thing and
> > > be done with it.
> > >
> > >
> > > Thanks,
> > >
> > > Daniel

