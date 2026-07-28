Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14797C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojea-0001Ar-3G; Tue, 28 Jul 2026 11:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wojeR-0000kt-Vg
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wojeM-0000M4-CT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785252201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yGLmE0Uup5xWQ2G+SyVEbIDUzauE43uCgyclhivM0xc=;
 b=LWN02+hj/hNTdMItfozH39dibtDOrc42Kj616EWlEmxjnwLobt7ddonf2UfsTvVw4i0V+Z
 k/gAzEcNGq3Ns37CUojZvqMFhGmtg1QGIYoenbg3VzpM3sLF5tePwhLc5TvSE/OhgrcQT+
 qHwOUsVumr0OLV8IKzvbK7IV4Twdb9s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-qGo7YqOsNRW6cQPfrLF7kQ-1; Tue,
 28 Jul 2026 11:23:18 -0400
X-MC-Unique: qGo7YqOsNRW6cQPfrLF7kQ-1
X-Mimecast-MFC-AGG-ID: qGo7YqOsNRW6cQPfrLF7kQ_1785252194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6582E1956058; Tue, 28 Jul 2026 15:23:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.73])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4D3D818004AD; Tue, 28 Jul 2026 15:23:09 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:23:08 -0400
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
Subject: Re: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
Message-ID: <20260728152308.GG371693@fedora>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dl4fy5/Nk4W7j/qR"
Content-Disposition: inline
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

--Dl4fy5/Nk4W7j/qR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 03:30:08PM -0700, Connor Kite wrote:
> By default svq vrings are placed in an anonymous memory map. As svqs
> will be leveraged to enable memory isolation in vhost-user, it is useful
> to be able to place the vrings in a shared isolation memory region.
>=20
> Adds the option to specify vring placement by providing a vring base
> address before starting the svq.
>=20
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 22 +++++++++++++++-------
>  hw/virtio/vhost-shadow-virtqueue.h |  3 +++
>  2 files changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index eb86c1ee37..9e3c359f50 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -857,14 +857,21 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Vir=
tIODevice *vdev,
> =20
>      svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_index=
(vq));
>      svq->num_free =3D svq->vring.num;
> -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
>      desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
> -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANON=
YMOUS,
> -                           -1, 0);
> +    if (svq->base_addr =3D=3D NULL) {
> +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANO=
NYMOUS,
> +                            -1, 0);
> +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_siz=
e);
> +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> +                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANO=
NYMOUS,
> +                            -1, 0);
> +    } else {
> +        svq->vring.desc =3D (void *) svq->base_addr;
> +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_siz=
e);
> +        svq->vring.used =3D (void *)((char *)svq->base_addr +
> +                          vhost_svq_driver_area_size(svq));
> +    }
>      svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
>      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
>          svq->batch_last.id =3D VIRTIO_RING_NOT_IN_BATCH;
> @@ -929,6 +936,7 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadow=
VirtqueueOps *ops,
>      event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
>      svq->ops =3D ops;
>      svq->ops_opaque =3D ops_opaque;
> +    svq->base_addr =3D NULL;
>      return svq;
>  }
> =20
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index ccfeee36d7..39f69e6455 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -148,6 +148,9 @@ typedef struct VhostShadowVirtqueue {
> =20
>      /* Size of SVQ vring free descriptors */
>      uint16_t num_free;
> +
> +    /* Location assigned to vrings if not in default anon memory map*/
> +    hwaddr *base_addr;

Why is base_addr a hwaddr? This is QEMU memory, not guest RAM. I
expected this to be void *.

A size needs to be at least documented here to reduce the chance of
memory bugs. Even better would be an interface like
vhost_svq_vring_total_size() so the caller can fetch the number of bytes
before allocating the memory.

--Dl4fy5/Nk4W7j/qR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmpoyVwACgkQnKSrs4Gr
c8jUuwgAvMc/G3tOhj0RTFEXylyhHMcyDAfcvVg+19MNnwq8RSuEjpwK7ongL+Do
s3rzWOVKWxQS8RMFhq0E1zXoLWZ0+nt3Ziqi2XBOj28SEiO3eZyfXMQ6lC1UYo1i
ZiN0+qHov/H69XAb8cKJgt4xKyiLhVEZfC/DKBzNzVOiFHApRfzdPQapfqTXA4PJ
5z0v+rRysNK9dCaLDf6hqlXki1xWm3M877IeDEztVtof0FolUwLgy4DM9r8lwEdi
efKoa9g6Jb083QGMMCKEzXR5wkxvrIVsbIc/OonhN8XDNjJNPpiaZeLlDj0WddGb
BECKOD1lZ+YB9/soytLlda2bjV2M8g==
=jc6J
-----END PGP SIGNATURE-----

--Dl4fy5/Nk4W7j/qR--


