Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E92CEE330
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 16:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syZYX-0001eF-1R; Wed, 09 Oct 2024 12:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syZYS-0001dX-Sk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 12:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syZYQ-0001J8-Sf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 12:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728491328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIKorGwMnViXPeDtCPDKuBmOlnthdRDmVeq7jRMRzVA=;
 b=W7d95aEdZhYB8Evhc8I4bZEjTruXBJqDTV6G6l0iXFeSH5gVw2H9cnlzlcSWbLGW+OboSy
 +jTndCx+S97WimpmoEfTFOK8VE7yNKQ0FNMX83a3YF7p+rYnOdlw2YeGnT9JdX/P2KocRW
 qSCvy77YzOayRamyHFzrnCEQ8DlK1r8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296--TGLDfTXPAmWEiUF_qqWGA-1; Wed, 09 Oct 2024 12:28:47 -0400
X-MC-Unique: -TGLDfTXPAmWEiUF_qqWGA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d39bf2277so438090f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728491326; x=1729096126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIKorGwMnViXPeDtCPDKuBmOlnthdRDmVeq7jRMRzVA=;
 b=hhArlxUHd+y2DXsi69RAxMVy9RR3OlzoPf6yPxRbDk9r8JnZXP0dDYiRlxy+ziJfF7
 YltsN6oyJGcUPWzyE55fA6wtyqfeMX+i3rvyHgTL7QRtQa75+Rtz1i5Ro8i7mMH+/ZzD
 FxSwJFw1RgQF5BHPxr4c6DM2ONW0mM1yL9JtpiVPfHG3DtbC3Qe7PSLKT+x0Ij5BRcIj
 TWYJhXvltxJyy/3d3syV9HRZ3Pl8+GR+Co4fLliXAHGFbvYQlj8OdymfCRY46BDwmA2m
 8otsh94hsFkESz+x1P9UfHUboZToIMyqt+sp09dxE7n8h6B+Pc8DKUz3JDNh/Tvry97L
 y93Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeJyWA194aD+vjpXzQgh19Zr8nUvn9WVNLQhB45vZLlsWvC4RxTy5e7ZIMKyJbTaOOMdkacxg8q94V@nongnu.org
X-Gm-Message-State: AOJu0YzFMeZxXzeLLlSnS/sXjR7WF611Rrb1S8Knxpp41G5NOMevqjR0
 Xcw6bp2Qq0RMG3P4EY0LMpRmrSrxZrpVa1eyU+HWw/eKL78fMvVOT7hjVPGuwiYwn7Hgq/2Zuky
 aqxkKT/MzJo8yDULKFlbnCKB3xf5xg4wcvI/nowdm5iaQ/RWiYt30Xo/AVTecZmy6R4ESDGQ8Tv
 WyM1PJc9gXJdxAfoT9NYgCw2N6flM=
X-Received: by 2002:a5d:6144:0:b0:37d:3989:c683 with SMTP id
 ffacd0b85a97d-37d3a9dbc7emr2101067f8f.22.1728491325472; 
 Wed, 09 Oct 2024 09:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE144m6koH9y8o6nEhqEXsWfYHz85gI0iOFxQr8Sbpam2CamtwkTaq8NnByZB6b/BB3EvWTc4ubC3n5F56xrf4=
X-Received: by 2002:a5d:6144:0:b0:37d:3989:c683 with SMTP id
 ffacd0b85a97d-37d3a9dbc7emr2101047f8f.22.1728491325099; Wed, 09 Oct 2024
 09:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230712134352.118655-1-sgarzare@redhat.com>
 <20230712134352.118655-2-sgarzare@redhat.com>
 <6187274e-7223-4c13-b950-57137f4422d1@akamai.com>
In-Reply-To: <6187274e-7223-4c13-b950-57137f4422d1@akamai.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 9 Oct 2024 18:28:33 +0200
Message-ID: <CABgObfaP+PAAFkGjYmwxWqSdKDcd_mDrb7rC9=TfcTrvqAu1Pg@mail.gmail.com>
Subject: Re: [PATCH 1/3] scsi: fetch unit attention when creating the request
To: Michael Galaxy <mgalaxy@akamai.com>, "Tokarev, Michael" <mjt@tls.msk.ru>, 
 qemu-stable <qemu-stable@nongnu.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org, 
 Mike Christie <michael.christie@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, 
 Fam Zheng <fam@euphon.net>, dharnett@akamai.com, "Hunt,
 Joshua" <johunt@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Yes, it looks like an easy backport. Adding Michael Tokarev and qemu-stable=
.

Paolo


On Wed, Oct 9, 2024 at 6:03=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.com> =
wrote:
>
> Hi All,
>
> We have stumbled upon this bug in our production systems on QEMU 7.2.x.
> This is a pretty nasty bug because it has the effect of causing the root
> filesystem in the guest to switch into read only mode if our block
> storage products change attachments to running virtual machines.
>
> Could we kindly ask to pull this identical patch for 7.2.15?
>
> Last year, it just went to master and landed in 8.0.50. We're planning
> to upgrade, but it will be quite some time before we get around to that,
> and I suspect others are also running 7.2.x in production.
>
> - Michael Galaxy
>
> On 7/12/23 08:43, Stefano Garzarella wrote:
> > Commit 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs") split
> > calls to scsi_req_new() and scsi_req_enqueue() in the virtio-scsi devic=
e.
> > This had no drawback, until commit 8cc5583abe ("virtio-scsi: Send
> > "REPORTED LUNS CHANGED" sense data upon disk hotplug events") added a
> > bus unit attention.
> >
> > Having the two calls separated, all requests in the batch were prepared
> > calling scsi_req_new() to report a sense.
> > Then only the first one submitted calling scsi_req_enqueue() reported t=
he
> > right sense and reset it to NO_SENSE.
> > The others reported NO_SENSE, causing SCSI errors in Linux.
> >
> > To solve this issue, let's fetch the unit attention as early as possibl=
e
> > when we prepare the request, that way only the first request in the bat=
ch
> > will carry the right sense.
> >
> > Fixes: 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs")
> > Fixes: 8cc5583abe ("virtio-scsi: Send "REPORTED LUNS CHANGED" sense dat=
a upon disk hotplug events")
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2176702
> > Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >   include/hw/scsi/scsi.h |  1 +
> >   hw/scsi/scsi-bus.c     | 36 +++++++++++++++++++++++++++++++++---
> >   2 files changed, 34 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > index e2bb1a2fbf..3692ca82f3 100644
> > --- a/include/hw/scsi/scsi.h
> > +++ b/include/hw/scsi/scsi.h
> > @@ -108,6 +108,7 @@ int cdrom_read_toc_raw(int nb_sectors, uint8_t *buf=
, int msf, int session_num);
> >   /* scsi-bus.c */
> >   struct SCSIReqOps {
> >       size_t size;
> > +    void (*init_req)(SCSIRequest *req);
> >       void (*free_req)(SCSIRequest *req);
> >       int32_t (*send_command)(SCSIRequest *req, uint8_t *buf);
> >       void (*read_data)(SCSIRequest *req);
> > diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> > index f80f4cb4fc..f083373021 100644
> > --- a/hw/scsi/scsi-bus.c
> > +++ b/hw/scsi/scsi-bus.c
> > @@ -412,19 +412,35 @@ static const struct SCSIReqOps reqops_invalid_opc=
ode =3D {
> >
> >   /* SCSIReqOps implementation for unit attention conditions.  */
> >
> > -static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
> > +static void scsi_fetch_unit_attention_sense(SCSIRequest *req)
> >   {
> > +    SCSISense *ua =3D NULL;
> > +
> >       if (req->dev->unit_attention.key =3D=3D UNIT_ATTENTION) {
> > -        scsi_req_build_sense(req, req->dev->unit_attention);
> > +        ua =3D &req->dev->unit_attention;
> >       } else if (req->bus->unit_attention.key =3D=3D UNIT_ATTENTION) {
> > -        scsi_req_build_sense(req, req->bus->unit_attention);
> > +        ua =3D &req->bus->unit_attention;
> >       }
> > +
> > +    /*
> > +     * Fetch the unit attention sense immediately so that another
> > +     * scsi_req_new does not use reqops_unit_attention.
> > +     */
> > +    if (ua) {
> > +        scsi_req_build_sense(req, *ua);
> > +        *ua =3D SENSE_CODE(NO_SENSE);
> > +    }
> > +}
> > +
> > +static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
> > +{
> >       scsi_req_complete(req, CHECK_CONDITION);
> >       return 0;
> >   }
> >
> >   static const struct SCSIReqOps reqops_unit_attention =3D {
> >       .size         =3D sizeof(SCSIRequest),
> > +    .init_req     =3D scsi_fetch_unit_attention_sense,
> >       .send_command =3D scsi_unit_attention
> >   };
> >
> > @@ -699,6 +715,11 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqo=
ps, SCSIDevice *d,
> >       object_ref(OBJECT(d));
> >       object_ref(OBJECT(qbus->parent));
> >       notifier_list_init(&req->cancel_notifiers);
> > +
> > +    if (reqops->init_req) {
> > +        reqops->init_req(req);
> > +    }
> > +
> >       trace_scsi_req_alloc(req->dev->id, req->lun, req->tag);
> >       return req;
> >   }
> > @@ -798,6 +819,15 @@ uint8_t *scsi_req_get_buf(SCSIRequest *req)
> >   static void scsi_clear_unit_attention(SCSIRequest *req)
> >   {
> >       SCSISense *ua;
> > +
> > +    /*
> > +     * scsi_fetch_unit_attention_sense() already cleaned the unit atte=
ntion
> > +     * in this case.
> > +     */
> > +    if (req->ops =3D=3D &reqops_unit_attention) {
> > +        return;
> > +    }
> > +
> >       if (req->dev->unit_attention.key !=3D UNIT_ATTENTION &&
> >           req->bus->unit_attention.key !=3D UNIT_ATTENTION) {
> >           return;
>


