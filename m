Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5077AC3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49BC-0007O4-Tf; Sun, 13 Apr 2025 22:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Av-0007Jg-DB
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49As-0007RK-Sk
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1q7Za029268;
 Mon, 14 Apr 2025 02:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2023-11-20; bh=KBBAx2IvEvRfFkCZN5EI9RMAxo7g0
 iZxBHXJn4VWgb0=; b=e0Kbi4VlMK0O0Ybmgxq7kamLjgm9WEFOfm6SJUGs/k/IL
 XGFqohFAoJL9QtKBl8ZF42J7b9zrFDGoVUh2row02zDMtIM2hRiUR48dECcAuuUp
 mIxrA8P9bdcO82wP97WP51WvSh6XtEdc5OxhGOO/9T9DXLtuHT99L2kqcrXxXmHE
 GQhikQL46WrbZDeI1KfBbHBvy5A1BnMMf85wceliISROpAS3fRlcDjbe6i9wcGvs
 pW+jMWvMSF4U8CIYkUJwwEZfC0DwnVouaCOK4I+FF7eUhXJfyf0sxkosaJ0FqE6X
 twUCwm24qnV52qWFL6Jg6PA4BqUmB4DmIVdtsZfOQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s2u0079-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DMMsqE009161; Mon, 14 Apr 2025 02:03:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:02:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYM035550;
 Mon, 14 Apr 2025 02:02:55 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-1; Mon, 14 Apr 2025 02:02:55 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 00/18] AMD vIOMMU: DMA remapping support for VFIO devices
Date: Mon, 14 Apr 2025 02:02:35 +0000
Message-ID: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_12,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140014
X-Proofpoint-GUID: B6TJhjKSt0AYtAvRvLxNqzq4AkeR5OZy
X-Proofpoint-ORIG-GUID: B6TJhjKSt0AYtAvRvLxNqzq4AkeR5OZy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.266,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds support for guests using the AMD vIOMMU to enable DMA
remapping for VFIO devices. In addition to the currently supported
passthrough (PT) mode, guest kernels are now able to to provide DMA
address translation and access permission checking to VFs attached to
paging domains, using the AMD v1 I/O page table format.

These changes provide the essential emulation required to boot and
support regular operation for a Linux guest enabling DMA remapping e.g.
via kernel parameters "iommu=nopt" or "iommu.passthrough=0".

A new amd-iommu device property "dma-remap" (default: off) is introduced
to control whether the feature is available. See below for a full
example of QEMU cmdline parameters used in testing.

The patchset has been tested on an AMD EPYC Genoa host, with Linux 6.14
host and guest kernels, launching guests with up to 256 vCPUs, 512G
memory, and 16 CX6 VFs. Testing with IOMMU x2apic support enabled (i.e.
xtsup=on) requires fix:
https://lore.kernel.org/all/20250410064447.29583-3-sarunkod@amd.com/

Although there is more work to do, I am sending this series as a patch
and not an RFC since it provides a working implementation of the
feature. With this basic infrastructure in place it becomes easier to
add/verify enhancements and new functionality. Here are some items I am
working to address in follow up patches:

- Page Fault and error reporting
- Add QEMU tracing and tests
- Provide control over VA Size advertised to guests
- Support hotplug/unplug of devices and other advanced features
  (suggestions welcomed)

Thank you,
Alejandro

---
Example QEMU command line:

$QEMU \
-nodefaults \
-snapshot \
-no-user-config \
-display none \
-serial mon:stdio -nographic \
-machine q35,accel=kvm,kernel_irqchip=split \
-cpu host,+topoext,+x2apic,-svm,-vmx,-kvm-msi-ext-dest-id \
-smp 32 \
-m 128G \
-kernel $KERNEL \
-initrd $INITRD \
-append "console=tty0 console=ttyS0 root=/dev/mapper/ol-root ro rd.lvm.lv=ol/root rd.lvm.lv=ol/swap iommu.passthrough=0" \
-device amd-iommu,intremap=on,xtsup=on,dma-remap=on \
-blockdev node-name=drive0,driver=qcow2,file.driver=file,file.filename=./OracleLinux-uefi-x86_64.qcow2 \
-device virtio-blk-pci,drive=drive0,id=virtio-disk0 \
-drive if=pflash,format=raw,unit=0,file=/usr/share/edk2/ovmf/OVMF_CODE.fd,readonly=on \
-drive if=pflash,format=raw,unit=1,file=./OVMF_VARS.fd \
-device vfio-pci,host=0000:a1:00.1,id=net0
---

Alejandro Jimenez (18):
  memory: Adjust event ranges to fit within notifier boundaries
  amd_iommu: Add helper function to extract the DTE
  amd_iommu: Add support for IOMMU notifier
  amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
  amd_iommu: Toggle memory regions based on address translation mode
  amd_iommu: Set all address spaces to default translation mode on reset
  amd_iommu: Return an error when unable to read PTE from guest memory
  amd_iommu: Helper to decode size of page invalidation command
  amd_iommu: Add helpers to walk AMD v1 Page Table format
  amd_iommu: Add a page walker to sync shadow page tables on
    invalidation
  amd_iommu: Sync shadow page tables on page invalidation
  amd_iommu: Add replay callback
  amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
  amd_iommu: Toggle address translation on device table entry
    invalidation
  amd_iommu: Use iova_tree records to determine large page size on UNMAP
  amd_iommu: Do not assume passthrough translation when DTE[TV]=0
  amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
  amd_iommu: Do not emit I/O page fault events during replay()

 hw/i386/amd_iommu.c | 856 ++++++++++++++++++++++++++++++++++++++++----
 hw/i386/amd_iommu.h |  52 +++
 system/memory.c     |  10 +-
 3 files changed, 843 insertions(+), 75 deletions(-)


base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
-- 
2.43.5


