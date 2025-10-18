Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95349CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA8wo-0001bJ-Nj; Sat, 18 Oct 2025 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vA8wm-0001au-JW
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 11:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1vA8wk-0000O7-Pa
 for qemu-devel@nongnu.org; Sat, 18 Oct 2025 11:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760801656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og/tNUHrmrh1WVKFecQS3eE9ozKVeoOwfsY1aZHAaUk=;
 b=TGOy84OXVaePOZcbIUD85XD+MMTj2lEhngAI3l7kr0qUIdF/DQOYkXzrPURcSz2FE7Vnzk
 YFR1TkdW/W67lidgr2Sq+rux5EMY110hWovORUoe1I1K/sjDE0tZ9qSn+mNKjVUf3Hu8uh
 8SC3EE0W0OVXXGWG7TfvtgaT2V1xntg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-RIu4GPUUPKaaQNMhVvJrcw-1; Sat, 18 Oct 2025 11:34:14 -0400
X-MC-Unique: RIu4GPUUPKaaQNMhVvJrcw-1
X-Mimecast-MFC-AGG-ID: RIu4GPUUPKaaQNMhVvJrcw_1760801653
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-63c5b404e95so321312a12.0
 for <qemu-devel@nongnu.org>; Sat, 18 Oct 2025 08:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760801653; x=1761406453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Og/tNUHrmrh1WVKFecQS3eE9ozKVeoOwfsY1aZHAaUk=;
 b=DYTrdMviuBLpQLjagATJ/0HwGKCxS2beYk2onQtCU5NV7IytV9xamu9IpgSAVEPoBD
 kqpBMVmlGxUqjaBwpGWds/mfw4ESFbiSIsjNZCLafcF5Qdfgy9DMfX+3iEMe5cPk0/v6
 bgz5EG/tsNGG56zMaE28vrPWjcm314wclFJ5U4scldeuME1x/stSW26Abj/ZU5k+mx9H
 e7bVcLlYc1beI4NDtb9v80li5BOfhPeu6BdVgV8WZ8P8EBzP+ljUSMKSC9paTTyXxhum
 SRHzvTaIn+MBPEgv4KMi6hUIEnWETsYvb6JMJOKop1FaqNxRvtVh2htxhpOJrfbPn3EY
 UvSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4vXFkGnI7byiVjgUCX6W+2p9dyptNb0wpY+p8VGyP+yeQGU431zJG+dZrj2IGjqdPAtmnZavjf3Wk@nongnu.org
X-Gm-Message-State: AOJu0YwtQmiuOc51aT1VnXbZnUUNHDGpgR1uWHpENIbkNvILAJHtLuX7
 V3Xk7CetJtG42LtasxnaTG6Ot8MYYJpYK/tbmno5YuFWQ8otrCAMQiZgqimsOwSw70pTszT0JpX
 Fnf2hwMkycrRpjKkF1IZNC3ryN+rgL3PkP85fIxUoIWkwLvSXg8LBgkeSwGd0MV2rebcRO14Ars
 jfeIKHKh36zaFl+zSmvsL2zWuPkqneiEQ=
X-Gm-Gg: ASbGnctnB0Pb9q/YPmkga3W7+J8Gh/oKgGUbAY7M6qfHclYO3raa/ffKX2MBs9jM0qd
 DHGYpbbFv0egTKL3YvmXdA2nMJFYj8pLtVTVZFj6Y91Th7aYjcjhXApk+fp4cEDd6RoLjpZVvNw
 BnU9jgbjDAt9SvucmAJHFc/y/pgFj+f5o2e3OV+kwHl52MRTJL9WNWBNrd
X-Received: by 2002:a05:6402:2686:b0:63c:1a7b:b3bb with SMTP id
 4fb4d7f45d1cf-63c1f631befmr6719212a12.1.1760801652805; 
 Sat, 18 Oct 2025 08:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm0GREF74Vw+OYBl+AyxeZ4wAqWYJi2aZKDgC863RqVX0eadS3ugO01p40hHFZEEyNSvJ+G1XAypXw3atIRhY=
X-Received: by 2002:a05:6402:2686:b0:63c:1a7b:b3bb with SMTP id
 4fb4d7f45d1cf-63c1f631befmr6719186a12.1.1760801652432; Sat, 18 Oct 2025
 08:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 18 Oct 2025 23:33:34 +0800
X-Gm-Features: AS18NWAPD2Z8w92peeaquRV3QPncaMdeSwypvANLBu6KAwOeiEhV4d0Q6-Dz2Fg
Message-ID: <CAPpAL=y-iAYCj3k2C561QmAnCLVsvnr+Jntux+tvaTEk5+jVag@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] vhost refactoring and fixes
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>


On Wed, Oct 15, 2025 at 11:03=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all. That's rebased and updated first part of
>   [PATCH 00/33] vhost-user-blk: live-backend local migration
>
> v3:
> 01-05,07-23: add r-b by Daniil
> 01,03,04,11-12,15,19,22,23: add r-b by Raphael
> 02: - add a-b by Markus and Raphael
>     - touch-up commit message
> 06: carefully follow existing pattern
>     of split into features / features_ex
>
> Vladimir Sementsov-Ogievskiy (23):
>   vhost-user: rework enabling vrings
>   vhost: drop backend_features field
>   vhost-user: introduce vhost_user_has_protocol_feature() helper
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
>   vhost: vhost_dev_init(): simplify features initialization
>   hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
>   vhost-user: make trace events more readable
>   vhost-user-blk: add some useful trace-points
>   vhost: add some useful trace-points
>
>  backends/cryptodev-vhost.c     |   9 +-
>  hw/block/trace-events          |  10 ++
>  hw/block/vhost-user-blk.c      |  20 ++-
>  hw/display/vhost-user-gpu.c    |  11 +-
>  hw/net/vhost_net.c             |  35 ++--
>  hw/scsi/vhost-scsi.c           |   1 -
>  hw/scsi/vhost-user-scsi.c      |   1 -
>  hw/virtio/trace-events         |  16 +-
>  hw/virtio/vdpa-dev.c           |   3 +-
>  hw/virtio/vhost-user-base.c    |   8 +-
>  hw/virtio/vhost-user.c         | 285 ++++++++++++++++++++++---------
>  hw/virtio/vhost.c              | 300 +++++++++++++++++----------------
>  hw/virtio/virtio-bus.c         |  18 +-
>  hw/virtio/virtio-hmp-cmds.c    |   2 -
>  hw/virtio/virtio-mmio.c        |  41 +----
>  hw/virtio/virtio-pci.c         |  34 +---
>  hw/virtio/virtio-qmp.c         |  12 +-
>  hw/virtio/virtio.c             |  48 +++---
>  include/hw/virtio/vhost-user.h |   3 +
>  include/hw/virtio/vhost.h      |  63 +++++--
>  include/hw/virtio/virtio-pci.h |   3 -
>  include/hw/virtio/virtio.h     |  16 +-
>  net/vhost-vdpa.c               |   7 +-
>  qapi/virtio.json               |   3 -
>  24 files changed, 537 insertions(+), 412 deletions(-)
>
> --
> 2.48.1
>
>


