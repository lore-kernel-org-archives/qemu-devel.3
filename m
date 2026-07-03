Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772C3C43327
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTg5-0001Ds-0s; Thu, 02 Jul 2026 22:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTg3-0001Ab-Nq; Thu, 02 Jul 2026 22:30:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTg1-0003gK-Hy; Thu, 02 Jul 2026 22:30:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631JQLq1203473; Fri, 3 Jul 2026 02:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FyDlXMX1wI5DoRH/p
 RHN3/B6zpI8n/pv/pkWJtR8avw=; b=kqRoNrR7UbWapG0ZCSxKbwfeoidta5/yV
 4PdOIrXZdnAL1SgEUn9NUapv00bMe8A19Vep9Oq3Hn8UyuskD1OGaeLqElbYOFYN
 0rHU7yUaiXhGJqCkr0VVFdWTA+4jFPHupuX5BjbNzM2UM2kT9a33zx/qaRAvUYsG
 A15hMT3ObXwgKaMz2VQLFRhi6r2D5dFV1bk1RZCaH0UkMNO6EIj2H+qbDrHJbQ3c
 6FHc9tJFwVnR8433B0m691XxmL1H/IUDezVymIBaaI9hDAa9HQubUEMPZWtk0RZy
 puSgoF/ESiMdvKrFIBgOygsjDTXNybQK1IGi9aeQJ0xGg0xrJgXrg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qacjvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632Jhvf012104;
 Fri, 3 Jul 2026 02:30:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqq001-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:30:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632Ug4b17564304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:30:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BE6458056;
 Fri,  3 Jul 2026 02:30:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F014F58052;
 Fri,  3 Jul 2026 02:30:39 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:30:39 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 30/33] hw/s390x/ipl: Handle secure boot with multiple boot
 devices
Date: Thu,  2 Jul 2026 22:29:28 -0400
Message-ID: <20260703022933.1805010-31-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfXwAmgUJRJkGYt
 /QCc5zU+jRlk82Z878Sg+xVbh6ggsnku2XjcldOMPQenn1pgqk98XyEwXD7Rq/Ge537FbNjbyQg
 5sdx8kLVuWFb+Ratmk+w0JkPEfkoNL4jA4TtAHs1tlbrP0zFvGNSAME3glz2K0Fnc9zobDqTLFP
 flEt4u4dt6CrVCafGNMyWfTKM82XnO8SHwR+B4BAdFBY+UG5Xgbtd5zk6F+JHNqUETw49Gwnww9
 o2DDnX9HX0VS6N3Hte7MwNhKKVsAX8S7Me24Qk+DVQYgEyjbDir+xOhH0/3t2TYXpwekxdPISjj
 4foN8T0FMZO1XNQlp3eGXRl4cALa2krJdk+rX5Y3Lbtkoy8Wpc6k5or1srXXW9XBi3PySIWA7w0
 1havlrZAbNFu51VVBvM+PheTkRvJqE4XzCPwO0n0mbbMeTgbg4W+EqKkg/xc/4NdP3C8RZDrvrf
 hika8tgKmSOVvH0vYZg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfXy9CPLZ/ykQ1X
 RjgXiibDcvv+KAuDMQrEyC5d8pGBoYCN6ikkYRVkwHRB8nU9B6tw4P0+2DjiBAV48kwY3mKIQtw
 8Z8YBPVR2NZeYGzQV3RsAY1esxrZ48w=
X-Proofpoint-GUID: rXpoVvWJdESmUz8SzFN_-sRrPQz-l_x_
X-Proofpoint-ORIG-GUID: rXpoVvWJdESmUz8SzFN_-sRrPQz-l_x_
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a471ed5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=3-8onZzmVqWz2BGYPZQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030020
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
index 687946c471..3eccdf1c99 100644
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


