Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F7CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsfs-0001Jj-IL; Wed, 04 Sep 2024 12:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfc-0001C8-R2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:15:50 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfY-0002G6-Jm
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:15:47 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-533496017f8so8974353e87.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466541; x=1726071341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UPov3bEaYQETs3cfkL+hd+7yzj0MCF4STSdQusQLNLk=;
 b=Mf+r/strryq0aIJSK0LKxBcMlmbnd8iPCMi4fAP+i3E+EM8RXyEgEd5Th3dk7+laFe
 jpM1DC/2e0mUxn5EHg4dFxw1TSc+4OFhfx2NSDNcFv7Vp0wrpgagCoHwsKdDptDe32ux
 z2BMkV4w/3zw2gnhMWhL4vLXNSA0CEN9DjuiSyrY7Y34HscY1X0g3o/40mXPFhE/uNav
 3o0ifQeQ8/kuraum5pBwaH7eWCJalA9EnLS/0glgAI7P/onFkwDyhee2Us1EYGD9WQiz
 WyfcQmdQccahVQmcEcgB42HbQbOZfPxrzUqTGIt2oPmXTY7dZDrLu4jXP9JjqHqf7gRN
 wdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466541; x=1726071341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UPov3bEaYQETs3cfkL+hd+7yzj0MCF4STSdQusQLNLk=;
 b=angZbboOjd+vS5Iv1+ZQqDML08BdUBTUo8+AlxsPyWrMaIy7m1dRxqEXVtt/tCKjIn
 xEXK/CRNPCfmOo2pas9CknY9CRH7mDev41LSBv6+7ewZRApXl6JNOS9LvIsTHMn06Lvz
 O+qgG6s/VG/fgI2MYsSE9zZWeJ+LWRYhWMlrcBMCmnSs0AAEzXiknkA9wdD/tM2gUAzE
 8elRLA5vhyghbIVVrR7ieR/PCcbORGFkmCms+vQ9qDRC/D58WDncszvX1QPLgrJQOw0b
 BGBwCceJkYXnZjzNm+YvS491cDQrufVQn0H1joqGM6GbnvdidfPYuEb522jNdCqPPEJ0
 MvCA==
X-Gm-Message-State: AOJu0YzJmcqCoFeH7hTV48jIZ7HwKGGSYV3wB+L6IYLQql8oMjM8/B3Y
 W00s0Efb/4jzL1+Yof83N7c2yYTK8d2HQsWfBm64bMfXNTbnRdMNK5QPHJEr
X-Google-Smtp-Source: AGHT+IGGxyXV1DHmwVIe0OpCvVwm03kby7sZoJZm7dAyldQigQIQwsvNJl64iMUk2nMzo9AdvWIDKg==
X-Received: by 2002:ac2:4c41:0:b0:533:4191:fa47 with SMTP id
 2adb3069b0e04-53546b69167mr10896281e87.47.1725466540471; 
 Wed, 04 Sep 2024 09:15:40 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5354084c9cfsm2388903e87.244.2024.09.04.09.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:39 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PULL v1 00/12] Xen queue
Date: Wed,  4 Sep 2024 18:15:24 +0200
Message-ID: <20240904161537.664189-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit e638d685ec2a0700fb9529cbd1b2823ac4120c53:

  Open 9.2 development tree (2024-09-03 09:18:43 -0700)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-09-04.for-upstream

for you to fetch changes up to 0b57c8160a2a6c833cfb1d958f08385c4391ab70:

  docs/system/i386: xenpvh: Add a basic description (2024-09-04 16:50:43 +0200)

----------------------------------------------------------------
Edgars Xen queue.

----------------------------------------------------------------
Edgar E. Iglesias (12):
      MAINTAINERS: Add docs/system/arm/xenpvh.rst
      hw/arm: xenpvh: Update file header to use SPDX
      hw/arm: xenpvh: Tweak machine description
      hw/arm: xenpvh: Add support for SMP guests
      hw/arm: xenpvh: Remove double-negation in warning
      hw/arm: xenpvh: Move stubbed functions to xen-stubs.c
      hw/arm: xenpvh: Break out a common PVH machine
      hw/arm: xenpvh: Rename xen_arm.c -> xen-pvh.c
      hw/arm: xenpvh: Reverse virtio-mmio creation order
      hw/xen: pvh-common: Add support for creating PCIe/GPEX
      hw/i386/xen: Add a Xen PVH x86 machine
      docs/system/i386: xenpvh: Add a basic description

 MAINTAINERS                     |   2 +
 docs/system/i386/xenpvh.rst     |  49 ++++++
 docs/system/target-i386.rst     |   1 +
 hw/arm/meson.build              |   5 +-
 hw/arm/trace-events             |   5 -
 hw/arm/xen-pvh.c                |  89 ++++++++++
 hw/arm/xen-stubs.c              |  32 ++++
 hw/arm/xen_arm.c                | 267 -----------------------------
 hw/i386/xen/meson.build         |   1 +
 hw/i386/xen/xen-pvh.c           | 121 ++++++++++++++
 hw/xen/meson.build              |   1 +
 hw/xen/trace-events             |   4 +
 hw/xen/xen-pvh-common.c         | 362 ++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-pvh-common.h |  88 ++++++++++
 14 files changed, 754 insertions(+), 273 deletions(-)
 create mode 100644 docs/system/i386/xenpvh.rst
 create mode 100644 hw/arm/xen-pvh.c
 create mode 100644 hw/arm/xen-stubs.c
 delete mode 100644 hw/arm/xen_arm.c
 create mode 100644 hw/i386/xen/xen-pvh.c
 create mode 100644 hw/xen/xen-pvh-common.c
 create mode 100644 include/hw/xen/xen-pvh-common.h

-- 
2.43.0


