Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99264C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqt-0005k1-Iu; Tue, 25 Aug 2026 17:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqs-0005j8-88
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:38 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqp-0004z8-Dj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 0675A808EE;
 Wed, 26 Aug 2026 00:38:28 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-FukKNoF3; Wed, 26 Aug 2026 00:38:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693907;
 bh=w2DX/o2qHXYK6TsjjrK0VRSLPiDhegEqH+Zkd4JRfxg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=knr78rG0OrSeCC+rh6TqJxS0M9CXSmQUE69s24LJrJoDPzDMYm2CmJpM46DxMywFb
 ZKAQsKtsYWpTtd2kiZeNaBkKOg2QdfIn+MNzPOKLYV3pALjlq6LsN/cbIC0XIiTlHC
 ZBjYxDk2UDtZWo1J7Y/8KIQrcBnrQtprEiy6vCo4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 00/30] move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:40 +0300
Message-ID: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi all!

That's a new version for old

[RFC 00/22] migration: convert vmstate_load/save_state

after the core patches converting migration code
are already merged into master.

Let's now convert the whole code base.

Vladimir Sementsov-Ogievskiy (30):
  tests/unit/test-vmstate: move to new migration APIs
  ui/vdagent: move to new migration APIs
  hw/virtio: extra state: move to new migration APIs
  hw/virtio: config save/load: move to new migration APIs
  hw/virtio: make virtio_save() and virtio_load() static
  hw/virtio: remaining: move to new migration APIs
  hw/s390x/virtio-ccw.c: move to new migration APIs
  hw/scsi/spapr_vscsi: move to new migration APIs
  hw/scsi/scsi-bus.c: use new migration APIs
  hw/vfio/pci: move to new migration APIs
  hw/pci/pci: move to new migration APIs
  hw/pci/msix.c: use new migration APIs
  hw/pci/shpc.c: use new migration APIs
  hw/display/virtio-gpu: move to new migration APIs
  hw/net/virtio-net.c: use new migration APIs
  hw/nvram/eeprom93xx.c: use new migration APIs
  hw/nvram/fw_cfg.c: use new migration APIs
  hw/usb/redirect.c: move to new migration APIs
  alpha/machine: move to new migration APIs
  avr/machine: move to new migration APIs
  or1k/machine: move to new migration APIs
  microblaze/machine: move to new migration APIs
  hppa/machine: move to new migration APIs
  sparc/machine: move to new migration APIs
  ppc/machine: move to new migration APIs
  mips/machine: move to new migration APIs
  arm/machine: move to new migration APIs
  migration/vmstate-types: convert vmstate_info_g_byte_array to new APIs
  migration: VMStateInfo: remove old .get / .set handlers
  migration: finally drop vmstate_save/load_state() functions

 hw/display/virtio-gpu.c        |  99 +++++++++++----------
 hw/net/virtio-net.c            | 133 ++++++++++++++--------------
 hw/nvram/eeprom93xx.c          |  17 ++--
 hw/nvram/fw_cfg.c              |  24 ++---
 hw/pci/msix.c                  |  17 ++--
 hw/pci/pci.c                   |  85 +++++++++---------
 hw/pci/shpc.c                  |  20 +++--
 hw/s390x/virtio-ccw.c          |  40 ++++-----
 hw/scsi/scsi-bus.c             |  17 ++--
 hw/scsi/spapr_vscsi.c          |   9 +-
 hw/usb/redirect.c              |  59 +++++++------
 hw/vfio/pci.c                  |  14 ++-
 hw/virtio/vhost-user-fs.c      |  68 +++++++-------
 hw/virtio/virtio-mmio.c        |  31 +++----
 hw/virtio/virtio-pci.c         |  45 +++++-----
 hw/virtio/virtio.c             | 157 +++++++++++++++++----------------
 include/hw/pci/pci.h           |   4 +-
 include/hw/virtio/virtio-bus.h |   8 +-
 include/hw/virtio/virtio.h     |   4 -
 include/migration/vmstate.h    |  17 ----
 migration/vmstate-types.c      |  17 ++--
 migration/vmstate.c            |  32 +------
 target/alpha/machine.c         |  17 ++--
 target/arm/machine.c           | 107 +++++++++++-----------
 target/avr/machine.c           |  50 ++++++-----
 target/hppa/machine.c          |  34 +++----
 target/microblaze/machine.c    |  17 ++--
 target/mips/system/machine.c   |  49 +++++-----
 target/or1k/machine.c          |  17 ++--
 target/ppc/machine.c           |  80 ++++++++---------
 target/sparc/machine.c         |  68 +++++++-------
 tests/unit/test-vmstate.c      | 118 +++++++------------------
 ui/vdagent.c                   |  38 ++++----
 33 files changed, 710 insertions(+), 802 deletions(-)

-- 
2.43.0


