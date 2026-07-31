Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC551C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpiDK-0003Qt-92; Fri, 31 Jul 2026 04:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wpiDG-0003QS-MK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wpiDE-0005u7-RY
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785485003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BytVVY100176dgRFsU3ZMXCvMsAoP9CGt2YQFyjEo08=;
 b=fChwrEE82FutRiG4QrpRejQIOnYQEwQHgImS08PZ0cgzAe29Rlg2fzkM2Q31z0LCdVt3sH
 lrGsFf6MpyDJQhe4OjpHKNogJISfeaPJ7Td1nG4VX3jhI71W7DeKkCWZWgQcxdSrdYz9Qh
 XJkGpCcYD/pw8cHQ8dwYMsmCmgIK+HI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-2BJTnr3vPLuRZZ39bmQVYQ-1; Fri,
 31 Jul 2026 04:03:17 -0400
X-MC-Unique: 2BJTnr3vPLuRZZ39bmQVYQ-1
X-Mimecast-MFC-AGG-ID: 2BJTnr3vPLuRZZ39bmQVYQ_1785484994
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63093180044D; Fri, 31 Jul 2026 08:03:13 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C60D230002EC; Fri, 31 Jul 2026 08:03:03 +0000 (UTC)
Date: Fri, 31 Jul 2026 10:03:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 virtio-fs@lists.linux.dev, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Alexander Graf <graf@amazon.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org,
 Greg Kurz <groug@kaod.org>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH v2 2/2] virtio: use Error for queue size validation in
 virtio_add_queue()
Message-ID: <amxWta_aGJnb6lPE@redhat.com>
References: <20260730205846.19479-1-stefanha@redhat.com>
 <20260730205846.19479-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730205846.19479-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Am 30.07.2026 um 22:58 hat Stefan Hajnoczi geschrieben:
> Coverity is unhappy with the code path where the x-override-queue-size
> property value is passed to g_new0() since it is a signed int rather
> than an unsigned int:
> 
>       *** CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
>       /builds/qemu-project/qemu/hw/virtio/virtio.c: 2595             in virtio_add_queue()
>       2589         }
>       2590
>       2591         vdev->vq[i].vring.num = queue_size;
>       2592         vdev->vq[i].vring.num_default = queue_size;
>       2593         vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
>       2594         vdev->vq[i].handle_output = handle_output;
>       >>>     CID 1664271:         Error handling issues  (NEGATIVE_RETURNS)
>       >>>     "__n" is passed to a parameter that cannot be negative.
>       2595         vdev->vq[i].used_elems = g_new0(VirtQueueElement, queue_size);
> 
> Introduce an Error **errp argument to virtio_add_queue() and set it when
> the queue_size argument or the x-override-queue-size property value are
> invalid.
> 
> At the moment none of the callers propagate the Error object. Instead
> they are all modified to pass &error_abort so that the error message is
> printed and the program terminates (it also terminated before). Further
> work, especially in new device emulation code, could actually propagate
> the Error object but is left for the future.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

What's the point of adding an Error object when not even a single caller
makes use of it?

At least the semantic change in virtio_add_queue() (checking if override
is valid) should be a separate patch from the refactoring that pushes
the existing &error_abort into all callers.

> @@ -2574,15 +2575,43 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, unsigned int queue_size,
>              break;
>      }
>  
> -    if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
> -        abort();
> +    if (i == VIRTIO_QUEUE_MAX) {
> +        error_setg(errp, "Exceeded maximum number of virtqueues (%d)", i);
> +        return NULL;
> +    }
> +
> +    if (queue_size > VIRTQUEUE_MAX_SIZE) {
> +        error_setg(errp, "Virtqueue size %u exceeds the max (%u)",
> +                   queue_size, VIRTQUEUE_MAX_SIZE);
> +        return NULL;
> +    }
>  
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>      if (qbus && qbus->parent &&
>          object_property_find(OBJECT(qbus->parent), VIRTIO_QUEUE_SIZE_OVERRIDE)) {
>          int override = object_property_get_int(OBJECT(qbus->parent),
>                                                 VIRTIO_QUEUE_SIZE_OVERRIDE,
> -                                               &error_abort);
> +                                               errp);
> +
> +        if (*errp) {
> +            return NULL;
> +        }
> +        if (override < 0) {
> +            /*
> +             * The property type should be UINT16, so this can't happen, but
> +             * help out Coverity.
> +             */
> +            error_setg(errp, "%s (%d) cannot be negative",
> +                       VIRTIO_QUEUE_SIZE_OVERRIDE, override);
> +            return NULL;
> +        }

Wouldn't it be more proper to use object_property_get_uint() instead of
getting an unsigned property as signed and then checking for negative
values?

> +        if (override > VIRTQUEUE_MAX_SIZE) {
> +            error_setg(errp, "%s (%d) exceeds the max (%d)",
> +                       VIRTIO_QUEUE_SIZE_OVERRIDE, override,
> +                       VIRTQUEUE_MAX_SIZE);
> +            return NULL;
> +        }
> +
>          if (override) {
>              queue_size = override;
>          }

Kevin


