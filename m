Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899D9C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA63-0004yG-P0; Thu, 08 May 2025 18:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA60-0004qf-J8; Thu, 08 May 2025 18:52:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5y-0006cR-Rg; Thu, 08 May 2025 18:52:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548JuW1x025864;
 Thu, 8 May 2025 22:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zkDopYj3QGUt5kYjt
 wZ68pUb4Z4QzlLZ5Z5J804NL68=; b=TXIqLOOaqD22xNxYBTHLBw0l8wJSvB5on
 ecoIZGWEs4unfg1a/8byXPuU6oeXhnHZIdCJmgfOUl/kjAXS0Fbue5ge4AIW2bUM
 W0wr3wf7ucXKQi1NqnXxAY6KauCCqwBtFMCpysLTLXMsxW5/1Mep5j8Bf5NORtX5
 nymKfHXinpm1b4/ekDa8GQcMaduY/MpcRgD9JaQn3NRXbdl2EYhO1MEZxhnT2VOU
 WEhPkxyz39NMkrNa4CsNKpslHb4ueQmPzgPSDe1BGirP0amxmIcx7tFA0drmDFRr
 WhHyIX14uodClQlqRoSS7hQjzqJEXTv2sPydcr/NdcTAM2oOb4v3A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthkbhbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:52:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548Lmvkr002729;
 Thu, 8 May 2025 22:51:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp838v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:59 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mpvj521365280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF4A358055;
 Thu,  8 May 2025 22:51:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69E375804B;
 Thu,  8 May 2025 22:51:56 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:56 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 21/25] hw/s390x/ipl: Set IPIB flags for secure IPL
Date: Thu,  8 May 2025 18:50:37 -0400
Message-ID: <20250508225042.313672-22-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX/D7XBB/yjlFb
 vlQZ7gGbQMlz1xOOp5m5ZFbPRW9STQHHSn2Aur7Lyp274XlSTzkH+75bNxm7chQ5loUKEFcnMwb
 kO2dQjByBxmVW/Y1E5PBdutVhYTznPokzsNuJNZskNH48ycBh6dd4F2rQySeP3ziOI2S9sV1qlA
 wwyjIu/CKXEOBH2YOETOdxamZchQyzX9sPZA6SpE875X/DeYEwFoWa4Ri5JeF4gKY9UsxUK57b/
 VPpYGoZfbZFa0MyYEXZuDfHwf5T8jTVbYjmJnA2xbs/9NFEPjwqcC6MM6Kuh2dk+Ohdunsnak3u
 QlkWjy0zyUeMNDwWxAbK5OMgWfaUU8TPy24PoNvG2x919HoehTUNfHJVP/nVK61z+MvRr+1gx8y
 OPUgHhunOZXJmDhOQFBegY1dz+2Z+dtIiaXs7xziuCwgw1M4opT3YY/hw1z0vkjKshowHTG8
X-Proofpoint-ORIG-GUID: Obl1gFBn1QjHrhZcUof72ZfGtQ1Vtj4T
X-Authority-Analysis: v=2.4 cv=PvCTbxM3 c=1 sm=1 tr=0 ts=681d3590 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=mSMmxON0n-l7oYpSrNgA:9
X-Proofpoint-GUID: Obl1gFBn1QjHrhZcUof72ZfGtQ1Vtj4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=752 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If `-secure-boot on` is specified on the command line option, indicating
true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.

Any error that occurs during true secure IPL will cause the IPL to
terminate.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d1a972ac8d..4c827be121 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -437,6 +437,11 @@ static bool s390_has_certificate(void)
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
@@ -494,6 +499,17 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
+        /*
+         * If -secure-boot on, then toggle the secure IPL flags to trigger
+         * secure boot in the s390 BIOS.
+         *
+         * Boot process will terminate if any error occurs during secure boot.
+         *
+         * If SIPL is on, IPLIR must also be on.
+         */
+        if (s390_secure_boot_enabled()) {
+            iplb->hdr_flags |= (DIAG308_IPIB_FLAGS_SIPL | DIAG308_IPIB_FLAGS_IPLIR);
+        }
         /*
          * Secure boot in audit mode will perform
          * if certificate(s) exist in the key store.
@@ -503,7 +519,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
          *
          * Results of secure boot will be stored in IIRB.
          */
-        if (s390_has_certificate()) {
+        else if (s390_has_certificate()) {
             iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
         }
 
-- 
2.49.0


