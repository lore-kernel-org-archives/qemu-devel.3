Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3987FC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36D2-0003CK-AL; Fri, 11 Apr 2025 00:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36D0-0003C2-RL; Fri, 11 Apr 2025 00:41:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36Cz-0001ZO-A4; Fri, 11 Apr 2025 00:41:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2241053582dso21798635ad.1; 
 Thu, 10 Apr 2025 21:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346499; x=1744951299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=H6t4SJpfcCnWF6cns1lG2/hYIMS+W6yS8eMYzKAhvZs=;
 b=FXQky3ucWiTCHT1pcd/dI4lrXwmOGyy7uRrNYTIfav8HYp1NjMm0gzef1/i9VXWIXs
 eYIM+cOlFaX7tN+4C7NsEsYP+GjarK6uwy5AyzYPTrX+RVRD9Dlm13z2G5Q6HMnEb7QH
 BHQYgLvo7SmOEix2Z+nEypOsEMVvvCYrYLUXkJY8MJteu+aAURml1/x9ZrhR/anFA8P2
 jv5ZGtIuSSIyv3/PyMPfxk1FUrvemAoT26/Egm3+a7QbGiekR2h4bZg5uQ6ktgZSGklg
 IT/npxtVQ14RIUGT1pGHI5iU1gYQolBnQfwBnDiYj2qa/lUNAD2dWx76xjpoIXuz4JIV
 uFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346499; x=1744951299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H6t4SJpfcCnWF6cns1lG2/hYIMS+W6yS8eMYzKAhvZs=;
 b=AJJ8IhmqGphTOInM64dCUPQJbHdEJ3XtYuywDbtxvoxfhFp0tkwitZBsK2JBWyTGIi
 TFKfa7Ff9aboMODVdH71Q8RzEVJbTI8lHvD+BnC2p+tZB+zeUB2YP/uC/u9RVdKtK2iU
 XcgUFbqCVgzYIm+bc1Vgn25E+RecjTx9IAOSg4dAI0P+xFqn9k5EJ56Qb7Z/HTE1DV+d
 Pi7HR3FrB3WYSR9oJiwgNGCFHjK7wEndtEP7dKsM4kGX+wMoHwnPsdYN7iS6AAmVBkS3
 z3TLp3utoJoXIfFvBywCicgoj5un27SXRWI78OgJ6tVHLdeEW/oPx1P4ejPCyBcmASo4
 gEFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwoCakgCz6n0qVTrIu5TrU1EO2QeD24LFudO+4Wp6unpW96IVYaucPRAJ7ZEcLCOaTfx5R/RhDEEB0@nongnu.org
X-Gm-Message-State: AOJu0Yx99A7LbsdoUFBL6NxbE+75v/r32AJPQ9W58vBIwxOch92+Jc8a
 nk8zeVA3jYCQYqNrVG/x14ibVru9IpT0O00PfyVgpnCFeZo0udO4BxRO2g==
X-Gm-Gg: ASbGnctWPWx3L9cHdS3ezIhEMs8R1vIta8CLQt6JzFZe+9rMkr5EMCk7pzGG77ewtbD
 aQSeFfuBQ4W8Qbvfotz1inW6l1HJW41R2rxC1MhqRz9rWTqusjtpRI7EtjfCutJ4PWmzY7etrQx
 gqAs2apGlJVJs4xYYAEe0cv95b+6/sFklKkxdvzKqqh9r4AExddixmyMsHKGrPs4xPUyEUKULgz
 Dane3mGuEbV6LdxcY/1FmiKXYpQVftCzPBlRhJRM3S5AgeILTjeaIM35lCdaZqOX1An5IZoC4l7
 rKe+37RpKxNo4eK3nifQP8Jgpjyxfe9zvEhOucdi12m6
X-Google-Smtp-Source: AGHT+IGFQNeTs9dOuNOUBID6LhRDaAW49TV1x0wwkr//fZvX+clappYwDXSkDz4ziWs0p6zUQ8ZH0Q==
X-Received: by 2002:a17:902:f68f:b0:215:7421:262 with SMTP id
 d9443c01a7336-22bea4b40f9mr18715415ad.12.1744346498951; 
 Thu, 10 Apr 2025 21:41:38 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:41:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v4 0/7] qtest/libqos/pci: pci and msix fixes
Date: Fri, 11 Apr 2025 14:41:22 +1000
Message-ID: <20250411044130.201724-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Since v3:
https://lore.kernel.org/qemu-devel/20250117172244.406206-1-npiggin@gmail.com/

- Split out the preparation patches for the ahci and virtio tests
  into their own patches as suggested by Phil.
- Added an extra assertion that qpci_iounmap() must only be called
  for a bar that was previously mapped, which required a bunch more
  prep work in ahci including adding a qpci migration helper.

Thanks,
Nick

Nicholas Piggin (7):
  tests/qtest/ahci: unmap pci bar before reusing device
  tests/qtest/ahci: don't unmap pci bar if it wasn't mapped
  tests/qtest/libquos/virtio: unmap pci bar when disabling device
  tests/qtest/libquos/pci: Add migration fixup helper for pci devices
  qtest/libqos/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  qtest/libqos/pci: Factor msix entry helpers into pci common code

 tests/qtest/libqos/ahci.h       |   2 +
 tests/qtest/libqos/pci.h        |  14 +++
 tests/qtest/libqos/virtio-pci.h |   1 +
 tests/qtest/ahci-test.c         |  38 +++++---
 tests/qtest/libqos/ahci.c       |  11 +++
 tests/qtest/libqos/pci.c        | 148 +++++++++++++++++++++++++++++---
 tests/qtest/libqos/virtio-pci.c |  59 ++++---------
 7 files changed, 208 insertions(+), 65 deletions(-)

-- 
2.47.1


