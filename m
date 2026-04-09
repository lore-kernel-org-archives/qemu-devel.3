Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BE9F31E5B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAryC-0006y8-LY; Thu, 09 Apr 2026 12:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wAry7-0006r0-Tk; Thu, 09 Apr 2026 12:10:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wAry6-0007oI-7Z; Thu, 09 Apr 2026 12:10:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639EApJU2401288; Thu, 9 Apr 2026 16:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pMxwQeZ4ev4mCAV9Ck0oKLFAv7ZIKhndqQKrvJsvl
 6Y=; b=VrKFslVRPBWpbRQWJRLSZ+d/eEvAWKaSM7hMBkaV+k7HfJDNmqD63p7cU
 hpLW9ck+N5wO5ERIPSipLw/KTloxQuTOTWWKapRcSkQKzoa++8Tmv7ooMK1UIc6w
 dFO/8sFdEdgtiRODALnBw18K1O3DpxAd1m+1CbUR1oaPYoTWUjo4QNJhTOxyvstQ
 /4wZBToeVpflL6mJW5LCMkQGZIPGNmjWyg+Z191TOZdDWMiGW+eWoXBLSTzBFJ2x
 Th/iTtPVuq6IaVU71V7NwJXZn8NovigElWc+dmrnIUb22Or1y4UPX4Sl0JpR2JRM
 6VNR8eVTfVaKff2mbGrPbNswtWKTg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hn0bp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 16:10:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639CnqXK018946;
 Thu, 9 Apr 2026 16:10:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9mbax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 16:10:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 639GAnv159572632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 16:10:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AE2520043;
 Thu,  9 Apr 2026 16:10:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7460E20040;
 Thu,  9 Apr 2026 16:10:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.24.136])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Apr 2026 16:10:47 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: anisinha@redhat.com, pbonzini@redhat.com, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, peter.maydell@linaro.org
Subject: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in kvm_cpu_exec
Date: Thu,  9 Apr 2026 21:40:42 +0530
Message-ID: <20260409161042.55281-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE0NSBTYWx0ZWRfX14lecYEXauIs
 VGw3irFbeq8+f045DWTY80qEW0Kptvd+8cwdgkUmr50MkIXWeqjTe6w0zBhT56aEY6HKnf632qu
 R7tTLpDmx0nZtgmqeH5BpnzCqlNLP+zyjHhgsGId6dYZobrOZWRhRrf6lF6Ikk9UguoN7FVXknz
 aKqHCGSvySvnoTiZtEs/83Rfh27/uchUHB676KkjE2J326O16WwiH2nswytVzGjM1/aPJJMWdu8
 cEzBDTBXu3YlAiTKgEbvrzJNB/pavgK0C5DaZifoiz1C10F7Wqa4mYYWcErtLFvAg2CD9z3SRCb
 sDbRXKUPjh451gxoeQcHd3e79mdkM7aUCfkccmMQD/IjeqzMwMZC5vwfX45ll06ZmnR7i52QHK/
 c0dwCfLYqmpnVQoDTBlRKpl/hJaIu5csiW1iGojgeXcksjwhU9OTuWoYKVb22BWR0E0Ehm0uqkb
 X+XO8Q0i63AEB2v3t/g==
X-Proofpoint-GUID: mB8bpi-nAlk1Q2GS0Bo8tnBoTzVVH4Ph
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d7cf8e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=J3LV9hoIG5fqms1vbrYA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: S9AEwKEdiqit0oF60W46EMXD0qU6EZUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When kvm_cpu_exec() returns EXCP_HLT due to kvm_arch_process_async_events()
returning true, it was returning before releasing the BQL (Big QEMU Lock).
This caused a lock imbalance where the vCPU thread would loop back to
kvm_cpu_exec() while still holding the BQL, leading to deadlocks.

The issue manifests as boot hangs on PowerPC pseries machines with multiple
vCPUs, where secondary vCPUs with start-powered-off=true remain halted and
repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration held
the BQL, preventing other operations from proceeding.

The fix has two parts:

1. In kvm_cpu_exec() (kvm-all.c):
   Release the BQL before returning EXCP_HLT in the early return path,
   matching the behavior of the normal execution path where bql_unlock()
   is called before entering the main KVM execution loop.

2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
   Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since the
   loop expects to hold the BQL when calling kvm_cpu_exec() again.

This ensures proper BQL lock/unlock pairing:
- kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
- kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
- kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
- Next iteration has BQL held as expected

This is a regression introduced by commit 98884e0cc1 ("accel/kvm: add
changes required to support KVM VM file descriptor change") which
refactored kvm_irqchip_create() and changed the initialization timing,
exposing this lock imbalance issue.

Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 accel/kvm/kvm-accel-ops.c | 4 ++++
 accel/kvm/kvm-all.c       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 6d9140e549..d684fd0840 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
 
         if (cpu_can_run(cpu)) {
             r = kvm_cpu_exec(cpu);
+            if (r == EXCP_HLT) {
+                /* kvm_cpu_exec() released BQL, re-acquire for next iteration */
+                bql_lock();
+            }
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f..00b8018664 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
     trace_kvm_cpu_exec();
 
     if (kvm_arch_process_async_events(cpu)) {
+        bql_unlock();
         return EXCP_HLT;
     }
 
-- 
2.52.0


