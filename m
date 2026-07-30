Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A06C55167
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYbP-0004CL-DY; Thu, 30 Jul 2026 17:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbL-0003jv-5k; Thu, 30 Jul 2026 17:47:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbJ-0002Sm-Ao; Thu, 30 Jul 2026 17:47:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJlos53976288; Thu, 30 Jul 2026 21:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=l3asYwPsNTPQUzL8Q
 vLHOs97u2XuAGIoi21QInY0/F8=; b=tK3XaOaMuWkFSyU88nLd4HRjqLDRls0by
 AUqNIB0tDU7b4ui8Bkclvv+Uq/1EWD2ei/LXGwhx5IjMxFnSFe3c/1Gd3eaZWsxo
 uApERXwPVAdO0oQ+BfOIk/6Oixd1tUif0vgpO3oktarriNu2mNI9P69GffhGNGMW
 Z/hcqDs0gsgs+4BELIU2SSInyLclAwEVie8J+zuMTuAPe1yE5ibzndFJlTT0YDXa
 sfBV4QrOfe8CXBEEltS61eKoHhE7fpHQ7BGGMzqzIbprF4Fzj3+xQBcX9voqyeRV
 L34t0KdS7a7inN0Zs/qWDPjCTLhh/N8MX+ZJI9l2wk3rCN7PKJaSA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y23h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfYJt003877;
 Thu, 30 Jul 2026 21:47:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5yd1ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULlVfD31588728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29CD758043;
 Thu, 30 Jul 2026 21:47:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E89D58059;
 Thu, 30 Jul 2026 21:47:29 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:29 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 30/34] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Thu, 30 Jul 2026 17:46:19 -0400
Message-ID: <20260730214624.2328883-31-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NypdUtjeEBxd0FZU_any_g_ZiIkZdUfZ
X-Proofpoint-ORIG-GUID: NypdUtjeEBxd0FZU_any_g_ZiIkZdUfZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX+UvZY7vzC13l
 ctdi3hvYEhRm37H9fcBvChTnA1/pJvUfHbxOYUsiSbEHdsiFJDc7fBhyYnmACvslkELwJJ5BrDi
 Ie+IS5pnaWn4fcB6NOvppKq4m77SFWI=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6bc675 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=8E_wKCjR_O7UhaygiVUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX7aA8voaK58QO
 GP0g1zb0NcGk3J2ns2xDCa0mEg38g1aUOSnqYxhuRvgVGUWvFZ7VefyFsdDwEGZ9WMkzV2plhGw
 XCPGHMS3s/Vdj43KyG4ey2MZpFsOEoVv8f5nVGlt0xPLCVK7Qj2BfioBcPoUh1YEBXEIt1AG0jG
 StvVzdjVj+FmLLsdvwS7ZDAJ/rbeCx5iVait5UfcpBbfWrBdo1S8bErmYA9VyGq6KzdUZ4ZkDwM
 RLLFj1WWehwqORKR+ha6bcFQNKmC5KuAsgwR8P5tf+ugQ74+eMp+cnYaS/0aRPBfXoXw73zSnLA
 m3VZ8jo9i9iDBe5h58rd7Ts3TBm8zjdymI+WCYdZrJXkBE/CFwceHTAWr0v3amg4wSJKXMLvFCf
 q0Muw4JmhT0H8o6hBhELZa5iy/C0SB+Bqy4iEKj8vvU0kQYfIEBMSThqOeTDK3ofzNcwkdYJ4up
 nf5LbzsW8EeWL8/Ce+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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
2.55.0


