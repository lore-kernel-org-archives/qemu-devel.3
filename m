Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E0ACD3436
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 22:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK1aw-0001y9-6s; Mon, 04 May 2026 18:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ag-0001vw-Gi; Mon, 04 May 2026 18:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ac-0002sY-7H; Mon, 04 May 2026 18:16:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644Kdp2A2771798; Mon, 4 May 2026 22:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FXIt7qEDwIqw/7fNi
 vpRUvOAJgUhQVxbx8gZymuFsN4=; b=OonBBD1mGw18GrtpVP16GF7HkBWHTTcYQ
 e2YBCGpEWitburz59PRC5AOaY18jcd4FEr3z02YMVUIL13iDA6EcivQA0Aea6zOT
 oHMr+c6ieGPki6cZC5wWJPanDrhTtNuoLiG/6N5Vzw1ZcfE8wHiqv14oyA4c5Bzh
 BJWHcBy9bifyrjcvT3DVraCCMQ9hce3Y490OQ43FUiJ91kX68EaYGt8sN+dBnLoO
 oJQWYqcD3u/ossiRT0Cgq3zaHy4xpbLx2TzlbAeKa31cicrXFv+SWZ4sPsvO50n5
 0OdSnqFxv+wFtzIbqeFdsPo01CAZwvtvHI3H6IH+vmFKH/eF2lDDg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxgtyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644M9jRY012550;
 Mon, 4 May 2026 22:16:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvy5nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:26 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644MGO6n25428570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 22:16:25 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9C7458055;
 Mon,  4 May 2026 22:16:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F61158043;
 Mon,  4 May 2026 22:16:24 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.119.68])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 22:16:24 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 5/6] s390x: Enable IPL from Virtio PCI SCSI devices
Date: Mon,  4 May 2026 18:16:12 -0400
Message-ID: <20260504221613.826825-6-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260504221613.826825-1-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIwNSBTYWx0ZWRfX66U/UwKndq0O
 AG30bDmyZTvOeRZbnRF5D5oOGJwrL16D1c+kehZ9D+QFVJzpf3ieapR3N44f6zbzAfMPgZTO9SU
 Kz2X/W9AHrPMWF93V7vEzj8RwFcrxXmUjN98F8RdP0L+3OPagqqhn8r726tTQl2yqQ+9cAA5XJf
 OREn277WBjCMfPq0mR+vm4dm0q4UfapbWK7QCMVVUBgA+VcAnJQvSa4t2XQNonEjPIm1yRSg36b
 pcaxk/3jcIfoMeva9qOXF2bcjBm9Q0EtiioCpICuPVi3CSs71dEitgpr4y1Rc3WSQJwcBusPyeM
 AFhIqoN0uPT8ECXOys4gAEWHnm7LrsFu8m/RfdBxoRXtCXBMHbUPHUdlO+zrKrx/uL5b1NjFB14
 LJbjTV96FqZe8uMrOmN+kqjywm+6ZcZVrg7wMvN+IJeALFSv+1eeFksFShi1TkO1IbBHvhET8fm
 H1HQfx2i3akCW3fBiLA==
X-Proofpoint-ORIG-GUID: bIEC0919hyH6s19WaoiVSGQQwOistGnG
X-Proofpoint-GUID: bIEC0919hyH6s19WaoiVSGQQwOistGnG
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f91aba cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GdLXXov1tT0adLAbiZYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Detect PCI SCSI boot devices and build an IPLB for them.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 hw/s390x/ipl.c      | 36 ++++++++++++++++++++++++++++++++++++
 target/s390x/diag.c |  3 ++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 402f5dbd7e..1ed1afe4c4 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -400,6 +400,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 }
 
 #define PCI_DEVTYPE_VIRTIO       0x05
+#define PCI_DEVTYPE_SCSI         0x06
 
 static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
 {
@@ -415,6 +416,26 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
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
@@ -523,6 +544,21 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         }
 
         switch (devtype) {
+        case PCI_DEVTYPE_SCSI:
+            sd = SCSI_DEVICE(dev_st);
+            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
+            if (scsi_lp && strlen(scsi_lp) > 0) {
+                lp = scsi_lp;
+            }
+            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
+            iplb->blk0_len =
+                cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
+            iplb->pbt = S390_IPL_TYPE_PCI_SCSI;
+            iplb->pci_scsi.lun = cpu_to_be32(sd->lun);
+            iplb->pci_scsi.target = cpu_to_be16(sd->id);
+            iplb->len = S390_IPLB_MIN_PCI_LEN;
+            iplb->pci.fid = cpu_to_be32(pbdev->fid);
+            break;
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
             iplb->pbt = S390_IPL_TYPE_PCI;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 06bdb2bbc8..319a2c9f4c 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -133,7 +133,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
-            if (subcode == DIAG308_SET && iplb->pbt == S390_IPL_TYPE_CCW_SCSI) {
+            if (subcode == DIAG308_SET && (iplb->pbt == S390_IPL_TYPE_CCW_SCSI ||
+                                           iplb->pbt == S390_IPL_TYPE_PCI_SCSI)) {
                 s390_rebuild_iplb(iplb->devno, iplb);
                 s390_ipl_update_diag308(iplb);
                 env->regs[r1 + 1] = DIAG_308_RC_OK;
-- 
2.52.0


