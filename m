Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585E3C61DB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNbwq-0004Jd-5x; Fri, 06 Jun 2025 14:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwX-0004Eh-TL; Fri, 06 Jun 2025 14:37:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uNbwV-0008JR-R1; Fri, 06 Jun 2025 14:37:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556F5B3H020624;
 Fri, 6 Jun 2025 18:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fVzaY2
 45JOK2WHnWPfZaG3KcQG2OjmEdw7QvliX8y8c=; b=KkV/uJOImg1KolMQabNjER
 l5GdLmPL/8B07w/Oxapcc+41/cT6Fhlue1H1DJj65U5Z97I4qHE47DfCOlok8wXP
 TGduEpqdq1QTyYv12MKTC8ThiOetoLB8gTPzEdyrZSQ9n7mu0tyeJU66rdcAS4QZ
 LYj4Y+LKXa6HrincdYLkgTfB2B/bA65e3pkJyUJKIyJlgjq4jnezzEa5r/OW8g4B
 ckverQ7AFnHljruOgbjsna2GQWfOv3wjFOH9a2DAVmT/ciTjSXwzXY5XQDXMunvw
 Ptz2pM09QTkfpmxoVxeQiLH+RZKMiLa2tzhsSnF3A4njehuAtfKD7kFbarryrNyw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf08689-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556FfQPw028437;
 Fri, 6 Jun 2025 18:37:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 470eakthwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 18:37:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556IbNbg31982116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 18:37:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B0AE58059;
 Fri,  6 Jun 2025 18:37:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09E4058053;
 Fri,  6 Jun 2025 18:37:22 +0000 (GMT)
Received: from MacBookPro.ibm.com (unknown [9.61.255.166])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 18:37:21 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v12 4/4] s390: implementing CHSC SEI for AP config change
Date: Fri,  6 Jun 2025 14:37:16 -0400
Message-ID: <20250606183716.26152-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606183716.26152-1-rreyes@linux.ibm.com>
References: <20250606183716.26152-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J5v5cy4ZD-4y6DlMlF13VNk_ORNaEpOi
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=68433565 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=uLlxcZOcU1Y7BrJQP9YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: J5v5cy4ZD-4y6DlMlF13VNk_ORNaEpOi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE1OSBTYWx0ZWRfX0pMg6ZanIuPF
 4fOdY4PRWM+02CuS15HxwaY0fWPVUC5420MMHSE2bG/BTPv6HXi7kYk9LmMF5QGMSPjPrUIChUj
 1dqtAzynSMsIICKwsu+Uye8DJlROe83rIvASMn6Q6TtM1FIEiQQwv2Wxy94aN8yqgqi2VO/gCux
 uHofBcAh+p5+x/eoAijAiOMjc6AaT5j3ebAsvy0xALnJk91rThpYIKlHA+LQcMxCNIA+UvmeQHB
 MirgX95NzT+2ol6aRNj8/EutVEC6wMv69yMn2J/VkNNHYaqCji1rNL80nuFMfk8xSQuyxTz9tND
 KRKhI57cCHN0H9cBw9lWvSlmLoesNdPfgfjJ+A588K86EyUq1Kef4xCG6J6MkLeDzCFVdlfG77V
 mq5p0/7Qa0evybxPIL97NZ8XV5r8PT4Sw2oveqbsC7ZEZtqcuTI6gHeQ8OmZTpcv78yjtFWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_07,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
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

Handle interception of the CHSC SEI instruction for requests
indicating the guest's AP configuration has changed.

If configuring --without-default-devices, hw/s390x/ap-stub.c
was created to handle such circumstance. Also added the
following to hw/s390x/meson.build if CONFIG_VFIO_AP is
false, it will use the stub file.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS           |  1 +
 hw/s390x/ap-stub.c    | 21 +++++++++++++++++++++
 hw/s390x/meson.build  |  1 +
 target/s390x/ioinst.c | 11 +++++++++--
 4 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6763077e..1e84bfeaee 100644
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
index 0000000000..001fe5f8b0
--- /dev/null
+++ b/hw/s390x/ap-stub.c
@@ -0,0 +1,21 @@
+/*
+ * VFIO based AP matrix device assignment
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/ap-bridge.h"
+
+int ap_chsc_sei_nt0_get_event(void *res)
+{
+    return EVENT_INFORMATION_NOT_STORED;
+}
+
+bool ap_chsc_sei_nt0_have_event(void)
+{
+    return false;
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


