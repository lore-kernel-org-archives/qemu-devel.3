Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A38C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whFef-0001sS-D5; Tue, 07 Jul 2026 19:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFec-0001ol-0t; Tue, 07 Jul 2026 19:56:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whFeY-0002kX-Rm; Tue, 07 Jul 2026 19:56:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MmMMN184080; Tue, 7 Jul 2026 23:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ctsHirudJ25PUav1g
 KZnP5seYl2oQ2gD915FatB8nQc=; b=iTH0G5gNvZWEkbxqKt4FevOodaqbnWbkp
 eFneqjyQhv48IHCuOX1JCqFLKSrjWKBeoI0tR5TiW01XNfApngRQoybWwOyFqrnz
 pc8TquAPiJNqgHdYJ3BSxI3xR8BrL2UYDRFnS7NH4G2YWWrXu2UGZLMQAVvSj3c+
 0zBKaawkEV9MYysEEpFIqSyM9Vj+GKLaDRQ07/dUngDOrUBhz7q/SVERaTTzCGgK
 tlKEetuzO3brhW+N+FwFOwHsp3j6OhXZfgit1ylgMxzQp6Tu+JDqYg0+N7xbNjSh
 zIZDBmqt3+A05h9VFx1GrtSBdk51P/AtzPK70rZ3y8HB3XvPd0bcQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdtbv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Nnbp8008219;
 Tue, 7 Jul 2026 23:56:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hd2m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:56:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NuLXX29819428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:56:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 997C55805A;
 Tue,  7 Jul 2026 23:56:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D96858052;
 Tue,  7 Jul 2026 23:56:21 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.116.2])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:56:21 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v16 30/33] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Tue,  7 Jul 2026 19:56:04 -0400
Message-ID: <20260707235615.2513487-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4d9226 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=8E_wKCjR_O7UhaygiVUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX2cCMpgxZHXBU
 1KjIYTvlitL8uPgYexRmS1eyvMjNq1TEpwJQ0uXqEkkHNPdNTQo5k0Op18vezcSv9URl2BhySyc
 7zMW1qxFqTrBe5B65jByBxbytXzdSqdkO0C6fXXr0BBzjRri47dcoQ6s4E5QXPBuSgvKk4E8GoC
 YGXYWYDR2Y3tLFSYfHEbMcRlZnVZNqVor8a78/jDjNRfsRXlcNJRS/HV/aBIfYKs7YxxmFscTSW
 QncpizNa8ghAUgkzZpI7yWaBbomFP6PNq82TBa+FAVI+388kMZv87B7IqyZfkZbvEgPe+zv6ncA
 QPV3jHt+lE7LJLU9+GCY18kxeoH92YAqJc+JZJWAMRSSI3+VvgvBa1dXy4xy3XMhviqch3vIzuC
 e/ZDz0doQC21OvD6isCVcesM0W67/3ix+Tqx5EWlVnBbkdyaWCIflsjEaPpDxiA/hHYk5J/Vc9t
 Fsi/AZNTD0V6TSQQiZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX6qrpf2Bng51y
 RutJn1aHYBrbe/JGbXoye/yV1UidPw1sbkIfn/bf8Zz/OILmz6Bhz8rmzPat8UxvIS632HXWpAo
 6sMhJDl79abO9DCCtaUGRKL1UORGHtw=
X-Proofpoint-GUID: Cyf5ZYyHeZ9WU6jaGn-SaawAeR9wwRZO
X-Proofpoint-ORIG-GUID: Cyf5ZYyHeZ9WU6jaGn-SaawAeR9wwRZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070233
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

The current approach to enable secure boot relies on providing
secure-boot and boot-certs parameters of s390-ccw-virtio machine
type option, which apply to all boot devices.

With the possibility of multiple boot devices, secure boot expects all
provided devices to be supported and eligible (e.g.,
virtio-blk/virtio-scsi using the SCSI scheme).

If multiple boot devices are provided and include an unsupported (e.g.,
ECKD, VFIO) or a non-eligible (e.g., Net) device, the boot process will
terminate with an error logged to the console.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/ipl.c          | 40 ++++++++++++++++++++++++++++++++++++++--
 pc-bios/s390-ccw/main.c |  3 ---
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 35bdfe03d8..d59ed36c78 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -504,6 +504,37 @@ static void s390_set_secure_boot_flags(IplParameterBlock *iplb,
     iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
 }
 
+static bool s390_validate_secure_boot_device(int devtype, Error **errp)
+{
+    switch (devtype) {
+    case CCW_DEVTYPE_VFIO:
+        error_setg(errp, "Passthrough (vfio) CCW device does not support secure boot!");
+        return false;
+    case CCW_DEVTYPE_VIRTIO_NET:
+        error_setg(errp, "Virtio net boot device does not support secure boot!");
+        return false;
+    default:
+        return true;
+    }
+}
+
+static void s390_apply_secure_boot(IplParameterBlock *iplb, int devtype,
+                                   bool secure_boot, bool audit_mode)
+{
+    Error *local_error = NULL;
+
+    if (!secure_boot && !audit_mode) {
+        return;
+    }
+
+    if (!s390_validate_secure_boot_device(devtype, &local_error)) {
+        error_report_err(local_error);
+        exit(1);
+    }
+
+    s390_set_secure_boot_flags(iplb, secure_boot, audit_mode);
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -560,14 +591,19 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
-        s390_set_secure_boot_flags(iplb, s390_secure_boot_enabled(),
-                                   s390_has_certificate());
+        s390_apply_secure_boot(iplb, devtype, s390_secure_boot_enabled(),
+                               s390_has_certificate());
 
         return true;
     }
 
     pbdev = s390_get_pci_device(dev_st, &devtype);
     if (pbdev) {
+        if (s390_secure_boot_enabled() || s390_has_certificate()) {
+            error_report("Virtio pci boot device does not support secure boot!");
+            exit(1);
+        }
+
         pci_lp = object_property_get_str(OBJECT(pbdev->pdev), "loadparm", NULL);
         if (pci_lp && strlen(pci_lp) > 0) {
             lp = pci_lp;
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index c5c093534c..8fc1cbf653 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -308,9 +308,6 @@ static void ipl_ccw_device(void)
     switch (cutype) {
     case CU_TYPE_DASD_3990:
     case CU_TYPE_DASD_2107:
-        IPL_assert((boot_mode == ZIPL_BOOT_MODE_NORMAL),
-                    "Passthrough (vfio) CCW device does not support secure boot!");
-
         dasd_ipl(blk_schid, cutype);
         break;
     case CU_TYPE_VIRTIO:
-- 
2.54.0


