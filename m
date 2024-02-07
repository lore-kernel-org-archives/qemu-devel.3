Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4EEC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXp20-0001of-GE; Wed, 07 Feb 2024 16:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXp1x-0001kw-1t
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXp1s-0006WH-QX
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707339622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9cmddD6dLiAsM8y/+mXhCRMf1feQHqzcgr8TfDsDvo=;
 b=WjK6jdEbTOL4JmkVnGetEkO+TpZsgmmIin3eXlmiCU9dvpzMXXzYSl95GyPtuFEX5UyDTB
 qL6gMlCLNQ9qdiQC8lU7BwOtbKUoZ15gMQZcnODT6WnUNN9JKYoM6bcmd3BhS3C7D58QuT
 DAg+RRxTEo5bZejtFXqz3vgp2QuQdXA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-h8uieEJDML6RRii9Ce2L7g-1; Wed, 07 Feb 2024 16:00:20 -0500
X-MC-Unique: h8uieEJDML6RRii9Ce2L7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0B1388F5A3;
 Wed,  7 Feb 2024 21:00:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF76D111F9;
 Wed,  7 Feb 2024 21:00:17 +0000 (UTC)
Date: Wed, 7 Feb 2024 22:00:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] virtio-blk: avoid using ioeventfd state in irqfd
 conditional
Message-ID: <ZcPvXIFTI2X0aNwk@redhat.com>
References: <20240122172625.415386-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122172625.415386-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 22.01.2024 um 18:26 hat Stefan Hajnoczi geschrieben:
> Requests that complete in an IOThread use irqfd to notify the guest
> while requests that complete in the main loop thread use the traditional
> qdev irq code path. The reason for this conditional is that the irq code
> path requires the BQL:
> 
>   if (s->ioeventfd_started && !s->ioeventfd_disabled) {
>       virtio_notify_irqfd(vdev, req->vq);
>   } else {
>       virtio_notify(vdev, req->vq);
>   }
> 
> There is a corner case where the conditional invokes the irq code path
> instead of the irqfd code path:
> 
>   static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
>   {
>       ...
>       /*
>        * Set ->ioeventfd_started to false before draining so that host notifiers
>        * are not detached/attached anymore.
>        */
>       s->ioeventfd_started = false;
> 
>       /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
>       blk_drain(s->conf.conf.blk);
> 
> During blk_drain() the conditional produces the wrong result because
> ioeventfd_started is false.
> 
> Use qemu_in_iothread() instead of checking the ioeventfd state.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-15394
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to the block branch.

Kevin


