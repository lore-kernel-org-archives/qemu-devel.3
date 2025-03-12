Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B60C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMKQ-0004KI-Nt; Wed, 12 Mar 2025 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsMK6-0004Ij-V4; Wed, 12 Mar 2025 09:40:39 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsMK4-0004oS-6Y; Wed, 12 Mar 2025 09:40:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5e34f4e89so10711049a12.1; 
 Wed, 12 Mar 2025 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741786833; x=1742391633; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvyvLeWFZnPSh0kNCrQSqPiULMpRNI6p9V27Fh0ENG4=;
 b=ZsEVt4lcwzE36DPBvHpmeRWxxPqv2NYoQDd1XRFmiTX+DFUxMvXbPTF5gQPtJpsTIv
 dGR42uok6es5hkm36rZzv9rHljc1ZM3nOveQ6LSQM47wKghssuhAnkl4cZHorDXUUPTq
 GBuH7wQOnC/TSS8gxnHKVCIxOgLKTDhVG0iE45AMbhPOqcqdqZTwZF2ndebMusmLESLy
 fkyQR6KA1WMfdAQ+bHyto1Y2abHKgtFQTWUBS1ZGYtKrhzWg/AI9YEPcjnXEWyhAsRzS
 cUV58eMDm5vDWTlvpufjrKmggSP0nNOl5W3MA3oakMojhqxRANrBV7FpnH2OJirtCVbg
 XrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741786833; x=1742391633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvyvLeWFZnPSh0kNCrQSqPiULMpRNI6p9V27Fh0ENG4=;
 b=Z1OYze1RVGmW/to+MAzRJuIPZAPkDcvlX5wCPUx0bZkBbq1+Ne1OLXUjsZKBoH/jzk
 v9E4s3+KKkhzZOG10t7cVzkU1JP3RZAPVqdpdHpz35eLT+uiNQLSaAjIoXOby5COOXbh
 XANnTseeNsG1UCzYH/HwlBa4c3ry4UwJL+J8QRKJwjJTv+Wadk3LHOfQICAt9i7pZ1Fv
 DmRwnQMbSn8pqw70V2tN5wewvCWu86SGctSEKa3ln7D/IzQT1fvHkng5hLzYKdLksiJD
 4Rk5FTbg9/V5m5vZFnnet+nxOPqQX1Ti+NM8tDvn+bwAPYeDbMrQrCxMlunLM1luqIPU
 1wOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRgyU3BmooOqDlGSQOwMePjAZVyEu06IEE9xJmE5kZXB0tUwZgzbn8RgNePjS0WjiDWCba8DG32hQk@nongnu.org
X-Gm-Message-State: AOJu0Yxx+S9r0a3RgSgs2Rfmn3dejHZtD9xDjZVETE4Egr3440CpbSGG
 Yjn9xL/xtjXnkGdj0fTBJWf1ZVwW9MZzM6rbfNrHQGSFAXJ0HFHKIaailrEavsN61Mz8InAVrGc
 mPNBshyd4lWmjj6+Jr/N3Q67LJn3tQhLCqRM=
X-Gm-Gg: ASbGnctYP0r20xpLsj/O0o37WwBvUdE+x6vcs7OnhkiqA5uW+kVqvfpE99ViQjbhnKt
 oDjiuSt55ymTmcEobEwVW0zpARXQQzaPS5odXWE9dZ8SF9fCaXku0v/p/ntXHIgVyIGX7getBKC
 Sc0WgTyqe2gqMIKDGI/sHs3VKqCA==
X-Google-Smtp-Source: AGHT+IFIKAz2qqgxEUnCOX2+slkAPLY7NSIYh65ZsHKcHLXGVMH6uZGV+mEFOvetOlrt4RQKmTkIsUfamFD/HJNSc58=
X-Received: by 2002:a05:6402:5109:b0:5e0:82a0:50dd with SMTP id
 4fb4d7f45d1cf-5e5e24da027mr27730278a12.27.1741786832496; Wed, 12 Mar 2025
 06:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250311160021.349761-1-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 12 Mar 2025 21:40:19 +0800
X-Gm-Features: AQ5f1JrLIFd4yv_DwJtTQ5Kcvs7sm26qkCecGJSKel2W3Elgg9R3BNYyYx2BBS4
Message-ID: <CAJSP0QXFhALMxNNAwMvbSseRy23Fyu=km+Kr=WJZUL_eEKonUw@mail.gmail.com>
Subject: Re: [PULL 00/22] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Wed, Mar 12, 2025 at 12:06=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>
> The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da=
32:
>
>   Merge tag 'migration-20250310-pull-request' of https://gitlab.com/faros=
as/qemu into staging (2025-03-11 09:32:07 +0800)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to a93c04f3cbe690877b3297a9df4767aa811fcd97:
>
>   virtio-scsi: only expose cmd vqs via iothread-vq-mapping (2025-03-11 15=
:49:22 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - virtio-scsi: add iothread-vq-mapping parameter
> - Improve writethrough performance
> - Fix missing zero init in bdrv_snapshot_goto()
> - Code cleanup and iotests fixes

The following CI failures came up:
1. laio_has_fua() is missing on some host OSes:
https://gitlab.com/qemu-project/qemu/-/jobs/9380928997#L3369
2. io_uring_prep_writev2() without #ifdef HAVE_IO_PREP_PWRITEV2:
https://gitlab.com/qemu-project/qemu/-/jobs/9380928883#L2515
3. qemu-iotests 051:
https://gitlab.com/qemu-project/qemu/-/jobs/9380928853#L4519

Please send a v2 pull request. Thanks!

Stefan

>
> ----------------------------------------------------------------
> Kevin Wolf (8):
>       block: Remove unused blk_op_is_blocked()
>       block: Zero block driver state before reopening
>       file-posix: Support FUA writes
>       block/io: Ignore FUA with cache.no-flush=3Don
>       aio: Create AioPolledEvent
>       aio-posix: Factor out adjust_polling_time()
>       aio-posix: Separate AioPolledEvent per AioHandler
>       aio-posix: Adjust polling time also for new handlers
>
> Stefan Hajnoczi (13):
>       scsi-disk: drop unused SCSIDiskState->bh field
>       dma: use current AioContext for dma_blk_io()
>       scsi: track per-SCSIRequest AioContext
>       scsi: introduce requests_lock
>       virtio-scsi: introduce event and ctrl virtqueue locks
>       virtio-scsi: protect events_dropped field
>       virtio-scsi: perform TMFs in appropriate AioContexts
>       virtio-blk: extract cleanup_iothread_vq_mapping() function
>       virtio-blk: tidy up iothread_vq_mapping functions
>       virtio: extract iothread-vq-mapping.h API
>       virtio-scsi: add iothread-vq-mapping parameter
>       virtio-scsi: handle ctrl virtqueue in main loop
>       virtio-scsi: only expose cmd vqs via iothread-vq-mapping
>
> Thomas Huth (1):
>       iotests: Limit qsd-migrate to working formats
>
>  include/block/aio.h                         |   5 +-
>  include/block/raw-aio.h                     |   8 +-
>  include/hw/scsi/scsi.h                      |   8 +-
>  include/hw/virtio/iothread-vq-mapping.h     |  45 +++
>  include/hw/virtio/virtio-scsi.h             |  15 +-
>  include/system/block-backend-global-state.h |   1 -
>  include/system/dma.h                        |   3 +-
>  util/aio-posix.h                            |   1 +
>  block/block-backend.c                       |  12 -
>  block/file-posix.c                          |  26 +-
>  block/io.c                                  |   4 +
>  block/io_uring.c                            |  13 +-
>  block/linux-aio.c                           |  24 +-
>  block/snapshot.c                            |   1 +
>  hw/block/virtio-blk.c                       | 132 +-------
>  hw/ide/core.c                               |   3 +-
>  hw/ide/macio.c                              |   3 +-
>  hw/scsi/scsi-bus.c                          | 121 +++++--
>  hw/scsi/scsi-disk.c                         |  24 +-
>  hw/scsi/virtio-scsi-dataplane.c             | 103 ++++--
>  hw/scsi/virtio-scsi.c                       | 502 ++++++++++++++++------=
------
>  hw/virtio/iothread-vq-mapping.c             | 131 ++++++++
>  system/dma-helpers.c                        |   8 +-
>  util/aio-posix.c                            | 114 ++++---
>  util/async.c                                |   1 -
>  hw/virtio/meson.build                       |   1 +
>  meson.build                                 |   4 +
>  tests/qemu-iotests/tests/qsd-migrate        |   2 +-
>  28 files changed, 803 insertions(+), 512 deletions(-)
>  create mode 100644 include/hw/virtio/iothread-vq-mapping.h
>  create mode 100644 hw/virtio/iothread-vq-mapping.c
>
>

