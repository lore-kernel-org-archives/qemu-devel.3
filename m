Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20FBC3601B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza2a-0002CV-BG; Tue, 01 Apr 2025 07:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2X-00029w-UA
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:22 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2W-0003g8-3i
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:21 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22403cbb47fso112603005ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743507858; x=1744112658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iiqMLQDqNdYF3NLpp4fJvMQ29Jg+v2cfv8TSKQO8xA8=;
 b=RM0k/xCmWCVwgdh08QkTY1JXtVUlMWCf4n/GWUxy9o3xm406KQ3FyC8fTHfhNcqD0y
 Xq6KFGBeicpuAF/oewV91RaSty884TEg9CRUR6rR8EU8pRFoqmF4jxTc/3lPZggObbJW
 eZsIJnraJqYvJagDe9AEqEmFP5pmUw+PQ3QkxYci2BrjsAa5PbdmLuDAugWw0s8FzvKk
 9r9wNZhJWjNHCmdQzfypli/D/uEFXTc6HIYxYXoelNrxh6x53Jlot91xZERXrHsCYSKz
 It3KLoGNUGImnb7p63KUlz0rBusVV85TVHHsIpr79sQC2ynZ7yOiC8eBJwQDh/NsmwUd
 xrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507858; x=1744112658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iiqMLQDqNdYF3NLpp4fJvMQ29Jg+v2cfv8TSKQO8xA8=;
 b=aL8nxzSyPBpv0US3Fr6UskqjdGG5Bz+y8sKYda3K6E3DQ43Kp26yPXVrVIBygEY4c9
 BNKCYAOET5zTp65dM7av1kjASYUVWcs9I15YOHuhvc+M44cUN34CyaaMsnjKncUWQKrP
 3Hu2cXdr5dbQWrfWi2HZQfrx/hO5pI22B+QVHeMKHPqDhGt86+IuzgesfJAv8m3AUoiR
 XpAgHKNuBe3NWA41cMNcXYzSN2whp9R4aa1atmU9xE13Khe/R6qhAg5Q3TsvmQDsT2lQ
 h8RvV6NtOzt7WprJsza6f8beZ5NwmCsupQPcUSfchYp9zG58OCSj7vdMg6JKNRlAvKRu
 pm2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnVDkEAqn7Gm8Vvc/AbJPhWELmV2yltB4fWDVuPNJxuoABLkxC22eJ8gJQmgm6+r+R3Xfec5O9toUh@nongnu.org
X-Gm-Message-State: AOJu0Yye2qPlaEKP6jwo/1MvqT6a2clQmjbqF+dEZbfQzr1ow31tsQAl
 eFcSCvgpZyiYy0Xg9ciwxnFL2ABrz9WuGElvBX2K7nw+U4ehOrEx
X-Gm-Gg: ASbGncuVBa0m9GyA3+siSWJowPUhUsgXdfSF4S2ivH+jUdE8y2uZDmZjSz6+fSFD0F9
 HhmOd1KXAv8foZDvzMB5wJ0EfP+WOeDPiCH3ljFz3NkQNjItaQBPyGcMQs7DEa08ELh0P4eyXju
 8zTFI+RbREPgj8matzzrpZT7gmVcOo2uRIeWcb44vEr1KFtb1LAasEWyxTjhBJEHgEepBN1KwTB
 CvhlpKDHtLVnIC2HdW5JsVSh2aijlN4dPPjfnVNsl/yeVtILJUhv4BhpqASZa0LYRiWF0LNaBR5
 q40CdS6luFWMZk5MoyioRM/aqk/k9d1PFZlmCo/TkqEHJrIe0w==
X-Google-Smtp-Source: AGHT+IHel31UK9qyt3J8MTh4yGODRRnaVrBaIAplkkUQ+/e8CGy49/oaNCbTx9MwbPKC+M3bDtCKhQ==
X-Received: by 2002:a17:902:f542:b0:21f:8453:7484 with SMTP id
 d9443c01a7336-2292f975694mr172435115ad.30.1743507858424; 
 Tue, 01 Apr 2025 04:44:18 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee11b7sm86408135ad.86.2025.04.01.04.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 04:44:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] ipmi: bmc-sim improvements
Date: Tue,  1 Apr 2025 21:44:07 +1000
Message-ID: <20250401114412.676636-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These little things came up when looking at behaviour of IPMI with
the bmc-sim implementation running the ppc powernv machine, and
trying to clean up error messages and missing features.

Since v1 (thanks to Corey for review and suggestions):
- Added fwinfo to PCI devices
- Report interrupt number in Get Channel Info for ISA, PCI, and
  unknown/unassigned.
- Fix error reporting for Get Channel Info unsupported channels.
  Verify it is the correct error code that ipmitool looks for
  https://github.com/ipmitool/ipmitool/blob/master/lib/ipmi_channel.c#L256C16-L256C45
- Change _CH_ to _CHANNEL_ in some defines names.
- Also avoid adding event logs with watchdog don't log flag.

Thanks,
Nick

Nicholas Piggin (5):
  ipmi/pci-ipmi-bt: Rename copy-paste variables
  ipmi: add fwinfo to pci ipmi devices
  ipmi/bmc-sim: Add 'Get Channel Info' command
  ipmi/bmc-sim: implement watchdog dont log flag
  ipmi/bmc-sim: add error handling for 'Set BMC Global Enables' command

 include/hw/ipmi/ipmi.h     |  19 +++++++
 hw/acpi/ipmi.c             |   2 +-
 hw/ipmi/ipmi_bmc_sim.c     | 107 ++++++++++++++++++++++++++++++++-----
 hw/ipmi/ipmi_bt.c          |   2 +
 hw/ipmi/ipmi_kcs.c         |   1 +
 hw/ipmi/isa_ipmi_bt.c      |   1 +
 hw/ipmi/isa_ipmi_kcs.c     |   1 +
 hw/ipmi/pci_ipmi_bt.c      |  50 ++++++++++-------
 hw/ipmi/pci_ipmi_kcs.c     |  11 ++++
 hw/smbios/smbios_type_38.c |   6 ++-
 10 files changed, 166 insertions(+), 34 deletions(-)

-- 
2.47.1


