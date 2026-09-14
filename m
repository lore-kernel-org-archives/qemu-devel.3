Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3B0C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ajc-0000o8-Ky; Mon, 14 Sep 2026 13:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6AjI-0000i6-0U; Mon, 14 Sep 2026 13:44:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6AjE-0007Ma-E5; Mon, 14 Sep 2026 13:44:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EFvxk32515230; Mon, 14 Sep 2026 17:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FPa+HiQBDuU/fyndZ
 Q0VLK/SkSVETo1Di7pKkdj977A=; b=GakTZyl52CheJtUqFfJTr7HlolTxx9CEs
 MeY0jxpGQEELPHoR3bKvPI/Gavu0QnyVf52HgR086StkoODlfsrQmBpioid7x7Ly
 BrwQqYBR+k4UZMyBva6Fc7Uix963BUeA3Zqr7bxnFaYozB9aRWvUSjmhmGulHMOF
 BwENPoxXXE15HSU2MYetr2TtUE98tqtKUEAWaNBvMC/2FM3xpcw/gD8sCIn2Z8Qe
 GVjlXC4sMwYYpavbSJRaNuJQRreVEUTd69Wqx/t+93qcFI6X75T1pToQULG2dO1W
 2v+9zHdbckcWURdtHBWsYuLpsktyMBig7TVh4RmCNw9fO2L5iipxA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcutu19-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:44:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EGW9gl2352626; Mon, 14 Sep 2026 17:44:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry74bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:44:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EHiNLo33817164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 17:44:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFCF158055;
 Mon, 14 Sep 2026 17:44:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39BE058043;
 Mon, 14 Sep 2026 17:44:23 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.224])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 17:44:23 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v5 3/3] s390x/pci: Reset a device in error state
Date: Mon, 14 Sep 2026 10:44:20 -0700
Message-ID: <20260914174420.12309-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914174420.12309-1-alifm@linux.ibm.com>
References: <20260914174420.12309-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfX3vPPSCW6tH2t
 EupM+cTfEjoS7WO99NS7LRT/Gll5osW2mAIogSNr7QeuK1O00K12ztifFWI1UP++9pQmXI4DOLt
 +Tw/++CjtIof19TWap+8/httdAEXCC0=
X-Proofpoint-ORIG-GUID: 4KnLxxkmEMpa4XkPavWwmHsVxki46AwX
X-Proofpoint-GUID: 4KnLxxkmEMpa4XkPavWwmHsVxki46AwX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfX/X6nSoJsblBh
 t0p30UkVSvCh3wj15Q6CMviEBg5PXFsrMWhFOtDIFvNOliDl1sDFq3S2ZKhnkilSZre1YPwLcvZ
 uvMnsFRmD5UKarGwxofL57PowsBZt+bYZXxRKZz0cGlXhmk6UB+4bxS5OtqO6nDMMqWYn16aWnE
 6SSJhHdnyet+MPtRhe6ZsegzoAlyuCMgV5mMBMIWXtzhH/hPgSQugnn1yOSJ9fa9WE6E+bXYmzi
 PS7+r6GtTmm+lodkcSbu7rsdWXl3mcTnw3FQfHEoWufq/oOFcuALa5zWaKrUzRcoYIjc1vt4ZUF
 CcNiBSSmGRC+p7DBsTMG7p4Sp9MSY03jtWOlxoS26oEyjLkj221btuzY0W7jB88jt6fRUONe/OL
 tHjOWw4b8UvSHwBVPGW2Yq/oAtGqlS6ivP065wmJ+BVUz69PP3ge4uY44hJkN5GAQoW0vpOzhVO
 q2EPpI9Oe4agmhh3aZQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa83279 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=A6rq8h5Md1LYvE6mRIYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140248
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For passthrough devices in error state, for a guest driven reset of the
device we can attempt a reset to recover the device. A reset of the device
will trigger a CLP disable/enable cycle on the host to bring the device
into a recovered state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 7 +++++++
 hw/s390x/s390-pci-vfio-stubs.c   | 4 ++++
 hw/s390x/s390-pci-vfio.c         | 9 +++++++++
 include/hw/s390x/s390-pci-vfio.h | 1 +
 4 files changed, 21 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b2967dacba..8418da9372 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1505,6 +1505,8 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
+    case ZPCI_FS_ERROR:
+        break;
     default:
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
@@ -1517,6 +1519,11 @@ static void s390_pci_device_reset(DeviceState *dev)
     } else if (pbdev->summary_ind) {
         pci_dereg_irqs(pbdev);
     }
+
+    if (pbdev->state == ZPCI_FS_ERROR) {
+        s390_pci_reset(pbdev);
+    }
+
     if (pbdev->iommu->enabled) {
         pci_dereg_ioat(pbdev->iommu);
     }
diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
index 9fc84ca135..c68c612038 100644
--- a/hw/s390x/s390-pci-vfio-stubs.c
+++ b/hw/s390x/s390-pci-vfio-stubs.c
@@ -36,3 +36,7 @@ bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
     error_setg(errp, "VFIO not available, cannot setup error handler");
     return false;
 }
+
+void s390_pci_reset(S390PCIBusDevice *pbdev)
+{
+}
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 6c072005fd..37d2f49658 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -185,6 +185,15 @@ static void s390_pci_err_handler(void *opaque)
     return;
 }
 
+void s390_pci_reset(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
+    if (ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET)) {
+        error_report("Failed to reset PCI device %s : %s ",
+                      vfio_pci->vbasedev.name, strerror(errno));
+    }
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index c7886b63ea..38ccf445ea 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -21,5 +21,6 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
 bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
+void s390_pci_reset(S390PCIBusDevice *pbdev);
 
 #endif
-- 
2.43.0


