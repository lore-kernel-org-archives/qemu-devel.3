Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1101AC9EC63
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGI-0003QK-MG; Mon, 12 Jan 2026 05:35:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGH-0003Ob-90
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGF-00028o-KC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:01 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C63hTr008622
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4Jo+cg9obOe3ll1mp
 JR9IhJka21gKtO3asHBHq7Euu0=; b=JYrLRsQKl5hycEQi3orx+3ETrYWikCdmk
 JSEnMsR4LoWjOM3KCEzqRLmt14WDmFZcaNLVGDVFki3sLlETtx7Qoetx+OFnqpz5
 IZQBen4Izipu5JVMJCUh6m/GeGaSsPg/47D4viL18Vos9efNj6oONI+RFqsa14hZ
 NOirum/fbrSmf22LvmUDXzsiQHBpSbwp/2x7yyr0jB+PRK1M/PGGdP6wye88UZ9p
 xFI5zMQ2c98nUAi9JA/cIKA0iR04c3nSN+Vh8GGSXK3Q9gcFLikGmGaE04zoXUeJ
 gcAefmQC90k+7hEsmSDDu8S1+x6SA3VDPvFY7p/jYypAFVGPUN7+A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxd1m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9vNjC025566
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23mwc33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAYrDA9896266
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:34:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D9062004B;
 Mon, 12 Jan 2026 10:34:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 859D420040;
 Mon, 12 Jan 2026 10:34:52 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:34:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 01/10] target/ppc/kvm : Use macro names instead of hardcoded
 constants as return values
Date: Mon, 12 Jan 2026 16:04:24 +0530
Message-ID: <20260112103433.8451-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r24kjGPammwf8233RxopprvM7RZVZUe3
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6964ce52 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=TXOZxh5LdWKoDwPKVd0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX8s0CiektWbcj
 aewTZCvRHWNRKXyHZmhUVTWlnK+sZ72lE2s83aRpIL6aLuEGAlm3kDPdpZoT0RKp0Ni+g20Kxsq
 cj4VsphDoE/0pQvRwO7uT//gxvLOLgsrXoNqlQK4z3uynzQnaE0NxJfxYzJOhj/t6ef6nAbxjG0
 qxa8kP5MhNPH8TyTBuu3ucKDvCkOu56UWQ02tEShjD9MQX988HhljFgonRN6W8oPxaQZ91+o77n
 L7gH2/X0onti1rqtyVw1VbsYmF85kkvSaE8BGM8RJjHJxq27cZLfgs/POPb0XOH9O7+A6AQ3j7n
 aiTIRlqoK+3g4rRjgAhyOfUKVdyYbrhnmGTgFtmU6LzH0oHsslP1F4YqzPknHrwZB+D+Zw5juu3
 wJhJzgbkJu42qcqKJZ6GbyBPMhiemaVnZL0a6uXjRjMyzS/Whk6I9/DTla8NTAbGhY/SVu3W2ti
 1TKSJhawvzPb/QQSkvA==
X-Proofpoint-ORIG-GUID: r24kjGPammwf8233RxopprvM7RZVZUe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

From: Gautam Menghani <gautam@linux.ibm.com>

In the parse_* functions used to parse the return values of
KVM_PPC_GET_CPU_CHAR ioctl, the return values are hardcoded as numbers.
Use the macro names for better readability. No functional change
intended.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251202124654.11481-1-gautam@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/kvm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 1521787b3f..41bd03ec2a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2450,26 +2450,26 @@ static int parse_cap_ppc_safe_cache(struct kvm_ppc_cpu_char c)
     bool l1d_thread_priv_req = !kvmppc_power8_host();
 
     if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
-        return 2;
+        return SPAPR_CAP_FIXED;
     } else if ((!l1d_thread_priv_req ||
                 c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
                (c.character & c.character_mask
                 & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
-        return 1;
+        return SPAPR_CAP_WORKAROUND;
     }
 
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 static int parse_cap_ppc_safe_bounds_check(struct kvm_ppc_cpu_char c)
 {
     if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR) {
-        return 2;
+        return SPAPR_CAP_FIXED;
     } else if (c.character & c.character_mask & H_CPU_CHAR_SPEC_BAR_ORI31) {
-        return 1;
+        return SPAPR_CAP_WORKAROUND;
     }
 
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
@@ -2486,15 +2486,15 @@ static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
         return SPAPR_CAP_FIXED_IBS;
     }
 
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 static int parse_cap_ppc_count_cache_flush_assist(struct kvm_ppc_cpu_char c)
 {
     if (c.character & c.character_mask & H_CPU_CHAR_BCCTR_FLUSH_ASSIST) {
-        return 1;
+        return SPAPR_CAP_WORKAROUND;
     }
-    return 0;
+    return SPAPR_CAP_BROKEN;
 }
 
 bool kvmppc_has_cap_xive(void)
-- 
2.52.0


