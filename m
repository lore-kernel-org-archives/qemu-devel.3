Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B280C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnY34-0003h0-He; Thu, 27 Feb 2025 02:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tnY2y-0003ge-Kd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tnY2w-0000VN-3l
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740640260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z/RVerwJivPA/ot1znIRZyWAqST5kVjwoinyT8WChfs=;
 b=K3WCV11lWSl6r+8ivzaRlMjwUyKzaovz37RlODVVFWFKEILTnwcPoZEuGK6XnXSI9/aUaA
 mNihGzIACS0g/Edd+a1grskQllHXG/2T9v+N5RgbCdGf56hkBBDfJxaBWTns8tyl9RRuIs
 38mCn1oN522eEidGjIiLHqVwjR+HxCU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-a5d897gPPbGYf3fFBFS39g-1; Thu,
 27 Feb 2025 02:10:55 -0500
X-MC-Unique: a5d897gPPbGYf3fFBFS39g-1
X-Mimecast-MFC-AGG-ID: a5d897gPPbGYf3fFBFS39g_1740640254
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15C3C1800360; Thu, 27 Feb 2025 07:10:54 +0000 (UTC)
Received: from localhost (unknown [10.2.16.46])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34DB119560AB; Thu, 27 Feb 2025 07:10:51 +0000 (UTC)
Date: Thu, 27 Feb 2025 15:10:48 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 slp@redhat.com, stevensd@chromium.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v4 0/9] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20250227071048.GD85709@fedora>
References: <20250217164012.246727-1-aesteve@redhat.com>
 <aad375d5-8dab-41df-9986-4967ef485a71@redhat.com>
 <CADSE00+Tq8KVTW3BhLwRiQLQuFmauHRvXh34zP6fvvYFrB_t9g@mail.gmail.com>
 <40859ece-0850-40cb-b8b9-28d0d76aefde@redhat.com>
 <CADSE00JPHcXXK4dhvwY7rrXNV=1WSQYMv8vOGjVE0TG0+fVkNA@mail.gmail.com>
 <b320f128-3604-40c8-961c-ceb431f82f6d@redhat.com>
 <CADSE00LvNbCR6cn-FuDCVF-vvXULrx7=5SyceMtdgxwpUa3NMw@mail.gmail.com>
 <933cf843-e845-45e0-8c48-a34541ad0afb@redhat.com>
 <CADSE00Lzxt7AuzLe24=T+C1TCOAmV1SkAMqAkSXwLBK+x4NHbA@mail.gmail.com>
 <ba4c6655-4f69-4001-84fa-2ebfe87c0868@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tZKMvMvPIcylzVPo"
Content-Disposition: inline
In-Reply-To: <ba4c6655-4f69-4001-84fa-2ebfe87c0868@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--tZKMvMvPIcylzVPo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:53:01AM +0100, David Hildenbrand wrote:
> > > As commented offline, maybe one would want the option to enable the
> > > alternative mode, where such updates (in the SHM region) are not sent=
 to
> > > vhost-user devices. In such a configuration, the MEM_READ / MEM_WRITE
> > > would be unavoidable.
> >=20
> > At first, I remember we discussed two options, having update messages
> > sent to all devices (which was deemed as potentially racy), or using
> > MEM_READ / MEM _WRITE messages. With this version of the patch there
> > is no option to avoid the mem_table update messages, which brings me
> > to my point in the previous message: it may make sense to continue
> > with this patch without MEM_READ/WRITE support, and leave that and the
> > option to make mem_table updates optional for a followup patch?
>=20
> IMHO that would work for me.

I'm happy with dropping MEM_READ/WRITE. If the memslots limit becomes a
problem then it will be necessary to think about handling things
differently, but there are many possible uses of VIRTIO Shared Memory
Regions that will not hit the limit and I don't see a need to hold them
back.

Stefan

>=20
> >=20
> > >=20
> > > What comes to mind are vhost-user devices with limited number of
> > > supported memslots.
> > >=20
> > > No idea how relevant that really is, and how many SHM regions we will
> > > see in practice.
> >=20
> > In general, from what I see they usually require 1 or 2 regions,
> > except for virtio-scmi which requires >256.
>=20
> 1/2 regions are not a problem. Once we're in the hundreds for a single
> device, it will likely start being a problem, especially when you have mo=
re
> such devices.
>=20
> BUT, it would likely be a problem even with the alternative approach where
> we don't communicate these regions to vhost-user: IIRC, vhost-net in
> the kernel is usually limited to a maximum of 509 memslots as well as
> default. Similarly, older KVM only supports a total of 509 memslots.
>=20
> See https://virtio-mem.gitlab.io/user-guide/user-guide-qemu.html
> "Compatibility with vhost-net and vhost-user".
>=20
> In libvhost-user, and rust-vmm, we have a similar limit of ~509.
>=20
>=20
> Note that for memory devices (DIMMs, virtio-mem), we'll use up to 256
> memslots in case all devices support 509 memslots.
> See MEMORY_DEVICES_SOFT_MEMSLOT_LIMIT:
>=20
> /*
>  * Traditionally, KVM/vhost in many setups supported 509 memslots, whereby
>  * 253 memslots were "reserved" for boot memory and other devices (such
>  * as PCI BARs, which can get mapped dynamically) and 256 memslots were
>  * dedicated for DIMMs. These magic numbers worked reliably in the past.
>  *
>  * Further, using many memslots can negatively affect performance, so set=
ting
>  * the soft-limit of memslots used by memory devices to the traditional
>  * DIMM limit of 256 sounds reasonable.
>  *
>  * If we have less than 509 memslots, we will instruct memory devices that
>  * support automatically deciding how many memslots to use to only use a =
single
>  * one.
>  *
>  * Hotplugging vhost devices with at least 509 memslots is not expected to
>  * cause problems, not even when devices automatically decided how many m=
emslots
>  * to use.
>  */
> #define MEMORY_DEVICES_SOFT_MEMSLOT_LIMIT 256
> #define MEMORY_DEVICES_SAFE_MAX_MEMSLOTS 509
>=20
>=20
> That changes once you have some vhost-user devices consume combined with =
boot
> memory more than 253 memslots.
>=20
> --=20
> Cheers,
>=20
> David / dhildenb
>=20

--tZKMvMvPIcylzVPo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfAD/gACgkQnKSrs4Gr
c8hc+AgAotwRuYDtXevIGhm0uaQiFUzDp4R4Z6rOywx2piDuMgwsCpX8Mxc0G3F+
FBqhEsJsywkv4Jcexz8CuX7nuqTCMZGpHY411M8HXBFYDxNQV64lPqn6k6x+E66f
48yrgQnHqhEDo+CfULJvDLIEBQCL/Vd+KkWC/jPxZgcVu1NjMb3MtcAa6u9RXkG6
HKo1Gu6BCiikSkH4jGGjbPh25qOwlsAPq0ybyaqDvfZgD6VyJLe6PTCJi6g+jVR/
saE9jL+KtYhO+MwM25/f2O3/ZCfudZhq2b1s6+dbBbTVY5fLrQMuzmZ1/T83EjmC
fZ+XP1by+BNH4C/zYb0wNq8N5MWCcQ==
=LRZE
-----END PGP SIGNATURE-----

--tZKMvMvPIcylzVPo--


