Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CB7C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 08:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty4g3-0003yN-AW; Fri, 28 Mar 2025 04:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty4g0-0003y5-AE
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 04:02:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ty4fy-0006qj-0K
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 04:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743148968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dQzQYURmMcjvoL1+8Rz//CV0wh6tqaNZx7v4rQ2hto=;
 b=AD7hPko4Tvs1+KrkzmhB0jtor70xHeaBpkxayhdInw/MPJwwBcSanZmPBySDS3yIhMzsYO
 kujealLjda4W4v2IEbI4klpjdd3j0HGv7O+HjGbiCAnZNwdOrHho2NQzj+5V3k3hOvfYm4
 kTZAgw+7VATAWa42KATFYQDldN5KEwQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-fvoTyXSUOCKGoxb83cOFjQ-1; Fri, 28 Mar 2025 04:02:46 -0400
X-MC-Unique: fvoTyXSUOCKGoxb83cOFjQ-1
X-Mimecast-MFC-AGG-ID: fvoTyXSUOCKGoxb83cOFjQ_1743148965
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff798e8c93so3518631a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 01:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743148965; x=1743753765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dQzQYURmMcjvoL1+8Rz//CV0wh6tqaNZx7v4rQ2hto=;
 b=turMYyygb0Y9ctpAQDHaT4Mb7n2mefJYx4XGHJyt9v0weKE0an03UbAlasP73kDT2E
 l2/XnIVJ3Sv/npk1yV0ErPAuOs/7MDFAz23EREfrUY2qrj6C3RZRKRXba98cN+fiRrET
 /R7Kee2xd9y3fe/1IW6PbsmuzupLnHtXt/YlzeIWkNB/uWrTCJd2o9dbJAynJcXiM+Rs
 19nXAKULXBwph3JnEedfGUqIWUwgLYZeghWYzoeRztg8JiUHrcK8U+IrB5fgOXzywJm2
 HOA48RICrTjz8n1Lbu5bXKFTu311FRrb0izZw/87JUUWiJ8Xg7swltSJzi2/6QFgrx5z
 iC8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjFnen8LuRtMeemmMULzWcBZPNgH4wmagL5sUPBKXBA1wJgM4q1GEEWF9Zi3yRUvxNFajgjvaDZeQH@nongnu.org
X-Gm-Message-State: AOJu0Yz8pu7w5Ghc5t/kcdBRKQYygeEHKKDLwLjdikprstQ1fMeyE8te
 t3FZSMANDvvuHHCJOCvY2/ETy6tLLTAJskXqP+Xua8a+1Cc/lk8Gc5mM5GHDROlnVaB9ZWWG/rI
 JzEJNgl1haKW41FFX6jsJ0U6owCFAtNmjxJDNbsNYdVnCZB0DFXLPfRy00Xn2bJdcLYVxhXZm0a
 lN+Za6QXkps1is20fdgnvzCMGuCX1MVUudBmtTqQ==
X-Gm-Gg: ASbGnct4KIMYTc2/N4TE7232zDY5yFLxT57DY9pk1mRvP9s3fezwx7ayMRVtYBuUpXn
 9dJggAI5fk//3ZZgHn28PlvHj2FDZLTbt0tqLpkUwvJ1CYDYI8DIymdRxUcwV0btJVtQvuis=
X-Received: by 2002:a17:90b:5824:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-303a80654b3mr8178565a91.19.1743148964859; 
 Fri, 28 Mar 2025 01:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJNRRv67SC7i9fwJgDDJum396p3/LXONpnxu1RETX5OOHfi8qjyGSL+UXsqGeBOKP8zXxjkvgrEHU+uE6J5yY=
X-Received: by 2002:a17:90b:5824:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-303a80654b3mr8178533a91.19.1743148964234; Fri, 28 Mar 2025
 01:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <20250324135929.74945-7-sahilcdq@proton.me>
 <CAJaqyWecV3X9PmRHikjkGYT1jbN_ygyKYqvi5AuMtb_aE9oZ0g@mail.gmail.com>
 <18a9abc3-6be2-46ca-9228-a53b5c668374@gmail.com>
In-Reply-To: <18a9abc3-6be2-46ca-9228-a53b5c668374@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 28 Mar 2025 09:02:08 +0100
X-Gm-Features: AQ5f1JrkrFlDqKPwIKbKyb2BxSd3uAY-9BBppGZj0LKNirTszn9e11Q2jriaDig
Message-ID: <CAJaqyWfhT1fKkM-dD_ZTTaS3++a9pRwBWMNFntTvG5ZO7uFE=Q@mail.gmail.com>
Subject: Re: [RFC v5 6/7] vhost: Validate transport device features for packed
 vqs
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 28, 2025 at 6:34=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 3/26/25 5:36 PM, Eugenio Perez Martin wrote:
> > On Mon, Mar 24, 2025 at 3:00=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >>
> >> Validate transport device features required for utilizing packed SVQ
> >> that both guests can use with the SVQ and SVQs can use with vdpa.
> >>
> >> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> >> ---
> >> Changes from v4 -> v5:
> >> - Split from commit #2 in v4.
> >>
> >>   hw/virtio/vhost-shadow-virtqueue.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shad=
ow-virtqueue.c
> >> index 8430b3c94a..035ab1e66f 100644
> >> --- a/hw/virtio/vhost-shadow-virtqueue.c
> >> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> >> @@ -33,6 +33,9 @@ bool vhost_svq_valid_features(uint64_t features, Err=
or **errp)
> >>            ++b) {
> >>           switch (b) {
> >>           case VIRTIO_F_ANY_LAYOUT:
> >> +        case VIRTIO_F_RING_PACKED:
> >> +        case VIRTIO_F_RING_RESET:
> >> +        case VIRTIO_RING_F_INDIRECT_DESC:
> >
> > This should only enable _F_RING_PACKED, there is no code supporting
> > either reset or indirect descriptors.
> >
>
> Without _F_RING_RESET and _RING_F_INDIRECT_DESC, I get the following erro=
r:
>
> qemu-system-x86_64: -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-=
0,x-svq=3Dtrue,id=3Dvhost-vdpa0: SVQ Invalid device feature flags, offer: 0=
x1071011ffa7, ok: 0x70011ffa7
>
> Evaluating 0x1071011ffa7 & ~0x70011ffa7 gives me 0x10010000000 as the
> set of invalid features. This corresponds to _F_RING_RESET (1 << 40)
> and _RING_F_INDIRECT_DESC (1 << 28) [1].
>
> I get this error when x-svq=3Dtrue irrespective of whether split vqs or p=
acked
> vqs are used.
>
> Is there a way to turn them off in the QEMU command?
>

In the case of nested virtualization you should be able to disable it by:

-device virtio-net-pci,indirect_desc=3Doff,queue_reset=3Doff,...

In L0 QEMU cmdline.

> Thanks,
> Sahil
>
> [1] https://gitlab.com/qemu-project/qemu/-/blob/master/include/standard-h=
eaders/linux/virtio_config.h
>


