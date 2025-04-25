Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E66C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 05:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8BY7-0008W7-7b; Fri, 25 Apr 2025 01:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXq-0008Tr-E7; Fri, 25 Apr 2025 01:24:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1u8BXn-0004HM-UN; Fri, 25 Apr 2025 01:24:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OISIg4001038;
 Fri, 25 Apr 2025 05:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=j2lYSG6CJU+JTlrLB
 tdCxHVpBpMWDJrmlEnYf5pSVro=; b=ryejpvxn6H86MFdqBxtN9morAHSMv8S5A
 ikzuDOhmOTOSlyWb/OLysvEINOeyb5gxVVMIZ+Rr7uDHGKlwHy0B3mwtHjPsdtIn
 11YmXgpAsa/bVs8hsCP/j3xwbrPQ6o0lvyCs9piCzDvcGrstmP5TpiYVIzBa8vcB
 hAEk+WL9p0OBKkpbJBmiiZrfLC93bfvPScHZAVTuRPmc6xHXkHK58PNwFO9vR1QH
 6wtoLw0ejjaxIW+sinZnP1YoA4XF+2R5W1IziV6L4K1g66l3HxEhV/fHT3HtF2nN
 jT1zOZAoObZk5rnV5dSN+kznkEOnptAEfDdsWxJaLUfQh2U1Wn5CA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467k7k4tej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P3HkV0022271;
 Fri, 25 Apr 2025 05:24:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxkr0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 05:24:09 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53P5O8PI20906750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 05:24:08 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27FDC5805F;
 Fri, 25 Apr 2025 05:24:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AE6B58051;
 Fri, 25 Apr 2025 05:24:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.253.76])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Apr 2025 05:24:07 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [PATCH v7 6/6] s390: implementing CHSC SEI for AP config change
Date: Fri, 25 Apr 2025 01:24:01 -0400
Message-ID: <20250425052401.8287-7-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425052401.8287-1-rreyes@linux.ibm.com>
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bpZOmcsHyONXK_FUYgsL6n-vEFRgY6ms
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDAzNSBTYWx0ZWRfXyZPWYz30L3au
 14kC79JoCY0LlFwQ+kz7yDteTPVqFEGYNzF6ubY1VRpp20G3JXT392A/1hItJZ4qKbkcFpa67IQ
 fmh+dvsAtjxEErrVEAhmlg5/nToIXptc07W+KH/5Zab7etPRHwW6AcMZC6BzRz56EJv0j8tTcnO
 TwF9vd1OKdNLb6uvzYvMSq4L2JLNnKP2FWXGFat2jd35gbFN0mtCKRXoOHP/hXexeR5mjYp1hhD
 rjPqjxYn1X2vM17XYMbTike52SBaH/vaFIvDoU8ieraE6B8bnFLbSn/qZqKSHWSMTBT3C31qLgF
 8vForRtQFg8EeDYZrZM9cPTeUMiVAi5LMVdfkSkW9FpFIZJvFVKlfyKQ2AnlIqLWhqOaYVk3+MV
 209zQTtuOXZ+VdUr32I7tp/VJGQrrh22rzXHPbSNAGkEoYTdrlJ5vFawb8OUneQWJvyKw7Bg
X-Authority-Analysis: v=2.4 cv=KZjSsRYD c=1 sm=1 tr=0 ts=680b1c7a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=cXSfBGZelckeR0FG7_wA:9
X-Proofpoint-GUID: bpZOmcsHyONXK_FUYgsL6n-vEFRgY6ms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

If configuring -without-defaul-devices, hw/vfio/ap-sub.c
was created to handle such circumstance. Also added if
CONFIG_VFIO_AP is false, it will use the stub file.

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 MAINTAINERS           |  1 +
 hw/vfio/ap-stub.c     | 23 +++++++++++++++++++++++
 hw/vfio/meson.build   |  1 +
 target/s390x/ioinst.c | 11 +++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100644 hw/vfio/ap-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 661a47db5a..ad85d081e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -112,6 +112,7 @@ F: hw/intc/s390_flic.c
 F: hw/intc/s390_flic_kvm.c
 F: hw/s390x/
 F: hw/vfio/ap.c
+F: hw/vfio/ap-stub.c
 F: hw/vfio/ccw.c
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/s390x/
diff --git a/hw/vfio/ap-stub.c b/hw/vfio/ap-stub.c
new file mode 100644
index 0000000000..9d2c4c2e67
--- /dev/null
+++ b/hw/vfio/ap-stub.c
@@ -0,0 +1,23 @@
+/*
+ * VFIO based AP matrix device assignment
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
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
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index a8939c8386..28f4c959b8 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -11,6 +11,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
+vfio_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
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


