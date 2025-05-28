Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E8C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKER7-0004wJ-1x; Wed, 28 May 2025 06:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uKER5-0004vi-QL; Wed, 28 May 2025 06:55:03 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uKER3-0007Vf-BB; Wed, 28 May 2025 06:55:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748429663; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZwHz5lyPDh4MUsjQ5T/Z6yN9e/F80OtcI/M37hmVZVTdED4ArCbjCtLyzs4diiev+htM548I/irzXPNifCNPCdlpZursZvWZ+2eiOt06M5LghL8jgdmk3FFCw4+xvsfWOwqVZ4ni8N3UUtVz5jRja2AI/eEkLHqfOIrnW5KgGIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748429663;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gwCPySt0IyfsqMjjC6iwkB2hIy/Rl4ePvEgjnOwd91Y=; 
 b=Oti+fbXj8WTrGL8OcwOb65reajJbs/oZu3b1ot2vv1MHtOO38wtg1kCgV+7KAFBtKqfv7tCPb6RnJBtcmF6hHXYnzTqPHSLzQqMh1ac+oB0AsHSA+fw6wxKUGlcYogeSOCOykGea3toVxVQg5iyXL/bDpcVjNeUODEpcMIZUnUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748429663; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=gwCPySt0IyfsqMjjC6iwkB2hIy/Rl4ePvEgjnOwd91Y=;
 b=MgPD0ZDF0mjvaikHnp2acvjiA7wRzagpmqJeq1FAUNzWaZ+zG/UduE32/9TpNEOX
 MTraYpwcsd1rVwi1nZ0qlamuZTEmfAmbd0npnmr/fdEDJ6Q1NrXWheEgeKXMX/0FN80
 vfu9mHfoxjDPc1CdOqV5TnbNgKDwnip7cuIg55Ss=
Received: by mx.zohomail.com with SMTPS id 174842966156039.664211631292574;
 Wed, 28 May 2025 03:54:21 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Song Gao" <gaosong@loongson.cn>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Cc: Li Chen <chenl311@chinatelecom.cn>
Subject: [PATCH REPOST v4 0/4] acpi: Add machine option to disable SPCR table
Date: Wed, 28 May 2025 18:53:34 +0800
Message-ID: <20250528105404.457729-1-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Chen <chenl311@chinatelecom.cn>

(REPOST because the previous post failed to send to qemu-devel/qemu-riscv/qemu-arm,
 see https://lore.kernel.org/qemu-devel/1971648603b.dce1f5d22901195.6702025346547333607@linux.beauty/T/#u)

This series introduces a new machine option, spcr=on|off, allowing users
to disable the ACPI SPCR (Serial Port Console Redirection) table.
By default, SPCR is enabled. Disabling it can help ensure that the guest's
console behavior is determined solely by kernel command-line parameters
on arch like arm64, avoiding unintended serial console configurations imposed
by firmware.

Also add tests on AArch64 and RISC-V virt machines using TCG and UEFI boot.

Changes since v3:
- Add Reviewed-by from Sunil V L <sunilvl@ventanamicro.com> for patch 1, 3, and 4.
- rename enable_spcr to acpi_spcr_enabled as suggested by Philippe Mathieu-Daudé.
Changes since v2:
- Omit UART device from DSDT and SPCR construction if no serial device is present,
as suggested by Philippe Mathieu-Daudé.
- Add Reviewed-by from Gavin Shan <gshan@redhat.com> for the first patch and fix style issue.

Changes since v1:
- Add bios-tables-test for RISC-V and ARM as suggested by
- Add Acked-by from Michael S. Tsirkin for the first patch
- Add Reviewed-by from Bibo Mao for the first patch

Li Chen (4):
  acpi: Add machine option to disable SPCR table
  tests/qtest/bios-tables-test: Add test for disabling SPCR on AArch64
  tests/qtest/bios-tables-test: Add test for disabling SPCR on RISC-V
  acpi/virt: suppress UART device & SPCR when guest has no serial
    hardware

 hw/arm/virt-acpi-build.c       | 18 ++++++++-----
 hw/core/machine.c              | 22 ++++++++++++++++
 hw/loongarch/virt-acpi-build.c |  4 ++-
 hw/riscv/virt-acpi-build.c     | 10 ++++++--
 include/hw/boards.h            |  1 +
 include/system/system.h        |  2 ++
 qemu-options.hx                |  5 ++++
 system/vl.c                    |  5 ++++
 tests/qtest/bios-tables-test.c | 47 ++++++++++++++++++++++++++++++++--
 9 files changed, 103 insertions(+), 11 deletions(-)

-- 
2.49.0


