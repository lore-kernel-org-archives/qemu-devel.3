Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CECDC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7uGd-00027N-6X; Fri, 17 May 2024 05:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGY-00021c-Nh
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:43 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s7uGT-0006Fi-BA
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:52:42 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so870782a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715939548; x=1716544348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T1atyWPenvlDUxOBVQydBb4pOFloZbUFyUwcdAJycps=;
 b=jau+APhH2EjrBrNNNIyzDM1GXOrXUp0+d2Cp2FcuF+HYkpf6+rPjKJu/P8P0cR+5xq
 t95aLYMV7TB7oDLuv2ZUP9gJKS4v/4CSTdayrxguhYd7mYgfuRZuxSCDR9Ykk8WBQMdO
 1FHGc4DMEsu1rZHmG5Ec5U02RLPBDNsvuyk0kukXS/Rw9oDtr425h2xJwMeC0vz/ld+W
 b1ZkBeKvuY5SthD+jwDYgMFKXZwbnVSnIx3Ugo33oK+0I+1+xyVWvicH0K7DQNPuBaPS
 6s/Zo970GQl1BeGJSjAhJnbz8KpDY8tGUk4s7ldN3HvoLe/6pY4qJJDVP150rJdRqUkR
 4/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715939548; x=1716544348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T1atyWPenvlDUxOBVQydBb4pOFloZbUFyUwcdAJycps=;
 b=YQNq0bRSsCaLU4W14yamKC+DRk3Vd/t2IJsZsGXaXccClG0LW1M6RekqGW8uCQDgHQ
 73JAlE3Gc5njOJfALoUqRdl2hxyP3gLdELxTMlSMaXazMa64VEdNnwEIJHBbRtLxGJFc
 SOAY3VZx6+G5rCoZB7wXe7PENerkeASWdi8gfaCY0FjRQirIMXHRj+6vW0sIuilb5J/Q
 fjO3gf9a+QX20LQGPW0ACDjf+kl+zV1em67bJpl+SY7CH5nBheuXQ96ue8KFfY+Wop50
 ZHCr/GsBZQHagK4zJ7Lkidny5XC42txuN6g6niQvHrt0CF2eeyTsmxW/n2G0jw+GkCdW
 MdVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6jo+vwTU9epN//0rzmEJ2vNPMZtqkCc1yD6LaL71g9b/e5MFOr4c6nx+7i8So3qfa/SgmvEFxDsjU59ejl2PRquL7kM0=
X-Gm-Message-State: AOJu0YyEwUCnrYzGAxAheITiK2xuYoUqehA/pbsBL+Z4e9mWt5LzN0+B
 hFHvCz14HigkHD7fdUlcf0N8xD572DRkNB8o/aqDzO3KZL9m9qzrmUCV7hEc9NM=
X-Google-Smtp-Source: AGHT+IFx+JfLJXXrxor2syJFW5WdAhLF/7nAis5RnffH0SR17WUSSIwJYHQVk+kBzNY0NX1gNioNww==
X-Received: by 2002:a17:90a:7e10:b0:2b3:390c:e3f0 with SMTP id
 98e67ed59e1d1-2b6c75dbe8fmr28692698a91.16.1715939548065; 
 Fri, 17 May 2024 02:52:28 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ca53cesm16975992a91.44.2024.05.17.02.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 02:52:27 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v3 00/11] Support persistent reservation operations
Date: Fri, 17 May 2024 17:52:07 +0800
Message-Id: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x536.google.com
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

Please ignore the v2 series. Please review the v3 series instead.
Thanks!

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
- Add scsi driver at the driver layer to verify the functions.
Changqi Lu (11):
  block: add persistent reservation in/out api
  block/raw: add persistent reservation in/out driver
  scsi/constant: add persistent reservation in/out protocol constants
  scsi/util: add helper functions for persistent reservation types
    conversion
  hw/scsi: add persistent reservation in/out api for scsi device
  block/nvme: add reservation command protocol constants
  hw/nvme: add helper functions for converting reservation types
  hw/nvme: enable ONCS reservations
  hw/nvme: enable namespace rescap function
  hw/nvme: add reservation protocal command
  block/iscsi: add persistent reservation in/out driver

 block/block-backend.c             | 397 ++++++++++++++++++++++++++
 block/io.c                        | 163 +++++++++++
 block/iscsi.c                     | 443 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 324 +++++++++++++++++++++-
 hw/nvme/ns.c                      |   8 +
 hw/nvme/nvme.h                    |  44 +++
 hw/scsi/scsi-disk.c               | 352 ++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              |  99 +++++++
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2193 insertions(+), 2 deletions(-)

-- 
2.20.1


