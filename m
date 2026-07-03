Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6210EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHR-0001Yb-TK; Fri, 03 Jul 2026 13:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHP-0001HU-Ao; Fri, 03 Jul 2026 13:02:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhHN-0003Uu-Nv; Fri, 03 Jul 2026 13:02:19 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJ3DY3246599; Fri, 3 Jul 2026 17:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0tRrXI+I1z+661/MO
 dlzZWSYaFNneyZuHHQqK5PBfkE=; b=oHP4S6foMIEfeY8eHrJUojCd2GNUbZKx8
 hTnlNO/FZRtNHe7YbXhPPENvENxqD8ow9cVPmKd13iSxIE2/BFT0idoMTo+oCBEW
 vU57dT70PtArzPTi4C4kHUpYxBLOPijS+yGbaPsu/YpZaJcLI+4C3xRjKOKMoZ+j
 YM6dwKAYzCeEYQyEx7BejEMCi2rtptKPspIwNM7ZgP388sfxfcYdLfqBjRgqG2q6
 /DIdgKnYjbkDVQpcf2SPZSvwnW0tiiRRmd7HQzAcBSVVQk5Alsd2vJFksPAbNrL2
 J0MKEHyHUQ6H8alEVay/Rn3er6YXoLx7rM+UFs+px4dob6vC8zcDA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qafsxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663GnlBr001538;
 Fri, 3 Jul 2026 17:02:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7whtjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:02:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H2Cb74260542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:02:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F147E5805C;
 Fri,  3 Jul 2026 17:02:11 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E84F58054;
 Fri,  3 Jul 2026 17:02:09 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:02:08 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 30/33] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Fri,  3 Jul 2026 13:00:27 -0400
Message-ID: <20260703170032.1893204-31-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX1H7oDtQVBu+h
 /RT2TgJ2zpE0cQWydzL17W3K4+3ZvZ4PqVCoLafK9VKL4WPpbyuFOZ3SZ+K/Jje0FPutlEIXeP0
 Wuw4YfmgjDQxwYFMJ6LrAlxNY5AejztCjjtSgBjgWoITBu+7S50C6wQmbf37INgHgpbMZ1zxkoy
 8fkSJH8149L0ABIrZkxbh+0kPP3r6EqGGlrHMkakpGLdKHWx+4buYuSb2DG54F4V+r3RVdupOLw
 +l9f53WBEMghgS5E1wDdSohB9+Kxw+Vhnwr/kaqDoyrMUq1M1FtJ/Z7aOpkCymmMXN16LnXHoV1
 QqyZCV8MvisUIcXlupt0IkllntsZqV9nHrFIYY0dQa8nF7yx13cnvNNDwkk1+ik6WxCVAyz19sf
 AIFBLMz1JznSEdFmaJRCkO9l1xMKj2a5VWwG++XymTbyE22+mXJRObhfcAiFPdEHOW6SPrKOIf2
 Aq5dRzXwsR0MOr4gVbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXyae9MfDtwzez
 1R9PRsU7vxQnSernjtIy0jk/CkweTrmYJeRBaTtAu0ZhoM/XuEDorJM2jPBjNkVi1nH5Rmu24YE
 Hc6fig82r26iZo8e1TwIi13vc8VrH1U=
X-Proofpoint-GUID: 8Q-8j5AKtJ5AR1g1Ez1crBX-442jX5-l
X-Proofpoint-ORIG-GUID: 8Q-8j5AKtJ5AR1g1Ez1crBX-442jX5-l
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a47eb16 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=3-8onZzmVqWz2BGYPZQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030167
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
---
 hw/s390x/ipl.c          | 35 +++++++++++++++++++++++++++++++++--
 pc-bios/s390-ccw/main.c |  3 ---
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index a99d3e3306..1c9ae4d019 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -503,6 +503,37 @@ static void s390_set_secure_boot_flags(IplParameterBlock *iplb,
     iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
 }
 
+static bool s390_validate_secure_boot_device(int devtype, Error **errp)
+{
+    switch (devtype) {
+    case CCW_DEVTYPE_VFIO:
+       error_setg(errp, "Passthrough (vfio) CCW device does not support secure boot!");
+       return false;
+    case CCW_DEVTYPE_VIRTIO_NET:
+       error_setg(errp, "Virtio net boot device does not support secure boot!");
+       return false;
+    default:
+       return true;
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
@@ -559,8 +590,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
-        s390_set_secure_boot_flags(iplb, s390_secure_boot_enabled(),
-                                   s390_has_certificate());
+        s390_apply_secure_boot(iplb, devtype, s390_secure_boot_enabled(),
+                               s390_has_certificate());
 
         return true;
     }
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 1bf77d1594..9623d5320f 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -305,9 +305,6 @@ static void ipl_ccw_device(void)
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


