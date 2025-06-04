Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A02C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 03:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMeeU-00049L-N6; Tue, 03 Jun 2025 23:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uMeeT-00049A-Dt
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 23:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uMeeR-0002zC-Cg
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 23:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749007128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkGEvgrgSDW2GFJMiKsYv7kbrRkz18QAXxKXvdpl0zw=;
 b=R1qECK3AMhLRZBRu7Y758CcRZ7XLYRD//cTnGo4BBIfzNiFaTorKDFCTnz7MHDZoEfPYN4
 TSS8WnD9R4BC21ogoGFkWaWpRuEbMu+dj+b9GOo3tcqzVzs+vz7jJmZ1Y7Vq+P4gmgfVBr
 WPamxYLxJy4dgCp7BKvgDNTEtyyBF44=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Phi-xt1wMUWpDxh-3XEL0g-1; Tue, 03 Jun 2025 23:18:45 -0400
X-MC-Unique: Phi-xt1wMUWpDxh-3XEL0g-1
X-Mimecast-MFC-AGG-ID: Phi-xt1wMUWpDxh-3XEL0g_1749007124
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad8adc22e88so587051466b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 20:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749007124; x=1749611924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IkGEvgrgSDW2GFJMiKsYv7kbrRkz18QAXxKXvdpl0zw=;
 b=HXg91SXy8hSUjLBPE7pKpucPXSnrxHSo4hHs8I7nz5XL4pevsUfaHQtHLQWygsAseg
 Wa7s6CV0nz+QLB1PTPDgEzIQRognAOrtIBzh4kJBfhR+rjhW19pZbrEyny0lNIoGeVcH
 Ar5wwh8jOhiT9coBPKhcRAwKch5Q7cGh/RMIerS9GrKzsHJCOYw1kAedGRIZs+kTOlxi
 Xye2FwF8/9Uhahndn8bYsnb2jWQE7fx092Np09icfUZ7BC2oHwc24c/H5bMXJlUgvHz8
 MaT2rwLQeAf3Fdgn7mQP9Ikwqnhr5TZfjxS2A5CR+lMyZbEUYV2NFQG9g8c8H8X6fSS0
 kqAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfZusSPnFr5YbvfS2Y9JKY9SlR5d1EwH7ACqw2KQGcTngX9mvpdKmjT87BbnQLTpp8cJhmdRLNAcfe@nongnu.org
X-Gm-Message-State: AOJu0YwlA2H+2zvHjN2BGjaxPAKxC7AACgrVaAarEJS6QAehqg5J0SL9
 kK24hM09nTBlKmtQVAX+iBXDweqbixHKzyygdPqa9XZXmopS2l03iQQq1xg/ZjnN9l2coEk4GkR
 /iza5jYzb90tnxcRwfby25xtzu8aAqW3Lkg0rOYfn44OH+1A2dfPTuwUurTKvGtzit0X1LwhPaL
 uPscxbQfOILJBfSLkwM/9gcpr8DSK/lY8=
X-Gm-Gg: ASbGnctdmxb4A6CkxsHrqyThKWBiYJSWvsZV7Rez3WuftKQSxhp5QQnWTdLYwZyTnvv
 a1FQ8T9WSuhLQdzJJGYJrrmY9oU1T1pmwXRRVHh+92x26XUjY670L9/nr1QTkrfR6Xu31ZQ==
X-Received: by 2002:a17:907:1ca1:b0:ad2:2dc9:e3d3 with SMTP id
 a640c23a62f3a-addf8ffa8d4mr90864166b.57.1749007123829; 
 Tue, 03 Jun 2025 20:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAQtpTZinV1Q4NWqtUmT8jSRHIM/nZb5/Z907g34rJUtNJvKYX5DyyNzL4eP8MW3egjAsQpp1ygfKJKhy6Hsc=
X-Received: by 2002:a17:907:1ca1:b0:ad2:2dc9:e3d3 with SMTP id
 a640c23a62f3a-addf8ffa8d4mr90862366b.57.1749007123494; Tue, 03 Jun 2025
 20:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250530-n-v2-1-b1be546ca586@daynix.com>
 <CACGkMEsX3HJKh_WsFaVg=5HPQBwGhLQytxvDHS-DQjeN-3zGJQ@mail.gmail.com>
In-Reply-To: <CACGkMEsX3HJKh_WsFaVg=5HPQBwGhLQytxvDHS-DQjeN-3zGJQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 4 Jun 2025 11:18:06 +0800
X-Gm-Features: AX0GCFv21O1omq7g4xwFQp0SSo6z5dTzmeJ5BNskkxQg81-bGRi9uxYp2gmM04k
Message-ID: <CAPpAL=yixs-bDdEJbPL_=29aTn18Cy2zkox-R3wkJ8FbpmUh4Q@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Add queues for RSS during migration
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jun 3, 2025 at 11:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, May 30, 2025 at 1:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> >
> > virtio_net_pre_load_queues() inspects vdev->guest_features to tell if
> > VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
> > number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
> > VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_feature=
s
> > is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> > VIRTIO_NET_F_MQ uses bit 22.
> >
> > Instead of inferring the required number of queues from
> > vdev->guest_features, use the number loaded from the vm state. This
> > change also has a nice side effect to remove a duplicate peer queue
> > pair change by circumventing virtio_net_set_multiqueue().
> >
> > Also update the comment in include/hw/virtio/virtio.h to prevent an
> > implementation of pre_load_queues() from refering to any fields being
> > loaded during migration by accident in the future.
> >
> > Fixes: 8c49756825da ("virtio-net: Add only one queue pair when realizin=
g")
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Changes in v2:
> > - Updated a documentation comment of pre_load_queues() for clarity.
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250510-n-v1-1-19ee26=
ac3ca6@daynix.com
>
> Queued.
>
> Thanks
>
>


