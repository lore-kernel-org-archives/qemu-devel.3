Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26D9C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 04:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIKK8-0003bU-7i; Fri, 23 May 2025 00:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKK3-0003Z3-G0; Fri, 23 May 2025 00:47:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uIKJz-0002OK-VL; Fri, 23 May 2025 00:47:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MNW540030252;
 Fri, 23 May 2025 04:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LtsTZq
 tvSg46IPPHnxprxAbf1CrgiaEhnoM3ic+Xd6M=; b=rRfHfpZGtTjoQHl/8xLJC3
 AyhdqWbYVlsnKbDuA0flrdgUWPzYWxB6r44BeajaQSkeQkQygp/tl+Tn69FERPw4
 h33owgIKtz3gYNSNE/LRuYPl84haEV7XFVXfqLxsGK6TIsOmz4x7l4yIS1vvKkWu
 deZPeH+q3t2CZ11RltybzrRVwDWuFykJpxpl7dwzWxd6FYGo3/MAWChIgCTfdBYV
 ydSONX4brR02yO/2oEOzwurVoKRnYW3MRiDt7g47i9fcqcSTPd4NoxpTLE3m4GAz
 uFk2oSxdnYBfaA6J0Qb4f9oTAV78m49juRHszDulnwxKQsEpzA2MDAkfyNPjp4nw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t669k85h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54N1TBC5020733;
 Fri, 23 May 2025 04:47:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwkq4wuu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 04:47:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54N4ljtq62980420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 04:47:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0E515805D;
 Fri, 23 May 2025 04:47:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11F4B58057;
 Fri, 23 May 2025 04:47:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.208])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 May 2025 04:47:44 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v10 4/4] s390: implementing CHSC SEI for AP config change
Date: Fri, 23 May 2025 00:47:41 -0400
Message-ID: <20250523044741.59936-5-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523044741.59936-1-rreyes@linux.ibm.com>
References: <20250523044741.59936-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RrPFLDmK c=1 sm=1 tr=0 ts=682ffdf4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=6lWZeWWzXn-IPcWKNDYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BkTi5PmcSK8A2ElRFn0IeyKM7xW800wU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDAzOCBTYWx0ZWRfX8WCy4MQxYen0
 FuoKaaY8eO2fAag6pDfW4xs+XJcX4kLotk9nG7FYVo5ATFvoFw5iQLpMw0LeSqg3Mcl4bNvQ5sn
 PinDx3rGxEKZ89Q9Opk7dv0MD/M+shOTKftMYGaH8m+qZH7VhwaKTGA2iiuTIx/MBeP6nHQAqcY
 f3F7SUdG18kak5G1NcK1E/y8INroX+XdktJtZP0O2TwFU+SLPv3by2/0K6wgZlMFYHWjrpd/KfT
 Sgt8mDCEkdV1t/0ZsWc5xZzaMlzFqEVSASKwaoi0hg64mesc21quhIVjetNe0T0NnBG31kcwqr8
 X+G/kDcxrlo6+rJl18HqxR3lqD+Rquh7kQ00LgrTpDfi2k5w10MUp2Izvm3r3Mdp1RI0kbcS3Xo
 Fi+Q9V2y+hT2E6NvV2/SKihoE7L5z3bhLNyjsklbUw+MKJy3CA+8B7P7x2m4ZuhH2TVpRUcN
X-Proofpoint-GUID: BkTi5PmcSK8A2ElRFn0IeyKM7xW800wU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230038
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
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS           |  1 +
 hw/s390x/ap-stub.c    | 25 +++++++++++++++++++++++++
 hw/s390x/meson.build  |  1 +
 target/s390x/ioinst.c | 11 +++++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 hw/s390x/ap-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7060cf49b9..444523a35e 100644
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


