Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2775FCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 06:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHGH7-0008I5-G0; Fri, 07 Nov 2025 01:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vHGH4-0008Gl-Ii
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 01:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vHGH1-00013S-Mk
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 01:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762498117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKWkx0qphW4TDOHQhDrWZG6gdBs1YKPbCbMV9uUpsio=;
 b=HvvTs6cY7M76WAqFPB+kT47ZUYs1Qqwj20olk4MEacZPoAOLIQO/w7zTnzyewGyCtIZRNN
 jv+juuJ2bH2SemOD4TRrmimU6jIt364g8fgwENQyh5CsNeRgK5n2SA+VQV2+sNONrndL21
 1v9ZBwZC4qyzggXoHPW5EJd1A2JuXMQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Y1bZlRKoPVSa8Yqc6XpOJQ-1; Fri, 07 Nov 2025 01:48:36 -0500
X-MC-Unique: Y1bZlRKoPVSa8Yqc6XpOJQ-1
X-Mimecast-MFC-AGG-ID: Y1bZlRKoPVSa8Yqc6XpOJQ_1762498115
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-786444a5c8dso9177187b3.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 22:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762498115; x=1763102915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKWkx0qphW4TDOHQhDrWZG6gdBs1YKPbCbMV9uUpsio=;
 b=GuognWnc9aqKFsH0JVJ3cqmlkPYWM+v2TsTnU3Y1vJ51pkQyYgzRf/I5c+T8nIuaCX
 AgR+j18oajj8I3oXrj4T/Rwhdf5MjUAfD3NK7eLwQ7aQgwGmFM7WyQjIlewKI5tcOJrH
 22rmGeynVT8ftgK9dCr041qVBgG3hz9LqvIZAPMnHqb98lFtomtJQbVYZHoIDb1PsHHa
 6MSTqAp2cENQzJUYYP1IOcSXRSKja4eLN6ZCmS3+obw3ri/fSu/M2vp13J+jc7XlCTjp
 HbSGr5nEzOqXaFUThcWOP8PELnvPJzfRpgjy+4rFwVQtujcPl0ZXfK7qpeZPsMZybhTM
 969A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762498115; x=1763102915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qKWkx0qphW4TDOHQhDrWZG6gdBs1YKPbCbMV9uUpsio=;
 b=MxRDHLm3+BwG0SV2yPnFsdAHJnYaIaBh4++B8aJJVNGc0QKjCN50eG48KwtLv4YzdQ
 k4YHdgIDT3Ncfpux+KH7ViTv4cPwpZ8duaYXtgYVMtYjZincDHm9dgxoNTx5zhgu9WYh
 uAaFjAzEg++V7KSQLpwZwbUJ3E70xAGIauV+7R+E66st1sEUuQ2pJnhHT0SMjr/nnRly
 /+JzIxjzXbEiMUXd9L2mYuRabop7fmKFe7P4kAVX4zhTP3PSrMceP7WcpkQlIufEgQ90
 Gn41euGSIW0Oxv4MgEmqK67IbS4Og+QHiNypy2/mftQAPBzIeotI6DVMrzzD4zgXiQnX
 VnvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQgmghBcjVctlDQu3dQUX6W+N8wctB4fUPwSwYKlL3zFn/L62MZgKESQYjacvee56Cmu6HC9d7aLRS@nongnu.org
X-Gm-Message-State: AOJu0YyvhcnRN6UMeeXVJln9RAbZJeABnXxrbGa9qMgyzjZUmjHk7g+s
 woUdVEbVxlVRIIkpMv5tBkalz8A1omZ7BZ4zY1S55wsXLPJkUtoNjoMxpAUzTq7F+6V2zxCsFif
 TSUjBfMFPOJ0KNkM1pZ9oGDjX7mKB2Ssacxg5wUnQPTCBT/yELCIIoHbQsz1a9YtpGtS1dYrKc3
 3EJv9yRiwaHVFfQKqCUEaymfGDYgw2gq8=
X-Gm-Gg: ASbGnctPIENbQ4+h8M3zL3rS4LCqgPWdpI1r6LpXJjsWz+X1006tMyp5K8H+JTWZmQ7
 I65GgpUM2PXzPqh0dQ1+sD0ASIY9v/SASLWYMQiRveZ/T9aJPrTmLZmtLfH/8rlJoQ5WMMXRnNo
 PfV9dQNnn4EQxacODEopQ5ZSswk2u5rqy8IzzkD3bqbKI2P+0pOgeUlegq
X-Received: by 2002:a05:690c:f5:b0:786:378b:e7f2 with SMTP id
 00721157ae682-787caad6b64mr4051647b3.10.1762498115645; 
 Thu, 06 Nov 2025 22:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/X3F+xRPjhICAeAEpFQDiVFw72a8IjaEFWmKeDvDzXXAKhmT38sIbIqRX36+n9dzlklv0Qrg5g7qOAPNL2TI=
X-Received: by 2002:a05:690c:f5:b0:786:378b:e7f2 with SMTP id
 00721157ae682-787caad6b64mr4051527b3.10.1762498115302; Thu, 06 Nov 2025
 22:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20251107064320.4633-1-wafer@jaguarmicro.com>
In-Reply-To: <20251107064320.4633-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 7 Nov 2025 07:47:59 +0100
X-Gm-Features: AWmQ_bmDPm5mQOWCKPoegYozBR9ooj-rlz75NsMeH0Lk7iArAkJa7gM9iULttnE
Message-ID: <CAJaqyWd4dpZ0L3F058sy9EuFD1U=BcXk1t+t62k11yyvfvo+-w@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: fix vhost-vdpa suspended state not be shared
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com, 
 angus.chen@jaguarmicro.com, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

On Fri, Nov 7, 2025 at 7:45=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> wr=
ote:
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
> So move v->suspended to v->shared, and then all the vhost_vdpa devices ca=
nnot
> have different suspended states.
>
> Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")
>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
>
> --
> Changes in v2:
>  -Move v->suspended to v->shared
> --
> ---
>  hw/virtio/vhost-vdpa.c         | 6 +++---
>  include/hw/virtio/vhost-vdpa.h | 8 ++++++--
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 7061b6e1a3..2f8f11df86 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -905,7 +905,7 @@ static int vhost_vdpa_reset_device(struct vhost_dev *=
dev)
>
>      memory_listener_unregister(&v->shared->listener);
>      v->shared->listener_registered =3D false;
> -    v->suspended =3D false;
> +    v->shared->suspended =3D false;
>      return 0;
>  }
>
> @@ -1354,7 +1354,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *de=
v)
>          if (unlikely(r)) {
>              error_report("Cannot suspend: %s(%d)", g_strerror(errno), er=
rno);
>          } else {
> -            v->suspended =3D true;
> +            v->shared->suspended =3D true;
>              return;
>          }
>      }
> @@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_d=
ev *dev,
>          return 0;
>      }
>
> -    if (!v->suspended) {
> +    if (!v->shared->suspended) {
>          /*
>           * Cannot trust in value returned by device, let vhost recover u=
sed
>           * idx from guest.
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 449bf5c840..6ad371f424 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -76,6 +76,12 @@ typedef struct vhost_vdpa_shared {
>
>      /* SVQ switching is in progress, or already completed? */
>      SVQTransitionState svq_switching;
> +
> +    /*
> +     * Device suspended successfully.
> +     * The device can only be suspended once, so it needs to be shared.

I think I prefer the "the vhost_vdpa devices cannot have different
suspended states" comment here, but I'm fine with this one.

Either if you change it or not,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> +     */
> +    bool suspended;
>  } VhostVDPAShared;
>
>  typedef struct vhost_vdpa {
> @@ -83,8 +89,6 @@ typedef struct vhost_vdpa {
>      uint32_t address_space_id;
>      uint64_t acked_features;
>      bool shadow_vqs_enabled;
> -    /* Device suspended successfully */
> -    bool suspended;
>      VhostVDPAShared *shared;
>      GPtrArray *shadow_vqs;
>      const VhostShadowVirtqueueOps *shadow_vq_ops;
> --
> 2.34.1
>


