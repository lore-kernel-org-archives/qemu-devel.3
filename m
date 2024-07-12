Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFB1C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 02:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS69n-0003kg-Ox; Thu, 11 Jul 2024 22:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sS69l-0003j5-2z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:37:09 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sS69h-0003NG-Qc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 22:37:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c7fa0c9a8cso1193437a91.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720751819; x=1721356619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rNpOtwK0UU4PEbqjAfiyHWLImhvCa4nJA6412cLt5vk=;
 b=XfbMdl9dpvMGLSBfZExloroBsThc3kG1YQnpQ9Zm7loVoVQBLEpB/MK3+Jv22nEHz7
 Cioff+sll046fpHtY5Fk8iFbAIUzAm9ogLTAQ9LwsbwXVwJp5jVZTeB++z8lEreREekS
 CgvVujVHiOrzoj2PhTF2CuWkILXpuz5G8VwwKaMydMVDS1l1LI3jnnnvTDLKxB8mNlUj
 EbgodSZy3C6jK4DB48GyFUqhgfbvsSqVkgNSGGpVHxtuuass0C3I/moQWn0PLJFLwMx7
 6Lh2rFxFxlLl5JoXnsojjuj/ze76/rnIDRAQb/YYdqBCSl77TkmrJYWGubwwGv5+s4EY
 kndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720751819; x=1721356619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rNpOtwK0UU4PEbqjAfiyHWLImhvCa4nJA6412cLt5vk=;
 b=PyOmPgjFVZgpFDcvgzSJ8JbCeql/Cl5/fyi64TARioviDcHA0hoohW4XH/X/SluOKF
 jnZpGZbW4FNXuMZD1cLdMkQtPb4X2PsIKVlGaBKI8JGhnmSw6uktFktselhe42vhp44E
 Dca/0WSTFEBx0QEQGbyCD4G76YtQvUx+gpNsd93KJIyRX+iMsJ+Ewk2zc7hZKvT9rZ21
 K0vJ0DRBfqzxsPrRrgMA69MYzSMmLmUlCQrUqA+3qYZ7NeDFvEwogmaPUfgLy32cZcoz
 7X2LWfoPrSM8jdJKdUlKmSlKzqAp1U+LMcIgmW4nHrF6PdqV5ttM1KdnK6XQGn5Enwr/
 gLqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwUld1kYbUseok6zxmvpJPPeT1J7YLvD7SKDBf95/Mbz22+m+p6zbwRV89FyyK/tDlYDjhfKv5Zi8yKZ00eRFbL1mWYCs=
X-Gm-Message-State: AOJu0YxWUnN4y4oBotpOzzClLBJSO639g9kh+H7Ys/OsJ8vMkw+8GtEk
 e03UIEDF9AdGArU9qWviM+9A8EvwF1B46v7ZBaWhc9BBFfDWYR4lnVRrF+93vjE=
X-Google-Smtp-Source: AGHT+IFBhPh8VMmeqBBk7Ue4w9F0c2+9nNzqkWqOmzhI0pVX5rJyxRXhtxYsUMu4VBK52yUfi9eifA==
X-Received: by 2002:a17:90b:4b48:b0:2c9:9424:b361 with SMTP id
 98e67ed59e1d1-2ca35d53a3dmr7524044a91.45.1720751819495; 
 Thu, 11 Jul 2024 19:36:59 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd65fc43sm297453a91.39.2024.07.11.19.36.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jul 2024 19:36:59 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v9 00/10] Support persistent reservation operations
Date: Fri, 12 Jul 2024 10:36:40 +0800
Message-Id: <20240712023650.45626-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1030.google.com
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

Patch v9 has been modified, thanks to Stefan for the code review.

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
 hw/nvme/ctrl.c                    | 321 ++++++++++++++++++++++-
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
 16 files changed, 2235 insertions(+), 2 deletions(-)

-- 
2.20.1


