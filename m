Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B3AC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqng-00087d-8X; Fri, 02 Feb 2024 05:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqne-00086r-9T
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqnc-0001WJ-76
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uAzEGb+J/AkRTlKgn4Q+UQOBOrQwlPrCK4S8wbDak54=;
 b=RVBaivthOlZnij5xoi3O+UrVpoeKdUi9S83wg+obvnPtHVSS+Z4/cY5+evXkd1/GNNejKv
 5M5dVK4pu7oJF0wP3VXBK7tp5ibX40yHnCHtjVzF5/+dZXlC9iROw/7i7thpCM/8H/e5LQ
 QbIStKT/VIcaHuglG5E4bzRXXwQQXlg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-bVQAquUqN36rs66pSEA-hg-1; Fri,
 02 Feb 2024 05:29:24 -0500
X-MC-Unique: bVQAquUqN36rs66pSEA-hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D20DB3C0BE4D;
 Fri,  2 Feb 2024 10:29:23 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37A2340C9444;
 Fri,  2 Feb 2024 10:29:19 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 00/23] migration/multifd: Refactor ->send_prepare() and
 cleanups
Date: Fri,  2 Feb 2024 18:28:34 +0800
Message-ID: <20240202102857.110210-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

v1: https://lore.kernel.org/r/20240131103111.306523-1-peterx@redhat.com

This v2 patchset contains quite a few refactorings to current multifd:

 1) Redefines send_prepare() interface, to be:

      p->pages ----------->  send_prepare() -------------> IOVs

    A major goal of it is to get prepared for others to add quite a few new
    hardware accelerators for multifd compression, or adding zeropage
    detection accelerators.

    It turns out we don't yet need more hooks to achieve that, so hopefully
    most new accelerator codes do not need a lot of changes if rebase onto
    this (please still wait until this series fully reviewed and merged;
    hopefully this should happen soon).  Please note that p->normal[] is
    dropped; now please use p->pages->offset[] for the same purpose.
    Please check the code for details.

    We may want a separate OPs for file later, which I'll leave that
    decision to Fabiano.

    This also prepares any possibility of replacing p->pages to raw
    buffers (VFIO usage).  But that's left for later too.  Logically with
    this patchset applied, it should be much easier.

 2) [new in v2] Fixed one more race usage of MultiFDSendParams.packet_num,
    as reported by Fabiano during his review on v1.  This is mostly done in
    the single patch:

 3) [new in v2] Made multifd sender side lockless, by dropping the mutex,
    as suggested by Fabiano in his review in v1.  This is mostly done in a
    single patch:

 4) A lot of cleanups to multifd code, it picked up some patches from an
    old series of mine [0] (the last patches were dropped, though; I did
    the cleanup slightly differently), and added a bunch of other cleanups
    either I got to see when doing that, or requested when Fabiano reviewed
    v1.

    Note: when I worked on this I even found more things to cleanup.  But I
    decided to stop at only what mostly requested from Fabiano in v1 to
    stop growing this series.

1) above is mostly done in:

    migration/multifd: Move header prepare/fill into send_prepare()

2) above is mostly done in:

    migration/multifd: Fix MultiFDSendParams.packet_num race

3) above is mostly done in:

    migration/multifd: Optimize sender side to be lockless

The rest patches all fall into 4) category.  Please have a look, thanks.

Avihai/Fabiano, I hope my understanding is right that we can still consider
this series before a separate patchset to fix the dangling thread issue.
If not, please shoot.

v2 changelog:

- When spurious wakeup happens for multifd sender thread, crash hard rather
  than causing a deadlock later.
- Always use atomic operations on pending_job / pending_sync
- Moved the setup of zerocopy write_flags from multifd_save_setup() into
  no-comp setup() phase.
- Added below patches, some form of request here and there from Fabiano:
  migration/multifd: Split multifd_send_terminate_threads()
  migration/multifd: Change retval of multifd_queue_page()
  migration/multifd: Change retval of multifd_send_pages()
  migration/multifd: Rewrite multifd_queue_page()
  migration/multifd: Cleanup multifd_save_cleanup()
  migration/multifd: Cleanup multifd_load_cleanup()
  migration/multifd: Stick with send/recv on function names
  migration/multifd: Fix MultiFDSendParams.packet_num race
  migration/multifd: Optimize sender side to be lockless

[0] https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
[1] https://lore.kernel.org/qemu-devel/20240126221943.26628-1-farosas@suse.de

Peter Xu (23):
  migration/multifd: Drop stale comment for multifd zero copy
  migration/multifd: multifd_send_kick_main()
  migration/multifd: Drop MultiFDSendParams.quit, cleanup error paths
  migration/multifd: Postpone reset of MultiFDPages_t
  migration/multifd: Drop MultiFDSendParams.normal[] array
  migration/multifd: Separate SYNC request with normal jobs
  migration/multifd: Simplify locking in sender thread
  migration/multifd: Drop pages->num check in sender thread
  migration/multifd: Rename p->num_packets and clean it up
  migration/multifd: Move total_normal_pages accounting
  migration/multifd: Move trace_multifd_send|recv()
  migration/multifd: multifd_send_prepare_header()
  migration/multifd: Move header prepare/fill into send_prepare()
  migration/multifd: Forbid spurious wakeups
  migration/multifd: Split multifd_send_terminate_threads()
  migration/multifd: Change retval of multifd_queue_page()
  migration/multifd: Change retval of multifd_send_pages()
  migration/multifd: Rewrite multifd_queue_page()
  migration/multifd: Cleanup multifd_save_cleanup()
  migration/multifd: Cleanup multifd_load_cleanup()
  migration/multifd: Stick with send/recv on function names
  migration/multifd: Fix MultiFDSendParams.packet_num race
  migration/multifd: Optimize sender side to be lockless

 migration/multifd.h      |  50 ++--
 migration/migration.c    |  12 +-
 migration/multifd-zlib.c |  11 +-
 migration/multifd-zstd.c |  11 +-
 migration/multifd.c      | 630 ++++++++++++++++++++++-----------------
 migration/ram.c          |   2 +-
 migration/trace-events   |   2 +-
 7 files changed, 404 insertions(+), 314 deletions(-)

-- 
2.43.0


