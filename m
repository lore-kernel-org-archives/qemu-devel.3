Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0492CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 23:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNJQ5-0007qO-Mr; Wed, 13 May 2026 19:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wNJQ3-0007pc-DK
 for qemu-devel@nongnu.org; Wed, 13 May 2026 19:55:15 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wNJQ1-0005nU-Ki
 for qemu-devel@nongnu.org; Wed, 13 May 2026 19:55:15 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6815add87f0so2529668a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 16:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778716511; cv=none;
 d=google.com; s=arc-20240605;
 b=lNF/oWzIAd2XZ2mB64uWwbJQNLKa66c4dzLKslR2aUhwyGZoGXET+11TVBgp0AKzuW
 sOAqr+LU+vCMd0QPNpPrV37sAfjBeG4Lxad6oBQxk3I6H7v4Vb1y85/48BRiAKtjEWh5
 d5BKcNwwwwPtct+WmM9GENupHa3g5GiyM3ZRo0XbyD8elrRhDVbxR/mNoaXdCdSn6xIC
 U1mTKsmZd92pUK7K0BihtPe5LH0wjHn9DyaM1wxKNo84kLmwv3AthwuwOdoYDsI81wTN
 1CkObpY62qO3jW3oF3AqL+Rp0w1W2lZM3zkCEYpac3jsc7/cgIsAwOqpO7/AY4DZ60QI
 xdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kP3j2OV8y/tlpNusNGHv9RfGAkyYIpr8mU/BfcQSQhw=;
 fh=vrbxt5zITAJ3Cptgih9bqtbOHZVKxLLP4eLkL4pQLg8=;
 b=i0PP6iQ/A9s/NaPSO0nWi/bouXSPZtnLI0rXxgCbD864p8iUlh2JuuOJtuXzZMxu+/
 PVsy4BEhJRakH3jC5O9PZ8FFbNRFc7WzDFp76edjUqyD2T1eLbOfSesHPG4M8oIaqiPV
 tK+ZMgwBuyaB1v8A+dm8V9Y9EecZcM3bF/b+i+qf3Myzrv3OV7gsW+EZ3t0e+FThiLjV
 PqcCTU3IxlZ2I3JMh1BcYgcFE2//v/2f3V8dHp3kkWDxPLakiXvVxXDYQzBnfVxHp7Sk
 M/1BkPWEMQWdCerGMP3r1Bw2+ZKGCIOGOUm33bYa1eGPMnuWHnL/3KIOYLfBLA2euaCt
 10CQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778716511; x=1779321311; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP3j2OV8y/tlpNusNGHv9RfGAkyYIpr8mU/BfcQSQhw=;
 b=Eg79Kz7+FkCvQZGJoprfwmL9ttZW7h/JXgxN8ScMzMq+rIXBPX81fgRHj7DlGwpxl8
 Io0P5Yp1dPVz8jiReS9al6TEBmovatP8eYhTlxLfFr/fGres5oMDSDuNsMcq7flltLHG
 CvS26iyVMqqaRW56wzJ4HzxOzAMBeZzS9+ErE3JGrRpY3wkXYONo3jPMfGSfJ7idchtv
 Dg0jV7XazJfr6q40+P0ZcNNd85xSSmPSsyIYq5dtfZJD631VSZiQT8XXRpGG+vXZaSDS
 0uXjZJytVs+P0xDUNCK2vUEBeKtjjdxMJtXGifznyMlju+N1+M2EmcW0x4oGFMXb9BFH
 4XPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778716511; x=1779321311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kP3j2OV8y/tlpNusNGHv9RfGAkyYIpr8mU/BfcQSQhw=;
 b=OmOx8GUwysdIgVkrPAVO8PyKXmaF9bHiqb8De/Gc3gm0/u9OMixIXXbds6YE2bqDXa
 4jUi3XahvrukEU/vcNDHqoeR4+jjZoxhisHZ7SAIUqgS0Zt5VFCv71pDzVk+Iu+WqoKr
 gVSjyZYJwWMBTJbQTAE+H9Zu1JL29sH4Qac7o2JQTB8Uni6vDOlV9MqlXGpdMxXR2l7D
 y+Ondaq8ssyUiGuOIoK9tmNnATLg3vLx6jxvKE0zUuF+vPS0GMsfyDqQ2M43sQJBLMWZ
 kD0mP9SRsKNaxHM5LTQHmHuTMd5t1v1mIIsyQotGHncRIhgaxTd+eiLyEklSQT3H8Uj1
 VFIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BVPHX0IFqlLgoPQgJgyYi83On5g6B8FiVmIaTfVm9XEiJkes/WUd/Qiq+7qMlLt6JQLRZcMNEopQw@nongnu.org
X-Gm-Message-State: AOJu0YxBnjxKBnbGZkTToyhvXQAkiBnynCsvXgwWKPFhO+nr/tnHNUnB
 uAxFB0FEUut8VvP+DScJo47EiBGg3QrWI6NE1t7RwelAS32OI1v8ZKRIXY+a3tSFBoVgvU5YrTE
 wAdNJoWxGNs0EveBBn7PNnb1l3vM9Bio=
X-Gm-Gg: Acq92OG7zqU14Zs47lovrbe8cwXAyf1UpWDncluVRZqibkI+TmrUMUa5iCLNs7aY5RI
 M5A5SlLmnhf63PbnmEIn8rOJibvBs2YXZPN/AqVHZm67/hm+zyxU+zobcbrqlsCGnPASYfpIBSh
 bWTGelXWCc+YVdg6IPgVdfTdqFbrkY1f3JuNT6/0M99f8pn7P8mPUK0Mm7dqoML3k27y+qSPzBb
 RNcjlflZRfta3CEXMTqhCWyLKDBuh3WnLeW7MXaL+1MgMbZqDRmLWCUaKoxSzf5T155P/+vozdf
 lkXkbEwOyRDvslvLEUConoLANchk6ChqMoLaBwYSwwPcEmnF
X-Received: by 2002:a17:907:26c7:b0:ba8:e7b5:39ad with SMTP id
 a640c23a62f3a-bd3bc9d770bmr373225766b.0.1778716510311; Wed, 13 May 2026
 16:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260513023859.518484-1-alistair.francis@wdc.com>
 <82b83672-24b9-40d1-9a19-89fd64c0606f@linaro.org>
 <20260513-pampers-threaten-2a71df36e314@spud>
In-Reply-To: <20260513-pampers-threaten-2a71df36e314@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 14 May 2026 09:54:43 +1000
X-Gm-Features: AVHnY4LxRcCplCwgrEXFIJ1wchhZRn_RB_J5uvUuA1SiDGmA0CDEXCscRnNiH1I
Message-ID: <CAKmqyKN5Tjwuy+S+NzEN0Xpsv_U7rQSM=PtvAkNNuhgA_oaRXQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 sebastian.huber@embedded-brains.de, 
 Alistair Francis <alistair.francis@wdc.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, May 14, 2026 at 7:26=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, May 13, 2026 at 08:10:06AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 13/5/26 04:38, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
> > > Conor and Sebastian as people to help deal with the fixes.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > > Conor let me know if it should be a different address
> > >
> > >   MAINTAINERS | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 952ed683bb..9626eb1ea9 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
> > >   F: tests/tcg/riscv64/test-crc32.S
> > >   Microchip PolarFire SoC Icicle Kit
> > > +M: Conor Dooley <conor@kernel.org>
> > > +M: Sebastian Huber <sebastian.huber@embedded-brains.de>
> >
> > Maybe worth having a look at Guenter's following patch for this
> > machine:
> > https://github.com/groeck/qemu/commit/1a66d5b4e5fe9
>
> Ye, I can do that. It looks mostly pretty sane, but needs a bit of
> cleanup I think before it is really applicable.
>
> Does it matter if the rates the PLLs report are accurate btw? Since

You know the hardware better than us. Generally if it allows the guest
boot and the values are sane then that's probably fine

Alistair

> everything here is emulated, it shouldn't matter if the PLLs run say all
> at 100 MHz instead of one at 100 and one at 40, right? They're just used
> to clock things like i2c or pwm controllers.

