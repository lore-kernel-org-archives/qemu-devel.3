Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618ACEFCE4B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxtgq-0004mw-FJ; Wed, 04 Mar 2026 16:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgZ-0004jw-VS
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:17 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgW-0003R6-6k
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:15 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 000DD80861;
 Thu, 05 Mar 2026 00:23:06 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-LJ3gwjOq; Thu, 05 Mar 2026 00:23:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659386;
 bh=vbqSuSScSZ8F9CxLTW5J64QpP+OI3UQwzjbtHl3/oFE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=PCB5BTnG60T3eyBCoBMruP25tKLSePk3XXCZgl7/7C9r5lG4KG1F0bLYdRkaGGZCK
 j2YAtc3GF+eEy5bq41r85iDN/udkALJsoAQTLJbdpk81GWjx3zr4eTVvSIv69lWN6H
 X9m8Bn0CdXZ3HxhB4zp/ApWXX0H924SFoCMGvcgc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [PATCH v3 00/18] migration: more bool+errp APIs
Date: Thu,  5 Mar 2026 00:22:44 +0300
Message-ID: <20260304212303.667141-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v3:
01,02: add r-bs by Fabiano and Peter
03: improve comment, add r-b by Peter
04: add r-bs by Fabiano and Peter
05: new, replacement for dropped "[PATCH v2 05/16] migration: vmstate_save/load_state(): stop tracing errors"
06: rebase on kept trace-points, keep r-b by Peter
07-09: add r-b by Peter
10: rebase on kept trace-points, keep r-b by Peter
11-12: add r-b by Peter
13: rebase ion kept traces and logic around trace_vmstate_load_field_error() already refactored, fix indent, drop r-b
14: add r-b by Peter
15: add r-b by Peter, use "else { if () {} }"
16-17: new
18: rebased on dropped err_hint, drop r-b

Vladimir Sementsov-Ogievskiy (18):
  migration: vmstate_save_state_v: fix double error_setg
  migration: make vmstate_save_state_v() static
  migration: make .post_save() a void function
  migration: vmstate_load_state(): add some newlines
  migration: vmstate_save/load_state(): refactor tracing errors
  migration: factor out vmstate_pre_save() from vmstate_save_state()
  migration: factor out vmstate_save_field() from vmstate_save_state()
  migration: factor out vmstate_pre_load() from vmstate_load_state()
  migration: factor out vmstate_load_field() from vmstate_load_state()
  migration: factor out vmstate_post_load() from vmstate_load_state()
  migration: convert vmstate_subsection_save/load functions to bool
  migration: VMStateInfo: introduce new handlers with errp
  migration: introduce vmstate_load_vmsd() and vmstate_save_vmsd()
  migration/cpr: move to new migration APIs
  migration/savevm: move to new migration APIs
  hw/s390x/css: drop use of .err_hint for vmstate
  migration: drop VMStateField.err_hint
  migration/vmstate-types: move to new migration APIs

 docs/devel/migration/main.rst |   2 +-
 hw/block/fdc.c                |   2 +-
 hw/display/qxl.c              |   4 +-
 hw/display/vga.c              |   2 +-
 hw/display/virtio-gpu.c       |   2 +-
 hw/display/vmware_vga.c       |   2 +-
 hw/i386/vmmouse.c             |   2 +-
 hw/ide/ahci.c                 |   2 +-
 hw/intc/openpic.c             |   2 +-
 hw/intc/spapr_xive.c          |   2 +-
 hw/intc/xics.c                |   2 +-
 hw/intc/xive.c                |   2 +-
 hw/nvram/eeprom93xx.c         |   2 +-
 hw/pci/pci.c                  |   2 +-
 hw/pci/pcie_aer.c             |   2 +-
 hw/ppc/spapr_iommu.c          |   2 +-
 hw/ppc/spapr_pci.c            |   7 +-
 hw/ppc/spapr_vio.c            |   4 +-
 hw/s390x/css.c                |  15 +-
 hw/usb/hcd-uhci.c             |   2 +-
 include/migration/cpr.h       |   2 +-
 include/migration/vmstate.h   |  73 ++--
 migration/cpr.c               |  22 +-
 migration/savevm.c            | 108 +++---
 migration/trace-events        |  30 +-
 migration/vmstate-types.c     | 642 +++++++++++++++++-----------------
 migration/vmstate.c           | 354 +++++++++++--------
 target/arm/machine.c          |   4 +-
 target/ppc/machine.c          |   6 +-
 29 files changed, 691 insertions(+), 612 deletions(-)

-- 
2.52.0


