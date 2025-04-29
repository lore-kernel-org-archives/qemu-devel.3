Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DFAC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 05:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9dPP-0005B3-J5; Tue, 29 Apr 2025 01:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicholas@linux.ibm.com>)
 id 1u9dP6-00059D-Mn; Tue, 29 Apr 2025 01:21:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicholas@linux.ibm.com>)
 id 1u9dP1-0000If-2O; Tue, 29 Apr 2025 01:21:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T4EOKu029614;
 Tue, 29 Apr 2025 05:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=WOsbZ6VHfmKUE/Ggj8hV8qBPCLHBj3a0g649Lbb4Y
 Sw=; b=eoTmd+KkeNbwa4/XPYu9egEdXfpTGmVbTTAm0IM70rUdIIzZpduDZAJYf
 xG8F/9eSDSk0cCT9Hr/cbcI66qqZCFuKh53MMZLGY3Mh79HvpNK81dq/rJlRhXly
 BZgFQDrvJcl5ZQ3Be1pJFxSsVnkHhJkV4OUJMe495zfqKXiH7gMMZIr1dkAva4lr
 ZoD/djh/4giToDSSi/cEtSq5fvt5mFwpbQdO29ETskE3TI8DREaX/dZlFSaxf0p2
 dPeSzM/Bxfok1K8kmbVBJKvyKB2ArgwYx0i+ihEnJvTat4SOhqcb8ZFp2DNGYbxq
 Wc6oc/ROkiOF9qQLGe3V+UMgtmCQg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a84s47e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 05:20:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53T13BCZ024662;
 Tue, 29 Apr 2025 05:20:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1m1hjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 05:20:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53T5KjOe41419094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 05:20:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24F4B20043;
 Tue, 29 Apr 2025 05:20:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5890320040;
 Tue, 29 Apr 2025 05:20:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 05:20:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.36.15.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 1DFC7600E5;
 Tue, 29 Apr 2025 15:20:37 +1000 (AEST)
From: Nicholas Miehlbradt <nicholas@linux.ibm.com>
To: borntraeger@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org, 
 david@redhat.com, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
Date: Tue, 29 Apr 2025 15:20:21 +1000
Message-Id: <20250429052021.10789-1-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mchsu4/f c=1 sm=1 tr=0 ts=681061af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=wvb5WSqKDChzOkrdz1EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzNyBTYWx0ZWRfX5kNKK+MkknS7
 H/OeOspswe3QqYJfWwsYSKnnhuqPWAFFXxixiOrcPIUeM74qKCxl8atvQgOuiks+7m+gd/Sa6fx
 5qm2vVOS3eoPhVRRzGOeDimMaPQajJOOxFtOxiuvoheACxz6OTxiV1W3kIcGyLLcbcwW3wvWJEg
 OBzcwXISjXgrvcoQfUiAJjFeuMDFg0m0Z6gNP9paa6t5sMIprvL7MAPoBJ3bTqTufvMC1XaSLhj
 ctroOaPpYT6NiMDVeW1gWwhVqS01JhP79GiszsQQ3q3OgOPUHPbtCF2SHJPaKwb787lgensnA5y
 7qfox+kOYkZWiJnIDolhmeHLKQovcn6Yw5ge4DMGNqHhDEqIQFgL31ygKcz5KkUkwAEFeYW438n
 Ae+DFMP3pbu1wxNvHzCJKz2g2NSRL8bUqjlMiTIR4dKihpRuLjMgw+TXGCgS/+Q0xaTWNupH
X-Proofpoint-ORIG-GUID: B3VlHltzSyTMSneGztqaKA5YHbkt8Bug
X-Proofpoint-GUID: B3VlHltzSyTMSneGztqaKA5YHbkt8Bug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290037
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nicholas@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

The reset performed by subcode 3 of the diag308 instruction specifies
that system memory should be reset. This patch implements that
behaviour.

Introduce S390_RESET_REIPL_CLEAR to differentiate between subcode 3 and
subcode 4 resets.

When doing a clear reset, discard the ramblock containing the system
ram.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 hw/s390x/ipl.h             | 1 +
 hw/s390x/s390-virtio-ccw.c | 6 ++++++
 target/s390x/diag.c        | 3 +--
 target/s390x/kvm/kvm.c     | 6 +++++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index cb55101f06..9c38946363 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -38,6 +38,7 @@ enum s390_reset {
     /* default is a reset not triggered by a CPU e.g. issued by QMP */
     S390_RESET_EXTERNAL = 0,
     S390_RESET_REIPL,
+    S390_RESET_REIPL_CLEAR,
     S390_RESET_MODIFIED_CLEAR,
     S390_RESET_LOAD_NORMAL,
     S390_RESET_PV,
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 94edd42dd2..bc07158b16 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -455,6 +455,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
     enum s390_reset reset_type;
     CPUState *cs, *t;
     S390CPU *cpu;
+    RAMBlock *rb = machine->ram->ram_block;
 
     /*
      * Temporarily drop the record/replay mutex to let rr_cpu_thread_fn()
@@ -479,6 +480,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
+    case S390_RESET_REIPL_CLEAR:
         /*
          * Reset the subsystem which includes a AP reset. If a PV
          * guest had APQNs attached the AP reset is a prerequisite to
@@ -489,6 +491,10 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
             s390_machine_unprotect(ms);
         }
 
+        if (reset_type == S390_RESET_REIPL_CLEAR) {
+            ram_block_discard_range(rb, 0 , qemu_ram_get_used_length(rb));
+        }
+
         /*
          * Device reset includes CPU clear resets so this has to be
          * done AFTER the unprotect call above.
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133e..cff9fbc4b0 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -105,8 +105,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
         break;
     case DIAG308_LOAD_CLEAR:
-        /* Well we still lack the clearing bit... */
-        s390_ipl_reset_request(cs, S390_RESET_REIPL);
+        s390_ipl_reset_request(cs, S390_RESET_REIPL_CLEAR);
         break;
     case DIAG308_SET:
     case DIAG308_PV_SET:
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index b9f1422197..f2d5f7ddc0 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1915,7 +1915,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = handle_intercept(cpu);
             break;
         case KVM_EXIT_S390_RESET:
-            s390_ipl_reset_request(cs, S390_RESET_REIPL);
+            if (run->s390_reset_flags & KVM_S390_RESET_CLEAR) {
+                s390_ipl_reset_request(cs, S390_RESET_REIPL_CLEAR);
+            } else {
+                s390_ipl_reset_request(cs, S390_RESET_REIPL);
+            }
             break;
         case KVM_EXIT_S390_TSCH:
             ret = handle_tsch(cpu);
-- 
2.47.2


