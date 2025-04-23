Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E67FC369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7VAe-0000qo-Vs; Wed, 23 Apr 2025 04:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAd-0000pW-CN; Wed, 23 Apr 2025 04:09:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAb-0006kr-2S; Wed, 23 Apr 2025 04:09:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fjAA007133;
 Wed, 23 Apr 2025 08:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Th1tHZvzfJkCmyGZW
 nfkdNgj0GGUM+kx7mjUTmOgOsk=; b=XENfLaVfXbE9JH8Hbr1yMQ4Yrd9JpQe3y
 3Z1Z2RDhnU4oTDuin2H07RMAe/eSIBhKvSscw+cwN+dBfCNjnccY94r1K2jbCcTl
 FHobnhcgJ8akFmGscH4ifmswgTaNvBvTHM7ZdO7bc+6bw6mHDec89yxf3OwAdYRQ
 l1XrbDzWLt5hJJ06RQPPAdCOg5JPzkyUauEQRS3OIHTqhKfqdbl8EW4ZK4DqYnCx
 MoZ6A+PMZOhJPcm2AZLgBIskavqsyshO9jSZTyKkFs4cuwjGUbv/1poB+HDrSEwP
 hVaqbJo9lfHAIuz6NlYOV2JV9iJ7gwjtYhnZSH+biVDp78Pi9wMWw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnsa5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6Vrmv000925;
 Wed, 23 Apr 2025 08:09:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxt390-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53N89KhZ15204954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 08:09:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7043958060;
 Wed, 23 Apr 2025 08:09:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F2C258056;
 Wed, 23 Apr 2025 08:09:19 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 08:09:19 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v5 2/3] target/s390x: Introduce function when exiting PV
Date: Wed, 23 Apr 2025 10:09:14 +0200
Message-ID: <20250423080915.1048123-3-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423080915.1048123-1-ggala@linux.ibm.com>
References: <20250423080915.1048123-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zYhXHk4DY8lfUjST0Lrf5RgXFbtSeyHo
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808a032 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=wThvhrd033kK1bniQ4UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NCBTYWx0ZWRfX11x50qhrDBy0
 POnIPgb/YHXTtdH+v7EAH0zXxoxGRMuu15QCYkat4RMWgnVGHcwYYfqC2ubzuIhlCP/3OFnz229
 rKFqKdP9r6BMy6E5c2xn0hzOgl+XqcIjmzw8AFRMqOKRMiv07HPhH6/+L39oUDyE+QDgn8wlFCk
 TBZ0qzF3tOBF6iXQBgk9CdEQbjKtGenIomp8mVhCiIMxCGxTPVf5hRa4aKOcc8Gm0G2EjDhe0tP
 dpBVTwke7QiqUqnQGQ1wEBVFoLKJARs3FQpkat2qsn2oYJcfWP4xVbMpPivt/SQohr9qMSP4H3V
 sxlo+eJGGpDnCPrxJE59Y9nOWNw44OYxqfjjbE+OMtyqhWyA7jcZKM5r+MFmacaqU5fKzLKkpHD
 YxAzC+6BQymR3NC8g0DGld/Hi0idBWqllQy20ombMHfDXoq1oqW6AER42wdHEcsKmYD6X7QP
X-Proofpoint-ORIG-GUID: zYhXHk4DY8lfUjST0Lrf5RgXFbtSeyHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=800 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ggala@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Replace an existing macro (s390_pv_cmd_exit) that looks like
a function with an actual function. The function will be used
when exiting PV instead of the macro.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 target/s390x/kvm/pv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index c1edb860d8..589038ad4e 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -59,14 +59,12 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
  */
 #define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
 #define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
-#define s390_pv_cmd_exit(cmd, data)    \
-{                                      \
-    int rc;                            \
-                                       \
-    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
-    if (rc) {                          \
-        exit(1);                       \
-    }                                  \
+
+static void s390_pv_cmd_exit(uint32_t cmd, void *data)
+{
+    if (s390_pv_cmd(cmd, data)) {
+        exit(1);
+    }
 }
 
 int s390_pv_query_info(void)
-- 
2.49.0


