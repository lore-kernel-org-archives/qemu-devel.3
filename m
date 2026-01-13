Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BCFD2F34C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 18:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfihc-0006tw-0c; Tue, 13 Jan 2026 13:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfih9-0006eY-Ip
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vfih0-0006HJ-MJ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 13:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768327231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kbm9NA9dD6Isl74EALCx7+xC5wTeYij3XnD/Hv+cVLw=;
 b=CqduPgfPB/EJcLvmBkAg8jSud2YX9wNYGD2uDMWby9B+PXxqfA6W0db0sO54rtIA1YIVS5
 HG3Ev9nuHTn8jBAVLpjXBRO82TTB2QlL3fS7HGV4vQcZG8JqeX+6E+Lsrbz8sCMQ+t3bAL
 +YTQkDk39n+6kLL/2huapl3iQTadM0A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-tt9ZX0QiPuue0clRnaufUg-1; Tue,
 13 Jan 2026 13:00:26 -0500
X-MC-Unique: tt9ZX0QiPuue0clRnaufUg-1
X-Mimecast-MFC-AGG-ID: tt9ZX0QiPuue0clRnaufUg_1768327223
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1DCD19560B2; Tue, 13 Jan 2026 18:00:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 388821800285; Tue, 13 Jan 2026 18:00:18 +0000 (UTC)
Date: Tue, 13 Jan 2026 13:00:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 2/5] vhost-user: introduce protocol feature for skip
 drain on GET_VRING_BASE
Message-ID: <20260113180017.GA528940@fedora>
References: <20260113095813.134810-1-dtalexundeer@yandex-team.ru>
 <20260113095813.134810-3-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JD+DUASqegM5fptM"
Content-Disposition: inline
In-Reply-To: <20260113095813.134810-3-dtalexundeer@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--JD+DUASqegM5fptM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 02:58:13PM +0500, Alexandr Moshkov wrote:
> Add vhost-user protocol feature
> VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT
>=20
> Now on GET_VRING_BASE this feature can control whether to wait for
> in-flight requests to complete or not.
> Also we have to validate that this feature will be enabled only when
> qemu and back-end supports in-flight buffer and in-flight migration
>=20
> It will be helpfull in future for in-flight requests migration in
> vhost-user devices.
>=20
> Update docs, add ref to label for inflight-io-tracking
>=20
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  docs/interop/vhost-user.rst    | 59 +++++++++++++++++++++-------------
>  hw/virtio/vhost-user.c         |  5 +++
>  include/hw/virtio/vhost-user.h |  2 ++
>  3 files changed, 44 insertions(+), 22 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 02908b48fa..dcf79de0c0 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -736,6 +736,8 @@ negotiated, back-end can send file descriptors (at mo=
st 8 descriptors in
>  each message) to front-end via ancillary data using this fd communication
>  channel.
> =20
> +.. _inflight_io_tracking:
> +
>  Inflight I/O tracking
>  ---------------------
> =20
> @@ -1033,26 +1035,27 @@ Protocol features
> =20
>  .. code:: c
> =20
> -  #define VHOST_USER_PROTOCOL_F_MQ                    0
> -  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD             1
> -  #define VHOST_USER_PROTOCOL_F_RARP                  2
> -  #define VHOST_USER_PROTOCOL_F_REPLY_ACK             3
> -  #define VHOST_USER_PROTOCOL_F_MTU                   4
> -  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ           5
> -  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN          6
> -  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION        7
> -  #define VHOST_USER_PROTOCOL_F_PAGEFAULT             8
> -  #define VHOST_USER_PROTOCOL_F_CONFIG                9
> -  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD      10
> -  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER        11
> -  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
> -  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
> -  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
> -  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
> -  #define VHOST_USER_PROTOCOL_F_STATUS               16
> -  #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> -  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
> -  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_MQ                       0
> +  #define VHOST_USER_PROTOCOL_F_LOG_SHMFD                1
> +  #define VHOST_USER_PROTOCOL_F_RARP                     2
> +  #define VHOST_USER_PROTOCOL_F_REPLY_ACK                3
> +  #define VHOST_USER_PROTOCOL_F_MTU                      4
> +  #define VHOST_USER_PROTOCOL_F_BACKEND_REQ              5
> +  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN             6
> +  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION           7
> +  #define VHOST_USER_PROTOCOL_F_PAGEFAULT                8
> +  #define VHOST_USER_PROTOCOL_F_CONFIG                   9
> +  #define VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD         10
> +  #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER           11
> +  #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD          12
> +  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE            13
> +  #define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS    14
> +  #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS     15
> +  #define VHOST_USER_PROTOCOL_F_STATUS                  16
> +  #define VHOST_USER_PROTOCOL_F_XEN_MMAP                17
> +  #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT           18
> +  #define VHOST_USER_PROTOCOL_F_DEVICE_STATE            19
> +  #define VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT 20
> =20
>  Front-end message types
>  -----------------------
> @@ -1243,12 +1246,24 @@ Front-end message types
> =20
>    When and as long as all of a device's vrings are stopped, it is
>    *suspended*, see :ref:`Suspended device state
> -  <suspended_device_state>`. The back-end must complete all inflight I/O
> -  requests for the specified vring before stopping it.
> +  <suspended_device_state>`.
> =20
>    The request payload's *num* field is currently reserved and must be
>    set to 0.
> =20
> +  By default, the back-end must complete all inflight I/O requests for t=
he
> +  specified vring before stopping it.
> +
> +  If the ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT`` protocol
> +  feature has been negotiated, the back-end may suspend in-flight I/O
> +  requests and record them as described in :ref:`Inflight I/O tracking
> +  <inflight_io_tracking>` instead of completing them before stopping the=
 vring.
> +  How to suspend an in-flight request depends on the implementation of t=
he back-end
> +  but it typically can be done by aborting or cancelling the underlying =
I/O
> +  request. The ``VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT``
> +  protocol feature must only be neogotiated if
> +  ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD`` is also negotiated.
> +
>  ``VHOST_USER_SET_VRING_KICK``
>    :id: 12
>    :equivalent ioctl: ``VHOST_SET_VRING_KICK``
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index a820214188..793d1b36d8 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2320,6 +2320,11 @@ static int vhost_user_backend_connect(struct vhost=
_dev *dev, Error **errp)
>              }
>          }
> =20
> +        if (!u->user->supports_inflight_migration ||
> +            !virtio_has_feature(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {

This looks like it will not compile since virtio_has_features() takes
two arguments. I think it should be:

  !virtio_has_feature(dev->protocol_features,
                      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)

> +            protocol_features &=3D ~(1ULL <<
> +                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFL=
IGHT);
> +        }
> +
>          /* final set of protocol features */
>          u->protocol_features =3D protocol_features;
>          err =3D vhost_user_set_protocol_features(dev, u->protocol_featur=
es);

I seem to have different version of hw/virtio/vhost-user.c. Is this
patch against qemu.git/master?

> diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-use=
r.h
> index fb89268de2..f30c1792e4 100644
> --- a/include/hw/virtio/vhost-user.h
> +++ b/include/hw/virtio/vhost-user.h
> @@ -33,6 +33,7 @@ enum VhostUserProtocolFeature {
>      /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>      VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
>      VHOST_USER_PROTOCOL_F_DEVICE_STATE =3D 19,
> +    VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT =3D 20,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> =20
> @@ -69,6 +70,7 @@ typedef struct VhostUserState {
>      GPtrArray *notifiers;
>      int memory_slots;
>      bool supports_config;
> +    bool supports_inflight_migration;
>  } VhostUserState;
> =20
>  /**
> --=20
> 2.34.1
>=20

--JD+DUASqegM5fptM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmlmiDEACgkQnKSrs4Gr
c8gpyAf9FQyDPYo0dF8rKYGTS4a/pZBgzg4jCagsrcGxtdgcxAFGn86yRWRgSWlX
VAPpMl3rbr2JrXbNlWpVMBIN+qHyEFnTzjYGraNoJDylWBeLYJes/BKzfN+FnIF/
lTQWPjPllXif155xxAqO4k5wz6STKgYIwXwD7qp6rkl5jqgFI8dDXjeTNnZ9VF70
+EO8vcmJ9Yu2Ict6YFolIdpGtC7C/4CtdBrSFlhFP5P59+EwPld7+QP3fwmsU/sC
BcMaNkIxQKALSU1LSE3AarIZEY378pvNbfihkHo7p+Co8DKyQky9alCnJODOnM4c
bzuF9AEgmFtSnthcPzkZazpTLmuBPA==
=P+Ih
-----END PGP SIGNATURE-----

--JD+DUASqegM5fptM--


