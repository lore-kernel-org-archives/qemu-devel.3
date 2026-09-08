Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87673C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ww2-0001fS-QB; Tue, 08 Sep 2026 10:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x3ww1-0001ep-Ah
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x3wvz-0003ZG-Ax
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788878185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oZ64/WN7rUrf9IP6rnrVjWKCX8jXeN3/Os+2FyrzfPI=;
 b=DRTdwau3KFgvtQezAgWU/zkLdL/76B8sDS1TsdpNl7DgppZYOPMzcknjGthqVbtvjqn45G
 VisPqtTrYQOHYO4EkkK9Fl0+2ckfsKHwMpfJKfhXnsjX8xZmsY9SetI2nvqobZgd+7MqbW
 RP7+sI+Nj+1UI5Rnz9FniW5dRuYlU2A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-NEMXSVTDNFSv5pRBpCKPNQ-1; Tue,
 08 Sep 2026 10:36:19 -0400
X-MC-Unique: NEMXSVTDNFSv5pRBpCKPNQ-1
X-Mimecast-MFC-AGG-ID: NEMXSVTDNFSv5pRBpCKPNQ_1788878176
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D2B7192E259; Tue,  8 Sep 2026 14:36:15 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CB331956042; Tue,  8 Sep 2026 14:36:12 +0000 (UTC)
Date: Tue, 8 Sep 2026 10:36:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 1/9] virtio: Introduce virtio_complete_reset()
Message-ID: <20260908143611.GB1016680@fedora>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
 <20260908-gpu-v3-1-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dhgyCmpbZqNmY0zN"
Content-Disposition: inline
In-Reply-To: <20260908-gpu-v3-1-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--dhgyCmpbZqNmY0zN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 03:11:18PM +0900, Akihiko Odaki wrote:
> Introduce virtio_complete_reset() as preparation to allow asynchronous
> reset. It is unconditionally called in virtio_reset(), but a follow-up
> change moves the call to each device implementation.
>=20
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  include/hw/virtio/virtio.h |  1 +
>  hw/virtio/virtio.c         | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c99cb19d8865..1431be1389f2 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -507,6 +507,7 @@ int virtio_queue_set_host_notifier_mr(VirtIODevice *v=
dev, int n,
>                                        MemoryRegion *mr, bool assign);
>  int virtio_set_status(VirtIODevice *vdev, uint8_t val);
>  void virtio_reset(VirtIODevice *vdev);
> +void virtio_complete_reset(VirtIODevice *vdev);
>  void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
>  void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
>  void virtio_update_irq(VirtIODevice *vdev);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index daa5607338c9..8d5f58a02df6 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3423,11 +3423,10 @@ int virtio_set_features_ex(VirtIODevice *vdev, co=
nst uint64_t *features)
>  void virtio_reset(VirtIODevice *vdev)
>  {
>      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> -    VirtioSharedMemory *shmem;
> -    uint64_t features[VIRTIO_FEATURES_NU64S];
> -    int i;
> =20
>      virtio_set_status(vdev, 0);
> +    vdev->status =3D VIRTIO_CONFIG_S_FAILED;

Why is the VIRTIO Device Status Register set to FAILED during reset?
I don't see this in the VIRTIO specification.

> +
>      if (current_cpu) {
>          /* Guest initiated reset */
>          vdev->device_endian =3D virtio_current_cpu_endian();
> @@ -3448,6 +3447,15 @@ void virtio_reset(VirtIODevice *vdev)
>          k->reset(vdev);
>      }
> =20
> +    virtio_complete_reset(vdev);
> +}
> +
> +void virtio_complete_reset(VirtIODevice *vdev)
> +{
> +    VirtioSharedMemory *shmem;
> +    uint64_t features[VIRTIO_FEATURES_NU64S];
> +    int i;
> +
>      vdev->start_on_kick =3D false;
>      vdev->started =3D false;
>      vdev->broken =3D false;
>=20
> --=20
> 2.55.0
>=20

--dhgyCmpbZqNmY0zN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqgHVsACgkQnKSrs4Gr
c8hEXgf+OcG9H3Wmw8PGOi69iCx1N1imIFC6idNHc6qsgMYFFH/o2sL+wHM3XIHN
1XnU0cq/Jupedg92xQZDYg4MqEj8jax9QtXtnfp13ifXuVSu4leVebqDiPmnEe/j
dwFNYQ529eMsGgJAUFKDSIaVwx13u29cD1zljHU7sN4qo013ygYRCd6jV2as1Pi7
eYhnp0I0wxrgwvMeN+h+BXyLhh3Tm6fXA70ZzPwYB5EimQSmhQCm41uHHk6G9wy3
5z80PE8aW5YoeBbvGRMYiTANyufxL5C6kRkm6sKMOccTmN3Q2Jb4MtX3hEUTaAoK
zMZI41C9LfVRQ2zgQv8oJQ2QC33VcQ==
=uOIU
-----END PGP SIGNATURE-----

--dhgyCmpbZqNmY0zN--


