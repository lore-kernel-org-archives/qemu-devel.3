Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20BCC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnOT7-0001UD-OB; Fri, 24 Jul 2026 18:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSk-0001RQ-Sv
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSj-0001Gu-0D
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OJcblm4097294; Fri, 24 Jul 2026 22:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=Ch+k4q9QoNkXN4D0ITIte+8MYyWwc
 GdHpCjNSN+A94g=; b=felCExhUGDEgyymFWn4xvGTtxjZcj1lAatpDxMwPoCWcz
 p54pzaX/lg43LSuDbmaoR7C9CUvgHZWl2/pEaDPvWhhTu8vLokhJ0MZjFO3J1Eqx
 UDSm/Koy+PTserhiNNj59MNxp0zuSbiRQpJEyEEZ5SfKwJT4XsvWXvWe5/RkWbnl
 2kgd1hbTJ13+66OLycq3Bz5IE+WZvIUm+k9XoAdf1g58u6Hzpx9YLNhNBwhFkyOj
 RNIWar/I+bQAz9DE4S4A4m7Belm5GBLc6NgioSk5lNxC1IrbCvYTeOWPhcOoQpQg
 0a4PvIHV4gJIOhvZyoWUs2cti91CvRSopTzxa2Q5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1n3s7hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66OMXYkX028213; Fri, 24 Jul 2026 22:33:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ffyxtq3by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:44 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66OMXiTM029565;
 Fri, 24 Jul 2026 22:33:44 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ffyxtq3a1-1; Fri, 24 Jul 2026 22:33:44 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, joe.jin@oracle.com
Subject: [PATCH v2 0/5] amd_iommu: Bugfix and Cleanup for IO Page Fault
Date: Fri, 24 Jul 2026 15:31:26 -0700
Message-ID: <20260724223216.108667-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607240203
X-Proofpoint-GUID: J39q6FSOijRWIHmnvtat70vRrTFxJ0oz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX8ttvJFOLU4vm
 YkERnjO5mOsfvUrn0TlNQ+Yjac+WUrLvt9eR2hBVjhML2YdKCCQd+/0Z5pLvzLXPqbelsQGELVN
 JMRZWnb2TLothzpG+UeiHzBcmRlFk9aqKjWjf0yqlfDZIgOZehi/
X-Proofpoint-ORIG-GUID: J39q6FSOijRWIHmnvtat70vRrTFxJ0oz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX9dAVeiH9CpVD
 JbPmMOlD58A+7SUUCB7l48Hwy4OXnnX2iueOqb5fD9lWGufToNeFbO5L/fvFPZauaEB38ZJuUsA
 1jSPMbjSBEu2M8EPGsv4VIE8ysuhnA6WJCgtxe++sMP5rxvRW+fk4we5CFNmjwX8NFuGBeIdwUD
 ReMB3axhNM+YxoPrzVxIEg5SsQE4pZhY7c0SCuYE2yP8eCrBHBNHm3efZGE6VLpmwUrRXSXzaix
 cz8BPRU9sq9mNQqutrSUnG2DeeKkye2EOZxv/nFBKmua8misBtVHBcaIU1hz+Dzx+9OxdCOn6VX
 9s+Vtn4SR2tqYqLJ4+Fd7oVe78ERskW8j9NKTKinphJn0gBLamwsYH18akBV3MAdM1wYLXrtvhG
 qnyEOV/Ylxh8tZHux4Dh2ldF4IKK77kjiMjHeTkXvSK6ojGtJuNrwwgQDOy5AGlu5ztnj9qpMqS
 jS3Oy3w15+13Nw1L0e6qNIAka52P9M5ZdfdV41TQ=
X-Authority-Analysis: v=2.4 cv=PryjqQM3 c=1 sm=1 tr=0 ts=6a63e849 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=GzRUGnGu-hvjJYHa8FsA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12114
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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

v1: https://lore.kernel.org/qemu-devel/20260609204403.323149-1-dongli.zhang@oracle.com

v1->v2:
  - Add Fixes tag.
  - Rename amdvi_as_devid() to amdvi_get_as_devid().
  - Cleanup and add macro to avoid hardcoding.
  - Make AMD IOMMU extended feature register read-only.
  - Drop the patch for enabling I/O page fault delivery when xtsup=on.

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
these issues through bugfixes and cleanup.

- Fix duplicate MSI capabilities for the IOMMU PCI device.
- Fix an invalid PCI address reported in I/O page fault events.
- Fix excessive GA log messages causing endless guest dmesg output.

The QEMU test patch I used to inject IOMMU IO page faults has been appended to
the end of this email. To execute "info version" HMP command will be able to
trigger an IO page fault.

The following is the QEMU command line. I have tested these changes with both
7.1 and v6.4 guest kernels. I have also tested with both xtsup=off and
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


Dongli Zhang(5):
  amd_iommu: Do not create duplicate MSI capability
  amd_iommu: Use full BDF when reporting page faults
  amd_iommu: Define MMIO register masks
  amd_iommu: Make extended feature register read-only
  amd_iommu: Do not latch unsupported GA log status bits

 hw/i386/amd_iommu.c | 34 +++++++++++++++++++++-------------
 hw/i386/amd_iommu.h | 25 +++++++++++++++++++++----
 2 files changed, 42 insertions(+), 17 deletions(-)


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


