Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7391AC5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 01:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyJMW-0001Oh-Ks; Sun, 23 Aug 2026 21:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMO-0001Hl-8k; Sun, 23 Aug 2026 21:20:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMG-0003Tg-Pp; Sun, 23 Aug 2026 21:20:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67NNp0ps4046632; Mon, 24 Aug 2026 01:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=47lJmUqdv0eBZXC4QoeOtUFhB877q
 P3XUHgjRFnI1cE=; b=V9brxdzYqf9FuhxInQiANy4S+nNJs0abuLiAncz75vGiS
 fEFLGOcWiXZrOlQyAl5v//Ch77VGQDwngnxXgSqHYniJJLIFfMRRy3i7A7nGetXf
 lQodCD7eSAYPW/kjGRLyiJM6FkeXuLuNVYURsc4rps5dU/KZpfUKneukljI9PtPL
 lQ1udgjEGgrHPOtFwV+B2/tiztJSKOtt+r/jXzekkSpWbsJxnIsYO38Xotd5mier
 vh49zeuBUon9cmBlaZZPbRADDa3995yM+hz+78mika5nw2Qc0ou1fAwJw6ucFjPP
 wcQLzp1zQZJcbhlneyeMy5pxyLur3ZktvQcfWAaeA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72by1cvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:19:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67O1FTpG013204; Mon, 24 Aug 2026 01:19:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84kh6xhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:19:48 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1JmVp024683;
 Mon, 24 Aug 2026 01:19:48 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4g84kh6xgy-1; Mon, 24 Aug 2026 01:19:47 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, mjrosato@linux.ibm.com,
 alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, joe.jin@oracle.com
Subject: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe native
 hot-unplug
Date: Sun, 23 Aug 2026 18:13:30 -0700
Message-ID: <20260824011420.752806-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=904 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608240009
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfX3BF2TB91yoxr
 J4S8XZdgPFf9o24g9LQzGnntjof/oDB/7xKrKOlQ4S6p8Znos6VamXoOeTjImw+KOkSntrkBO3L
 V7B43TV4RNO0beNfNjKnSzpHEVUg6F5GgdsmkrhyTDAT7omFFEf5oKZC+rVNjL/3H0fl0zZ+jo6
 c4FjufpmUrDCx0twHW0VxntMzS0lDSOKjBrRAuyK9gRvmlJJPzHci3vnbrCVSjM744/aBMCrekv
 C+TOfcpl2eFbJICIsjNGyVlO/YE430FWCBh5lM47cYUUo5HGdzyCFe2bpZ/nmMN8+i7USfIbtdJ
 9ddUY68T4GfjERKl7CkFUx7SqIYBpIzPQWPKApZ2bbLI5Ns2f71C8uSXbwpkQ1U+AFSlmnQwNLQ
 XiAU1VLcO9aj+r2/67qtRqMYLkaTPIAadcJ3e8Whj46Krz7YNCdZnCHx/3LQkX1QIpBGnH9Cryq
 LK30Cq6M5p9LqXahnrkaIuPhfKRT1+xqVow1XT/4=
X-Proofpoint-GUID: kXNlk9faoRWpNtS_08ftUnZQijJ94D1Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfX1Ad5XuEgQrKe
 wbBpPbFVxeMEar49WkGuCY0fGdIwGy8qO8VFQ4HFr3CL//K+Wfgk0XypouAesePDkd+1BM6iTCK
 XDOuSWlSbVu4OujNRbFAWa0z9kS/sZ0mno3sk0q9Wx5vhIET7vKW
X-Authority-Analysis: v=2.4 cv=fqTsol4f c=1 sm=1 tr=0 ts=6a8b9c36 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=p0WdMEafAAAA:8 a=bvKi9n43um0Dy7nFDjwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: kXNlk9faoRWpNtS_08ftUnZQijJ94D1Q
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hot-unplugging a PCI device can require cooperation from the guest. For
ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
eventually writes the ACPI PCI eject register. For PCIe native hotplug,
QEMU notifies the guest through the PCIe hotplug mechanism and waits for
the slot unplug flow to complete. Only after that completion does QEMU
unrealize the device and emit DEVICE_DELETED.

This can leave a device stuck in the unplug pending state when the guest
does not cooperate. Examples include:

1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
unavailable.

2. The guest is stalled and cannot handle the hot-unplug event. For
example, stalling the Linux [irq/9-acpi] kernel thread can reproduce this
for ACPI-based hot-unplug.

3. The device was attached to a slot that the guest cannot use. For
example, a pcie-root-port only supports slot 0. If a device is added to a
non-zero slot below a pcie-root-port, the guest may never discover the
device and therefore may never complete the unplug request.

The non-zero slot case has also been discussed in:

hw/pci: warn when PCIe device is plugged into non-zero slot of downstream port
https://gitlab.com/qemu-project/qemu/-/commit/ca92eb5defcf9d1c2106341744a73a03cf26e824

hw/pci: add comment to explain checking for available function 0 in pci hotplug
https://gitlab.com/qemu-project/qemu/-/commit/67d045a0ef5b9c5f871c3a1d87325a8a42d2b9d5

pci: don't skip function 0 occupancy verification for devfn auto assign
https://gitlab.com/qemu-project/qemu/-/commit/e228d62b4af29bca698ec57efdceb46f392f5444

For example, if root-port.1 is a pcie-root-port, the following command adds
a vhost-scsi-pci device to an invalid slot:

(qemu) device_add vhost-scsi-pci,id=scsi01,wwpn=naa.5001405324af0985,bus=root-port.1,addr=01.0
warning: PCI: slot 1 is not valid for vhost-scsi-pci, parent device only allows plugging into slot 0.

In this situation, the device may be impossible to remove through normal
guest-cooperative hot-unplug. Production environments also need a host side
recovery option when the guest kernel is the reason that unplug does not
complete.

This series adds a force option to QMP device_del and HMP device_del. When
requested, QEMU asks the selected hotplug controller to complete the unplug
through a new force_unplug callback.

This series implements forced unplug for ACPI PCI hotplug and PCIe native
hotplug, which cover common pc/q35/virt cases. SHPC is not implemented by
this series.


Dongli Zhang (8):
  qdev: Add force argument to qdev_unplug
  qdev: hotplug: Add force_unplug handler callback
  qdev: Support forced device_del in QMP and HMP
  hw/acpi/pcihp: acpi/pcihp: Add forced slot unplug helper
  hw/acpi/piix4: Support forced PCI unplug
  hw/acpi/ich9: Support forced PCI unplug
  hw/acpi/ged: Support forced PCI unplug
  hw/pci/pcie: Support forced PCIe native unplug

 hmp-commands.hx                 | 11 ++++++-----
 hw/acpi/acpi-pci-hotplug-stub.c |  6 ++++++
 hw/acpi/generic_event_device.c  | 15 +++++++++++++++
 hw/acpi/ich9.c                  | 15 +++++++++++++++
 hw/acpi/pcihp.c                 | 17 +++++++++++++++++
 hw/acpi/piix4.c                 | 15 +++++++++++++++
 hw/core/hotplug.c               | 11 +++++++++++
 hw/isa/lpc_ich9.c               |  1 +
 hw/pci/pcie.c                   | 20 ++++++++++++++++++++
 hw/pci/pcie_port.c              |  1 +
 hw/s390x/s390-pci-bus.c         |  4 ++--
 hw/vfio/ap.c                    |  2 +-
 hw/vfio/ccw.c                   |  2 +-
 hw/vfio/pci.c                   |  2 +-
 hw/xen/xen-legacy-backend.c     |  2 +-
 hw/xen/xen_pvdev.c              |  2 +-
 include/hw/acpi/ich9.h          |  2 ++
 include/hw/acpi/pcihp.h         |  3 +++
 include/hw/core/hotplug.h       | 12 ++++++++++++
 include/hw/core/qdev.h          |  2 +-
 include/hw/pci/pcie.h           |  2 ++
 qapi/qdev.json                  | 11 +++++++++--
 system/qdev-monitor.c           | 23 +++++++++++++++++------
 23 files changed, 160 insertions(+), 21 deletions(-)

base-commit: eea8fe61b8be8f3016e522e6af24924a0266ca95

Thank you very much!

Dongli Zhang


