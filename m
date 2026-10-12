Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9273CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPuH-0005lq-9d; Mon, 12 Oct 2026 19:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPuF-0005lC-9Y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPuD-0006Hr-HC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:58:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMghBa2853719; Mon, 12 Oct 2026 23:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=WCn/R
 SrMDfAIeAJsRlEMEo+1DhJjBmQay3HorwQCKMI=; b=nj6fMOmjTW6O22n4BOseB
 MtkPpJOKGEo40IH4YsVyoU47JIjmS1meVHIbNKyZtF5fSkbpJxT07yMzIZIdWbYj
 TbTXmDllELEs/Ou/eR5+UUiB3xoFaYAocQ5mo37r2sh06I2GIFZ5TrebuuOZ6swW
 8NxhBYAoyt4uNrzRFh+tpMEj+8otDOV5e9Z3PcD+USoSRUGvhU8kN5xNZftt59f1
 09z0LMnBNp+n8ISqYlKqVq9vyCn3AFULFWPzs21CaSb5u23XPtiLRt9vLT09/sT5
 fAgx5OiN4yVK8I7kciko4rRUuF/+C5ZJWWJW1t+0jjmkUhfxCTp18J8t7Dw32kOn
 g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dcsb68r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpeFQ015082; Mon, 12 Oct 2026 23:57:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:54 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfHl025328;
 Mon, 12 Oct 2026 23:57:53 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-21; Mon, 12 Oct 2026 23:57:53 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 20/21] vfio: block cpr-luo migration
Date: Mon, 12 Oct 2026 23:56:16 +0000
Message-ID: <20261012235727.398133-21-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX0cIup9qZc9ya
 GGxX4g5sErA3Ejy3wNBYE1aMms2x8G99/UahxB+9WdkoyRHGrvuKPstoNZHCDB5rc/QF1lUKc3A
 6gMEZWIY+ete1lnk1VnyzuKzr3OWHE6gN4DqCbxKtogEBBWqCrVX
X-Proofpoint-GUID: 5jd5TINQHSjt7UTGg3PSpxgCbIrschFf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX5B9EsfI17b3v
 eyftXhLen4LyuZ3tr5BT+cQxrsEjxjZipIAaZEVoz6ZLHg4Jsw+0wZpMt+kc2ma7U9h0oQLynAt
 IT02H2q7oljwj+J3sJoMDtk2l3DZAd2ynVmr7kZmemA3oSJE8DfAsNzyyqpjabTsr5pwSYK3oBF
 CF1/SUDHgqYxWi6mHqQ6CuRqFj9u2HEcscSzKkvksAAaDY1UlWOpaA2MtgMntnkKy2NYmK8wiIW
 z8aD//2rp6cpvNo3VRJzyAHir37xM7CqWBAVLkQmdnaHh2hhVJeOzbHk5lUJ/pLGifKvqQLajDF
 4AJHdcVDIqt155t9OxAaX/UXkwxTO/Q7LUJRMBlNfvq4RL5MsQ3Q0F8PMCIoX/RiT9INu1Bp6S1
 GAYlRGrrQ5MpLqemg1NvurGm3d4HFfD/jw2wFVZEJqnfl87DT+Wec7Ze0Xqfn5I8R9PEaDVxQvo
 3zYiWhyCZtk0ulR7dgbLi/RjP868qG0tQcwUY8jo=
X-Proofpoint-ORIG-GUID: 5jd5TINQHSjt7UTGg3PSpxgCbIrschFf
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6acd7403 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=GQ2AnB7t7wovDo35adgA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

So far, cpr-luo does not support preserving and retrieving VFIO resources
across a kexec reboot. In the future, this may be supported by treating
VFIO as a live-migratable device when applicable, that is, by saving and
loading VFIO and vendor-specific state across kexec, as mlx5_vfio_pci does.
In addition, the upstream linux kernel work is ongoing to preserve and
retrieve PCI, IOMMU, and VFIO state across kexec.

Block cpr-luo migration whenever a VFIO is involved, just like cpr-exec and
cpr-transfer.

(qemu) migrate_set_parameter mode cpr-luo
(qemu) migrate -d file:cpr-luo.state
Error: VFIO: cpr-luo is not supported

This does not affect the existing cpr-transfer and cpr-exec support.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/vfio/cpr-iommufd.c      | 17 ++++++++++++++---
 hw/vfio/cpr-legacy.c       |  8 ++++++++
 include/hw/vfio/vfio-cpr.h |  1 +
 include/system/iommufd.h   |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 6758c73b6b..803fc0cd51 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -157,10 +157,20 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
 {
     Error **cpr_blocker = &be->cpr_blocker;
 
+    error_setg(&be->luo_blocker, "VFIO: cpr-luo is not supported");
+    if (migrate_add_blocker_modes(&be->luo_blocker,
+                                  BIT(MIG_MODE_CPR_LUO), errp) < 0) {
+        return false;
+    }
+
     if (!vfio_cpr_supported(be, cpr_blocker)) {
-        return migrate_add_blocker_modes(cpr_blocker,
-                    BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC),
-                    errp) == 0;
+        if (migrate_add_blocker_modes(cpr_blocker,
+            BIT(MIG_MODE_CPR_TRANSFER) | BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+            migrate_del_blocker(&be->luo_blocker);
+            return false;
+        }
+
+        return true;
     }
 
     vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
@@ -172,6 +182,7 @@ void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
 {
     vmstate_unregister(NULL, &iommufd_cpr_vmstate, be);
     migrate_del_blocker(&be->cpr_blocker);
+    migrate_del_blocker(&be->luo_blocker);
 }
 
 bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 2d40d8baea..9160e95f27 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -171,6 +171,13 @@ bool vfio_legacy_cpr_register_container(VFIOLegacyContainer *container,
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     Error **cpr_blocker = &container->cpr.blocker;
 
+    error_setg(&container->cpr.luo_blocker,
+               "VFIO: cpr-luo is not supported");
+    if (migrate_add_blocker_modes(&container->cpr.luo_blocker,
+                                  BIT(MIG_MODE_CPR_LUO), errp) < 0) {
+        return false;
+    }
+
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
                                 MIG_MODE_CPR_REBOOT);
@@ -199,6 +206,7 @@ void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
     migrate_del_blocker(&container->cpr.blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
     migration_remove_notifier(&container->cpr.transfer_notifier);
+    migrate_del_blocker(&container->cpr.luo_blocker);
 }
 
 /*
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index ecabe0c747..8d885fe404 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -26,6 +26,7 @@ typedef int (*dma_map_fn)(const struct VFIOContainer *bcontainer,
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
+    Error *luo_blocker;
     bool vaddr_unmapped;
     NotifierWithReturn transfer_notifier;
     MemoryListener remap_listener;
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 17bf1a3727..182a71df77 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -33,6 +33,7 @@ struct IOMMUFDBackend {
     int fd;            /* /dev/iommu file descriptor */
     bool owned;        /* is the /dev/iommu opened internally */
     Error *cpr_blocker;/* set if be does not support CPR */
+    Error *luo_blocker;
     uint32_t users;
 
     /*< public >*/
-- 
2.43.5


