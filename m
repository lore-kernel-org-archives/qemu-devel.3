Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95FCCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDdfI-0005O2-Qz; Tue, 28 Oct 2025 02:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDdfG-0005Nk-I0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:58:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDdfE-0007mb-Dz
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:58:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S41tWu029205;
 Tue, 28 Oct 2025 06:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=khYziR5+CThOPUfTM
 hJcg9BND1gfxOrDu9DOsBlVQ64=; b=lHIwju1PzAFRCBuphv6QcElr1MbI6Y6Aw
 L68O6OBwhdjaPmVk/KExv++j4Iq13nG9CyR+KKSUGBXKRitvmPGiywGl1Tg8Bh8M
 brtnRH0YZiDklk0LkFBpjW1wf5OE0aCllHfbqRxMjzkDgfJlAas3V4jEeTFCKZgX
 xDtJ5/wSuqOOKfkfAtI5/O1lH0zrpQT/y1iAGO0AtagJmTYv3lyQK3YuYz5+pyBj
 LtYmI+rCxat0xhy+j1gj913U1bdYSbC/mTeHtIZyMJJlDrIRHymS1IZdOsvtP+aa
 scI8AzLcJo0YsOEAG3/W7QlKKIqehtLgBl0M1xa9m1A+KXuJ1hhTw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0mys2dqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 06:58:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S6qeco021584;
 Tue, 28 Oct 2025 06:58:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a18vs1kcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 06:58:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59S6wXfe41222642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Oct 2025 06:58:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D91D2004B;
 Tue, 28 Oct 2025 06:58:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CFDB20040;
 Tue, 28 Oct 2025 06:58:31 +0000 (GMT)
Received: from shivang.com (unknown [9.39.28.67])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Oct 2025 06:58:31 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 shivangu@linux.ibm.com, sourabhjain@linux.ibm.com
Subject: [PATCH 2/2] hw/ppc: Fix memory leak in get_cpu_state_data()
Date: Tue, 28 Oct 2025 12:28:15 +0530
Message-ID: <20251028065815.84156-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028065815.84156-1-shivangu@linux.ibm.com>
References: <20251028065815.84156-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kXT2TGNUNLQldexiAsEEi5HR6m03jDRG
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=6900699d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=ebZVwKzJ5QttRmoVdyAA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX8c/BzE4vSGIy
 6/xMdMgpk0BxQZchgRXSizUUfDgLPGmOfvS+x49gn9djzKsrH7dJo4nUu7UQwBSVYmEanvgjyWM
 7gi23hkMNR7XxPfZ7NLbuols44kwnZFKjuRZDPGCr3L852t8Gs1vSToTsXt/68RokEHVEzL0j5Z
 7FOKP+3IlIUHzjYxv7xCTFaiY4tYhsLwsZ23Jvk0hb3xAhTn1dJHpOmDevcwmf/IzMC92rNjJrw
 XRrbU9gmmwx2jUa1U3POvSgbzt0StpeEJuR6CT5fq/D+Qc9Mim3stSi+9G+RgMJokc/HaXeYzRw
 X8fATs6oz/cGYMhZrz13i7Eruz3aS86glvenq2rZ3Sd27ooxXdgSgspCtnTHw2M4oMgwHUVn7GQ
 spfTSfbPUhtwO4UMcQdwTr5EPOdGmQ==
X-Proofpoint-GUID: kXT2TGNUNLQldexiAsEEi5HR6m03jDRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Fixes coverity (CID 1642024)

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/CAFEAcA_Bm52bkPi9MH_uugXRR5fj48RtpbOnPNFQtbX=7Mz_yw@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index 883a60cdcf..49d2f862a1 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -453,7 +453,7 @@ static FadumpRegEntry *populate_cpu_reg_entries(CPUState *cpu,
 static void *get_cpu_state_data(uint64_t *cpu_state_len)
 {
     FadumpRegSaveAreaHeader reg_save_hdr;
-    FadumpRegEntry *reg_entries;
+    g_autofree FadumpRegEntry *reg_entries;
     FadumpRegEntry *curr_reg_entry;
     CPUState *cpu;
 
-- 
2.51.0


