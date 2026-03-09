Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26C1EA852F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObm-0006NZ-H1; Sun, 08 Mar 2026 20:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObg-0006L0-JU; Sun, 08 Mar 2026 20:36:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObf-0001fB-4X; Sun, 08 Mar 2026 20:36:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628Ni7el1643088; Mon, 9 Mar 2026 00:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HLx3Mu+NgaVHppkso
 mvj1s6zgG4sLA3O4PUaVqcKOxA=; b=X6q+M3aY9CloHbVXBu7oEJC6uUTw7t8TH
 YWe6hhv3zYya4hMBs1fKcEP7Tq6FVre/QVYHvLGIV0AURAQpcYTz8J3gBGyEe6Rz
 9EDyKwghLb+6rzySPYwk5W31V3T5OswXfwEAjciH24Gxi5vFbapsAmba9eSlHpnY
 BCPYfdl0I7uMxak1FB9sHdjcWZ4hz3nSyYJKaWUV28NSbAqDY0CYxTYMBPqY2l7B
 oknZFzjxmm73Ah87LmmySoBiJBN4+FfJcR/43lU7w3JoUY4wAOvBzQB42n7JXVe4
 Ts/WeKcTPbwFY+gO3d7a82iSVBbzYlIBonmchM0xt72SWE3CueqJQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw4kf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628N3hPJ025041;
 Mon, 9 Mar 2026 00:36:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjtt9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290aJuZ33555122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F14FF58050;
 Mon,  9 Mar 2026 00:36:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D912058045;
 Mon,  9 Mar 2026 00:36:17 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:17 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 07/15] include/hw/s390x: Move CLP definitions for easier
 BIOS access
Date: Sun,  8 Mar 2026 20:35:53 -0400
Message-ID: <20260309003601.242634-8-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX2i3O5yMl+6p/
 Xb2kHTt4AnnGiXXApboji9/U4OiK7+RZF4yCs9gMlbdMHqno/u15Z07ATDdTlai/3aKnLbrkYM7
 ZJCN41X7L3BfW2Xo1F338DTFQIGEX99J4IqzeCk3/PbFUI0W48VDBj6dvr1TND3dOlNiZTF2mmW
 QFrplIwMyKoE/nErmThRLzpfRIOwhbrqwynNHLV+myL8LlNfhuxKBOjzInb95zq8jQlSTO1dI6e
 lTPPSfep3XLwhMUQcjx2I80k3rU7+qPZkrhBS6ZagTJZucxrPHyHngL8rFNAffjI3cjB86QsQtu
 rsZWVAtyvTnbfACLHjKQAs6nJ0AO+I+C5MOWu7EJzjmQKqZNvVeDyCNMRGEQIYZfzgyXFMyZ4E5
 LZsvP3EIlFb8D4tmVidhJmR+J49E1oEnmUZ3hD6pQHjUaUwJdITeepajcRPGfdQUnX+xwOzI4JS
 ADebi3yr/U1VrBvUyoA==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69ae1605 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8
 a=tAEn9mKmgxsDd59HE_0A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: oIwZTwf4TedneHWi2_JcvQudLSQQREjW
X-Proofpoint-ORIG-GUID: oIwZTwf4TedneHWi2_JcvQudLSQQREjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Move the s390-pci-clp definitions into the "ipl" sub-directory, which is visible
to the s390-bios.  This allows the bios to reuse the architected definitions and
prevents code duplication.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 MAINTAINERS                               | 1 +
 hw/s390x/s390-pci-vfio.c                  | 2 +-
 include/hw/s390x/{ => ipl}/s390-pci-clp.h | 0
 include/hw/s390x/s390-pci-bus.h           | 2 +-
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename include/hw/s390x/{ => ipl}/s390-pci-clp.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6730cee490..80e10e43b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1882,6 +1882,7 @@ R: Eric Farman <farman@linux.ibm.com>
 S: Supported
 F: hw/s390x/s390-pci*
 F: include/hw/s390x/s390-pci*
+F: include/hw/s390x/ipl/s390-pci*
 F: util/s390x_pci_mmio.c
 L: qemu-s390x@nongnu.org
 
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 9e31029d7a..8ce44dbecc 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -17,7 +17,7 @@
 
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "hw/s390x/s390-pci-vfio.h"
 #include "hw/vfio/pci.h"
 #include "hw/vfio/vfio-container-legacy.h"
diff --git a/include/hw/s390x/s390-pci-clp.h b/include/hw/s390x/ipl/s390-pci-clp.h
similarity index 100%
rename from include/hw/s390x/s390-pci-clp.h
rename to include/hw/s390x/ipl/s390-pci-clp.h
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 04944d4fed..f643e13057 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -19,7 +19,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
-#include "hw/s390x/s390-pci-clp.h"
+#include "hw/s390x/ipl/s390-pci-clp.h"
 #include "qom/object.h"
 
 #define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
-- 
2.52.0


