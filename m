Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48766C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5aX-0007f8-9P; Tue, 11 Jun 2024 13:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH5aV-0007em-I5
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:47:15 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sH5aT-0002EA-OS
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:47:15 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6f1c4800easo319154866b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718128032; x=1718732832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwSTSCJVVwt0iVYmLJK1Db1TLI+pYOhV6c8R4CFhtaU=;
 b=Jcr2KMpzRerW44nI1LSDQT6qjGP+DKukgKUSwWHXeZnDNDHXMNiEtqZ9CAAHxECBsX
 8tW34jlOpPc/ieroiRx768vVdah+U9aIF9ach/hsTPF9k9r+ZdaVdvLpC5sKFwZ+4Vcz
 gIOzindTjLQ1oqvgp+zWg4ute9fgaocRq4CN3MEHVW3hrPEmbz33jGBhmjg12Y+dWNtN
 i3AUgQ2pxiRjZ0uhBPGvH/RUMveZ/KsPmd1RPfZjWQAV+bluDWcF1z5CL5bBnyek5qyl
 m0VSK+lm5eptI23d1TKm7oI6pHfT8omnEtvtgOeKDNQ6GDKelNnWYA2kkvGxj7wO9Lj7
 hi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718128032; x=1718732832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwSTSCJVVwt0iVYmLJK1Db1TLI+pYOhV6c8R4CFhtaU=;
 b=nK7YarpfCHoooYRIHGMEruQXRWDqPEKJeNGBEVb4ydZB1nLe59k76yli5QR1tprhsF
 w/ROqa1L5n5m6SvKYBtTvKPt+1JI0eKPtoXtFgDKLgpn8sreu6KMoclyow9amkhzPlkS
 1jHOhKlDazQAPnqwybveSiHTQYhhFpLLvzWJ7Ytb0gj4J5uxc0pOrK6qk4E2pVPx2Sbs
 BC16/7gPULALohm5Sff9l9zc0+44meUtJqBostqOmxe+eLaPsFYCHeLCXLwMF1v21QN3
 hipMeGHZPdJOm27RrVxL0VLqqvjYt/NBFICvkfWg9ALFHJ8Y6zcCxLtYsCcgmKRWgYfU
 5whQ==
X-Gm-Message-State: AOJu0Yw1u+Y877JiTL9aDnCPNFT3JhAVYt0NqHmCnRE9V0ApUfhkiJWZ
 Dgw3DpvQ5TKHZ4X7lHQtRbWL860HCztw2NKsmEAKy9zQ1VUJ954Q2rT/jnv8hIRSGjEjLbcurQm
 93eNa50xYKLadZijP4bFka9lf++mrG/L42CeH8g==
X-Google-Smtp-Source: AGHT+IF+LmSgQG5TNqPiNU8kPvzVYjCS8NSdf8fa5T5LnHAD2MH612lYmUZGilg1FhW8NNDzlE1a3+56aDbYE6iUyn4=
X-Received: by 2002:a17:906:6a29:b0:a6e:a97c:fc97 with SMTP id
 a640c23a62f3a-a6ea97cfd15mr865047666b.7.1718128032014; Tue, 11 Jun 2024
 10:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
 <5cc8bab3-4edc-4657-882b-5e8291fba29d@linaro.org>
In-Reply-To: <5cc8bab3-4edc-4657-882b-5e8291fba29d@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 11 Jun 2024 20:46:55 +0300
Message-ID: <CAAjaMXZb+9h+eMOE67k-tGNRSObFqD5-_wUT1PaOHWSE86b2Aw@mail.gmail.com>
Subject: Re: [PATCH v1] virtio-iommu: add error check before assert
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

On Tue, 11 Jun 2024 at 18:01, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 11/6/24 14:23, Manos Pitsidianakis wrote:
> > A fuzzer case discovered by Zheyu Ma causes an assert failure.
> >
> > Add a check before the assert, and respond with an error before moving
> > on to the next queue element.
> >
> > To reproduce the failure:
> >
> > cat << EOF | \
> > qemu-system-x86_64 \
> > -display none -machine accel=3Dqtest -m 512M -machine q35 -nodefaults \
> > -device virtio-iommu -qtest stdio
> > outl 0xcf8 0x80000804
> > outw 0xcfc 0x06
> > outl 0xcf8 0x80000820
> > outl 0xcfc 0xe0004000
> > write 0x10000e 0x1 0x01
> > write 0xe0004020 0x4 0x00001000
> > write 0xe0004028 0x4 0x00101000
> > write 0xe000401c 0x1 0x01
> > write 0x106000 0x1 0x05
> > write 0x100001 0x1 0x60
> > write 0x100002 0x1 0x10
> > write 0x100009 0x1 0x04
> > write 0x10000c 0x1 0x01
> > write 0x100018 0x1 0x04
> > write 0x10001c 0x1 0x02
> > write 0x101003 0x1 0x01
> > write 0xe0007001 0x1 0x00
> > EOF
> >
> > Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   hw/virtio/virtio-iommu.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> > index 1326c6ec41..9b99def39f 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -818,6 +818,18 @@ static void virtio_iommu_handle_command(VirtIODevi=
ce *vdev, VirtQueue *vq)
> >   out:
> >           sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
> >                             buf ? buf : &tail, output_size);
> > +        if (unlikely(sz !=3D output_size)) {
>
> Is this a normal guest behavior? Should we log it as GUEST_ERROR?

It's not, it'd be a virtio spec (implementation) mis-use by the guest.
the Internal device error (VIRTIO_IOMMU_S_DEVERR) would be logged by
the kernel; should we log it as well?

