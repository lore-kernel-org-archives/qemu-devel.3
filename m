Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD67CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdUt-0001Et-JJ; Thu, 11 Jun 2026 07:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUs-0001EL-Ol
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUq-00015i-JN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so47273475e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781176971; x=1781781771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mqB4N9E7k2p/QU7bz0tTWoRbsx9PaEkiPT6NRae5L+s=;
 b=EqwAmw+OQYseSEUilQy0rbrDjRZrvV3tK9b5bNYyoE+1I/wQAIiOJ6Nm/Nloqe6oS9
 TCySIk4rlUD7NZvx9RoInUTTuGlDpS7a4mK6QHDDHtwi9n/3oR2vH3JsBV3FsZcF5xNb
 ox1pTFdm3Nxe/LhJJosvDy4XZaho+IZ/7WrwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176971; x=1781781771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqB4N9E7k2p/QU7bz0tTWoRbsx9PaEkiPT6NRae5L+s=;
 b=N9iEt4l5EFYkC1g1gooRvWALbBVuNYLtUTVbc29d950ilXNFg0qaudXjhd7K3YObBR
 u/pSjcvab+SJhICoWowYky1Bt+nXmUGgc52jgADCon0VpF7x8GWO+h0lxaVomlZAHK1G
 EW6MEw13Gum20IQyoNcHKQkA7+trds+ntJIS0bliWHiR7y8Iq6HRq01Zp4gzSKMGPxiD
 Z301Mul6MEcNiYBssR2cbz0yDYf66eBo/SiUBtycSGmZ3lB5+0tkqvaZXXCo0PtYqvVY
 yQ/BbewZZtWBNKtSuSqJJ/i/uyujbKyWMGhhIXNdSGVHCMvIz/szwlrSZ1ohzLF3lU3z
 Kz1A==
X-Gm-Message-State: AOJu0YwwKVEJs54uJID12z13gdID75UqHs+iTn/ys72+G5/zudsuJC/G
 YCDhvgfXaLnO/8NzkX+5fR+Jot9OJx5vmtOK8doy+4RMdCNC4EiYrhmucwErwKJWpinAUmyar/M
 K2+rv6mk=
X-Gm-Gg: Acq92OGGae6eqsstcfkDdce8euMHxTqmEk0c05a1iDttvY3aRc65CYLC6LP8cpkI1e1
 BB4DTsTvjIpebQLTyyBnJCSM6zS2q8+qx+JT77Ax5q6LNcDwFkrP4EBeMRmZ0+YDqE0Dl698Nw+
 6Sk1cg4ZFPrGd4v4eSPH1SR5WGaYaUKFmZLBYd1JpiaAETF/mx9azR9njwTuHIgD9fGZZuOp9NM
 K3vbMPaVFicIkaXQmtj2nBZ9VyBkBRgbLAhp4ZdpXPpCdt6vlL2v5P4DoSRnq6w1Dx8he9yeN59
 UE7YqoV/e8xsYm95/t9dT+cqY9LuK4UpZOhQ+UscZ4SrUZdOSPImS7ouU8RQrpdFpAao7Tal9DC
 Kq4LV8OWib2SCx+D0rEyg/8QkAZMfSYqhq8BQb9RwUpebhi5zo2vi3k2f+GZjl20wSDqS4C8T26
 sbg4HvLxzT8tqyYN6UgzRTItYVts293dCDqKIcyhyRIwuJ68/GiO6UElC0OfJ+eWV3GNq5XynUs
 87UMVdqfzqt+6rI43Rt7tP8RwmZkQzewA==
X-Received: by 2002:a05:600c:3550:b0:490:e5c1:b897 with SMTP id
 5b1f17b1804b1-490e5d0fe68mr27139415e9.20.1781176970646; 
 Thu, 11 Jun 2026 04:22:50 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006c26edf58ff062dc.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6c26:edf5:8ff0:62dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fb24sm86375554f8f.34.2026.06.11.04.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:22:50 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v9 0/8] hw/nvme: add basic live migration support
Date: Thu, 11 Jun 2026 13:22:41 +0200
Message-ID: <20260611112249.165012-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x330.google.com
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
https://gitlab.com/mihalicyn/qemu/-/commits/nvme-live-migration

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
 hw/nvme/ctrl.c                                | 1035 ++++++++++++++++-
 hw/nvme/ns.c                                  |  164 +++
 hw/nvme/nvme.h                                |   12 +
 hw/nvme/trace-events                          |   10 +
 include/block/nvme.h                          |   12 +
 tests/functional/migration.py                 |   23 +-
 tests/functional/x86_64/meson.build           |    1 +
 .../functional/x86_64/test_nvme_migration.py  |  172 +++
 tests/qtest/nvme-test.c                       |  421 +++++++
 10 files changed, 1815 insertions(+), 36 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

-- 
2.47.3


