Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4CBFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHibZ-0005ZJ-Rn; Tue, 28 Apr 2026 09:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Gautam.Menghani@ibm.com>)
 id 1wHfoN-0003hE-Na; Tue, 28 Apr 2026 06:37:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Gautam.Menghani@ibm.com>)
 id 1wHfoL-0008KB-To; Tue, 28 Apr 2026 06:37:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S8Y6G2036865; Tue, 28 Apr 2026 10:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Fmr4fsjDCSje8LaRXFevkKK/e5kpy7KbCEwat6mo5
 wg=; b=WT6d33Xg1CjkMnPYjgKqeINiniulyzxCJVQ7rhyyW03sB7fnG7ksRJ2TN
 m84GYQLI7D1sJGNHcuKlsuHLWrct8J+hA1XqLJ0RwOCwFfiU5IwLCikH3SxILPCc
 WpW+cgfpBU/hLmPx/o8nCQNc6nSHzidFwiD7umA+72hIRapu/0GamfA68KoVpbUw
 xoQvJnSalu3va487ZhqYf5Yl24DUjueyuz2WIB0E6xs5uNKds7rpStQ3utpv6ZJf
 63fWb/X8mhvZLiZL8UUYlbEeS9QoV6CP6lM7lHlQm/Ifv0sa7m836ym2Cr/F0k5Q
 JHk/bnQuAqTGKsjUTP7uR7E7CkYfw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1duw9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 10:36:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SANvJ5001198;
 Tue, 28 Apr 2026 10:36:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy917p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 10:36:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SAareX60621098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 10:36:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F6692004B;
 Tue, 28 Apr 2026 10:36:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D712220040;
 Tue, 28 Apr 2026 10:36:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.36.19])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 10:36:51 +0000 (GMT)
From: Gautam Menghani <Gautam.Menghani@ibm.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, adityag@linux.ibm.com
Cc: kiki <Chan9Yan9@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Zexiang Zhang <chan9yan9@gmail.com>, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v2] hw/intc/xics: Add a check for an invalid server id
Date: Tue, 28 Apr 2026 16:06:44 +0530
Message-ID: <20260428103645.50617-1-Gautam.Menghani@ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: niRNXtms5A0aSykIOvL3piamIEvrHa-I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA5MSBTYWx0ZWRfXya1fBzqhH+Z0
 JdHCadIdHXuPao0K31kzLe5R17Wou/7mCyKPqyZjDlysAg2Sl09EarhV8BO6Kf+u6OkSM7SPF0a
 dkQ4WAGvB4QaLULFLZKiEOoa+M878gU8TIt4X6wta24nmbU3dQ9tG47uAFDrl9nLXdaJyM+jOZF
 HpVMRXS1gPNV+8iIEl4sXieezYh25z0NByTwXSUCZMQfQNtupZGar4PlrnyGWxwbzVgg1gtCHe1
 FVs2ELbD+lYAF8OyXakHn3RCkQnTGbUdiM5L0RuSVXhwIniQ9fzgEpef07t6mrVmYV2lWoVzd/v
 eGoanjFGiZ8HSlQ94E3oGm3QHf6KfZFV2RxhnUQJlptpvjO4kunNqK93BJe1EoM52Ci/CxYfqeo
 Bf+sOimb49JunIVBC2kh9MfmKX924okg8NehCh+JIbwX2E+67HaRoeaYqFLC5vDFnyfFNAEthva
 85zEpcJ0p8rGuzKZQLA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f08dca cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=gDGxtpEj6ED9AaWiFCkA:9
X-Proofpoint-GUID: UrssTfQayPXaH2P0i-Va2YOmuDEpzajl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280091
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=Gautam.Menghani@ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:36:00 -0400
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

From: kiki <Chan9Yan9@gmail.com>

A malformed IVE value can result in an invalid server field being
passed to icp_irq(). The function assumes the server id is valid and
may access invalid state otherwise, potentially leading to a crash.

Fix this by validating the server id before using it and ignoring
invalid values.

Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2:
1. Fix build error and subject line

 hw/intc/xics.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c0a252d051..e32984e9fc 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "trace.h"
 #include "qemu/timer.h"
@@ -222,6 +223,13 @@ void icp_irq(ICSState *ics, int server, int nr, uint8_t priority)
 
     trace_xics_icp_irq(server, nr, priority);
 
+    if (!icp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ 0x%x\n",
+                      server, nr);
+        ics_reject(ics, nr);
+        return;
+    }
+
     if ((priority >= CPPR(icp))
         || (XISR(icp) && (icp->pending_priority <= priority))) {
         ics_reject(ics, nr);
-- 
2.52.0


