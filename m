Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5320BC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAghz-0001D0-9g; Thu, 01 May 2025 23:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAghx-0001CJ-2i; Thu, 01 May 2025 23:05:01 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAghv-00084G-67; Thu, 01 May 2025 23:05:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-74019695377so1390808b3a.3; 
 Thu, 01 May 2025 20:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155096; x=1746759896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/kFvo0g8CcZ6d6v+axjxMJhZQpCfm+ikCr6BeFDwz40=;
 b=gEJsRsICflv4jhXqZL71F6/cSDJINmlfc4qjuw2SeNhAp2Hkfzm9TsoKgiF40s4qrs
 hah6m/L+cwpoa+HPV5CsWYJvLUb+BtS7uxNGb8e9RL9CQy24Ohck1a28VlVyUEdf25WF
 5v6rTxqTYTI8xk5U/KWqIdVoy+fPsZY9KTlgBTYxCDoub8k2JbcRgRdjLR2/Q6/Xeufx
 bV2/lPEeZEo3Boq0KYjFDNQ1X8Eb1VilO6UdlGrItVSW86Ak5+5wmXN7K3EtikO5xUJT
 11SBuxZLOrDH+x8q6PjKW5ki9nB83fyTJgnVNz8dqWsnmOmzhOiQpMiKc435tLsp4YAa
 NkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155096; x=1746759896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/kFvo0g8CcZ6d6v+axjxMJhZQpCfm+ikCr6BeFDwz40=;
 b=Qv3cDu5QhZMrA3dvL1eudXsg2naTt7kALz9fm2Ax3tl1YwG4HMz8BpXYq850NUIZeo
 TufqDDXBwAByMXR/kX39b0pXXqPBcsAtMRgE/Ih+LMEuWopIgcfRTDIgvX+oa+T+HGmy
 0Rwf75X08+ExxKJhBNEzeAgvBPU6SOVz5YzhtGhgaiF4jI4BpwDFv3fGngQ1q/2/mdYf
 mzlmeJMeNVCsc+1zM22cUF8wHqA1SV7TvZE0LD3TXYoNne8tncVBClmK3lL1HEhp7G60
 ZOzlb8Yr/mpmpnCWh9GkH8znu5JgLSoSk2puPLdGpJkYuZ00reyK3FWlapEvWUJS9/Ax
 rGmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz9rxBBdM+48i1/lzOLu8qsNsdCSUaK7ESfT9p5T4SM3K56uhKRun2kZ83W7w2f+M77I6+OMuCldCd@nongnu.org,
 AJvYcCXBExHrzCyG4+FwAJCY3LkZXCbnU3Az9uMKNksNND9sCY4EhO7W3e0wLWH8xld7+E9ptDkxe3Wznco=@nongnu.org
X-Gm-Message-State: AOJu0Yxq1J0Kc+ZAWgiIPIImpn+2gOrJJ+R6pll6AHrdwZFvzhOizv1X
 WPkJAt4Qru12JfhOo6PGynfdi5fXLGFJtc4WOI2uI5tORlyUrXPW02BzDw==
X-Gm-Gg: ASbGncs6PXpUAvIGC3TRf1++ydxM12KgcjtIzbMj5QhhjfufSIJE4ppvrdoTKdqHiNA
 +6DNbF7rtz7ZFnyrWqaGhjYDZHt1BAXLMyuUER0+fDjQnhpZV8HxOhnEifbnSeH6lFukNMvpVHc
 6FGSES2b27HRyqbg2TLUoyyP/+cS0qTbv2M1UfRyHvJ3VlvMIBIjZS86qZj3AGit1zJai1Yz+zZ
 BF9s2QNvo2rwk6P8YptnfUAAKt8HN8rqhgloPCbtSeRoOjRoku2iRo2LXri66I9S2AaoMZz54Bt
 eq+jpz6qx4at2OlIuCkcMcdTPYqd6KdoOeJ/6f7kK1hl
X-Google-Smtp-Source: AGHT+IGRCzSM5xvhJoNXqm3sgfIIhC0D+MWAV4f9mqPIrge+g9tSSC/unjyw81fRClGKgNppmkqQeg==
X-Received: by 2002:a05:6a00:e1b:b0:73f:f816:dd7f with SMTP id
 d2e1a72fcca58-74058b12139mr1560285b3a.15.1746155095944; 
 Thu, 01 May 2025 20:04:55 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:04:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 00/11] tests/qtest: pci and msix fixes
Date: Fri,  2 May 2025 13:04:34 +1000
Message-ID: <20250502030446.88310-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Since v4:
https://lore.kernel.org/qemu-devel/20250411044130.201724-1-npiggin@gmail.com/

I merged in the "spapr" series that touches similar code:

https://lore.kernel.org/qemu-devel/20250416145918.415674-1-npiggin@gmail.com/

- Simplified the ahci shutdown logic to keep one unified shutdown
  function.

Thanks,
Nick

Nicholas Piggin (11):
  tests/qtest: Enforce zero for the "un-fired" msix message value
  tests/qtest: Fix virtio msix message endianness
  tests/qtest: Add libqos function for testing msix interrupt status
  tests/qtest: Enable spapr dma with linear iommu map
  tests/qtest/ahci: unmap pci bar before reusing device
  tests/qtest/ahci: don't unmap pci bar if it wasn't mapped
  tests/qtest/libquos/virtio: unmap pci bar when disabling device
  tests/qtest/libquos/pci: Add migration fixup helper for pci devices
  qtest/libqos/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  qtest/libqos/pci: Factor msix entry helpers into pci common code

 tests/qtest/libqos/ahci.h              |   3 +
 tests/qtest/libqos/pci.h               |  20 ++-
 tests/qtest/libqos/virtio-pci.h        |   1 +
 hw/ppc/spapr_iommu.c                   |  10 +-
 tests/qtest/ahci-test.c                |  10 ++
 tests/qtest/e1000e-test.c              |  21 ---
 tests/qtest/igb-test.c                 |  21 ---
 tests/qtest/libqos/ahci.c              |  20 +++
 tests/qtest/libqos/generic-pcihost.c   |   1 -
 tests/qtest/libqos/pci-pc.c            |   3 -
 tests/qtest/libqos/pci-spapr.c         |   7 +-
 tests/qtest/libqos/pci.c               | 210 ++++++++++++++++++++++---
 tests/qtest/libqos/virtio-pci-modern.c |  30 +---
 tests/qtest/libqos/virtio-pci.c        |  97 +++---------
 tests/qtest/vhost-user-blk-test.c      |   6 -
 tests/qtest/virtio-blk-test.c          |  12 --
 16 files changed, 278 insertions(+), 194 deletions(-)

-- 
2.47.1


