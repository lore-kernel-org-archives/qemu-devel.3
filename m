Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B832CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 16:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI7Kw-0001Tn-D8; Wed, 29 Apr 2026 12:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7Kt-0001TI-4i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wI7Kr-0007sk-6p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 12:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777478423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K/RlA35TLbnfLjYvHujuCktPHK97/X/i1lG4oTsHUi8=;
 b=CUpXLF82KrtzthifpllwaK0A5KkuAvC51Ter+b+phIfYzUGQTQg6jr0dETmkO8udTr2pJp
 jryjzd/MxAoD7GX/kKjK/RfOGWffM27I/R6b+n8GtWjKM3Oued+RLirxlMtupDZLPWUDj8
 bzJeXz/JNu2N7rkHWD2LI9K6qY2b6z8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-411ry6GnPZ6vxavoAdyc5Q-1; Wed,
 29 Apr 2026 12:00:14 -0400
X-MC-Unique: 411ry6GnPZ6vxavoAdyc5Q-1
X-Mimecast-MFC-AGG-ID: 411ry6GnPZ6vxavoAdyc5Q_1777478412
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F1561956077; Wed, 29 Apr 2026 16:00:12 +0000 (UTC)
Received: from localhost (unknown [10.44.33.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D58E19560AB; Wed, 29 Apr 2026 16:00:10 +0000 (UTC)
Date: Wed, 29 Apr 2026 12:00:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jorge Moreira <jemoreira@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Hanna Czenczek <xanclic@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
Message-ID: <20260429160009.GC12211@fedora>
References: <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
 <CAJi--PPPVc3-z8G3E_qucWhE4bn7hdKYJK4iOcP0Db4tUAw8zQ@mail.gmail.com>
 <afDClLiylMgvPiUn@sgarzare-redhat>
 <CAJi--PMNCY26wqJiRw1xnAZVvOQUajcz534ocVhQx_Ox4u8GHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sbMRmyzoAvyCYYfk"
Content-Disposition: inline
In-Reply-To: <CAJi--PMNCY26wqJiRw1xnAZVvOQUajcz534ocVhQx_Ox4u8GHg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--sbMRmyzoAvyCYYfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:19:30AM -0700, Jorge Moreira wrote:
> On Tue, Apr 28, 2026 at 7:33=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Mon, Apr 27, 2026 at 03:48:44PM -0700, Jorge Moreira wrote:
> > >On Mon, Apr 27, 2026 at 3:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > >>
> > >> On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
> > >> > On Wed, Apr 22, 2026 at 1:32=E2=80=AFAM Stefano Garzarella <sgarza=
re@redhat.com> wrote:
> > >> > >
> > >> > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.co=
m> wrote:
> > >> > > >
> > >> > > > On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefa=
nha@redhat.com> wrote:
> > >> > > > >
> > >> > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrot=
e:
> > >> > > > > > While starting the vrings on SET_VRING_KICK could solve th=
e state
> > >> > > > > > machine issue, it still won't notify the back-end that buf=
fers are
> > >> > > > > > ready (the driver won't do this). Non-polling back-ends de=
pend on this
> > >> > > > > > kick, especially for queues where data flows only from the=
 driver to
> > >> > > > > > the back-end. Most implementations likely attempt to read =
=66rom the
> > >> > > > > > queue only after receiving the kick.
> > >> > > > >
> > >> > > > > This is an interesting question to clarify in the spec.
> > >> > >
> > >> > > Yep, which is in part related to what I wrote in the other reply:
> > >> > > "I think the main issue to clarify is what the device should do
> > >> > > when the vrings are configured, but the driver has already been
> > >> > > initialized (which is usually the case after migration)."
> > >> > >
> > >> > > > >
> > >> > > > > Stefan
> > >> > > >
> > >> > > > This is the question that interests me most, to be honest. I'd=
 rather
> > >> > > > have the discussion about when to activate the vrings in a dif=
ferent
> > >> > > > thread and keep this one focused on whether the front-end shou=
ld send
> > >> > > > the kick or if the back-end is expected to check if there are =
"new"
> > >> > > > buffers in the vring after restore.
> > >> > > >
> > >> > >
> > >> > > IMO we don't need anything from the VMM. When the device receives
> > >> > > SET_VRING_KICK, it can check if the vring already contains buffe=
rs
> > >> > > (and this is the part we might need to clarify) and wake-up the =
other
> > >> > > threads (or always wake-ups them, as crosvm does IIUC, and let t=
hem
> > >> > > perform this check).
> > >> > > After sending the SET_VRING_KICK message to the device, the VMM =
has
> > >> > > the exact same knowledge of the vring state as the device, there=
fore,
> > >> > > it's still unclear to me why we need to inject that kick.
> > >> > >
> > >> > > Stefano
> > >> > >
> > >> >
> > >> > Is it possible to activate a vring after it has been deactivated w=
ith
> > >> > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send=
 the
> > >> > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
> > >> > reactivate it?
> > >>
> > >> Hi Jorge and Stefano,
> > >> Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs w=
hen
> > >> a VM is paused and then resumed.
> > >>
> > >> You can stress test this by driving I/O using iperf (virtio-net) or =
fio
> > >> (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
> > >> QEMU's monitor.
> > >>
> > >> Here is QEMU's code for starting (including re-starting) rings:
> > >> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c=
?ref_type=3Dheads#L1341
> > >>
> > >> QEMU does not inject a kick. The back-end must check the rings itsel=
f.
> > >>
> > >> I'm not sure that all vhost-user back-ends actually check the rings.=
 I
> > >> think back-ends should do it, but we should also update the spec wit=
h an
> > >> front-end implementation note recommending injecting a kick after
> > >> VHOST_USER_SET_VRING_KICK completes in order to maximize compatibili=
ty
> >
> > Okay, but since, as we've seen, no frontend currently implements this,
> > we need to make it clear that a backend shouldn't necessarily expect the
> > kick injected from every frontend, but should support it in some way
> > since some of them can inject it.
> >
> > IMHO especially new backend implementations shouldn't rely on the kick
> > injection.
> >
> > So, to summarize:
> > - the frontend should also send a kick to restart the queues
> > - the backend should restart the queues after VHOST_USER_SET_VRING_KICK,
> >    but it might also receive a kick
> >
> > >> with implementations that follow the current spec wording. And at the
> > >> same time I think the spec should also be changed to say that
> > >> VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check=
 the
> > >> vring upon processing the message.
> >
> > Yep, I think we are aligned.
> >
> > >>
> > >> That seems like it would clean up the issues without introducing
> > >> compatibility issues or making existing implementations non-compliant
> > >> with the updated spec.
> > >>
> > >> What do you think?
> >
> > LGTM!
> >
> > >
> > >Sounds good to me
> > >
> >
> > @Jorge do you want to propose this change?
>=20
> You have a much better idea of where and how this should be written,
> it will save us a few rounds of review if one of you makes that
> change.

I can give it a shot and will CC you.

Also, I wanted to apologize for not being very forthcoming in this
discussion. I had an intuition about this issue but lacked the time to
research and double-check the details. As a result, I didn't respond
to all your points in detail. Sorry if it was frustrating.

Stefan

--sbMRmyzoAvyCYYfk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnyKwgACgkQnKSrs4Gr
c8jTMwf+Op+/Hu/RBWBqE2ldJ6cQNYIa/hrY3eLcNBU9j+KSLmqrBnLjN3WOSbvO
06ESVBXDjJqEK/V3foC4H2P5kDpvcbhKV6FMUqX7fdXMOl5g+ATzk7pt9KgGclyj
BnSZ+Y0X/rKacsMxIbI+JfkLCjWLOYh86eQMfijEO2+YB9FLMxvFLSsOZ7LqubRv
UUTnXMhH6NLiTZxdX+shKQDq1moj9k2Mi3C8V7iKI69Hnk9pajPmGHiyj8c7xEnZ
K6fUU2eTzXccIH5i40qCinuh61YJrZu8BguQLqCyJMDr/vQ7fHOejjMVxYpHeBJU
qzdiv0tJ+Jv/vDSDOI7BkJ6fxQGiCQ==
=iEbb
-----END PGP SIGNATURE-----

--sbMRmyzoAvyCYYfk--


