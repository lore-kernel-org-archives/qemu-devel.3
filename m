Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07314C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kKM-0006S0-6U; Mon, 21 Sep 2026 16:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKC-0006Cx-N6; Mon, 21 Sep 2026 16:09:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kKA-0005Pg-FX; Mon, 21 Sep 2026 16:09:16 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8D9A1860555; Mon, 21 Sep 2026 20:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xjqVqIPmym2GlI74z
 mW8Ff0A+CbToZFr9gKX2l/c5d8=; b=LUHo2Jd5PF2bwJiP2tNnDOhysGNREP2La
 0jn98s6hJ2Elv21lZsyn6F8wT7BJkwqciybpHtJUX9vO0QhbkzxLoibbqVGW2kXJ
 oIASwVtKz82oAqttnbq3U0U+bhaF55N3+RLUxCmZ483O2n0dAu61Yg4RRtJejX3+
 PVB1KBt8W111ilNV+EEmhdS/lmHY3LBZAwOxI+51QvEOxA7C9ylIXcHbCVaO2VF8
 Hc4R9fNhLsJpLzxb9c30BHgIFpWTUDCPudKhU+eTdyULvbdqLld/meNpVGZEO63g
 21S+g/T27C8o/WwMy06NQUgEjD+fJalRg2e5+JxFna66xPuQET7SQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ah52-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJHhnx2399621; Mon, 21 Sep 2026 20:08:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy6nby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8nun22610660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D72045805D;
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6782F58059;
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:49 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 30/33] s390x: Find scsi-pci boot device and build IPLB
Date: Mon, 21 Sep 2026 16:08:27 -0400
Message-ID: <20260921200830.1302919-31-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921200830.1302919-1-farman@linux.ibm.com>
References: <20260921200830.1302919-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rMsbeefY-c-Q8J1RPmeQL8w7bmnV1PIx
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab18ed3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=GdLXXov1tT0adLAbiZYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfXzHMbYKl4DpQm
 USmDRpAtzqENQqNbc0B+enlwgNE/FHSvMpFxRphXd22Yji1wGEbCbgapiznpOielc2UkWLp1+YB
 lo4j06i2TfCDTPPwXPixhArDT1d8a+Amh4WZX9PZgYP6K2H7rws3mBUQxNxVPoY5H0v6vP3Y6Ty
 EoQwway2V4DqCTbqQJKdoXDpKMOf06x9y81L76IiHyddAWanB0w4zc1CuUV4t5KcBqKF1tWMOBl
 DvaudrSp3cxjk07UYQzGxaG4Wolds0RzpaGeVGc84c/+HpaaqQvBEV+hbbFD86VDwUlNTGqmFLF
 Dua+NiuGGtiIWkllg41MFNeHRw+Zh9oZtR1fjHkJjsCwMTedFgHq/Hm09Jk11z7RRFve6W4ZAwC
 Ql9ZWQkxfSJKrgNUbVMezec+V6GN8O5Ffe8SydnEGGYDzHK4xemajZ7FyUc1ezWvD18A5RMmwOr
 mad9DnlRHTcAhJ+zHQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX7B2r0UauaBSu
 RmDx1DE/s0UEmv3glgUPcMx/h2X0+ddJN0sbWLIHtgV4XYjsZYuDWdk8dJyImv6v2D7EE+/mQyF
 N7304afOe4tDBlSs06U11o7QK6yCkVM=
X-Proofpoint-GUID: rMsbeefY-c-Q8J1RPmeQL8w7bmnV1PIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260831194919.3830270-8-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/ipl.c          | 37 +++++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/main.c |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 4fa8124f92..1add11ad7b 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -402,6 +402,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 }
 
 #define PCI_DEVTYPE_VIRTIO       0x05
+#define PCI_DEVTYPE_SCSI         0x06
 
 static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
 {
@@ -417,6 +418,26 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
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
@@ -616,6 +637,22 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
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
index a2a24b024f..d2a2ac3138 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -267,6 +267,9 @@ static bool find_boot_device(void)
             blk_schid.ssid = iplb->scsi.ssid & 0x3;
             found = find_subch(iplb->scsi.devno);
             break;
+        case S390_IPL_TYPE_PCI:
+            found = find_fid(iplb->scsi.fid);
+            break;
         default:
             puts("Unrecognized SCSI controller");
             break;
-- 
2.55.0


