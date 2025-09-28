Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D50CAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3Q-0002vK-2y; Sun, 28 Sep 2025 15:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3G-0002jv-8o
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x35-00045g-21
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SJCS9T013138
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7UnnuOANCoT9LyRTt
 Shxg7lf3n9jckRY0dGNMSukg0A=; b=iiX2t1/HiBz9wEr5liM2r5oVwJejjySCl
 b2N+bhxaw5JGslxz36jfy33gYpGegwM+hG+3ltUsccFCUrAlvHy+vReLwG/pWNwp
 oqXWFnaX8GN9Jw9MOAO5YkG/OPdAK24FvwVAaH8RdWc06hg+L6VA6KJ8TvybMclJ
 koBMlcVHgNSTpDE9z3U8iCxmDJB4QgmNyJjeN8rek5xvcZ88ZLoQ+lWm2b3/Q/aQ
 Q3Y9Ukl1YMMsmxKZTaEW4yleachh6aaB5gd7LxyFNpFq9pVdH6o3/IitBxPeztII
 czm69A7fCjIM70BkYRK6FbBybo9l6DnXb+5OyskSeVjmx+rAG82NA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7n7en1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SHFSXO003325
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxk01d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:27:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQxuK43843862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:26:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C1692004D;
 Sun, 28 Sep 2025 19:26:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6AC920040;
 Sun, 28 Sep 2025 19:26:58 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:58 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 15/27] hw/ppc: Support for an IBM PPE42 CPU decrementer
Date: Mon, 29 Sep 2025 00:56:17 +0530
Message-ID: <20250928192629.139822-16-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ig-_vz-Z5WptKFtt0V_hKIdGped49P1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXznlWWZtGOKOI
 6krkCxBcPPSZSSQFMsPZpGuaSPdVtIQQgurB9rkACBC2yTp5YwMreBXFRK6QqNOpRZxAuWN1j4e
 /fXjdeg5prJtaorWqoSkkzbt5UpBEui8oDaKAeDlXowLDu0Y4PeEiq4xzjSj2zbbd7tuHNumDWo
 /Ev6yHoZZ/EFLhnaG1b5Hr4cVpB7PqUUQFjudR6YpA0NnCjkDN6QPPBSO9+fXGf0H5aqlgoJnxA
 ZT5FMb1bdQ+gyOIvqfqsKEgZ95EEpOFsWD+kQ0Ie3qstd5LvDa1LcX7cJ00UtiVo+lJUVeskhI3
 5Jh/W0XkTHtyVJFSXJ0BwuXT31WXYX5HyGl9/2msWV0sWbJBCDLYIwIkLmQqYg+KR9+sGsj37Gb
 FKVEErjVpB5f1vMX37GLX8xFt45HwA==
X-Proofpoint-GUID: ig-_vz-Z5WptKFtt0V_hKIdGped49P1o
X-Authority-Analysis: v=2.4 cv=T7qBjvKQ c=1 sm=1 tr=0 ts=68d98c08 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FSmKNcNrx3yT2pM3_rYA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

The IBM PPE42 processors support a 32-bit decrementer
that can raise an external interrupt when DEC[0]
transitions from a 0 to a -1 (a non-negative value to a
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
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925201758.652077-8-milesg@linux.ibm.com
Message-ID: <20250925201758.652077-8-milesg@linux.ibm.com>
---
 include/hw/ppc/ppc.h | 1 +
 hw/ppc/ppc_booke.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

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
-- 
2.43.5


