Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DEEFED9E4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2W28-0000MV-RT; Tue, 17 Mar 2026 11:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1w2W25-0000Li-Gs; Tue, 17 Mar 2026 11:08:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1w2W22-000738-BO; Tue, 17 Mar 2026 11:08:33 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H7E4uG839813; Tue, 17 Mar 2026 15:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7vu2bhd2gxrC9LVgH
 dBb5sDARYo3YfIa3rJnX6xtJKM=; b=BcAn5fcoN3Hu/EkbspU+Q2M9P2TZXlyQD
 e4jVXGhKIFtSg8Qor5JVMS+r2LQGaXLFwXSuHwlKk0/SJFc/CtgAH0WBOTQe6etX
 ad4vx4VETUztZPJhVFTI7JaRQi2TXkdBlwctMI6qkOisg3/CGx+vr0TFw+mcNrE7
 IA97mD+gOfp/WRK3+4DSVx3KtxtBNXhDAHLVOJkQf9BhqpcvMPeSlcITK4derrgL
 sL04V9+nJ4gKbGs8SiYbXyTjb5ngxHCpI+unsT8oOhUA00W6ktGqLWbknDbwCPV/
 eTr4ncgnWvhbue4E41S2gn5+JAQafWoEH366HgxTsC3lqw9nsTmzw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs5cnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 15:08:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HEVwlt005412;
 Tue, 17 Mar 2026 15:08:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s9trq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 15:08:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HF8Ab951904946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 15:08:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FB1820043;
 Tue, 17 Mar 2026 15:08:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D300120040;
 Tue, 17 Mar 2026 15:08:08 +0000 (GMT)
Received: from Mac.com (unknown [9.39.22.133])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 15:08:08 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Subject: [PULL 1/1] ppc/pnv: fix dumpdtb option
Date: Tue, 17 Mar 2026 20:37:58 +0530
Message-ID: <20260317150758.53781-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317150758.53781-1-harshpb@linux.ibm.com>
References: <20260317150758.53781-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b96e5f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=CGBzvb4MnhGT_TwKM-YA:9
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: nknI9dnDQH1F1iHjURxm6p0g9h6CMxNW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzMCBTYWx0ZWRfX04ARkyA+DI98
 o2aiubuPuGQbpuzQ49ua95UulGkRng8T5Vlde6khFZTb82JgV7wKGLh7rPpgPSm7KP+BjVsAeCZ
 H4Jmww8AIwwmmoggKVOjga9KqviNGhg8CK6GSdVqOMwFNer/FxxLoc97spm21tJzST3QVq2NH1l
 Qto7OcnBCk8l6JRH0TOwr+7vDXL7iFyDpujXpv4eDZP1ePQL0sWSGfm00zMQuA1C9xetauTi+ja
 Nt9KB7KLH9mfrsKc7zpNyebEltgJ29s8YpQvbU0HxkRjjj7lO0nCYFI/KKDOoeM5RhNaTTA6+Uk
 Gj1URX7QqOs+vp1AkKZsF5RKahXmccjYr+Ggos18P8i9GYNpF9J0yCQkAPjrAigIS5g7U6x+XPh
 dSsafDhnPnX1jdDUeU+nmwvvA0Ov5Hl9WZgymd46wjUsnNGLuQ6PsbjDmzsTeI7SdbDs6a9V8Y6
 jgeLDQ8JlbFhF1oI6dA==
X-Proofpoint-GUID: nknI9dnDQH1F1iHjURxm6p0g9h6CMxNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

The '-machine dumpdtb' command line option stopped working on
PowerPC/pnv systems after recent design change [1].

Fixing this by generating fdt blob in `pnv_init`.

[1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-stable@nongnu.org
Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260311143549.118720-1-shivangu@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1513575b8f..7e54b6bc60 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -773,26 +773,8 @@ static void pnv_reset(MachineState *machine, ResetType type)
         }
     }
 
-    if (machine->fdt) {
-        fdt = machine->fdt;
-    } else {
-        fdt = pnv_dt_create(machine);
-        /* Pack resulting tree */
-        _FDT((fdt_pack(fdt)));
-    }
-
+    fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
-
-    /* Update machine->fdt with latest fdt */
-    if (machine->fdt != fdt) {
-        /*
-         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
-         * the existing machine->fdt to avoid leaking it during
-         * a reset.
-         */
-        g_free(machine->fdt);
-        machine->fdt = fdt;
-    }
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
@@ -1261,6 +1243,11 @@ static void pnv_init(MachineState *machine)
     if (pmc->i2c_init) {
         pmc->i2c_init(pnv);
     }
+
+    if (!machine->fdt) {
+        machine->fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(machine->fdt)));
+    }
 }
 
 /*
-- 
2.52.0


