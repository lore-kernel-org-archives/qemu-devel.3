Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB88ECCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIhFA-0005a3-7i; Mon, 19 Oct 2026 02:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xIhF7-0005ZZ-Vv
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:53:10 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xIhF5-00069q-UX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:53:09 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1cc392d8bso1929035a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792392785; cv=none;
 d=google.com; s=arc-20260327;
 b=bt2MyE/mGbmXQGd9vL1F7Dn10dG4OJWpLHHxOu4McF8xPyEQXjB/UeEX7modVE5tzn
 t091uH0Kkj973c7wpiCYKKFNhgc7OFCeNkIhUsRRbf9cIHPHmmXdns28dbVpPw2uJuaq
 Xs9GrYEDMnGP0OpcwovU+Iz4qEp5vev5v3wxoYq/ePPiqSJEPtncrCoJREeP02RUW2bO
 B7jBNdENC0h/znnu+ODmcs7OSXO/wd2UcA7tUSZOHL52x1XqoWNNn1iCdtsR/7WWAB4m
 qgG+mo3KyUMzdpbW4IpSwO7mHbKmgO0e8Iw600l6k+MlPY5um+Q5JVbiLvQEUMdObD/1
 O3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pD/CRwTFRQqQz5Uc/ZFouJDd34rFU03sKGHGQtOCkxQ=;
 fh=aU1efp1Hqslajef9yw/kvM+9GDKW8LvzbV7DMPwJ+U0=;
 b=pmS8CzNhdn9+pykWrCvWoLEpdHWynHATGCAcWiVD09kJGCfMqoWYY3SL2bJ3MoQexJ
 1wyiqtANhvyL/wnx7/SIOjZsBNMKTMBKPXncJbqOonGn+T7GRr64L6REPH/Yb4mV5CQj
 Tz79lvhoIRYGKHSIMENoom//ZFkxtpV6WHKB/enILF/5UHRXDBZRjKh1QMtWAvn0sX/E
 GDBrv1aoPyV2VqDsxhppKTFZHxxpnzATcDnnuFlZWfUXGxYeccRqtIbONmsivHKzCb/5
 ZHP2Be4SBZ33+q3f/OPfPUlcJnhsTGBlb375asYGl1+C3eBMvJt+dO3pxOd6sRbBFpfs
 TJLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792392785; x=1792997585; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pD/CRwTFRQqQz5Uc/ZFouJDd34rFU03sKGHGQtOCkxQ=;
 b=AlyiTCRhTLl/iC6DrsWXv7luvsXXfldCunLUYuHxIlurhsL+489U+iC5oXXDcEW3TA
 gVAiFdQzMq3xlMV6DDN0qRf8zdS99k+jx1kxuaEeg1ZRDmccBsK7L028LMkt7e1LEyya
 h6VtwzMLg/HqeUqPMrGbYjYQNFrLBiW2iukYHvntEQF3Zn8QBmP0Qms2vNjhv/N0+TyN
 6/oZbVPcCb5g8QuKsqi29TJmVoV5oR7ffgRMOr1XGY81dMCYCf09Q+fCDZAbtfMbztWK
 kxQTq7Fnv0JclA7g4xHfd5rQCshyyTLX+cdQuLeArDH5HYkG+Q3/6PjMmlL9oI1Dca96
 JHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792392785; x=1792997585;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pD/CRwTFRQqQz5Uc/ZFouJDd34rFU03sKGHGQtOCkxQ=;
 b=TjVw64bUO9NsiEAkO5EzDPtuqGR7Qz4Vb1lLSmQ9Y7NXy4NNFMaMe1ayiTVkTG7qbJ
 xzZ1MxvAT5OGa6auzgD29ysvx6Bhrw78MANWgcXDQDHwkCt0Hn8ai9cIdtsY8hU+aGTK
 CU9GUSrJjvaQCcyYdDb4iS2CD3ZvKvWG/jXhS19VxS8jAflDGGxUP6Eem/tr5zdLKLP1
 kZpUJFzV3si3xtQ9LISGzLLAwErD77J62IPtM+YXn72RWbg4EKyqfxHwobW82AN8mavz
 KX6Ruv/0hiP/2Tvkr8CxEL38haFQRIJ760nU2hY2Ji1PTdGvLgZAaUDpT6sWStk4VChT
 eDYw==
X-Gm-Message-State: AFq9FYKNThj8ZBegb4k3j2UW1fcckX3FJRYIMHPMX1hzx1QL1mbDfd3A
 +/JTC3iPH+mxT8aFSTXGP2/F6Zl5MHVOVo1qsoJmy2gffrjqGCTG+Q4FJvq3G+Q+ky6Zq7036DJ
 dW4zNZcjCU4uV2DLfAKz0yIR4DkrS80FqGA7371E=
X-Gm-Gg: AYBFou02eKarksm12d8Mbe3lTXrwUErLD5FMuVGJkUjW/Tb5wg6IzKDOkuxWk4TT9mc
 S3h4UWS9LtedZlPanldSBmQdAqv8crBLz1mp0nCn46UYDPrn6Q3UP90dumx9NZB0xO75BdHmnTc
 pNfAUWjIYJNIHhXDz9DQSZAxv4h6pM9hCSqURJT1jzVyF+88jWQWZ1A0PkIM+KFPhQwQ9ekrq68
 qPf8vEug397HP0O6lrbdOKneepkSjZT3uSWClT0hUyn1jCTF7txSmYteQnIt7iZwWA+5bDBBIXK
 S9s26uVFWyh292KICN5XFFukMsxIRgU5Y6hB6he6x/zFZ51TPR7fpD88XKO+lg/t3+I=
X-Received: by 2002:a05:6402:1d4a:b0:6b1:ef6b:f3e4 with SMTP id
 4fb4d7f45d1cf-6b3a8176404mr3811510a12.14.1792392784920; Sun, 18 Oct 2026
 23:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260929084416.1600199-1-zhangckid@gmail.com>
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 19 Oct 2026 14:52:26 +0800
X-Gm-Features: AclHuK-urWFDkkmQtaXdTd-Amj-2GBhyDN34vNM-rtxQd1v2fJ5CG4dKfpIZvkU
Message-ID: <CAK3tnvJUWJ3DpG960gCBL0GtvKmPpbiTQeWdcC-eMjcusci4Hg@mail.gmail.com>
Subject: Re: [PATCH V18 00/13] iothread: Support tracking and querying
 IOThread holder
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi all,

A gentle ping on v18. Could you please take a look at the remaining
patches, particularly the COLO and vfio-user changes addressing the
previous review comments?

Please let me know if anything else is needed to move this series forward.

Thanks,
Chen


On Tue, Sep 29, 2026 at 4:44=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> ### Motivation
> Currently, the relationship between IOThreads and the resources using the=
m is
> opaque. From a management perspective, it is difficult to determine which
> devices or block exports are currently associated with a specific IOThrea=
d
> via QMP or HMP.
>
> This series introduces a "holder" tracking mechanism based on QOM paths o=
r
> block exports to significantly improve IOThread observability.
> In high-performance virtualization environments, users often pre-allocate
> a set of IOThreads to serve as a persistent thread pool. During device
> hotplug/unplug cycles, while IOThread objects remain persistent,
> their attachment state changes dynamically.
>
> By tracking these "holders," administrators can use `query-iothreads` to
> monitor the real-time load distribution of the thread pool and identify w=
hich
> specific devices (e.g., virtio-blk, BlockExport) are attached to which th=
read.
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
>   iothread_unref_and_put_aio_context().  Acquiring an AioContext register=
s a
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
>     blockdev lifetime assumption. Since the additional changes are minima=
l,
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
> ### V13 -> V12 Changelog
>   - Refactored block export IOThread reference handling with shared
>     init/cleanup helpers and preserved the existing single-IOThread
>     driver arguments.
>   - Moved monitor IOThread cleanup to the QOM unparent callback,
>     where the canonical path is still available.
>   - Kept internal IOThreads hidden from query-iothreads.
>   - Made virtio queue-mapping holder arguments const.
>   - Improved some detail comments.
>
> ### V12 -> V11 Changelog
>   - Change the function name from the "iothread_put_aio_context()"
>     to "iothread_unref_and_put_aio_context()" match the
>     "iothread_unref_and_put_aio_context".
>   - Fix unnecessary char * cast since the holder variable is
>     declared const.
>   - Add detailed commit msg in patch 06/15.
>   - Optimize the HMP print in patch 13/15.
>   - Rebase code on upstream.
>
>
> Zhang Chen (13):
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
>
>  block/export/export.c                   | 62 +++++++++++++---
>  blockdev.c                              |  9 ++-
>  hw/block/dataplane/xen-block.c          | 19 ++++-
>  hw/block/virtio-blk.c                   | 21 ++++--
>  hw/scsi/virtio-scsi-dataplane.c         | 22 ++++--
>  hw/vfio-user/pci.c                      |  2 +-
>  hw/vfio-user/proxy.c                    | 20 +++++-
>  hw/vfio-user/proxy.h                    |  4 +-
>  hw/virtio/iothread-vq-mapping.c         | 20 ++++--
>  hw/virtio/virtio-balloon.c              | 21 ++++--
>  include/block/export.h                  |  5 ++
>  include/hw/virtio/iothread-vq-mapping.h |  6 +-
>  include/hw/virtio/virtio-balloon.h      |  1 +
>  include/system/iothread.h               | 38 +++++++++-
>  iothread.c                              | 89 ++++++++++++++++++++++-
>  monitor/hmp-cmds.c                      | 20 ++++++
>  monitor/monitor-internal.h              |  7 +-
>  monitor/monitor.c                       | 36 +++++++---
>  monitor/qmp.c                           | 14 ++--
>  net/colo-compare.c                      | 36 ++++++----
>  qapi/misc.json                          | 94 +++++++++++++++++++++----
>  tests/unit/iothread.c                   | 18 +++--
>  tests/unit/iothread.h                   |  7 +-
>  tests/unit/test-aio-multithread.c       |  5 +-
>  tests/unit/test-bdrv-drain.c            | 18 +++--
>  tests/unit/test-block-iothread.c        | 21 ++++--
>  26 files changed, 508 insertions(+), 107 deletions(-)
>
> --
> 2.43.0
>

