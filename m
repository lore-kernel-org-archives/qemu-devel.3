Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8132FD2D6E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwUg-0005AL-9F; Tue, 10 Mar 2026 08:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzwU7-00051x-KI; Tue, 10 Mar 2026 08:46:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzwU4-000390-S8; Tue, 10 Mar 2026 08:46:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A5ISDg719749; Tue, 10 Mar 2026 12:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KDNKF3RXtxUcBaU1z
 EVwzfQj+RyanbyR+5WGtctHqT4=; b=TlL13Ie6XOtspbxbUFI1DhJruLeqUi0bB
 b3rrQyHvcvtj8zHHxN+qKxfEo9Nf8yApxquvPcX5DLhhRD7CAmk8vO2DdFLcEqju
 c6dntTwtHesjQo/rGhu4kv7VwsXdaRmP6K0Et6F+NhMlOd2+jMu5ygaQrDMlZ/A0
 ShhXtBWytk/gFZ72B5eJMO3FHkl12/c4WdVzDWY1MedAoQ9MHJf1w8Qalz8L87iz
 8Fq6heV1vvJoIE/9AkRXW4idjfIzeUaaRxXEB1kdGuw0mdSn7auBQKJc1WP88iJs
 IiYzWYwT97ifNxv3tbn1PwXOtSC/SMTMRGb7pVZLexCsoO7Ih8jhw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywau7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 12:46:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABUUsm015638;
 Tue, 10 Mar 2026 12:46:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybn93g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 12:46:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62ACkf5j45285644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 12:46:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D78820040;
 Tue, 10 Mar 2026 12:46:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E8DA2004B;
 Tue, 10 Mar 2026 12:46:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 12:46:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v5 06/10] pnv/mpipl: Set thread entry size to be allocated by
 firmware
Date: Tue, 10 Mar 2026 18:16:13 +0530
Message-ID: <20260310124619.3909045-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310124619.3909045-1-adityag@linux.ibm.com>
References: <20260310124619.3909045-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwOSBTYWx0ZWRfX1cQ9CPgg1TZR
 WHKr6FAQifmDXDOqCZMN5mGiqxW+N92NYXDq/7i4Hq90qoOgcPaM4vMwJfjrm/GCol5H/QelDfl
 STz/azvjenAttFUiyktaLiHGm0jSxY1v7txek9nCIEm+7lYebwkC4cRe+6a+WeYBtzPyHxzDUwV
 WxeGfR3gccGy0xGNlAnEwLHBaiq8Bt8waqMA2kakVjdqZPkYzYOAMCQqOimIvfLh5XSwQnqNLoC
 wM/GDhfd3kHtP6e8v2xH+cZcRY0vPGFMo/T8VamzSewsWUc4ywESEiVKO7Ax78PwE7LAcPiT6Tk
 5sT0BekZZj165KKkMEr2Ofe4MLy+8MTqtK2RGjBGpUBvVJWnXzaM2UtrCFIOLlB7ZB9NHe03F88
 ukn+XDinhm4VWOQa8A2oWrOxrHd6R54fGAx2hVvEiRgU5MZa2bNSsDz2MtoUfNXMoIyqwIg0EGZ
 YtIYZQ2Z2PHPa6HeHSw==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b012b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=x2nWBmqi6rLqIJY0GGYA:9
X-Proofpoint-GUID: jBRAPitxvtHMxFi4BpH7EvoEdWieyjBs
X-Proofpoint-ORIG-GUID: QE0QNIBoo8GtvJn7y1tCltTVX-Nrqu6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Set the "Thread Register State Entry Size" that is required by firmware
(OPAL), to know size of memory to allocate to capture CPU state, in the
event of a crash

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1513575b8f37..3038b1626c54 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -781,6 +781,30 @@ static void pnv_reset(MachineState *machine, ResetType type)
         _FDT((fdt_pack(fdt)));
     }
 
+    if (!pnv->mpipl_state.is_next_boot_mpipl) {
+        /*
+         * Set the "Thread Register State Entry Size", so that firmware can
+         * allocate enough memory to capture CPU state in the event of a
+         * crash
+         */
+
+        MpiplProcDumpArea proc_area;
+
+        proc_area.version = PROC_DUMP_AREA_VERSION_P9;
+        proc_area.thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
+
+        /* These are to be allocated & assigned by the firmware */
+        proc_area.alloc_addr = 0;
+        proc_area.alloc_size = 0;
+
+        /* These get assigned after crash, when QEMU preserves the registers */
+        proc_area.dest_addr = 0;
+        proc_area.act_size = 0;
+
+        cpu_physical_memory_write(PROC_DUMP_AREA_OFF, &proc_area,
+                sizeof(proc_area));
+    }
+
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
     /* Update machine->fdt with latest fdt */
-- 
2.53.0


