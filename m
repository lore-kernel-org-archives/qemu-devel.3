Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A168CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzf2-0001WT-TB; Mon, 20 Oct 2025 19:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzf0-0001WC-TI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:51:30 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzez-0002qu-5n
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:51:30 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-430ab5ee3e7so17309055ab.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761004288; x=1761609088; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMpDmskLppr6F+e3fDW5G4tmsS3etKL6PdgZ83CdD6k=;
 b=A9Y74LYZAm8nAxCsgcKIUswJB/oXLcwOdPmGFEBbzpGu+w79q7W4qev+kRUVFo+TN3
 3BeevlBc89zNJ1ZtrHt3TQnzkIC37sJYlqH7ek6T54D2hpnfYQqZrar+cM3nPPE2g/4u
 NWyLTcf+BwNeeJppSQcaB2JCbLH8ihi9cNUPhmL9qBuKtjDvQVBTRy2gQdUpTSHYzsnS
 loquSP6TgIG0/suUqvc3af1oKkajh/YWdaamigOYVQtBkMnRBEwpbfz3f2y9ljRM08gQ
 svPl6i4UMHFtVsIzQnOK9w59mmlmSi6Pnkazrsejgh21nprP3Mc7XVMm6OKwa46nEfeg
 4LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761004288; x=1761609088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMpDmskLppr6F+e3fDW5G4tmsS3etKL6PdgZ83CdD6k=;
 b=h/Q/lBRvefvxQ06DmKBgFJ29eOL/ovvkfDemY74tLaTLPa0/oRWTZMTFMEmdtt75Xy
 vAPU3RjjCl16j3x64vzZtx84yf2dJ542wmgE1jn/drmbqWqPdMl3GlGNTg3DOLJWaLJY
 MSAUsGuU/q4n9nvDowL062Z7Z/v1rl2bK9Uf0xjf0TAvTWcdGPWrz/MFMQv7Y1eZ9fn6
 3huDumMdx31hIstbMQJ3p4uHy036EITymXy6gieRHGUOjHB+2Y4mILHSf98HwXoscB9E
 WAG52cGeIABLiYibdJji151cZlLxfNmCznFms2laQsqFXVIi7fR0p8HsAStxD0dsZ6FH
 qzYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtkGjKKuNFWypApt6FiF1EB7Jsl4ZOYyLWiOENssBpZtoD2NICH9/lmdVps7dmO2hpdMS5MhUvN0Oj@nongnu.org
X-Gm-Message-State: AOJu0Yw446OFGCxDGvEQ5IF/GjwcJDpG7X24CdTzb7m5KSQz8nYLrSFE
 BfeFoDfLR7Mlh+rox7myL4h64F7NIO7aACBMDSgwCgzF04TToQMKvk8G208aCfwSJhf8T7tlA4c
 SRFM11OtqRmrOrREwLSry3V6Ti4C+Aoo=
X-Gm-Gg: ASbGnct7m3sv/axHK1Uf6HAfBUBgsHejKnnIS0ZpzTWG56fvSILNLfJWzd24Q65NB4G
 ddJFNPyDvNh6KB2koQ8MYn/Lxuu2GFfBHY2y64GwStC54jHyCip++7ZZ0w1GWDNFok2Qjg5Il7S
 hE8jDalH5Xc6pBhvDsai0FSkNeM/e9GaX076Ry0R7aoW/b6Y+wb4Zy8e7jNNXfMmFxAfcLz1zsL
 0cof+EnBSFBYsCthHzjni6t38mBSWyIcPDT4Yebgi9Fzzm/hvtM5H2REWap
X-Google-Smtp-Source: AGHT+IFHAGsjkfJp69GfBxFtdnu37/+rJSxoe5uNkxFfToWfwVIWHII/jLO5fIPj+1vVbtOjmbA7YhjYyfHhp/suzlI=
X-Received: by 2002:a05:6e02:1c01:b0:430:a6b9:e976 with SMTP id
 e9e14a558f8ab-430c52b5a7dmr192473595ab.19.1761004287694; Mon, 20 Oct 2025
 16:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-21-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-21-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:51:17 -0400
X-Gm-Features: AS18NWDOUUZNLe43h8tMHhyGGbpB7NntS7irrYVi_MerSGJXK8axHwQWDmrkrRM
Message-ID: <CAFubqFsLqnHc1tm5B0PCFcDsRgzifB-6aX+UK4F6NfC_W-FE8g@mail.gmail.com>
Subject: Re: [PATCH v2 20/25] vhost-user: add vmstate
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For now a naming nit and a question.

On Thu, Oct 16, 2025 at 7:44=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c         | 95 ++++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost-user.h |  4 ++
>  2 files changed, 99 insertions(+)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index c5cb5ed528..a820214188 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -28,6 +28,8 @@
>  #include "system/runstate.h"
>  #include "system/cryptodev.h"
>  #include "migration/postcopy-ram.h"
> +#include "migration/qemu-file-types.h"
> +#include "migration/qemu-file.h"
>  #include "trace.h"
>  #include "system/ramblock.h"
>
> @@ -3137,6 +3139,99 @@ void vhost_user_qmp_status(struct vhost_dev *dev, =
VirtioStatus *status)
>          qmp_decode_protocols(u->protocol_features);
>  }
>
> +typedef struct VhostUserMigTmp {
> +    struct vhost_dev *parent;
> +    bool has_backend_channel;
> +    int backend_fd;
> +    uint32_t memory_slots;
> +    uint64_t protocol_features;
> +} VhostUserMigTmp;
> +
> +static int vhost_user_tmp_pre_save(void *opaque)
> +{
> +    VhostUserMigTmp *tmp =3D opaque;
> +    struct vhost_dev *dev =3D tmp->parent;
> +    struct vhost_user *u =3D dev->opaque;
> +    QIOChannelSocket *sioc =3D u->backend_sioc;
> +
> +    if (sioc && sioc->fd < 0) {
> +        return -EINVAL;
> +    }
> +
> +    tmp->backend_fd =3D sioc ? sioc->fd : -1;
> +    tmp->has_backend_channel =3D !!sioc;
> +    tmp->memory_slots =3D u->user->memory_slots;
> +    tmp->protocol_features =3D u->protocol_features;
> +
> +    return 0;
> +}
> +
> +static int vhost_user_tmp_post_load(void *opaque, int version_id)
> +{
> +    struct VhostUserMigTmp *tmp =3D opaque;
> +    struct vhost_dev *dev =3D tmp->parent;
> +    struct vhost_user *u =3D dev->opaque;
> +    Error *local_err =3D NULL;
> +
> +    if (tmp->has_backend_channel) {
> +        u->backend_sioc =3D qio_channel_socket_new_fd(tmp->backend_fd,
> +                                                    &local_err);
> +        if (!u->backend_sioc) {
> +            error_report_err(local_err);
> +            return -EINVAL;
> +        }
> +        u->backend_src =3D qio_channel_add_watch_source(
> +            QIO_CHANNEL(u->backend_sioc), G_IO_IN | G_IO_HUP,
> +            backend_read, u->dev, NULL, NULL);
> +    }
> +
> +    u->user->memory_slots =3D tmp->memory_slots;
> +    u->protocol_features =3D tmp->protocol_features;
> +
> +    return 0;
> +}
> +
> +static bool vhost_user_tmp_test_fd(void *opaque, int version_id)
> +{
> +    struct VhostUserMigTmp *tmp =3D opaque;
> +
> +    return tmp->has_backend_channel;
> +}
> +

Will this be vhost-user-blk specific? It should probably be something
like vhost_user_backend_transfer_tmp?

> +static const VMStateDescription vmstate_vhost_user_blk_tmp =3D {
> +    .name =3D "vhost-user-blk-tmp",
> +    .pre_save =3D vhost_user_tmp_pre_save,
> +    .post_load =3D vhost_user_tmp_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT64(protocol_features, VhostUserMigTmp),
> +        VMSTATE_UINT32(memory_slots, VhostUserMigTmp),
> +        VMSTATE_BOOL(has_backend_channel, VhostUserMigTmp),
> +        VMSTATE_FD_TEST(backend_fd, VhostUserMigTmp, vhost_user_tmp_test=
_fd),
> +        VMSTATE_END_OF_LIST()
> +   },
> +};
> +
> +static int vhost_user_post_load(void *opaque, int version_id)
> +{
> +    struct vhost_dev *dev =3D opaque;
> +    struct vhost_user *u =3D dev->opaque;
> +
> +    u->postcopy_notifier.notify =3D vhost_user_postcopy_notifier;
> +    postcopy_add_notifier(&u->postcopy_notifier);
> +
> +    return 0;
> +}
> +

Why do we need a second post_load() callback here? Why can't
u->postcopy_notifier.notify be set in vhost_user_tmp_post_load()?


> +const VMStateDescription vmstate_vhost_user =3D {
> +    .name =3D "vhost-user",
> +    .post_load =3D vhost_user_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_WITH_TMP(struct vhost_dev, VhostUserMigTmp,
> +                         vmstate_vhost_user_blk_tmp),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_backend_init,
> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index 36d96296a3..fb89268de2 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -114,4 +114,8 @@ void vhost_user_async_close(DeviceState *d,
>
>  void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status);
>
> +extern const VMStateDescription vmstate_vhost_user;
> +#define VMSTATE_BACKEND_TRANSFER_VHOST_USER(_field, _state) \
> +    VMSTATE_STRUCT(_field, _state, 0, vmstate_vhost_user, struct vhost_d=
ev)
> +
>  #endif
> --
> 2.48.1
>
>

