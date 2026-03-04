Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC65EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcSo-0002SZ-8w; Tue, 03 Mar 2026 21:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSa-0002OT-JM; Tue, 03 Mar 2026 21:59:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSZ-0000WY-2f; Tue, 03 Mar 2026 21:59:40 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6241iEEB481611; Wed, 4 Mar 2026 02:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PISeczBSyswsLrVxV
 C7ic/B9wKXGF2IF49tkk6HFvIM=; b=gDUAQSQRAisqCJbKlxJbri1QCiD5CtcFt
 4tAIGfNgcDVr2mk9dr+o0rS1VUfK2qE86/X96Bt4rwgMqic4fz2WqClThrHrHE90
 Iu09s61Ps0uHBibhmgx9vtsGdaYmT0dmpwrOrcvcz+Ip6D0s7TUUwRL99wl5Y/8b
 QifGje7ppvTwXVQDj8cOsINq2f1EpWT6fS4/P8hcjl4XPeZ80RjRTQ8JY9lS5NYC
 So0worJEuefcHIByFcaQT6XcpEqwFN6kO55cuGOlsLebgM27hM8nCuXjJ6VEyOxb
 RhWByJpFW3MqHurosALknGy20RjjMbFBg9/RJR23XmtowPkuJGTfQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmncr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623NBCpn010305;
 Wed, 4 Mar 2026 02:59:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k4xek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xZMS29491882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B32FF58063;
 Wed,  4 Mar 2026 02:59:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F6A058053;
 Wed,  4 Mar 2026 02:59:34 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:34 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 07/15] include/hw/s390x: Move CLP definitions for easier
 BIOS access
Date: Tue,  3 Mar 2026 21:59:09 -0500
Message-ID: <20260304025917.2157032-8-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX7dxnB/K5gE2C
 jH/DKR0gB2Xu/cc7gEP/NaKHpTVhTWyZRRH10XKOD1DxysZVLuqMAt2NbpBGdzwshZlc1+pkKB4
 pIzRMGyhfXRyZE5deRisbwMUzGN48YruLWVzQf8qZbYwZdKr4irdXVH4J67LybzVOuMuzDDgZLP
 VYhHfTG+DCznNb6ZcMmU9dv8suYIeknzgxwhitwxGEj33OK2tg4Z5ezuaQfTne9pqAk/k962G8M
 eKT2ukso+sMKiRpVKlAWiz6XXlz3eOnjxmDdVs3g8Rhi3JVifyLvh0JsHjeL4f6llPRtwvW/XOU
 qRFdXsxX4Rdr9CYhwpF8XXGuvbTBA7uv256Q8DKBoWOy+XZMMA7VcoOVASkneA8lCCuAkZ54P87
 rE4UgAAQZZwzB30qh9RPd7CqtqMcL+Rso/tzs8lFmG/Kg105N0bE0jD8e4vxDSuhwfJqs5UYj5z
 JPBCweDWHap7ZzW9QbA==
X-Proofpoint-ORIG-GUID: LuWGtWCmkJtUKioGPGZDq3FUGzmbZ3bO
X-Proofpoint-GUID: LuWGtWCmkJtUKioGPGZDq3FUGzmbZ3bO
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a7a019 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8
 a=tAEn9mKmgxsDd59HE_0A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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
index b8317fab31..54a600f76b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1892,6 +1892,7 @@ R: Eric Farman <farman@linux.ibm.com>
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


