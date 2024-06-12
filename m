Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F96BC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJms-0006aU-NN; Wed, 12 Jun 2024 04:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHJmq-0006Zo-59
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:56:56 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHJmo-0005Qo-BS
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:56:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35f223e7691so405679f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718182606; x=1718787406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sykB+ZZ03atBd8iudmBxnh/0IJvWE1EfTCtRykO68BY=;
 b=Pu1r0MJmz781maxJDp9h5UmQbA7i9KlynuBthgjRtdxJQ61L1u3BazOxvpyUyNgYX6
 5uMgpADD2hYQazLizfmVNqTjHeISO2eQINZV1vbe9jkdWAvttDOADrjAZW5gG5A2EgrG
 25OIZIgM6poFbEAMkZzDEcNj0JBkRPOeoGTgzMFCrhXJEONA4INY2cSLgWxJLgy0bjxT
 A8SyQs0w+BNrZ6vDlhtDt0LJfYCnb21RivbzQH5MfDTXUV0kN0sKIWtUxPUGQlPd1PON
 JoGTkyZKIg1HmXU7AwGRYHiMaZqJDONfmjLKG22X4bDHX2FYPaST+ojrBviJk0Y1iosK
 Coag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718182606; x=1718787406;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sykB+ZZ03atBd8iudmBxnh/0IJvWE1EfTCtRykO68BY=;
 b=avkUI1Qy0K55YdxwUUtix/z8ysHTKifQAB04tHJ8BjJJ2EvtSQEMMHN2BuxhP9SiCl
 K/zomiZAjMnTy4xKMJ9b50GZDMwsF5zO109z9/N2D/Zlh9RDd6UJkMxfIeVAvagjZxKs
 LCotOIJNGgdzXnM12T0rWN9DJW494W1qEakixHWn9ngGVlyyhFH/vRw+9OlUYAjvvTNz
 ZiT+ScmgrNmdkx8GdiPzsQsVk+aENdYscfl2S1YcdrRbwaOsthSfuA1+2AVVXMGFC53x
 NHCmCbVMf+eKhiS5b/q3HYS59CiGGEz0X19b+ztfh6oKB2Z7kDQp2OWp3vGxK1U6IAVR
 uAaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxb8vSXvUgjx0fnjOHvwYDfj7z2c4Gk7TpVtI4Crf09IXLPpcMGTVjDn0r6MN4l6y28Dvq+me4efL+naeIV3JB803qbKk=
X-Gm-Message-State: AOJu0Yz/tzedbgaA+hDP/zh5h24T4InoLI9mGcPWUukxlLVlVLUIe2zb
 ImLjTB3mZV3MbmF8dpgxWzwufcfOow8qb86V6DX5x+v4H8jDmKlEkI/RmGub9DY=
X-Google-Smtp-Source: AGHT+IE+sRiHoGK0tMdgTomZEbWxwBkqAHtCuCsuPJvaJiAHYLAbJFLBbjV/ziWy3Y0l7q4qXO8CcQ==
X-Received: by 2002:a5d:47c1:0:b0:360:6e1c:558f with SMTP id
 ffacd0b85a97d-3606e1c56d0mr888924f8f.5.1718182606415; 
 Wed, 12 Jun 2024 01:56:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0eb36c72sm12078275f8f.85.2024.06.12.01.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:56:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 606A25F893;
 Wed, 12 Jun 2024 09:56:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Zheyu Ma <zheyuma97@gmail.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v1] virtio-iommu: add error check before assert
In-Reply-To: <CAAjaMXZb+9h+eMOE67k-tGNRSObFqD5-_wUT1PaOHWSE86b2Aw@mail.gmail.com>
 (Manos Pitsidianakis's message of "Tue, 11 Jun 2024 20:46:55 +0300")
References: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
 <5cc8bab3-4edc-4657-882b-5e8291fba29d@linaro.org>
 <CAAjaMXZb+9h+eMOE67k-tGNRSObFqD5-_wUT1PaOHWSE86b2Aw@mail.gmail.com>
Date: Wed, 12 Jun 2024 09:56:45 +0100
Message-ID: <87sexiy1wy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Tue, 11 Jun 2024 at 18:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
>>
>> On 11/6/24 14:23, Manos Pitsidianakis wrote:
>> > A fuzzer case discovered by Zheyu Ma causes an assert failure.
>> >
>> > Add a check before the assert, and respond with an error before moving
>> > on to the next queue element.
>> >
>> > To reproduce the failure:
>> >
>> > cat << EOF | \
>> > qemu-system-x86_64 \
>> > -display none -machine accel=3Dqtest -m 512M -machine q35 -nodefaults \
>> > -device virtio-iommu -qtest stdio
>> > outl 0xcf8 0x80000804
>> > outw 0xcfc 0x06
>> > outl 0xcf8 0x80000820
>> > outl 0xcfc 0xe0004000
>> > write 0x10000e 0x1 0x01
>> > write 0xe0004020 0x4 0x00001000
>> > write 0xe0004028 0x4 0x00101000
>> > write 0xe000401c 0x1 0x01
>> > write 0x106000 0x1 0x05
>> > write 0x100001 0x1 0x60
>> > write 0x100002 0x1 0x10
>> > write 0x100009 0x1 0x04
>> > write 0x10000c 0x1 0x01
>> > write 0x100018 0x1 0x04
>> > write 0x10001c 0x1 0x02
>> > write 0x101003 0x1 0x01
>> > write 0xe0007001 0x1 0x00
>> > EOF
>> >
>> > Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
>> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> > ---
>> >   hw/virtio/virtio-iommu.c | 12 ++++++++++++
>> >   1 file changed, 12 insertions(+)
>> >
>> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> > index 1326c6ec41..9b99def39f 100644
>> > --- a/hw/virtio/virtio-iommu.c
>> > +++ b/hw/virtio/virtio-iommu.c
>> > @@ -818,6 +818,18 @@ static void virtio_iommu_handle_command(VirtIODev=
ice *vdev, VirtQueue *vq)
>> >   out:
>> >           sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
>> >                             buf ? buf : &tail, output_size);
>> > +        if (unlikely(sz !=3D output_size)) {
>>
>> Is this a normal guest behavior? Should we log it as GUEST_ERROR?
>
> It's not, it'd be a virtio spec (implementation) mis-use by the guest.
> the Internal device error (VIRTIO_IOMMU_S_DEVERR) would be logged by
> the kernel; should we log it as well?

Yes logging guest errors are useful when attempting to work out if
guests are buggy or QEMU is in the future.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

