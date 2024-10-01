Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF521CEACD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sve5I-0005ZT-BB; Tue, 01 Oct 2024 10:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sve5D-0005SH-Tf; Tue, 01 Oct 2024 10:42:35 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sve5B-0003Hh-By; Tue, 01 Oct 2024 10:42:35 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E2CB15C4D75;
 Tue,  1 Oct 2024 11:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D83C4AF09;
 Tue,  1 Oct 2024 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727782996;
 bh=44BsigIhsxsocvsZCqC3i1BqcN0t/l9an36GyHXYyiw=;
 h=From:To:Cc:Subject:Date:From;
 b=TA+nWCwZzM+RmzWcmxM/gxvN30N/6YU/AE0MGLOCWXZMnXiKgoBGM1RGJH4ktXcai
 dJKz0XiMwDBOOVaEoXo79LsP2lRpfbfmCpVCgM3Kqjb4GnYuKsenPsg9AbdR5CT9fC
 31IxhZwz4vBSOYf+IaRY8Yzslf4gAJww4m6JWh2KzbCq50fd2Lcbb6Bawg4hmDEUsi
 FhVbt1q4g384yL8CJ7HQ0UrdpvBN7XoYHjwYGit4nAvEqjHeXC7TLhHGHo91TNE/nH
 XNV/M122Pv8n654CgzWgDsmLb+NcHlohVZim1Qu0dp9L01ygrmOmoRn7gRih6YgSRT
 dWkD+m6yTWg4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1svbHd-0000000Adcp-34uQ; Tue, 01 Oct 2024 13:43:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH RFC 0/5] Change ghes driver to use HEST-based offsets
Date: Tue,  1 Oct 2024 13:42:45 +0200
Message-ID: <cover.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This RFC series was part of the previous PR to add generic error injection
support on GHES.

It contains only the changes of the math used to calculate offsets at
HEST table and hardware_error firmware file.

The first patch adds a new firmware file to store HEST address.
The second patch makes use of it.
The remaining ones add migration support.

PS.: I'm sending this as a RFC as using the proceudure defined at the
pseudo-migration of:

	https://www.linux-kvm.org/page/Migration

Didn't work. I tried to use two different QEMU versions to check a
real life case and also to use just one QEMU and trying to load a
virt-9.1 state on a virt-9.2 machine. 

For instance, trying to restore a virt-9.1 state on virt-9.2 gave me
this error:

	(qemu) qemu: Machine type received is 'virt-9.1' and local is 'virt-9.2'
	qemu: load of migration failed: Invalid argument

Yet, running virt-9.1 used the old math code (offsets from hardware_errors firmware
file) while running virt-9.2 executed the new math code using HEST address.

Mauro Carvalho Chehab (5):
  acpi/ghes: add a firmware file with HEST address
  acpi/ghes: Use HEST table offsets when preparing GHES records
  acpi/generic_event_device: Update GHES migration to cover hest addr
  acpi/generic_event_device: add logic to detect if HEST addr is
    available
  arm/virt-acpi-build: Properly handle virt-9.1

 hw/acpi/generic_event_device.c |  30 +++++++++
 hw/acpi/ghes.c                 | 108 ++++++++++++++++++++++++++++++---
 hw/arm/virt-acpi-build.c       |  30 +++++++--
 hw/core/machine.c              |   4 +-
 include/hw/acpi/ghes.h         |   2 +
 5 files changed, 159 insertions(+), 15 deletions(-)

-- 
2.46.1



