Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76215C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGis-0006wA-Kg; Mon, 14 Jul 2025 06:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubGdN-00050Y-RD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubGdH-0006e2-NE
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752489717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPAkTAaIy889P9aYpRLXTKByB/dQEP/Oc6mdMhiTbsU=;
 b=el9zx58Z3L+ebdVRLNyDWRWe7HtYPceSeXaF8a/xEU6hvOKyOiymBIDSBVmb51CZCxy8FO
 vQ20bRUrJUWawZGKiLDAMl6rQQE9pWkgGbSyhnOBFChsXqCZDfXmTVNCp5wNItKzHcAnBO
 i0ijjRXI2YCQJ/GX32sHFcRjAr+llqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-61XW7XVhPcyBDqD5ozQ-6w-1; Mon, 14 Jul 2025 06:41:56 -0400
X-MC-Unique: 61XW7XVhPcyBDqD5ozQ-6w-1
X-Mimecast-MFC-AGG-ID: 61XW7XVhPcyBDqD5ozQ-6w_1752489715
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso21236045e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752489715; x=1753094515;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPAkTAaIy889P9aYpRLXTKByB/dQEP/Oc6mdMhiTbsU=;
 b=vCfQkuBadrS06W09bbfmZbR5/eoHti5YGzMEu9fC0MIQhDHm3PGSJzju7Y6cP4+Dcy
 U8Vl6ZJ5dFIpRhzc2sIRlJtPQwohEl0HHxf65QMkA2krMe6D0LCsQZ+R4T+amJEBpRQN
 14hydJ09Fik9olxEbLGC+/LqP2rpdBfWsSuJ+gK2Tdh9TbGBLnQL1C78khSKEMdy6CaE
 mXE8abuuo/2xg5Cajt1mIYIxUH6IIcj4wL1dxfcAuh9BvZOAaa0KQONegu2aSsFQYqKD
 dJ9hP7ir8CbYGFm6ebMiH6CYxYYPOHJYeSdtnYsN02omv9HE/203Vtt0Dc+e7GFNJan2
 kEPQ==
X-Gm-Message-State: AOJu0YzNUJAgSWRd/2TuXCSWu7UFHB8+YS7AXszy+8gJVUlI+sCPa6DP
 xRatbfuRzACjMJm2eJNvrdiXtFPEdpo5IUA8TpclFwjb20xj+iytTE77Fil6/SOg4/GooczNMyy
 +4PbdyqmoRRG1BYo6xUF/QuF+Z3oGCi+agD2k7H0np621oeP3flG3liqk
X-Gm-Gg: ASbGncsQsZS+rsqSW8brHvN4+TLAQsUCIKXm6/J0ORwxZ45DAVNfE6H+5rFwqCnMRo1
 oLoVEiXmiECJO2BnNrtTcAre4fYjpnyRvspjpWXb9DH0L9tNU7SEz7cZgJq6J/V9cuaW2ZDBnK7
 fRFK0sGble/9xUvIRGjdZJcmyY/ZnAxt93bMl5piV0OVx7uOME+Iql5rO8YMeC1yoMyVjwN69Zh
 BO4yA9t1/n3LU/O1AjIbbnXqvGaIdnpxZ+5HoRuvxL+gPIPM1MH6GIGPb6SoAYwoowjigwJb1Bl
 rtb+bNX8AVBQRoTPDeMCIJLMnxjoZ0iv
X-Received: by 2002:a05:600c:8b70:b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-4560fc1c49amr45435545e9.1.1752489715093; 
 Mon, 14 Jul 2025 03:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpmfUJGJnjzI1HHy8gI/3LD4+H4VhPR82va2p+Eymc35k6ON0jiNdtPVYzEVuGDjZeLV7yMg==
X-Received: by 2002:a05:600c:8b70:b0:456:fc1:c286 with SMTP id
 5b1f17b1804b1-4560fc1c49amr45435295e9.1.1752489714598; 
 Mon, 14 Jul 2025 03:41:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562360c989sm2596075e9.37.2025.07.14.03.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 03:41:54 -0700 (PDT)
Date: Mon, 14 Jul 2025 06:41:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 pbonzini@redhat.com, jasowang@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net
Subject: Re: [PATCH 0/4] vhost: drop backend_features
Message-ID: <20250714062807-mutt-send-email-mst@kernel.org>
References: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 03, 2025 at 03:47:08PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> This field is mostly unused and sometimes confusing (we even have
> a TODO-like comment to drop it). Let's finally do.

Breaks make check with UBSAN enabled:
32/109 /arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/vhost-user/flags-mismatch - ERROR:../tests/qtest/qos-test.c:189:subprocess_run_one_test: child process (/arm/virt/virtio-mmio/virtio-bus/virtio-net-device/virtio-net/virtio-net-tests/vhost-user/flags-mismatch/subprocess [9701]) failed unexpectedly FAIL       



https://gitlab.com/mstredhat/qemu/-/jobs/10668177755


To trigger, configure with:

./configure '--cc=clang' '--cxx=clang++' '--enable-ubsan' '--extra-cflags=-fno-sanitize-recover=undefined -fno-sanitize=pointer-overflow' '--target-list=arm-softmmu' 

make
make check


> Vladimir Sementsov-Ogievskiy (4):
>   vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
>   vhost-user: stop use backend_features
>   vhost_net: stop use backend_features
>   hw/vhost: finally drop vhost_dev.backend_features field
> 
>  hw/block/vhost-user-blk.c         |  1 -
>  hw/net/vhost_net.c                | 14 ++++++--------
>  hw/scsi/vhost-scsi.c              |  1 -
>  hw/scsi/vhost-user-scsi.c         |  1 -
>  hw/virtio/vdpa-dev.c              |  1 -
>  hw/virtio/vhost-user.c            | 25 ++++++++++++++++---------
>  hw/virtio/vhost.c                 | 15 ++++++---------
>  hw/virtio/virtio-qmp.c            |  2 --
>  include/hw/virtio/vhost-backend.h |  2 ++
>  include/hw/virtio/vhost.h         |  7 -------
>  10 files changed, 30 insertions(+), 39 deletions(-)
> 
> -- 
> 2.48.1


