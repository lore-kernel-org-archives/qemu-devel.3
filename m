Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B861FFD7072
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ReS-000236-2V; Tue, 17 Mar 2026 06:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdx-0001ve-CG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2Rdr-0006VJ-K0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 06:27:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso6106085e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773743231; x=1774348031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iRDEAFCxC5LjnOCBEZCiS2Pr7Crk112Fz556YwJLg3g=;
 b=FB2QLunRr2chv1GoXd+1qbnjV2zOt7SCnruze7ilV5mRS9OgF5KB6eFWm3D2EP2GPk
 jN44aK5nNeuzo/bHhmc2U3ydH426V6K4C4IBz7tbrhoccNOW9z6UPDfmckBuapm7wkMG
 pLuAJJ++seSfpDainBR3g51B+a10fWD8y6KdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773743231; x=1774348031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iRDEAFCxC5LjnOCBEZCiS2Pr7Crk112Fz556YwJLg3g=;
 b=s9f4Eu1CdbuxiQbQ0yErIeTGyJ49zhvt/R52TQPuR0puSdcQeihU/aczBAJ28KI15m
 G7/TqEUJnT57y/Z7xzt5/yw+kwaa71tto4nS3TgjHzfkmxVdW0RPIfROIJy9KkX6+W72
 SnKXf3mz2RrhhlUUBfdzoyuz5GjGlIzDmw07HocqAmJxvuXKJunbEhe6Xcub+pk2cQFq
 gyZhlUApJMiIULRJGPnt2wGwpxQSu0RQe8RwvTgkWCpUEIl2gjCt0P6ZVNsEvKr8x1P1
 hwbro0k4Qlu85SpyEEFY0dm6PqRtFt6eWQGMvnM1XikmqEAPuyLog7R3PlBl2S4EVnvK
 +t6A==
X-Gm-Message-State: AOJu0YzoJVqXQnGpj4DAKy4vVGoSWHunuDeuY5IOcQNDkEFctW2l1veC
 ZCia68LZmtNTmvuK8JlYII41JHnCckQ+BVM3LQUN9+aihf/cZJ0N8hyKahFXlfqaunpGijrX4AW
 bhhpoJO0=
X-Gm-Gg: ATEYQzxIh50XQ9oVved/pcucOkx7/LaOFMf+9iKN61clYZ0DEz7u/0ksbq5gcq1lGnO
 Ckeu1QFg+2+JUAVeFJugcLra9zIaOve8XHRdUymKpSBGqHMSlD+84I3AE2PobLoh7obQyOTBv0o
 ZDj8udPQegyrCy2UjkUlyyhC0coxg+V3lBkf2tstToGLUMLYXa3V0e8wqU5mTQjm553w/Xk2Tln
 Y46xjx4eLZsiGywoBs6DCgmtaeJyCTMMvqNGsBSCdlHwK2SdNg7aOVd82nKM0ORiAkYrJKbJvOK
 K/9slUIiOyxV3RRx7YJ3+hCQXQG8EwABaSaRewT2o+74NTq/V4/rfolsOAUWQdWNU3BNcnubSMz
 c2O3a08IhA2H0zVjhaIaILvmy4QX5BhfT5y2MAHq7d4mhksrVbTD6jIlTEsWxO/iRE36w9Im/qB
 hvwrCj2c37v0Q7SjUHSKh+SjrYugbMZDoi+FWKJNIBw+7hdudwXKC/B+CFCpPuPNCXhhzwSJSTo
 /+HCpruX8FRp2es9q0CC04=
X-Received: by 2002:a05:600c:4f0b:b0:485:3b4a:f707 with SMTP id
 5b1f17b1804b1-4856eacf14emr43510155e9.10.1773743229747; 
 Tue, 17 Mar 2026 03:27:09 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0051af80c54da1a9bc.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:51af:80c5:4da1:a9bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9c36bsm61977665e9.9.2026.03.17.03.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:27:09 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 0/8] hw/nvme: add basic live migration support
Date: Tue, 17 Mar 2026 11:27:00 +0100
Message-ID: <20260317102708.126725-1-alexander@mihalicyn.com>
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
https://github.com/mihalicyn/qemu/commits/nvme-live-migration

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
  migration/vmstate: export vmstate_{load, save}_field helpers
  migration: add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
  tests/unit/test-vmstate: add tests for VMS_ARRAY_OF_POINTER_ALLOW_NULL
  tests/functional/migration: add VM launch/configure hooks
  hw/nvme: add migration blockers for non-supported cases
  hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
  hw/nvme: add basic live migration support
  tests/functional/x86_64: add migration test for NVMe device

 hw/nvme/ctrl.c                                | 874 +++++++++++++++++-
 hw/nvme/ns.c                                  | 160 ++++
 hw/nvme/nvme.h                                |   8 +
 hw/nvme/trace-events                          |  11 +
 include/block/nvme.h                          |  12 +
 include/migration/vmstate.h                   |  83 +-
 migration/savevm.c                            |  26 +
 migration/vmstate-types.c                     |  91 ++
 migration/vmstate.c                           |  64 +-
 tests/functional/migration.py                 |  22 +-
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 159 ++++
 tests/unit/test-vmstate.c                     | 157 ++++
 13 files changed, 1618 insertions(+), 50 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

-- 
2.47.3


