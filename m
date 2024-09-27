Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DF0CDD1D3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFsi-0006UJ-PC; Fri, 27 Sep 2024 14:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsg-0006Jr-2k; Fri, 27 Sep 2024 14:39:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsd-00023L-Sy; Fri, 27 Sep 2024 14:39:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHMYSn018961;
 Fri, 27 Sep 2024 18:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:reply-to:mime-version
 :content-transfer-encoding; s=corp-2023-11-20; bh=xzUGtAdgxkNul6
 OaJBZ5qH9GhwfsHkG4fW8fJ8LxdbA=; b=UxqcE0i0FSmpvQiF2h2y0BVbVVZ/Cs
 wO4otFEpQyk2Kaqm1P46ay2klk0fIFh4MS1mLDAXELovB7GmoSttKO8H9uehGgZ/
 gwsoUdjX1MFt3nPvpJtNcpAyHoxjkkU86aRjKXOG9y3KdPgbKbofFxb5oFNVh1nf
 Olyha9g0URA44691UFtwQ2PI6cNCgmMN55sb63MHEZbhgSLpdDiV+Y3BUBQY1G50
 tAcYKw6DnFu96Qe2ucPTimufJW9xS60BpDPm7rWDF56fDr/PZhjVQb+PH18v/JKD
 h3i0O1woPA8njmxPQTY7NJBKg8Xgj7js06/19bY3zFy9dkFiH4nUBZ3Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr1gh6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48RHrdwV032809; Fri, 27 Sep 2024 18:39:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkm8fgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:19 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RIdIoT009004;
 Fri, 27 Sep 2024 18:39:18 GMT
Received: from localhost.localdomain (dhcp-10-175-14-34.vpn.oracle.com
 [10.175.14.34])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 41smkm8ff6-1; Fri, 27 Sep 2024 18:39:18 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com,
 annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V2 PATCH 00/11] Support ACPI Control Method Sleep button
Date: Fri, 27 Sep 2024 14:38:55 -0400
Message-ID: <20240927183906.1248-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270135
X-Proofpoint-ORIG-GUID: 5DoZ81OIzEPzTofC9vi9E3wYjyzrbORz
X-Proofpoint-GUID: 5DoZ81OIzEPzTofC9vi9E3wYjyzrbORz
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: miguel.luis@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ACPI sleep button can be implemented as a fixed hardware button
or Control Method Sleep button.

The patch of implementing a fixed hardware sleep button was posted
here 1). More discussions can be found here 2). Essentially, the
discussion mainly focuses on whether the sleep button is implemented
as a fixed hardware button or Control Method Sleep button. The latter
benefits various architectures since the code can be shared among
them.

This patch set implements Control Method Sleep button for both x86
and ARM platform.(The patch set was posted previously here 3). We
rebase all the patches on QEMU9.1.0 and re-post it).

For x86, a sleep button GPE event handler is implemented, so a GPE
event is triggered to indicate the OSPM the sleep button is pressed.
Tests have been done for Linux guest, and Windows Server guest,
the sleep button works as expected.

For ARM, a GED event is triggered to notify the OSPM. With proper
debug knobs it is possible to see the guest OSPM acknowledges the
sleep event:

(qemu) system_sleep
(qemu) [6.744138] exregion-0179 ex_system_memory_space: System-Memory (width 32) R/W 0 Address=0000000009080000
[6.746003] evmisc-0132 ev_queue_notify_reques: Dispatching Notify on [SLPB] (Device) Value 0x80 (Status Change) Node 00000000f0e6819e
[6.802873] PM: suspend entry (s2idle)
[6.806201] Filesystems sync: 0.002 seconds
[6.807580] Freezing user space processes
[6.809478] Freezing user space processes completed (elapsed 0.001 seconds)
[6.810602] OOM killer disabled.
[6.811111] Freezing remaining freezable tasks
[6.812953] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[6.814126] printk: Suspending console(s) (use no_console_suspend to debug)

But that seems to be all, depicting that sleep/wakeup for ARM is broken
and there are still missing some pieces of the puzzle.

Nonetheless, we would like to take this RFC as an opportunity for updates
on this subject as possible roadmaps.

1) https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06478.html
2) https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/#mfe24f89778020deeacfe45083f3eea3cf9f55961
3) https://lore.kernel.org/all/20231205002143.562-1-annie.li@oracle.com/T/


Annie Li (6):
  acpi: hmp/qmp: Add hmp/qmp support for system_sleep
  acpi: Implement control method sleep button
  test/acpi: allow DSDT table changes
  acpi: Support Control Method sleep button for x86
  tests/acpi: Update DSDT tables for Control method sleep button
  acpi: Send the GPE event of suspend and wakeup for x86

Miguel Luis (5):
  hw/acpi: Add ACPI GED support for the sleep event
  tests/acpi: allow FACP and DSDT table changes for arm/virt
  hw/arm: enable sleep support for arm/virt
  tests/acpi: Update FACP and DSDT tables for sleep button
  arm/virt: enable sleep support

 hmp-commands.hx                               |  14 +++++
 hw/acpi/control_method_device.c               |  54 ++++++++++++++++++
 hw/acpi/core.c                                |  17 ++++--
 hw/acpi/generic_event_device.c                |   9 +++
 hw/acpi/meson.build                           |   1 +
 hw/arm/virt-acpi-build.c                      |  13 +++++
 hw/arm/virt.c                                 |  14 ++++-
 hw/core/machine-hmp-cmds.c                    |   5 ++
 hw/core/machine-qmp-cmds.c                    |  11 ++++
 hw/i386/acpi-build.c                          |   9 +++
 include/hw/acpi/acpi.h                        |   1 +
 include/hw/acpi/acpi_dev_interface.h          |   1 +
 include/hw/acpi/control_method_device.h       |  25 ++++++++
 include/hw/acpi/generic_event_device.h        |   1 +
 include/hw/arm/virt.h                         |   1 +
 include/monitor/hmp.h                         |   1 +
 qapi/machine.json                             |  18 ++++++
 qapi/pragma.json                              |   1 +
 tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5278 bytes
 .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5364 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6639 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7761 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5480 bytes
 tests/data/acpi/aarch64/virt/FACP             | Bin 276 -> 276 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 6830 -> 7012 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 6741 -> 6923 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 8155 -> 8337 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 13701 -> 13883 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 7294 -> 7476 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 8484 -> 8666 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 6781 -> 6963 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 3337 -> 3519 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 6902 -> 7084 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 8189 -> 8371 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 6688 -> 6870 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 6836 -> 7018 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 10623 -> 10805 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8537 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8554 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9862 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8816 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8583 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 12150 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 13095 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33952 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 9001 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 9714 -> 9896 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10191 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8612 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8625 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8554 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9896 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9667 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13390 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8235 -> 8417 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8395 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8543 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8638 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 13095 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33952 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 9143 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9169 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18771 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 9464 -> 9646 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35900 bytes
 65 files changed, 191 insertions(+), 5 deletions(-)
 create mode 100644 hw/acpi/control_method_device.c
 create mode 100644 include/hw/acpi/control_method_device.h

-- 
2.43.5


