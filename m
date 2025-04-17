Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F67DC369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 12:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5OWf-0001wS-4h; Thu, 17 Apr 2025 08:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5OVM-0001Nx-F6; Thu, 17 Apr 2025 08:38:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u5OVK-00039H-Bf; Thu, 17 Apr 2025 08:38:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H9Zrfu014932;
 Thu, 17 Apr 2025 12:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=sCCSf9R+vWDhK7Hl5
 gwg2YW6AI3FtJLiS8RPAVgQBqA=; b=LCe0YcgfFYsW1cs1yvotEFRJPBu80cnXv
 9YH2/jEIft26xkkj8gMkIfAt0yItc09LkrvbvP/VDezInaMpkFumzkpTtm1FIrC1
 x7yX6uyPPkIEhmCGMVgl+ottO/gRFkRXqU6/q7xdhWgiTjTHCG7pOwFWUVzLa8Rb
 q1Zp28U6OYEN/UY9JEj85/CzqrRTltKohn7DYeGKnl64jL5MT5fkP0CZJGES+Otu
 mlM0cFByP+91Q6qZBOIxy4CAcVn0vWpgeTFkMBzl+UmXPIDrIvy+fUr/H3NegP0b
 YSH65HdDzF3piyg00QltZkuEmPaEfKqe8D816WELsqOaDK86G+wJA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mn7ugks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 12:38:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBiAaW010438;
 Thu, 17 Apr 2025 12:38:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qkdck2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 12:38:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HCc0HM28967590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 12:38:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6F7058052;
 Thu, 17 Apr 2025 12:38:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE47558066;
 Thu, 17 Apr 2025 12:37:59 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Apr 2025 12:37:59 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v4 2/3] target/s390x: Introduce function when exiting PV
Date: Thu, 17 Apr 2025 14:37:55 +0200
Message-ID: <20250417123756.729132-3-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417123756.729132-1-ggala@linux.ibm.com>
References: <20250417123756.729132-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ANnAolku c=1 sm=1 tr=0 ts=6800f62b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=wThvhrd033kK1bniQ4UA:9
X-Proofpoint-GUID: s3wWMjOORkPRLGqItgnDxcBhi1pR2K7M
X-Proofpoint-ORIG-GUID: s3wWMjOORkPRLGqItgnDxcBhi1pR2K7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=791 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
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

Replace an existing macro (s390_pv_cmd_exit) that looks like
a function with an actual function. The function will be used
when exiting PV instead of the macro.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 target/s390x/kvm/pv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 3a0a971f0b..66194caaae 100644
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


