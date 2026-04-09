Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC68EA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wApZ3-0000B5-4J; Thu, 09 Apr 2026 09:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wApYq-0000AZ-PX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wApYo-0002q4-9r
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 09:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775741800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qadhq1RgqaOpnkMpQ7Zm5mmTLivcn10ymOSLhVpNaHE=;
 b=XQS/aWyQ74uST4g/0VVmm57oof5vDwfmEzmZzLHJogxyE5qJXp7F6/nytYWjZKXb11XwST
 yq3uGYtwrvCxD56GHZL/MJkhVQ4aIdDzJwnzeKrNdBZ29JYzZYnHdvCgusM5sqHJznuXs5
 s0K4I3KJ+ry/3aJCZPGpzsGQnJszoLU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-YNCQz38dNNeWUtyOS15uug-1; Thu,
 09 Apr 2026 09:36:36 -0400
X-MC-Unique: YNCQz38dNNeWUtyOS15uug-1
X-Mimecast-MFC-AGG-ID: YNCQz38dNNeWUtyOS15uug_1775741792
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D870C19560A7; Thu,  9 Apr 2026 13:36:30 +0000 (UTC)
Received: from localhost (unknown [10.44.34.179])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0C29195608E; Thu,  9 Apr 2026 13:36:27 +0000 (UTC)
Date: Thu, 9 Apr 2026 09:36:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 7/8] hw/nvme: add basic live migration support
Message-ID: <20260409133625.GC340896@fedora>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
 <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
 <20260408182708.GA319710@fedora>
 <CAJqdLro7E0mhdanbaE-xQUAzk1W7qYKN1QoEe8KH4VhsitiUmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JqT1BtkDSTA/OB+x"
Content-Disposition: inline
In-Reply-To: <CAJqdLro7E0mhdanbaE-xQUAzk1W7qYKN1QoEe8KH4VhsitiUmw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


--JqT1BtkDSTA/OB+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 09:55:10PM +0200, Alexander Mikhalitsyn wrote:
> Am Mi., 8. Apr. 2026 um 20:27 Uhr schrieb Stefan Hajnoczi <stefanha@redha=
t.com>:
> >
> > On Tue, Apr 07, 2026 at 09:02:26PM +0200, Alexander Mikhalitsyn wrote:
> > > Am Di., 7. Apr. 2026 um 17:48 Uhr schrieb Stefan Hajnoczi <stefanha@r=
edhat.com>:
> > > >
> > > > On Tue, Mar 17, 2026 at 11:27:07AM +0100, Alexander Mikhalitsyn wro=
te:
> > > > > +    /* wait when all in-flight IO requests (except NVME_ADM_CMD_=
ASYNC_EV_REQ) are processed */
> > > > > +    for (i =3D 0; i < n->num_queues; i++) {
> > > > > +        NvmeRequest *req;
> > > > > +        NvmeSQueue *sq =3D n->sq[i];
> > > > > +
> > > > > +        if (!sq)
> > > > > +            continue;
> > > > > +
> > > > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->=
head, sq->tail, sq->size);
> > > > > +
> > > > > +wait_out_reqs:
> > > > > +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> > > > > +            if (req->cmd.opcode !=3D NVME_ADM_CMD_ASYNC_EV_REQ) {
> > > > > +                cpu_relax();
> > > > > +                goto wait_out_reqs;
> > > > > +            }
> > > > > +        }
> > > > > +
> > > > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait_end(n, i, =
sq->head, sq->tail);
> > > > > +    }
> > > >
> > >
> > > Hi Stefan,
> > >
> > > > Emulated storage controllers usually do not drain requests themselv=
es.
> > > > They rely on core migration code (e.g. migration_completion_precopy=
())
> > > > to stop vCPUs and call bdrv_drain_all_begin/end() to quiesce I/O. W=
hy
> > > > does NVMe busy wait for requests here?
> > >
> > > I rely on core migration code to stop vCPUs and drain requests, *but*
> > > a challenge here is that
> > > a concept of "in-flight" request in NVMe is not that simple and we
> > > have a few different types of in-flight requests:
> > > - request was written in SQ (sq->head !=3D sq->tail) -> this I don't
> > > even consider as in-flight, because we just stop SQ processing
> > >   and these requests don't require any special handling during migrat=
ion
> > > - request was taken from SQ by nvme_process_sq() and it now lives in
> > > sq->out_req_list - this means that
> > >   we have also initialized req->aiocb and submitted IO for processing
> > > in QEMU block layer. After request is processed, completion callback
> > >   will be called (for read/write requests it is
> > > nvme_rw_complete_cb()), then nvme_enqueue_req_completion() will be
> > > called and remove
> > >   NvmeRequest from sq->out_req_list and put it into cq->req_list.
> > >   I expect, that by the time when we enter nvme_ctrl_pre_save(),
> > > bdrv_drain_all_begin/end() were called and
> > >   all AIO is finished and sq->out_req_list is empty (except AERs).
> > > *But* to be on a safe side I also added busy loop on
> > >   sq->out_req_list.
> > >
> > > So, I tend to agree that this busy wait is probably not required, but
> > > I believe that we still need to verify that sq->out_req_list
> > > is in fact empty. Because if we messed up, then it's better to crash
> > > on assert() than to have silent data corruption.
> > >
> > > Then after I have a loop cq->req_list, and this time it is absolutely
> > > required because we need to write all NvmeRequest
> > > results to CQ and free NvmeRequest structure, cause I didn't want to
> > > deal with NvmeRequest serialization.
> >
> > I don't see how the busy wait approach can work since
> > migration_completion_precopy() holds the Big QEMU Lock
> > (bql_lock()/bql_unlock()) while .pre_save() is called. The main loop
> > thread's event loop will not be able to make progress while .pre_save()
> > is busy waiting.
>=20
> Yes, my bad. Good catch! You are absolutely right.
>=20
> This is especially stupid mistake from my side, taking into account
> that I *knew* about that we hold BQL
> in this context, cause in my first version of this patchset I *was*
> taking this into account:
> https://lore.kernel.org/qemu-devel/20260217152517.271422-5-alexander@miha=
licyn.com/
>=20
> see comment before qemu_bh_cancel(n->admin_cq.bh).
>=20
> Thanks, Stefan! ;)

No worries. The good news is that we don't need to worry about race
conditions due to device state changing while .pre_save() runs :).

Stefan

--JqT1BtkDSTA/OB+x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnXq1kACgkQnKSrs4Gr
c8i0OQf/SWqT/byrereK8zjIY5i5ggaZ10XK2quyF72oWdTgUQeZMHcHVjrOxIlP
CZle0vv+WkYn4xR6WbXAGjvG3O+kaNllzqY9PmBHjZCUzGtDJh/Wo9E6Hcowr4jg
eCg48fS7LhodeVZtDI3lXC+tzHuzSCvAmTpjTE0I27yQLJjvpCjeb3GahO+OzOHv
+tk5niDsrpz/Yr/xzgbSC9dFIMfCJUzx1Ah2zJai8uWiRfAeIefff8M8cCCeDsjz
mn8A54ixidiGe8oBhLfnr7D2lQLCGLjk0gloGzerJ5Fwee1PgWK8qLShaLOzRwTW
LAQyZpqN/93vcCD6U/H8JDvzs084ug==
=gxB9
-----END PGP SIGNATURE-----

--JqT1BtkDSTA/OB+x--


