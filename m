Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F7FC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCAy-00058m-Q7; Thu, 06 Jun 2024 08:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCAx-00058W-GL
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sFCAu-0007Jg-5M
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:25:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f47f07acd3so8804755ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717676696; x=1718281496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1WI9oZjzlFDgNVZ6UoZmzwJK60bDnx3N8O7PgEvKg7U=;
 b=hBTRl/vsdm0PBRRpL79ReQUs8ZI+qKFUjJVLGhV0GlQ9Pv5k35BY/QiTIGiBfLJA7E
 mLn8smtw4KXZW82V7QjE7GNaO05rKat1H96zgt9i7qm8REcSWs4ZpSq1XJKH22wSge5d
 fVTXTEj+DplIqMS89TlbQBPx4LDorVqGMFONpYUKfvKD5mA3U99LufF88/KbNGkjNSly
 nI+MO28FGsWbw1gAKfcw2KWKcjM9VYOKO5Y22t7rGm8pnseq1viV6MSxsWp/ZZMKysn6
 kElvf4ruV+qrMqCaqR/Gr5H69UPohJpIaqwMoQnvvEM4hNOrlmvHSEscqW67cD+v0xtc
 G46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676696; x=1718281496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1WI9oZjzlFDgNVZ6UoZmzwJK60bDnx3N8O7PgEvKg7U=;
 b=Cgxf+wBcCfR1gLnnfbbFNqlYiqxW0oqDshAPfpT2ZUFbq8eRNQI4d/5zx87l3iT205
 H7CO1BzQteV1fBR+/T2/hkVZMNAtBt6+W8afLdUtntfx7nxRvBy1lK3TPZI7ZJP4L+q8
 8yNzWtxp0t4I/FgJiobagZcTQ7Ib3o3IL7FVmPJBdEbdpfzicwIxF07DCBLeCSQitJwd
 F1GYpOzfy4KHb5C4M3AiCrwU7NzVO44D8U1s4+XMF/nUlNN3ev7AwiyhQtttJZ8iubeh
 faVYs/AbRwVwrRUJrUxtdsHL749inlWaNqW8DQOaa9jhdfn8SIwuRp51BQcHSxjXe5dX
 pRNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Lof2R5Z1mlPoP6k8d0518czUENEtK881KyP63FoDYdT7p/4v2g+/3mAwD5hBGlVhosVc5t4WZjZFaX2z/+Z3TPnFIQY=
X-Gm-Message-State: AOJu0YxsawKamdvUguwGdy/xgheFFqfAhFLHn87sUPuOK0C0erC2hQP1
 7zuTyIkKFcCjc8ShJRYuhvec9EPTCdfe53q7xCHuh43pxSBISYNs0mrV89cXX4dRilQe6CND/Ta
 /
X-Google-Smtp-Source: AGHT+IHsBzcUwypjBM4P+MZK8xt+H+i/iyKQP3W7hOWKigSi+YwSJ68/bjs/tT9yR8fMlhCE/PxmmA==
X-Received: by 2002:a17:90a:6447:b0:2c2:4114:fe48 with SMTP id
 98e67ed59e1d1-2c27db1f93amr5837243a91.23.1717676695954; 
 Thu, 06 Jun 2024 05:24:55 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c20d7adsm1459396a91.9.2024.06.06.05.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:24:55 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v5 00/10] Support persistent reservation operations
Date: Thu,  6 Jun 2024 20:24:34 +0800
Message-Id: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

patchv5 has been modified. 

Sincerely hope that everyone can help review the
code and provide some suggestions.

v4->v5:
- Fixed a memory leak bug at hw/nvme/ctrl.c.

v3->v4:
- At the nvme layer, the two patches of enabling the ONCS
  function and enabling rescap are combined into one.
- At the nvme layer, add helper functions for pr capacity
  conversion between the block layer and the nvme layer.

v2->v3:
In v2 Persist Through Power Loss(PTPL) is enable default.
In v3 PTPL is supported, which is passed as a parameter.

v1->v2:
- Add sg_persist --report-capabilities for SCSI protocol and enable
  oncs and rescap for NVMe protocol.
- Add persistent reservation capabilities constants and helper functions for
  SCSI and NVMe protocol.
- Add comments for necessary APIs.

v1:
- Add seven APIs about persistent reservation command for block layer.
  These APIs including reading keys, reading reservations, registering,
  reserving, releasing, clearing and preempting.
- Add the necessary pr-related operation APIs for both the
  SCSI protocol and NVMe protocol at the device layer.
- Add scsi driver at the driver layer to verify the functions


Changqi Lu (10):
  block: add persistent reservation in/out api
  block/raw: add persistent reservation in/out driver
  scsi/constant: add persistent reservation in/out protocol constants
  scsi/util: add helper functions for persistent reservation types
    conversion
  hw/scsi: add persistent reservation in/out api for scsi device
  block/nvme: add reservation command protocol constants
  hw/nvme: add helper functions for converting reservation types
  hw/nvme: enable ONCS and rescap function
  hw/nvme: add reservation protocal command
  block/iscsi: add persistent reservation in/out driver

 block/block-backend.c             | 397 ++++++++++++++++++++++++++
 block/io.c                        | 163 +++++++++++
 block/iscsi.c                     | 443 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 326 +++++++++++++++++++++-
 hw/nvme/ns.c                      |   5 +
 hw/nvme/nvme.h                    |  84 ++++++
 hw/scsi/scsi-disk.c               | 352 ++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              |  98 +++++++
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2231 insertions(+), 2 deletions(-)

-- 
2.20.1


