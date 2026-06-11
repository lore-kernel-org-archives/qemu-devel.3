Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1564CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjpl-00070J-Ak; Thu, 11 Jun 2026 14:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpj-0006ym-Di
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpf-0002FE-Kz
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so821685e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781201324; x=1781806124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6JzkVWCpLix1/Wim0D5gr5+TOU8iTfxXj8Cpd9/BXmQ=;
 b=PbGNH2uX22LP6zFs4JXhUV9xQBSuuAsP9TFcI12Gy/sf3xl4QfDX/J4ImTn9Q4/fXU
 bXbthKjVl2eL5lGO+SMsiSU2WbtN5N0TZC7EW/leRyABCseVdv5HbE6RZK5mUQlTTF3Q
 H5IHb9/nRiD+Y5r8CxG4yCN36CreY2VGTTJEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201324; x=1781806124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JzkVWCpLix1/Wim0D5gr5+TOU8iTfxXj8Cpd9/BXmQ=;
 b=UCL4s0L58tWTWSgOjONK01MZ9kjGADlLqKe+qb60nC2D3l9saP8b7QWMmbDYidDOu3
 5fRssxXXpkDLczuSGpPcxmGb4ZOk/KR0wKMevFqI7CRqpccN7r+hPy8r1cZDVgUZxEqk
 hknQThILsfs23Dh4ivwYofcSf7NFdgyvdicCVBL75zykxaXc4fOUGikzZ3N2aV8d2LZV
 7Tc/JPFh25mkT3/HHCAw2VEFu1XqxRUCxqkxvMi6i7iLN0wFuAt2qTWM7UL93vLRc8ir
 mIwCMLmdWwURQwlfy4D3PDZjdNPDYPGGQxnHb0Xd9Q+4AMf8g55PUaRC9WAOx3WHcnzl
 hJsg==
X-Gm-Message-State: AOJu0YwwYEV8lJDvUh0nXKEnT4wTwMifZ/mTgq0x4KKYM7HHYEafKPzQ
 MkORQtlAkDugUKBxeY79zEG+J8D+PrCFrsSdYz8WYx9sT7PdDNH5Vx5sFMUsfUvyR9vM+NYX0t4
 qgDJmoZU=
X-Gm-Gg: Acq92OFeEAAWx5mxPSp2oOLxZAFASUt2f7HdsStM+OSJU8++wtDpry52k4qfi56JL9m
 Kpo/c139Z3due2++S8dc0KGoeLN0yPQf1o7YONL4hxtf3KKF5UNa6PXPrAHuRnN/d2IOsTsb5mb
 DQI36eCJRg6AvRH3kkcWcX8k2ckWELAtZhmEbUtnsFk06hrUaDfZBUuECLDi6ThxenQksghcb4c
 YKQWFBpCKZ1kTmNnmioHwVYt0n38dfkgzgyje+bsMag16rJsrZO5km4LXMDyezShujWkqRSRTff
 GzPQkkCp5+H8trjv9y0m8v5JQz8VPfKMOLNpvdoa+Qo1GNHzlg6TO4z8LkyamZF5jPNWm30cjzk
 zdMEfFyPlksd6vq1+dnW5R73KgtohmeA71Pid8Il3NLd5QHupcS/18L3KYsKRFyVFttPgrhEx9K
 yzdajDRXh61vZf+yLi16taLn5f9vCcEZnOE9wUvL7o6xSjA9EgaI98JxgTAzfHeF4UJmnysGhB+
 /xF8kOfzeC5xjGgGicpmgA=
X-Received: by 2002:a05:600c:c0c3:10b0:490:b06a:649e with SMTP id
 5b1f17b1804b1-490e5611c60mr44902135e9.25.1781201323656; 
 Thu, 11 Jun 2026 11:08:43 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006f778db3bc22ef81.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6f77:8db3:bc22:ef81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm6563345e9.0.2026.06.11.11.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:08:43 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v10 0/8] hw/nvme: add basic live migration support
Date: Thu, 11 Jun 2026 20:08:33 +0200
Message-ID: <20260611180842.6390-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset adds basic live migration support for
QEMU emulated NVMe device.

Implementation has some limitations:
- only one NVMe namespace is supported
- SMART counters are not preserved
- CMB is not supported
- PMR is not supported
- SPDM is not supported
- SR-IOV is not supported

I believe this is something I can support in next patchset versions or
separately on-demand (when usecase appears).

Testing.

This patch series was manually tested on:
- Debian 13.3 VM (kernel 6.12.69+deb13-amd64) using fio on *non-root* NVMe disk
  (root disk was virtio-scsi):

time fio --name=nvme-verify \
    --filename=/dev/nvme0n1 \
    --size=5G \
    --rw=randwrite \
    --bs=4k \
    --iodepth=16 \
    --numjobs=1 \
    --direct=0 \
    --ioengine=io_uring \
    --verify=crc32c \
    --verify_fatal=1

- Windows Server 2022 VM (NVMe drive was a *root* disk) with opened browser
  playing video.

No defects were found.

Git tree:
https://gitlab.com/mihalicyn/qemu/-/commits/nvme-live-migration

Changelog for version 10:
- build fix on Alpine Linux (PAGE_SIZE macro redefinition)
- clang build fix [ thanks to Fabiano ]
- format specifier change from %lx to 0x% PRIx64 in qtest (fix for win64 cross build)
- I run the entire testsuite, (almost) all green now
  https://gitlab.com/mihalicyn/qemu/-/pipelines/2594705360
  all the failures I can see look unrelated to this patchset
- I kept all RWB/ACK-tags in place (hope it is fine as all changes were trivial)

Changelog for version 9:
- many trivial check-patch fixes here and there
- disabled qtest on ppc64 (spapr bus) by adding qpci_check_buggy_msi() check
  [ we had a private discussion with Klaus and he told me that ppc64
    tests are failing after debugging I found this old patch which wasn't merged
    for some reason https://lore.kernel.org/qemu-devel/20250502030446.88310-5-npiggin@gmail.com/ ]
- I kept all RWB/ACK-tags in place (hope it is fine, cause really I hasn't changed too much)
- QEMU CI tests results https://gitlab.com/mihalicyn/qemu/-/pipelines/2593676152

Changelog for version 8:
- rebased
- added Acked-by from Stefan
- added RWB tag from Klaus
- added RWB tag from Peter

Changelog for version 7:
- rebased on top of recent main
- addressed review comments from Stefan Hajnoczi:
  - better incoming migration stream validation (SQ/CQids correctness)
  - endianness bugs are fixed in qtest (validated on s390x)
- added RWB tags from Klaus

Changelog for version 6:
- rebased on top of:
  https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null
  (see also https://lore.kernel.org/all/20260401202844.673494-1-peterx@redhat.com)
- addressed review comments from Stefan Hajnoczi:
  - supported "full CQ" case by serializing NvmeRequest state
  - added qtest for NVMe device migration with full CQ

Changelog for version 5:
- rebased on top of https://lore.kernel.org/all/20260304212303.667141-1-vsementsov@yandex-team.ru/
  (as Peter has requested)

Changelog for version 4:
- vmstate dynamic array support reworked as suggested by Peter Xu
  VMS_ARRAY_OF_POINTER_ALLOW_NULL flag was introduced
  qtests were added
- NVMe migration blockers were reworked as Klaus has requested earlier
  Now, instead of having "deny list" approach, we have more strict pattern
  of NVMe features filtering and it should be harded to break migration when
  adding new NVMe features.

Changelog for version 3:
- rebased
- simple functional test was added (in accordance with Klaus Jensen's review comment)
  $ meson test 'func-x86_64-nvme_migration' --setup thorough -C build

Changelog for version 2:
- full support for AERs (in-flight requests and queued events too)

Kind regards,
Alex

Alexander Mikhalitsyn (8):
  tests/functional/migration: add VM launch/configure hooks
  hw/nvme: add migration blockers for non-supported cases
  hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
  hw/nvme: set CQE.sq_id earlier in nvme_process_sq
  hw/nvme: unmap req->sg earlier in nvme_enqueue_req_completion
  hw/nvme: add basic live migration support
  tests/functional/x86_64: add migration test for NVMe device
  tests/qtest/nvme-test: add migration test with full CQ

 MAINTAINERS                                   |    1 +
 hw/nvme/ctrl.c                                | 1036 ++++++++++++++++-
 hw/nvme/ns.c                                  |  164 +++
 hw/nvme/nvme.h                                |   12 +
 hw/nvme/trace-events                          |   10 +
 include/block/nvme.h                          |   12 +
 tests/functional/migration.py                 |   23 +-
 tests/functional/x86_64/meson.build           |    1 +
 .../functional/x86_64/test_nvme_migration.py  |  172 +++
 tests/qtest/nvme-test.c                       |  419 +++++++
 10 files changed, 1814 insertions(+), 36 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

-- 
2.47.3


