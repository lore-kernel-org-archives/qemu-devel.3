Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BD1CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMFr-0001Fl-1y; Tue, 05 May 2026 16:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFh-00010f-WF; Tue, 05 May 2026 16:20:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMFg-0000Kt-CR; Tue, 05 May 2026 16:20:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645F4lOO2204349; Tue, 5 May 2026 20:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Bgyq104mrphet7nAN
 WLHEuSdqvbcalxtebGqiXGB5Qk=; b=bpNP4kTdLvPNun6nfArXSc9n11FlpCjN5
 3Gn4v0uGZ98u5cVKW0xhD0CIZrX2xS1GU0+pHt3VtYpSGKReZu5VSTjh2Fo3oUpZ
 dvRaa2UWQ0KZxJM5BBNWbm8p2zHQHz8zIt7tigTpqwQX2m/EQKA2kZpaoU51Sqve
 ZE1nxI/Cxw7bxJcW+c/b9poR852uxm+GHYEpKjeRwVPwlybuHsoMDxbYRaVKN4KA
 TuWKmpADYzTQ2fdt2mP3kfTBB18iKaIUdU67Cm+Tlny85A8qiKhVvx6/QFUKtkNq
 xS2o3rGMrqcN9vxa8Vvq/4Uns/1Sd6bSx8GyqQI86DH2NKADx2vcQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6d6rp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9Qra015552;
 Tue, 5 May 2026 20:19:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yb272-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJsA327132646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1A9C58059;
 Tue,  5 May 2026 20:19:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F3A05805C;
 Tue,  5 May 2026 20:19:53 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:52 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 26/32] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Tue,  5 May 2026 16:18:58 -0400
Message-ID: <20260505201905.997996-27-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fa50ec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=MUQpW0jNMHjpGy_Q9scA:9
X-Proofpoint-ORIG-GUID: Ywa-zkVj39GO9M8X6BuUWukAYiJYHEId
X-Proofpoint-GUID: Ywa-zkVj39GO9M8X6BuUWukAYiJYHEId
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfX1YYR47QrZq/R
 DfO6bHDp+gOw5scE7ZF3Onlu6z3+hyCgAU6HNA0u2i5bziQ4ls+9uLaJyiV0NGPIlLKWbqlki8S
 eLsquXKSe0QEzlK//A0bUmOAkCRTPNqP18U0QM+MGZt2sYCu1lSjxTwxOveg0UEQrQiKfuS/Pc6
 H+UgfiejpahD4/16xWNB2YaTM5jGPLUzOZk1pFh4ISjVg2RVKW5W86ORpIE54uKNNsO3exPqveh
 4g6+Y9XdBLcSl/jlJk3gSNzdjq1gzBH9LPq2ZsVIszj+OJeGXzTiM8a2JoxbqBYfDkkxwW2qyp9
 OYby29KkCbRoISpAuVWCqdfQVum09ajkkD2ePckNbyqS+fE5QPb+MwAkm/0gQ5F0hrxw2Ue2AAV
 Z92ytX/c6BkmISCSFDltkve5lA+bFooZt2OoUlkJUz+R6j3Z/a5n0xlnjObLt0GBcY2wIIwiK2Z
 1ZQaOsN1R6PH9wWYEag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

If `-M secure-boot=on` is specified on the command line option, indicating
true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.

Any error that occurs during true secure IPL will cause the IPL to
terminate.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/ipl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index f4311f6d62..67e8231c76 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -468,6 +468,11 @@ static bool s390_has_certificate(void)
     return ipl->cert_store.count > 0;
 }
 
+static bool s390_secure_boot_enabled(void)
+{
+    return S390_CCW_MACHINE(qdev_get_machine())->secure_boot;
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -524,6 +529,18 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
+        /*
+         * If secure-boot is enabled, then toggle the secure IPL flags to
+         * trigger secure boot in the s390 BIOS.
+         *
+         * Boot process will terminate if any error occurs during secure boot.
+         *
+         * If SIPL is on, IPLIR must also be on.
+         */
+        if (s390_secure_boot_enabled()) {
+            iplb->hdr_flags |= (DIAG308_IPIB_FLAGS_SIPL | DIAG308_IPIB_FLAGS_IPLIR);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
+        }
         /*
          * Secure boot in audit mode will perform
          * if certificate(s) exist in the key store.
@@ -533,7 +550,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
          *
          * Results of secure boot will be stored in IIRB.
          */
-        if (s390_has_certificate()) {
+        else if (s390_has_certificate()) {
             iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
             iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
         }
-- 
2.54.0


