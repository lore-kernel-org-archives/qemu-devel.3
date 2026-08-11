Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF5CC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkh-0002cQ-4H; Tue, 11 Aug 2026 10:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnke-0002bF-W8; Tue, 11 Aug 2026 10:46:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkd-0003gZ-6o; Tue, 11 Aug 2026 10:46:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWjmZ492651; Tue, 11 Aug 2026 14:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4Brz6gunKDfUfYuv5
 wgJ4qzXmCL8uVATvvQWXPiwpv0=; b=Z44Sh4n4YyW+9uLmYY21YyAIYWwMblY82
 sXAuTQLz52Tqka/YDBf5XS5eeqNf2x8q2XVG0+qJEysjYWnelUN+XOF+ZOkpPS99
 jITUbRWPKVcekrB76qFK0ioqeAKNVQqDm1+PMK/Yl+/qv54x3H4EuWc2nkmvhAAj
 3Qdqp1b5EOZv9QJP8EqnkK44rns88Dnfrli98iEk2/GrCELlfS1XRZCG0PcvC2eu
 nT4aK8FweMjpRh+cv9luejSjT3hMJeTS2hgEkPuaNPQTBvRpb1eHgYrl6W7xKBD8
 F9XZdRuhc5Isy/NKrzd3BcWwwdLleFuDmMfhPvj8sgt68Tn+8hpOw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9defm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfE1T005344;
 Tue, 11 Aug 2026 14:46:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjsc3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkgT124052434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5F5358055;
 Tue, 11 Aug 2026 14:46:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B3E058043;
 Tue, 11 Aug 2026 14:46:42 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:42 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 7/8] s390x: Find scsi-pci boot device and build IPLB
Date: Tue, 11 Aug 2026 10:46:28 -0400
Message-ID: <20260811144629.866641-8-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: INsbne7kMQ94uUROJH-aBvfdJMdQcZ5C
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b35d5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=GdLXXov1tT0adLAbiZYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXxk9cm0RuaZFS
 C9R3/9qxiZmoTyGaIWTncB45jDLoZyhN2J3246NNbdk6x8GMwaewVEbK9477jRkKQcBcLj3qQpD
 BvX52kclqeT3Wzi9EPcPuKhhaMT9nZJx4gMvOhxHPHgp6UjXF11xNWBykZzM9EMnEQDwcjFDrAT
 cfdtVgu3uYGJmNIeuzZnBpgjNL1Z9TDAgD0x2SlyQkG5Uu4PyXzAw+qffC9cOTL29hGd/MpTHME
 i97nXftbi8t9DaahG159vPj0MglCKxtNoxFbji26ssR8+TRLy2NteyXrN+VuMntiGoQrBQ8zPQn
 tJ8EtEZlLCZWjprmIWawwSpy5PJD64qbgoXf8v2dCydSdgpENc+ZmRr0hmdcdPQ0CzHULhiHTED
 Lyap4nbD2iXSQ+sfjLhaKkk/P2zcAigcDDWKE/F0ECtTd8gnSYDZfjc1sk7dYdDXnn0HzwrVC0i
 uAhQNqRvEsxiCYtAFLA==
X-Proofpoint-ORIG-GUID: INsbne7kMQ94uUROJH-aBvfdJMdQcZ5C
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX7b9m1d0+q/7j
 bGBraKU3J4ZPd1IHvSM+4Z2jvh3Zvc9MmN1CSLBpjq8laqYAwJ9cZ0hLFfjYtymqgLVv3nEc8/O
 tbnndnumZk/zbEF5QF6WnbFhAA92Fnw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add logic to identify a virtio-pci scsi controller and target lun with
assigned bootindex, then build IPLB for it.

Unfence PCI case for scsi devices in BIOS.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c          | 37 +++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/main.c |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7e68be4c20..3ab48e1224 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -401,6 +401,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 }
 
 #define PCI_DEVTYPE_VIRTIO       0x05
+#define PCI_DEVTYPE_SCSI         0x06
 
 static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
 {
@@ -416,6 +417,26 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
             if (pbdev) {
                 tmp_dt = PCI_DEVTYPE_VIRTIO;
             }
+        } else {
+            SCSIDevice *sd = (SCSIDevice *)
+                object_dynamic_cast(OBJECT(dev_st), TYPE_SCSI_DEVICE);
+            if (sd) {
+                SCSIBus *sbus = scsi_bus_from_device(sd);
+                VirtIODevice *vdev = (VirtIODevice *)
+                    object_dynamic_cast(OBJECT(sbus->qbus.parent),
+                                                TYPE_VIRTIO_DEVICE);
+                if (vdev) {
+                    pci_dev = (PCIDevice *)
+                        object_dynamic_cast(OBJECT(qdev_get_parent_bus(DEVICE(vdev))->parent),
+                                            TYPE_PCI_DEVICE);
+                    if (pci_dev) {
+                        pbdev = s390_pci_find_dev_by_pci(s390_get_phb(), pci_dev);
+                        if (pbdev) {
+                            tmp_dt = PCI_DEVTYPE_SCSI;
+                        }
+                    }
+                }
+            }
         }
     }
     if (devtype) {
@@ -532,6 +553,22 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->pbt = S390_IPL_TYPE_PCI;
             iplb->pci.fid = cpu_to_be32(pbdev->fid);
             break;
+        case PCI_DEVTYPE_SCSI:
+            sd = SCSI_DEVICE(dev_st);
+            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
+            if (scsi_lp && strlen(scsi_lp) > 0) {
+                lp = scsi_lp;
+            }
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
+            iplb->blk0_len =
+                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
+            iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
+            iplb->scsi.lun = cpu_to_be32(sd->lun);
+            iplb->scsi.target = cpu_to_be16(sd->id);
+            iplb->scsi.channel = cpu_to_be16(sd->channel);
+            iplb->scsi.bus = S390_IPL_TYPE_PCI;
+            iplb->scsi.fid = cpu_to_be32(pbdev->fid);
+            break;
         default:
             return false;
         }
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 50f455324e..40b21f5f87 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -263,6 +263,9 @@ static bool find_boot_device(void)
             blk_schid.ssid = iplb.scsi.ssid & 0x3;
             found = find_subch(iplb.scsi.devno);
             break;
+        case S390_IPL_TYPE_PCI:
+            found = find_fid(iplb.scsi.fid);
+            break;
         default:
             puts("Unrecognized SCSI controller");
             break;
-- 
2.54.0


