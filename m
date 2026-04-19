Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A766EEA7199
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wERn7-00011Y-CJ; Sun, 19 Apr 2026 09:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmf-0000tq-08
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:02:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmX-0008IM-St
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:01:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so30345725e9.2
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776603702; x=1777208502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fk349AO3pKfAG0FFpQJLVXFefEF3d09SJA53kGdnCyw=;
 b=EAEaGz3zfAWja6i9mY23DsJ7forbv6rFi1mugV2BpXTZAA+TXpK7avmK6y8TMSAFfB
 YZVNtAKCus++7K3QwOQOcl2W3ZSCQyyH1VpGnAmRZT92WkL5nH8J/lAwtLcbkoUC4uLk
 J344WB1VMXOZdR+YHms8RU+u0uPQDfPCvh5xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776603702; x=1777208502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk349AO3pKfAG0FFpQJLVXFefEF3d09SJA53kGdnCyw=;
 b=BMk69/FyWhqDJ1tyxav3Jbf3PQJMTHj/YxwCmEPCsj+/NfCOYi+bi+pgNynqd1p9B3
 UFf0l7oaC9MY5so/soMPou1o+lTT1957cOrkkMf981Q4+GhXzqKRDhjte64jxM78bkKa
 iDwblG7vWr+7jr/wFIjEbdN4CLD0MTo0FhqslY0fzQ4c161E5xhdioYxbaTIhwFlJNpQ
 YvSb8GkuLq3LQLDJLnafAM6i0i+MyZIMnJhWwjctPYcpQ7K5RviGJIf1K2tS1f3VUSYO
 bcrR3dc5mzR4iuiIpmn2ohPTfsFjFjslZm4BsXQJPv0Z4vQyZbleybACj2QQ1kCg1us2
 2Tcg==
X-Gm-Message-State: AOJu0YzGqefHI7NAH4lZBkZsD5G0iDpXl8whcjBIMhHIyqmxXiHlyWEM
 QUdQ/et4qWdIDZl3e+s6QylN+trqRq/TyNnssaBtEQiPILUGWvrHmXHIwg5UMAyyORNP/54QC4C
 9ox6Qe2I=
X-Gm-Gg: AeBDiesA0bapiam+viy0N+h6bHZCwQgq0WJ5u159ahSZun4WpWpIsyzVBIXmR2guwQQ
 /9XCHZL8xfLqSZz7apQEWcUJHF+DyqFU5vDuNsonaEHfDRFNnLj6YK6q+BJ/YA6uZUXrFAmhhw6
 YtZm8ve5+4FQZoIVzFYXh7/vHga+0r/rPfJOm9yIVmbU69lYL4TA2eDuhLTHCjz1oZgxGnlQ+pl
 IAdr78hPiv6Ib1dninTzTY2sXtqRZ6H4VaiR73dCnLq5dA2V8F4AGHcwecG9TPUPBN9/M51Vz4r
 0oUgvx5TiQfGYv40XUdoVQ3hlmeouh/HgFp5jT+LzIVev/1NLekhoTxRR/AkYHThNo17XTL8CD6
 9rZJaXokczB347bIFl23KEOFtdyvf9Qid0BvP8nWmnlAWJUjVSTKEfOx9ql78kESe3OfTZt1nZu
 9PSM3P29FnlAslq24ns5AXlBn9055SlHq9AzoNGl/JkqUZX3h7grcw4SG/oW4tEwQm30R8kSu6l
 Lmq8pv4B6gllbK86iXsaUJiR/DD8yTeoA==
X-Received: by 2002:a05:600c:4ec8:b0:485:7f02:afd5 with SMTP id
 5b1f17b1804b1-488fb755caamr145885785e9.13.1776603701710; 
 Sun, 19 Apr 2026 06:01:41 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00995e4e0d3496e07b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:995e:4e0d:3496:e07b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm20734304f8f.13.2026.04.19.06.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 06:01:41 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v6 0/8] hw/nvme: add basic live migration support
Date: Sun, 19 Apr 2026 15:01:31 +0200
Message-ID: <20260419130139.15554-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
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

 hw/nvme/ctrl.c                                | 992 +++++++++++++++++-
 hw/nvme/ns.c                                  | 160 +++
 hw/nvme/nvme.h                                |  12 +
 hw/nvme/trace-events                          |  10 +
 include/block/nvme.h                          |  12 +
 tests/functional/migration.py                 |  22 +-
 tests/functional/x86_64/meson.build           |   1 +
 .../functional/x86_64/test_nvme_migration.py  | 159 +++
 tests/qtest/nvme-test.c                       | 393 +++++++
 9 files changed, 1725 insertions(+), 36 deletions(-)
 create mode 100755 tests/functional/x86_64/test_nvme_migration.py

-- 
2.47.3


