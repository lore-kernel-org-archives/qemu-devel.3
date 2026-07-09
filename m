Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B53C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpXv-0000sW-2G; Thu, 09 Jul 2026 10:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whpXt-0000rz-94
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whpXr-0005pd-7F
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783606565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZnP5sp8kDwGqMKewQKR5q6XbY/8qdmfvStgFSn+aPv8=;
 b=f3dzCbLMAkzxNNKPxmr9AUTOAR+DpdD/HZ5Zl8qLsI+C98DLqE4Ife5fqmD22fmcRTNdZO
 Z3IB3YBXFn8aWH+9bO1sbXGvK6sE+os2RdgQDRGNhgjLiglg3drOHaJOgzWNc6j/tTCLpU
 T+srLQW/tXbvUvQD4s3MvCD1Qh7TmhE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Ap62PVPjNWexuXKgD7KcsA-1; Thu, 09 Jul 2026 10:16:04 -0400
X-MC-Unique: Ap62PVPjNWexuXKgD7KcsA-1
X-Mimecast-MFC-AGG-ID: Ap62PVPjNWexuXKgD7KcsA_1783606563
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so8456815e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783606563; x=1784211363; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZnP5sp8kDwGqMKewQKR5q6XbY/8qdmfvStgFSn+aPv8=;
 b=tnGmgk9hBFxN4dXwdnrYXH9e+yiigh23Aqao33O9Fpul8ZczpBMEHg6QliXzCnF9oc
 +4rTdj3ZHOIK8BOlDw+uOCRvRz0rzQG4yJbX79+0y463P+fdhYv1yFMl4bIUDDfai84I
 uY1uLTxhy2fuMADyF5PvVvFduwUM9H/nQG7Es4FwMc2la+mV2G+rZ0b9aBTJN8DMkpsc
 CiUmFBwcjPdSRL8B7a15OLiPPYHr7YpOgD+yipwfSv5VH7scttqljlSpROwahowiowKF
 0fBt0iDvlStQPnGN2WX4HIaY50KnTK7prSXYWZQpbatigOwwnh1anamjqw6+hszz4mS4
 qSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783606563; x=1784211363;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZnP5sp8kDwGqMKewQKR5q6XbY/8qdmfvStgFSn+aPv8=;
 b=bbSwUm+rd5CJMB7PQ1Xo3aB+07z8k/Qn6ahfS44XA8RKUNAJL6+x/D+PALvNtKfxxg
 Qd2s76gGCVaxu7PleLqC4wmnacEiERjsdekrfkEAoTzJcUpANiIXywHMAC5aGLhbZd0T
 fsagVpYQcqJgSAJzNHy7klv7x/oTO4QtTDHJq8BwB0gyZUcG/nKN2/k/Y7kkMsYfH/FA
 +pRISIkNwD0x5ePMbzaYJo2GvnR9TlZ0mV4lZC5tFCAQCj429sRdplhvLvg1vfMU7BmC
 H9h6Ark1O++97LAqkJyAV+CnvFstDeL35/Fq6i4vPh64MvpNCWHKp8uHQv9SIorP7vkq
 OnBA==
X-Gm-Message-State: AOJu0Yy6dm47zl0AAoyIpKaeaMF1QPx8pCb1ivb2J5C4Jm2fNLVNWZAn
 YHy/P9Y2h6mZbO+RbRc1e4PYjS4a3l7AZKznYbqNp0iPo6Ucz7OB2kitU6Dw0BtSnUIJrzIcgww
 f0GrRGj5ZYSGHKDp9OrHUT9Xxzl93+45pPAXi+GkSf1LzXW6R8FPf50H0
X-Gm-Gg: AfdE7cm4wH1q65lYKa513Lj5RVXm08JmcOo0N0wKufAaNyAP9CC6nnscoL/21d67O5J
 ADdQjDdikO9gNKTcF+CtNT4Bm/psA0X2761Ntazr6Y8Gxtkr628abd/VpGZYx2yxde+l+Kua9G0
 okM+RPGvb95vbsNoFodmn+g3dl540ap3GiS2w0AlVNOOwKFsMVIuI7AQcFGll8QsBhHQ22suEDi
 fup2KVIX43BzJijIBWp5q4WvvMLnQCYG9PHjtoxgboG3NV2cpXvARJN7MNbzrDleu7O2XB505J3
 Id/ijMPI6ir4LYs70/PtIBtTcjREmPzNGdNIcqqvU4ccYZ3056zP7dRzkSeCloPXHBpezShc40M
 ITuijO0Uh0pCQqccQDXmxaEiCfAzJ9fVF
X-Received: by 2002:a05:600c:22d2:b0:48a:5f32:62c6 with SMTP id
 5b1f17b1804b1-493ec7754cemr24072715e9.11.1783606562597; 
 Thu, 09 Jul 2026 07:16:02 -0700 (PDT)
X-Received: by 2002:a05:600c:22d2:b0:48a:5f32:62c6 with SMTP id
 5b1f17b1804b1-493ec7754cemr24072385e9.11.1783606562029; 
 Thu, 09 Jul 2026 07:16:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8f1sm52543407f8f.3.2026.07.09.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 07:16:01 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:15:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Amit Shah <amit@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/virtio: return NULL from qemu_get_virtqueue_element()
 on invalid state
Message-ID: <20260709101334-mutt-send-email-mst@kernel.org>
References: <20260709100644.1878369-1-lvivier@redhat.com>
 <20260709083651-mutt-send-email-mst@kernel.org>
 <2fe112be-4caf-47cb-b554-57ebaa1d76fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe112be-4caf-47cb-b554-57ebaa1d76fd@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 09, 2026 at 03:24:31PM +0200, Laurent Vivier wrote:
> On 7/9/26 14:40, Michael S. Tsirkin wrote:
> > On Thu, Jul 09, 2026 at 12:06:44PM +0200, Laurent Vivier wrote:
> > > qemu_get_virtqueue_element() uses assert() to check that the in_num
> > > and out_num fields deserialized from the migration stream do not
> > > exceed VIRTQUEUE_MAX_SIZE. A crafted migration stream can set these
> > > fields to invalid values, hitting the assertion and aborting the
> > > destination QEMU process.
> > > 
> > > Replace the assertions with a bounds check that returns NULL on
> > > failure. Update all callers (virtio-serial-bus, virtio-blk,
> > > virtio-scsi) to handle the NULL return and fail the migration
> > > gracefully.
> > > 
> > > Cc: qemu-stable@nongnu.org
> > > Fixes: 6bdc21c050a2 ("virtio: fix up max size checks")
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3802
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >   hw/block/virtio-blk.c       |  4 ++++
> > >   hw/char/virtio-serial-bus.c |  3 +++
> > >   hw/scsi/virtio-scsi.c       |  4 ++++
> > >   hw/virtio/virtio.c          | 11 ++++-------
> > >   4 files changed, 15 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 6b92066aff4c..42c0f2553f18 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -1384,6 +1384,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
> > >           }
> > >           req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
> > > +        if (!req) {
> > > +            return -EINVAL;
> > > +        }
> > > +
> > >           virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
> > >           WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
> > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > > index c1973f0248fc..879df158608a 100644
> > > --- a/hw/char/virtio-serial-bus.c
> > > +++ b/hw/char/virtio-serial-bus.c
> > > @@ -763,6 +763,9 @@ static int fetch_active_ports_list(QEMUFile *f,
> > >               port->elem =
> > >                   qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
> > > +            if (!port->elem) {
> > > +                return -EINVAL;
> > > +            }
> > >               /*
> > >                *  Port was throttled on source machine.  Let's
> > > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > > index 6c7376801190..8dd0b88a30c4 100644
> > > --- a/hw/scsi/virtio-scsi.c
> > > +++ b/hw/scsi/virtio-scsi.c
> > > @@ -274,6 +274,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
> > >       assert(n < vs->conf.num_queues);
> > 
> > 
> > I mean just above this we have this assert.
> 
> Sure, I can fix that too.
> 
> > 
> > 
> > If you are really want to be nicer about handling
> > malformed input, pls do this systematically, not just
> > at random places for no apparent reason.
> 
> I don't do this randomly for no apparent reason, see
> https://gitlab.com/qemu-project/qemu/-/issues/3802

I am not blaming you, sorry if it sounded like it.
But this is not coming from any customers (how can it)
the fact that someone decided to fuzz our migration
stream and triggered a specific assert *is* random and it does not
mean we will now go and try to focus on the specific things
that triggered in the specific test.


> But I'm going to check if I can remove more assert() in the migration path.
> 
> Thanks,
> Laurent
> 
> > 
> > 
> > >       req = qemu_get_virtqueue_element(vdev, f,
> > >                                        sizeof(VirtIOSCSIReq) + vs->cdb_size);
> > > +    if (!req) {
> > > +        return NULL;
> > > +    }
> > > +
> > >       virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
> > >       if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index f4d86a365530..7bccfdde33e7 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -2167,13 +2167,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
> > >       qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
> > > -    /* TODO: teach all callers that this can fail, and return failure instead
> > > -     * of asserting here.
> > > -     * This is just one thing (there are probably more) that must be
> > > -     * fixed before we can allow NDEBUG compilation.
> > > -     */
> > > -    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
> > > -    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
> > > +    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
> > > +        data.out_num > ARRAY_SIZE(data.out_addr)) {
> > > +        return NULL;
> > > +    }
> > >       elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
> > >       elem->index = data.index;
> > > -- 
> > > 2.54.0
> > 


