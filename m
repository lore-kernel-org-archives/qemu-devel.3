Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B2FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1sRe-0004vO-NH; Thu, 25 Sep 2025 16:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1sR3-00044V-Ii; Thu, 25 Sep 2025 16:19:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1sQn-0006GU-SY; Thu, 25 Sep 2025 16:19:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PImnLf031457;
 Thu, 25 Sep 2025 20:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TKN9XZO1rwCovFIC9
 E21FSTvnRaF4tIDh3jy5DxoEwY=; b=TWs+tBaLkd7Qlo0AbFWq95fQoMs45eaJX
 emVWYtIDbt1NLdFIJT9B/1BNmibI/U3TP9U8SoOJKY/E2EthGMuq4C+BgI79XOM+
 IxZTj/bDbILbLxbFYelBNmxg8mql7v/11zETNiDl3NpT+X9/UcXVZZRuDmmoVxuV
 pRWCou9H/5tyRJvKezu15moJ6MYvNgbFjSQsuSAw0hhqYqphA5Lx2djahfOG2Djs
 tc2qi5um7eDBc1llFwlaBJnc+dzuAuKcb6nyrfEZGGnJiR+dKTLxcp4rwVpFTn8m
 HHWJptwB5I3+LgLSvRfxKNQYHtXhDY7X/6hKRoaI5ikjIlcQ7dQaA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbagfga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:19:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PKIxPG029677;
 Thu, 25 Sep 2025 20:18:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbagfg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:18:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIIvbr003361;
 Thu, 25 Sep 2025 20:18:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawkgjrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:18:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PKIvIA10027590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 20:18:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 457575805A;
 Thu, 25 Sep 2025 20:18:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C029F58051;
 Thu, 25 Sep 2025 20:18:56 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 20:18:56 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v6 7/9] hw/ppc: Support for an IBM PPE42 CPU decrementer
Date: Thu, 25 Sep 2025 15:17:45 -0500
Message-ID: <20250925201758.652077-8-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925201758.652077-1-milesg@linux.ibm.com>
References: <20250925201758.652077-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BQz3H1wfeTlBjQtfjOm_526WHNS5l3S_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX0wi0GAMLSkgw
 GhfuZur0cVycKSF/nRc5VX4Jmu86KlQvQ3uQ0ChJtzHpJAGJIm1HKuggacayLBFpWJyhIzg6s9A
 M3uclQ5ykUR8gW1Mgy5bx4bwDdgV672viLG1mPUZeuh2S9KMBnnIK6Z6LsCvIXvyHnytHfas8nG
 JNUtHpGEjBfDAAuWufAhBox0abfQVHGC/qTMw7hyA1oQZ/BOPkho4jikNMvxvmC5Xdt6Ofxd2Rq
 MJe3LxATcBqoIOJW9Js8J+WM/Chj5ZGHDdkiD4DDI/EdSjp/GvKFk5m4L9mKImFZdQPAWFFFRw/
 QWdmaJ4M2wBP5N9rHS4UTPyANQnOXkvwOrRcJIBzqBB9wJ/WJQSq+64sgW9C086/lpK+V8T6+lM
 dJmwhMJMPmrbns8vS2Zik+tBs38M1g==
X-Proofpoint-ORIG-GUID: PyyDyhf0mPkG_1vR1nLtKntEmAvTWaD4
X-Authority-Analysis: v=2.4 cv=B6W0EetM c=1 sm=1 tr=0 ts=68d5a3b4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=FSmKNcNrx3yT2pM3_rYA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The IBM PPE42 processors support a 32-bit decrementer
that can raise an external interrupt when DEC[0]
transitions from a 0 to a 1 (a non-negative value to a
negative value).  It also continues decrementing
even after this condition is met.

The BookE timer is slightly different in that it
raises an interrupt when the DEC value reaches 0
and stops decrementing at that point.

Support a PPE42 version of the BookE timer by
adding a new PPC_TIMER_PPE flag that has the timer
code look for the transition from a non-negative value
to a negative value and allows the value to
continue decrementing.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/ppc/ppc_booke.c   | 7 ++++++-
 include/hw/ppc/ppc.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 3872ae2822..13403a56b1 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -352,7 +352,12 @@ void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags)
     booke_timer = g_new0(booke_timer_t, 1);
 
     cpu->env.tb_env = tb_env;
-    tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
+    if (flags & PPC_TIMER_PPE) {
+        /* PPE's use a modified version of the booke behavior */
+        tb_env->flags = flags | PPC_DECR_UNDERFLOW_TRIGGERED;
+    } else {
+        tb_env->flags = flags | PPC_TIMER_BOOKE | PPC_DECR_ZERO_TRIGGERED;
+    }
 
     tb_env->tb_freq    = freq;
     tb_env->decr_freq  = freq;
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 8a14d623f8..cb51d704c6 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -52,6 +52,7 @@ struct ppc_tb_t {
 #define PPC_DECR_UNDERFLOW_LEVEL     (1 << 4) /* Decr interrupt active when
                                                * the most significant bit is 1.
                                                */
+#define PPC_TIMER_PPE                (1 << 5) /* Enable PPE support */
 
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset);
 void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq);
-- 
2.43.0


