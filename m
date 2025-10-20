Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BA3CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzTI-0007FA-K4; Mon, 20 Oct 2025 19:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzTG-0007DB-AH
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:39:22 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzTE-0001VW-9j
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:39:21 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-940276d224dso244703039f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761003558; x=1761608358; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwrEyTPEnTrGScUv80u1JSfh+WEEiM/bAxoY9n77o2o=;
 b=Z/9UnMl0R+hQ1DVMl2hGWakVtiGr4ebeXSkBfjGCABmG6cwwCcOprnxwSn8+IwaOM/
 YML/2wA3SQtD2q8clG9JM70g+s+tvSbG32lgz7Rr0X+t7KH5gQTEwY+0XSoxP+2fd9sc
 gdYBw2iEwu4rkt1yjSyle7y2eMjhNoUUU6V5T4lh85bJl3OqsM8VRvryE+Q1sKGWo7zy
 aI4bOdki8gGNNK614n6hEyd7cEOf6/N2Ajwv+Gr4Yq1XXMw0/fr3ocQzB4+yBZHag0yZ
 CKCbPI0L9o1NThnsTr3jQPl4DgCVE9rlqG4r5SGIq3rxBQm+7xUfKlsppMyE4e2BVzDn
 +O+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003558; x=1761608358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwrEyTPEnTrGScUv80u1JSfh+WEEiM/bAxoY9n77o2o=;
 b=nO+5AoS1jBHdIhj5lWf04/jcmofmgHst8VRkezcogz4PkVK0CSCxvLbD3GEPJ+45d2
 Px1jSQn9LWU7HEgFnSlwTNc5tcb7SYPXH0xonrcevmvNZfCA+0SuDatb1dOd3/+JZWgS
 zdCB3Xi4Nh04v/OfmcfLM9LdWwxwY/taT7cMCMoAQY9I/x13y1jOacLE+Eu1B1pXFK7p
 VtPxwre1WcmY1mD+Af0O0UYPHRhZ0g5S+4aBOhu3bsvUHkm0wdVBuximb4Zp+JQF8ThT
 DKx7eQsxlVsreld6zD49nSCQDwBkFNFo4BalUQVAdZlAnw3jxhVpIECi1IS2E5JDpO7D
 y0pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+t/buhfZm4VIQhGOPI2CQ3OAPUXOzvPZF9j+w0AX2NMx11UpMHdyXwisE+dFoUp2QCfb2wOabnjV2@nongnu.org
X-Gm-Message-State: AOJu0YzuL30W4962Dco83Sw/0wDPjS/fvY2WW9M92nHbSsAcVCI+yhvv
 MNHSiqsKFXnU0LOhqBb7m9OU79qPPD9UzblAG3NHYx6sokNSp5KgAR32lLtpb0KN4VIaTcgD5dA
 nZQYcuP17f8Au+30XJmu8cNRWlh1UKMs=
X-Gm-Gg: ASbGncs7gjxhoWyqd3GjwEuRs0A7sqSTV/WU8SXpzROakKO8Vl+Lwb3MR26PVXO3iBb
 l0vZpXik1Uxc9lpcM3OHQup0qneq2laYcPl+7xuW4HY10bp4LFM/lcmbBjPJTSaUZq38a75lWjU
 tB8PHWhXYSu1zyPzZsldBVW4YbwmIW0gVL0o6abmQoVT0hJ+I7CLPnG6TOLfBj+shNuTmE3+Qdd
 IsEOvlaU9fqDTth9dsqmiYD4eiek6GpYwC58DRe8ej52BQKCcZEnktk/3Rr
X-Google-Smtp-Source: AGHT+IGE/VijscIX2yU4QN64saSBnwzr0T3znZv3o9y4fXkEV655foNcB6XkGtIS6aBcgKN5vLg4OPs1fkWBA2kHIgs=
X-Received: by 2002:a05:6e02:148d:b0:430:b167:3604 with SMTP id
 e9e14a558f8ab-430c5209bafmr227864965ab.4.1761003557773; Mon, 20 Oct 2025
 16:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-18-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-18-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:39:06 -0400
X-Gm-Features: AS18NWAQSimpp3wWAu_gmzV4zIAPNWX_U_DpM6GJvt-zstNlqqNpJESEdamOh1s
Message-ID: <CAFubqFt0GWOUAJGU1xxv9zi-FDODqHoa1bho8n5o_OAxF3zkww@mail.gmail.com>
Subject: Re: [PATCH v2 17/25] vhost: add inflight region backend-transfer
 vmstate
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>


On Thu, Oct 16, 2025 at 7:49=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Prepare for future backend-transfer migration of vhost-user-blk.
> Among other things we'll need to transfer the inflight region, let's
> prepare for this.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c         | 26 ++++++++++++++++++++++++++
>  include/hw/virtio/vhost.h |  5 +++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 3e5192ec23..63036f8214 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1975,6 +1975,32 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>      }
>  }
>
> +static int vhost_inflight_backend_transfer_post_load(void *opaque,
> +                                                     int version_id)
> +{
> +    struct vhost_inflight *inflight =3D opaque;
> +
> +    inflight->addr =3D mmap(0, inflight->size, PROT_READ | PROT_WRITE,
> +                             MAP_SHARED, inflight->fd, inflight->offset)=
;
> +    if (inflight->addr =3D=3D MAP_FAILED) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_backend_transfer_vhost_inflight =3D {
> +    .name =3D "vhost-inflight",
> +    .post_load =3D vhost_inflight_backend_transfer_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_FD(fd, struct vhost_inflight),
> +        VMSTATE_UINT64(size, struct vhost_inflight),
> +        VMSTATE_UINT64(offset, struct vhost_inflight),
> +        VMSTATE_UINT16(queue_size, struct vhost_inflight),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bi=
ts,
>                             const uint64_t *features)
>  {
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index af46d4b5f2..94a0c75fc8 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -587,4 +587,9 @@ static inline int vhost_load_backend_state(struct vho=
st_dev *dev, QEMUFile *f,
>  }
>  #endif
>
> +extern const VMStateDescription vmstate_backend_transfer_vhost_inflight;
> +#define VMSTATE_BACKEND_TRANSFER_VHOST_INFLIGHT(_field, _state) \
> +    VMSTATE_STRUCT_POINTER(_field, _state, vmstate_inflight, \
> +                           struct vhost_inflight)
> +
>  #endif
> --
> 2.48.1
>
>

