Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAE0D75E3B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 13:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tETUV-0004YV-RK; Fri, 22 Nov 2024 08:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tETUT-0004Wu-J8; Fri, 22 Nov 2024 08:14:29 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tETUR-0006L3-Qu; Fri, 22 Nov 2024 08:14:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F06D95C5A3D;
 Fri, 22 Nov 2024 13:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E87CC4CEDA;
 Fri, 22 Nov 2024 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732281264;
 bh=W9eH/NjQmQ/fmoOrydtYHGpAJG00A8vG13tZgPQj1LU=;
 h=From:To:Cc:Subject:Date:From;
 b=tc13vhJsp4xUDbgNcsQCLUvvUlh+gvbuVd3zmZ+6oghwyoeCGjRZ4TQ7FXJABqTMU
 n4J0VhdEshh2krzx43z9xMrhdXkhjAdcVSFlnxxnQiwE3qSURwUy6uo4MxboPEEunR
 gQyYsNhUYJEkTWPQ4PO2ngr6KM2fUk9zsmFLV/v7U5qcJvQhTIORTUl/HOcQmaUQ+H
 fM0pmb0Bo6YAwR00ixKz5DbwZtqvHs/w2IVV3FsRYc4LyQ9ZoLBkls0HmDiK65EUDX
 8SBghAxjw0UTF6j6Mq9ZGmYcQDnfNRtCQveGFqnWR/YEBQg3mc2zBdyq5qExu/xnDL
 ul5D/bQk3btDw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tETUL-00000006v9e-4BRt; Fri, 22 Nov 2024 14:14:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] Change ghes driver to use HEST-based offsets
Date: Fri, 22 Nov 2024 14:14:10 +0100
Message-ID: <cover.1732281080.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

This  series was part of the previous PR to add generic error injection
support on GHES. It depends on a cleanup patch series sent earlier
today:

	https://lore.kernel.org/qemu-devel/cover.1732266152.git.mchehab+huawei@kernel.org/T/#t

It contains the changes of the math used to calculate offsets at HEST table 
and hardware_error firmware file. It prepares for the addition of GHES
error injection.

The first patch was previously at the cleanup series. It prepares
the logic to support multiple sources.

The second patch adds a new firmware file to store HEST address.

The third patch use the new firmware to calculate offsets using
HEST table.

Patches 4 and 5 add migration support. They assume that this
series will be merged for qemu 9.2 (maybe it is too late for that,
as QEMU is now on soft freeze). 

I tested migration using both virt-9.1 and virt-9.2 machines
on qemu 9.2.

I also tested migration with:

	qemu-9.1 -M virt-9.1 -cpu cortex-a57 => qemu-9.2 -M virt-9.1 -cpu cortex-a57
	qemu-9.2 -M virt-9.1 -cpu cortex-a57 => qemu-9.1 -M virt-9.1 -cpu cortex-a57

---

v2:
  - some whitespace and comment changes
  - patch 3/6 (acpi/ghes: rename the function which gets hw error offsets)
    was merged on the cleanup series.

Mauro Carvalho Chehab (5):
  acpi/ghes: Prepare to support multiple sources on ghes
  acpi/ghes: add a firmware file with HEST address
  acpi/ghes: Use HEST table offsets when preparing GHES records
  acpi/generic_event_device: Update GHES migration to cover hest addr
  acpi/generic_event_device: add logic to detect if HEST addr is
    available

 hw/acpi/generic_event_device.c |  30 +++++++
 hw/acpi/ghes.c                 | 156 +++++++++++++++++++++++++++++----
 hw/arm/virt-acpi-build.c       |  33 ++++++-
 hw/core/machine.c              |   2 +
 include/hw/acpi/ghes.h         |  23 +++--
 5 files changed, 216 insertions(+), 28 deletions(-)

-- 
2.47.0



