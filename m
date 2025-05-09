Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6220C3ABCC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQil-0002Ap-Kv; Fri, 09 May 2025 12:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQic-00024t-3q; Fri, 09 May 2025 12:37:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uDQiU-0000Cf-Tg; Fri, 09 May 2025 12:36:59 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549EEOoN031556;
 Fri, 9 May 2025 16:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=52DjofBsUUNvOfdOV
 weJIlhF2WxSR1eGUCP9z5rsi5I=; b=RcBWsB9BZya0QkvvtXghs9FT7USOcgtlq
 0nN4paiZoVS0cwwJPnjxCB8uYw93nVEGqoucjCFI9//ix/l95pA2fYJE6whYUzZd
 F59qerv5c24RSAAOL5JhAYw5sqLlCVP7kIv8vt0XI7hlFUX1VstOAWkvJqJnZJHt
 Uns1f/qI8Z8Eff35919a27XIz4FxZsSwZCgFGf+2o1CBICZPZ3qwtlu3zgiGdP6+
 bwFEkzFodIWjeHuw34IHTcGF2AHSqXJGykBEQw02djlFmtHYbZZ2RaSe05FKWcVQ
 Eyp85a87pNGoxyFsDtkbwCBx67NX7urYI10YQHIjyhM0PJuJZx90A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rwd26f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549GSiiQ014112;
 Fri, 9 May 2025 16:36:52 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypm46yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 May 2025 16:36:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 549GapWW29098656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 May 2025 16:36:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B06E658063;
 Fri,  9 May 2025 16:36:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3A1958043;
 Fri,  9 May 2025 16:36:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.92])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 May 2025 16:36:50 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, rreyes@linux.ibm.com
Subject: [RFC PATCH v8 6/6] s390: implementing CHSC SEI for AP config change
Date: Fri,  9 May 2025 12:36:45 -0400
Message-ID: <20250509163645.33050-7-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509163645.33050-1-rreyes@linux.ibm.com>
References: <20250509163645.33050-1-rreyes@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681e2f25 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=m9aztibn0zm50kQe27wA:9
X-Proofpoint-GUID: 5snpuWy0kotRWX6z-r_lpPgKoj8nb3rv
X-Proofpoint-ORIG-GUID: 5snpuWy0kotRWX6z-r_lpPgKoj8nb3rv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE2NCBTYWx0ZWRfX3M7gLCBU5mVv
 M5vfTOVBAgO21MzjKASy2t7htvEoDWAeOTgH8dlUSDseGN6wSmW2O+i2FZKFcDtj3Rsio5/u55z
 3+eETI+s4qQLWUJAhHh8rgV0WdhEnw4hqfQUYtAI7nfU3chNu046xHlfILANXb+HoUmQxeNRe/q
 5JUjMAKDo4l1+jzg6kOedKFSHnbBFdRQ5+wjg6b/lle4eZp9xNWbPNH5LpjNK9AHuNWbjix9vys
 Nmu2ek8C7qVpFMt6mPvRW0guYr8gSdrxrd2v8gMlZk2pBR/liv0NY1EpPGDHO6Al7uN9foI/YX6
 I1+UGYj/j1AKrQBTzzNn5IMEPH8QjwdPjF1Ih4ugWkKAV4byA+kGcfrGoxUjMwQ63MG66dNiJ9I
 Q4IQdXW8NNPU2KJLTDemlB1xpVJzGkVpmHciCRaFeX3U/nB1B+HPGuDvmQvLFz/ZUQCBsBJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090164
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rreyes@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
 hw/s390x/ap-stub.c    | 23 +++++++++++++++++++++++
 hw/s390x/meson.build  |  1 +
 target/s390x/ioinst.c | 11 +++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)
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
index 0000000000..9d2c4c2e67
--- /dev/null
+++ b/hw/s390x/ap-stub.c
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


