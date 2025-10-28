Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4234CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstL-0002tg-F3; Tue, 28 Oct 2025 19:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstJ-0002tK-Ki
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:13 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst7-000147-4D
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:13 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 79A4781745;
 Wed, 29 Oct 2025 02:13:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-ThdkQgOK; Wed, 29 Oct 2025 02:13:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693232;
 bh=oGzexodoqwXXxow5Kv5HhsSopMsjYnhQLeF2d62uSBs=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=aarnUWNGFNctRYHkyoO9qLwaLhlA772ZqBcAnE1RJx+h7oZyVoVPzl2SkzwXj9Q0Y
 rHFEezx1YhEISqA7XV+Vm21eERTBYqfj0wX49gs3lSuKdgBeyzrTxdYc9oYgHE4kgh
 59bQIqJ63wuzYlqgB/rLNaoQdCmeKBpmN0xV0SnY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 00/22] migration: convert vmstate_load/save_state
Date: Wed, 29 Oct 2025 02:13:24 +0300
Message-ID: <20251028231347.194844-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
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

Hi all!

That's a proof-of-concept for converting vmstate_load/save_state
to have boolean error value, to fixup this analysis
  https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
in code.

As many of .get / .set handlers call vmstate_load/save_state,
let's convert them too, it not too much.

And finally, while touching each file, let's also use
new pre/post _errp() APIs.

So, this series propagate a lot of errors through errp, which
were simply printed out before.

Why it is an RFC:
1. I didn't yet double check the accuracy of all patches
2. Maybe, commit messages need to be more detailed, maybe they
need more arguments about correctness of the change
3. Maybe, it's better first merge new generic interfaces, and
than send per-maintainer small series, to avoid this huge
series, depending on many maintainers.

So, I don't include in CC many maintainers now, to get a first
look from Markus and Peter.

What do you think?

Based on [PATCH v4 0/2] migration: vmsd errp handlers: return bool
Based-on: <20251028130738.29037-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (22):
  migration: introduce vmstate_load_vmsd() and vmstate_save_vmsd()
  migration: VMStateInfo: introduce new handlers with errp
  tests/unit/test-vmstate: move to new migration APIs
  ui/vdagent: move to new migration APIs
  hw/s390x/virtio-ccw.c: move to new migration APIs
  hw/scsi/spapr_vscsi: move to new migration APIs
  hw/scsi/scsi-bus.c: use new migration APIs
  hw/vfio/pci: move to new migration APIs
  hw/pci/pci: move to new migration APIs
  hw/pci/msix.c: use new migration APIs
  hw/pci/shpc.c: use new migration APIs
  hw/virtio: move to new migration APIs
  hw/display/virtio-gpu: move to new migration APIs
  hw/net/virtio-net.c: use new migration APIs
  hw/nvram/eeprom93xx.c: use new migration APIs
  hw/nvram/fw_cfg.c: use new migration APIs
  migration/cpr: move to new migration APIs
  migration/savevm: move to new migration APIs
  migration/vmstate-types: move to new migration APIs
  migration: VMStateInfo: remove old .get / .set handlers
  migration: convert vmstate_subsection_save/load functions to bool
  migration: finally convert vmstate_save/load_state() functions

 hw/display/virtio-gpu.c        |  66 ++--
 hw/net/virtio-net.c            | 118 ++++---
 hw/nvram/eeprom93xx.c          |  25 +-
 hw/nvram/fw_cfg.c              |  30 +-
 hw/pci/msix.c                  |  17 +-
 hw/pci/pci.c                   |  66 ++--
 hw/pci/shpc.c                  |  22 +-
 hw/s390x/virtio-ccw.c          |  25 +-
 hw/scsi/scsi-bus.c             |  17 +-
 hw/scsi/spapr_vscsi.c          |   6 +-
 hw/vfio/pci.c                  |  14 +-
 hw/virtio/vhost-user-fs.c      |  65 ++--
 hw/virtio/virtio-mmio.c        |  10 +-
 hw/virtio/virtio-pci.c         |  10 +-
 hw/virtio/virtio.c             |  78 +++--
 include/hw/virtio/virtio-bus.h |   4 +-
 include/hw/virtio/virtio.h     |   2 -
 include/migration/cpr.h        |   4 +-
 include/migration/vmstate.h    |  19 +-
 migration/cpr.c                |  32 +-
 migration/migration.c          |   2 +-
 migration/savevm.c             | 108 +++---
 migration/vmstate-types.c      | 584 ++++++++++++++++-----------------
 migration/vmstate.c            | 187 +++++------
 tests/unit/test-vmstate.c      | 116 ++-----
 ui/vdagent.c                   |  38 +--
 26 files changed, 804 insertions(+), 861 deletions(-)

-- 
2.48.1


