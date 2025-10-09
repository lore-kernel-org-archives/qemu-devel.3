Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52B1CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6w8F-00078B-29; Thu, 09 Oct 2025 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w8E-00077l-22
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:16:54 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6w8B-0008GB-KP
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:16:53 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-930cfdfabb3so107681839f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760037409; x=1760642209; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yC7kD2MtrJeTgU0ulwUJLYLiLM02R/yJPJ8Z2Gvf43I=;
 b=mtF0XBt+rkwExMYdGXM5cJkfrYyknQQTZ02xSUUto8fE5H+ymjA4aazrqKaQrmS5U8
 WDilujvHBXrUF6PJ60vkl5d95sDaYme04FVzVYHY1/cF1Ne6CQGrPakZUXtbGsGf7i+k
 vaS6WA3JtAEaeb/VAOa7de0/CXKeCr2T9DohtG49TCd+qXRda96d86sNHyv88IqBpSgw
 OFB/trgaGmvXjIjmCzZBF1XD1VVKM6tbWlUndFVmgd0pPMKb+c22HUs1sYZGtDiOO/1R
 sOcJ7ZgQsRMAn/Aw2Th1mNyggGxwntQsVePjVu12MhlpdAz3TXWQYw7qYajnXXFW5GuD
 L2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760037409; x=1760642209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yC7kD2MtrJeTgU0ulwUJLYLiLM02R/yJPJ8Z2Gvf43I=;
 b=R8RrmOiusFVaqozLe+iZR3X3zGD6xc378ErcGfRuBU1IUQ4jAiUEwnK2kUc5Sb6Bbe
 aShetf0vcD3Q535inmrHd+8t25upeaguYPhUiFv1MydrbY0Fk7rwWD9cuWukqZ6+WQdx
 cRK6Oa0da8gXjnVNjP1Oy24xJce46lV5Iv3W7m9aZyFbdO4dGscHKHkJ7+aTMFfBw3Go
 gohnLFGgri7zKsUcIzWgqhF72a3SVqU5Exyl7tKAWZIK8k8KXdm6uLVe+8iYDFJEBcoC
 wpca8S3GMmocw+vriNYr09i15kjWbWKFfUy+Gw4tfIyW5OgIY3gACTOUg+r62y7rrYUq
 Gz5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNJAmH5h9NBH5X2XS6yObSJJiV+TEmIlwfSMC8yHIZzyNfBwk2m2InJXPQKPdY5yegEZcTDvkU8hbK@nongnu.org
X-Gm-Message-State: AOJu0YyTMhFB3zIUYvxmFmlMC0adEpAWXB2RtyhLwzzW0+h8e7+NvpmQ
 2+nbM5umc6Z3sXtEPwqsLwOHNn7+DMXxKgCY4A9lNiXgbDmbYeSdoKUX8OFk/t3Q+utDQDXOY8K
 rfADRneggZ2NauZtkgxxL5Own5VzwxT0=
X-Gm-Gg: ASbGncs0a3pGpLXaC/o78p1MMhbBzGJyuNMzYkMTUStNldJTwE7HN9f1Xuf7JNiVtvJ
 5BoNPY2TdXiaAPnnCriU/hmQyek7dajjjuqnhxcMhIuvrlGTMj2Kc4RS2BAKO00cyf4kiTZZQzv
 bqTCHdL0C6K72/MH6siwijLd6RzmP8AVtUFQ3m9WccRio5ZMa+9/QWNy36uX3GpnLIqf0GWLxd4
 nvz9MJDyQDrQynhkMugQmTpHBm6DMStlFp6VNidNA==
X-Google-Smtp-Source: AGHT+IH2OmZv9AeU8A/8lqpwkLelvSrbrf+2gk33E6NBnIcEI4SWwbhnZyurNcx5f7IfFCowErx60TEat7xA319/ris=
X-Received: by 2002:a05:6e02:4813:b0:42f:7d6f:7a72 with SMTP id
 e9e14a558f8ab-42f7d6f8053mr133724735ab.5.1760037409016; Thu, 09 Oct 2025
 12:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 15:16:37 -0400
X-Gm-Features: AS18NWAvnbn_I1oxbx50YHJwCA94G9pR75hiysIp0M56VxWqX_0aFG5sgJ0Fgp8
Message-ID: <CAFubqFv8F8swA3EwZfgnVYpHNgs0yZSFgf6wm2DwXgPxSTjs5A@mail.gmail.com>
Subject: Re: [PATCH 00/33] vhost-user-blk: live-backend local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd34.google.com
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

My apologies for the late review here. I appreciate the need to work
around these issues but I do feel the approach complicates Qemu
significantly and it may be possible to achieve similar results
managing state inside the backend. More comments inline.

I like a lot of the cleanups here - maybe consider breaking out a
series with some of the cleanups?

On Wed, Aug 13, 2025 at 12:56=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Local migration of vhost-user-blk requires non-trivial actions
> from management layer, it should provide a new connection for new
> QEMU process and handle disk operation movement from one connection
> to another.
>
> Such switching, including reinitialization of vhost-user connection,
> draining disk requests, etc, adds significant value to local migration
> downtime.

I see how draining IO requests adds downtime and is impactful. That
said, we need to start-stop the device anyways so I'm not convinced
that setting up mappings and sending messages back and forth are
impactful enough to warrant adding a whole new migration mode. Am I
missing anything here?

>
> This all leads to an idea: why not to just pass all we need from
> old QEMU process to the new one (including open file descriptors),
> and don't touch the backend at all? This way, the vhost user backend
> server will not even know, that QEMU process is changed, as live
> vhost-user connection is migrated.

Alternatively, if it really is about avoiding IO draining, what if
Qemu advertised a new vhost-user protocol feature which would query
whether the backend already has state for the device? Then, if the
backend indicates that it does, Qemu and the backend can take a
different path in vhost-user, exchanging relevant information,
including the descriptor indexes for the VQs such that draining can be
avoided. I expect that could be implemented to cut down a lot of the
other vhost-user overhead anyways (i.e. you could skip setting the
memory table). If nothing else it would probably help other device
types take advantage of this without adding more options to Qemu.

Thoughts?

>
> So this series realize the idea. No requests are done to backend
> during migration, instead all backend-related state and all related
> file descriptors (vhost-user connection, guest/host notifiers,
> inflight region) are passed to new process. Of course, migration
> should go through unix socket.
>
> The most of the series are refactoring patches. The core feature is
> spread between 24, 28-31 patches.
>
> Why not CPR-transfer?
>
> 1. In the new mode of local migration we need to pass not only
> file descriptors, but additional parts of backend-related state,
> which we don't want (or even can't) reinitialize in target process.
> And it's a lot simpler to add new fields to common migration stream.
> And why not to pass fds in the same stream?
>
> 2. No benefit of vhost-user connection fd passed to target in early
> stage before device creation: we can't use it together with source
> QEMU process anyway. So, we need a moment, when source qemu stops using
> the fd, and target start doing it. And native place for this moment is
> usual save/load of the device in migration process. And yes, we have to
> deeply update initialization/starting of the device to not reinitialize
> the backend, but just continue to work with it in a new QEMU process.
>
> 3. So, if we can't actually use fd, passed early before device creation,
> no reason to care about:
> - non-working QMP connection on target until "migrate" command on source
> - additional migration channel
> - implementing code to pass additional non-fd fields together with fds in=
 CPR
>
> However, the series doesn't conflict with CPR-transfer, as it's actually
> a usual migration with some additional capabilities. The only
> requirement is that main migration channel should be a unix socket.
>
> Vladimir Sementsov-Ogievskiy (33):
>   vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
>   vhost: drop backend_features field
>   vhost-user: introduce vhost_user_has_prot() helper
>   vhost: move protocol_features to vhost_user
>   vhost-user-gpu: drop code duplication
>   vhost: make vhost_dev.features private
>   virtio: move common part of _set_guest_notifier to generic code
>   virtio: drop *_set_guest_notifier_fd_handler() helpers
>   vhost-user: keep QIOChannelSocket for backend channel
>   vhost: vhost_virtqueue_start(): fix failure path
>   vhost: make vhost_memory_unmap() null-safe
>   vhost: simplify calls to vhost_memory_unmap()
>   vhost: move vrings mapping to the top of vhost_virtqueue_start()
>   vhost: vhost_virtqueue_start(): drop extra local variables
>   vhost: final refactoring of vhost vrings map/unmap
>   vhost: simplify vhost_dev_init() error-path
>   vhost: move busyloop timeout initialization to vhost_virtqueue_init()
>   vhost: introduce check_memslots() helper
>   vhost: vhost_dev_init(): drop extra features variable
>   hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>   vhost-user: make trace events more readable
>   vhost-user-blk: add some useful trace-points
>   vhost: add some useful trace-points
>   chardev-add: support local migration
>   virtio: introduce .skip_vhost_migration_log() handler
>   io/channel-socket: introduce qio_channel_socket_keep_nonblock()
>   migration/socket: keep fds non-block
>   vhost: introduce backend migration
>   vhost-user: support backend migration
>   virtio: support vhost backend migration
>   vhost-user-blk: support vhost backend migration
>   test/functional: exec_command_and_wait_for_pattern: add vm arg
>   tests/functional: add test_x86_64_vhost_user_blk_fd_migration.py
>
>  backends/cryptodev-vhost.c                    |   1 -
>  chardev/char-socket.c                         | 101 +++-
>  hw/block/trace-events                         |  10 +
>  hw/block/vhost-user-blk.c                     | 201 ++++++--
>  hw/display/vhost-user-gpu.c                   |  11 +-
>  hw/net/vhost_net.c                            |  27 +-
>  hw/scsi/vhost-scsi.c                          |   1 -
>  hw/scsi/vhost-user-scsi.c                     |   1 -
>  hw/virtio/trace-events                        |  12 +-
>  hw/virtio/vdpa-dev.c                          |   3 +-
>  hw/virtio/vhost-user-base.c                   |   8 +-
>  hw/virtio/vhost-user.c                        | 326 +++++++++---
>  hw/virtio/vhost.c                             | 474 ++++++++++++------
>  hw/virtio/virtio-bus.c                        |  20 +-
>  hw/virtio/virtio-hmp-cmds.c                   |   2 -
>  hw/virtio/virtio-mmio.c                       |  41 +-
>  hw/virtio/virtio-pci.c                        |  34 +-
>  hw/virtio/virtio-qmp.c                        |  10 +-
>  hw/virtio/virtio.c                            | 120 ++++-
>  include/chardev/char-socket.h                 |   3 +
>  include/hw/virtio/vhost-backend.h             |  10 +
>  include/hw/virtio/vhost-user-blk.h            |   2 +
>  include/hw/virtio/vhost.h                     |  42 +-
>  include/hw/virtio/virtio-pci.h                |   3 -
>  include/hw/virtio/virtio.h                    |  11 +-
>  include/io/channel-socket.h                   |   3 +
>  io/channel-socket.c                           |  16 +-
>  migration/options.c                           |  14 +
>  migration/options.h                           |   2 +
>  migration/socket.c                            |   1 +
>  net/vhost-vdpa.c                              |   7 +-
>  qapi/char.json                                |  16 +-
>  qapi/migration.json                           |  19 +-
>  qapi/virtio.json                              |   3 -
>  stubs/meson.build                             |   1 +
>  stubs/qemu_file.c                             |  15 +
>  stubs/vmstate.c                               |   6 +
>  tests/functional/qemu_test/cmd.py             |   7 +-
>  ...test_x86_64_vhost_user_blk_fd_migration.py | 279 +++++++++++
>  tests/qtest/meson.build                       |   2 +-
>  tests/unit/meson.build                        |   4 +-
>  41 files changed, 1420 insertions(+), 449 deletions(-)
>  create mode 100644 stubs/qemu_file.c
>  create mode 100644 tests/functional/test_x86_64_vhost_user_blk_fd_migrat=
ion.py
>
> --
> 2.48.1
>
>

