Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F768C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUOR-0000Bd-Ea; Mon, 29 Jan 2024 11:21:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUUOQ-0000BM-AV; Mon, 29 Jan 2024 11:21:54 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1rUUOO-0005kH-9X; Mon, 29 Jan 2024 11:21:54 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-59612e4a21eso1004073eaf.3; 
 Mon, 29 Jan 2024 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706545310; x=1707150110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hOTTH6nrrocKdYrOWl6KvQ7eQwW7Ni2LFEsyt7wBAPM=;
 b=OhQT2bKJ6+zIxBEMYc8qfQmbJ1ZebTxFxdC0xKfC9N6nu7wAsbLV9fxiUoNrkpnk05
 6NsB3S5wvl9OpbusGmVMM1WDxDcucS81GrYR6s92ilH1i7COOAFC765dUmapUXzXFyEY
 lSj8/Re1s4SZHFlER3B/uObqfiffMUM4lLMtO9ZvSCVOSaMHAYZiCiLwM8mPx+8PVlw4
 DLiQusNHml1enftPh0XoQdxnhzg71wCm4clJ57d29wcgUFCqgok2C+PQciunGOpKUsxL
 7OpaZxfZzCQCdTd80GG4tN6JV9mW0E8DICWzQh3gwYdnqi2CZlDhDV3Pi75nZS8Uicqd
 yyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706545310; x=1707150110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hOTTH6nrrocKdYrOWl6KvQ7eQwW7Ni2LFEsyt7wBAPM=;
 b=sw49dGncsfeWlvwoOryNYvkWL/bf6RyRFQ2orLh0H7u3CDu6/VTMw3i7SUGaCNNpA4
 q65N7Em7CfE/aJ1bOrK50Ort+uXbXh1PVaT5DSCS6VnRcQrUw1xeFNSaQLM/CIMmDq3k
 FPg+imUVkdsSF+Wp7xsXBTO/3k4x4SgoxJ3e5w+sXEP7VwmIIBw/tfaAQwJEOuh0H5n/
 lZvSnnfd6ePmjtxpRDctlETBFnSQkg+mof4jSE/R4M7WEMcRnea5SWI+Z4YhovTK+ojm
 EK8G0ZDWR4HqWCjs/FOK7QKMpNwsz4p6l5LCrBu+vXri+SXHardpHOPzfCb9AVzIJVhi
 hhRA==
X-Gm-Message-State: AOJu0YxMxVhNFkuefIngO3ck9LYS9uPoaREFBz5S2EdApLJAOTSOoAje
 xCtu/mPvRO5qauDjJ17vlWHc2J0Ngkx9hCbPRKSXEVpr2s4McZnufdcdQCJLryYbjg==
X-Google-Smtp-Source: AGHT+IH84g8Vo+gRpge1u+xbHA1h+p5jNhak+ITca3iu+oldztJO40NA7kIMxWx52YbLiX3LHxesrQ==
X-Received: by 2002:a05:6358:d59b:b0:175:a3ed:f630 with SMTP id
 ms27-20020a056358d59b00b00175a3edf630mr2122918rwb.39.1706545310173; 
 Mon, 29 Jan 2024 08:21:50 -0800 (PST)
Received: from localhost.localdomain ([49.47.195.100])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a63e650000000b005d553239b16sm6241339pgj.20.2024.01.29.08.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 08:21:49 -0800 (PST)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: rayhan.faizel@gmail.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v2 0/2] Add BCM2835-SPI0 to BCM2835
Date: Mon, 29 Jan 2024 21:51:06 +0530
Message-Id: <20240129162108.2782082-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-oo1-xc29.google.com
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


