Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIT6-0005xF-1Y; Fri, 10 Jan 2025 12:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWISq-0005v2-2V
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:06:29 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWISo-0004t7-8J
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:06:27 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so3237118276.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 09:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736528785; x=1737133585; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBcBGCnCXUPu6lYWQNb1vrMXeob1mbg0t9BDxdJyk5U=;
 b=crsVumOqcflUkbuz22J+CCkJuBFnnN2cdqOV6LqCO3tZDwNGqmSPLne81ebSCbCH76
 TVRw4CRe1bEHsKZgSb6uucbPjreomAr1KdXhWjxpWr7oDja+NnLyniODByhUkTLbm+Mj
 x01GIqKdhkIVla8br0rueMVGDN9/Am6kuEh0wr3lJuf6+DGBhTxqHUH2X32uF1rDGezc
 R1O7h/+fzzbpox5FHac8EMEpmnb4/J1eLHgpfQAIoVC83Gh+aZwFSvdOlYD3il4zQpuC
 nC71neNncq001N84jDJtrX1SE2J/4f/gJ1U0O64dJKOo3p54deAyoJFE/vxghxXwrgn9
 mRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736528785; x=1737133585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBcBGCnCXUPu6lYWQNb1vrMXeob1mbg0t9BDxdJyk5U=;
 b=lSSzsZqg2xxHZIbJbGhNWWuNorXETVrK4slJbZmUwEXo/M5tfZuUhU/ajy+xfuEyta
 n2aFMKVQ2VXUokH1rtz6mQsLrWcc+wgfJKtT0lTq+Dx/Ws+KP64ddrkkQHwtPL8xuaU6
 TiNgqf2EcQCzVDoydQ8cJYTG4ytZpq8Vdr19hy12nS2CUlNQKkgSd7h2VZI3mnPVW3BT
 VJWC2KlzHy90rMphddw7yPZUM8t2ITyZq33R+Wkjcrjoa3TRkcArjqFYwncH18ZcMY4E
 eFU47s0ketu2hwO+c1UtVTVukQ/gBxRBQ5mki4HkInr9txVjNdkok7GBWmG0giS6aaep
 CUVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6/TCUGvUEN+sD6ktbWJE+E2K0wO2/t0mABW3tT7bEasCdiw2XAh/b4POjij6qq3NEkvZ7DjL0KkwS@nongnu.org
X-Gm-Message-State: AOJu0Yz3Zl0LIi/mIfkwPwL1A7LEFnYmSTvy/j0UXF7JPmmxqdx/7mKO
 3XInJ/uDvzVrJ67GRXLgFlH3rjsC9ckTEMkj+ev8uDJ9VCjz3tTNkIA7mu7HsQklriHWqwSKG+M
 pkg/muoUJlVpdSqKnr1z9mPuUlg1aP/tmND71vA==
X-Gm-Gg: ASbGnctspfRDZUzZfT2+SH1+T8ohIrYcwkWB4EuaRkhG1Tcg8mZjg3LC6gpEVMSDALn
 5daOgBXs16rG9ATUG2PHtyHWn8X+5a7fHPXWIHA8=
X-Google-Smtp-Source: AGHT+IEJzHd20TDqkBnUMCPnzML7yzE0gQNjp33/PYKSNMtqgEUSkhtzh72aUz3G8dUeb1s6Dfxo0LhCObNXniAHANo=
X-Received: by 2002:a05:690c:d91:b0:6ef:87de:5ddf with SMTP id
 00721157ae682-6f531246a65mr95684047b3.11.1736528784943; Fri, 10 Jan 2025
 09:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
 <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
 <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
 <f1d67bea-7389-40c3-a304-6cec459a2f49@zabka.it>
 <4aa676ea-331f-4c8b-be1d-208804ede674@redhat.com>
 <CAFEAcA_2CEJKFyjvbwmpt=on=GgMVamQ5hiiVt+zUr6AY3X=Xg@mail.gmail.com>
 <871pxa4ni4.fsf@draig.linaro.org>
In-Reply-To: <871pxa4ni4.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 17:06:13 +0000
X-Gm-Features: AbW1kvboGbQ0bWQn00kLquCjznWUl-iLnkYfnqHUJIj__QMGYI6V86leBhjkug4
Message-ID: <CAFEAcA_=H7L49PKR7f_WwGhpZK3G9VwWG_fPBh+NUeeZY=tUsw@mail.gmail.com>
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, Stefan Zabka <git@zabka.it>,
 qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Fri, 10 Jan 2025 at 16:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Wed, 8 Jan 2025 at 20:10, David Hildenbrand <david@redhat.com> wrote=
:
> >>
> >> On 08.01.25 19:35, Stefan Zabka wrote:
> >> > On 21/12/2024 15:55, David Hildenbrand wrote:
> >> >   > Let's wait for opinions from others first.
> >> >
> >> > <https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-y=
our-patch-seems-to-have-been-ignored>
> >> > states that two weeks is a reasonable amount of time for follow-up.
> >> >
> >> > Should I also ping the original patch? I thought pinging the thread
> >> > would be more appropriate, as it contains relevant information.
> >> >
> >>
> >> I just pushed a compiling version of the attrs.debug approach to:
> >>
> >>         https://github.com/davidhildenbrand/qemu/tree/debug_access
> >
> > I think this approach (having a 'debug' attribute in the MemTxAttrs
> > seems reasonable. I do note that if we allow this kind of access
> > to write to MMIO devices then we are also permitting ELF (and other)
> > image loads to write to MMIO devices where currently we ignore those.
> > That means there's probably a class of guest images (of dubious
> > correctness) which will start writing junk (likely zeroes) into
> > device model registers; we previously would silently ignore any
> > such bogus ELF sections.
> >
> > Q: should we suggest behaviour for device models if they see a
> > 'debug =3D 1' transaction, e.g. "don't update your internal state
> > for a debug read if you have clear-on-read or similar kinds of
> > register fields" ?
>
> What do we do for device models that want to know which CPU things are
> coming from, as per:
>
>   https://gitlab.com/qemu-project/qemu/-/issues/124

I think that's an orthogonal issue. We already have a problem that
you can see on reads where because we don't encode the CPU ID
into the txattrs devices have to work around this by using
the current_cpu global, which isn't set for gdbstub accesses
(and so if the device doesn't have handling for 'current_cpu =3D=3D NULL'
then it might crash).

But this patch only changes the handling of writes, which puts them
in the same situation as read accesses. If the write falls over it's
probably also the case that they were already falling over on reads.

thanks
-- PMM

