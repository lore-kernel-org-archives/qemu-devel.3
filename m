Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A702E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 12:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLM6a-00015V-6v; Wed, 11 Dec 2024 07:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tLM6S-00014J-Gs
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:46:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tLM6P-0001Ec-Rh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733921162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnx63n8/CH8Cp6i1au7PXsC6WUwqf6kg1LoLrK6u0h0=;
 b=czUofQ1pZOjBEA5zjO3VlB00vw5W7k+nAjZXfbBBGa174iqttZFWy3H3Rapb4MGkfnejtm
 W2BntaDgEaETr/kdR65i0J8LoMO45kLCpmMcH2YBVTNiEDev3PgX4aTudQ5b3K7Lx+9GZv
 9XsF6JTI0xw0bt6Imaps5Y++e8oz3fc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-NjmaankVMK69tEbxRZctnA-1; Wed, 11 Dec 2024 07:46:00 -0500
X-MC-Unique: NjmaankVMK69tEbxRZctnA-1
X-Mimecast-MFC-AGG-ID: NjmaankVMK69tEbxRZctnA
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6eeeb850458so86168997b3.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 04:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733921160; x=1734525960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnx63n8/CH8Cp6i1au7PXsC6WUwqf6kg1LoLrK6u0h0=;
 b=weLL7/Hu43Bkm7p/jDRVD5LehagaLhcl9oGni6k9mmgQZ7wQFqzyMiv26GLgg7NOWu
 CPZrZOP3t7L2w7fPX0AJiHfwypFzvO6l84ixHuLVvjVkRfBNVNd6aZhFJJ8FxvqxFhA+
 zt4S17ggnZArLYxxglBzEuM9L7iCpmzLVshNkfHLIQn4BmB9Kt+H16rGc1xhDRuECeN/
 tu2ccgYtK/PCsUbWy0aJm713c+TfMlSAzf7ap6jRmh7LoCVcX4VNdDldcVxfyxX2Dy7B
 X7O43i68y057mCYgmC/MRBkCvP0IIUrmQreS+rpzE4zT3a0DUwx50BCdM9dgS1+krt7f
 oMdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsvXefycaCfBHmCGhRuGVPsyEZsZlhCyRDABnLqg7WhrA6KVriEBgxTsK8nThhgK9mgv2YTY77lXkK@nongnu.org
X-Gm-Message-State: AOJu0Yw9YM7GYT/OdhJt0FVTHWzdOAesWCt8VVSQ9koxBlcjeZZKIRo2
 r8/Su9SCNy5AzV2lWrQizVuTMPDDN9lKtpn/GumCz72ExIJMyLiKb4nBv5l4S2b4skTfgfBf0rX
 hJDWFyjRSAV4D+6ZsCMGFyL8y1ka0HxZ2iPtcIs7yNui/kmwjYldjTpOWAOhy0UH+WOOan4qRjK
 kQqPPB1Oc3U/XEMIcU0NWaJtQG324=
X-Gm-Gg: ASbGncuZMwxC++o1BDylDINRE11bJ03JyfWFzaignO6QuoC7qEB1M6NfrapXN7NHkxG
 EOKCCdxTr68NTjXJxNYrmKSbFVnwjrkJz2vk=
X-Received: by 2002:a05:690c:4c09:b0:6ee:a81f:1264 with SMTP id
 00721157ae682-6f1480450afmr27430497b3.26.1733921160269; 
 Wed, 11 Dec 2024 04:46:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkvyKpVMaqbfwi4anBmvURDoRQdP+8CQVqysCHuAwvj1feSTLFTh06wHhqMt7O2j7/bauzQ1ZTzxuHSUpnwO8=
X-Received: by 2002:a05:690c:4c09:b0:6ee:a81f:1264 with SMTP id
 00721157ae682-6f1480450afmr27430367b3.26.1733921160020; Wed, 11 Dec 2024
 04:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20241211123349.904-1-Wafer@jaguarmicro.com>
In-Reply-To: <20241211123349.904-1-Wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 11 Dec 2024 13:45:24 +0100
Message-ID: <CAJaqyWcU8fN1ewYyZ1qDSdxWmr7SVbw8s+VKzO4_b63F8MS=Rg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/virtio: Fix check available index on virtio loading
To: Wafer <Wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 11, 2024 at 1:34=E2=80=AFPM Wafer <Wafer@jaguarmicro.com> wrote=
:
>
> From: Wafer Xie <wafer@jaguarmicro.com>
>
> The virtio-1.2 specification writes:
>
> 2.7.6 The Virtqueue Available Ring:
> "idx field indicates where the driver would put the next descriptor entry
> in the ring (modulo the queue size). This starts at 0, and increases"
>
> The idx will increase from 0 to 0xFFFF and repeat,
> So idx may be less than last_avail_idx.
>

I don't get this change. If that happens the driver went buggy or
malicious and the next check nheads > vring.num should mark the vq as
buggy, isn't it?

> Fixes: 258dc7c96b ("virtio: sanity-check available index")
>
> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
>
> --
> Changes in v2:
>  -Modify the commit id of the fix.
> ---
>  hw/virtio/virtio.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index a26f18908e..ae7d407113 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3362,7 +3362,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int v=
ersion_id)
>                  continue;
>              }
>
> -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
> +            if (vring_avail_idx(&vdev->vq[i]) >=3D vdev->vq[i].last_avai=
l_idx) {
> +                nheads =3D vring_avail_idx(&vdev->vq[i]) -
> +                         vdev->vq[i].last_avail_idx;
> +            } else {
> +                nheads =3D UINT16_MAX - vdev->vq[i].last_avail_idx +
> +                         vring_avail_idx(&vdev->vq[i]) + 1;
> +            }
>              /* Check it isn't doing strange things with descriptor numbe=
rs. */
>              if (nheads > vdev->vq[i].vring.num) {
>                  virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
> --
> 2.27.0
>


