Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F254CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3Z-00032T-50; Sun, 28 Sep 2025 15:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3L-0002lZ-Sa
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x37-00045A-88
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S5TrJa006371
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4qaCSaQP0VwoBSHql
 r3/GbmsAoZvfXdsqj4tD6XKhDU=; b=pSLl+07FkqvffbaCnnDP2bJ+cMSuh9X3q
 k6/9YlG5KkoSsdQBXAHTH9P/PY51qcrsef8A6aFEiBWf1ndErZMvcuEGBw0bd+zp
 bbAiKVbi5nIrjA/gnkb28Is536HDOSdXAJfubneya9sXVUeQHNLFFE7U2bh+mZx2
 k/2gSnZvcoVHZ7rmmX7qMRLMRnGz/ceS8bWr/JnIW9KTaZI84n03CfZWL42z1dFP
 rmTDcUvOpfTZpoAemjCeCf2A697TJ0YxkamMgdampdbFg/XXfIXkhNAtOU9+drI8
 yPzqUxcXS8GHVwNRSF5qRmvi8BonQPgOWGwF6S3UQ1KwHyRjbiZ4A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7ktxq0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH0Mq0003369
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxk00k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQu0F27394318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:26:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4F4020049;
 Sun, 28 Sep 2025 19:26:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0EEC20040;
 Sun, 28 Sep 2025 19:26:55 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 13/27] target/ppc: Support for IBM PPE42 MMU
Date: Mon, 29 Sep 2025 00:56:15 +0530
Message-ID: <20250928192629.139822-14-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68d98c06 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Uotnjwh7_nUNd4_WO1gA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: aF7TubSZnfJ2yImkQo1XxsW_fswXKOO_
X-Proofpoint-ORIG-GUID: aF7TubSZnfJ2yImkQo1XxsW_fswXKOO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXwFumKZyqOo4a
 0aFECQkazpvKAqm3qHoOpXz8azRoO35ko3OLD+bsUYLvnlI/aOMW0wVJKSbCLtdKQB1qFkp+SUN
 s6B1lah7M+Z/wu7aRhSYDXVXXq27zfOU55XWtfHc2TApusl0fqSE5rJbbOKA5Gsc3muCpb1xgDI
 CxQaK42IcD8BpKMJhj0rKGdoVaacOuf04N34vaEObjiZqA29hzc1fSqHgpFlJ+C3MygW//ksxf3
 InDb7HIvS7cG8aA773WdB/cLPoyFOK4yFVbqei2I0xgXfqxxYggDMK59VIS+Fa7qgFi+8vR3A5x
 NtLXJvjlKKzxSgXH+lffJ1xOGoyFO+zDkGujGvuXs/yIZizT/y1yYVynh5rbjjKfbvZzxfgVdEo
 mIPbSJNal3QDPPH+Hz0ByzrGLgX8kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Glenn Miles <milesg@linux.ibm.com>

The IBM PPE42 processor only supports real mode
addressing and does not distinguish between
problem and supervisor states. It also uses
the IR and DR MSR bits for other purposes.
Therefore, add a check for PPE42 when we update
hflags and cause it to ignore the IR and DR bits
when calculating MMU indexes.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925201758.652077-6-milesg@linux.ibm.com
Message-ID: <20250925201758.652077-6-milesg@linux.ibm.com>
---
 target/ppc/helper_regs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 41b7b939ec..a07e6a7b7b 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -186,6 +186,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_LPCR] & LPCR_HR) {
         hflags |= 1 << HFLAGS_HR;
     }
+    if (unlikely(ppc_flags & POWERPC_FLAG_PPE42)) {
+        /* PPE42 has a single address space and no problem state */
+        msr = 0;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (!env->has_hv_mode || (msr & (1ull << MSR_HV))) {
-- 
2.43.5


