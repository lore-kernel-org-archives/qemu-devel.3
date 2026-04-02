Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73523111224A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 01:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w86k9-0003k8-BY; Wed, 01 Apr 2026 21:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86k4-0003hp-CQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 21:21:04 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86k2-0000sL-JT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 21:21:04 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso42621166b.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 18:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775092861; cv=none;
 d=google.com; s=arc-20240605;
 b=MLJw9og7XhmVWwtT+mEb4H7leSwl4Fpn3LZwPgw9lYz5ayQkGVijzN3FUOtFH2Nnzn
 GQbZC1DtgX/26q8Wr9uw1OY778GG2QGsdSoXTvRJTPT/bmNtXOq0ILRunwHzRrnsTeTa
 2Dv0OYm6CMe9DVKJjK1DVOjvI0PopViWYtpWgvENzKl+kmk2qi7uc+QDTqkBsrM9zuPH
 +b0zDBudYnlMTD+3muBw4ToJFWREx6/NdJ0EPakLwAO1DJ9EHcQ+YM12WkiT8NXUZTRc
 lGOHFeD9GBArVvrzQdAH5T1OuYUtG9cfOUKZqIO1MQ06dj0lJZhikCQNUe9VNlvnp2lZ
 ERKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vvZzySnXMQuEekVUrXwBjYEbehrYBwKgFI6x7ta6reE=;
 fh=pib4z2lKR1zIJgPNvRHjuZ7qVpt3JkKqZS5pIzvygy8=;
 b=Rwq6A29xZrHTGJOWaPeB0G64LxAU+31db+i5xP6h72VOpbJESQ1CEoKm+BNh8ayqd9
 5uMERnv4i1vX0MOPUNX1vd+lBKPII2dinZlQmYdO336Si8PyrRyBERBZHdVfK2LZTul4
 xzEHPdbg+f2t4iH2iifSny/kfqYJvAj0CwqcwpgNdnz2rA2qDJk2Ca4l3A7dZOiwkKUK
 c4l0Nv6zS3IxIjqD0IRNYUSYc2KtZtMg++AgQu+cMXGJ5YYX6fi/8lyGqjjuXoTSJnya
 ak6K8pZVHVPhOEcGg8HytMu2Vw5RSEkLsp8taYAhkJDJxLl7QFS3llZYShKDDq30ZyEq
 AH1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775092861; x=1775697661; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvZzySnXMQuEekVUrXwBjYEbehrYBwKgFI6x7ta6reE=;
 b=Vs18xzGkqCr9LI5qPh8DWHd2COumKSYpy3qXhp8ha4fVdBQN7/ML58K9SFm8S4+zu3
 +zk0nPMoebVtfxmXfEdq1QMvGPQO5XTbxpR4vf8DuLR4xtcQX8ynmYphP7z0fg7VelDe
 Fo72qHrGGmM/fwxtxIp63Tn5+tKgQwmnNwvzMfmeFu0V6YZrOtU+QtI/Bd9dvMDWeuXp
 SlS56/zIC4Ec7c+dT6pda1zfwFoJO9WDXaUw+EkPjY9cVg9bBsB53BkgPWxeK9RafHgf
 0e2i2Xqf5WZ9B/adjcjPo+FGUQoYaQKLl132aMevjXKY8o1ffHIAk55ccJuTVRdQegLu
 Td0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775092861; x=1775697661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vvZzySnXMQuEekVUrXwBjYEbehrYBwKgFI6x7ta6reE=;
 b=WMWwVHFpZMtes5wNWYnEFol7M2ufJr9dxdz7cLGBZLH+iX9cF9W+WF/dD/4BE+iQp6
 srdi0GoIIid9NwOb1OmAbXDakANbEkai/my5J3cCz7DQbqYE0Yl12NvYBpVLxa5Nv4F9
 ovfxK4oM40gaEwGjz32hHwm1eVDtQ7NzDniNkRENRW3WpcQ1pxylPBQ6tP7WZfGh+BI1
 7xAzKuUSnOaIwvOl7j0mzTSu9FRrQH0T7siiDUeBiCvpm+rsCyi9UbZrwCJXPxErTiug
 UzAjqR8Na2zgWN/HkSsvhOoMsjpGAXJzS9fbDWkMRclVDinS0GXE+884fbiDQfLadvAv
 6MvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt6GpxtkgadPMieG4nNmbsFhnXlPEX5VzgGI7rLbKGIfJ2Diq873iZmHnO42iTH1Czdm7WGLTQGbbE@nongnu.org
X-Gm-Message-State: AOJu0YwJz2azB514SIac9OK736M6UmH7UBiKLRfLTSshMezV4zRzkpsX
 C00sTOaaCUyakFmTTEuSfT8wa8qDqd/Bo3+9zQeKF4qP+fpz1aJ5EAMMQnE52TXjgvAuXd3fjBa
 KlFK7D4yf8/swzPnfUXKFNWsCN88lBA4=
X-Gm-Gg: ATEYQzx7UoqjXZ1ct+8wLc0n7PwDFrcknnKkUG5fdnuyN9PYbAPNTqNIVJSyYV0k8oU
 +AbcqTrm5bAIZ/BmU1WqZUw5/mak2fNAQr3bQw0UWg2qo7NgN3egZYg2bvcAhdM94QJ4n2K5KZX
 3zJ+NTWgCLP6z5C25/703Q6FU+xyONDEFYn9zy6K4QS87ZGVW93g+Adk3a2ZPsjbLD1C5TQ+6pL
 hg0G3uL9/MuGQ9Tz/6g9G7veuR99+k+HjNDk4+TPNLL/V25T6+8Rv451Nha+qUQ0eEe54tCGh/0
 wquWawJ8BrciahrNT4Y4wyGFHDXM4tFpm/K/Mg==
X-Received: by 2002:a17:906:ba84:b0:b97:b720:41a1 with SMTP id
 a640c23a62f3a-b9c13b7bfa7mr387955766b.38.1775092860868; Wed, 01 Apr 2026
 18:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
 <abKfuTO7zg5d67E8@sifive.com>
 <CAKmqyKOcCKAb2w2t2qYgOevswst75FjzKfihrYP9+odRAsCQmw@mail.gmail.com>
 <abe80eiIC4gXUHxk@sifive.com>
 <CAKmqyKP-42diNbiAwr_qykVTAYgR=Ok2S4dgLwPN5oGuLTQGRg@mail.gmail.com>
 <acSqxQQxnO0HdB8M@sifive.com> <acTIq7M94646OAA_@ZEVORN-PC.localdomain>
In-Reply-To: <acTIq7M94646OAA_@ZEVORN-PC.localdomain>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 11:20:34 +1000
X-Gm-Features: AQROBzA61o6j9SLXWSOyHvjfl1cSuRG_P_4wxmbjn0zleEDZ1MOrsTBae4waPJc
Message-ID: <CAKmqyKNPUM8GGsRTTCN8mb-b7BBhn211naFw2kpym=5-OuP4uQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
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

On Thu, Mar 26, 2026 at 4:07=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> On Thu, Mar 26, 2026 at 11:42:58AM +0800, Max Chou wrote:
> > On 2026-03-19 13:45, Alistair Francis wrote:
> > > Yes, that's how things previously worked. Basically I think we just
> > > need a tag (that won't be changed) in an official RISC-V repo that we
> > > can point to. That way it's easy to say "this is the exact version we
> > > used to write the QEMU implementation". Then if there is a version 0.=
2
> > > we can easily see what has changed and update to match.
> > >
> >
> > Hi Alistair,
> >
> > The official riscv-isa-manual repository has added a new tag for the
> > frozen Zvfbfa v0.9, as shown below:
> >
> > https://github.com/riscv/riscv-isa-manual/releases/tag/zvfbfa-0.9
> >
> > The current v5 implementation fully complies with this frozen
> > specification.
> >
> > Since the Zvfbfa is frozen, should I prepare a v6 that removes the =E2=
=80=9Cx-=E2=80=9C
> > prefix from the zvfbfa property and updates the specification reference
> > ?

Yes please!

Alistair

> I think we need a v6 series, usually it's fine to implementation
> after spec tag is release.
>
> That said, we should defer to Alistair's thoughts on this.
>
> Additionally, my new debug spec series can be sent upstream later
> (base on the zvfbfa tb ext_flag patch), once zvfbfa ia all ready
> and pulled.
>
> Thanks,
> Chao
> >
> > Thanks,
> > rnax
> >
> > > With the seemingly infinite number of draft extensions we need
> > > something to manage the version and compatibility, and that seems lik=
e
> > > the best bet.
> > >
> > > Posting the draft PDF spec somewhere immutable would also work. We
> > > just need to be able to point to something that won't change and
> > > represents some sort of "release". So a git commit doesn't seem like
> > > enough, we need a "release" that everyone can converge on.
> > >
> > > Alistair

