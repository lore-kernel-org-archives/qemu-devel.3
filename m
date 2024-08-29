Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986D5C8300F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 08:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjajp-0005K7-EA; Thu, 29 Aug 2024 04:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjajn-0005Iy-L6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:39 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjajl-0000A2-GC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:39 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d3bc043e81so309234a91.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 01:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724920953; x=1725525753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9pujDbo0lkszsHv41sSuVtbF7Up1CXVHOfpXCOvwjn4=;
 b=GLNp6Bzl/A09l0Sg7tfQqPciZhEtDX+FzAQ4gAvkJoSGt5ftxCAV32M3YlJg1/S54h
 kymn5/zEal4ViCGLZH9g4HyBUSTn4zbE36e+68pMXTIkI17+1zFRE1cuRMpKS9eNkKfT
 GA8YAl4ejSREJksYTTGGoh8TGUtbRaPrfV6awn1S2WKNf8xohzlpM5FIivgystJE/1eR
 PHuaQ7vAgnKgB4TB6gQ8zIJ2xL5gr2c0UsWaWyBLaxBtPYuhIplvDtBo9JnsAweLpRho
 fi2CYNmmEO2m3YDkSxG1C7alZ0xggMa/77RFw8++0G0Qb9U8Y8cEFTvhMAeMyRS5dvX1
 H1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724920953; x=1725525753;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9pujDbo0lkszsHv41sSuVtbF7Up1CXVHOfpXCOvwjn4=;
 b=VEIEP96f4Ga1jbl5doBpyzvup/UJc1dqmCshsPFdSE1fEtMJiOlqPpbChr6ecEpanD
 +lJxN+zfECHDSXdmqIoKNhOfrMrZysCmwhMsO3ksnZX6zDGzuMfHJcfM5XRfX3Tytq5z
 v1z9icPWzKMfWg6JRlTOI0pIjYSLYQQ6qKHaE9xFGjVhNMSwqNZU8LPMva6dT8FKdRy7
 zGtI55ruIiDEjO/UalBZO+BMGQSWPCrBInoEzPr/mN5OCrRBoilw0UEV2hCIyP5ySfj4
 tbMBCBGR1fp+qCuSpT7Uij43SZLOQdhdquJnAz30OFDh9sbrYATvJhf4lKSOOCICDsls
 GWvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0WaiLmEIATAfINk4kLe7NINhyN/vVTVEC8BSo/oeY1o0hJXc+iE3zYneLuXpt+HLNgQK3Cf78Q6v5@nongnu.org
X-Gm-Message-State: AOJu0YyzxMFmRsVWWCwFfB2w/qPpd+G4nUpxYf0T8xT4Xsi2cmEG2uzy
 VH3/oE10jhXt3YWr7pbYNO6LY/cXNtXp22oJYjI8Gv5vfd7QBh2gg+0Zy9ecU4ex1F1MA3bAJec
 o
X-Google-Smtp-Source: AGHT+IHt1dHqFB3lpvL1SuNyB6mjN7H6BO+C9MeKcHk2Ph6YNdvxOvZxYhbZ5nju2nG0/vNxeiypIQ==
X-Received: by 2002:a17:90a:8409:b0:2d3:d4ca:62f6 with SMTP id
 98e67ed59e1d1-2d8564b3cf2mr1963586a91.42.1724920953231; 
 Thu, 29 Aug 2024 01:42:33 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3897sm3431856a91.49.2024.08.29.01.42.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Aug 2024 01:42:32 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v10 00/10] Support persistent reservation operations
Date: Thu, 29 Aug 2024 16:42:04 +0800
Message-Id: <20240829084214.50548-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Patch v10 has been modified, thanks to Klaus for the code review.

v9->v10:
- When the driver does not support the pr operation, the error
  code returned by nvme changes to Invalid Command Opcode.

v8->v9:
- Fix double-free and remove persistent reservation operations at nvme_is_write().

v7->v8:
- Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
- Fix buf memory leak at iscsi driver.

v6->v7:
- Add buferlen size check at SCSI layer.
- Add pr_cap calculation in bdrv_merge_limits() function at block layer,
  so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
  changed to bs->bl.pr_cap.
- Fix memory leak at iscsi driver, and some other spelling errors.

v5->v6:
- Add relevant comments in the io layer.

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

 block/block-backend.c             | 403 ++++++++++++++++++++++++++++
 block/io.c                        | 164 ++++++++++++
 block/iscsi.c                     | 423 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 333 ++++++++++++++++++++++-
 hw/nvme/ns.c                      |   5 +
 hw/nvme/nvme.h                    |  88 +++++++
 hw/scsi/scsi-disk.c               | 368 ++++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 100 ++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2247 insertions(+), 2 deletions(-)

-- 
2.20.1


