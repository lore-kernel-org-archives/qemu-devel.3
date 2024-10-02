Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2C3CF319C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 08:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svuqy-000142-LX; Wed, 02 Oct 2024 04:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svuqv-00013s-85
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svuqt-0005dJ-23
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 04:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727858213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPmehwjaIJ/aiZJChPUDyyteVMFwMsJuswsWN9nORC4=;
 b=R8/hLvwp8+HibChzlrLTDx0r96t7nJJWCvUYfQ2GYkyXAQMLu+FonigU8mcQA67gs0uWn4
 4Ga0VO/JvZ2DKlmzYXkDZiq5P+dX/znM3zSV538cc2W2JqBP1/0+zQKVhYnVgHOvDv2G3T
 LfPIaCK0EFaLnhMJUg81mCfAFGsOaLk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-ZZIk3CRJMRqUNRBQj4R3yA-1; Wed,
 02 Oct 2024 04:36:52 -0400
X-MC-Unique: ZZIk3CRJMRqUNRBQj4R3yA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1635519560A5; Wed,  2 Oct 2024 08:36:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3F1719560AD; Wed,  2 Oct 2024 08:36:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 00/22] -Werror=maybe-uninitialized fixes
Date: Wed,  2 Oct 2024 12:36:23 +0400
Message-ID: <20241002083646.2893078-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:

  Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/warn-pull-request

for you to fetch changes up to baad82ecfb27474f17f4318502725622ab7170fc:

  qom/object: fix -Werror=maybe-uninitialized (2024-10-02 11:36:12 +0400)

----------------------------------------------------------------
-Werror=maybe-uninitialized fixes

----------------------------------------------------------------

Marc-André Lureau (22):
  util/coroutine: fix -Werror=maybe-uninitialized false-positive
  util/timer: fix -Werror=maybe-uninitialized false-positive
  hw/qxl: fix -Werror=maybe-uninitialized false-positives
  nbd: fix -Werror=maybe-uninitialized false-positive
  block/mirror: fix -Werror=maybe-uninitialized false-positive
  block/mirror: fix -Werror=maybe-uninitialized false-positive
  block/stream: fix -Werror=maybe-uninitialized false-positives
  hw/ahci: fix -Werror=maybe-uninitialized false-positive
  hw/vhost-scsi: fix -Werror=maybe-uninitialized
  hw/sdhci: fix -Werror=maybe-uninitialized false-positive
  block/block-copy: fix -Werror=maybe-uninitialized false-positive
  migration: fix -Werror=maybe-uninitialized false-positives
  hw/virtio-blk: fix -Werror=maybe-uninitialized false-positive
  migration: fix -Werror=maybe-uninitialized false-positive
  linux-user/hppa: fix -Werror=maybe-uninitialized false-positive
  target/loongarch: fix -Werror=maybe-uninitialized false-positive
  tests: fix -Werror=maybe-uninitialized false-positive
  hw/virtio: fix -Werror=maybe-uninitialized
  hw/virtio: freeing leaked memory from vhost_svq_get_buf in
    vhost_svq_poll
  block: fix -Werror=maybe-uninitialized false-positive
  fsdep/9p: fix -Werror=maybe-uninitialized false-positive
  qom/object: fix -Werror=maybe-uninitialized

 block/block-copy.c                 |  2 +-
 block/file-posix.c                 |  2 +-
 block/mirror.c                     |  8 ++++----
 block/stream.c                     |  6 +++---
 fsdev/9p-iov-marshal.c             | 15 ++++++++++++---
 hw/block/virtio-blk.c              |  2 +-
 hw/display/qxl.c                   |  4 ++--
 hw/ide/ahci.c                      |  3 ++-
 hw/scsi/vhost-scsi.c               |  2 +-
 hw/sd/sdhci.c                      |  2 +-
 hw/virtio/vhost-shadow-virtqueue.c |  6 ++++--
 linux-user/hppa/cpu_loop.c         |  2 ++
 migration/dirtyrate.c              |  4 ++--
 migration/migration.c              |  2 +-
 migration/ram.c                    |  2 +-
 nbd/client-connection.c            |  2 +-
 qom/object.c                       |  2 +-
 target/loongarch/gdbstub.c         | 26 ++++++++++++++------------
 tests/unit/test-bdrv-drain.c       |  2 +-
 tests/unit/test-block-iothread.c   |  2 +-
 util/qemu-coroutine.c              |  2 +-
 util/qemu-timer.c                  |  6 +++---
 roms/openbios                      |  2 +-
 23 files changed, 61 insertions(+), 45 deletions(-)

-- 
2.45.2.827.g557ae147e6


