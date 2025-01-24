Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18884C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 11:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbHpo-0005li-1p; Fri, 24 Jan 2025 06:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tbHpk-0005lC-Hk; Fri, 24 Jan 2025 06:26:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tbHpi-0001z3-QZ; Fri, 24 Jan 2025 06:26:44 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O9Vgug019083;
 Fri, 24 Jan 2025 11:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=4ApwJCYWzyF0ZzbXDBSqNt5pZgFIuYs4oWuS89fr2
 tY=; b=lxOkQbC0NbIDMFq6hFUkX9aDed0uinEGwuSlNlgxKNHrqDWQfyZQik8z6
 fHnsR5nCxgcCFA1LGpIr011BJzG14NaVvDFMV5YmufO4sEGPgvl2y3e6JrVrS4ZU
 aBktyoTeGWGxZapgBGB4p+V+FPbzy9KRp31BMgOCJ9ArfLzmXI1rcAZzMAKhPgCF
 z/0D8QchKiX1tcJggFIeCShZEJZWkAWBeaYgugdgBg5I+v8cpIOZbSpIGw+1E2uO
 gVnwLB0l6hhuEOHa86f9QU+gdvo4EvfmrtrPhWwJOsreh4uxyLn8EErq/MHufpwH
 dW+M0trOWBXcN/HC1c65imrCqVwTA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x93eu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 11:26:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50O9tHqS032420;
 Fri, 24 Jan 2025 11:26:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk2sqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 11:26:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50OBQZl457540952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 11:26:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78293200C7;
 Fri, 24 Jan 2025 11:26:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC3AC200CF;
 Fri, 24 Jan 2025 11:26:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.20.50])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2025 11:26:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] hw/s390x/s390-virtio-ccw: Fix a record/replay deadlock
Date: Fri, 24 Jan 2025 12:25:48 +0100
Message-ID: <20250124112625.23050-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1M0knaISyUEdQunm7sP_0yZCW_Ipi93P
X-Proofpoint-ORIG-GUID: 1M0knaISyUEdQunm7sP_0yZCW_Ipi93P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240080
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.043, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Booting an s390x VM in record/replay mode hangs due to a deadlock
between rr_cpu_thread_fn() and s390_machine_reset(). The former needs
the record/replay mutex held by the latter, and the latter waits until
the former completes its run_on_cpu() request.

Fix by temporarily dropping the record/replay mutex, like it's done in
pause_all_vcpus().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 38aeba14eeb..e2386910f78 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -48,6 +48,7 @@
 #include "kvm/kvm_s390x.h"
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/s390x/virtio-ccw-md.h"
+#include "system/replay.h"
 #include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
@@ -454,6 +455,18 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
     CPUState *cs, *t;
     S390CPU *cpu;
 
+    /*
+     * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
+     * process the run_on_cpu() requests below. This is safe, because at this
+     * point one of the following is true:
+     * - All CPU threads are not running, either because the machine is being
+     *   initialized, or because the guest requested a reset using diag 308.
+     *   There is no risk to desync the record/replay state.
+     * - A snapshot is about to be loaded. The record/replay state consistency
+     *   is not important.
+     */
+    replay_mutex_unlock();
+
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
 
@@ -533,7 +546,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
              * went wrong.
              */
             s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
-            return;
+            goto out_lock;
         }
 
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
@@ -546,6 +559,15 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
         run_on_cpu(t, s390_do_cpu_set_diag318, RUN_ON_CPU_HOST_ULONG(0));
     }
     s390_ipl_clear_reset_request();
+
+out_lock:
+    /*
+     * Re-take the record/replay mutex, temporarily dropping the BQL in order
+     * to satisfy the ordering requirements.
+     */
+    bql_unlock();
+    replay_mutex_lock();
+    bql_lock();
 }
 
 static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
-- 
2.48.1


