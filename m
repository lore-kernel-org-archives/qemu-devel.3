Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85095C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 03:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCt3D-0007Lz-2w; Thu, 30 May 2024 23:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt3A-0007LN-Jn
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:35:28 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt38-0002ut-0m
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:35:28 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-6c1a359ee2bso450538a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 20:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717126519; x=1717731319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ror6EuFlXyEsRDuhpd/4z+RSzTVwhxZ92e3454klac=;
 b=htWrU8LxSL9mEvATBFKrsZJazRpHFNLhXe82T3YCsVa7IYs2Fv+PQiCCKGOHqIIXmh
 ZRxEz3HcZILpHYcAUzwm9ucNz9kMMpc6p2F8PJhLf8fWOpc0V3V/v9hwoFldqywbUm6V
 pl5oG8fj7Lo9cO5BXqDJ6NfzQvwmJHoORBa1U7oEcPSfkVUIe1x1nkuKwVlFk0qht8v0
 dxviYn/xYLCENl1C2Dn9TwhZQ6oDfXIzD10g6YVtKdr2Y3Pe7LsMJhjl0uIGBwLGRITF
 5Z6UnPulvW0h9MZbNnSUBES80cUU/5RW4p8w00DEsAuClwMqntR9qB7nwt4ylpOogrSH
 /JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717126519; x=1717731319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ror6EuFlXyEsRDuhpd/4z+RSzTVwhxZ92e3454klac=;
 b=Q6MJPdqGAmO4gMSIIseMHtkidCUFbjVWc0XLsFZw+MA4bQtnw7M3c9Tf7+sdnBf2ir
 MURzxln1i8/HOHKIcDpDc/47+Z4aRqkn7Wd+v9r6YKhXfTY/64scLiIRpvx+iUzkiomr
 PHV9IF5N9Y1T3GS0KLwSmvLQb4v4bjlQv+N5iaP83DuMqH7dRpO47MRCs+X2anyh5bhW
 4Bx1p8H+rgZy+PJ1yamMhEX/I71p56Zu0aCsVvvSXhMxeUMASk9yQ5FOT+vyiC08sTHG
 pDEGLDTy9pB+0Ag0zzPeA0H0/MsrX4S8ykEyTL3Gp9s0VwySddIxUzeXC66khOo2Yuce
 PVGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv50Cj8m3477YKtDPTvVb33THR+1cSovYRuXL70tn4GmJ1CskLmO5eEQzNeGKFTPAj9s3dH4kZBQHo08VNyCC7DQRmPyU=
X-Gm-Message-State: AOJu0YzL74VnMdgmvHxeevzyP/v7fki5d7cPom7CnjLEWAZuBF3LkWBp
 3TRQt3cbySSb4nWMedDGFwJ9qWYAthbZ2fyw1Q5eu3wbe1i4HoWYnaULCl5rRIk=
X-Google-Smtp-Source: AGHT+IFxcIKltWU27svvVwuCfKlAUKa9zVisNSKObSJODdrc5Wgtyr/dpxPJMf0dhTy5C8MyKIIKJQ==
X-Received: by 2002:a05:6a21:6d8a:b0:1af:d07a:37c8 with SMTP id
 adf61e73a8af0-1b26f22b0e3mr998303637.37.1717126519269; 
 Thu, 30 May 2024 20:35:19 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a777e989sm2457629a91.29.2024.05.30.20.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 20:35:18 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v4 00/10] Support persistent reservation operations
Date: Fri, 31 May 2024 11:34:45 +0800
Message-Id: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x532.google.com
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

Patch v4 has been modified. Many thanks to Klaus for the
code review.

Could anyone please review the core block layer and
SCSI layer related codes?

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
 hw/nvme/ctrl.c                    | 324 +++++++++++++++++++++-
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
 16 files changed, 2229 insertions(+), 2 deletions(-)

-- 
2.20.1


