Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83836CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBZD-0002Fb-9j; Mon, 30 Sep 2024 04:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBYy-0001iG-Sb
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBYp-0005aW-Ki
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727684114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=risbI3bTLmRXwMbrFArb02ftLaLtFLnXBup+RkGUlyI=;
 b=R0utawbZvqDU7LbwLxTRTN6M8w+XNmHWBCpZwrlx5+reqVJ2slsGwxBc7RUEPcwVn9ZMzO
 4FppjJX7WxZtY+PGuWZuVS/23P8GRF4G8TbZr8GrNFsqyVRLqfIj0jyB/5h6MBsNmMHnq4
 MmKZGhyV3Amn+q5Tv5QLKWscBTNVpj8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-RlEB4nEPMEuJ3EYly_uXgw-1; Mon,
 30 Sep 2024 04:15:10 -0400
X-MC-Unique: RlEB4nEPMEuJ3EYly_uXgw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DFA3196C428; Mon, 30 Sep 2024 08:15:07 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87A9519560AA; Mon, 30 Sep 2024 08:15:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/22] -Werror=maybe-uninitialized fixes
Date: Mon, 30 Sep 2024 12:14:35 +0400
Message-ID: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

Depending on -Doptimization=<value>, GCC (14.2.1 here) produces different
maybe-uninitialized warnings:
- g: produces -Werror=maybe-uninitialized errors
- 0: clean build
- 1: produces -Werror=maybe-uninitialized errors
- 2: clean build
- 3: produces few -Werror=maybe-uninitialized errors
- s: produces -Werror=maybe-uninitialized errors

Most are false-positive, because prior LOCK_GUARD should guarantee an
initialization path. Few of them are a bit trickier. Finally, I found
a potential related memory leak.

Patches missing r-b: 6, 10-11, 15-21

thanks

v3:
 - some changes suggested by Manos
 - added s-o-b/a-b

v2:
 - rebased, dropped some patches
 - added some new patches with updated code-base and newer GCC
 - added s-o-b/a-b

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
  RFC: hw/virtio: a potential leak fix
  block: fix -Werror=maybe-uninitialized false-positive
  qom/object: fix -Werror=maybe-uninitialized
  fsdep/9p: fix -Werror=maybe-uninitialized false-positive

 block/block-copy.c                 |  2 +-
 block/file-posix.c                 |  2 +-
 block/mirror.c                     |  8 ++++----
 block/stream.c                     |  6 +++---
 fsdev/9p-iov-marshal.c             |  6 +++---
 hw/block/virtio-blk.c              |  2 +-
 hw/display/qxl.c                   |  4 ++--
 hw/ide/ahci.c                      |  3 ++-
 hw/scsi/vhost-scsi.c               |  2 +-
 hw/sd/sdhci.c                      |  2 +-
 hw/virtio/vhost-shadow-virtqueue.c |  6 ++++--
 linux-user/hppa/cpu_loop.c         | 10 +++++-----
 migration/dirtyrate.c              |  4 ++--
 migration/migration.c              |  2 +-
 migration/ram.c                    |  2 +-
 nbd/client-connection.c            |  2 +-
 qom/object.c                       |  5 ++++-
 target/loongarch/gdbstub.c         | 26 ++++++++++++++------------
 tests/unit/test-bdrv-drain.c       |  2 +-
 tests/unit/test-block-iothread.c   |  2 +-
 util/qemu-coroutine.c              |  2 +-
 util/qemu-timer.c                  |  6 +++---
 roms/openbios                      |  2 +-
 23 files changed, 58 insertions(+), 50 deletions(-)

-- 
2.45.2.827.g557ae147e6


