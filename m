Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81575CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzAv-0005tF-Vl; Mon, 20 Oct 2025 19:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzAu-0005t4-LI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:20:24 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vAzAq-0007XK-GF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:20:24 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-93e871dbe94so279286139f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761002417; x=1761607217; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcRuxB7BFbTkuNwyukQvNeIqPVv/XDCFAmnD9HuVGf8=;
 b=bp6edTqInkRTMzvOhB9sWPO64V+x698OaPIP2CfLUpz5X4VsRBC+MXEutr4z5l6ZWz
 Fr4Cr0ce1e1ydoxjRCaDxXpQrzirhjIyJla90+TgevRpsO20h+V7h9f/lNF4epXQyItM
 8jnioZcFPDq/RgTf5ZOKc6YASFEmRrXVwpkdSmp17Ruaqmskhnds4nwQJfZPpwqYC8hH
 YCK1S3ZGL9/DFi9gTk3MzBjco7OiH0H9wCldZzIE1uMOLC9GtsX/FdIeu4YfrNv++k+M
 3/PHEcXJ/foIfBG13DDkdNxa0m0MT/yTLmN+RD1ufi3S0Y+jPqc5CkH1S8jMRwnbT9fO
 zg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002417; x=1761607217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcRuxB7BFbTkuNwyukQvNeIqPVv/XDCFAmnD9HuVGf8=;
 b=jb9JtmPX0yaXKsY7VrRw9ole8S3vLnCllvPqTgoor4afzuZtuabNzbaAHCIVygRF7h
 pqJm5nhCz1rDjoGxgJ0BSerdho/wXKmRaJ/qHlR39Skzdu5hrp47nekBGVmU4beJx3+O
 E4XLXd6WqjmtygLeV5lTOqEirdTbiSzkUQxRwpnirg4kpU0IjPI4foSo2Bpj48vTG8zj
 IOtVnxN9oz0J+KHRJPIct7L5L/cVdL9XjGq7Lw5hDF2FqykZhfwFD/x22xFrGhHhiWVy
 uQkZA/JrNd3x7JOHZTWkIp7yRZ+iKHZiMDdSgV65FutF5PLJUKSwShPCnE/mHyAkKn7G
 cmew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrdfgCy0KDmw5nZ+86X3Tjgi+yLYBV7GNy0x/Y5sbFxLq8av5ePubQGdbqT9PixkxctoqxKPdGKOpp@nongnu.org
X-Gm-Message-State: AOJu0Yw3vUYOiWSAKXOyuFslNdk/4Dnfh9jcKS5dJxVcDBDdAhEoTgKD
 ZVBProhh9F09WFtPTsllnVYwxb1/ifK9trV6BqEIHrA/9aS5QcIIaXD6xVKPEouglOWNXrtwM0G
 j5VUb+lCMpg80UWMmpyj4XS7BY7YyY84=
X-Gm-Gg: ASbGncs/5ztVUXdDtnIkrGUwTBXt/oniWxBzAtZtsY/qghhz+jog/HU/g0JCTF6EwBp
 9qfHXj/vmGMvgjKCljSXbdhOXyGfqo+fTuOBy9DZjGRI8NQrMqigOGUUN3DkDZxP0RgFHkwQ0fY
 JL4XMuhvJlYKlXOuaAziSjCIz3/5LOSMEZJIc8TM2OkHZnMaLg7ImhzHq6MFA9qjwf5KRtf2rTu
 kUBrC4KhoMKaI0eI5q4EPfv2nP+902lbAOlfVMRIE6YpvzZxsj676r1BXrmEKxudRh0Rl4=
X-Google-Smtp-Source: AGHT+IHnKbGUCf+XFp7VspVAeNdoU/G15aC6ghBVr+XwZ6SWri0iXskyRlADb4YVAMEJuB7qftj+joEAJewZUrWMCvc=
X-Received: by 2002:a05:6e02:1a66:b0:42d:8acf:a6e2 with SMTP id
 e9e14a558f8ab-430c5269283mr247280615ab.15.1761002417353; Mon, 20 Oct 2025
 16:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-5-vsementsov@yandex-team.ru>
In-Reply-To: <20251016114104.1384675-5-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 20 Oct 2025 19:20:05 -0400
X-Gm-Features: AS18NWCPpz2Hv9lG-gko4pjj75d6WpU2AjulZdk3cbbWB_AIHWvUySv2hLZnIIo
Message-ID: <CAFubqFuFkxWM5PNuX_p3=j-K6fXvhRWhvo7tr3yWL=HAyhY0pg@mail.gmail.com>
Subject: Re: [PATCH v2 04/25] vhost: add connect parameter to vhost_dev_init()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de, 
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 jasowang@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 "reviewer:vhost-user-scmi" <mzamazal@redhat.com>, 
 "open list:virtiofs" <virtio-fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd33.google.com
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

Looks ok, just a comment typo which is deleted in a subsequent commit.

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Thu, Oct 16, 2025 at 7:47=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We are going to split vhost_dev_init() so that the first part will do
> early initialization of QEMU structures, but don't communicate with
> backend, and the second part will do backend communication. We need
> this for future support for backend-transfer migration support for
> vhost-user-blk (backend will not be available in the early
> initialization point).
>
> With this commit we introduce boolean parameter for vhost_dev_init(),
> so callers may chose, do they want "init + connect" (which is current
> behavior, so all callers pass true), or caller may want "only init",
> and call vhost_dev_connect() later. vhost_dev_connect(), as well
> as support for connect=3Dfalse will be added in further commits.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/cryptodev-vhost.c        |  2 +-
>  backends/vhost-user.c             |  2 +-
>  hw/block/vhost-user-blk.c         |  2 +-
>  hw/net/vhost_net.c                |  2 +-
>  hw/scsi/vhost-scsi.c              |  2 +-
>  hw/scsi/vhost-user-scsi.c         |  2 +-
>  hw/virtio/vdpa-dev.c              |  3 ++-
>  hw/virtio/vhost-user-base.c       |  2 +-
>  hw/virtio/vhost-user-fs.c         |  2 +-
>  hw/virtio/vhost-user-scmi.c       |  2 +-
>  hw/virtio/vhost-user-vsock.c      |  2 +-
>  hw/virtio/vhost-vsock.c           |  2 +-
>  hw/virtio/vhost.c                 | 11 ++++++++++-
>  include/hw/virtio/vhost-backend.h |  2 ++
>  include/hw/virtio/vhost.h         |  3 ++-
>  15 files changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> index c6069f4e5b..b4dafb4062 100644
> --- a/backends/cryptodev-vhost.c
> +++ b/backends/cryptodev-vhost.c
> @@ -66,7 +66,7 @@ cryptodev_vhost_init(
>      crypto->dev.vq_index =3D crypto->cc->queue_index * crypto->dev.nvqs;
>
>      r =3D vhost_dev_init(&crypto->dev, options->opaque, options->backend=
_type, 0,
> -                       &local_err);
> +                       true, &local_err);
>      if (r < 0) {
>          error_report_err(local_err);
>          goto fail;
> diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> index 42845329e7..e65ba7b648 100644
> --- a/backends/vhost-user.c
> +++ b/backends/vhost-user.c
> @@ -37,7 +37,7 @@ vhost_user_backend_dev_init(VhostUserBackend *b, VirtIO=
Device *vdev,
>      b->dev.vqs =3D g_new0(struct vhost_virtqueue, nvqs);
>
>      ret =3D vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0,
> -                         errp);
> +                         true, errp);
>      if (ret < 0) {
>          return -1;
>      }
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index a5daed4346..a92426f18c 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -365,7 +365,7 @@ static int vhost_user_blk_connect(DeviceState *dev, E=
rror **errp)
>
>      s->vhost_user.supports_config =3D true;
>      ret =3D vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_U=
SER, 0,
> -                         errp);
> +                         true, errp);
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 323d117735..c4526974fb 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -274,7 +274,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *opt=
ions)
>
>      r =3D vhost_dev_init(&net->dev, options->opaque,
>                         options->backend_type, options->busyloop_timeout,
> -                       &local_err);
> +                       true, &local_err);
>      if (r < 0) {
>          error_report_err(local_err);
>          goto fail;
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index d694a25fe2..d187c705d8 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -278,7 +278,7 @@ static void vhost_scsi_realize(DeviceState *dev, Erro=
r **errp)
>      vsc->dev.vq_index =3D 0;
>
>      ret =3D vhost_dev_init(&vsc->dev, (void *)(uintptr_t)vhostfd,
> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
> +                         VHOST_BACKEND_TYPE_KERNEL, 0, true, errp);
>      if (ret < 0) {
>          /*
>           * vhost_dev_init calls vhost_dev_cleanup on error, which closes
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 0c80a271d8..e121f2e259 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -161,7 +161,7 @@ static int vhost_user_scsi_connect(DeviceState *dev, =
Error **errp)
>      vsc->dev.vq_index =3D 0;
>
>      ret =3D vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE=
_USER, 0,
> -                         errp);
> +                         true, errp);
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index e1a2ff433d..b6b4ee7d38 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -116,7 +116,8 @@ static void vhost_vdpa_device_realize(DeviceState *de=
v, Error **errp)
>      v->vdpa.shared->device_fd =3D v->vhostfd;
>      v->vdpa.shared->iova_range =3D iova_range;
>
> -    ret =3D vhost_dev_init(&v->dev, &v->vdpa, VHOST_BACKEND_TYPE_VDPA, 0=
, NULL);
> +    ret =3D vhost_dev_init(&v->dev, &v->vdpa, VHOST_BACKEND_TYPE_VDPA, 0=
, true,
> +                         NULL);
>      if (ret < 0) {
>          error_setg(errp, "vhost-vdpa-device: vhost initialization failed=
: %s",
>                     strerror(-ret));
> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> index cf311c3bfc..0768231a88 100644
> --- a/hw/virtio/vhost-user-base.c
> +++ b/hw/virtio/vhost-user-base.c
> @@ -334,7 +334,7 @@ static void vub_device_realize(DeviceState *dev, Erro=
r **errp)
>
>      /* connect to backend */
>      ret =3D vhost_dev_init(&vub->vhost_dev, &vub->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
> +                         VHOST_BACKEND_TYPE_USER, 0, true, errp);
>
>      if (ret < 0) {
>          do_vhost_user_cleanup(vdev, vub);
> diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
> index e77c69eb12..2a8eead90b 100644
> --- a/hw/virtio/vhost-user-fs.c
> +++ b/hw/virtio/vhost-user-fs.c
> @@ -256,7 +256,7 @@ static void vuf_device_realize(DeviceState *dev, Erro=
r **errp)
>      fs->vhost_dev.nvqs =3D 1 + fs->conf.num_request_queues;
>      fs->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, fs->vhost_dev.n=
vqs);
>      ret =3D vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
> +                         VHOST_BACKEND_TYPE_USER, 0, true, errp);
>      if (ret < 0) {
>          goto err_virtio;
>      }
> diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
> index f9264c4374..40e567c18a 100644
> --- a/hw/virtio/vhost-user-scmi.c
> +++ b/hw/virtio/vhost-user-scmi.c
> @@ -253,7 +253,7 @@ static void vu_scmi_device_realize(DeviceState *dev, =
Error **errp)
>      scmi->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, scmi->vhost_d=
ev.nvqs);
>
>      ret =3D vhost_dev_init(&scmi->vhost_dev, &scmi->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
> +                         VHOST_BACKEND_TYPE_USER, 0, true, errp);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret,
>                           "vhost-user-scmi: vhost_dev_init() failed");
> diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
> index 993c287348..b630af0fe7 100644
> --- a/hw/virtio/vhost-user-vsock.c
> +++ b/hw/virtio/vhost-user-vsock.c
> @@ -115,7 +115,7 @@ static void vuv_device_realize(DeviceState *dev, Erro=
r **errp)
>      vhost_dev_set_config_notifier(&vvc->vhost_dev, &vsock_ops);
>
>      ret =3D vhost_dev_init(&vvc->vhost_dev, &vsock->vhost_user,
> -                         VHOST_BACKEND_TYPE_USER, 0, errp);
> +                         VHOST_BACKEND_TYPE_USER, 0, true, errp);
>      if (ret < 0) {
>          goto err_virtio;
>      }
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 107d88babe..3a4b2d924d 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -166,7 +166,7 @@ static void vhost_vsock_device_realize(DeviceState *d=
ev, Error **errp)
>      vhost_vsock_common_realize(vdev);
>
>      ret =3D vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
> +                         VHOST_BACKEND_TYPE_KERNEL, 0, true, errp);
>      if (ret < 0) {
>          /*
>           * vhostfd is closed by vhost_dev_cleanup, which is called
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1998663461..f733e98b4a 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1617,7 +1617,7 @@ static bool check_memslots(struct vhost_dev *hdev, =
Error **errp)
>
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                     VhostBackendType backend_type, uint32_t busyloop_time=
out,
> -                   Error **errp)
> +                   bool connect, Error **errp)
>  {
>      int i, r, n_initialized_vqs =3D 0;
>
> @@ -1634,6 +1634,15 @@ int vhost_dev_init(struct vhost_dev *hdev, void *o=
paque,
>      r =3D vhost_set_backend_type(hdev, backend_type);
>      assert(r >=3D 0);
>
> +    /*
> +     * Postponed connect only supported for devices with
> +     * .vhost_backend_connect handler
> +     */
> +    assert(connect || hdev->vhost_ops->vhost_backend_connect);
> +

nit: TODO

> +    /* TDDO: support connect=3Dfalse */
> +    assert(connect);
> +
>      r =3D hdev->vhost_ops->vhost_backend_init(hdev, opaque, errp);
>      if (r < 0) {
>          goto fail;
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
> index ff94fa1734..d3f055f95e 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -53,6 +53,7 @@ struct vhost_virtqueue;
>
>  typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque,
>                                    Error **errp);
> +typedef int (*vhost_backend_connect)(struct vhost_dev *dev, Error **errp=
);
>  typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
>  typedef int (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
>
> @@ -167,6 +168,7 @@ typedef int (*vhost_check_device_state_op)(struct vho=
st_dev *dev, Error **errp);
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
>      vhost_backend_init vhost_backend_init;
> +    vhost_backend_connect vhost_backend_connect;
>      vhost_backend_cleanup vhost_backend_cleanup;
>      vhost_backend_memslots_limit vhost_backend_memslots_limit;
>      vhost_backend_no_private_memslots_op vhost_backend_no_private_memslo=
ts;
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index f1a7e7b971..74ed24232e 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -155,7 +155,8 @@ struct vhost_net {
>   */
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                     VhostBackendType backend_type,
> -                   uint32_t busyloop_timeout, Error **errp);
> +                   uint32_t busyloop_timeout,
> +                   bool connect, Error **errp);
>
>  /**
>   * vhost_dev_cleanup() - tear down and cleanup vhost interface
> --
> 2.48.1
>
>

