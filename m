Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDADC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUU1Q-0002rH-As; Mon, 29 Jan 2024 10:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUU1P-0002qx-2T
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:58:07 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUU1N-0008Ks-E5
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:58:06 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d8dd580f3dso3888905ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706543884; x=1707148684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hOTTH6nrrocKdYrOWl6KvQ7eQwW7Ni2LFEsyt7wBAPM=;
 b=cb/hnjffs/PkgELJNxIyqJ9J1r7/PJec7kKeClY4IpF01hiRh2Mze+lKN9pYdPn6/R
 MOhhLrIchpDx0yEb5xMiSGgcAwW2vzA77Al6xfWKb8UCqeR8DSALhgkji6rTzgyu82Pg
 /Ci4hqdq1tQX31NDDTwyYjB5gQfno8uurkGzQ8h58VUqvKpFL+hG0hj8kagPtHKsZEeK
 gy5UDlG6f4Pvn+ID0UJyi2lVi5ZuTnVmwpmKClQIepmtMeS9OSsZwjEKfDQkUXKpUh1A
 UYCneFhaN3QklUli7v8MjWYioB/imP9O+lJenZ0sjokdE8DACqkIjQ7tASYscAMWSMR6
 9xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543884; x=1707148684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOTTH6nrrocKdYrOWl6KvQ7eQwW7Ni2LFEsyt7wBAPM=;
 b=a4ZV+fJk3UhtCo8Bpp9DiAS0dOCUg+L+hDDAzOyjb82pOHd113jXvqyf8pTg4oWoSA
 K0Unyy1tulglK/LJa0ZzVIrVMu5p/aEGjILPGJ6Elj8cgLzmFr/5IfcSzPL6tXzb1Z6g
 1/jyFfPBJwaZXhfqsTzfySUdpyGAx932zKbyM74MSseyavj/sKeNR8fHRQ+XhVTnkmph
 ZkZvpn44+OIAQDN6gzt0e/hstZohfpSfx16b6SbyJEm6vUpQBRbtlqRU6BbXXz0hBrEG
 tnGdpv0nKrFx5nFZq3KcQthGzR2UHYeYoZTtjaFWKU4q0s4ppij5H/hAqoSEG9fsy2jf
 4ePA==
X-Gm-Message-State: AOJu0YwqlG8SX16acJBYoE7js31OtpeVcEUztc4fpNkP8AXtPGzOeZkH
 AOJQTZ3rK+vfPVvIO3n3FgmnMJqfIgxCoZyYnffF9slwMMW8tdLxTBBwC3xWefA=
X-Google-Smtp-Source: AGHT+IF0S+T2zZm5Y37AetgoURSx9Bl65Gb26APZ/U//t2U3vwXSl63qR3s4Zy5fpiQGk2Wx7sAeTg==
X-Received: by 2002:a17:903:2b0c:b0:1d4:c7d5:3587 with SMTP id
 mc12-20020a1709032b0c00b001d4c7d53587mr3305135plb.9.1706543883742; 
 Mon, 29 Jan 2024 07:58:03 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a170902cf4e00b001d8ffeb53dbsm100955plg.77.2024.01.29.07.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:58:03 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rayhan Faizel <rayhan.faizel@gmail.com>
Subject: [PATCH v2 0/2] Add BCM2835-SPI0 to BCM2835
Date: Mon, 29 Jan 2024 21:25:42 +0530
Message-Id: <20240129155541.2767068-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch series implements the SPI controller for BCM2835 boards.

[Changes in v2]
- Accidentally forgot to CC maintainers
- Signed cover letter

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Rayhan Faizel (2):
  hw/ssi: Implement BCM2835 SPI Controller
  hw/arm: Connect SPI Controller to BCM2835

 docs/system/arm/raspi.rst            |   3 +-
 hw/arm/Kconfig                       |   1 +
 hw/arm/bcm2835_peripherals.c         |  17 +-
 hw/ssi/Kconfig                       |   4 +
 hw/ssi/bcm2835_spi.c                 | 288 +++++++++++++++++++++++++++
 hw/ssi/meson.build                   |   1 +
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/ssi/bcm2835_spi.h         |  81 ++++++++
 8 files changed, 392 insertions(+), 6 deletions(-)
 create mode 100644 hw/ssi/bcm2835_spi.c
 create mode 100644 include/hw/ssi/bcm2835_spi.h

-- 
2.34.1


