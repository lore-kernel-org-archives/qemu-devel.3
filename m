Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884C9D1D899
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4vS-00086U-Bw; Thu, 04 Dec 2025 03:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vR4vQ-00081A-KH
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:42:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vR4vP-00075d-8T
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764837774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsGvHs1YS80jgVqbEAm8V4e3iVfaYSj/AVium/TnLZs=;
 b=AMnzRO/s73rdZZAJMoRwptUotj7/8YQKdZrDnFf/AalZJwuVigMgqKF7Wut/yeTDKZv9uA
 IcgvxJ35Ka4rPpwo1oraR8tIwrp/9AwLDUtvUZw1KnB77NtDSDj7lQ94USnppBM5leIKQ8
 i5qtT+S/C7Drwcip5p9m90XOs6DIg9o=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-NaG0wa3oOKmgf6_qFxoxFw-1; Thu, 04 Dec 2025 03:42:52 -0500
X-MC-Unique: NaG0wa3oOKmgf6_qFxoxFw-1
X-Mimecast-MFC-AGG-ID: NaG0wa3oOKmgf6_qFxoxFw_1764837772
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-787cf398a53so7927977b3.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764837772; x=1765442572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsGvHs1YS80jgVqbEAm8V4e3iVfaYSj/AVium/TnLZs=;
 b=RE55XunUKsDNxJCUnC9yjUj5SrRdgMg7nUhyKLTjVq9uHpBGX1oqvYk4clZ06bh0Ow
 u1lavuveBnEolZw8sXdQRZgqL5n1UdwQ1lGGr7MEx78rngPg0pMhs+4j9/zJaaOK609y
 90hEUn4E9ZVOqUZ+dGh1PGN4XCxWJ65NwpYMcu1ueLh3suNauN11MBAsNLm1mZPK2QZt
 FoqLJZk1y9yOq+wDlPVkJwodjbfDO66E/cd6vCzEo1rPfUBEa9ntQV+XIexJIyIWCEVb
 MuK2FdG7n0XuEVYzWzlV7VJJ7uHZYhZ0BcCFJ+xzexkKedoPz/wP1NUz/1YHsy1Wv5Fu
 hA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837772; x=1765442572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EsGvHs1YS80jgVqbEAm8V4e3iVfaYSj/AVium/TnLZs=;
 b=m+DlS9L8HzrTKAVZZivOgwo9mJf11W4I7Rb3ZK4kZOsJ9OYMzSWBvQiT5zZT//XI1q
 3glXGCH6rKlY1ksg8mLfBmNCVAU2r5ykFeqYWBpC0edwjmZ9cViXjTBXlT6+4l3xgEeZ
 +cIIMGMcPWww1TWIJNM7TBNP2Fgf0Dk26GHsFUPm+kck1R3AhTsrcB3aYEy5PhLiGIXI
 TvDKN1wa07dDYBKqn59Wxga/n6yYInTnVxtdMZXyE8ebyRyjEN0QM3ESJbBMrJfZJA5+
 dntPCvjB0ofBdbTN1FjWnvp0bfwdkVnqcqybN/JqWnLTBRwSsfu27wd9B1BWPflwxYcF
 toXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Vwj0n+U/S5x5DGXu6cH5H3ux/YrPfFQwmM25voZGJmfhsDTp7Dnckc73Dfjzh1Mui/8l3C1SBpIT@nongnu.org
X-Gm-Message-State: AOJu0YxTVTWN8OTHPMydsngiep55BAbJEKHdlUyu0x1NxVsv/uVcf8qf
 VvzHCaC8nclbrude8nh/C1BltJ18Y5JiQ3kKzXXZU5JJ8rBw7gnKTLUe0nTK4HlhNAqxrVT4C21
 CLoMHdTcpyJW+oONaNZOtHJO0dL2/lKXtIrGDunpJS/1OcOfKjButLaUOx2CudZZkDIJPsidfRg
 mJAXrGQIjPVaxzlXuzgFbowBZ5xeyBVC4=
X-Gm-Gg: ASbGncsUQ5khjBp+mDyBM880Kf+VGVYNqOBXsJW2O9pIWi+0M1jfJIHKAAcGGGjT5yk
 H3WLlHI+33hP9HVj8maoCLrXkQcSwiZBmUuNenlYv65DeS1zmZzY6z/E1mPlrEYl34xFS6SpC4h
 UjL1pGz9LrlPsTv2hCTnktsNLYl2VwkHcB7GyKCK/1+edCX0vyKAOT2siK+ET9qSgnb0s=
X-Received: by 2002:a05:690c:6e03:b0:788:17c5:4459 with SMTP id
 00721157ae682-78c0c1b3612mr44488547b3.58.1764837771973; 
 Thu, 04 Dec 2025 00:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFENZdkDWOUZuFj1PaguxziutlHkZioYE90PO+4n9c28DrCuMPpblQiBaja+q2MJ8PUuDvumXOL298SU4Rqa6I=
X-Received: by 2002:a05:690c:6e03:b0:788:17c5:4459 with SMTP id
 00721157ae682-78c0c1b3612mr44488367b3.58.1764837771670; Thu, 04 Dec 2025
 00:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20251204074416.9350-1-wafer@jaguarmicro.com>
In-Reply-To: <20251204074416.9350-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 4 Dec 2025 09:42:15 +0100
X-Gm-Features: AWmQ_bnBbnWE0sgSzUOeIJzflTmxOITWa6mUqwTH7NYWvf7VOZ6rRDpwx4ZnCZI
Message-ID: <CAJaqyWfWOzZ9VHj8tro24QfAmOUw0GACCxxAyczpt+Qpqb-i6w@mail.gmail.com>
Subject: Re: [PATCH 4/4] vhost: supported the virtio indirect desc of used ring
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Dec 4, 2025 at 8:45=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> wr=
ote:
>
> Retrieve the used ring buffers in the indirect descriptor area
> of split shadow virtqueues.
>

This needs to be squashed with the previous patch. Otherwise, we are
allocating & mapping on each indirect descriptor but not freeing &
unmapping.

> Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 36 ++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 94ad5c3a57..0ffb884196 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -636,12 +636,40 @@ static VirtQueueElement *vhost_svq_get_buf(VhostSha=
dowVirtqueue *svq,
>          return NULL;
>      }
>
> +    bool used_indirect =3D (svq->desc_state[used_elem.id].indirect_desc =
!=3D NULL);
> +
> +    /* Free indirect descriptor table if it was used */
> +    if (used_indirect) {
> +        if (svq->indirect_ops && svq->indirect_ops->free) {
> +            svq->indirect_ops->free(svq,
> +                                    svq->desc_state[used_elem.id].indire=
ct_desc,
> +                                    svq->desc_state[used_elem.id].indire=
ct_iova,
> +                                    svq->desc_state[used_elem.id].indire=
ct_size,
> +                                    svq->indirect_ops->opaque);
> +        }
> +        svq->desc_state[used_elem.id].indirect_desc =3D NULL;
> +        svq->desc_state[used_elem.id].indirect_iova =3D 0;
> +        svq->desc_state[used_elem.id].indirect_size =3D 0;
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
> +     * To maintain consistency with `add split`,
> +     * we used 'num' as free descriptors.
> +     */
> +    if (used_indirect) {
> +        svq->desc_next[used_elem.id] =3D svq->free_head;
> +        svq->free_head =3D used_elem.id;
> +        svq->num_free +=3D num;
> +    } else {
> +        last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, used_=
elem.id);
> +        svq->desc_next[last_used_chain] =3D svq->free_head;
> +        svq->free_head =3D used_elem.id;
> +        svq->num_free +=3D num;
> +    }
>
>      *len =3D used_elem.len;
>      return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
> --
> 2.34.1
>


