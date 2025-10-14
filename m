Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDECCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hZB-0000J0-6W; Tue, 14 Oct 2025 12:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8hZ8-0000I4-01; Tue, 14 Oct 2025 12:07:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8hZ5-0005BH-ET; Tue, 14 Oct 2025 12:07:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EBdssY017759;
 Tue, 14 Oct 2025 16:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vn8p4RJSflx0eO9WQ
 ZKMyBB/6+o9mm2w1wj61LmRILk=; b=Eb9w4bzzaE95sMrGyPiMQ0e9KYV+PhADg
 Q8Yf1lumgWAw9EeE/BaakHooW52E5l718Ok3rN36pt1nw9hureR85yB9s2AQCA2G
 YHXus+WBoZqn4eOHbX9fDI3G5Ufn8aWB1oXLeXNx46qYPdQp6BT6nP3jiswt0vhh
 pON0FgsTUhdRRgm5q7erM3zrD+UwIwwRHKPKkgDYz7p22oK3rG96+Al3FEBv4J+e
 Ud/E8zQCFEEJ9U+sjVyu1R+4xwurRW2Yb9LgZD21gaUk03TbaSQLyHLPNhlVuLAa
 vBhik40O4ezSn6xhgXAlEuVHHAIwt6KEIcD3X3vMVRif7YgyR62/Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpfa32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:07:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEE5EN015207;
 Tue, 14 Oct 2025 16:07:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1js417u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:07:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59EG7mVP61014514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 16:07:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E91920117;
 Tue, 14 Oct 2025 16:07:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E58920116;
 Tue, 14 Oct 2025 16:07:47 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.67.246])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Oct 2025 16:07:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] target/s390x: Fix missing clock-comparator interrupts
 after reset
Date: Tue, 14 Oct 2025 18:05:14 +0200
Message-ID: <20251014160743.398093-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014160743.398093-1-iii@linux.ibm.com>
References: <20251014160743.398093-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfX3l/0InuZqIc7
 cRzcbT6IFmaOJYHbHfgFz1AwB9Z5bfeJ3ZFTO0crZ5yEAqMoErIsTW1jXLiQgdIk7vDcmxoDadJ
 4InRUNCmwokZF2QBvYJPbbZStqnxjySpNgmNT4uan0TvWMYgkXzNUCzNiJRg0uEldsLdg5/xSeQ
 eU5v93X9QYCn+zqFA+NTCOH7huDl4FOFn7Ygb1U7NKmLzYryW6qvPuvAtEmBI5MLhuy8QbHzk2V
 ZLo3mUYyGqmrtidyeN+3a0ri2T4rp/YHMpeJnxc4kM/t23syIESCc7rl/sny16Uo31b5PPs5DhG
 JmEBvzLVnUQ156Fh8KpF9vcSva985rqM8sw6hPSSOUm9t7HOpEd5cEFto608RMvhsLGMS7xoNLs
 WHzLNxOjx7cTZRJDIj+pvkwazpXgaw==
X-Proofpoint-ORIG-GUID: 4EpRL-s34XL7qMXtBgrf3X987ysm32I-
X-Proofpoint-GUID: 4EpRL-s34XL7qMXtBgrf3X987ysm32I-
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ee7556 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=4iyXZ4RDbAuoQZjARrEA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

After reset, both TOD and CKC values are set to 0, so if
clock-comparator interrupts are enabled, one should occur shortly
thereafter.

Currently the code does not set tod_timer, so this does not happen.

Fix by adding a tcg_s390_tod_updated() call. Initialize TOD clock
before CPUs in order to ensure that the respective object exists
during the CPU reset.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 6 +++---
 target/s390x/cpu.c         | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ad2c48188a8..9f37a96ae5a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -286,6 +286,9 @@ static void ccw_init(MachineState *machine)
     /* init memory + setup max page size. Required for the CPU model */
     s390_memory_init(machine);
 
+    /* init the TOD clock */
+    s390_init_tod();
+
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
 
@@ -332,9 +335,6 @@ static void ccw_init(MachineState *machine)
         s390_create_sclpconsole(ms->sclp, "sclplmconsole", serial_hd(1));
     }
 
-    /* init the TOD clock */
-    s390_init_tod();
-
     /* init SCLP event Control-Program Identification */
     if (s390mc->use_cpi) {
         s390_create_sclpcpi(ms->sclp);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f05ce317da1..cc2de6ce08e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -40,6 +40,7 @@
 #include "system/reset.h"
 #endif
 #include "hw/s390x/cpu-topology.h"
+#include "tcg/tcg_s390x.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -215,6 +216,13 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
             break;
         }
     }
+
+#ifndef CONFIG_USER_ONLY
+    if (tcg_enabled()) {
+        /* Rearm the CKC timer if necessary */
+        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
+    }
+#endif
 }
 
 static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.51.0


