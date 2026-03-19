Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551701088E70
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w34KC-0006ms-Hp; Wed, 18 Mar 2026 23:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w34KA-0006mb-Sg
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:45:30 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w34K9-0006jV-8l
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:45:30 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so72541966b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773891927; cv=none;
 d=google.com; s=arc-20240605;
 b=ES2xaYEZ4Mi0QbgAa5o/nijuy7b8BRw/Tulb+GQIZmlAwlvj8u6Qr92fQjouEufW0K
 cOJRCXiSP0BNhL3+V0cEbdU0FJTQBruG8RXY0NAWReM5sYDn9aOa04NHJWBxCbIDFiDY
 9rzd8t7gGQ0rf/hBBNu9wtMZxZ9/jNC089TggJHKl5MxsgnDwFmJ/lILzPTrMuIRjft1
 v1V0uL8yMzJstdiybWmjNx9S/u9FCcrpsXiddYvxsfjql/ypN2nbtUb6eVhZHtkLfcql
 7H5f6wibf5RiDsVL5gqb6d6OGtDFEUj5Ef0zGbdCzqeb1nopivYhl4dLQ2GVLUfR6lLh
 2qXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jfr7swISXfky0TRkGnfBtMQG5t1kGtGdr9QeHqfxjR0=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=PP+Hj2jhaCn5aawlBF6/452Mw3/6bCl7OG3ek9MK7VQcFjdHJhOYFuzf68NW6MD3dY
 hhBHcmsxcY+9BIF4oQPF5IVy6RXqrhmI4cgAD2xCO6y5cFgZRaeLNlEUgTaKXFt/THwG
 itzORiJQehge3m8P9v5zoN8sNXeREizuM8gOUDDt8aT048hMdMhNsowbdPoWjxtpdtNw
 Rvn11EFMtUHZZwluZ5VRGEEd7N+TWbMyt58rJ6w3w76/wgbvCZyzlMSew4C3U8QGq5vT
 u4iTj5SlyO5gjFxF46gwQV7/ULtrFmlf8UFs8PI3ZfMJ4S7WTdicdXems+eJsZpHq6YZ
 wBKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773891927; x=1774496727; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfr7swISXfky0TRkGnfBtMQG5t1kGtGdr9QeHqfxjR0=;
 b=fvsaZmCr0xY00lzRer/SgibwsMcO6+Hv3Sg11GEoEs72BffiHTGWOvGxiz7wLmDm9h
 TIqfGO2LULJJ4MRZzLYWd4UQrtWlunddUk6qE9fhoj0YZnfGcziAmYXmPCOgwOt5Q9Nd
 Qwij/+ELGMoRIrXtvhr1pcWRVtyduM7grpXua0HRbSIwwdEE2Jtu6C6V+MHzVkhD3bSb
 +Nb7QJhyqW82nQtWw05Y2dh9A0rFgoQyGzcRJzt8BTY+RSBgQ7kPoCO9p87XQ26Bex6/
 dpE72GBUlOGgUdgySiK4tYYOnPUEh61z8gN/5dA/54YF9DTwHZG7fFYowHPUBZN0cI7y
 SwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773891927; x=1774496727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jfr7swISXfky0TRkGnfBtMQG5t1kGtGdr9QeHqfxjR0=;
 b=Ks842u2CxCBCIEg0zH8hmbb6GmL579NkY7Qra9QoAzw8KQDunHD9cY+eWE/7KYqo07
 GFQ3ikxl28gy7p37MnkH9oUN+ysSaNLeZKM9ifZE+cj1zxRhd0xYARQsCb/9D9xPYS2J
 O6w+atO0k6jE6CDc2g93ye+W5bpresJgqU2gnkLNB9TYpojNL74PhQourGaXgwA98/ty
 ehAtIwuYDGQb3JQK4Dfm8V2wjv9HlX3aigz3eqCLLoAyYfH4Kr2vwGqawdQ6jZeYjb/H
 /zVm8WA/r4sQUKGvt1TFYmBBFU/f4zDbdZc61KBezpuGysDrfXVBAEjfKGDeRsGkkllC
 ZQHg==
X-Gm-Message-State: AOJu0Yw5yZ/dYKEZNiq0+1gojWfa9hbln4rp80aYwxpiowZf+F5GIe1B
 XpUult4jwwcYsfuBaCCmT7lslSvIQ0TEz8TaiTbIFiMRi4sUDZtTx0+jYJIuCfkc3fX/ex8rxC8
 yPpWal/4lqYXlTKfCBfBzypdifBBDRZw=
X-Gm-Gg: ATEYQzxrKhh3MUXnYkSx/Xla3m++yRtocLm7lLu7QI/5AqFmMf6Rd/3lDwKzt0WQeJh
 I9JxQUk47l+FyBNE8lJFewR30I51Jbtl6DZIEvo9lHrljHRz+VqWrFIKoAvONEQ7w/iVnmB6OqZ
 ewq0qP7J9FP8yVW5bd0fePVTtsed2w50bOc9G3W+kS+l+Ib27M2xplYIHcBD6i7dmN1bn7EOahd
 Be+42oWvH4m+RQNBHC3Q8mLnv8Pij9MiP9zEiiSuIrdS6DsVwQ2eDMOqylW/GM/XnGgsXHeDuyj
 Ho+GJEYWYK3QGj/bgUshvviuCXpvCbS5hXinqYCcGcaZEZfY
X-Received: by 2002:a17:907:78b:b0:b97:8866:77eb with SMTP id
 a640c23a62f3a-b97f486326fmr333985966b.5.1773891927075; Wed, 18 Mar 2026
 20:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
 <abKfuTO7zg5d67E8@sifive.com>
 <CAKmqyKOcCKAb2w2t2qYgOevswst75FjzKfihrYP9+odRAsCQmw@mail.gmail.com>
 <abe80eiIC4gXUHxk@sifive.com>
In-Reply-To: <abe80eiIC4gXUHxk@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 13:45:00 +1000
X-Gm-Features: AaiRm51muVGzHmq1CwfRLfHUsy3qGdmdBpsxQ7DTXnN4VrQBjjBeh9Qn4YJPa14
Message-ID: <CAKmqyKP-42diNbiAwr_qykVTAYgR=Ok2S4dgLwPN5oGuLTQGRg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
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
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Mar 16, 2026 at 6:28=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> On 2026-03-13 11:09, Alistair Francis wrote:
> > The problem here is that there is no version control. If we merge this
> > series and the PR changes then suddenly we are out of sync there is no
> > way to track which version of the draft spec we support.
> >
> > We need clear versions, like we previously have. For example version
> > 0.7 and then 0.8. Draft versions are ok, but we need a stable target
> > to develop against.
> >
> > >
> > > PR #2743 is currently open, meaning ratification is pending but not
> > > yet complete. Under the new workflow, merge into main of
> > > riscv-isa-manual is the signal that ratification is finalized. If you
> > > prefer to wait until that merge happens before applying this patchset=
,
> > > I completely understand. Alternatively, if you are comfortable
> > > accepting it as ratification-pending, I am happy to address any
> > > remaining technical comments.
> >
> > In this case we will have to wait as there is no stable version of the
> > spec to point to.
> >
> > Alistair
> >
>
> Hi Alistair,
>
> Thank you for your feedback on the version control and stability of the
> Zvfbfa specification. I understand your concern about developing against
> a moving target.
>
> To address the lack of a stable target as you mentioned, I=E2=80=99d like=
 to
> help bridge this gap. Since this patchset was prepared based on the
> Zvfbfa version v0.1 and this version has passed the ARC review, I
> propose we coordinate with the Zvfbfa isa designer to check the
> specific tag/commit ID of the Zvfbfa v0.1.


> If we could create a tag or release for v0.1 (e.g., v0.1/v0.1-draft)
> within the Zvfbfa repository that explicitly marks the current state of
> the Zvfbfa spec, would that provide the necessary versioning baseline
> for you to accept this patchset?

Yes, that's how things previously worked. Basically I think we just
need a tag (that won't be changed) in an official RISC-V repo that we
can point to. That way it's easy to say "this is the exact version we
used to write the QEMU implementation". Then if there is a version 0.2
we can easily see what has changed and update to match.

With the seemingly infinite number of draft extensions we need
something to manage the version and compatibility, and that seems like
the best bet.

Posting the draft PDF spec somewhere immutable would also work. We
just need to be able to point to something that won't change and
represents some sort of "release". So a git commit doesn't seem like
enough, we need a "release" that everyone can converge on.

Alistair

>
> My goal is to ensure QEMU supports a traceable version of the draft spec
> while respecting the current RVIA development process for this ISA
> implementation patchset and the followings in the future.
>
> rnax

