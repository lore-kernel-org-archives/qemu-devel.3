Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA1CC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txOvJ-00071k-7K; Wed, 26 Mar 2025 07:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txOur-0006ld-43
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1txOuo-0006KN-MC
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742988441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLSNH3zhDh9VqbeFpSwjl3hhBYCph9Oc7Nmzhv7a4IU=;
 b=YpZv3svgvh/Sm2EJocuGRFFT0U1JhVwtL82OPo15Qjt3DzmDdOjBzwa7UnmKqAlItpcees
 zECpmcTt8bWKjFc3hm6+7rw+hoIiDStDOiYehldYJCsHeenP/htFGnCmAMGsCKnPZcu8tR
 guwyYjhCLT5ylc78SPqR1cnxSeUT9ts=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-5HTQ-WhrOXyVM7HEYGbFZw-1; Wed, 26 Mar 2025 07:27:19 -0400
X-MC-Unique: 5HTQ-WhrOXyVM7HEYGbFZw-1
X-Mimecast-MFC-AGG-ID: 5HTQ-WhrOXyVM7HEYGbFZw_1742988438
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff8a2c7912so1691698a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 04:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742988438; x=1743593238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLSNH3zhDh9VqbeFpSwjl3hhBYCph9Oc7Nmzhv7a4IU=;
 b=WVMYRWvrJLYKsV76+zdguIxpNocaCeZEEMqHfTkPgqMymrDqyL5lkYhlAAdINOj/8k
 cVM2yaiBNak4ib6wh2hBjd8GYnUQDMvLmFVfxnuV44k4OVCkMEir3neOPa05eXZw+TyA
 j/LTBkRDS9uzjNo7n6bavKwrNl8+uvjDlSP0XmTwokXBN3o1IVA9NTbdwrM7C4gCokTK
 ltsvo9IH8Uakvn1Bx56PLpqorR1WQzj/t29MKFB4HGEOIVTHzb+esfZMxIEjSBcjH3Yh
 urr3Nwg8Z5pCL7jht3WletwPFK59BNOptkyxDxHbR/hpU7Or79YQV+ZUEbK4AHNhN4ll
 L1Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNkrFK5F5jb/pnJIG8l4w3erUELECoj9leg0tZMk06zG1yAPGnQWiHB+yaiyU52WC2QI7zVfKdAOBs@nongnu.org
X-Gm-Message-State: AOJu0YxGBPyxVmPNyjJYTKFOSH16d7qkUMMuNlNEx0qmankHxPhS+Lqm
 Nv+eHeAEB2mhjWyB0T8cfyqb+kO/VEkDy8RAVlkYjHBVzjBQxmVcJMrpDQewH5sZJQTsL/6nRhl
 mT8hsIXd/cYOVGNwVuJVJJotVJcWkge1y8qKPP8Xdyy6yM8xi0t9AeboWpSYYFmA960gTR3BcLS
 3ydaq+UzniSFEcwKg2CRmE6dvjTwU=
X-Gm-Gg: ASbGnctZCH0iI55XT/JDQIhbQU+XmoonZmvDncAiD1PdITST2k6GJHBjFNb1e094v4h
 5g/kaOJcvsBGzAmtjdHe4RTD8c0Yb/7XEMJtOVUnATlLFic0p+oIEUPA1mZBu/rzvZzE7TWQ=
X-Received: by 2002:a17:90b:2dc7:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-3037890df74mr4934211a91.10.1742988437966; 
 Wed, 26 Mar 2025 04:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFznsNlo6CSJVXRbXiry7Z4pCn441SIruyl4mPR1GRjb0Qk0qPBJ1MLYsbKWDJDWMNa7vt0BXEWl/NHvaO+I6Y=
X-Received: by 2002:a17:90b:2dc7:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-3037890df74mr4934158a91.10.1742988437377; Wed, 26 Mar 2025
 04:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-3-sahilcdq@proton.me>
In-Reply-To: <20250324135929.74945-3-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 12:26:40 +0100
X-Gm-Features: AQ5f1JoGVj2_DvV6rgdOaQT7nT7gkdJ6CFkPvEInUEy4P1Y2wNT75ZiS5lu5gT8
Message-ID: <CAJaqyWfSFH7vrCRdg0zV4xrs7AmjMAnmZnqp1P3fMCeiMEGFMg@mail.gmail.com>
Subject: Re: [RFC v5 2/7] vhost: Data structure changes to support packed vqs
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
> Introduce "struct vring_packed".
>
> Modify VhostShadowVirtqueue so it can support split and packed virtqueue
> formats.
>
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes from v4 -> v5:
> - This was commit #3 in v4. This has been reordered to commit #2
>   based on review comments.
> - Place shadow_avail_idx, shadow_used_idx, last_used_idx
>   above the "shadow vring" union.
>

What is the reason for the member reorder?

>  hw/virtio/vhost-shadow-virtqueue.h | 87 +++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 31 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 9c273739d6..5f7699da9d 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -46,10 +46,65 @@ typedef struct VhostShadowVirtqueueOps {
>      VirtQueueAvailCallback avail_handler;
>  } VhostShadowVirtqueueOps;
>
> +struct vring_packed {
> +    /* Actual memory layout for this queue. */
> +    struct {
> +        unsigned int num;
> +        struct vring_packed_desc *desc;
> +        struct vring_packed_desc_event *driver;
> +        struct vring_packed_desc_event *device;
> +    } vring;
> +
> +    /* Avail used flags. */
> +    uint16_t avail_used_flags;
> +
> +    /* Index of the next avail descriptor. */
> +    uint16_t next_avail_idx;
> +
> +    /* Driver ring wrap counter */
> +    bool avail_wrap_counter;
> +};
> +
>  /* Shadow virtqueue to relay notifications */
>  typedef struct VhostShadowVirtqueue {
> +    /* True if packed virtqueue */
> +    bool is_packed;
> +
> +    /* Virtio queue shadowing */
> +    VirtQueue *vq;
> +
> +    /* Virtio device */
> +    VirtIODevice *vdev;
> +
> +    /* SVQ vring descriptors state */
> +    SVQDescState *desc_state;
> +
> +    /*
> +     * Backup next field for each descriptor so we can recover securely,=
 not
> +     * needing to trust the device access.
> +     */
> +    uint16_t *desc_next;
> +
> +    /* Next free descriptor */
> +    uint16_t free_head;
> +
> +    /* Size of SVQ vring free descriptors */
> +    uint16_t num_free;
> +
> +    /* Next head to expose to the device */
> +    uint16_t shadow_avail_idx;
> +
> +    /* Last seen used idx */
> +    uint16_t shadow_used_idx;
> +
> +    /* Next head to consume from the device */
> +    uint16_t last_used_idx;
> +
>      /* Shadow vring */
> -    struct vring vring;
> +    union {
> +        struct vring vring;
> +        struct vring_packed vring_packed;
> +    };
>
>      /* Shadow kick notifier, sent to vhost */
>      EventNotifier hdev_kick;
> @@ -69,47 +124,17 @@ typedef struct VhostShadowVirtqueue {
>      /* Guest's call notifier, where the SVQ calls guest. */
>      EventNotifier svq_call;
>
> -    /* Virtio queue shadowing */
> -    VirtQueue *vq;
> -
> -    /* Virtio device */
> -    VirtIODevice *vdev;
> -
>      /* IOVA mapping */
>      VhostIOVATree *iova_tree;
>
> -    /* SVQ vring descriptors state */
> -    SVQDescState *desc_state;
> -
>      /* Next VirtQueue element that guest made available */
>      VirtQueueElement *next_guest_avail_elem;
>
> -    /*
> -     * Backup next field for each descriptor so we can recover securely,=
 not
> -     * needing to trust the device access.
> -     */
> -    uint16_t *desc_next;
> -
>      /* Caller callbacks */
>      const VhostShadowVirtqueueOps *ops;
>
>      /* Caller callbacks opaque */
>      void *ops_opaque;
> -
> -    /* Next head to expose to the device */
> -    uint16_t shadow_avail_idx;
> -
> -    /* Next free descriptor */
> -    uint16_t free_head;
> -
> -    /* Last seen used idx */
> -    uint16_t shadow_used_idx;
> -
> -    /* Next head to consume from the device */
> -    uint16_t last_used_idx;
> -
> -    /* Size of SVQ vring free descriptors */
> -    uint16_t num_free;
>  } VhostShadowVirtqueue;
>
>  bool vhost_svq_valid_features(uint64_t features, Error **errp);
> --
> 2.48.1
>


