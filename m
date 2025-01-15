Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F34C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4tg-0004Dh-5X; Wed, 15 Jan 2025 10:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4tb-0004CZ-Lz; Wed, 15 Jan 2025 10:01:27 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4tZ-0002sG-K2; Wed, 15 Jan 2025 10:01:26 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso119440915ad.3; 
 Wed, 15 Jan 2025 07:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736953282; x=1737558082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bP4N8FKxiB5/9gCXiyE1+NC4Ty7YL+cQj1EaOo/86NE=;
 b=QZ1KH2454/gj2UbcdyldPNdnjBNlYYoziEabgS8+k2tXe1yrb7mXDFzkYR5dI4SiyV
 eB4iJcmj4gZL7hW8/LqRLNWxytBJSDbxL8eMJy0Y7LJl5z7mEur9j2EimRhnMhu1o09d
 vZtVyiy7EHkFgAwfrz3cYp+kyfdZZFJA8DuRY9bSzZ/n6Sncu+SxeYwxf5aPFiB4twRF
 0ayKVtuwweRRhXCNlgfYmOWpMA4NjFFD9VeEx0ptH/sUBQmSbc6j32Zv033eEPRSKARG
 EYpmc/DNPWpl9GqXcJCiS9ivKrQuMghX1m4l4KvAnhN+/BiR7yeLZ6+7PuWTnLeqldG/
 p2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736953282; x=1737558082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bP4N8FKxiB5/9gCXiyE1+NC4Ty7YL+cQj1EaOo/86NE=;
 b=R2PV62LKz8ZIZrfjz6pnC/uwsNbiejzd9FIlotxxxphSPqnIZLrGIItvSKwdNDSVO1
 Pd2TBBnDWY5ndFPaXcjDxGS6AgLYUKCtRyA/RZMA3NkIum8bosU4o5PLwKZbFuvuiuoF
 JuCSgmllMtidbWul6+pU8g8NtNHMb8gm9+9Dsn2kDE7r8XZ+YSGlkhSrD+a2LBfBl72x
 Irt2uWNzu0JLBKj88EB/BFXdOYzGU9xQNfJmNFYJFVelmIKfkwd/xCFfDIrO6Yu+2u4A
 foVRX4LKkL1BkdBX+lATEOwykx4X0rYa2Ohdox+NkEPtRpZ8C1VkB7KFcuKW4ShviGlU
 2Z0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFSy9v/LxY2vglBD06ZCNHiAQPlJflK6J0pxbU/XC40YjEg2nUc2GJ/c9Bic4Qo9TWsaLxIzIK8W9/@nongnu.org
X-Gm-Message-State: AOJu0Yz6l2SoqVkJcNGXrYEE3IOD5WG39ZS3+ectT9eNHJtWbJesdPWn
 tLuTwyxuSdexLL3FxrUQG6MY27IPSFKgtOD5fhYkJRa6JMsK6NCrYX6Qbg==
X-Gm-Gg: ASbGnctDvf8isVzjoerfxSVchSjzAkPfC32XAqgx4R+jv00DqORrfeF+Sqm48DcvWgB
 873KQJvwXiqQXhWUnQKBlk0+dVAPF5SaPTXYjeo86BENdhFnop7eUubMoNGQheDx6P0c+sqE/wY
 QGc6T1cY/g5g4353K3d80oP9Olm6FxFWTYi0WvcQSPaYAgmX92OVkKNgMBo6+nEnaw3iLZyidOV
 zBQYkiV2FyQQCHwHwMxSTGW1fp6czE0kFaLQr8vG8a9d0vK1e4HIi2sx9BuUw==
X-Google-Smtp-Source: AGHT+IFNDvfEneccpnYtsqZlg7T5OT2s7v3apepSbFq89C6AEXsPNIzS0X8fDQXp7+qqe6RLb6w4bg==
X-Received: by 2002:a05:6a00:1255:b0:71e:6c3f:2fb6 with SMTP id
 d2e1a72fcca58-72d21f4b05emr48465909b3a.8.1736953281659; 
 Wed, 15 Jan 2025 07:01:21 -0800 (PST)
Received: from wheely.local0.net ([118.210.104.29])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658a7esm9519592b3a.106.2025.01.15.07.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:01:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org
Subject: [PATCH v2 0/5] qtest: pci and e1000e/igb msix fixes
Date: Thu, 16 Jan 2025 01:01:06 +1000
Message-ID: <20250115150112.346497-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

This series fixes some iomap balance issues and enables msix
sharing bar0, which will be required for some future XHCI
test cases.

It also removes the invalid write to msix PBA memory by
qtest, and fixes that properly by unmasking and taking
delivery of the msix interrupt in e1000e and igb tests, as
other test cases do.

Since v1:
- Patch 4 update comments as suggested by Akihiko Odaki.
- Patch 5 significantly rework and simplify also suggested
  by Akihiko Odaki. In particular the msi vectors are always
  unmasked to avoid the extra case of handling masked.

Thanks,
Nick

Nicholas Piggin (5):
  qtest/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  qtest/libqos/pci: Do not write to PBA memory
  qtest/e1000e|igb: Clear interrupt-cause bits after irq
  qtest/e1000e|igb: Fix msix to re-trigger interrupts

 tests/qtest/libqos/ahci.h       |  1 +
 tests/qtest/libqos/e1000e.h     | 11 ++++-
 tests/qtest/libqos/pci.h        |  3 ++
 tests/qtest/libqos/virtio-pci.h |  1 +
 tests/qtest/ahci-test.c         |  2 +
 tests/qtest/e1000e-test.c       |  4 ++
 tests/qtest/igb-test.c          |  4 ++
 tests/qtest/libqos/ahci.c       |  6 +++
 tests/qtest/libqos/e1000e.c     | 87 +++++++++++++++++++++++++++++++--
 tests/qtest/libqos/igb.c        |  9 ++++
 tests/qtest/libqos/pci.c        | 74 ++++++++++++++++++++++++----
 tests/qtest/libqos/virtio-pci.c |  6 ++-
 12 files changed, 193 insertions(+), 15 deletions(-)

-- 
2.45.2


