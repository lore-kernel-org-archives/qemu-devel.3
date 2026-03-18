Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7BF103E183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2rfs-0006od-EJ; Wed, 18 Mar 2026 10:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rfo-0006nz-D3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:15:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w2rfm-0005lQ-1q
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 10:14:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82a7539851fso200329b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 07:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773843296; x=1774448096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jZORAx5okj97F1LsSgHyM9lahihlA6VdW3AFu49zcYg=;
 b=KWER8YPtYjOfdbcdELsxZgxfsKsW0GAZgZLb8t7tw71zRoCE536SnRFEN5qXBR2zWS
 ar2UhnbYLMH2UGh/qVVfbnag8baR0pJ5oOBIwMLc6wRKQYMh+GtxdDXE45RQfsN9qZI4
 po+E/lilcjxX0b8zu1Hu6sziaUL0ywUifp3XgfqwrrrTfYdx1eKCwTNTrvdxKddxIaYU
 wipq74LelASGbUgLb5MRv5C5Crs4+yzlFvy4ktIf5UIoCmmhQh/ka/NSihvIuXpunpSY
 tEfJ+2q92+b5SnCUJ4TGFE+OhbaUhGFOiPvwhbM/j7VtPETqSRvbnnIMTdx/+jr0gUly
 Bm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843296; x=1774448096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZORAx5okj97F1LsSgHyM9lahihlA6VdW3AFu49zcYg=;
 b=DY3WdKrmTjsBHP6AKC5sJFQVNZMFV1X/rRInuf/QMC6+OGBUyQ0YAYiaxBjD3CLoqa
 MtsKEmbhiS4p7YsHvoTfX+uP4Xt453PLufYSrsS5iWs+3Tru8apI7NkwWWqavRssNFmy
 p55yuevbIzvXKUWMEgfq3TYE7cXsEl2+Vx2ZOTaRYeGmz3cdkpj4HXvSGUGM6A42Iac9
 1WHtlVCQqwP2NsgqNlOyPGNEbh0itW+aDfkhCw6B70q+AhkwVkhIdOLW/sHr9JDCjdSf
 gtD/12gUbwLQMwELOD2z/ME47r8XXzgsf41CVC2c+H7n9yyccEWSdDtWF9WNgtLGtGop
 YKpQ==
X-Gm-Message-State: AOJu0YzjSsIrqwSKEEVm65IKeTFqfoZVFbgdqIo8zhZHoawKAfglHnUW
 Ayby+jWIEeT/lTq7eytEhgdtxEuY2SZB2UJy4fP69+5ATOFUIq5ZaSzN2cLQsCTV
X-Gm-Gg: ATEYQzyfCeByxYoF59CKHnm1/uQxQ5VPVj9qoKcJpi5DVwhNi6QA/PHxgVi7MceSLgy
 vdnnO1EascePHZQSmbN01xbYZUu9Y6rJyU2TRCbOMx2BlS/ZQX6NSuAd3lCJ5k30ZmbPT1Edh9V
 65mRlF3xFe1FyFPIAX83tNfpY/0GWJ7JCandZ7WqBV5OKK34EVseVkatLL9Dxq/KHv2RRM69674
 07tCvCxSe3N/ZlnYGgyfyuT0mEdfAMqFVdYNH8oKGEDwiTUvjG2sLCN02gUg7xB36p/V/6CU0tD
 HIzi6xv2TGtYfjLVFQbPU1BiEd/HZsGY/MejZTfLTQx4RoIC3JAH+nQsBUCJoa/CkGcgJsQZP/k
 ofpsIbhyOLkDOrHzkBHVUvJgg0C5/jP27U71zbJMPiURkvTAkcHGkbT3UfQROLOXWrqS/uetYNk
 MWj7HSRH8oJiCVEnVxVJj4OObQ/ht7lJtClVOxySx0xCtI5xWJXcGRCAIfuG0NAxHvbjnVeq6yn
 klcCgD4BQ==
X-Received: by 2002:a05:6a21:50a:b0:398:9379:d052 with SMTP id
 adf61e73a8af0-39b99ed66c2mr3383972637.30.1773843296070; 
 Wed, 18 Mar 2026 07:14:56 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local
 ([27.122.242.65]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6af06bd7sm2927272b3a.0.2026.03.18.07.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:14:55 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [PATCH v3 0/4] Fix error handling for callers of load_image_targphys,
 get_image_size, event_notifier_init, msix_init
Date: Wed, 18 Mar 2026 23:14:09 +0900
Message-ID: <20260318141415.8538-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
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

Changes in v3:
- Patch 1: For next-cube, use a local Error* instead of &error_fatal
so that load failures are reported only when !qtest_enabled(),
matching the existing guard. Distinguishes "file not found" (error
set) from "file too short" (no error, size < 8) in next-cube.
(pointed out by Peter Maydell)
- Patch 2: Drop leon3.c change: warning is meaningless for baremetal
programs where no BIOS is expected, and error handling already
exists downstream. (pointed out by Clément Chigot)
- Patch 3: No code changes. Add Reviewed-by tags.
- Patch 4: Replace error_propagate() with conditional errp passing:
(s->msix == ON_OFF_AUTO_ON ? errp : NULL), avoiding the need for
a local error variable. (pointed out by Akihiko Odaki)

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413

Trieu Huynh (4):
  hw/core/loader: fix error handling for load_image_targphys callers
  hw/core/loader: fix error handling for get_image_size callers
  util/event_notifier: fix error handling for event_notifier_init
    callers
  hw/pci/msix: fix error handling for msix_init callers

 hw/alpha/dp264.c       |  2 +-
 hw/hppa/machine.c      |  2 +-
 hw/hyperv/hyperv.c     |  4 ++--
 hw/hyperv/vmbus.c      |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c |  2 ++
 hw/m68k/next-cube.c    | 11 +++++++++--
 hw/m68k/q800.c         |  2 +-
 hw/m68k/virt.c         |  2 +-
 hw/microblaze/boot.c   |  3 ++-
 hw/net/igbvf.c         |  2 +-
 hw/net/rocker/rocker.c |  2 +-
 hw/pci/msix.c          |  2 +-
 hw/remote/proxy.c      | 15 +++++++++++++--
 hw/scsi/megasas.c      | 16 +++++++++++-----
 hw/usb/hcd-xhci-pci.c  | 16 +++++++++++-----
 hw/vfio/ap.c           |  2 +-
 hw/vfio/ccw.c          |  2 +-
 hw/vfio/pci-quirks.c   |  2 +-
 hw/vfio/pci.c          |  2 +-
 hw/virtio/vhost-vdpa.c |  4 ++--
 20 files changed, 65 insertions(+), 32 deletions(-)

-- 
2.43.0


