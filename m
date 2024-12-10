Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE99E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKw21-0005KI-7Y; Tue, 10 Dec 2024 03:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKw1x-0005G6-GN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tKw1v-0004cV-IT
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733820942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctpum92POoP9+D9Pr2k+Szw3dF2BItWGwSKVcY1eWkc=;
 b=OqErsKQHOqBu5aH0MM5mo98jrPD/21FWmyx18Sq4rGpMQUYdpmnhBWAcvbXcWpiz1z+Zpc
 HdArlXpgn7ihH1Jtx6Uxy7IRL5En9BqyDPk63HcT80BD9xJAj5YhLpITxqEEvFpsjexVf0
 19Gn5BusAUGBZgrEc7/4Oztz90p327o=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-4PO7rlTxN1W8c7Lvxp5e4g-1; Tue, 10 Dec 2024 03:55:40 -0500
X-MC-Unique: 4PO7rlTxN1W8c7Lvxp5e4g-1
X-Mimecast-MFC-AGG-ID: 4PO7rlTxN1W8c7Lvxp5e4g
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-6eeeb850458so71615867b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 00:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733820940; x=1734425740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctpum92POoP9+D9Pr2k+Szw3dF2BItWGwSKVcY1eWkc=;
 b=Rm4dDo6XILs0Uy/abuxfMwLmKWqQ+gJuWScTeFYhJpJJZpKXxzz4Gcu+gSlD0vCma8
 ll2f9YWmMyWr1HE8WwZfLx35or5LU+sN5bKV4Srx8IJjetG16jAd9mg03RBXOWAIUI5F
 lmZ3zaQuGjOmqCXoD9T33DZsoLK7nwS8hrgCtyzxWDgnMRvv9IrQ5hOou7COHunoE5mo
 3lWR6+bNyd88QQQzep5I9ANhqr/F++fFbd1gw1nynnnsVHLPlFP/iXxF4TXhMhkHal7N
 EQ/ms66yhpN8zOsTiLc9z06UqMKpFxJmga35wF/Xzm7izoYE/E5oqT73y5BA3irwqdyx
 IEbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhtACiLxPHH00dsbe5u8HQy5yLe1Xy6CUmuFA4A5pseLnx652Emo7SRiwJAxSV5I1tygJluQ6RQ7ya@nongnu.org
X-Gm-Message-State: AOJu0Yyf8YV1VbakqojWC1rHA+3EZaDv5YWKm7ZRRiZs1LX/0+U9sHso
 1pY8oDqeTYzbAD3JN3n6pXIUsjQ1t7j7AQmq5bmucfqox1bH9V/G9zf64yZ+gaY2QIOU9nOy3nv
 cV90nNGtDWizdIhDQpcRp/PsR9CLEIisVcH0p1CgoRSB1/vjNYVjHSrjXIMN3/NP9xXhmtbVf2O
 K2a43fLaehZheM4AsWaCCertKKOBc=
X-Gm-Gg: ASbGncskvW84Fdo3eG82/+U6lW1eNiLfXm47q6a6Kho5WC2I1/koEyWHRdx9Jv1MBBr
 qI/NCGX72xamDduqefKaazT9bTzzixhO7/0c=
X-Received: by 2002:a05:690c:8b1a:b0:6ef:6f24:d0bc with SMTP id
 00721157ae682-6efe3c6c947mr89148817b3.27.1733820939803; 
 Tue, 10 Dec 2024 00:55:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLhzFR22dFHyACCdC1AzchxKBqOE2f8fGDHbeccuI3o50Sh16DCmZW1b5uoMGDNflEYPv7BB5ylIHYq42B7vU=
X-Received: by 2002:a05:690c:8b1a:b0:6ef:6f24:d0bc with SMTP id
 00721157ae682-6efe3c6c947mr89148757b3.27.1733820939527; Tue, 10 Dec 2024
 00:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <20241205203430.76251-4-sahilcdq@proton.me>
In-Reply-To: <20241205203430.76251-4-sahilcdq@proton.me>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Dec 2024 09:55:03 +0100
Message-ID: <CAJaqyWfBpyJAwv2m9r0ik_pmoN2OSJvcvSjYuq_vPAXSZP138A@mail.gmail.com>
Subject: Re: [RFC v4 3/5] vhost: Data structure changes to support packed vqs
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Thu, Dec 5, 2024 at 9:35=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> Introduce "struct vring_packed".
>
> Modify VhostShadowVirtqueue so it can support split
> and packed virtqueue formats.
>

This patch should be before the previous one or it does not compile, isn't =
it?

> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> ---
> Changes v3 -> v4:
> - Commit #2 of v3 is now commit #3 in this series.
> - vhost-shadow-virtqueue.h
>   (struct VhostShadowVirtqueue): Add bool is_packed.
>   This was initially in commit #3 of v3.
>
>  hw/virtio/vhost-shadow-virtqueue.h | 69 ++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 22 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 19c842a15b..ce89bafedc 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -46,10 +46,56 @@ typedef struct VhostShadowVirtqueueOps {
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
>      /* Shadow vring */
> -    struct vring vring;
> +    union {
> +        struct vring vring;
> +        struct vring_packed vring_packed;
> +    };
>
>      /* Shadow kick notifier, sent to vhost */
>      EventNotifier hdev_kick;
> @@ -69,27 +115,12 @@ typedef struct VhostShadowVirtqueue {
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
> @@ -99,17 +130,11 @@ typedef struct VhostShadowVirtqueue {
>      /* Next head to expose to the device */
>      uint16_t shadow_avail_idx;
>
> -    /* Next free descriptor */
> -    uint16_t free_head;
> -
>      /* Last seen used idx */
>      uint16_t shadow_used_idx;
>
>      /* Next head to consume from the device */
>      uint16_t last_used_idx;
> -
> -    /* Size of SVQ vring free descriptors */
> -    uint16_t num_free;
>  } VhostShadowVirtqueue;
>
>  bool vhost_svq_valid_features(uint64_t features, Error **errp);
> --
> 2.47.0
>


