Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B5CD3B7F6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 10:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVyh-0003NJ-Mh; Mon, 25 Nov 2024 05:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tFVyd-0003Me-Rn
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tFVyb-0008Bb-7M
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 05:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732529152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6SMsgNkKKmgIIsg8EyJhLbqeFa8eI74P8++VgVIhggs=;
 b=cC58l+8s5/OYh0R3XHnkRonqJBXsB/vd1yQSK1irN3K138flLvPkajuKEwNUC5DIC5f9as
 9HQT7yd3WsjJ0XsY4DY6EhWUK3e+xBo3GSmWjoZSX8hSEgRmcHUQm2KFKuqfLamUZ2Cn30
 O3XJevAQc0mQFmcY4SGlYFAPYp3vspk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-gNGVtkv_PwCGkGAuHm5v4w-1; Mon,
 25 Nov 2024 05:05:50 -0500
X-MC-Unique: gNGVtkv_PwCGkGAuHm5v4w-1
X-Mimecast-MFC-AGG-ID: gNGVtkv_PwCGkGAuHm5v4w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DB791953953; Mon, 25 Nov 2024 10:05:49 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.190])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D435196BC05; Mon, 25 Nov 2024 10:05:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL v4 00/10] Block layer patches
Date: Mon, 25 Nov 2024 11:05:41 +0100
Message-ID: <20241125100541.26259-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 6b99bb046dd36a6dd5525b8f88c2dcddae49222a:

  Merge tag 'pull-lu-20241122' of https://gitlab.com/rth7680/qemu into staging (2024-11-24 13:39:06 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to fbdea3d6c13d5a75895c287a004c6f1a6bf6c164:

  ssh: Do not switch session to non-blocking mode (2024-11-25 11:03:42 +0100)

----------------------------------------------------------------
Block layer patches

- Fix qmp_device_add() to not throw non-scalar options away (fixes
  iothread-vq-mapping being silently ignored in device_add)
- Fix qdev property crash with integer PCI addresses and JSON -device
- iotests: Fix mypy failure
- parallels: Avoid potential integer overflow
- ssh: libssh broke with non-blocking sessions, use a blocking one for now
- Fix crash in migration_is_running()

----------------------------------------------------------------
Dmitry Frolov (1):
      parallels: fix possible int overflow

Jakub Jelen (1):
      ssh: Do not switch session to non-blocking mode

John Snow (4):
      iotests: reflow ReproducibleTestRunner arguments
      iotests: correct resultclass type in ReproducibleTestRunner
      python: disable too-many-positional-arguments warning
      python: silence pylint raising-non-exception error

Kevin Wolf (2):
      qdev: Fix set_pci_devfn() to visit option only once
      tests/avocado/hotplug_blk: Fix addr in device_add command

Stefan Hajnoczi (2):
      qdev-monitor: avoid QemuOpts in QMP device_add
      vl: use qmp_device_add() in qemu_create_cli_devices()

 block/parallels.c                |  4 +--
 block/ssh.c                      |  3 ---
 hw/core/qdev-properties-system.c | 54 ++++++++++++++++++++++++++--------------
 system/qdev-monitor.c            | 42 ++++++++++++++++++++-----------
 system/vl.c                      | 14 +++--------
 python/scripts/mkvenv.py         |  3 +++
 tests/avocado/hotplug_blk.py     |  2 +-
 tests/qemu-iotests/iotests.py    | 11 +++++---
 python/setup.cfg                 |  1 +
 tests/qemu-iotests/pylintrc      |  1 +
 10 files changed, 83 insertions(+), 52 deletions(-)


