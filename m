Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC99E937E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 11:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBsae-00080b-EV; Sun, 12 Apr 2026 07:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yangyanglan718@gmail.com>)
 id 1wBsaW-0007zZ-Ku
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 07:02:50 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yangyanglan718@gmail.com>)
 id 1wBsaV-0005gw-0m
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 07:02:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82a655cfab5so3085586b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775991765; x=1776596565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P0I64YhpyMjlwXh0rYcyNuTHHPF6A4RQnkGlKp1Ga9E=;
 b=k5HbrsAy/6QOmud2HTSY2i6AbMmq9bwvBVqI3hVCiuz/rK0Wh1LeVCPAe/yOmvzhoH
 shWKhpcNg1WEnvTKVWZs+Q+m0KnXrJlMQaBLcOVQj9N7g5n6EzBSXITfNfyX73xm34/R
 02abNVacsT6fdr2URL0NjQB/GzveaZHHyq0cVNVmpx6594nzTWkGIrR2Fe1ohk4ECf8z
 5RZxybmmqO29fxd7WDjG/wuRsaU0zYJQ/SuLDPojZ018g4likJboC2dUiM6dcvrt4rxN
 17DBANOiIfqoJy1D1mF9x92qHMYuiUN4DMOTjsYwh3whL25b/m4SVwDzfbCRgmiNH51I
 DbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775991765; x=1776596565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0I64YhpyMjlwXh0rYcyNuTHHPF6A4RQnkGlKp1Ga9E=;
 b=KBByoVnBD0osf/nviFd0nwL1S2eI8Aw+61HhqraHNfEnAyHbMKahO7DFWI/oEkboeF
 9gocXGIj2iffMdsTJU5M6xhTrZG6mYuxhM+awsZvrWUfuAOQd/KYN7sx8CjRFyWCMHG2
 TLP85AVm55v81rzEJZKE9gVz3KAGBQ9CAp8/pimb8fGtTYDS2sdS9YYAJ4+h3O66SpgE
 T06WXlrCJNzqVw4oTWHLZeUwOPsuy6+lXkjsK3e5dj7qo4lz0SpVeOEjjCxYrvC826+5
 ee85Aqu5fO8SLCGm1hXVUKGLng0Cdb6KXfFqWJTGj7Lf/Vi32QU9dd6SLvHlwhyivRol
 7Y4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9w6csum1D3zpwB7uG73KW3LHaJ8AVbIP0YokuxKou7mX5CItForvBP+utJ2HDZ621l+mivUw7G23fl@nongnu.org
X-Gm-Message-State: AOJu0YzP/WMZ1f9xAtwyN/hS3L8oqkaK/CxFYuS4Nh29I66IXhTVK3iJ
 xUn8qQTA2y5kUaX1Ts5tXsFzWk3SYenLo724zGey3rLBfaTw/vFkfTfd
X-Gm-Gg: AeBDieutequfHoM3YN1xYh1oiKewyxrjK1GW4TsANd9q4nwxBfSdiINsOkf8Kl4uYI+
 xexbr+RuxNuWnlXhXE95ND+ygY1bV0xXHC9N4i2mku8CpO1/2jQhjjtcRvSA4054h0z9kC3bNxj
 zp8WuhyK/bKlvUZ/OtpJ1yUEd4aCDRKmGE27pSHhovVZ1IPzmUIgKBa1k/eMHBilE0yUJBWObGe
 HRD4L88N+FIsTgt7NbSNc6XsvH35oKknFliU6CNNpcRf8/FwSs841vEbsKlXK/9Szzv5VlLm+N/
 8lOp7EFsqvnYXPLhzmDleDKYxpJ6yKX3hlF5fUWlk77JUskD4hsLjIxC8HdnMeP5J5v+174adQB
 coWA7aif1KfUio/XyEXrqiXZBQxr8W8uoiDVqxdKq8ns2IKJDlzrQdCBs/zts2MlyOGRvXIugXn
 cD8rrafdEiRmLGVt7GVCup3/8OaK6TdED7YRs=
X-Received: by 2002:a05:6a00:9a3:b0:82a:75be:d377 with SMTP id
 d2e1a72fcca58-82f0c2c8331mr8694877b3a.41.1775991765118; 
 Sun, 12 Apr 2026 04:02:45 -0700 (PDT)
Received: from archlinux ([58.38.119.35]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c20aed6sm7996263b3a.0.2026.04.12.04.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:02:44 -0700 (PDT)
From: Yucai Liu <yangyanglan718@gmail.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Cc: jcd@tribudubois.net,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v3 0/2] i.MX6UL LCDIF device model and SoC wiring
Date: Sun, 12 Apr 2026 19:02:38 +0800
Message-ID: <20260412110240.93116-1-yangyanglan718@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=yangyanglan718@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yucai Liu <1486344514@qq.com>

This series adds a basic i.MX6UL LCDIF device model under hw/display
and wires it into the i.MX6UL SoC.

Changes in v3:
- merge the previous "build symbol" patch into the device patch
- drop the unrelated hw/arm/meson.build line-wrap-only change
- fix commit message formatting (use real newlines)
- use 16 KiB for the LCDIF MMIO region size in both device and SoC map
- rework register indexing/storage to match 0x10-spaced register layout
- apply SET/CLR/TOG semantics only to registers that have those aliases
- set CTRL1 reset value to 0x000f0000
- remove redundant 32bpp host-surface check
- move realize-time cleanup to unrealize

Yucai Liu (2):
  hw/display: Add i.MX6UL LCDIF device model
  hw/arm/fsl-imx6ul: Wire in the LCDIF device model

 MAINTAINERS                       |   2 +
 hw/arm/Kconfig                    |   1 +
 hw/arm/fsl-imx6ul.c               |  12 +-
 hw/display/Kconfig                |   4 +
 hw/display/imx6ul_lcdif.c         | 453 ++++++++++++++++++++++++++++++
 hw/display/meson.build            |   1 +
 include/hw/arm/fsl-imx6ul.h       |   4 +-
 include/hw/display/imx6ul_lcdif.h |  37 +++
 8 files changed, 511 insertions(+), 3 deletions(-)
 create mode 100644 hw/display/imx6ul_lcdif.c
 create mode 100644 include/hw/display/imx6ul_lcdif.h

-- 
2.53.0

