Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42991C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfWMc-0005Y2-UL; Fri, 03 Jul 2026 01:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWMZ-0005WF-TZ; Fri, 03 Jul 2026 01:22:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wfWMX-0005w6-0j; Fri, 03 Jul 2026 01:22:55 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635LT8N018373
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 3 Jul 2026 14:21:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=eRgDwmfqLOROSsM7iDfNfv4dTa1BcJ8KBiEORkeKTHc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1783056102; v=1;
 b=JPcyGAj3IGq8xd9orzIITQJi+gi2gUCskbFRmBaBPLfurfUDsag8SmirzClB8To7
 0TrJohL3Gh/OxsWy8VmFmegHgpVTvRHuEn+tA6xBqRwIlF5B72DhpYw80LWjK49C
 ZDUdV4fP1+p4SviIgGbM/rVEluugBRhaOQl2XwmxV2X3QSt6/Bq2saDPdUNW7fgR
 52RHLJBlEirIoo/jk4A9Ufs/pADk7oC6aVWWcCfCYC3aK6jj44WybkqR9Z5mtTWk
 XrRrkrRhElS8A1rd+r2a8+hJKncVpMz8BkfkLh2r33DYO9iSzUaRaiVEDj8y7PUr
 qBmT70n9/whlLtWnyZRQZg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 0/7] migration/ram: Assert RAMBlock stability while
 streaming RAM
Date: Fri, 03 Jul 2026 14:19:16 +0900
Message-Id: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQqDMBBFryKzbkImFFu76j3ERYwTHUuNJCoV8
 e6NtszqwftvNogUmCI8sg0CLRzZDwn0JQPbmaElwU1i0ErnKp0I5i0aSw6vTil0NSRzDOT4c1b
 K6sdxrnuy0zE9jI7j5MN6vlnw8P5FxLO4oFDC6MZYlxfFDe/PEFtpWbKcxeRfq5fGyn6Eat/3L
 +7bNhe1AAAA
X-Change-ID: 20260606-ram-dcef14f001fb
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, linux-edac@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2770;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=NNkYV0KyYReVgPGgyQOKUoe4QJmGzhT1a38kyn3oGx4=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a72+0ve/+nVHHc23tBX1w+LfJai3yJbPn3vpW7OKeVz
 T4QePFjRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwEROzGFkeLbAjTX068LrLueM
 KswOfu42s9/yStvoa9CZhogPX4TWyDEyHFuz6vamT0kxGq9VE8uc3Vf8mGXD+dExUlaBL1hp15F
 HXAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RAM migration sends the RAMBlock list and sizes before transferring page
contents. The RAM code cannot cope with migratable RAMBlocks being
added, removed, renamed, made migratable/non-migratable, or resized
while that stream is active, because the destination has already parsed
the stream layout.

Add RAMBlock notifier checks so such changes are caught immediately.
Ignored RAMBlocks remain exempt because they are not represented in the
RAM migration stream.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Added patch "hw/nvram/fw_cfg: Remove acpi-mr-restore".
- Added patch "hw/nvram/fw_cfg: Avoid resizing RAM at runtime".
- Added patch "migration/ram: Fix ram_save_complete() return value".
- Link to v1: https://lore.kernel.org/qemu-devel/20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (7):
      hw/nvram/fw_cfg: Remove acpi-mr-restore
      hw/nvram/fw_cfg: Avoid resizing RAM at runtime
      system/memory: Remove the resized callback
      system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
      system/physmem: Notify RAMBlock migratable and idstr changes
      migration/ram: Fix ram_save_complete() return value
      migration/ram: Assert RAMBlock stability while streaming RAM

 include/hw/core/loader.h       |   1 +
 include/hw/nvram/fw_cfg.h      |   5 +-
 include/migration/misc.h       |   2 +-
 include/system/memory.h        |   4 --
 include/system/ramblock.h      |   7 +--
 include/system/ramlist.h       |  24 ++++++----
 block/block-ram-registrar.c    |   8 ++--
 hw/acpi/ghes.c                 |   6 ++-
 hw/acpi/vmgenid.c              |   1 +
 hw/arm/virt-acpi-build.c       |   3 +-
 hw/core/loader.c               |  14 +++---
 hw/core/machine.c              |   1 -
 hw/core/numa.c                 |  54 +++++++++++++++++----
 hw/display/ramfb.c             |   2 +-
 hw/i386/acpi-build.c           |   3 +-
 hw/isa/lpc_ich9.c              |   2 +
 hw/loongarch/virt-acpi-build.c |   3 +-
 hw/misc/vmcoreinfo.c           |   3 +-
 hw/nvram/fw_cfg.c              |  80 ++++++++++++++++++-------------
 hw/riscv/virt-acpi-build.c     |   3 +-
 hw/xen/xen-mapcache.c          |   6 +--
 migration/ram.c                | 106 +++++++++++++++++++++++++++--------------
 system/memory.c                |   7 +--
 system/physmem.c               |  40 +++++++---------
 target/i386/nvmm/nvmm-all.c    |   4 +-
 target/i386/sev.c              |   8 ++--
 util/vfio-helpers.c            |   7 +--
 27 files changed, 247 insertions(+), 157 deletions(-)
---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260606-ram-dcef14f001fb

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


