Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E0ECCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 07:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9eVL-0005o7-WE; Fri, 17 Oct 2025 03:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9eVJ-0005ne-DW
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1v9eVG-0006IN-0o
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 03:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760684632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EyiW/ItzXtKEEfqyc+xYp+e2elzmoy1LJx4m2/X1FW4=;
 b=iI+WBfy33lueAoj70cdSRHoeXPjr59Q/H6tNuULcNKpYfbIrkUwBL69iQiYG8l9/dfcCds
 j74amvWNmBZVmCpI716nqZ5pnb7BLAjs55y2rGfNKbGk0fXJ1elhub/s4xJtuzlbMtdKmA
 u3krSxlz6lU25AnYzUvFwxZirPRVXU0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-8ta8AY92M9a_kR5nEunNwQ-1; Fri, 17 Oct 2025 03:03:50 -0400
X-MC-Unique: 8ta8AY92M9a_kR5nEunNwQ-1
X-Mimecast-MFC-AGG-ID: 8ta8AY92M9a_kR5nEunNwQ_1760684630
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-277f0ea6ee6so18591035ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 00:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760684629; x=1761289429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyiW/ItzXtKEEfqyc+xYp+e2elzmoy1LJx4m2/X1FW4=;
 b=S9q8akcvnDZL3Zgje90OtIIWAHMs8i1R87Gfmg0Z00rLmb8C4U3qOyEkp3ZuCqGCXS
 4jT+iEgvtLzFUjnejocLelpZAj3vsEtPWy1cAOcyo3Vv1Vw7fdTvWAdCZzBp5pJX+QJs
 Ftxbgs8Br5opUPyN7NYpea/0uSPLUu3Wua+IZwzTUkQT95TlYJ6qPh+O8u1+iFriwixj
 8D08k7JNByNuVZGDOGSOKOTFaAChgaNT0gJYPwS5UnKlb58BfGcMdqw2i3RfTKELgq+/
 Nm47LJ7gjgo+eAYndvIPgaoo9mfycIF8jOHO0jFokku9Ykzwu6TcWN0Mp4BvCo0ToX8L
 Ke3Q==
X-Gm-Message-State: AOJu0YyG+MFDE3M+QK2jQSMuomzTH+wg56/e2rAQ8YwKIn5nNEbwHh09
 YB7ckffteJTOnuNZ6jBPgD9GlRE5p/FUc0wSGI2EpNDEZWIGcDLLftB3lISK/pUjQ7IN41F/DY9
 lO7/qx/xl9Ss6K+/wgPX9gS2Pp6fQOSKvEybHW1Q8iJThKeWrSLRNLFim0IKAuBdJXMBbdh168N
 9AQ3b8V4GsTwqLuQZiZg0txo5/sazBGU4yJs0uRlc09Q==
X-Gm-Gg: ASbGncu4TmWO1G+sFe9kg9hNhtHke01UPV9mKNptfTSvrahmMC2MDY+6TURYpYcGAoD
 53XI+zTXsyt0g3uNWHRdl+pmjMmkTT6Uho5/QMSgOjJ9pu/MlCvzmzTsogHyS8HM+ZGf2xv2xKj
 Z37pzPAu6TEjZR7a6DWqCusfBtosvMebWY/KIrxPAkoRaBbsdcqFQ=
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id
 d9443c01a7336-290caf831cdmr34118175ad.39.1760684629438; 
 Fri, 17 Oct 2025 00:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFhTemW5wdnVmod39DboJHG8P8nyoMICsIgYtQIoMrT+aboiULK1q+agGeOsHolZwh5/HjpHF9nOyHTjX+4JY=
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id
 d9443c01a7336-290caf831cdmr34117905ad.39.1760684628963; Fri, 17 Oct 2025
 00:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251015124314.1588018-1-aesteve@redhat.com>
 <zey3wf53mapbrc25xwal3dia5fb4tddyxghvzjpy2p2fm6cdcp@7dlkcuzpcoho>
In-Reply-To: <zey3wf53mapbrc25xwal3dia5fb4tddyxghvzjpy2p2fm6cdcp@7dlkcuzpcoho>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Oct 2025 09:03:37 +0200
X-Gm-Features: AS18NWAww3DAbEAFGn4ceWTyCzNC_iDI3UGX6cd5RXK5riOSBOToyzaNSxM_88E
Message-ID: <CADSE00+=TyrTJfjMN8fKuNY8gK1V0BYjCXh32aQhW-eQSiNcpA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost-user: fix shared object lookup handler logic
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
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

On Wed, Oct 15, 2025 at 2:57=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Oct 15, 2025 at 02:43:14PM +0200, Albert Esteve wrote:
> >Refactor backend_read() function and add a reply_ack variable
> >to have the option for handlers to force tweak whether they should
> >send a reply or not without depending on VHOST_USER_NEED_REPLY_MASK
> >flag.
> >
> >This fixes an issue with
> >vhost_user_backend_handle_shared_object_lookup() logic, as the
> >error path was not closing the backend channel correctly. So,
> >we can remove the reply call from within the handler, make
> >sure it returns early on errors as other handlers do and
> >set the reply_ack variable on backend_read() to true to ensure
> >that it will send a response, thus keeping the original intent.
> >
> >Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> >Cc: qemu-stable@nongnu.org
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user.c | 40 +++++++++++++---------------------------
> > 1 file changed, 13 insertions(+), 27 deletions(-)
>
> Thanks! This patch LGTM, so
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks, I will send a new version of the patch to base it on
https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg04130.html.
The other patch relies on the REPLY_MASK flag, so I need to add a
`reply_ack =3D false;` or else it'd send two replies.

>
>
> But I left couple of comments that is not related to this fix and maybe
> should be fixed separately:
>
> >
> >diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> >index 36c9c2e04d..8a93f1d4b5 100644
> >--- a/hw/virtio/vhost-user.c
> >+++ b/hw/virtio/vhost-user.c
> >@@ -1668,14 +1668,6 @@ static bool vhost_user_send_resp(QIOChannel *ioc,=
 VhostUserHeader *hdr,
> >     return !qio_channel_writev_all(ioc, iov, ARRAY_SIZE(iov), errp);
> > }
> >
> >-static bool
> >-vhost_user_backend_send_dmabuf_fd(QIOChannel *ioc, VhostUserHeader *hdr=
,
> >-                                  VhostUserPayload *payload, Error **er=
rp)
> >-{
> >-    hdr->size =3D sizeof(payload->u64);
> >-    return vhost_user_send_resp(ioc, hdr, payload, errp);
> >-}
> >-
> > int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *=
uuid,
> >                                  int *dmabuf_fd)
> > {
> >@@ -1716,19 +1708,15 @@ int vhost_user_get_shared_object(struct vhost_de=
v *dev, unsigned char *uuid,
> >
> > static int
> > vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >-                                               QIOChannel *ioc,
> >-                                               VhostUserHeader *hdr,
> >-                                               VhostUserPayload
> >*payload)
> >+                                               VhostUserShared *object)
> > {
> >     QemuUUID uuid;
> >     CharBackend *chr =3D u->user->chr;
> >-    Error *local_err =3D NULL;
> >     int dmabuf_fd =3D -1;
> >     int fd_num =3D 0;
> >
> >-    memcpy(uuid.data, payload->object.uuid, sizeof(payload->object.uuid=
));
> >+    memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> >
> >-    payload->u64 =3D 0;
> >     switch (virtio_object_type(&uuid)) {
> >     case TYPE_DMABUF:
> >         dmabuf_fd =3D virtio_lookup_dmabuf(&uuid);
> >@@ -1737,18 +1725,16 @@ vhost_user_backend_handle_shared_object_lookup(s=
truct vhost_user *u,
> >     {
> >         struct vhost_dev *dev =3D virtio_lookup_vhost_device(&uuid);
> >         if (dev =3D=3D NULL) {
> >-            payload->u64 =3D -EINVAL;
> >-            break;
> >+            return -EINVAL;
> >         }
> >         int ret =3D vhost_user_get_shared_object(dev, uuid.data, &dmabu=
f_fd);
> >         if (ret < 0) {
> >-            payload->u64 =3D ret;
> >+            return ret;
> >         }
> >         break;
> >     }
> >     case TYPE_INVALID:
> >-        payload->u64 =3D -EINVAL;
> >-        break;
> >+        return -EINVAL;
>
> So, after this patch, we are not going to call
> `qemu_chr_fe_set_msgfds()` when we are returning an error to the
> backend. I guess this is even better than before, right?
>
> >     }
> >
> >     if (dmabuf_fd !=3D -1) {
> >@@ -1757,11 +1743,6 @@
> >vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
> >
>
> Should we call qemu_chr_fe_set_msgfds() only if fd_num > 0?
> Or should we return an error if `dmabuf_fd` is not a valid fd?
>
> I guess this is pre-existing and maybe should be fixed in another patch
> if it's a problem.
>
> Thanks,
> Stefano
>
> >     if (qemu_chr_fe_set_msgfds(chr, &dmabuf_fd, fd_num) < 0) {
> >         error_report("Failed to set msg fds.");
> >-        payload->u64 =3D -EINVAL;
> >-    }
> >-
> >-    if (!vhost_user_backend_send_dmabuf_fd(ioc, hdr, payload, &local_er=
r)) {
> >-        error_report_err(local_err);
> >         return -EINVAL;
> >     }
> >
> >@@ -1790,6 +1771,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
> >     struct iovec iov;
> >     g_autofree int *fd =3D NULL;
> >     size_t fdsize =3D 0;
> >+    bool reply_ack;
> >     int i;
> >
> >     /* Read header */
> >@@ -1808,6 +1790,8 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
> >         goto err;
> >     }
> >
> >+    reply_ack =3D hdr.flags & VHOST_USER_NEED_REPLY_MASK;
> >+
> >     /* Read payload */
> >     if (qio_channel_read_all(ioc, (char *) &payload, hdr.size, &local_e=
rr)) {
> >         error_report_err(local_err);
> >@@ -1833,8 +1817,10 @@ static gboolean backend_read(QIOChannel *ioc, GIO=
Condition condition,
> >                                                              &payload.o=
bject);
> >         break;
> >     case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> >-        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que, ioc,
> >-                                                             &hdr, &pay=
load);
> >+        /* The backend always expects a response */
> >+        reply_ack =3D true;
> >+        ret =3D vhost_user_backend_handle_shared_object_lookup(dev->opa=
que,
> >+                                                             &payload.o=
bject);
> >         break;
> >     default:
> >         error_report("Received unexpected msg type: %d.", hdr.request);
> >@@ -1845,7 +1831,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOC=
ondition condition,
> >      * REPLY_ACK feature handling. Other reply types has to be managed
> >      * directly in their request handlers.
> >      */
> >-    if (hdr.flags & VHOST_USER_NEED_REPLY_MASK) {
> >+    if (reply_ack) {
> >         payload.u64 =3D !!ret;
> >         hdr.size =3D sizeof(payload.u64);
> >
> >--
> >2.49.0
> >
>


