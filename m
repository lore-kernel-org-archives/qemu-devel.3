Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEB5C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wongk-00088X-7F; Tue, 28 Jul 2026 15:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wongi-00087w-QR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wongf-0005Lu-7y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785267719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x+AkxoWsB7uc2detbeE8+509PBr3u/TvOz/2hh/L2Kw=;
 b=OGYwNZCV3nHy6uAyeeAnTQy9crfhg1i9aexc51a+eiuDtMG1wkqytq0Ju8/o8bbXjhq90t
 /tz1A51V+raxIurcQK1SeqQZW4ZYl5uK1M1AmB30judyjQuE6lDp7TveZM88U/e/pYz27+
 XNkz7/XtdTbecIYKyi32CMnvxmAkHPA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-sF0ED4HdOLyGoftEuRehEA-1; Tue,
 28 Jul 2026 15:41:55 -0400
X-MC-Unique: sF0ED4HdOLyGoftEuRehEA-1
X-Mimecast-MFC-AGG-ID: sF0ED4HdOLyGoftEuRehEA_1785267712
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDC3519560B2; Tue, 28 Jul 2026 19:41:50 +0000 (UTC)
Received: from localhost (unknown [10.2.17.47])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF12F1956089; Tue, 28 Jul 2026 19:41:47 +0000 (UTC)
Date: Tue, 28 Jul 2026 15:41:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 qemu-block@nongnu.org, virtio-fs@lists.linux.dev,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: [PATCH RFC 13/15] hw/virtio/vhost-user: add shadow virtqueues
 and eventfd intercepts
Message-ID: <20260728194145.GK371693@fedora>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B6GEy+uFbHjCCumJ"
Content-Disposition: inline
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-13-6b97c439eb28@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--B6GEy+uFbHjCCumJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 03:30:12PM -0700, Connor Kite wrote:
> Adds shadow virtqueues that will eventually be used to transfer data
> between device and host via bounce buffers when isolation mode is
> active.  The svqs are initalized, and eventfd assignments are
> intercepted so that notifications come to svqs first before
> the guest or backend receive them.
>=20
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  hw/virtio/vhost-user.c | 54 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 54 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index acabfb7f1c..75858289a2 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -18,6 +18,7 @@
>  #include "hw/virtio/vhost-backend.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/vhost-shadow-virtqueue.h"
>  #include "hw/virtio/vhost-iova-tree.h"
>  #include "chardev/char-fe.h"
>  #include "io/channel-socket.h"
> @@ -365,7 +366,9 @@ struct vhost_user {
> =20
>      /* Isolated memory data*/
>      struct IsolationRegion iso_memory;
> +    GPtrArray *shadow_vqs;
>      VhostIOVATree *iso_iova_tree;
> +    bool svqs_allocated;
>  };
> =20
>  struct scrub_regions {
> @@ -1693,6 +1696,24 @@ static int vhost_set_vring_file(struct vhost_dev *=
dev,
>  static int vhost_user_set_vring_kick(struct vhost_dev *dev,
>                                       struct vhost_vring_file *file)
>  {
> +    struct vhost_user *u =3D dev->opaque;
> +    int svq_idx =3D file->index - dev->vq_index;
> +    if (u->user->memory_isolation) {
> +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vqs,
> +                                                      svq_idx);
> +        vhost_svq_set_svq_kick_fd(svq, file->fd);
> +
> +        if (svq->hdev_kick.initialized =3D=3D false) {
> +            int r =3D event_notifier_init(&svq->hdev_kick, 0);

Where is event_notifier_cleanup() called?

> +            if (r) {
> +                error_report("Failed to create kick event notifier");
> +                return r;
> +            }
> +        }
> +
> +        file->fd =3D event_notifier_get_fd(&svq->hdev_kick);

Modifying the function argument is probably not expected but
vhost_virtqueue_start() doesn't use it after this call, so there is no
immediate problem. It would be safer to have a local struct
vhost_vring_file that can be modified without affecting the caller's
copy.

> +    }
> +
>      int ret =3D vhost_set_vring_file(dev, VHOST_USER_SET_VRING_KICK, fil=
e);
>      if (ret < 0) {
>          return ret;
> @@ -1721,6 +1742,24 @@ static int vhost_user_set_vring_kick(struct vhost_=
dev *dev,
>  static int vhost_user_set_vring_call(struct vhost_dev *dev,
>                                       struct vhost_vring_file *file)
>  {
> +    struct vhost_user *u =3D dev->opaque;
> +    int svq_idx =3D file->index - dev->vq_index;
> +    if (u->user->memory_isolation) {
> +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vqs,
> +                                                      svq_idx);
> +        vhost_svq_set_svq_call_fd(svq, file->fd);
> +
> +        if (svq->hdev_call.initialized =3D=3D false) {
> +            int r =3D event_notifier_init(&svq->hdev_call, 0);

Where is event_notifier_cleanup() called?

> +            if (r) {
> +                error_report("Failed to create call event notifier");
> +                return r;
> +            }
> +        }
> +
> +        file->fd =3D event_notifier_get_fd(&svq->hdev_call);

Same as above.

> +    }
> +
>      return vhost_set_vring_file(dev, VHOST_USER_SET_VRING_CALL, file);
>  }
> =20
> @@ -2715,6 +2754,17 @@ static int vhost_user_postcopy_notifier(NotifierWi=
thReturn *notifier,
>      return 0;
>  }
> =20
> +static void vhost_user_init_svq(struct vhost_dev *dev, struct vhost_user=
 *u)
> +{
> +    /*Modified from vhost-vdpa*/
> +    u->shadow_vqs =3D g_ptr_array_new_full(dev->nvqs, vhost_svq_free);
> +    for (int i =3D 0; i < dev->nvqs; i++) {
> +        VhostShadowVirtqueue *svq;
> +        svq =3D vhost_svq_new(NULL, NULL);
> +        g_ptr_array_add(u->shadow_vqs, svq);
> +    }
> +}
> +
>  static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
>                                     Error **errp)
>  {
> @@ -2859,6 +2909,10 @@ static int vhost_user_backend_init(struct vhost_de=
v *dev, void *opaque,
>      u->postcopy_notifier.notify =3D vhost_user_postcopy_notifier;
>      postcopy_add_notifier(&u->postcopy_notifier);
> =20
> +    if (vus->memory_isolation) {
> +        vhost_user_init_svq(dev, u);
> +    }
> +
>      return 0;
>  }
> =20
>=20
> --=20
> 2.43.0
>=20

--B6GEy+uFbHjCCumJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmppBfkACgkQnKSrs4Gr
c8incggAjXD8O74CX7ZbPEI9yeqAUza43JWOz78Ypa4LvWMaqWm0MK2nSmjunVjC
99wXDVM2Dz2DVphziIy7C6D/zyJBopg1K/N08Z1ZKB43TY3BtteU0tfEgJuAOooA
TKK5UJynp/mLbMG8IWEVB1Sg9bogNL8cckPMzVVzkQwCD+33CPBfwHChwmR4zuai
XNUeTUnU3D4mQycDXAlsWG+MwGQRh1GPd6i0Q8bIXM7Uv1w8qSSeZ4skNGEvH0SZ
Xq7Y0sXONrDVkRGyvKkHOb7claFGvm4KoCUTt8rVwe1BSM9+JMC+apsDBiLvTxlX
qAJCi8AzjycweYFAENIpHtQrM5h0uw==
=gN7E
-----END PGP SIGNATURE-----

--B6GEy+uFbHjCCumJ--


