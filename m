Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB891CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wa0-0005jt-TW; Thu, 09 Oct 2025 15:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6wZw-0005iy-SC
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:45:34 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6wZt-0003Lj-IM
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:45:32 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-4291359714eso11994845ab.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760039126; x=1760643926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJRlHVP3uqj1vYTy4oMe30QXggRfeUOYT/Y9bofSxm8=;
 b=IA9fmlQlvmmzfP71xZH5qCM2c7ksWT/CxB5DYXnb9UhBDdr5Wp3CA0sij+pwW3SshU
 goYXuOkfbQbvEANsSrhn65ikg/r4ClUln+PM5spc4aOKb28al2GcQm1xcwD0QmQw15Eg
 tpPLd4rGxMCReVb1NMDwIZO4plAsjG4Dk/xp+OKoMP9NMSlzmDM2JznYn3MH44COKHCt
 LkahIWvQIMaNWsSGydSNANpz1yoQBTQVNBAC+NGMbCgekPFupXuWQRLNzCFMMXqg49sE
 SspAiY5eQ6fRDGuVmYaVPm/ZWzmCgkcFi70IHDgSi16YYPaFbwm540nmj4rEZKD0qWDe
 KyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039126; x=1760643926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJRlHVP3uqj1vYTy4oMe30QXggRfeUOYT/Y9bofSxm8=;
 b=IUcXu6Xxb+I7jZJ97ujMJ9t1TZqHt/JLPtFAcrojTKIgJ8V6YS/sF/Qay4VciiCSWH
 OdHLCvcu2/KPIe/q65nOLl3IW5Ls2wxmtfv44j2rbU2WNWwaPOFQFhfL3iNk1Yu+2bRJ
 MZvMOiHl+vM7Uz8Uial42fFNPyUYvlq0YV/3lmWEJnC/PV9hBHSF3EXEJ3nfr9HZ6l7E
 ov9OtQaYhh1w9ZWTcx1AjSDO9vKdNZQg+SYr4NLvHujzqJEnUmFNtgx0mbOKBcKl8ap4
 G04nGXOAgBBuCONQMwRtLhpxAufN+HDUxwjKJP0pNKHwy42fNePDDYs2b0I68QUo7vQV
 7wLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuqKgFMRvqZSWuLozHKgT5c5ipsMoC/Hb8dksxeIvrFdZxXul7ReiuVXy6i32mmh8S6RyIfYLiIjbw@nongnu.org
X-Gm-Message-State: AOJu0YyWbfZN7kEwYFmJSVEpBSSIYAQZeor4ts5kCQn0XU0OQ6CyCixK
 1QZcWiJaYMMJeU//WNmaSZbYW8tXct16l8Whp/cRNJYuDDMLGVHooSoSh9DznbT3izjttbMwKMI
 6F1R/5usHnl5v65vYPqYUeL1/KCl7ZZk=
X-Gm-Gg: ASbGnctTXDaBq42Q5+IeJzCt+ysBQvvzYbX/GvownI5WGjPsLB27shA02O61my2xDzs
 bSa1ddUxH0WtcdjE+U5sgHs+Ma64gyFt5LeBl+gcJBuhLpiFbW7+7VY3Jg7UjeF9tZN3WJ6aAVJ
 IHBKIDT4lPl4qpws3qBeWS5cLJIIKihPZROUJ/ocCtOvewwpgNkzeChvm15lE0WgEjOWo1aQllJ
 5RiLcyV9w7cvIqGgTAfDQD+JlaTmBXDHZimEuudyQ==
X-Google-Smtp-Source: AGHT+IH69KLJlDj2f/0Vy2Y5RzRGuG7PQzGoiVqqcFyrCBDzjkFYc1ALNVSVHHU4VhWa+bC478F6AQkhb6dHxkD+KhY=
X-Received: by 2002:a05:6e02:2143:b0:42d:8c07:70d2 with SMTP id
 e9e14a558f8ab-42f8736905dmr98607795ab.11.1760039126150; Thu, 09 Oct 2025
 12:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-5-vsementsov@yandex-team.ru>
 <CAFubqFvSkXDgpttJLz8dtCtsbWLqfS2BRWP=UZxF81st5_Qn_g@mail.gmail.com>
 <7f24506f-2ce0-4a86-95ea-9391088fe821@yandex-team.ru>
In-Reply-To: <7f24506f-2ce0-4a86-95ea-9391088fe821@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:45:15 -0400
X-Gm-Features: AS18NWAahNv_uLqdJBiKinQEO6D0GHQ4hoWAif6SMnVjfzLUts-rAv90dUgYvnY
Message-ID: <CAFubqFvQbYfTuUFa3b4=P4zGiL=-YfDDZ+XupicP33R26h5v7w@mail.gmail.com>
Subject: Re: [PATCH 04/33] vhost: move protocol_features to vhost_user
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x135.google.com
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

On Thu, Oct 9, 2025 at 3:35=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 09.10.25 21:57, Raphael Norwitz wrote:
> > On Wed, Aug 13, 2025 at 12:57=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> As comment says: it's only for vhost-user. So, let's move it
> >> to corresponding vhost backend realization.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru=
>
> >> ---
> >>   backends/cryptodev-vhost.c        |  1 -
> >>   hw/net/vhost_net.c                |  2 --
> >>   hw/virtio/vhost-user.c            | 23 ++++++++++++++++++++---
> >>   hw/virtio/virtio-qmp.c            |  6 ++++--
> >>   include/hw/virtio/vhost-backend.h |  3 +++
> >>   include/hw/virtio/vhost.h         |  8 --------
> >>   6 files changed, 27 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> >> index 943680a23a..3bcdc494d8 100644
> >> --- a/backends/cryptodev-vhost.c
> >> +++ b/backends/cryptodev-vhost.c
> >> @@ -60,7 +60,6 @@ cryptodev_vhost_init(
> >>
> >>       crypto->cc =3D options->cc;
> >>
> >> -    crypto->dev.protocol_features =3D 0;
> >>       crypto->backend =3D -1;
> >>
> >>       /* vhost-user needs vq_index to initiate a specific queue pair *=
/
> >> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> >> index fcee279f0b..ce30b6e197 100644
> >> --- a/hw/net/vhost_net.c
> >> +++ b/hw/net/vhost_net.c
> >> @@ -260,9 +260,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *=
options)
> >>               goto fail;
> >>           }
> >>           net->backend =3D r;
> >> -        net->dev.protocol_features =3D 0;
> >>       } else {
> >> -        net->dev.protocol_features =3D 0;
> >>           net->backend =3D -1;
> >>
> >>           /* vhost-user needs vq_index to initiate a specific queue pa=
ir */
> >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >> index 6fa5b8a8bd..abdf47ee7b 100644
> >> --- a/hw/virtio/vhost-user.c
> >> +++ b/hw/virtio/vhost-user.c
> >> @@ -11,6 +11,7 @@
> >>   #include "qemu/osdep.h"
> >>   #include "qapi/error.h"
> >>   #include "hw/virtio/virtio-dmabuf.h"
> >> +#include "hw/virtio/virtio-qmp.h"
> >>   #include "hw/virtio/vhost.h"
> >>   #include "hw/virtio/virtio-crypto.h"
> >>   #include "hw/virtio/vhost-user.h"
> >> @@ -264,6 +265,14 @@ struct vhost_user {
> >>       /* Our current regions */
> >>       int num_shadow_regions;
> >>       struct vhost_memory_region shadow_regions[VHOST_USER_MAX_RAM_SLO=
TS];
> >> +
> >> +    /**
> >> +     * @protocol_features: the vhost-user protocol feature set by
> >> +     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
> >> +     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
> >> +     * by the backend (see @features).
> >> +     */
> >> +    uint64_t protocol_features;
> >>   };
> >>
> >>   struct scrub_regions {
> >> @@ -274,7 +283,8 @@ struct scrub_regions {
> >>
> >>   static bool vhost_user_has_prot(struct vhost_dev *dev, uint64_t feat=
ure)
> >>   {
> >> -    return virtio_has_feature(dev->protocol_features, feature);
> >> +    struct vhost_user *u =3D dev->opaque;
> >> +    return virtio_has_feature(u->protocol_features, feature);
> >>   }
> >>
> >>   static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMs=
g *msg)
> >> @@ -2218,8 +2228,8 @@ static int vhost_user_backend_init(struct vhost_=
dev *dev, void *opaque,
> >>           }
> >>
> >>           /* final set of protocol features */
> >> -        dev->protocol_features =3D protocol_features;
> >> -        err =3D vhost_user_set_protocol_features(dev, dev->protocol_f=
eatures);
> >> +        u->protocol_features =3D protocol_features;
> >> +        err =3D vhost_user_set_protocol_features(dev, u->protocol_fea=
tures);
> >>           if (err < 0) {
> >>               error_setg_errno(errp, EPROTO, "vhost_backend_init faile=
d");
> >>               return -EPROTO;
> >> @@ -3001,6 +3011,12 @@ static int vhost_user_check_device_state(struct=
 vhost_dev *dev, Error **errp)
> >>       return 0;
> >>   }
> >>
> >> +static void vhost_user_qmp_status(struct vhost_dev *dev, VhostStatus =
*status)
> >> +{
> >> +    struct vhost_user *u =3D dev->opaque;
> >> +    status->protocol_features =3D qmp_decode_protocols(u->protocol_fe=
atures);
> >> +}
> >> +
> >>   const VhostOps user_ops =3D {
> >>           .backend_type =3D VHOST_BACKEND_TYPE_USER,
> >>           .vhost_backend_init =3D vhost_user_backend_init,
> >> @@ -3041,4 +3057,5 @@ const VhostOps user_ops =3D {
> >>           .vhost_supports_device_state =3D vhost_user_supports_device_=
state,
> >>           .vhost_set_device_state_fd =3D vhost_user_set_device_state_f=
d,
> >>           .vhost_check_device_state =3D vhost_user_check_device_state,
> >> +        .vhost_qmp_status =3D vhost_user_qmp_status,
> >>   };
> >> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> >> index e514a4797e..d55b12f9f3 100644
> >> --- a/hw/virtio/virtio-qmp.c
> >> +++ b/hw/virtio/virtio-qmp.c
> >> @@ -788,12 +788,14 @@ VirtioStatus *qmp_x_query_virtio_status(const ch=
ar *path, Error **errp)
> >>               qmp_decode_features(vdev->device_id, hdev->features);
> >>           status->vhost_dev->acked_features =3D
> >>               qmp_decode_features(vdev->device_id, hdev->acked_feature=
s);
> >> -        status->vhost_dev->protocol_features =3D
> >> -            qmp_decode_protocols(hdev->protocol_features);
> >>           status->vhost_dev->max_queues =3D hdev->max_queues;
> >>           status->vhost_dev->backend_cap =3D hdev->backend_cap;
> >>           status->vhost_dev->log_enabled =3D hdev->log_enabled;
> >>           status->vhost_dev->log_size =3D hdev->log_size;
> >> +
> >> +        if (hdev->vhost_ops->vhost_qmp_status) {
> >> +            hdev->vhost_ops->vhost_qmp_status(hdev, status->vhost_dev=
);
> >> +        }
> >
> > Same comment as patch 1/33 - why have it in vhost_ops if it is
> > vhost_user specific, rather than checking the backend type and calling
> > a helper?
> >
>
> Aha, I think now, I undestand you correctly in 1/33.
>
> No specific reason, but a try to keep generic code backend-agnostic, with=
out
> knowledge about specific backends.
>
> Not a problem for me to swith to "if (backend_type =3D=3D ", if it's pref=
erable
> in this case.
>

Yes, that is what I meant. I think it makes the code more readable but
if others disagree we can leave it.

> >
> >>       }
> >>
> >>       return status;
> >> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vho=
st-backend.h
> >> index f65fa26298..0785fc764d 100644
> >> --- a/include/hw/virtio/vhost-backend.h
> >> +++ b/include/hw/virtio/vhost-backend.h
> >> @@ -12,6 +12,7 @@
> >>   #define VHOST_BACKEND_H
> >>
> >>   #include "system/memory.h"
> >> +#include "qapi/qapi-commands-virtio.h"
> >>
> >>   typedef enum VhostBackendType {
> >>       VHOST_BACKEND_TYPE_NONE =3D 0,
> >> @@ -160,6 +161,7 @@ typedef int (*vhost_set_device_state_fd_op)(struct=
 vhost_dev *dev,
> >>                                               int *reply_fd,
> >>                                               Error **errp);
> >>   typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Er=
ror **errp);
> >> +typedef void (*vhost_qmp_status_op)(struct vhost_dev *dev, VhostStatu=
s *status);
> >>
> >>   typedef struct VhostOps {
> >>       VhostBackendType backend_type;
> >> @@ -216,6 +218,7 @@ typedef struct VhostOps {
> >>       vhost_supports_device_state_op vhost_supports_device_state;
> >>       vhost_set_device_state_fd_op vhost_set_device_state_fd;
> >>       vhost_check_device_state_op vhost_check_device_state;
> >> +    vhost_qmp_status_op vhost_qmp_status;
> >>   } VhostOps;
> >>
> >>   int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> >> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> >> index 9f9dd2d46d..15bc287a9d 100644
> >> --- a/include/hw/virtio/vhost.h
> >> +++ b/include/hw/virtio/vhost.h
> >> @@ -104,14 +104,6 @@ struct vhost_dev {
> >>       uint64_t features;
> >>       uint64_t acked_features;
> >>
> >> -    /**
> >> -     * @protocol_features: is the vhost-user only feature set by
> >> -     * VHOST_USER_SET_PROTOCOL_FEATURES. Protocol features are only
> >> -     * negotiated if VHOST_USER_F_PROTOCOL_FEATURES has been offered
> >> -     * by the backend (see @features).
> >> -     */
> >> -    uint64_t protocol_features;
> >> -
> >>       uint64_t max_queues;
> >>       uint64_t backend_cap;
> >>       /* @started: is the vhost device started? */
> >> --
> >> 2.48.1
> >>
> >>
>
>
> --
> Best regards,
> Vladimir

