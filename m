Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CB2CD13DA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 04:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK7Wh-0003WY-BV; Tue, 05 May 2026 00:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wK7Wg-0003WN-4O
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:36:54 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wK7We-000618-Kj
 for qemu-devel@nongnu.org; Tue, 05 May 2026 00:36:53 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bc188a20e0aso234255466b.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 21:36:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777955811; cv=none;
 d=google.com; s=arc-20240605;
 b=N6sYkP12BXCK+MMjG3ECPMetTpOfSSIqQ2Y59eIIDL6BMxHw/uZt9Yh7Nxxx6UBw9z
 Hr70UyynRSRBhFnyXXBKQHspmCh7EWlOXuVdZk1qyCGpwapqfiN1RdSdD66Qe4891VvQ
 q1KR1fPn8GapHp36yiUzP3hHhdqGIX4ZZk01HPCvtUzw8wYHKK/HNx4QwfKmCn4QZ/iJ
 rJIrvCWyOfUL6gVp58SIV2So5i8TklLXAMi9aXHyFHOaBzbIp0VgjWMB7v/4ZzUmy7z6
 iWV6VotX1Ty8oRYKFH4ae6HCyZytpVDiWGTWEqXQK5k6fadUETxFsSkl7bAIuM04bnCG
 cYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uFMkq5KYL58vqRLqJZ1hMoKshY9uDeFXAjaudLKhDDM=;
 fh=9NbCJihG3Dv07VmfxXJkP0s1riJScAQAhnQeLs9zKNA=;
 b=lRNTqGouI3dhenEusJzKWlY9pI7+XeYI697U69bftxnTXvO9SXEOS6tiZs8F/3cw0G
 ZDqKUcbYQGTYYLdxlE5IqZyfotc9gc2yaebe9YXiwXVZ7rHJ0lpD6jCBakXjoWbjIe/w
 XCTkdwVM4If6VxglUYXSIMQ0wNMFFy6/1C2Rg07nyz9boAGyH7LcpRNBwdk0ipDCirQV
 TJw01mdk5hBPFoeR2e75FMAZVXQoaQd6RLx4Tnj/1pXgc/P8ly6eCmQkoAQxnw+XGHqT
 7bwLO+x8Bk6J34X4jfZCDplkEY7VJtvAB7Dlc2VmmpGMX2bBUBVfKL98ml2OxDuMwvt2
 SEBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777955811; x=1778560611; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFMkq5KYL58vqRLqJZ1hMoKshY9uDeFXAjaudLKhDDM=;
 b=HwAd1VA0dXeDw7SDowCz2HXMreP23fRzChkGeJrUJDN3xTkSH8+1/2NnHf8KguaNSy
 Cvwu9cfCY1EwWP2s3UbhwiYRxtqKnKQ+ZdN6R1LJf9/R2dow8zBFQ8lfkXgIeFrt1WRn
 6Gr325h2nGrNQuFHioSqApzykQsNx1I4WhErDEbgQuNo1sM9TF14P8HHfDrY0jztj+vq
 9VI/ra6RTt4fM8W/VdXxNlvG9DBztu1zfJn+LRW2gKqE5B0c2iLYu/p2hdtBFC8yNQx0
 nS8UajVC5FD2OJ2mJtcUTIJxQzH3rst75seh4nrLo6fWcUOMKPa1yxjnI4+C6ooBnqxF
 xjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777955811; x=1778560611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uFMkq5KYL58vqRLqJZ1hMoKshY9uDeFXAjaudLKhDDM=;
 b=luWOK6KTfiUW/KVOtkYVshO8ex4ccB5QGfNgKxbaAuhGoVxQH/VQY4yJ5y4nMNy37E
 Miy6n92YwrcR2d3ugb/BzSBpcCpPyXbLpDLORIQv5bVHlRhGK85hmUJyc+87EqwYxAaw
 VA7cZfKSP28Wj4Aa5TlADLa8GvHMd+7SY3u+HDkzK+bBz429bFsC+aUgUW2CwoT+ynQl
 mWZ6u3zTGsnnMnaMjxiiYrRJNpVDBuKGlsD8s7zUfS9+GWyBCNTYod0TS6TsHcVcrREp
 92gJA4cJ4l9JlKROAJPlSXIoUuxX9vAXBcMC4oykpQptUQqfGEtM0COI/s7czKagsdtn
 3EKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yTgf8a1+coAoARxdPnV+gpmy9YUY5XR8m5OXrdxT6ucc51YX4FGnrFMN2N8PP9MKQIh3dX487jjVT@nongnu.org
X-Gm-Message-State: AOJu0YxQ04ENVRX+L1JjOXwHCCEzegngs8nffF9KsEknr+stP4bmcume
 jF6DKiymcBpVsY48fAqRZJMbEPce+D5R4SZuzDnG1+FSnmw472nY0tQ/w0ETtN4zRPlDE1WD8eA
 YD7ixtnlgnrbZSTJ7Y8go9TEJ5HEVVqs=
X-Gm-Gg: AeBDiet97NE4rtBlWT3LJkR0uVyc5dRS8m1zTHkVeqaectBOp3M21cNmshiK4696CbF
 laLT0Ombj+x3TE8C9P0UizvuM4ML/CTuGMsjGkpIfGNi7ufgslOVpWDerdveS+xikl7KA8xAsze
 ZHerg6ETXq9TX/KQI46G76IdWuI6wOdKK04GZgq5dyMtH3efEwoILI5n87DpeBt8o7DzxoFQQh5
 SqSw7enHkMoWVqyuW+qBFXKAkEcIyx9HV+Y3B2StYLaz/Eyb8xm/2xZB5zT6Ev0+g1mHz7SWU2+
 GfNDCbzsyMEga8xVy8dUykf8Rx1ABeYehL0USOo+Xnpv5D1R
X-Received: by 2002:a17:907:3f20:b0:bc3:d9a7:37e3 with SMTP id
 a640c23a62f3a-bc3d9a738c5mr110965066b.36.1777955810838; Mon, 04 May 2026
 21:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <aflOIW3v5FQMwfGA@lima-default>
In-Reply-To: <aflOIW3v5FQMwfGA@lima-default>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2026 14:36:23 +1000
X-Gm-Features: AVHnY4Jupc91DFNMuyDJ_04nAu1QoH46QG_EpKiQETOV0fQ_XwD8TRgcjGEFcKA
Message-ID: <CAKmqyKNUJMOuq5jujJQrSvnrvCYfxuB_jUrxFcFAQie6PosgAg@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Tue, May 5, 2026 at 12:00=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> > On Sat, Apr 25, 2026 at 11:20=E2=80=AFPM Joel Stanley <joel@jms.id.au> =
wrote:
>
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e1942a86eba5..635a380945fd 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1760,6 +1760,17 @@ F: hw/*/*sifive*.c
> > >  F: include/hw/*/*sifive*.h
> > >  F: tests/functional/test_riscv64_sifive_u.py
> > >
> > > +Tenstorrent Machines
> > > +M: Joel Stanley <joel@jms.id.au>
> > > +R: Nicholas Piggin <npiggin@gmail.com>
> > > +R: Michael Ellerman <mpe@kernel.org>
> > > +L: qemu-riscv@nongnu.org
> > > +S: Supported
> > > +F: docs/system/riscv/tt_*.rst
> > > +F: hw/riscv/tt_*.c
> > > +F: hw/riscv/aia.[ch]
> >
> > AIA?
>
> Oh it must be because checkpatch complained about patch 5.
>
> It is covered by RISC-V TCG CPUs though, so no change needed to
> MAINTAINERS for AIA AFAIKS?

If it's already covered then that should be fine. Also, if you are
covering it, MAINTAINERS should be updated with patch 5 and not here

Alistair

>
> Thanks,
> Nick

