Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54449C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treMa-0000O7-Dw; Mon, 10 Mar 2025 10:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1treMY-0000Mv-PM
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1treMX-0002eR-1J
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741617852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e79LTItO9Zxn/2a/B6blpLMqcSuTSDDuVE7qNES85Ic=;
 b=aHvWbQNC0uS00ExYF3K7/R0VV9moCyxRt1Y73m+zcg39SAaWeoLSrzPfdIJbXI2tr+N3O1
 kV1tKVdBpRAMkStR+MNtUSa1ba6PjNWxrka2bnskEsCiTJjaOuVB37C49DF0VdA7h393q6
 1MKp1qqx2FB+Zo0QZv+l7q6JErlGJFw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-g4KHKMWYMzaq_Ofu-mKJPw-1; Mon,
 10 Mar 2025 10:44:05 -0400
X-MC-Unique: g4KHKMWYMzaq_Ofu-mKJPw-1
X-Mimecast-MFC-AGG-ID: g4KHKMWYMzaq_Ofu-mKJPw_1741617845
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5A8119560BC; Mon, 10 Mar 2025 14:44:04 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1368418001E9; Mon, 10 Mar 2025 14:43:59 +0000 (UTC)
Date: Mon, 10 Mar 2025 15:43:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 00/12] virtio-scsi: add iothread-vq-mapping parameter
Message-ID: <Z876rXYchAvup5_6@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213180043.713434-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 13.02.2025 um 19:00 hat Stefan Hajnoczi geschrieben:
> Implement --device virtio-scsi-pci,iothread-vq-mapping= support so that
> virtqueues can be assigned to different IOThreads. This improves SMP guest
> scalability where I/O-intensive applications can become bottlenecked on a
> single IOThread.
> 
> The following benchmark results show the effect of iothread-vq-mapping. fio
> randread 4k iodepth=64 results from a 4 vCPU guest with an Intel P4800X SSD:
> iothreads IOPS
> ------------------------------
> 1         189576
> 2         312698
> 4         346744
> 
> The virtio-scsi device model and core SCSI emulation currently assume that
> requests are processed in a single AioContext. This patch series goes about
> modifying this as follows:
> 
> scsi-disk: drop unused SCSIDiskState->bh field
> dma: use current AioContext for dma_blk_io()
> 
> Make dma-helpers.c support the QEMU multi-queue block layer by using
> qemu_get_current_aio_context().
> 
> scsi: track per-SCSIRequest AioContext
> scsi: introduce requests_lock
> 
> Make the core SCSI emulation code support processing requests in multiple
> AioContexts by protecting the per-SCSIDevice requests list.
> 
> virtio-scsi: introduce event and ctrl virtqueue locks
> virtio-scsi: protect events_dropped field
> virtio-scsi: perform TMFs in appropriate AioContexts
> 
> Make the virtio-scsi emulation code support processing requests in multiple
> AioContexts. The event and ctrl virtqueues can interact with multiple
> AioContexts. Especially the SCSI Task Management Functions (TMFs) handled by
> the ctrl virtqueue need to be made thread-safe.
> 
> virtio-blk: extract cleanup_iothread_vq_mapping() function
> virtio-blk: tidy up iothread_vq_mapping functions
> virtio: extract iothread-vq-mapping.h API
> virtio-scsi: add iothread-vq-mapping parameter
> 
> Port over the iothread-vq-mapping qdev property from virtio-blk to virtio-scsi.
> 
> virtio-scsi: handle ctrl virtqueue in main loop
> 
> Simplify TMF handling now that there is no longer a single AioContext where all
> requests are processed.
> 
> Stefan Hajnoczi (12):
>   scsi-disk: drop unused SCSIDiskState->bh field
>   dma: use current AioContext for dma_blk_io()
>   scsi: track per-SCSIRequest AioContext
>   scsi: introduce requests_lock
>   virtio-scsi: introduce event and ctrl virtqueue locks
>   virtio-scsi: protect events_dropped field
>   virtio-scsi: perform TMFs in appropriate AioContexts
>   virtio-blk: extract cleanup_iothread_vq_mapping() function
>   virtio-blk: tidy up iothread_vq_mapping functions
>   virtio: extract iothread-vq-mapping.h API
>   virtio-scsi: add iothread-vq-mapping parameter
>   virtio-scsi: handle ctrl virtqueue in main loop

Patches 1-10: Reviewed-by: Kevin Wolf <kwolf@redhat.com>


