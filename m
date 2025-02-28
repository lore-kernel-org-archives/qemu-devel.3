Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC5C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwlb-0004LJ-0z; Fri, 28 Feb 2025 04:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tnwlV-0004Kw-NV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tnwlT-0003VD-Vj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740735277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1VyEmEk5JVg7qqQJp7x7D0FzDjD7r/t/EMRE81LK60=;
 b=YQ3l8fHgm4AXK0nt5sfyq9bEf5rFXy0zLhv6pwYrVVdhILI4skAfv4EZQwkOZfNbMm9s+N
 xt7LO4YJdklhAr3z/DTGuxJCwdIOXfU67bjujS69BitMW7XJTXihsOcTGM4/gOEeDxJAEs
 pdgDvtYATCM++WkoC9+a3Wvox6F7Qh4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-qrcm1RjcPNmA7k6su4uxuQ-1; Fri, 28 Feb 2025 04:34:36 -0500
X-MC-Unique: qrcm1RjcPNmA7k6su4uxuQ-1
X-Mimecast-MFC-AGG-ID: qrcm1RjcPNmA7k6su4uxuQ_1740735275
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abf1fdde3e8so87371466b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 01:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740735275; x=1741340075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1VyEmEk5JVg7qqQJp7x7D0FzDjD7r/t/EMRE81LK60=;
 b=hAtIkcNj52oL308NA9sq8vaRcVoJ7KiTUoMkrjqkIFlh//GYNISgNwbv4CuQAHdS7Y
 /olJTvqZBbekVoN/hfjXv03te1sDqvYvZ1Tq0mCm8NbD4orf64/wQgkffiO5pVQZxUoJ
 MNdI7q69vQfq35DxkjaB6dizTAqBoByiiR46BhqVlyfcfzGtagM/SAUxaqXr23TAoGHF
 6mNYwmPEIEc9sIAYegWo4WqJck4XNgZSf4wR2bOprxdbUxScKUH7ynkxQy6seGkRQLpQ
 9SdKQEZnrAe50ttlXSIPNXdz2yi8UQTuGEWh5qyslO9UKizLRq2gjKK/pvk8iqnRiqsM
 HV1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlB84/f1uLg4kEgCyr/mMQdMDyXZ/53pFgaEg311rKR6F7ommfsJH8JOzZEChl1R5KT6fhzm4D5uzD@nongnu.org
X-Gm-Message-State: AOJu0YxMbQmDhhqsiQ0+j/LJ7yUogW/S86CJu26n9hRAgfWLeu5aQ7gw
 FcohFbVzAPdsliiE2ZO6nCG9NCBvvsBU34noSdbsqJZ4ALMeCc+gSOQKix+EaXJOP0MSImW6vnt
 jJATnld05g7qaJAYPBx0fmLPnjYzDOlbz/4tagD8RGo/tXWWsPXPCBhhqMPk3YaSrCSaZv9/GNm
 +FmYo7dqZDIOGCmmx/r/fUvLIiZAg=
X-Gm-Gg: ASbGncvk16Ip46Wcog9BaIMjFBWgz8V2NcFlqDuyp6y7qIUdxKnDu1KViWDI8ZiyWEG
 DcuVjSsc5VJvDkTgsIf8xqy6OvmRbnnKDVmX1J7zMp2xMYSc3pX67eXetXAd9Ob8X70B9Bt4mPg
 ==
X-Received: by 2002:a17:907:2cc4:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-abf261cd11emr259746466b.27.1740735274694; 
 Fri, 28 Feb 2025 01:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpHb8SushLH+M6laW+AyHYpl+D1xiFnELj9pR28UQsEvmFsUKXvZaUm3omVtoimxzCVjpCKKYrWKy4hEi3754=
X-Received: by 2002:a17:907:2cc4:b0:abc:4b7:e3d3 with SMTP id
 a640c23a62f3a-abf261cd11emr259744166b.27.1740735274260; Fri, 28 Feb 2025
 01:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20250218083208.78465-1-hanht2@chinatelecom.cn>
 <ebhceh2uzlpf3cr6gxnojt36i4vl5cvrputuhq62irbgb2ew4q@t7qxhpkvqmy5>
In-Reply-To: <ebhceh2uzlpf3cr6gxnojt36i4vl5cvrputuhq62irbgb2ew4q@t7qxhpkvqmy5>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 17:33:55 +0800
X-Gm-Features: AQ5f1Jph934eOp15me2xws25yZvIV4njBJFOklSgLZmnftZU-R_CpR0W9c0BfMg
Message-ID: <CAPpAL=xsHAZiox8q8RrYm6eM88EJQVA=SxX5mGcpj5d56Veb7g@mail.gmail.com>
Subject: Re: [PATCH] vhost: Don't set vring call if guest notifier is disabled
To: Huaitong Han <hanht2@chinatelecom.cn>
Cc: oenhan@gmail.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Feb 18, 2025 at 8:04=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Tue, Feb 18, 2025 at 04:32:08PM +0800, oenhan@gmail.com wrote:
> >From: Huaitong Han <hanht2@chinatelecom.cn>
> >
> >The vring call fd is set even when the guest does not use MSIX (e.g., vi=
rtio
> >PMD). This results in unnecessary CPU overhead for handling virtio inter=
rupts.
> >The previous patch only optimized the condition when query_queue_notifie=
r was
>
> Which patch/commit are you referring to?
>
> The last commit touching that check is commit 96a3d98d2c ("vhost: don't
> set vring call if no vector"), but I'm not sure if you are referring to
> it. If it's the case, please add it in that form in the description.
>
> It would also be better to add the Fixes tag as well and Cc stable if we
> would like to have this fix in the stable branch.
>
> Thanks,
> Stefano
>
> >enabled and the vector was unset. However, if query_queue_notifier is di=
sabled,
> >the vring call FD should also be unset to avoid this inefficiency.
> >
> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> >---
> > hw/virtio/vhost.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 6aa72fd434..d17e7cc6fe 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -1342,8 +1342,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
> >     }
> >
> >     if (k->query_guest_notifiers &&
> >-        k->query_guest_notifiers(qbus->parent) &&
> >-        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
> >+        (!k->query_guest_notifiers(qbus->parent) ||
> >+            virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR)) {
> >         file.fd =3D -1;
> >         r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> >         if (r) {
> >--
> >2.43.5
> >
>
>


