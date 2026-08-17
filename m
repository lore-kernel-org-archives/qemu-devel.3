Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB621C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuai-0001BK-NJ; Mon, 17 Aug 2026 06:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuah-0001AY-Eb; Mon, 17 Aug 2026 06:29:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1wvuaf-0008OB-Mz; Mon, 17 Aug 2026 06:29:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLVb0q3727905; Mon, 17 Aug 2026 10:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=C+amWTMkVUywrHrvc
 rZmolopHHGlfE4g9vCZb7Zfv+Q=; b=dGEFQXiJnjyRdlrjlP7JKfCnRHd38bID6
 XpfCyGgs2x6fAcLeLXWVssMqBYWuQJXQfUufC81JMmhJB20l6zrkMdr9a1TgjfHl
 1n/opW8G3XoPZX/9ggeCheosBioiTmxXQBPckxARfJj+0Xgu/PtMa5LasIYK0zas
 nnKo+/uOEfjsmhiOYELFBOBYpl5Mw8VDu3l8woAWC43riyuB0kkrAEiTy4heakiK
 moN8WAavftohCFgUAih8k1cRph3JRck5PmuZqqyZhoWHjwR1NWgiTSiTPm0TKAlx
 g0ONwGV81EgHUPwy6u3ol55JejzekLxsLVswq+5eFZwz6dlL+haMw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4hrcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HAQXrf029045;
 Mon, 17 Aug 2026 10:29:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvwr3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 10:29:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HAT6Vl29885094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 10:29:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 807FD5805C;
 Mon, 17 Aug 2026 10:29:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 682C75805B;
 Mon, 17 Aug 2026 10:28:59 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.124.212.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 10:28:58 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, nnmlinux@linux.ibm.com,
 sbhat@linux.ibm.com, harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 rathc@linux.ibm.com, balaton@eik.bme.hu, philmd@oss.qualcomm.com,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [RFC PATCH 6/8] spapr_vscsi: add VOF disk nodes to the device tree
Date: Mon, 17 Aug 2026 15:57:23 +0530
Message-ID: <20260817102733.605346-7-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817102733.605346-1-uverma@linux.ibm.com>
References: <20260817102733.605346-1-uverma@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -IJ_mJSzxc9hY6RVHyqiHsGyLK7k1CPf
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a82e275 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ldcrh8NI4ZgP_iADOm0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfX+yX4Mfv9RLOR
 HpgdRH5R/A4ZE7lZ//zi4qShl+bu6VTgBBk/0Ck/BPAKIhusC4bvuzXpZH/LsXoUu78LSq1iidd
 28vw0aDYzCA88CE9z3i430e4YyxrYkY=
X-Proofpoint-ORIG-GUID: XXln3yAELQPg_V7zP6PcgUBerREBN88U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA3NCBTYWx0ZWRfXzNMZcQGV4975
 fuUjHgikjCIjbwPIrlVo/1bYyr6VIoggo3q05+JOGR1Sid0LgkBf9AFSxEJbFogKrV7kbz8+Cb8
 dhU9gHUIJ5djYbgdJPeGZPsMqenHLR3Ms1Py8+X3tdZuKJdqfstEsJwYRbCzeayocftNJX1jen+
 f7lwdNA44FtxSTyLgCDBwWaE4HqL+wZnh1rAWik7jVXfhWqv9lzLwqKmCSbp8aJxCicxn2Hht6K
 xz+ufDc0Ja9I0L/o1/OqvR3ufKq6i7gzE7k+bQ7f5iCSPEJl3Dj286qy8kqKgrMTW0+QjYB7rf7
 Dscu/+x+t3pEi5v2RCOwan6svfplmoa7Asq7RgUsC5ePUP7UnyNYe9kP2k0i4vVMmVYQf7yJ2gY
 5iEeNjT4oyLCb4Z1lU6VR8t3KaMkGjI3NsrDYfwERTmgTrAtQNnmPyWrkSX2F5j1ivDAgzsPZ8D
 Kr+rxMSci7HADG3fnPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

From: Utkarsh Verma <uverma@linux.ibm.com>

Populate the vSCSI device tree node with child disk nodes for VOF
guests.

This lets Open Firmware clients such as GRUB open fully-qualified
paths like /vdevice/v-scsi@.../disk@<srp-lun> for attached vSCSI
disks.

Each child node is named from the encoded SRP LUN and includes a reg
property with the 64-bit LUN value, along with device_type set to
"block".

AI-used-for: code
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/scsi/spapr_vscsi.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22..03f5f27f5f 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1243,6 +1243,8 @@ void spapr_vscsi_create(SpaprVioBus *bus)
 
 static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
 {
+    VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(dev);
+    BusChild *kid;
     int ret;
 
     ret = fdt_setprop_cell(fdt, node_off, "#address-cells", 2);
@@ -1255,6 +1257,44 @@ static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_off)
         return ret;
     }
 
+    /*
+     * In VOF mode, add a child FDT node for each attached SCSI disk so that OF
+     * clients (e.g. GRUB via VOF) can open a fully-qualified path like
+     * /vdevice/v-scsi@.../disk@<srp-lun>.
+     */
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    if (spapr->vof) {
+        QTAILQ_FOREACH(kid, &s->bus.qbus.children, sibling) {
+            SCSIDevice *sdev = SCSI_DEVICE(kid->child);
+            char disk_name[32];
+            uint64_t srp_lun;
+            uint32_t reg[2];
+            int disk_off;
+
+            srp_lun = ((uint64_t)(0x8000 | (sdev->id << 8) |
+                                   (sdev->channel << 5) | sdev->lun)) << 48;
+
+            snprintf(disk_name, sizeof(disk_name), "disk@%"PRIx64, srp_lun);
+
+            disk_off = fdt_add_subnode(fdt, node_off, disk_name);
+            if (disk_off < 0) {
+                return disk_off;
+            }
+
+            reg[0] = cpu_to_be32((uint32_t)(srp_lun >> 32));
+            reg[1] = cpu_to_be32((uint32_t)(srp_lun & 0xFFFFFFFF));
+            ret = fdt_setprop(fdt, disk_off, "reg", reg, sizeof(reg));
+            if (ret < 0) {
+                return ret;
+            }
+
+            ret = fdt_setprop_string(fdt, disk_off, "device_type", "block");
+            if (ret < 0) {
+                return ret;
+            }
+        }
+    }
+
     return 0;
 }
 
-- 
2.54.0


