Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D3606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BQ1J5Xso
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWHb2-0004ob-H4; Wed, 25 Nov 2026 13:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xWHaj-0004no-Tp
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 13:19:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xWHah-0006Lk-Nm
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 13:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795630773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d2mKySRktUWLD6bPkFgi6UmcsnU2PsJlkU96NUYqFZI=;
 b=BQ1J5Xso54LK/BV2QrnRKxmFSXif6gxmwKkvJRc0NamBGmUPc7n7NWzQXQI1x5EZu3CiEM
 qBNBGM24VcpDB/3Ld45gESo77xwnxF/0fI3f43gkw4wkH0dqt2520TNHIrnz82RAq5/iw3
 xA6r6o5MZkAkGxOI7IyWBBepW1KR9us=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-yT2UEkjrPvqGgn6c0W98ug-1; Wed,
 25 Nov 2026 18:19:29 +0000
X-MC-Unique: yT2UEkjrPvqGgn6c0W98ug-1
X-Mimecast-MFC-AGG-ID: yT2UEkjrPvqGgn6c0W98ug_1795630768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DC5018005AC; Wed, 25 Nov 2026 18:19:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37F7F195B3C4; Wed, 25 Nov 2026 18:19:27 +0000 (UTC)
Date: Wed, 25 Nov 2026 13:19:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V20 00/14] iothread: Support tracking and querying
 IOThread holder
Message-ID: <20261125181926.GF10456@shajnocz.csb>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 05:25:51PM +0800, Zhang Chen wrote:
> ### Motivation
> Currently, the relationship between IOThreads and the resources using them is
> opaque. From a management perspective, it is difficult to determine which
> devices or block exports are currently associated with a specific IOThread
> via QMP or HMP.
> 
> This series introduces a "holder" tracking mechanism based on QOM paths or
> block exports to significantly improve IOThread observability.
> In high-performance virtualization environments, users often pre-allocate
> a set of IOThreads to serve as a persistent thread pool. During device
> hotplug/unplug cycles, while IOThread objects remain persistent,
> their attachment state changes dynamically.
> 
> By tracking these "holders," administrators can use `query-iothreads` to
> monitor the real-time load distribution of the thread pool and identify which
> specific devices (e.g., virtio-blk, BlockExport) are attached to which thread.
> 
> ### Technical Overview
> * Holder tracking
> 
>   Add a QAPI holder list to each IOThread.  A holder identifies either
>   a QOM object by its canonical path or a block export by its unique
>   BlockExportOptions ID.
> 
> * Explicit reference lifecycle
> 
>   Add iothread_ref_and_get_aio_context() and the matching
>   iothread_unref_and_put_aio_context().  Acquiring an AioContext registers a
>   holder and keeps the IOThread alive until the matching put.
> 
>   Legacy callers without a matching lifecycle use the explicitly named
>   iothread_unsafe_get_aio_context().  The ambiguous legacy
>   iothread_get_aio_context() is removed after all production callers
>   are migrated.
> 
> * Subsystem integration
> 
>   Track holders for block exports, monitors, virtio-blk, virtio-scsi,
>   virtio queue mappings, virtio balloon thread pinning, COLO compare,
>   vfio-user proxy, and xen-block.
> 
> * Introspection
> 
>   Extend IOThreadInfo with a holders array returned by
>   query-iothreads.  Display the same information with info iothreads.
> 
> 
> =====================================================================
> 
> ### V20 -> V19 Changelog
>   - Rebased onto upstream v11.2.0-rc0 (29760efaf96b).
>   - Add the RB in the patch 14/14.
>   - Adapted patches 1 and 5 to the updated QOM property registration
>     context, and resolved patch 9's conflicts with vfio-user region
>     FD cleanup. No functional changes to the series.
> 
> ### V19 -> V18 Changelog
>   - Added new patch in the last:
>     docs/devel: document holder-aware IOThread AioContext APIs
>   - Rebased on upstream code.
>   - Added IOThread prepare_delete() to reject deletion while holders
>     remain, preventing NULL IOThread lookups during virtqueue mapping
>     cleanup.
> 
> ### V18 -> V17 Changelog
>   - Saved the COLO object's QOM path for finalization and guarded
>     holder cleanup against incomplete initialization.
>   - Used the owning PCI device's QOM path for vfio-user holders
>     and saved it for disconnect().
>   - Simplified the monitor QOM path field name and clarified
>     PATCH 12's commit message.
>   - Rebased on upstream and collected Reviewed-by tags.
> 
> ### V17 -> V16 Changelog
>   - Rebase code to resolve code conflicts for patch 8:
>     "virtio-balloon: Update tracking iothread users with holder".
>     This issue caused by latest merged patch "fdc3f9a83d".
> 
> ### V16 -> V15 Changelog
>   - Unified per-monitor IOThread checks and accesses through
>     mon->iothread after initialization.
>   - Simplified PATCH 13's commit message and clarified why blockdev
>     cannot use the holder-aware get/put APIs.
>   - Dropped the v15 Patch 1 in this series, It will be taken away
>     independently by trivial-patches tree.
> 
> ### V15 -> V14 Changelog
>   - Moved monitor IOThread cleanup from unparent() to monitor_finalize(),
>     pairing complete() with instance finalization.
>   - Squashed V14 PATCH 04 and PATCH 14 into PATCH 13 and clarified the
>     blockdev lifetime assumption. Since the additional changes are minimal,
>     PATCH 13 retains Stefan's Reviewed-by from V14 PATCH 04.
>   - Rebased and adapted info iothreads to the MonitorHMP interface.
> 
> ### V14 -> V13 Changelog
>   - Renamed patch 3 and clarified that it introduces holder-tracking
>     infrastructure, with users converted in subsequent patches.
>   - Documented that monitor holders are not visible to management
>     applications, while retaining the tracking for a consistent holder
>     and IOThread reference lifecycle.
>   - Rebased on the latest upstream.
> 
> 
> 
> Zhang Chen (14):
>   iothread: introduce holder tracking
>   iothread: add holder-aware AioContext accessors
>   block/export: track IOThread references
>   monitor: track IOThread users with QOM paths
>   virtio-vq-mapping: track iothread-vq-mapping references using device
>     path
>   virtio: track IOThread references for thread pinning
>   net/colo: track IOThread references using path-based holder
>   virtio-balloon: Update tracking iothread users with holder
>   vfio-user/proxy: Update tracking iothread users with device QOM paths
>   xen-block: Update tracking iothread users with holder name
>   monitor/hmp: display IOThread holders
>   iothread: make legacy AioContext getter explicitly unsafe
>   tests/unit/iothread: update AioContext ref/put helpers
>   docs/devel: document holder-aware IOThread AioContext APIs
> 
>  block/export/export.c                   |  62 +++++++++++---
>  blockdev.c                              |   9 ++-
>  docs/devel/multiple-iothreads.rst       |  19 +++--
>  hw/block/dataplane/xen-block.c          |  19 ++++-
>  hw/block/virtio-blk.c                   |  21 +++--
>  hw/scsi/virtio-scsi-dataplane.c         |  22 +++--
>  hw/vfio-user/pci.c                      |   2 +-
>  hw/vfio-user/proxy.c                    |  20 ++++-
>  hw/vfio-user/proxy.h                    |   4 +-
>  hw/virtio/iothread-vq-mapping.c         |  20 +++--
>  hw/virtio/virtio-balloon.c              |  21 +++--
>  include/block/export.h                  |   5 ++
>  include/hw/virtio/iothread-vq-mapping.h |   6 +-
>  include/hw/virtio/virtio-balloon.h      |   1 +
>  include/system/iothread.h               |  38 ++++++++-
>  iothread.c                              | 102 +++++++++++++++++++++++-
>  monitor/hmp-cmds.c                      |  20 +++++
>  monitor/monitor-internal.h              |   7 +-
>  monitor/monitor.c                       |  36 ++++++---
>  monitor/qmp.c                           |  14 ++--
>  net/colo-compare.c                      |  36 ++++++---
>  qapi/misc.json                          |  94 +++++++++++++++++++---
>  tests/unit/iothread.c                   |  18 +++--
>  tests/unit/iothread.h                   |   7 +-
>  tests/unit/test-aio-multithread.c       |   5 +-
>  tests/unit/test-bdrv-drain.c            |  18 +++--
>  tests/unit/test-block-iothread.c        |  21 +++--
>  27 files changed, 535 insertions(+), 112 deletions(-)
> 
> -- 
> 2.53.0
> 

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan


