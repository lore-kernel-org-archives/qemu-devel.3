Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C35C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXUL-0006ZL-72; Mon, 12 May 2025 14:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uEXUE-0006Qn-H6; Mon, 12 May 2025 14:02:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uEXU9-0007wq-P1; Mon, 12 May 2025 14:02:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CA5u85018642;
 Mon, 12 May 2025 18:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=r/yylGKp+Ls7eKR7A
 1kCIEIXbE4MHcZoZTAMPHghzPs=; b=f3MCHios5ogMzIno5Fm7k/D6GGqhZ1wpc
 yv62tbuNQEMyIFu9gT204X0a7MQFh+MWXUAQc0yOkws8eR24kiKRF9F3x425DNFe
 Y7bOWarUSYQ75WwVm810ou546nVciJBgiUHhE/dExgqzq2q8MFyYG5l7FD6526cK
 9a6kNG/umUeyWQn18/o1OexiFGA7lFcLTzdJxLtw6F6dGRFidPHjV0peCWBZiaT1
 oOTI7+KG+1q6U9FvOsVb56JZhh8hQK6aHDf5tfx22Rm2Xvg0M2nCpKuB1p6YTr5M
 e14Jyf+LwLvaPM5yy7Py40ikIvlsDee25yz2uN0Oha/cPiTcBAC0g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1h8cwuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 May 2025 18:02:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54CI2WBI024470;
 Mon, 12 May 2025 18:02:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jjmky2qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 May 2025 18:02:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54CI2ZhZ63701264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 18:02:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 563EC58058;
 Mon, 12 May 2025 18:02:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94D8658063;
 Mon, 12 May 2025 18:02:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.251.19])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 May 2025 18:02:34 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v9 4/4] s390: implementing CHSC SEI for AP config change
Date: Mon, 12 May 2025 14:02:30 -0400
Message-ID: <20250512180230.50129-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250512180230.50129-1-rreyes@linux.ibm.com>
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fq3cZE4f c=1 sm=1 tr=0 ts=682237be cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=BcS6lGtn7vpLOzzWGCAA:9
X-Proofpoint-GUID: 6bKiOUFkaIrkqbB4fl7zUkPrUdmY6VSe
X-Proofpoint-ORIG-GUID: 6bKiOUFkaIrkqbB4fl7zUkPrUdmY6VSe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4MSBTYWx0ZWRfX4urj6bK1wy7m
 bz8RtszxkhNoufj3UZr2DjgZeV0/EHcZOkRt0bDxxcKeYvoL96vfK7+MXSWgETktzmY1yFPWLn6
 33QrPU6mHLwjLgHQk6qp1uUNCW0UXhoX9XUb1AH5RLu+9kqzvCuw1fPtWdfiw5KC6Eun11SFTGL
 r70m5oBw4dC6hJahpo+4HFDKO5+1tTdFq4bqDwpvelIxGya6lqmZ/afbllLFnMlraOuR1STZQe5
 j5OKPZZzzSSMlNAcQ71t6somEeXd/eN83XgwfTeYLR4G2sw0o/g16hgFrCIjoLTq282B2uGREfu
 +QVo/aOK4wyOejIWSpwHPHxmvL1+z1cxgGDGh812AeN3qexxoX1z66/aw6lI03qEvxI1Wkk29O0
 Qk23Jvt3doMmTaBkOdBNE1Jg8n8lLafel4eRLDKmQ6NcLzWBrj0eOxr2YngYDt2Lo7Ay8cpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120181
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Handle interception of the CHSC SEI instruction for requests
indicating the guest's AP configuration has changed.

If configuring --without-default-devices, hw/s390x/ap-stub.c
was created to handle such circumstance. Also added the
following to hw/s390x/meson.build if CONFIG_VFIO_AP is
false, it will use the stub file.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
---
 MAINTAINERS           |  1 +
 hw/s390x/ap-stub.c    | 25 +++++++++++++++++++++++++
 hw/s390x/meson.build  |  1 +
 target/s390x/ioinst.c | 11 +++++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 23174b4ca7..070c746c69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -112,6 +112,7 @@ F: hw/intc/s390_flic.c
 F: hw/intc/s390_flic_kvm.c
 F: hw/s390x/
 F: hw/vfio/ap.c
+F: hw/s390x/ap-stub.c
 F: hw/vfio/ccw.c
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/s390x/
diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
new file mode 100644
index 0000000000..e2dacff959
--- /dev/null
+++ b/hw/s390x/ap-stub.c
@@ -0,0 +1,25 @@
+/*
+ * VFIO based AP matrix device assignment
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/ap-bridge.h"
+
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    return 0;
+}
+
+int ap_chsc_sei_nt0_have_event(void)
+{
+    return 0;
+}
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 3bbebfd817..99cbcbd7d6 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -33,6 +33,7 @@ s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
 ))
 s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
 s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
+s390x_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
 
 virtio_ss = ss.source_set()
 virtio_ss.add(files('virtio-ccw.c'))
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index fe62ba5b06..2320dd4c12 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -18,6 +18,7 @@
 #include "trace.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "target/s390x/kvm/pv.h"
+#include "hw/s390x/ap-bridge.h"
 
 /* All I/O instructions but chsc use the s format */
 static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
@@ -574,13 +575,19 @@ out:
 
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
2.48.1


