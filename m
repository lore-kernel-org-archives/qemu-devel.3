Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEA7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 08:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGuzs-0000ls-Kc; Thu, 06 Nov 2025 03:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vGuzp-0000ld-R1
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 03:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vGuzo-0006R4-1F
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 03:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762416325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pN3pT8srM+G8jvRYVGxOxANVNO68Hpal0jz/dfkI0oM=;
 b=VoqNgB/dFGwQQqUxSAJ/C7Kn54/8kXgVgRTtqbW828MYp4yVRBkpwW5MiaKWcTfHa8Y0i1
 q8b7/3mAf93XXjlyBu02pArXWuKccLn33WbUG15MP+EFKLM125q1winRgVT0W3fCvnqPkt
 mSGqFK5pO5dLCuDOPLVsnhcHl4s75Xk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-OP27OCA9OJan9w75ltLL7Q-1; Thu, 06 Nov 2025 03:05:24 -0500
X-MC-Unique: OP27OCA9OJan9w75ltLL7Q-1
X-Mimecast-MFC-AGG-ID: OP27OCA9OJan9w75ltLL7Q_1762416323
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-76c0ad16289so7123547b3.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 00:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762416323; x=1763021123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pN3pT8srM+G8jvRYVGxOxANVNO68Hpal0jz/dfkI0oM=;
 b=njGHj128iCrZ8sOD4hH28qj05Sv7JECeA7KiRvfTtkOxZbaXvIcMRpZWc2/7viaWeh
 0lj4ej5/t2kMlh0kWxvTxTRZHhKDkednFJUs1L3YhbJtwwdq8DRkv+jJnX+ym73hscaj
 pl53P4ReU6aTA9Uu2Fw5MD8PDcTFEnO00R78H78ATaZCKCuGxAYHB4VgFaCqba8RgmIm
 xNX3YtnKvHsLYIBQq2706+Y8fVJbAOlhW3U/pTRKN/eY4JpyKx8U1DmqWB8JcHMgo1xb
 tQ5Ne4V9rhyr3gaO95Z2ulQzIaY6Yj5bmVhYMqbQjJeaMLc883DgfJnnzFus5GNG0eQC
 fB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762416323; x=1763021123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pN3pT8srM+G8jvRYVGxOxANVNO68Hpal0jz/dfkI0oM=;
 b=eRjnSNEYWG0aTUax9qjxW8wodh2nht2SGYr4NBwUNZgQtc44srYsRqnVr/BXDqtI7b
 csUPCn5+0PdImONJKYxq5NG1Td6GMgfTMpMvoSWZ6kaQwsehZZW1k2oKzJJwXRgjtUlr
 11b2S+yqmd2s+mXRYNZ9J0XR93L4yFhEcjy0qmkOw3w8Jt272JzPvFcirjNxnqx0kdMa
 6iZbZ74jGh50aBQqkWcbh8fxQxaik6W7dUuIURiy1pjDLQi5Wt1LYeBBm6a/pzWRsYoC
 ZQehxGnAvPxqo0VmHngEKsoKne7D80Yb4me+uX1j6YvqjborG5WvY0tM3WI8lr4PjTMB
 0Jng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5hUxzxDA4EhBMRZU4Crzdr3EkAkOKyYIwZ9qzNZO3sV2x/VszMAqgtVdJvqxC+PN/sw8a+5iUnrkU@nongnu.org
X-Gm-Message-State: AOJu0Yyr2TNDPOm7Q5L9iaH3z1mHklVQS8qx2VsCanMo72yReGe1ejrQ
 lQ5GyQP/PYrZtDRdNl6+QUVER57h3OvdNTWVWkI2VrKxNNxysOfG1cyyiml84rpaeKkBXK9KleQ
 HSwuTduyvP8d841tdnRk9f3KFToJjl41RU0Nfq4zJNp1bZcc4HDwdHYrZu8o789EnCMgZGWtuel
 aBirFKyuIv3Ng7TN6gElW8CDrAdk3htu4=
X-Gm-Gg: ASbGnctnC6t7xnEz8mBH/jz9/A6pJ0QtZZFiGyVXn6l1wzWgsVgpiWc7rGxNbg6d9KI
 4P+FuhIiLQKaU3nxLAd3ngx/tfvQ/5RXKi2jaxU66ynmy6AKzg97YkT4eae0ctB1cEsH7HITilG
 fmYFdVZFYFLffGWxhrxqTnJjnW91e5tvNf7MzMhcchlM7XUtUO3UO8xzMu
X-Received: by 2002:a05:690c:670b:b0:786:7017:9514 with SMTP id
 00721157ae682-786a41d9171mr61253297b3.55.1762416323653; 
 Thu, 06 Nov 2025 00:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzCATBzzRcA7H/0RCszO3kBbig2YQpNwWK+AIPgZ9J5Y+V1j57rnZbslpMBoYVjTwDnpp1a16ht8ypYQtEfyw=
X-Received: by 2002:a05:690c:670b:b0:786:7017:9514 with SMTP id
 00721157ae682-786a41d9171mr61253017b3.55.1762416323206; Thu, 06 Nov 2025
 00:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20251029125001.15086-1-wafer@jaguarmicro.com>
In-Reply-To: <20251029125001.15086-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 6 Nov 2025 09:04:46 +0100
X-Gm-Features: AWmQ_bkSlfH2Ar2gc9XciVqvk_QzbFz6Yi-9MP3fEfCY_T21MNwHZl8K80bFXL4
Message-ID: <CAJaqyWf+YxQAxM3e0H2Er=dYSbGHhadJQ5n=Lj_b4Ufa4z=HYg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix cannot get vring base when stopping a
 vhost-vdpa device with multiple queues
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com, 
 angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 29, 2025 at 1:50=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.com> w=
rote:
>
> When stopping a vhost-vdpa device, only the first queue pair is marked as=
 suspended,
> while the remaining queues are not updated to the suspended state.
> As a result, when stopping a multi-queue vhost-vdpa device,
> the following error message will be printed.
>
> qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not perm=
itted (1)
>
> qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not perm=
itted (1)
>
> Fixes: b6662cb7 ("vdpa: add vhost_vdpa->suspended parameter")
>
> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7061b6e1a3..2d5e6aca74 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>          return 0;
>      }
>
> -    if (!v->suspended) {
> +    if (!v->suspended && vhost_vdpa_first_dev(dev)) {

I'm sorry I missed this fix!

Good catch, thank you very much! But the right fix is to move
v->suspended to v->shared, and then all the vhost_vdpa devices cannot
have different suspended states.

Apart from that, please include the tag

Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")

In the patch description.

Thanks!

>          /*
>           * Cannot trust in value returned by device, let vhost recover u=
sed
>           * idx from guest.
> --
> 2.34.1
>


