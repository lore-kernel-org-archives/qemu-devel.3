Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D7FC5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 07:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy2kW-0002Y5-OH; Sun, 23 Aug 2026 03:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kV-0002XC-BA
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kT-0005q4-A0
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N71tUC2538433; Sun, 23 Aug 2026 07:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=L3BIWCfz6zsj376yj
 7VDSMUcPh7GnnaytV9GDqhdULA=; b=Lj0ka9ePtNA/icjbNVVUX5mF9nA8DzVYF
 u1IxZ4jiZfcZ83Y8nZpEe9PYrN7UG0oBGk89ky0efqtFZaiicXd9GGcYDCJwjYeH
 PECsane0M1Mbq1aHSrHOv0zAhR4G+FDuG+M06EjdJ2htIgyT4RPaY6Ff922d96K/
 Ma0qXCTlMgN0eembB+5Y2AYSMbunYj3r/IxUzU5TU6/OVLfRRVaDBe+N3zqsciZ6
 hgxt+mhBv23kdJpQ1xIQnhdIcucE6Se7qT6WvZt+3fm+Je1N8ceU9nKIbFJm+OXp
 OVKWg/2j+q7atoxC8Nt2rNmlvzEZuj5ShhBqohpfWqiFfkAJRErxw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dwuxw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 07:35:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N7QOIt027434;
 Sun, 23 Aug 2026 07:35:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jgsbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Aug 2026 07:35:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N7ZpUu46727530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 07:35:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F332520043;
 Sun, 23 Aug 2026 07:35:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4A820040;
 Sun, 23 Aug 2026 07:35:49 +0000 (GMT)
Received: from Mac.com (unknown [9.39.19.238])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 07:35:49 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Minhang Zhang <zhangminhang@kylinos.cn>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 2/7] target/ppc: Validate HTABMASK and reserved bits in SDR1
 for 32-bit mode
Date: Sun, 23 Aug 2026 13:05:28 +0530
Message-ID: <20260823073536.40282-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260823073536.40282-1-harshpb@linux.ibm.com>
References: <20260823073536.40282-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfXwgbwgpidUiEf
 6pBQAholLhKy8s+PUapFL9GuGKh+ck8QAizleu5ncJApJ+Dn7qK/Jy3lzvEjv8aTMGCB4DKuCyA
 WAsvXuFlfP1Mv9YkpwJyTr0PbVBmnEg=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8aa2db cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=dZbOZ2KzAAAA:8 a=VnNF1IyMAAAA:8 a=DoTH_MmcH-Uw9oovWWsA:9
X-Proofpoint-ORIG-GUID: EBEiX9cf6PSnf0gUu6BH8Z8YDLW6T4x7
X-Proofpoint-GUID: EBEiX9cf6PSnf0gUu6BH8Z8YDLW6T4x7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX5qGAlBeGu+Fd
 BSsfc6VB84H96X/N0s0dYx/jQS5HBCmiG101O4coL9hvRXG7DzJJrnExaXwKOYLCAyiaJeM8Z2p
 vXAxrDHacsuauIUrvjmjHwchnLlLzImD/MOeDqZojOZkeDMHASaPwyI4wT5v5wEn3cg8wQnXqz1
 Z4ctGvb92kdgJrVyqlN2ap+7hCdekIG4TniJzk8GvLwxAS5LqKkdFLf3saV1aAEX0HJvpS4fwDE
 v/dUitIgKlpOFa57povWsuEisbl38jU3QgHD0bXpFwtFnD58IHtav+fresJaL9Kd62LtXVP37cv
 Q7oNDsPw16sq6wITgnrPan31TY9ELMfTI/4hnMJmvGQ1b6z3qRBH38yp98s1TJ+/A2nUbeEue94
 8+0/ahVR2ea8aFnc4Dwvqy6+KTWGXYVZwaLo/6nloXPqcS9wKcG99ZDx8+hoLOS0VWJitDQ35ri
 WsxDNJNrCApwfDfZyYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608230066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Minhang Zhang <zhangminhang@kylinos.cn>

ppc_store_sdr1() had validation for 64-bit SDR1 values but lacked
corresponding checks for the 32-bit case.  According to the Power ISA,
in 32-bit mode SDR1 bits 16-22 are reserved (must be zero) and
HTABMASK (bits 23-31) must consist of a consecutive string of
1-bits starting from the LSB, i.e., be of the form 2^n-1.

Add checks to reject invalid HTABMASK values and log a guest error
for non-zero reserved bits, following the same pattern used by the
existing 64-bit validation.

Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>
Link: https://lore.kernel.org/qemu-devel/tencent_8388D4B38DC5172F5EEE70436D3AD6D02006@qq.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/mmu_common.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2499e619f8..2a36817181 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -42,24 +42,39 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
     PowerPCCPU *cpu = env_archcpu(env);
     qemu_log_mask(CPU_LOG_MMU, "%s: " TARGET_FMT_lx "\n", __func__, value);
     assert(!cpu->env.has_hv_mode || !cpu->vhyp);
-#if defined(TARGET_PPC64)
     if (mmu_is_64bit(env->mmu_model)) {
+#if defined(TARGET_PPC64)
         target_ulong sdr_mask = SDR_64_HTABORG | SDR_64_HTABSIZE;
         target_ulong htabsize = value & SDR_64_HTABSIZE;
 
         if (value & ~sdr_mask) {
             qemu_log_mask(LOG_GUEST_ERROR, "Invalid bits 0x"TARGET_FMT_lx
-                     " set in SDR1", value & ~sdr_mask);
+                     " set in SDR1\n", value & ~sdr_mask);
             value &= sdr_mask;
         }
         if (htabsize > 28) {
             qemu_log_mask(LOG_GUEST_ERROR, "Invalid HTABSIZE 0x" TARGET_FMT_lx
-                     " stored in SDR1", htabsize);
+                     " stored in SDR1\n", htabsize);
             return;
         }
-    }
 #endif /* defined(TARGET_PPC64) */
-    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
+    } else {
+        target_ulong sdr_mask = SDR_32_HTABORG | SDR_32_HTABMASK;
+        target_ulong htabmask = value & SDR_32_HTABMASK;
+
+        if (value & ~sdr_mask) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Invalid bits 0x" TARGET_FMT_lx
+                          " set in SDR1\n", value & ~sdr_mask);
+            value &= sdr_mask;
+        }
+        if ((htabmask & (htabmask + 1)) != 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Invalid HTABMASK 0x" TARGET_FMT_lx
+                          " in SDR1 (must be of form 2^n-1)\n", htabmask);
+            return;
+        }
+    }
     env->spr[SPR_SDR1] = value;
 }
 
-- 
2.52.0


