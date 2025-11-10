Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB8BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU2G-0005tP-6l; Mon, 10 Nov 2025 10:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vIU2E-0005hX-LK
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vIU2B-0008U1-8H
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0JTE+jz3xBFWYNGS5KzB9iASbCNegelCDeyLvIjVCA=;
 b=he9Q5qChFfggS08jrv27JGP8vsXcZpcDK/Sf8l94jJ3k8YQPdYcnAVdRB6MQh25OAnbX8T
 z7cFZDgJ8a4o6zsqQH/WZviMwP8dG2vzfqhTJW93kHRffrexQUVPbshbfDaoUxYhTtQPwI
 rFm3k9cL33jJ7MRR9ZFJDpHLBoJ0Yg4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-x3xqCC_qM0ucmXAERR2_TA-1; Mon, 10 Nov 2025 10:42:18 -0500
X-MC-Unique: x3xqCC_qM0ucmXAERR2_TA-1
X-Mimecast-MFC-AGG-ID: x3xqCC_qM0ucmXAERR2_TA_1762789337
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4774836c376so16700765e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789337; x=1763394137; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D0JTE+jz3xBFWYNGS5KzB9iASbCNegelCDeyLvIjVCA=;
 b=Hb7zPuh5yAzSJXb8CShPfBD113pGqCXjntcm85uEs0Pf/iliPc58pvj1M6MlyKndxV
 6tTB02JpTnRqCpobMFYdFCtoFnIrtbl4ncGYAevr6YMmOAXW9U5nSjRmmcj16kax/HK6
 pdNVlqstTQV+oZn/pqVxZMAtphWeor6uw5J5pJf6mrEua2iBwNX3TU4dhVSAfeBUjjZ+
 IAzGcEsTV1OOSapyOEKXhUIC9WU7MSHEmOSR6jdXEtkIDBDe7gAZkGKDh+038kN9coJA
 +qjNfT7fhQ91waUJ5+6JcEbggSF9s6N12AoK/tpDWWWcQlgPL/9flYbbZCDD8v4tf3vA
 iQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789337; x=1763394137;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0JTE+jz3xBFWYNGS5KzB9iASbCNegelCDeyLvIjVCA=;
 b=GkeCq4yxtg7+g4vmGT0xK3er9BhrfnU0gKKPUvg+t2IiyUi2ObhQrfUWeWIfrv7N1N
 ucHqmbYEs83TZfYdjJN+etJKfmwU3qVXFZnsI9JqXORbQnpswDpoXMu3ftlnjbiqXeu+
 VPW9eRlZ5T+EljdVTfhm1j2y/1+mv7GZzjyL8RokYkucgAYNphGkFDreDDQvNu9j4z2C
 pYBoSHFoC8WdmsSZZBlYV6ncy69ZMiXWeppKL89g8HNfXfkU9K1d5mGcHF+VFsSBzuBH
 5wGdZ2hrwYlQwwTADDol8eQuJtX+v/MPNgg8LDi3ckr3XfFS06cIzUL4tD2Lc0jKeXr7
 PDZg==
X-Gm-Message-State: AOJu0Yy7EkhAt6t/v22H5U/ZYHWIPmwP/hB9Jkhlo2nq+WwYWLTZs2et
 1uW69f+v7P/DlTiQ1CuJhOpGcdQnimrksW8t43eSoIWWcN2jkJF3mgdc6GlszGZlacxOpXI1h7C
 9T0VvMR2rpxT8aM4XtQq/y2/50qfvnhc2GrEbNdlaAtw+GNeuyTMIdsWB
X-Gm-Gg: ASbGncuYO+P+xuj7pKrjIY+Db2gyZoLrQ0o6l76w+/ybJfpHRGZhlsR6obY5bI3+udG
 3c5Pexh+RHx2py1YtehhnQ/X96cOF9cxtuPOWynHnzp8QSssNw19f18fwdiUQguvwR7xXHqVP4q
 nqY4y17K6rUiuk1/AmzgMW3E2rxg9/V7mIPQRoeDuY9ZKMhKimg1D6MHZO2hRt9SCJI7jtPU1Sv
 pULmLWVuKhOci3Y3wCadUZp304wHOZJaHTr4iD6JB7rFsikeVsu3z4vJmLSX1KQwVonhRP7cFtE
 4CfRvdZmoRN6QEhIfJWkU/44EXOge6KgaIIBbIp+Zo5Y7BurHByK7ua5CFYblVUSFB0=
X-Received: by 2002:a7b:c8c8:0:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-4777327703emr46004485e9.20.1762789336968; 
 Mon, 10 Nov 2025 07:42:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjRdjT4RJyQCDy7C8lXCVsJBgDiuFYNGcYa+Vs0xpx75pUJb0OemKdoM1OT1TZRaMMtwO5oA==
X-Received: by 2002:a7b:c8c8:0:b0:471:1765:839c with SMTP id
 5b1f17b1804b1-4777327703emr46004205e9.20.1762789336319; 
 Mon, 10 Nov 2025 07:42:16 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac675ca86sm23015965f8f.31.2025.11.10.07.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:42:15 -0800 (PST)
Date: Mon, 10 Nov 2025 10:42:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PULL 04/14] vhost-user: fix shared object lookup handler logic
Message-ID: <20251110104059-mutt-send-email-mst@kernel.org>
References: <cover.1762698873.git.mst@redhat.com>
 <fde5930cc37175cfcd0f03a089e26f4458a52311.1762698873.git.mst@redhat.com>
 <CADSE00+FLWVdh1CGmy6i4hLdJOKGG6-4JZySXL=wFOyyTnnFpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+FLWVdh1CGmy6i4hLdJOKGG6-4JZySXL=wFOyyTnnFpw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 10, 2025 at 10:23:25AM +0100, Albert Esteve wrote:
> On Sun, Nov 9, 2025 at 3:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Albert Esteve <aesteve@redhat.com>
> >
> > Refactor backend_read() function and add a reply_ack variable
> > to have the option for handlers to force tweak whether they should
> > send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
> > flag.
> >
> > This fixes an issue with
> > vhost_user_backend_handle_shared_object_lookup() logic, as the
> > error path was not closing the backend channel correctly. So,
> > we can remove the reply call from within the handler, make
> > sure it returns early on errors as other handlers do and
> > set the reply_ack variable on backend_read() to true to ensure
> > that it will send a response, thus keeping the original intent.
> 
> Hey Michal,
> 
> This patch was
> Based-on: <20251016143827.1850397-1-aesteve@redhat.com>
> … for main.

That's the SHMEM thing right?  Yes but I rebased it dropping
the SHMEM dependency.

At least, I think I did it correctly.

> As this was the first time I did this based-on thingy, I am just
> making sure that the other patch was not missed.
> If this PULL is only targeting stable, then it's ok as is.

It is targeting 10.2 which is in freeze. So equivalently same.


> BR,
> Albert
> 
> >
> > Fixes: 1609476662 ("vhost-user: add shared_object msg")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Message-Id: <20251017072011.1874874-2-aesteve@redhat.com>
> > ---
> >  hw/virtio/vhost-user.c | 40 +++++++++++++---------------------------
> >  1 file changed, 13 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index aac98f898a..4b0fae12ae 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc, VhostUserHeader *hdr,
> >      return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> >  }
> >
> > -static bool
> > -vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr,
> > -                                  VhostUserPayload *payload, Error **errp)
> > -{
> > -    hdr->size = sizeof(payload->u64);
> > -    return vhost_user_send_resp(ioc, hdr, payload, errp);
> > -}
> > -
> >  int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
> >                                   int *dmabuf_fd)
> >  {
> > @@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
> >
> >  static int
> >  vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> > -                                               QIOChannel *ioc,
> > -                                               VhostUserHeader *hdr,
> > -                                               VhostUserPayload *payload)
> > +                                               VhostUserShared *object)
> >  {
> >      QemuUUID uuid;
> >      CharFrontend *chr = u->user->chr;
> > -    Error *local_err = NULL;
> >      int dmabuf_fd = -1;
> >      int fd_num = 0;
> >
> > -    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid));
> > +    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> >
> > -    payload->u64 = 0;
> >      switch (virtio_object_type(&uuid)) {
> >      case TYPE_DMABUF:
> >          dmabuf_fd = virtio_lookup_dmabuf(&uuid);
> > @@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >      {
> >          struct vhost_dev *dev = virtio_lookup_vhost_device(&uuid);
> >          if (dev == NULL) {
> > -            payload->u64 = -EINVAL;
> > -            break;
> > +            return -EINVAL;
> >          }
> >          int ret = vhost_user_get_shared_object(dev, uuid.data, &dmabuf_fd);
> >          if (ret < 0) {
> > -            payload->u64 = ret;
> > +            return ret;
> >          }
> >          break;
> >      }
> >      case TYPE_INVALID:
> > -        payload->u64 = -EINVAL;
> > -        break;
> > +        return -EINVAL;
> >      }
> >
> >      if (dmabuf_fd != -1) {
> > @@ -1757,11 +1743,6 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >
> >      if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> >          error_report("Failed to set msg fds.");
> > -        payload->u64 = -EINVAL;
> > -    }
> > -
> > -    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_err)) {
> > -        error_report_err(local_err);
> >          return -EINVAL;
> >      }
> >
> > @@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> >      struct iovec iov;
> >      g_autofree int *fd = NULL;
> >      size_t fdsize = 0;
> > +    bool reply_ack;
> >      int i;
> >
> >      /* Read header */
> > @@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> >          goto err;
> >      }
> >
> > +    reply_ack = hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> > +
> >      /* Read payload */
> >      if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_err)) {
> >          error_report_err(local_err);
> > @@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> >                                                               &payload.object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> > -        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
> > -                                                             &hdr, &payload);
> > +        /* The backend always expects a response */
> > +        reply_ack = true;
> > +        ret = vhost_user_backend_handle_shared_object_lookup(dev->opaque,
> > +                                                             &payload.object);
> >          break;
> >      default:
> >          error_report("Received unexpected msg type: %d.", hdr.request);
> > @@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
> >       * REPLY_ACK feature handling. Other reply types has to be managed
> >       * directly in their request handlers.
> >       */
> > -    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> > +    if (reply_ack) {
> >          payload.u64 = !!ret;
> >          hdr.size = sizeof(payload.u64);
> >
> > --
> > MST
> >


