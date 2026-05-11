Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D2DCD484A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSIY-0005rF-6C; Mon, 11 May 2026 11:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSII-0005oM-Hn
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIF-0001ob-Mb
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso3930883f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1778512298; x=1779117098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yeEjIozXYuggNWnj6sGS9niPy+sTNKFrmy7l77LLm6M=;
 b=RMPDjTYpdb9f00KGhDBqXL6Rcpde1d2djbsOGqmeHwTqbX2cQnFp5+qUumrIDqweJz
 hpWsneXTYdvcimcbbzoW139WJTLFG4hw3zbOPmDO+KzuCBtOMt9zNDNklGpgI3eR1Vrc
 3ByM6tM5W5+UDMkfacdaNvha0iPHeL7M/i2P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512298; x=1779117098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeEjIozXYuggNWnj6sGS9niPy+sTNKFrmy7l77LLm6M=;
 b=bkHA02yybNRfxROJJdpUPsIwHv2TpXrE8f21PrgdSkHEd4OAHLsE3F6R7609U80F38
 /4DEkZjiCUhGYTjs2ndrsG19j8wSC56YfNABmmBoiJCey/aUH/ATeqglpYTv+gI1ainq
 ym/mnAa+XX5WdiDFJq30UcYA1gikxlQAU5pF/P0JKkuxGvl/A/j4kfbVKq6ffMFEltDU
 thXW9c3od3V1v248Rd8YUa5SnuPUl/CeVDvr9SC5VL8DXUN69BBpz+8//qZ+z63Xtlq2
 nRElg4rIzreqj5rxmHKqmHkKNv78Hdf6s2ubTcF6DEuZuc/1ZBXpIuhZNOghh2eZFSSx
 /zow==
X-Gm-Message-State: AOJu0YymHxeIhuUoZ4OTbrfIXkD2w9fUWIhH0EEqxGHkwBpd5wblu52H
 g65VsfaqqfW1n1Yx2smjZf5nhj107IvBSNyIT4MiDtJTCRIFQoTDHKTAhmF9vj/ilScXV8nhdgn
 RHcrveH8=
X-Gm-Gg: Acq92OHLNy/qrSJeA8PBBm6Fa/4FfhR+M2TjwhE8lbuykbYnrR5k8OxGXV+6c1UssHL
 upeEfLNJlpO1Evv5AIV/jwf5Kd6w+RKj56i4xPXCMdR3zdbl6qExtYSLKooBzVxv4o/sFKhVkz3
 rYK+FL1oNo+L6QGjFPXJWMVLkybp+JlUMQONRHtdnOhSSV+QNgRm1qGjHxXp9U0XUeJdh7tCUbY
 O1NJBuQcDaRvoLzhmzoHGP2JO4+Z/asqJ5CcNOh3dt7KId6NWeEZbhIIg6M/LihF+v8uCJ3ig4F
 j+/creiDC4/F38pMtt7fkRrtN/KdGNdYIEm31YXJnYHBvhsFXxO+mxj8gD2a1fzHsiUgn9rfKVF
 8EY/hPUq3i8F+YMabMZt5ZnlSU4dhBc2xqaHxSpZEMezr52Wlofu67AwY9uCE+TUlHJNAyFIu4k
 r0NRXyIHWL9ctK0tjUYl0AeI4+7ygjh2jBzM9e6bl6apd6d22/SUAfyQR5I30Bs8whFNe05rMhW
 Y/i+QO9uKGi8glESITC
X-Received: by 2002:a05:600c:1f95:b0:48e:82cc:4d4c with SMTP id
 5b1f17b1804b1-48e82cc4d69mr62849795e9.23.1778512293483; 
 Mon, 11 May 2026 08:11:33 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00267b069c8b2d0c7b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:267b:69c:8b2d:c7b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6813sm65766925e9.6.2026.05.11.08.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:11:33 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v7 0/8] hw/nvme: add basic live migration support
Date: Mon, 11 May 2026 17:11:23 +0200
Message-ID: <20260511151131.483217-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x430.google.com
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
https://github.com/mihalicyn/qemu/commits/nvme-live-migration

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

 hw/nvme/ctrl.c                                | 1007 ++++++++++++++++-
 hw/nvme/ns.c                                  |  160 +++
 hw/nvme/nvme.h                                |   12 +
 hw/nvme/trace-events                          |   10 +
 include/block/nvme.h                          |   12 +
 tests/functional/migration.py                 |   22 +-
 tests/functional/x86_64/meson.build           |    1 +
 .../functional/x86_64/test_nvme_migration.py  |  159 +++
 tests/qtest/nvme-test.c                       |  395 +++++++
 9 files changed, 1742 insertions(+), 36 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

-- 
2.47.3


