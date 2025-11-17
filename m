Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2F7CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuoo-0008UU-La; Mon, 17 Nov 2025 03:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vKuok-0008Ta-T9
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:42:34 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1vKuoj-0005ws-43
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:42:34 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-640fb1e568bso642348a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1763368950; x=1763973750; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Llcd3b0Po9TbQEb5FIMi4qpEZzxnXTdZUt0wCS68+qk=;
 b=R2L16N7Vr87sQdJCx3fK0Z5QrZBOaHtxx9bri336nNM20CEBRUIjEjFSChj3IkudEc
 oO/QjCo4iocPoUKdpGWaW+tRUxPg5S0pFioZSnLgSexmYS4qgPBODRIyuGZIEMYYdJqv
 5g15vhc/kCYpmVvunmsbd4TG4GenJCiIf5iJ6BC5V9uhmOLB+e1CGsBWm3sFpXD7gUTL
 v5YQ/zR6VYCZ/GM8JX77aH4hsA6QHMsy8Y2ZZDLnBoeXJz3jjmNnWgq3qzDrgwPdW+1x
 bzEouZURusg+gb4EabW3asyQZNSEdLRBCygwoqTms+CgXqmp2bcsDjo0pn7edjx8/zd8
 olMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763368950; x=1763973750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Llcd3b0Po9TbQEb5FIMi4qpEZzxnXTdZUt0wCS68+qk=;
 b=aiQLW80EjBIWHXKFQ2tr6kwOsFBEdGSz9TQ11ZAZjqcTZnyvyWKmWpJIvtlrAQz92U
 UewHtwVmgwQKG9TJb3DxRI2yaFDc5o6E4Kj9eyp7SypphfrJNGlud4/lXs0ZdsSb96uO
 XsGNF6dC/WpjUZzEtE6K3duYZdF7iNKWhKBviOv4wkGf8gNMcnl50ngh3FymEzWpahYE
 kt0ROjm+GqR+ptSJLRdE53gcl+Etd/SIG4CLUxJ+jk8Nw+IvttuSgh4XDG3LUeKHZQwu
 RNH+LYxewnP16DNWorgmAYucFV+RzOdBWM4No0p4Ha4monF8Q9ixI0CT9QJLlCqVonge
 tqoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfr3+xhheMrfD/7OAfV1Dv3l66gZVrmbvdAFjP+rZ1nqcxOLZg7PXaQTdKVlyE6n3nFvD1io3lRldD@nongnu.org
X-Gm-Message-State: AOJu0YyE/6KpVyIReutcRZd1M+CQ+4NtD9CslXIQNRp8nmKx3SPscIBR
 aK/QNn5cz0tOpsFFw3dNhp3pZgtBmwMYqL2/CPueZpEGSv0Sn/uCu3zP/T1qk+H0NT04d3PYcQh
 +KgVJ/P8DBvRMSP2UO1Z9yaeVtdVeTqoXDnIsxOW1eQ==
X-Gm-Gg: ASbGncuKxetzimkHD7PXgWnnfEHieCOQ3Ohie7oI3e3PJ+HNsBd8+zcLxZ21BR94yuZ
 wKoK2r8ycmEddXTyBajsG1uNZITllEsfBLPDQL1C4jEuYF2kJz3pfTiteOP3HM1dLkwmOOjZdva
 S7Bytyy3kg66q9h5qqCm43wRkFQYzmn6tMd6FMdgYO6CIqFww7Lo+gB0Rr7Gqmi0wSU7LbnLAKI
 fs0L/xFCHHdhk4JuRiRkMm//z+KfXPywRurJoE5SMTVJYGzTiwbZi5/txQ1jAXTqATpqNebOrug
 AN12qg==
X-Google-Smtp-Source: AGHT+IFAW/Gd8S4+6WMPzH+eT1ywln6dLYD3zeUN9Z7qPKBY05pwutBWSPtRU1M3k1ZW0beAc8REETGcEMqf5MUx3S8=
X-Received: by 2002:a05:6402:50c8:b0:640:baf7:7975 with SMTP id
 4fb4d7f45d1cf-643515912bamr5757111a12.6.1763368950201; Mon, 17 Nov 2025
 00:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20251021053309.208957-1-jinpu.wang@ionos.com>
 <637696ee-f0a4-4e35-b281-0bd0b1089b09@tls.msk.ru>
In-Reply-To: <637696ee-f0a4-4e35-b281-0bd0b1089b09@tls.msk.ru>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 17 Nov 2025 09:42:16 +0100
X-Gm-Features: AWmQ_bmI4hWdQTsp--q3aO_-L85125P2MmyGEpkLigJ9ZWytOywjj0hikU7WdSo
Message-ID: <CAMGffE=hb3Og+NBA4gN5bG7Wpi7EM10JX-jPx0jBHpxDNdojbw@mail.gmail.com>
Subject: Re: [PATCH] qmp: Fix a typo for a USO feature
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org, yu.zhang@ionos.com, 
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::52f;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Nov 17, 2025 at 9:38=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 10/21/25 08:33, Jack Wang wrote:
> > There is a copy & paste error, USO6 should be there.
> >
> > Fixes: 58f81689789f ("qmp: update virtio feature maps, vhost-user-gpio =
introspection")
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>
> It looks like this patch has been forgotten.
> I can push it through the trivial-patches queue
> if you like.
>
> Thanks,
>
Hi Michael,

Yes, that sounds excellent. Please go ahead and push it through the
trivial-patches queue.

I agree the typo should be fixed regardless; I haven't had time to
look into the FEATURE_ENTRY macros in detail yet.

Thanks,
Jinpu
> /mjt
> > diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> > index b338344c6cca..968299fda0c9 100644
> > --- a/hw/virtio/virtio-qmp.c
> > +++ b/hw/virtio/virtio-qmp.c
> > @@ -299,7 +299,7 @@ static const qmp_virtio_feature_map_t virtio_net_fe=
ature_map[] =3D {
> >       FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
> >               "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
> >       FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
> > -            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv6"),
> > +            "VIRTIO_NET_F_GUEST_USO6: Driver can receive USOv6"),
> >       FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
> >               "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
> >       FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
>

