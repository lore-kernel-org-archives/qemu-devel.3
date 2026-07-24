Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11452C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBuY-00050k-Tg; Fri, 24 Jul 2026 05:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wnBuX-00050V-Bh; Fri, 24 Jul 2026 05:09:41 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wnBuV-00084b-9K; Fri, 24 Jul 2026 05:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=4oLR3ct1SOUCbNc1Rj4wITWK9NuFxu4Fe8dyKwfXhdY=; b=tZo3fQGIBcDcwr0E6/8ZttCIHl
 N9I+bw5Cjxp/W6agFtGbmiNt7y0DiY5Lb+kotlyVWjI//tU3Y+1c6Dl3u6PiqUdMBHahGOdImI1Vr
 igSd1/tqeh9GcWY5aG4A5h8Wfxn+aslym5yvMXal/AtPoinRYIIqG8Uw8vhL6kqB7RqhcpdOiDQmd
 Fgs7Pmmn3TCvzpELcqhG6BQd3dwYA4uhbIpINMUXV+tcHPobOUjQ0ziuwzOPiEPn0Ygd437HZvw5W
 xEzQ1kwqmGUJDXxsUMVCif/6bqZmIsurT62/Yt6kPx6ilgBVd2kQBjd53AM7RQRaFuBk6YpeFUAiU
 kbsGHj+5hVzEX6/AuMTgmFPdJ2a8+2D6KftA8L7j/sQXBECLuyo71PX9OBmY+KFziuz09+IcGJ98j
 Ys4rCOOcXDBhNZ8C6zixxRGQsyXAMXTvVKfS80x4hqxjXeskFsvhSHc66haxyvgbx/JFbp1fG3T9Y
 lWxz/iC3sw8yxOkzuAQBGgELZPP7ZDletauulWDkBAX5bfRUkCqDOKCcx/BTN/gBGPUGO6zxnmeWr
 Z3Hvl7uVJ0sPVFZUTezFMfFYvwUJjxM2pRElegardbR23AGJGFCDGrAFS2cIbMDRv3I5Do/GR06XO
 L7xr7JIBfXO1OxC7AwSPeM5kbs/8BsYnl17cTXy20=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v3 2/2] hw/9pfs/xen: drain in-flight PDUs before xen-9p
 disconnect
Date: Fri, 24 Jul 2026 11:09:33 +0200
Message-ID: <118995374.nniJfEyVGO@weasel>
In-Reply-To: <52b6e2f7-6b44-4d6c-b69d-090deaffda13@oss.qualcomm.com>
References: <cover.1784809978.git.qemu_oss@crudebyte.com>
 <82bc736158e827e05d4b55da27c39d42e2062e96.1784809978.git.qemu_oss@crudebyte.com>
 <52b6e2f7-6b44-4d6c-b69d-090deaffda13@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, 24 July 2026 09:49:57 CEST Philippe Mathieu-Daud=C3=A9 wrote:
> On 23/7/26 14:43, Christian Schoenebeck wrote:
> > The xen-9p disconnect path has two issues:
> >=20
> > 1. It frees the Xen9pfsRing structures while in-flight PDUs may still
> >=20
> >     reference them via pdu->tag to index rings[]. This causes a UAF
> >     in xen_9pfs_push_and_notify() when worker threads resume after
> >     completing filesystem operations.
> >=20
> > 2. It never calls v9fs_device_unrealize_common(), which means server
> >=20
> >     state (struct LocalData, mountfd, FIDs) is never cleaned up on
> >     disconnect, causing a resource leak on every guest-initiated
> >     disconnect.
> >=20
> > Fix both by draining in-flight PDUs via v9fs_reset() before tearing
> > down rings, and calling v9fs_device_unrealize_common() to clean up
> > server state.
> >=20
> > Additionally, explicit calls of xen_9pfs_disconnect() in the error
> > paths of xen_9pfs_pdu_vmarshal() and xen_9pfs_pdu_vunmarshal() must
> > be deferred (via aio_bh_schedule_oneshot()), because
> > xen_9pfs_pdu_v(un)marshal() are running within a coroutine context
> > which makes them unsafe [1] for calling v9fs_reset() directly, as
> >=20
> > the latter e.g. has a loop like:
> >      while (!QLIST_EMPTY(&s->active_list)) {
> >     =20
> >          aio_poll(qemu_get_aio_context(), true);
> >     =20
> >      }
> >=20
> > which would a) never terminate (as the coroutine is on the
> > active_list) and b) aio_poll() is marked as no_coroutine_fn.
> >=20
> > [1] https://lore.kernel.org/qemu-devel/3351181.5fSG56mABF@weasel/
> >=20
> > And finally, add an idempotent guard to xen_9pfs_disconnect()
> > for the v9fs_reset(s) and v9fs_device_unrealize_common(s) calls
> > specifically [2], just to be sure.
> >=20
> > [2]
> > https://lore.kernel.org/qemu-devel/alpine.DEB.2.22.394.2607221815520.52=
95
> > @ubuntu-linux-20-04-desktop/
> >=20
> > Fixes: b37eeb0201 ("xen/9pfs: introduce Xen 9pfs backend")
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > ---
> >=20
> >   hw/9pfs/9p.c             |  1 +
> >   hw/9pfs/xen-9p-backend.c | 17 +++++++++++++++--
> >   2 files changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 3119f01117..fc01791830 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -4530,6 +4530,7 @@ void v9fs_device_unrealize_common(V9fsState *s)
> >=20
> >       qp_table_destroy(&s->qpp_table);
> >       qp_table_destroy(&s->qpf_table);
> >       g_free(s->ctx.fs_root);
> >=20
> > +    s->transport =3D NULL;
> >=20
> >   }
> >  =20
> >   typedef struct VirtfsCoResetData {
> >=20
> > diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> > index 24c90d97ec..a2f118d2ca 100644
> > --- a/hw/9pfs/xen-9p-backend.c
> > +++ b/hw/9pfs/xen-9p-backend.c
> > @@ -68,6 +68,11 @@ typedef struct Xen9pfsDev {
> >=20
> >   static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev);
> >=20
> > +static void xen_9pfs_disconnect_bh(void *opaque)
> > +{
> > +    xen_9pfs_disconnect(opaque);
> > +}
> > +
> >=20
> >   static void xen_9pfs_in_sg(Xen9pfsRing *ring,
> >  =20
> >                              struct iovec *in_sg,
> >                              int *num,
> >=20
> > @@ -150,7 +155,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
> >=20
> >                         "Failed to encode VirtFS reply type %d\n",
> >                         pdu->id + 1);
> >          =20
> >           xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> >=20
> > -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                xen_9pfs_disconnect_bh,
> > &xen_9pfs->xendev);>=20
> >       }
> >       return ret;
> >  =20
> >   }
> >=20
> > @@ -173,7 +179,8 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
> >=20
> >           xen_pv_printf(&xen_9pfs->xendev, 0,
> >          =20
> >                         "Failed to decode VirtFS request type %d\n",
> >                         pdu->id);
> >          =20
> >           xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
> >=20
> > -        xen_9pfs_disconnect(&xen_9pfs->xendev);
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                                xen_9pfs_disconnect_bh,
> > &xen_9pfs->xendev);>=20
> >       }
> >       return ret;
> >  =20
> >   }
> >=20
> > @@ -368,10 +375,16 @@ static void xen_9pfs_evtchn_event(void *opaque)
> >=20
> >   static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
> >   {
> >  =20
> >       Xen9pfsDev *xen_9pdev =3D container_of(xendev, Xen9pfsDev, xendev=
);
> >=20
> > +    V9fsState *s =3D &xen_9pdev->state;
> >=20
> >       int i;
> >      =20
> >       trace_xen_9pfs_disconnect(xendev->name);
> >=20
> > +    if (s->transport) {
> > +        v9fs_reset(s);
>=20
> Maybe v9fs_reset() is misnamed.
>=20
> What about v9fs_cancel_in_flight()?

The name v9fs_cancel_in_flight() would be too narrow. v9fs_reset() does two=
=20
things:

  1. draining all in-flight PDUs

  2. freeing all FIDs (and their associated hash table)

Therefore IMO v9fs_reset() more appropriately describes a reset of server=20
state. v9fs_reset() already exists for almost 10 years:

  commit 0e44a0fd3f28cccb8963fdfc05c53c546b3f46b6
  Author: Greg Kurz <groug@kaod.org>
  Date:   Mon Oct 17 14:13:58 2016 +0200

      virtio-9p: add reset handler
   =20
      Virtio devices should implement the VirtIODevice->reset() function to
      perform necessary cleanup actions and to bring the device to a quiesc=
ent
      state.
   =20
      In the case of the virtio-9p device, this means:
      - emptying the list of active PDUs (i.e. draining all in-flight I/O)
      - freeing all fids (i.e. close open file descriptors and free memory)

      ...

And even though the aspect of draining in-flight PDUs is focused and releva=
nt=20
for this particular security patch to prevent the mentioned UAF, it is stil=
l=20
correct and expected to do a full server reset here.

>=20
> > +        v9fs_device_unrealize_common(s);
>=20
> IIUC xen_9pfs_disconnect() is mixing XenDevOps::disconnect()
> and XenDevOps::free()?

While you are correct with your observation that it does mix the two things=
, I=20
fear this is required right now. Separating them would be cleaner and=20
possible, but it would require significant changes. And if you review my=20
discussions with Stefano in the previous versions of this series, you might=
=20
realize that this code is somewhat tricky and not trivial.

And finally:

1. These patches are addressing real security issues.

2. Your concerns are pure code organizational issues, no behaviour issues.

3. These structural issues exist for many (9?) years.

4. Changing this struture might introduce new issues.

5. We are already very close to release.

6. This series (v1) was posted already 3 weeks ago.

7. I have a bunch of other important fixes in my queue that I should send a=
 PR

So we can probably agree that this should not be within the scope of these=
=20
security patches?
=20
> > +    }
> > +
> >=20
> >       for (i =3D 0; i < xen_9pdev->num_rings; i++) {
> >      =20
> >           if (xen_9pdev->rings[i].evtchndev !=3D NULL) {
> >          =20
> >               qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i=
].e
> >               vtchndev),





