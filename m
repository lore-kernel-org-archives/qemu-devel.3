Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A10CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCyf-0005SF-6p; Fri, 28 Jun 2024 10:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCyb-0005S1-Kn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:53:25 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCyZ-0002aJ-1X
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:53:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a732cb4ea31so494366b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719586401; x=1720191201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcAZy8tYKfGDn0hWs6mgRnqTgWc70bznUgpnA5wQpkI=;
 b=lCudYaLmeDfnYNeQLY5sru+jxfUNf8pPiiJvB1Jx14c+ulMfA295hA3FKZETW8aJ5f
 pWxuIB4a/JkSell5P0RhaaqP3L924hH2SJWcGtxmnm9XzBIPHcIaoOo21zAOUiCet4gR
 /47bfwyBTrU4JO4ym76mxoTc/vPImthZI69Nc892eWv8R1XiLAoIPKjsoCvd70UjSiBm
 4a0ZchzBTqbAr2JVDrZ42n8fA4jyOMb2c04JUNRGPiXV4sFGTDydGVWWHH8YgfumdU2N
 aB3aCE4FhCYzPEeNtEo7S7N97MdLI5lB+1eKEzXQ1FdzFfIhk3Cjk3qi+KyDhlOOBlem
 YAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719586401; x=1720191201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcAZy8tYKfGDn0hWs6mgRnqTgWc70bznUgpnA5wQpkI=;
 b=ZAWONYCas9BxaqYpXlWaMAXRbsvzWQC+/u5XpuR3xkadMRXDQFW5Pkd6ojiNCgpPXX
 ylbeeG9xrN/MLBXI5XLGuy0dOUDH07TYeZwg/FH9uwpj8kYXaW5glJI0x+IW9SbCXdjE
 Hs8uq2eAMZbA93+kt50Sos8c9RY016afH7qRRkVignDWfvlmS8mdAXv9BdVkynLtyG//
 E6cA8IX+0ztM9Zdps+yauZNmS/WrR3lHm+VdEyzBTPFjFHi5Q6+SMkv9WMShRTF5n9W5
 tTrSeDgy1DElc9dofepbp7iw5g6K+iqnfGPFxh2VS/7Ker0Nsy9mb/Q8GshjTx3YzljV
 A91Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjVosM2Qk0DbidahHVtkAqGrcvYBfvlJIJC/vbtYCzeugV994mK8/3us5MD++TDlZ9vtPbN/+O1TXCvA5XXb6kUT6IsVY=
X-Gm-Message-State: AOJu0YxwAZ2fs4nc5DL3CNfTZsDizFAHBXCL4vQcbcueXc4dJFqSlwRw
 tLRo0vAvsUH0+5b9HSaA5z7Ucs1m/GzJB4fFDrqd+DAzezrEPgt1M1G5+UqlY/B3mjyHc6B5UOG
 M1MdMt8mXJKZz5NXVrFuPchJ4F7ogcigsZnf4fw==
X-Google-Smtp-Source: AGHT+IFg0cnGEfREzZdVu7Gdxch1OvfId1g7xDcafrG3AU34gkmqiZn/g0OAA8NZi2TSa1RsbLWol/i8oAtsAODId0s=
X-Received: by 2002:a17:906:fb8e:b0:a6f:7902:7516 with SMTP id
 a640c23a62f3a-a72aee66f5emr145067166b.14.1719586401083; Fri, 28 Jun 2024
 07:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com>
 <CAGxU2F4Q5ewt442zGvUhfMuXYcRENEingFQVuu5VK_wQBizE3Q@mail.gmail.com>
 <CAFEAcA9hdkZU0GF=v9Fj3GrYha=kgFr3GaKjd8kvsPHDdVCfRQ@mail.gmail.com>
 <2ktqnpqfb7lh3vip2rulobxrobyycjomaxfucdz3bhzbtfjkia@ibml6lv475un>
In-Reply-To: <2ktqnpqfb7lh3vip2rulobxrobyycjomaxfucdz3bhzbtfjkia@ibml6lv475un>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 15:53:09 +0100
Message-ID: <CAFEAcA-cvU5RudZdokD+tHMGEHtUcoxowNwS4HxLWz5nvXqC9w@mail.gmail.com>
Subject: Re: [Bug Report] Possible Missing Endianness Conversion
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Xoykie <xoykie@gmail.com>, qemu-devel@nongnu.org, 
 Eugenio Perez Martin <eperezma@redhat.com>, thuth@redhat.com, cohuck@redhat.com,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Tue, 25 Jun 2024 at 08:18, Stefano Garzarella <sgarzare@redhat.com> wrot=
e:
>
> On Mon, Jun 24, 2024 at 04:19:52PM GMT, Peter Maydell wrote:
> >On Mon, 24 Jun 2024 at 16:11, Stefano Garzarella <sgarzare@redhat.com> w=
rote:
> >>
> >> CCing Jason.
> >>
> >> On Mon, Jun 24, 2024 at 4:30=E2=80=AFPM Xoykie <xoykie@gmail.com> wrot=
e:
> >> >
> >> > The virtio packed virtqueue support patch[1] suggests converting
> >> > endianness by lines:
> >> >
> >> > virtio_tswap16s(vdev, &e->off_wrap);
> >> > virtio_tswap16s(vdev, &e->flags);
> >> >
> >> > Though both of these conversion statements aren't present in the
> >> > latest qemu code here[2]
> >> >
> >> > Is this intentional?
> >>
> >> Good catch!
> >>
> >> It looks like it was removed (maybe by mistake) by commit
> >> d152cdd6f6 ("virtio: use virtio accessor to access packed event")
> >
> >That commit changes from:
> >
> >-    address_space_read_cached(cache, off_off, &e->off_wrap,
> >-                              sizeof(e->off_wrap));
> >-    virtio_tswap16s(vdev, &e->off_wrap);
> >
> >which does a byte read of 2 bytes and then swaps the bytes
> >depending on the host endianness and the value of
> >virtio_access_is_big_endian()
> >
> >to this:
> >
> >+    e->off_wrap =3D virtio_lduw_phys_cached(vdev, cache, off_off);
> >
> >virtio_lduw_phys_cached() is a small function which calls
> >either lduw_be_phys_cached() or lduw_le_phys_cached()
> >depending on the value of virtio_access_is_big_endian().
> >(And lduw_be_phys_cached() and lduw_le_phys_cached() do
> >the right thing for the host-endianness to do a "load
> >a specifically big or little endian 16-bit value".)
> >
> >Which is to say that because we use a load/store function that's
> >explicit about the size of the data type it is accessing, the
> >function itself can handle doing the load as big or little
> >endian, rather than the calling code having to do a manual swap after
> >it has done a load-as-bag-of-bytes. This is generally preferable
> >as it's less error-prone.
>
> Thanks for the details!
>
> So, should we also remove `virtio_tswap16s(vdev, &e->flags);` ?
>
> I mean:
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 893a072c9d..2e5e67bdb9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vde=
v,
>       /* Make sure flags is seen before off_wrap */
>       smp_rmb();
>       e->off_wrap =3D virtio_lduw_phys_cached(vdev, cache, off_off);
> -    virtio_tswap16s(vdev, &e->flags);
>   }

That definitely looks like it's probably not correct...

-- PMM

