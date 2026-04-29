Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A265FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI7HK-0007SK-L2; Wed, 29 Apr 2026 11:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7Gl-0007LJ-K0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7Gh-0005v2-Ej
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 11:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777478156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uv0aUOrsctSONcuQXyinbd+j2k8RnKWlGBwXO/UiTTk=;
 b=hEQdx93yh/Ej9Lizljq0edvdt87OS59Rju+WaIa9Xq8qZKfrEepWv7rf8py2DM2XmdZFFm
 WuHg8BSN8UCCSH/NFHcDlawexrTV/zLi+Dt/iZ27K175fKl329Z338znrKT8KR35RHbI2Z
 H5J++ZihcfTRW6HRi4FJBZKGjwX769M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-rEzESzFQNYGEgIX5w1ulnA-1; Wed,
 29 Apr 2026 11:55:53 -0400
X-MC-Unique: rEzESzFQNYGEgIX5w1ulnA-1
X-Mimecast-MFC-AGG-ID: rEzESzFQNYGEgIX5w1ulnA_1777478152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FE4319560AB; Wed, 29 Apr 2026 15:55:52 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1772030001A1; Wed, 29 Apr 2026 15:55:50 +0000 (UTC)
Date: Wed, 29 Apr 2026 11:55:48 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jorge Moreira <jemoreira@google.com>, hreitz@redhat.com,
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260429155548.GB12211@fedora>
References: <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
 <CAJi--PPPVc3-z8G3E_qucWhE4bn7hdKYJK4iOcP0Db4tUAw8zQ@mail.gmail.com>
 <afDClLiylMgvPiUn@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Do/ZaTeJ5plpynVu"
Content-Disposition: inline
In-Reply-To: <afDClLiylMgvPiUn@sgarzare-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--Do/ZaTeJ5plpynVu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 04:33:23PM +0200, Stefano Garzarella wrote:
> On Mon, Apr 27, 2026 at 03:48:44PM -0700, Jorge Moreira wrote:
> > On Mon, Apr 27, 2026 at 3:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >=20
> > > On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
> > > > On Wed, Apr 22, 2026 at 1:32=E2=80=AFAM Stefano Garzarella <sgarzar=
e@redhat.com> wrote:
> > > > >
> > > > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com=
> wrote:
> > > > > >
> > > > > > On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > > > > > > > While starting the vrings on SET_VRING_KICK could solve the=
 state
> > > > > > > > machine issue, it still won't notify the back-end that buff=
ers are
> > > > > > > > ready (the driver won't do this). Non-polling back-ends dep=
end on this
> > > > > > > > kick, especially for queues where data flows only from the =
driver to
> > > > > > > > the back-end. Most implementations likely attempt to read f=
rom the
> > > > > > > > queue only after receiving the kick.
> > > > > > >
> > > > > > > This is an interesting question to clarify in the spec.
> > > > >
> > > > > Yep, which is in part related to what I wrote in the other reply:
> > > > > "I think the main issue to clarify is what the device should do
> > > > > when the vrings are configured, but the driver has already been
> > > > > initialized (which is usually the case after migration)."
> > > > >
> > > > > > >
> > > > > > > Stefan
> > > > > >
> > > > > > This is the question that interests me most, to be honest. I'd =
rather
> > > > > > have the discussion about when to activate the vrings in a diff=
erent
> > > > > > thread and keep this one focused on whether the front-end shoul=
d send
> > > > > > the kick or if the back-end is expected to check if there are "=
new"
> > > > > > buffers in the vring after restore.
> > > > > >
> > > > >
> > > > > IMO we don't need anything from the VMM. When the device receives
> > > > > SET_VRING_KICK, it can check if the vring already contains buffers
> > > > > (and this is the part we might need to clarify) and wake-up the o=
ther
> > > > > threads (or always wake-ups them, as crosvm does IIUC, and let th=
em
> > > > > perform this check).
> > > > > After sending the SET_VRING_KICK message to the device, the VMM h=
as
> > > > > the exact same knowledge of the vring state as the device, theref=
ore,
> > > > > it's still unclear to me why we need to inject that kick.
> > > > >
> > > > > Stefano
> > > > >
> > > >
> > > > Is it possible to activate a vring after it has been deactivated wi=
th
> > > > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send =
the
> > > > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
> > > > reactivate it?
> > >=20
> > > Hi Jorge and Stefano,
> > > Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs wh=
en
> > > a VM is paused and then resumed.
> > >=20
> > > You can stress test this by driving I/O using iperf (virtio-net) or f=
io
> > > (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
> > > QEMU's monitor.
> > >=20
> > > Here is QEMU's code for starting (including re-starting) rings:
> > > https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?=
ref_type=3Dheads#L1341
> > >=20
> > > QEMU does not inject a kick. The back-end must check the rings itself.
> > >=20
> > > I'm not sure that all vhost-user back-ends actually check the rings. I
> > > think back-ends should do it, but we should also update the spec with=
 an
> > > front-end implementation note recommending injecting a kick after
> > > VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility
>=20
> Okay, but since, as we've seen, no frontend currently implements this, we
> need to make it clear that a backend shouldn't necessarily expect the kick
> injected from every frontend, but should support it in some way since some
> of them can inject it.
>=20
> IMHO especially new backend implementations shouldn't rely on the kick
> injection.
>=20
> So, to summarize:
> - the frontend should also send a kick to restart the queues
> - the backend should restart the queues after VHOST_USER_SET_VRING_KICK,
> but it might also receive a kick

Yes, agreed.

>=20
> > > with implementations that follow the current spec wording. And at the
> > > same time I think the spec should also be changed to say that
> > > VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check =
the
> > > vring upon processing the message.
>=20
> Yep, I think we are aligned.
>=20
> > >=20
> > > That seems like it would clean up the issues without introducing
> > > compatibility issues or making existing implementations non-compliant
> > > with the updated spec.
> > >=20
> > > What do you think?
>=20
> LGTM!
>=20
> >=20
> > Sounds good to me
> >=20
>=20
> @Jorge do you want to propose this change?
>=20
> Thanks,
> Stefano
>=20

--Do/ZaTeJ5plpynVu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnyKgQACgkQnKSrs4Gr
c8irOgf9GIG6raSpw8ir4XanQzXBrtT6n/GEyWSmSW7ap8SIGhKi3yYvUSaSjkkA
h8bDyMk6X0qYRXMSTTBFvTH8pL8dzaZ+0AzwxNhKareRmEKRuU+Zyb1tqqfdM5n+
LUudcI3Bg3IEs3EBAMBAIPFVjfKSeOh/AOgURFI6aqwm0xNpoR03UVB7DGmNWGHG
6Yf3i14AvvRLmNWi/F0mLmnLAmlYZ7Qbs7i9o7Ze+irKcZlzbpa+sU/pisvKLgnD
2cXSeE6mHTBnnQkQz+8EhXMglNFTe+facm8pPcEJ0hvxyKtE23O4hs6DhyAtDQLD
PFZ+pVNc2vl5kY9cGDtG67iY4ChfRA==
=Qnpg
-----END PGP SIGNATURE-----

--Do/ZaTeJ5plpynVu--


