Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A17D74965
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVbq-0006Rg-1U; Fri, 19 Dec 2025 03:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbn-0006Qt-9X
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbl-0005Ww-Jo
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766131984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slS80YqiMsMI0H3LaNWNRpkJQfsYGbaubdXmVKdWh/w=;
 b=KkHb5j/cqSBV7vmW3kajP6fi6ghya/Sufpl9ubwAN1Xa9vms8enMI5hd0Zs04COgn4SLOU
 al+biBPsSba5KQvkvRh4Dq0nV0cleUT1do4jfqi9+b+syZ/i+sssdQQwfZ9zZq49p+o/EN
 ve8hfmdFgXdWhcuQTJajk1aUjA+lBLo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-oGBIpQ8JPqSyWZqpVzjeAQ-1; Fri, 19 Dec 2025 03:13:03 -0500
X-MC-Unique: oGBIpQ8JPqSyWZqpVzjeAQ-1
X-Mimecast-MFC-AGG-ID: oGBIpQ8JPqSyWZqpVzjeAQ_1766131982
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-78fac0d55f1so17630367b3.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 00:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766131982; x=1766736782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slS80YqiMsMI0H3LaNWNRpkJQfsYGbaubdXmVKdWh/w=;
 b=X/1wmFHfrTmBNKEMiNEX8HcSwEwpcTOAml+vy41Fds6BBCaKKJrOofyIC+xe9emwl7
 fx0wd1gW7KGW6nFqpfhjx5vmZZ/TUDCPkbIANnpI29NsVfHHfkopt9UB36qV0LjlUv71
 octt9RxL4Pfuifk43xl9YomAoh/6G2VkhtlqN1nQEIFn24k3CzqUbfoKbekfLJyrDUSw
 WkKGCz/QD1L9cwL7wQRbRJOPnGmrQiZY4DHaD5nbgACEalJx9au5qwsXBFyQ4egd54zi
 bd24++v+bC5TXZOcEIM+OoF71sRAnA/IAwrPF0ARoumI4JaMWNIhHtEmVl33TjulZ/Ko
 m7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766131982; x=1766736782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=slS80YqiMsMI0H3LaNWNRpkJQfsYGbaubdXmVKdWh/w=;
 b=C/t/3yq8ubPaVrIO+7z8iR2M2P3MqeKr5RDqMVgk9O7WawjXM54yP5e8Iy3gnW6fQ1
 2QeHpBCMo4aYyP9lRcLolqzYqDr/OdvgJOpRYbmF9GB7n5C0MoMxR5D3rKf9FFCQwnW0
 gMkcuym4TkxhMmGQrfSsJGWKjvjI/UIxu/mYvIDlI6TFL0UDvyEuNc7xu9LagIi+tEnr
 l7+3kPKa67g24/1tugMbKhaaD+7ZTbCqPh9MsR4/dGOdSnxjZVKv8j2UDChyuoqF2pHl
 /f5yl1ThQACkf65tQ74ceaPiuWUSCqpdngTyEZALzU8udNuQLDvrFVx/qp/RRoSKaVWr
 WsGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK+kx5xyRoxzmtMEd/SECwSyXwbMTbB7fUHpZIUOgOrajwcjEZYAOvIfo6gaf7ALvBkmFJlKjhLwMo@nongnu.org
X-Gm-Message-State: AOJu0YyZ8ojnsRYeICSnFjSFhTH2wcJLvvPpMtbntLJoKe9Ki/yOdQxn
 zPBoQJRZUivFsTk6keSg5augWnZh8dVPai4/T/IZsJZRbtyBXLyDuMPIqP1XYhLGBqauHbOSYEn
 9l6w2ROVWD6t3+RlCNmuOcg5NN1FHWNAXnBNmeGY7p/g6qIr9YlicqqiKpCp7/WPOYtC7VX/Ajn
 jBccflwHQIuwudcOVRjCnvqJM+JXnBYag=
X-Gm-Gg: AY/fxX4/7tJqX0v+7iKFZRUiyw1mMyG7EcG63z23TJgsW85Hw3qoGwCIYpCWsgVV2rx
 +84MXCHmJdFJr0jrDrvUcOpxF4yaoW83LGPgmEyDXtWNp02W6lMi8qlIbsIrzi5T6cr52a9ss/1
 uMqcX/U7ahBnliSgmPSyrruyOYdtBdW0DOaajVPUnFFq4MxZ8Q8Ygu8Z8CHvTL49kfMYA=
X-Received: by 2002:a53:bdc5:0:b0:645:5540:2cd3 with SMTP id
 956f58d0204a3-6466a84547dmr1412352d50.3.1766131982492; 
 Fri, 19 Dec 2025 00:13:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnzYWKtvS3mzk7fXOncf49/5TGJ07P4KnYsG3c8rQ+82b/bGXuQ7zbNtY3BMHxrMF3GJLxEWkcpuHYSbMYQbs=
X-Received: by 2002:a53:bdc5:0:b0:645:5540:2cd3 with SMTP id
 956f58d0204a3-6466a84547dmr1412345d50.3.1766131982204; Fri, 19 Dec 2025
 00:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20251216015701.6601-1-wafer@jaguarmicro.com>
In-Reply-To: <20251216015701.6601-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Dec 2025 09:12:25 +0100
X-Gm-Features: AQt7F2rC6Z8JM_ZgI4_x4u__nQO4HRRuISbNv52lOHIYxMifjNKDE7OS4yg8jh4
Message-ID: <CAJaqyWe7tdPRg=cMzEytEa4jBqtQk1vCuDuwJu5Kzp-j074=QA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] vhost: SVQ get the indirect descriptors from used
 ring
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 16, 2025 at 2:57=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> w=
rote:
>
> From: wafer Xie <wafer@jaguarmicro.com>
>
> For the used ring, based on the state of the SVQ descriptor,
> if it is indirect, retrieve the corresponding indirect buffer by index
> and then increment the freeing counter.
> Once all descriptors in this buffer have been released,
> update the current buffer state to SVQ_INDIRECT_BUF_FREED.
>
> Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 43 +++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 85eff1d841..adee52f50b 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -469,12 +469,47 @@ static VirtQueueElement *vhost_svq_get_buf(VhostSha=
dowVirtqueue *svq,
>          return NULL;
>      }
>
> +    /* Check if indirect descriptors were used */
> +    int indirect_buf_idx =3D svq->desc_state[used_elem.id].indirect_buf_=
idx;
> +    bool used_indirect =3D (indirect_buf_idx >=3D 0);
> +
> +    /* Update indirect buffer state if it was used */
> +    if (used_indirect) {
> +        SVQIndirectDescBuf *buf =3D &svq->indirect_bufs[indirect_buf_idx=
];
> +        unsigned int ndescs =3D svq->desc_state[used_elem.id].ndescs;

Nitpick, we could just populate num =3D and reuse here.

> +
> +        /* Increment freeing_descs for descriptors returned from used ri=
ng */
> +        buf->freeing_descs +=3D ndescs;
> +
> +        /* Check if all descs are accounted for (freed + freeing =3D=3D =
num) */
> +        if (buf->freed_descs + buf->freeing_descs >=3D buf->num_descs) {
> +            /* Reset buffer to freed state */
> +            buf->state =3D SVQ_INDIRECT_BUF_FREED;
> +            buf->freed_descs =3D buf->num_descs;
> +            buf->freeing_descs =3D 0;
> +            buf->freed_head =3D 0;
> +        }
> +
> +        svq->desc_state[used_elem.id].indirect_buf_idx =3D -1;

Why not continue using the buffer in a circular manner?

> +    }
> +
>      num =3D svq->desc_state[used_elem.id].ndescs;
>      svq->desc_state[used_elem.id].ndescs =3D 0;
> -    last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, used_elem=
.id);
> -    svq->desc_next[last_used_chain] =3D svq->free_head;
> -    svq->free_head =3D used_elem.id;
> -    svq->num_free +=3D num;
> +
> +    /*
> +     * If using indirect descriptors, only 1 main descriptor is used.
> +     * Otherwise, we used 'num' descriptors in a chain.
> +     */
> +    if (used_indirect) {
> +        svq->desc_next[used_elem.id] =3D svq->free_head;
> +        svq->free_head =3D used_elem.id;
> +        svq->num_free +=3D 1;
> +    } else {
> +        last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, used_=
elem.id);
> +        svq->desc_next[last_used_chain] =3D svq->free_head;
> +        svq->free_head =3D used_elem.id;
> +        svq->num_free +=3D num;
> +    }

I think the two paths are equivalent if the descriptor chain length is
1 except for the num_free +=3D indirect ? num : 1, can we merge both
paths and just make it conditional?


>
>      *len =3D used_elem.len;
>      return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
> --
> 2.48.1
>


