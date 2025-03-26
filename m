Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CC0C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPYw-0002Rg-UH; Wed, 26 Mar 2025 08:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPYt-0002O9-CD
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txPYr-0003Qc-DG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742990923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UY1arTL+T7gB0D6k5osfySS6w21iYXBKfhlOnNCepM=;
 b=c1EVGc6OviYqRhNIii6CWrV0hvVxJr+4o3Wljj4PXGOpimSYdTA0MTXukCFYti+CD7yJBy
 wkQiNzAWrW2GMCGlpZX7F9TSyXqWzqm4QWZl5Nfh/BUfRClPuK/8FrHcQFw6125TVR5l+y
 6X1kl+auoU4JKSs78rGH8OIepXEf2S8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-Kvoz043hNgCnC6Rpke74Zg-1; Wed, 26 Mar 2025 08:08:40 -0400
X-MC-Unique: Kvoz043hNgCnC6Rpke74Zg-1
X-Mimecast-MFC-AGG-ID: Kvoz043hNgCnC6Rpke74Zg_1742990920
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff6aaa18e8so10430578a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 05:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742990920; x=1743595720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UY1arTL+T7gB0D6k5osfySS6w21iYXBKfhlOnNCepM=;
 b=ZeC0xgOG84BGwEjiN5AbzQtHYHJDpP7wlTg5FZ1WHbIBXtilEmlE3iykhynhJrLGB0
 UAa0BKBsztv8F6GVsYxIS1LUMsMkvKI4qb3mD9ST7JMpn9UI5sQOJigATgJcvh5hYmaR
 v1QnHsVa/pcQi2Z6FN6Xoj5TeNHpvIrQk7OU3iSSjhjyV244Bc0h50CzyKMss97Y19/p
 SuNrzX085zQao7qaeu05oU5JI/B+yJsm/fAezCQ8F6kexGo6HL2dZpUQn1ZsTU4/CaZP
 Dp7XawK/trrQxMOWPMWqJuYzQLeTD9mVIUZxiNefNS/XAgjPmkQa+HozBL9vzHUGqqOp
 sJhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIhMN+qVR/zo4a26GOM7foJq6dk+GbaBekzGMri5Y36v6JheTXMZMoYTr6AxVk2GU9N4QmgccE8+3l@nongnu.org
X-Gm-Message-State: AOJu0YwnHntYKgPUhgUi1egrP1+kBnqvpDuRKH37vYMZxfkGBzSMru22
 cGPumFBtR/dI823vLaZTJaujqNHsJBNnYwLO+eJuiqkdxWfL0ki9v6XxZdEGD90CCADR8h55TiJ
 3jPe61Jd+DIsTfKSayGmG8Z+fCZDSnq0AI8sXfQwntRexPtoYB8soahovB0Tdg90aRnHQGxob9v
 0/bcJbuufEqJ+ZnNSRFlUEUGsVsnM=
X-Gm-Gg: ASbGncueik7s+PsDwUyeI1GAFsOCtMX8BhqOdgOv36VbyydJBwlGiJ/7fjqeZ6N1l8o
 PQC8Z0VirQN6R4flSs+ERpRdsjzO08FyYhUItXCayQ6fd1wBaEUaHqMIpk0x4mvcbJOyD+CU=
X-Received: by 2002:a17:90b:2647:b0:2f7:7680:51a6 with SMTP id
 98e67ed59e1d1-3030fe6a058mr26571499a91.6.1742990919509; 
 Wed, 26 Mar 2025 05:08:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO1KeARrVa+p2C6nWkzML+r/jwppMQw/d4eQDlLPj21Cqkc4rpAZPVP/gYDNbySezhFCiTNzSWBAX6j4KjOdI=
X-Received: by 2002:a17:90b:2647:b0:2f7:7680:51a6 with SMTP id
 98e67ed59e1d1-3030fe6a058mr26571460a91.6.1742990918951; Wed, 26 Mar 2025
 05:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-8-sahilcdq@proton.me>
In-Reply-To: <20250324135929.74945-8-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:08:02 +0100
X-Gm-Features: AQ5f1JrhfwGGxKGc6Dz4lWVBBw7vH0RWg_RIydy_4cevCt0QVubKQlcROY_n5NQ
Message-ID: <CAJaqyWfkGpRCv1a0qS3XC3Tnco-YSVH-CHd3itFG4V41tnc3wQ@mail.gmail.com>
Subject: Re: [RFC v5 7/7] vdpa: Support setting vring_base for packed SVQ
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Mar 24, 2025 at 3:00=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> This commit is the first in a series to add support for packed
> virtqueues in vhost_shadow_virtqueue.
>
> Linux commit 1225c216d954 ("vp_vdpa: allow set vq state to initial
> state after reset") enabled the vp_vdpa driver to set the vq state to
> the device's initial state. This works differently for split and packed
> vqs.
>
> With shadow virtqueues enabled, vhost-vdpa sets the vring base using
> the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
> differs for split and packed vqs. The implementation in QEMU currently
> uses the payload required for split vqs (i.e., the num field of
> vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
> payload is used with packed vqs.
>
> This patch sets the num field in the payload appropriately so vhost-vdpa
> (with the vp_vdpa driver) can use packed SVQs.
>
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.h=
tml
> Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.co=
m
> Link: 1225c216d954 ("vp_vdpa: allow set vq state to initial state after r=
eset")
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> Changes from v4 -> v5:
> - Initially commit #5 in v4.
> - Fix coding style of commit block as stated by checkpatch.pl.
>
>  hw/virtio/vhost-vdpa.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 58c8931d89..0625e349b3 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1265,6 +1265,21 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev =
*dev,
>      };
>      int r;
>
> +    /*
> +     * In Linux, the upper 16 bits of s.num is encoded as
> +     * the last used idx while the lower 16 bits is encoded
> +     * as the last avail idx when using packed vqs. The most
> +     * significant bit for each idx represents the counter
> +     * and should be set in both cases while the remaining
> +     * bits are cleared.
> +     */
> +    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
> +        uint32_t last_avail_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_=
CTR);
> +        uint32_t last_used_idx =3D 0 | (1 << VRING_PACKED_EVENT_F_WRAP_C=
TR);
> +
> +        s.num =3D (last_used_idx << 16) | last_avail_idx;
> +    }
> +

This should be added before 6/7 so we don't declare we support packed
without this.

>      r =3D vhost_vdpa_set_dev_vring_base(dev, &s);
>      if (unlikely(r)) {
>          error_setg_errno(errp, -r, "Cannot set vring base");
> --
> 2.48.1
>


