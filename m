Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACBCCD98C8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX3PG-0008NE-3b; Tue, 09 Jun 2026 16:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PD-0008MZ-V7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wX3PB-0000MC-Kq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 16:50:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659KBbLe3175885; Tue, 9 Jun 2026 20:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=CklL3v5d9kUjiX0D4oTI4kgk+yUmR
 WnGk4cLK7Iket8=; b=biXeTXeNY+sD5Xo1hXD6C4KxQzoiSsAzz6m8JHA4r7YrU
 sqg6llbMf2iDXEdQvzFNGv0cTHTdz4jiPA3cnEH/Ctjnbx5Pi/hRsitHxryPLu1C
 70PVBWN9wSjwSp2shkuSW5nuDv3guHHtPUKrdDoHawDihZRMevOcxveIILpwhbkm
 LzC1aVHmbWHWweQ98jmMICv1IiWpf4yFHAAfIrYZnTfXZqmMDX5Yj8BY3lhLTxTx
 H6sC/5yA4SlWwiP03uWjxAvfPIMfdHKFWfuoNSqGE0KHhZjzmqoY1rOwzhMfFEaO
 vsKE29w/zN4zevOGuS8FI01+m1MvoP1aUf/EgDdrA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4embe7n8du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 659KmUgw023039; Tue, 9 Jun 2026 20:50:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ema0qn7kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jun 2026 20:50:29 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 659KoTpH030607;
 Tue, 9 Jun 2026 20:50:29 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ema0qn7ju-1; Tue, 09 Jun 2026 20:50:29 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com
Subject: [PATCH 0/4] amd_iommu: Bugfix and Enhancement for IO Page Fault
Date: Tue,  9 Jun 2026 13:43:31 -0700
Message-ID: <20260609204403.323149-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606090195
X-Proofpoint-ORIG-GUID: Ett7OHE20sfKnsFFxhQsMWRjGxA4LYo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE5NSBTYWx0ZWRfX33PSYc6oDeKC
 iYEEINgQG8GP750TlrZwCRpamrpWGBqvPb9qS7V6lyo/w74V3vBv5Bon/CK6RZjUiMsJEArz6xt
 322rWrjd4hnKju3GmIdPIJ6dJGa9M7WekqYfIAVEO2AeL+5vMACOteQ6P8ELLdLh/X8sexfmMEx
 OSMcObYju6XvYeU+D5JVFFGBu9OgCEpPZ2xlt+aQk5USv8Guslj7kJOzTR8yz7zzvu70bfzVdRf
 HeCBQecv504PDi2MajnCFNSbrzu9Txw7+tSeyOtu6+pTzIz9b+IgjPMvFWiPBrgP0Vbiq7L3reP
 Q1/uSuvyXsXnvLI1hTwhxv6pps+JFds6nLPI5gtkOYbazR2aEqJJxeNkHUpran4n9TXcTsjneNB
 4kGdxYkAmLumfxzGH6hCCebmYqfJpAFylBGnJYULurbv4tAvP0SCfv1KFS6XNnYPq6yIFVveo3X
 aD7+IthBffCeWBM7cjK43YifKijJ7H/+/zvSErHo=
X-Proofpoint-GUID: Ett7OHE20sfKnsFFxhQsMWRjGxA4LYo9
X-Authority-Analysis: v=2.4 cv=AufeGu9P c=1 sm=1 tr=0 ts=6a287c97 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=esykdSN39bcNuQQq7WMA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Recently, I tried using QEMU IOMMU emulation to study PCI device IOMMU page
faults.

It works well with intel-iommu.

[   28.819456] DMAR: DRHD: handling fault status reg 2
[   28.820403] DMAR: [DMA Write NO_PASID] Request device [01:00.0] fault addr 0xc0000000 [fault reason 0x05] PTE Write access is not set
[   28.822325] DMAR: Dump dmar0 table entries for IOVA 0xc0000000
[   28.823289] DMAR: root entry: 0x00000001014ef001
[   28.823291] DMAR: context entry: hi 0x0000000000000602, low 0x00000001014ee001
[   28.825266] DMAR: pte level: 4, pte value: 0x000000010208f403
[   28.826211] DMAR: pte level: 3, pte value: 0x00000001020c8403
[   28.827158] DMAR: pte level: 2, pte value: 0x0000000000000000
[   28.828109] DMAR: page table not present at level 1

However, there are some issues with amd-iommu. This patchset aims to address
these issues through bugfixes and enhancements.

- Fix duplicate MSI capabilities for the IOMMU PCI device.
- Fix an invalid PCI address reported in I/O page fault events.
- Fix excessive GA log messages causing endless guest dmesg output.
- Enable I/O page fault delivery when xtsup=on.


The QEMU test patch I used to inject IOMMU IO page faults has been appended to
the end of this email. To execute "info version" HMP command will be able to
trigger an IO page fault.

The following is the QEMU command line. I have tested these changes with both
7.0 and v6.4 guest kernels. I have also tested with both xtsup=off and
xtsup=on.

qemu-system-x86_64 \
-machine q35,accel=kvm,kernel-irqchip=split \
-smp 4 -m 8G \
-cpu host \
-hda ol94.qcow2 \
-device pcie-root-port,io-reserve=0,pref64-reserve=32M,bus=pcie.0,chassis=40,id=pcie-root-port.1,addr=05.00,multifunction=on \
-device virtio-net-pci,netdev=tapnet,bus=pcie-root-port.1,mq=true,vectors=9,mac=52:54:11:22:14:47,disable-legacy=on,iommu_platform=true,packed=true \
-netdev tap,id=tapnet,script=qemu-ifup,downscript=no,queues=4,vhost=off \
-monitor stdio -vnc :18 \
-device amd-iommu,dma-remap=true,xtsup=off \
-kernel mainline-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda1 init=/sbin/init text loglevel=7 console=ttyS0 clocksource=tsc iommu=force iommu.passthrough=0 amd_iommu=force_isolation iommu.strict=1"


Dongli Zhang(4):
  amd_iommu: Do not create duplicate MSI capability
  amd_iommu: Use full BDF when reporting page faults
  amd_iommu: Do not latch unsupported GA log status bits
  amd_iommu: Use INTCAPXT for IOMMU event interrupts

 hw/i386/amd_iommu.c | 74 +++++++++++++++++++++++++++++++++++++-----------
 hw/i386/amd_iommu.h |  4 +++
 2 files changed, 62 insertions(+), 16 deletions(-)


Here is the QEMU test patch to inject IO page fault.

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 63e2faee99..9de0f302d7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1877,6 +1877,8 @@ err_undo_map:
     goto done;
 }

+bool testsys_debug = false;
+
 static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
 {
     unsigned int i, max;
@@ -1951,6 +1953,13 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     do {
         bool map_ok;

+        if (testsys_debug && (desc.addr & 0xff000000) == 0xff000000) {
+            testsys_debug = false;
+            printf("fault: virtqueue_packed_pop() desc.addr=0x%lx\n", desc.addr);
+            desc.addr = 0xc0000000;
+            desc.len = 1;
+        }
+
         if (desc.flags & VRING_DESC_F_WRITE) {
             map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
                                         iov + out_num,
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 443b8c785d..c42004d39b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -114,6 +114,8 @@ void hmp_info_name(Monitor *mon, const QDict *qdict)
     qapi_free_NameInfo(info);
 }

+extern bool testsys_debug;
+
 void hmp_info_version(Monitor *mon, const QDict *qdict)
 {
     VersionInfo *info;
@@ -125,6 +127,9 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
                    info->package);

     qapi_free_VersionInfo(info);
+
+    printf("fault: enable one-time debug\n");
+    testsys_debug = true;
 }

 void hmp_quit(Monitor *mon, const QDict *qdict)


Thank you very much!

Dongli Zhang


