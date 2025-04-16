Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07C8C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54F5-0006eI-31; Wed, 16 Apr 2025 11:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54Em-0006ZO-4r; Wed, 16 Apr 2025 10:59:40 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54Ee-00035D-A6; Wed, 16 Apr 2025 10:59:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so5739488b3a.0; 
 Wed, 16 Apr 2025 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744815568; x=1745420368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HXuQGfkXP/19tux2piI9VRUlehpzjl8OjOtBJ20HPC0=;
 b=koRf3T8QRN3dOHwgKexVo/7Um5xO/8rfkFt6+zvAl3STFd+9M2w2KKmJMV8QmG0DXM
 WI6S/KDjsnEUzklxICQj+a6/weXqtVRyv77NPHE9eyECUmINNSyObBhHLkx/Rk5TGCYd
 sL490lWW0IO8X7uQPD+MqCVHHuls2At3/qkt4K2k54UHxFwgyqT2omwQx7S3m7CG8eTn
 JmKHkwukzHWilyTCkR8OMSkLujcN2Ovr0VxIIWxn3AlEDvZA5LkYvkvfELvBbhwL+dYL
 28SW8kKWtc/5KL2CIoVIIscHTpG6WxUBt33/FpylB0hRteHaJOR0onegjthIpQOGuJNi
 iaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744815568; x=1745420368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXuQGfkXP/19tux2piI9VRUlehpzjl8OjOtBJ20HPC0=;
 b=AMG/6dgVT4VJoq+s5ZtClFbWQNP/wsky6NsKlzx8eLWzC47tK59Xe761ExfWaDHFbc
 Zwg6c3j/DIXMrh+kGUBKTYVX8LfsKYuN3KsIu+kCZYuJzvZdA7B30/EfECVAT8XBXlE0
 mzAsIuOnVG4Kxx6f2MUbH1gyp1r+IPfjxRGF2TOtQxaPXSUGwP1MZE8gX6nAjaMSmcF5
 gtfNDYnJ61bO1guevRgvOiaVt9e1Qw8nPjVMOp1CpGoKlqsyfOP6j8aIOtsFG5jKAq2d
 RERL0emFNYL1UyPnczBAuuDDQ6jI2ODCRWQc2icMndSFcYn/UEDF52sxJIZPn26dO7Rr
 vfpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrDMWuhC3/2MzZ9Qk3HJFt7RznpbrbtclT6EPhEECmnafvkD8Xr2XMX7MRTg6jsY1rEb7SQt0z1kSr@nongnu.org,
 AJvYcCWznIWRSB6lUFO5c9k/49k6SQdoLf6pJ/+bp065ihLf60fB7qFXj4lZJIVQpQfSz0TXbmWfe7OMmx5yqQ==@nongnu.org
X-Gm-Message-State: AOJu0YxaWR7alDvQf3L5bHpqdXLuwWbVuTDOcrpX1eGzoGtNlyx2C7SJ
 lPLUlmCp1JORi/6xVi4cnDPHJ56JlzziumPIF3kYTxYQZkxFZk24OMILLQ==
X-Gm-Gg: ASbGncuDA4GaeIvxbXY26g5O+iP6EGXqr38jBgvlHN0WT7aqwfV4pszwP+Jb9JPrgcs
 Qu+/vg8Mo7JwwHy6MKqLwij894d5iD/QJP+rA6GaKiEa18zmslEgswxpOLJHO8dApsPWgl0TttA
 f5biW9qSVwsitc1YwO1XmLX1KXTGfakLz2z1CpBS91fTjoimqfSlg1LdTrLb7sLvKqNKdmXx0KL
 fb6yH0q4iRaUaVDQcd4atpje50lcE9YHHJY8YNmZ9E4re4795J2v6wXIdTGcuJJawn1CmAcq15c
 a1gIQaH7s+EYKq/s7IdsvpaaA/RDhnKqvy0ETt5++Q==
X-Google-Smtp-Source: AGHT+IGvsKhx50Ja+VWnGN3C82mcjVGOvOGlZGYXvkAowslG+YKQUq/1AvQsG+lbC0l5vNvb/hO4XQ==
X-Received: by 2002:a05:6a00:3001:b0:736:d297:164 with SMTP id
 d2e1a72fcca58-73c266b28efmr2838269b3a.1.1744815567702; 
 Wed, 16 Apr 2025 07:59:27 -0700 (PDT)
Received: from wheely.local0.net ([1.145.55.85])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e355sm10814506b3a.139.2025.04.16.07.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:59:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH 0/4] tests/qtest: Enable spapr dma tests
Date: Thu, 17 Apr 2025 00:59:14 +1000
Message-ID: <20250416145918.415674-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

I kept R-B tags from Fabiano and Phil despite a little change in
how patch 1 looks and splitting it, hope that is okay.

Since RFC:
- Split endian fix + invalid value assert into two paches.
- Changed the invalid message assertion in what is now patch 1 to
  use g_assert_cmphex so the failing value can be seen.
- Added patch 3 to factor duplicated code we just changed. Some
  patches I have for e1000e and xhci tests also want to use the
  same function...
- Fixed stray hunk from mis-rebase in the spapr patch.

Thanks,
Nick

Nicholas Piggin (4):
  tests/qtest: Enforce zero for the "un-fired" msix message value
  tests/qtest: Fix virtio msix message endianness
  tests/qtest: Add libqos function for testing msix interrupt status
  tests/qtest: Enable spapr dma with linear iommu map

 tests/qtest/libqos/pci.h               |  6 +--
 hw/ppc/spapr_iommu.c                   |  9 +++-
 tests/qtest/e1000e-test.c              | 21 ---------
 tests/qtest/igb-test.c                 | 21 ---------
 tests/qtest/libqos/generic-pcihost.c   |  1 -
 tests/qtest/libqos/pci-pc.c            |  3 --
 tests/qtest/libqos/pci-spapr.c         |  7 +--
 tests/qtest/libqos/pci.c               | 62 ++++++++++++++++++++------
 tests/qtest/libqos/virtio-pci-modern.c | 30 +++----------
 tests/qtest/libqos/virtio-pci.c        | 38 ++++------------
 tests/qtest/vhost-user-blk-test.c      |  6 ---
 tests/qtest/virtio-blk-test.c          | 12 -----
 12 files changed, 77 insertions(+), 139 deletions(-)

-- 
2.47.1


