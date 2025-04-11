Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87999C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 09:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Aaz-0006hA-Rb; Fri, 11 Apr 2025 05:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u3Aax-0006fd-6H; Fri, 11 Apr 2025 05:22:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u3Aav-00066U-51; Fri, 11 Apr 2025 05:22:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B6W9Q2003721;
 Fri, 11 Apr 2025 09:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aiPBQP2nvMDH0TXRo
 ULYVW9tW/bKMZqoQBCRXBeTiCs=; b=AOte/uiiiNDRaIANK0jJBiwuaO7Ice6G+
 4sOvkzGYW3lFeHM8CF5mmoWdFfMescsG3LhHBQq1jLtUXWaYuupOi5C6evDQkdsx
 yziRJiRiyv2TMXXXNN9Elm1bEVegSxnOsYvpjQ2Osw3uBHutTiyPZrk/h0+fx9Pt
 vkFhaElxbCPbDZnroz4twWLqU2W7Lf4mHKxey18zkAg+KlLdvvhArTCdyRKjS4aH
 YIBNJOHIluYt0eBkO+OnDe+G6sDSPzab8kcfmviuF4hmt7guc3HbCY2Zb2BbPKQH
 rAtsRnpGCz0L8EU3w14XyozsVsGqoXtobQu8v7mGSWi8QUgYrrE2g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xe13wfby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 09:22:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53B6P9do013932;
 Fri, 11 Apr 2025 09:22:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufup29r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 09:22:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53B9MbGD28050024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 09:22:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 153A05805E;
 Fri, 11 Apr 2025 09:22:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33BF258056;
 Fri, 11 Apr 2025 09:22:36 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Apr 2025 09:22:36 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1 2/3] target/s390x: introduce function when exiting PV
Date: Fri, 11 Apr 2025 11:22:32 +0200
Message-ID: <20250411092233.418164-3-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411092233.418164-1-ggala@linux.ibm.com>
References: <20250411092233.418164-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JSYgWsso_Mz8Xf6MCWxHu7kL6yS9vfDk
X-Proofpoint-GUID: JSYgWsso_Mz8Xf6MCWxHu7kL6yS9vfDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=731 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110049
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

introduce a static function when exiting PV. The function replaces an
existing macro (s390_pv_cmd_exit).

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 target/s390x/kvm/pv.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 3a0a971f0b..b4abda2cef 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -59,14 +59,15 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
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
+    int rc;
+
+    rc = s390_pv_cmd(cmd, data);
+    if (rc) {
+        exit(1);
+    }
 }
 
 int s390_pv_query_info(void)
-- 
2.49.0


