Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFCFC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJlt-0001dJ-7Y; Wed, 28 May 2025 12:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJlr-0001dB-A3
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:36:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJlo-0006yf-Q8
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:36:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq4TZ028786;
 Wed, 28 May 2025 16:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=3CjW4ZC7IgcpAD5/1225Un0CjqLxP
 EItLdT1pXc99NE=; b=XcdYP6/YOIX1Y9S0h27lqrV9S7S19up3m9YDXSucLxBF0
 CucnTgFqEfJHJO7eRyUsw00RSg9Vt3xnhMSpvgoW+xK0eqRdDFSc6xgDWqR5rR/6
 qJzAfyWpK7+7xxdsZzlqin11Dv4yEdqFf4e+3GtIzVJRhEJXFUNqDLUFJ9SMF7XZ
 toEL76l/zpL5PKj01KSX2Khlh6j+Z6L3Dr04ckEpbRejlAhMbZ1oPuaqlRzdHWgf
 rFDrBX/b2N/GCN31dWQRGoYYk4X6gyzZgQJMe9cChxiRgECWQgRy1G6FcbeUMFwh
 SKG3RJwBH5TY5Vb5hkKyK0SuWqxeoLEtesXWn8mCg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s69yg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:36:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SGK717027782; Wed, 28 May 2025 16:36:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janjkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:36:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGaYQS006110;
 Wed, 28 May 2025 16:36:34 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janjhs-1; Wed, 28 May 2025 16:36:34 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 00/13] Support ACPI Control Method Sleep button
Date: Wed, 28 May 2025 12:35:45 -0400
Message-ID: <20250528163545.2143-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NCBTYWx0ZWRfX2PjZdU7HhkTe
 LTW/w3JkyfWqMJE9VTAMLtWbKVUtG37o5Qcqr+ZsBUOfKcZhXBX2R5tVsCHuf14pE6VjG/CwhOT
 Yq2xYHm2dtHqf+3Ds5+GyKb53eybkHE4VCwH/Wk1pdw+3y14vF1lqxK0p2uOzzAk/z1/g8IqR21
 rfcYIG5pa2CMvRCbIpB79WJF7zAV6IeAlII1WyTss3kfIapj1MSB4U6S+jyQdii7QBHlYJlBAb8
 03e/UOhmzsRtRDlEx4t+oEhsvVJZEZFJHufq10A+U26NE7M1V6ltMJ0JeDvT2uUrh2nV9qiV7Sa
 T9X3Okim8Z0yPbTuliNWhkEOjNLKIIkZ8G9Xq5ghDAwTWsOyB020E1lssTt49QOjO3tl4nfnou7
 vexKkuJjM0E0D9scvGCfbi0dZTeQg4N1Pfg+EIn7JCqZIgrVEmiYfigiIiwypUnUn5eDCxwm
X-Proofpoint-GUID: Mc_abSRr97VQtEguFpg0x4k1e5NQSq-p
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68373b94 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=blgLcFuWBmpAZbwxDM4A:9
 a=WPp7wK2zvv8A:10
X-Proofpoint-ORIG-GUID: Mc_abSRr97VQtEguFpg0x4k1e5NQSq-p
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The ACPI sleep button can be implemented as a fixed hardware button
or Control Method Sleep button.

The patch of implementing a fixed hardware sleep button was posted
here 1). More discussions can be found here 2). Essentially, the
discussion mainly focuses on whether the sleep button is implemented
as a fixed hardware button or Control Method Sleep button. The latter
benefits various architectures since the code can be shared among
them.

This patch set implements Control Method Sleep button for both x86
and microvm. The RFC V1 patch set was posted previously here 3). We
rebase all the patches on QEMU9.1.0 and re-post RFC V2 here 4). The
RFC V3 patch is based on QEMU 10.0.0-rc3 at 5). This patch set here
is rebased on QEMU 10.0.1. The sleep button support for microvm is
added, however, its support for ARM platform in V2 is removed due to
lower interests of it and more efforts in the firmware.

For x86, a sleep button GPE event handler is implemented, so a GPE
event is triggered to indicate the OSPM the sleep button is pressed.
Tests have been done for Linux guest, and Windows Server guest,
this sleep button works as expected.

For microvm, a GED event is triggered to notify the OSPM. This GED
event is also applicable for ARM platform, as mentioned earlier, the
implementation for ARM platform has been removed since RFC V3 patch
set. Tests have been run for Linux microvm guests.

System_wakeup doesn't work for microvm for now due to the missing
support of it. This patch set only covers system_sleep, not the
wakeup part.


1) https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06478.html
2) https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/#mfe24f89778020deeacfe45083f3eea3cf9f55961
3) https://lore.kernel.org/all/20231205002143.562-1-annie.li@oracle.com/T/
4) https://patchwork.kernel.org/project/qemu-devel/cover/20240927183906.1248-1-annie.li@oracle.com/
5) https://lore.kernel.org/all/20250411201912.2872-1-annie.li@oracle.com/

----Changes from RFC V3----
Improve source code and comment based on comments on RFC V3
---------------------------

Annie Li (12):
  acpi: Implement control method sleep button
  test/acpi: allow DSDT table changes for x86 platform
  acpi: Support Control Method sleep button for x86
  tests/qtest/bios-table-tests: Update ACPI table binaries for x86
  acpi: Send the GPE event of sleep for x86
  test/acpi: allow DSDT table changes for microvm
  microvm: Add ACPI Control Method Sleep Button
  microvm: enable sleep GED event
  tests/qtest/bios-table-tests: Update ACPI table binaries for microvm
  microvm: suspend the system as requested
  microvm: enable suspend
  acpi: hmp/qmp: Add hmp/qmp support for system_sleep

Miguel Luis (1):
  hw/acpi: Add ACPI GED support for the sleep event

 hmp-commands.hx                               |  14 +++++++
 hw/acpi/control_method_device.c               |  38 ++++++++++++++++++
 hw/acpi/core.c                                |  12 ++++++
 hw/acpi/generic_event_device.c                |  12 ++++++
 hw/acpi/meson.build                           |   1 +
 hw/core/machine-hmp-cmds.c                    |   5 +++
 hw/core/machine-qmp-cmds.c                    |  11 +++++
 hw/i386/acpi-build.c                          |  24 ++++++++++-
 hw/i386/acpi-microvm.c                        |  13 +++++-
 hw/i386/microvm.c                             |   4 +-
 include/hw/acpi/acpi.h                        |   1 +
 include/hw/acpi/acpi_dev_interface.h          |   1 +
 include/hw/acpi/control_method_device.h       |  21 ++++++++++
 include/hw/acpi/generic_event_device.h        |   2 +
 include/monitor/hmp.h                         |   1 +
 qapi/machine.json                             |  20 +++++++++
 qapi/pragma.json                              |   1 +
 tests/data/acpi/x86/microvm/DSDT              | Bin 365 -> 442 bytes
 tests/data/acpi/x86/microvm/DSDT.ioapic2      | Bin 365 -> 442 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie         | Bin 3023 -> 3100 bytes
 tests/data/acpi/x86/microvm/DSDT.rtc          | Bin 404 -> 481 bytes
 tests/data/acpi/x86/microvm/DSDT.usb          | Bin 414 -> 491 bytes
 tests/data/acpi/x86/pc/DSDT                   | Bin 8611 -> 8721 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8522 -> 8632 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9936 -> 10046 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15482 -> 15592 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9075 -> 9185 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10265 -> 10375 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8562 -> 8672 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5100 -> 5210 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8683 -> 8793 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9970 -> 10080 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8469 -> 8579 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8617 -> 8727 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12404 -> 12514 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8440 -> 8550 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8457 -> 8567 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9765 -> 9875 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12650 -> 12760 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8719 -> 8829 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8486 -> 8596 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12053 -> 12163 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12998 -> 13108 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33855 -> 33965 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8904 -> 9014 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13231 -> 13341 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10094 -> 10204 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8515 -> 8625 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8528 -> 8638 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8457 -> 8567 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9799 -> 9909 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9570 -> 9680 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13293 -> 13403 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8302 -> 8412 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8298 -> 8408 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8446 -> 8556 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8541 -> 8651 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12998 -> 13108 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33855 -> 33965 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9046 -> 9156 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9072 -> 9182 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18674 -> 18784 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14697 -> 14807 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35803 -> 35913 bytes
 64 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100644 hw/acpi/control_method_device.c
 create mode 100644 include/hw/acpi/control_method_device.h

-- 
2.43.5


