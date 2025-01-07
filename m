Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C24E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 21:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVGgL-0008UJ-SL; Tue, 07 Jan 2025 16:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tVEYh-0004Uq-NU; Tue, 07 Jan 2025 13:44:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tVEYe-0002ua-7v; Tue, 07 Jan 2025 13:44:07 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507I4BBs012018;
 Tue, 7 Jan 2025 18:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bDtmD3uahoU0Rlnbm
 02OUIfLNADVPIOIcSjT34aX7BM=; b=M/a7FO9iO7+yxKPPSlrwfamuSWvNDkvgP
 mDxktlNae5jUVF0P/dIq/Ha2A7XQvGBeqylWcQD/lOlMehmMUJO9KLIjiVxu1hwY
 6kQF58y5fKr0c+3evqGjERpvz4Q18cdTwKgi4N9+osGX/lHyRToPPrPd2aPGt9Du
 fpvhmfFFdDpSBXZKfqgF6NZN2cXDfoJaakFzgFvODYbWyfbJwRSjTW6w4V/POt04
 ABVJ3MOvvfHYvj26sLO4jsdjpI1l8qaXSXhNMyggisRRMFo1wGbcuRPuubywRh7G
 uLICd55NlqpcndMExdyI1V0OFrcP5t3cy+LYhabCYQbSMmlnOK32w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrcbyeb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 18:44:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507G0thB008851;
 Tue, 7 Jan 2025 18:44:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyv2hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 18:44:00 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 507Ihx0V23200296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 18:43:59 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36A575805D;
 Tue,  7 Jan 2025 18:43:59 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8196858058;
 Tue,  7 Jan 2025 18:43:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.12.78.174])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jan 2025 18:43:58 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com
Subject: [PATCH v1 5/5] s390: implementing CHSC SEI for AP config change
Date: Tue,  7 Jan 2025 13:43:54 -0500
Message-Id: <20250107184354.91079-6-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250107184354.91079-1-rreyes@linux.ibm.com>
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FnjuEUhhMz1D6WwZcQYXv203-TUKo2Et
X-Proofpoint-ORIG-GUID: FnjuEUhhMz1D6WwZcQYXv203-TUKo2Et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Jan 2025 16:00:05 -0500
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

Handle interception of the CHSC SEI instruction for requests
indicating the guest's AP configuration has changed.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 target/s390x/ioinst.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index a944f16c25..f061c6db14 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -17,6 +17,7 @@
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "target/s390x/kvm/pv.h"
+#include "hw/s390x/ap-bridge.h"
 
 /* All I/O instructions but chsc use the s format */
 static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
@@ -573,13 +574,19 @@ out:
 
 static int chsc_sei_nt0_get_event(void *res)
 {
-    /* no events yet */
+    if (s390_has_feat(S390_FEAT_AP)) {
+        return ap_chsc_sei_nt0_get_event(res);
+    }
+
     return 1;
 }
 
 static int chsc_sei_nt0_have_event(void)
 {
-    /* no events yet */
+    if (s390_has_feat(S390_FEAT_AP)) {
+        return ap_chsc_sei_nt0_have_event();
+    }
+
     return 0;
 }
 
-- 
2.39.5 (Apple Git-154)


