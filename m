Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B332CAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 20:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvi3Y-0001pI-TD; Mon, 08 Sep 2025 16:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3X-0001ow-8G; Mon, 08 Sep 2025 16:01:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3U-0006v5-Ub; Mon, 08 Sep 2025 16:01:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588IrUcN010489;
 Mon, 8 Sep 2025 20:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uDB0VznG86QpKWSk7
 +vbMedx2AEfs7dNe5SWwhZAs28=; b=q2y0QmBamCZD+hwwGl5gyWAWN3+DUNMlQ
 7YkRE9TvWj1duBZRHnmL0bo6hqFIwk488kxXxSGfHC3LF4ETrx89mUONeE69Bppe
 jtZvFe1r0VNlHXrMSnlQ+VVPHDBkBmPvUSZKUMeRh4uR5NqihsvhjFzs5S4OyE5V
 a/Fqdi2kA3vbL0Rm5FY6yn8q9tLRd048pAGJlG+8Tij0lMCFwHVZ+CHMOI0ZIGmP
 dvWdOcS/SwJl4tgdmoH0T+mdbnbKJ0GpYh3C6WAX4jhfy6ftcWVsTlPIqN+K/ahW
 q+fNEQdxCOxjj3ijtb9x+atWjwIb+UlgP3dD7tiraHXPH3E0vckhA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uke8wph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588K0lEN013726;
 Mon, 8 Sep 2025 20:01:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uke8wpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588H5fni010594;
 Mon, 8 Sep 2025 20:01:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smqnj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 588K1VdK21693004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Sep 2025 20:01:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAD6D58059;
 Mon,  8 Sep 2025 20:01:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EACB5805D;
 Mon,  8 Sep 2025 20:01:30 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Sep 2025 20:01:30 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v3 5/9] target/ppc: Support for IBM PPE42 MMU
Date: Mon,  8 Sep 2025 15:00:15 -0500
Message-ID: <20250908200028.115789-6-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908200028.115789-1-milesg@linux.ibm.com>
References: <20250908200028.115789-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX4ZDS5SsIZO/E
 tEBxMt7gFL0a3eC3/UAfA0aWY3pd6tN0+2oqSUxu75KwSOitLWBARBLuz3wpGoWzsFv657fJ3jw
 rykJMOrMERsJLr4vRWkYc3kllQLnecnVKbK6bBT/683d1hwpZNauEWorGcbz4TXWiOIZWIC6hsL
 CwHObye3X4ykVxvR2GEIUxF+JhoC8AbBpZYRfcjXg/jhjOGMBtaFb4zacZ/SJQUzHxpC2+4XADw
 mmzEr2OJnnORmtxYz/6K++ZQ/4U/DBnYuPXSjA8OUQhq+gcwyB6r2+fHUyl1kQB6AhRPPBL+Esb
 qvfVbFHCcAcwGZUhjAFVBKHrLwxBcW4MUNxvKMUCiHbv/WWF/WzZlZWZGgKcPhTSiT8aMn1+b4s
 LVrygME4
X-Proofpoint-ORIG-GUID: qJ_m_-NrrVGW3BXWpA90mhWBkSIPwS47
X-Proofpoint-GUID: DAC9405k0zBFM92epvUzXRp4oEwJg3G1
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68bf361d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Uotnjwh7_nUNd4_WO1gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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

The IBM PPE42 processor only supports real mode
addressing and does not distinguish between
problem and supervisor states. It also uses
the IR and DR MSR bits for other purposes.
Therefore, add a check for PPE42 when we update
hflags and cause it to ignore the IR and DR bits
when calculating MMU indexes.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---

Changes from v2:
  - Split MMU changes from v2 patch 1

 target/ppc/helper_regs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index aaefeffa66..29158342d5 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -186,6 +186,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_LPCR] & LPCR_HR) {
         hflags |= 1 << HFLAGS_HR;
     }
+    if (unlikely(ppc_flags & POWERPC_FLAG_PPE42)) {
+        /* PPE42 has a single address space and no problem state */
+        msr = 0;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (!env->has_hv_mode || (msr & (1ull << MSR_HV))) {
-- 
2.43.0


