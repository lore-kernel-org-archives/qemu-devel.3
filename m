Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9091BC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPsS-00021h-4f; Tue, 20 Aug 2024 10:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs2-0001tm-Pq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:04 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPrx-0001VH-9a
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:00 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f3ce5bc7b4so33506101fa.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164194; x=1724768994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1wqHo/ZnPjHlrmdKYJtuWm38+7FAW/gtzhAalcKMwBA=;
 b=gf/Iqd4rmQ9+9c2v2kI8qMV2Fu90W1a+hT+LHo0KuPybEw5mKpRSQbCfJ+w9F9l/qW
 gUbxQjuE3sAm2UGgbv0sD3e+6bHw4sfF8q4Ol4UernEc/QZm5SB1sUFiEzei4+oIePL5
 FpwwRWhCu7Ga1WTn7LAJmSYZBPOhGmGBPXboqlcqMiXD+B7aGp5QEwJD/98zTDJvkpSX
 NhLs7mmANwP3fyE8JxAHEM2Lj/zaA0Z1thZWadxHApmwacHkwDYp1Rnmrsa3qZdZmoDG
 L1NX6uPx3m71whwGD7R0H9+8bKYx/KzoAYWz3dpOagq9711Gd36cCpYDCvWRerFkTD38
 QXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164194; x=1724768994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1wqHo/ZnPjHlrmdKYJtuWm38+7FAW/gtzhAalcKMwBA=;
 b=eFg/gpMQEYjtSB9CEuzccgzTyg+5JfIhRfM0WyyUXFS/uobFe4PAQd85oWbrobEuYv
 1T/zQjkkmaeXsdSxsMX54nxE5soTXFLyaKOy/WAbH4zvNXtB20g+7Ox2PoksF5iG3wlO
 SPF/dolMtV4KBsELa19P2Z1FuV3lXkwVhuIilorHcmMqX15c2mB1S7iuxwZBNJvq+k6n
 OTGJn8UVz1weZyZ8G2Etn1jiwTLaPMGXqxSfLAgsSIGh+dR0R215KB5bgvuJTa8yC+i3
 BLB/OwVv0KvIFvy579CsNSmUcbpaTLIDyMEt+WcjTeRcCRUk5C57t+RwS2ClnoV5hkB2
 3IGw==
X-Gm-Message-State: AOJu0YywNaR3Wo8WZ5lGTfb1D+1cl3fiD+6KvSHq67Yf/r0prd+9VTZw
 Il1S9FzMuqBV7yi3tBhwn0u4dORYW5vnWBizzuhiPs7/SNR6sadR9LcKpZWI
X-Google-Smtp-Source: AGHT+IHmXoWvrk+gxIHZjEW1LKuL3xcHNfeuaWwnRfQPlxHkqzHlE5tf/66Ts3wZhxRwZDt8IqN6DQ==
X-Received: by 2002:a05:651c:199e:b0:2ef:296d:1dda with SMTP id
 38308e7fff4ca-2f3be57810fmr104068131fa.1.1724164193085; 
 Tue, 20 Aug 2024 07:29:53 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f3b748db7dsm18217371fa.36.2024.08.20.07.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:29:52 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 00/12] xen: pvh: Partial QOM:fication with new x86 PVH
 machine
Date: Tue, 20 Aug 2024 16:29:37 +0200
Message-ID: <20240820142949.533381-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
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

This series breaks out parts of the ARM PVH support into an abstract
machine that other targets can reuse.. There's a bit of refactoring
and some bug-fixes along the way.

Finally we add a new x86 xen-pvh machine.

The corresponding changes in Xen for PVH x86 are work in progress
(by Xenia Ragiadakou). You can find a current version here:
https://github.com/edgarigl/xen/tree/edgar/virtio-pvh-upstream 

I've briefly described the steps to run Xen PVH x86 guests here
(including example guest kernel config, xl.cfg and xl command-lines):
https://github.com/edgarigl/docs/blob/master/xen/pvh/xenpvh-x86.md

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Use an abstract PVH Machine to share code between arch specific
  PVH machines. This allows more sharing than a using a device component.
* Add comments describing our PCI INTX support.
* Allow the PVH target specific implementation to provide PCI
  INTX delivery via class methods.
* Clarify use of mc->max_cpus in comments.
* Use GUEST_MAX_VCPUS mc->max_cpus on ARM.
* Use HVM_MAX_VCPUS mc->max_cpus on x86.
* pvh-common: Directly use s->cfg. members when creating gpex.
* pvh-common: Clarify use of pci-ecam-size in comments.
* x86/xen-pvh: Create smp.max_cpus nr of dummy cores (not smp.cpus).
* x86/xen-pvh: Replace static array holding dummy cores with a dynamic one.
* Move stubbed Xen/ARM functions from hw/arm/xen_arm.c into xen-stubs.c

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
 docs/system/i386/xenpvh.rst     |  49 +++++
 docs/system/target-i386.rst     |   1 +
 hw/arm/meson.build              |   5 +-
 hw/arm/trace-events             |   5 -
 hw/arm/xen-pvh.c                |  89 ++++++++
 hw/arm/xen-stubs.c              |  32 +++
 hw/arm/xen_arm.c                | 267 -----------------------
 hw/i386/xen/meson.build         |   1 +
 hw/i386/xen/xen-pvh.c           | 121 +++++++++++
 hw/xen/meson.build              |   1 +
 hw/xen/trace-events             |   4 +
 hw/xen/xen-pvh-common.c         | 362 ++++++++++++++++++++++++++++++++
 include/hw/xen/xen-pvh-common.h |  88 ++++++++
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


