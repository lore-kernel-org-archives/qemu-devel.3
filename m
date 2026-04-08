Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565610F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXkr-0008RG-00; Wed, 08 Apr 2026 14:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wAXke-0008OH-Hl
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wAXkc-0005KK-2P
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775673339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P4NqgrViJUKON9F+uqRiBKsZ5OKMd2+LRMUxdKCAi1A=;
 b=LNxyNO7jzidvl8zNKGX7HMfhfraKv4SQwTcoAnE7rYDMuUN6YMaAetZkn4HFpdV7EZJihP
 iqICmwKWWQEBO6jYbQVsgNQLK1ese/rZojSFqzgfJVDvScL88Df3zPPAM11FVzobyVE4hi
 b3RcrsoB154uxQpcAy646wXbiOTivBE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-tvsZaieXOcmZVFlML6lhjg-1; Wed,
 08 Apr 2026 14:35:38 -0400
X-MC-Unique: tvsZaieXOcmZVFlML6lhjg-1
X-Mimecast-MFC-AGG-ID: tvsZaieXOcmZVFlML6lhjg_1775673335
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A57318002CB; Wed,  8 Apr 2026 18:35:34 +0000 (UTC)
Received: from localhost (unknown [10.44.48.42])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A13E61800756; Wed,  8 Apr 2026 18:35:31 +0000 (UTC)
Date: Wed, 8 Apr 2026 14:35:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 7/8] hw/nvme: add basic live migration support
Message-ID: <20260408183529.GB319710@fedora>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
 <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
 <adX4oSW5u1k0nLOk@AALNPWKJENSEN.aal.scsc.local>
 <CAJqdLrrBosYRyh8A75bJv9tvgQx5VWxgZuS_E1G=-28YpaBSyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6JBJpNwEeOXe3j5q"
Content-Disposition: inline
In-Reply-To: <CAJqdLrrBosYRyh8A75bJv9tvgQx5VWxgZuS_E1G=-28YpaBSyw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--6JBJpNwEeOXe3j5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 01:31:33PM +0200, Alexander Mikhalitsyn wrote:
> Am Mi., 8. Apr. 2026 um 08:41 Uhr schrieb Klaus Jensen <its@irrelevant.dk=
>:
> >
> > On Apr  7 21:02, Alexander Mikhalitsyn wrote:
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
> >
> > Correct. When nvme_rw_complete_cb (and friends) returns, we still have
> > the completion laying around, not posted on the CQ. That is queued up
> > for a BH to handle to coalesce CQE posting.
> >
> > > So, I tend to agree that this busy wait is probably not required, but
> > > I believe that we still need to verify that sq->out_req_list
> > > is in fact empty. Because if we messed up, then it's better to crash
> > > on assert() than to have silent data corruption.
> > >
> > > Then after I have a loop cq->req_list, and this time it is absolutely
> > > required because we need to write all NvmeRequest
> > > results to CQ and free NvmeRequest structure, cause I didn't want to
> > > deal with NvmeRequest serialization.
> > >
>=20
> Hi Klaus,
>=20
> >
> > There is a subtle catch here. There may not be room in the CQ to post
> > all CQEs. For example, in the extreme, the host has allocated a CQ with
> > room for 1 entry (size 2) and several deep SQs all associated with the
> > same CQ. If the controller has nowhere to post CQEs, then we need to
> > either abort migration (and try again) or migrate the CQEs.
>=20
> Exactly. This is why I have a next loop, where I ensure that
> cq->req_list is empty
> and also check nvme_cq_full(cq) to ensure that all CQEs can be posted.

Hi Alexander,
nvme_cq_full(cq) will never become false because the migration thread
holds the Big QEMU Lock while calling .pre_save(). The busy loop will
hang forever. See my reply to an earlier email in this thread for
details.

A qtest test case would be useful here (see tests/qtest/nvme-test.c) to
fill the CQ and live migrate. It might be tricky to deterministically
run .pre_save() (via the `migrate` QMP command) before nvme_post_cqes()
gets called, but then you'd have a test case that covers the CQ full
code path.

Stefan

--6JBJpNwEeOXe3j5q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnWn/EACgkQnKSrs4Gr
c8icMwf/X3fxEUNVX0ovKWkReO/TLjCksJfCQDRtkhNlqZE4+yACW3qZGk6405l/
ABACCO+5ETwlCwkQwIo9oDVCSqIRrGrCLr1pbU0q4/1Blv9xlu00BQsrCSo3G7n5
nFaVyxKpSch6+jbxEm1iLJ2aqQeNzlN3Da2HCXxBTuc951cf9U9RbwE5bcTPsupn
HWpC279Y1nAf1mSbNTTNvM0d4LVALI4Sma10q6i+sMy0C/hvXE7Ubl4zAysH8Itc
SSNwJPpDCw1f0WrZiWfRwrp/YD5GxX863Y593AeXWHNowaUG1EkMldI9anEnM+P1
CvwKTbiHwf6pYZNuZcqEwo+YYfUGTw==
=doGj
-----END PGP SIGNATURE-----

--6JBJpNwEeOXe3j5q--


