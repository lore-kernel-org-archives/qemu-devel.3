Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E754CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wboxg-0000Kv-T6; Mon, 22 Jun 2026 20:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxf-0000JF-MF; Mon, 22 Jun 2026 20:25:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxe-0003cK-2o; Mon, 22 Jun 2026 20:25:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmU393896350; Tue, 23 Jun 2026 00:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=m3QQnMA1J67/ZsLf6
 nhOOi5kLhoE1ut6ZAqrtdZ5+Q0=; b=jqcG0cJ5GDjf0n7mYAY6ZsaOXi3SbKdpE
 9TuSvpwIYHUayKfmiFtgQm8rtxO9d+6XkEbs6rMYap9Nvkx7SFAGGVMcSkYhwEZx
 WjM+QZlwTdwi7qE1rbWVjmV9xyOasemZYkQwGmlDxQrMg37q02JtTJZEpHl+J64/
 wMTnc5+E/d2MSpwjadJoJXk6vCKNOuKcuFTOJVtpwORt6Vv4mLRoCYdY86T7mT+R
 693j78omnZv5lrCNciAg/cqpt6Nvr1WQ8FapYWAKqjab6rjwl1U/bxEPFTuGNmQ5
 /uG1MuOQVq4vtADPl8/Z1vmUP/rNOtFE49L3XnECG7cmgIBbvIyxg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hm62s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0Jeo2007306;
 Tue, 23 Jun 2026 00:25:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw8utx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0PIC014549638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:25:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC4BF58053;
 Tue, 23 Jun 2026 00:25:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1C7E58043;
 Tue, 23 Jun 2026 00:25:49 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.116.241])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 00:25:49 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH 4/5] pc-bios/s390-ccw: Verify virtio support when booting from
 PCI device on s390x
Date: Mon, 22 Jun 2026 20:25:38 -0400
Message-ID: <20260623002539.126124-5-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260623002539.126124-1-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -v75l5OQYMvbByB68aH758FXzIINdSiT
X-Proofpoint-GUID: -v75l5OQYMvbByB68aH758FXzIINdSiT
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a39d290 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=vycScq5fQBvcvulrpfcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfXwB+l4lV/VKBv
 f57X0MDvQRwNPzh3sOC0xarAbegErRvT9biiCvRScF+8N8xvYo7wIzhV1rgNqEusUqKPrhnoeld
 dVrXlEkQF8xuIPToO1fwT2e3srZfn89G8Iq/ppko8VLt2f8k8X3XQ6ox80/iFPu2Q9AySIP+SLG
 t1UeDR4DJbLtEktdM0prn0Nq5DujpVswFhT/lMbhsdaV3d1P5TIot75t4/mmdY6jgXQJZWrsQyA
 n3aRC6sGX42ug42CMyPW2bC/cI9QDCAltJtc0vpP/2oOa4wEjp64G6AmkIciJFT2RgXhn2aJTUn
 ZJvV8diiw4tZ4ujHI14hLYDbsp0lT932FuXHyDCDvb0Up5lWWOyl//m3j9UaUsM3WZUTpMeVvOd
 hNEmCFkOywAlldVjd2+93BtEVPZrKe8CztlOrnQBgwjTGDFQd8iK3gVx+16AA2Y5ZXIgUVNRDov
 ZDPcE7fsLOGSqfT5daA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfXwXmO+GSRq1g/
 dQqGTi2ET+i/n6LStqN5EpmfVE3Ju5ooc/U9UEcB8ZUg/5kgTvGB6pEldTVpmY/lU/2Yyg73nhM
 PB37PogwlUUTapItX3fV2GgHDwmnMVk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

From: Jared Rossi <jrossi@linux.ibm.com>

The virtio specification requires that each PCI device has a vendor ID of
0x1AF4.  Verify this value before continuing with boot process.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c       |  1 +
 pc-bios/s390-ccw/virtio-pci.c | 19 +++++++++++++++++++
 pc-bios/s390-ccw/virtio.h     |  1 +
 3 files changed, 21 insertions(+)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 1059fda03c..567e97bf32 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -164,6 +164,7 @@ static bool find_fid(uint32_t fid)
     }
 
     vdev->pci_fh = entry.fh;
+    vdev->vendor_id = entry.vendor_id;
     virtio_pci_id2type(vdev, entry.device_id);
 
     return vdev->dev_type != 0;
diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
index 2c83ec4f13..07b53b894f 100644
--- a/pc-bios/s390-ccw/virtio-pci.c
+++ b/pc-bios/s390-ccw/virtio-pci.c
@@ -325,6 +325,20 @@ static int enable_pci_bus_master(void)
     return 0;
 }
 
+bool virtio_pci_is_supported(VDev *vdev)
+{
+    if (vdev->vendor_id == 0x1AF4) {
+        switch (vdev->dev_type) {
+        case VIRTIO_ID_BLOCK:
+            return true;
+        default:
+            return false;
+        }
+    }
+
+    return false;
+}
+
 int virtio_pci_setup(VDev *vdev)
 {
     VRing *vr;
@@ -335,6 +349,11 @@ int virtio_pci_setup(VDev *vdev)
     vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
     vdev->cmd_vr_idx = 0;
 
+    if (!virtio_pci_is_supported(vdev)) {
+        puts("Virtio PCI unsupported for this device ID");
+        return -ENODEV;
+    }
+
     if (virtio_pci_read_pci_cap_config()) {
         puts("Invalid virtio PCI capabilities");
         return -EIO;
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 75ae5bdbc2..aa307025e0 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -259,6 +259,7 @@ struct VDev {
     bool scsi_device_selected;
     ScsiDevice selected_scsi_device;
     uint32_t pci_fh;
+    uint16_t vendor_id;
     uint32_t max_transfer;
     uint32_t guest_features[2];
 };
-- 
2.54.0


