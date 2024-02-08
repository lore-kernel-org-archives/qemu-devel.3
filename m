Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238A4C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 08:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXzz5-0003mi-G0; Thu, 08 Feb 2024 03:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXzz0-0003lk-Dk
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:42:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXzyy-0000uu-O9
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707381728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VRfyNJhcw7IEmZYbl5RZwOD+C4hpdxuv7WDl3W289NI=;
 b=dHhtRkNzgxxDrG94QWy69H33l0bGoyofi+fS+ySIOHRyLizyCzV1PZ6/2nP/fnhrlrr+Pe
 ja6m+YDdlfU/lYlq3xy73ZyfNTkwdebCCa2mrOBQETaNDU3LCT186lxQvcfaGUXEl1oXLZ
 liCSKf4+d3jIeaEfAn+2nc8TTBftpyc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-60MWa-aPNTeGNiU_iWLNRg-1; Thu,
 08 Feb 2024 03:42:04 -0500
X-MC-Unique: 60MWa-aPNTeGNiU_iWLNRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7392438212D2;
 Thu,  8 Feb 2024 08:42:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 440442166B32;
 Thu,  8 Feb 2024 08:42:03 +0000 (UTC)
Date: Thu, 8 Feb 2024 09:42:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 1/1] virtio-blk: avoid using ioeventfd state in irqfd
 conditional
Message-ID: <ZcST2jDqvZWhgp2E@redhat.com>
References: <20240206153105.81868-1-stefanha@redhat.com>
 <20240206153105.81868-2-stefanha@redhat.com>
 <9393f1f7-9939-4640-aa43-f7df042a8ee9@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9393f1f7-9939-4640-aa43-f7df042a8ee9@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 08.02.2024 um 06:37 hat Michael Tokarev geschrieben:
> 06.02.2024 18:31, Stefan Hajnoczi :
> > Requests that complete in an IOThread use irqfd to notify the guest
> > while requests that complete in the main loop thread use the traditional
> > qdev irq code path. The reason for this conditional is that the irq code
> > path requires the BQL:
> > 
> >    if (s->ioeventfd_started && !s->ioeventfd_disabled) {
> >        virtio_notify_irqfd(vdev, req->vq);
> >    } else {
> >        virtio_notify(vdev, req->vq);
> >    }
> > 
> > There is a corner case where the conditional invokes the irq code path
> > instead of the irqfd code path:
> > 
> >    static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
> >    {
> >        ...
> >        /*
> >         * Set ->ioeventfd_started to false before draining so that host notifiers
> >         * are not detached/attached anymore.
> >         */
> >        s->ioeventfd_started = false;
> > 
> >        /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
> >        blk_drain(s->conf.conf.blk);
> > 
> > During blk_drain() the conditional produces the wrong result because
> > ioeventfd_started is false.
> > 
> > Use qemu_in_iothread() instead of checking the ioeventfd state.
> > 
> > Buglink: https://issues.redhat.com/browse/RHEL-15394
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-id: 20240122172625.415386-1-stefanha@redhat.com
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Cc qemu-stable?  This smells like a stable material, please let me know
> if it is not.

The patch email itself was CCed to qemu-stable and even contained a note
for backporting to stable:

https://lists.gnu.org/archive/html/qemu-block/2024-01/msg00278.html

It's only missing in the commit message. I'll add the Cc: line to
my pull request (for Stefan's pull request it seems too late because
Peter is already processing it, so we'll probably end up having both
versions in the git history).

Kevin


