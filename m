Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E61BCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq2C-0007qi-3D; Tue, 26 May 2026 07:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq25-0007pE-Jo
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq1z-0001x0-Q9
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so40834715e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1779795184; x=1780399984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yRWJ/0HNeJ1cF7QvGHBrS1Xv00TBpOu6uW5gyP0AJZE=;
 b=bXtcO59s6gfEVHWg6KFOHGE2R/hIGA/eCKZ/uR/zRvIP61XeeU5H7PpNA95ZRYQDF2
 Qui7lDeH+fC+rW2F1KXLd/K6mRbdvxOHxug51eTe3cnB9/kpWMa1qr7rQACTx4NyAJgP
 0mLqR2EMX9YSHnJZ2L17LFgpCl8zCxafLsVoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795184; x=1780399984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRWJ/0HNeJ1cF7QvGHBrS1Xv00TBpOu6uW5gyP0AJZE=;
 b=skU9MPG9nQJg4QJsoPjnLmYziKMoAvlth1+4k1IIdVsmMNDZ+4NLAgNxHWqIEhwlEk
 RwnGNOseNei8PZn91BkMA9na3CehXnssWHT8MPpZgIoK4ta4Qszva7wqUhFOI3tnmNVB
 nY7DwZnz2jILsuLzkF9cD8byJJw0fQRBGta+aIfrHvsib8KwxVGHlVy6OjTntlUHr721
 G8xJbGshk7CS+hysFeO5vTRqQ1Kp96BnAi2avxxTUnh7klWy1mxqNZZr1o+a8jE+DU2I
 kmOtDxNOVNvDRyflb8P6cmuJKHto1y1vbsrN0o9TKmriXUdhLXODT4P4nZdY4Riin1Xt
 749g==
X-Gm-Message-State: AOJu0YzDQkKzlWVtFv9Moav4Mr94caWsitXT11cvPiZCSCzOlLtbaRRJ
 t2DsJiBkz9xBx/3Y/Vp2MKIxxxqoQWz3bYTpApfaLAvRRjnK5qZkQkMm3uoJwAT6mtsQ6Mxb2e4
 Z46uRJmQ=
X-Gm-Gg: Acq92OH1E4qClIs2RAo0OaWVcKFWMzjr3QVEV4mE80nKmWfziif0EofjIi9z9YwETOl
 uA/oargMULiIxHb6rg6jfnWBt7jyXIlDDZ3mCLCTAXYNRuA3e2wPYV1yjzD844jlZJg8rapzBNT
 bzAf4L/28KpTH/jAfjHTfoJTHbE6BP991alD5sLPonxefZYx+mu4rCKlswkVX32yrlW3P9sr/7o
 0B8tYyBtlswMStZytK8k8DxwOAHaw29l6x75RwpdGYO7bLl7oaHzhX2YcJeyG8litK2ETZBRJl5
 CzDXFvl4E4PbqIb4JRtEI+IWLIivM+rlQQVQc1whEpFitcosY8414PZ/qDlFMjMuapjb5y3qdSt
 9wbOU33TkHRHAjW8N+V4db37aipJkDHR8RIKgmlQPgKdG09vnBKT72Chaqi67ipnwPe22urAdl5
 S5Lefo2jQM8FCIIGopQmMXvC3Ww/HS41ElhJG5c4R+9p2DPVqTlnjh/FglctHph+IvqsHDdZmiR
 qvzj1l+sJZE+BmOvkvLNQBusw2l2d8Cww==
X-Received: by 2002:a05:600c:a402:b0:48e:6db3:ff3a with SMTP id
 5b1f17b1804b1-490426d079cmr212530135e9.16.1779795183485; 
 Tue, 26 May 2026 04:33:03 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00840292fb31d0d80a.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:8402:92fb:31d0:d80a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm34366870f8f.18.2026.05.26.04.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:33:02 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v8 0/8] hw/nvme: add basic live migration support
Date: Tue, 26 May 2026 13:32:53 +0200
Message-ID: <20260526113301.91492-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x332.google.com
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


