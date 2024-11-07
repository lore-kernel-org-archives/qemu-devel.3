Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833AFD43352
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91j7-0003jt-NY; Thu, 07 Nov 2024 07:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t91j5-0003jj-NS
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:35:03 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1t91j2-0001I7-E4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:35:02 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkhLW1p9Kz6K5kJ;
 Thu,  7 Nov 2024 20:33:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 698AF1403A2;
 Thu,  7 Nov 2024 20:34:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 13:34:47 +0100
To: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>
Subject: [PATCH 0/5] hw/acpi: Fixes + tests for ACPI Generic Port Affinity
 Struturs
Date: Thu, 7 Nov 2024 12:34:41 +0000
Message-ID: <20241107123446.902801-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

A couple of issues have been reported on this code that has been merged
for 9.2.

A) Missed a version number update in the qapi/qom.json docs when rebasing
   for 9.2.
B) A test failure on i686 (32bit) bios tables test for x86_64.

This second one was a refactoring mistake where visibility of the size
of an array of 8 characters had been replaced with a pointer which on 64
bit hosts is also 8 bytes, but not on 32 bits, leading to a miss-alignment
of the final structure in the table and a test failure. Fix by hard coding
the size as 8 given it is always this size for the relevant ACPI HIDs.

For completeness the tests are also included. Some reference tables
needed an update to incorporate other changes.

Jonathan Cameron (5):
  hw/acpi: Fix size of HID in build_append_srat_acpi_device_handle()
  qapi/qom: Change Since entry for AcpiGenericPortProperties to 9.2
  bios-tables-test: Allow for new acpihmat-generic-x test data.
  bios-tables-test: Add complex SRAT / HMAT test for GI GP
  bios-tables-test: Add data for complex numa test (GI, GP etc)

 qapi/qom.json                                 |   2 +-
 hw/acpi/aml-build.c                           |   2 +-
 tests/qtest/bios-tables-test.c                |  97 ++++++++++++++++++
 .../data/acpi/x86/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
 .../data/acpi/x86/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 0 -> 12599 bytes
 .../data/acpi/x86/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
 .../data/acpi/x86/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
 8 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x

-- 
2.43.0


