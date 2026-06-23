Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3943CCD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbugF-00008f-6n; Tue, 23 Jun 2026 02:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wbugD-00008S-Lo; Tue, 23 Jun 2026 02:32:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wbugC-0006g3-6j; Tue, 23 Jun 2026 02:32:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0nP2a310605; Tue, 23 Jun 2026 06:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nAxZQCkO7gPAL9PsM
 1ooFYJe1kt5VVBPiNbD7aR5/HY=; b=DBXnI/miurDW0H4twT/xSFNkgrckcqXZP
 KGljDjBUvdnEwPzPr5frWNYjuVhTa5QwvRFu0RTeqcIvUl/RX0Ews3S88citfOEB
 zkrngFcvQjZhQvInCGyzMVlcVq43VPWrOCAFjInfwflFkL12w+TpDhB9mKTqXNgj
 DFaOwCqDZ/HTxIg2+mrPui41QJiB0nAUnMtY8AFIjY4+PJFj0Xai27HVrB0XG0Ry
 gemS/OOllr041Bs7zr/gNdVNKPVyOJBaapuJgHuYPbDEn5VZ4jSdiYwu+o81SzKO
 fKEaCxwzDLwV+9ahikFizNzsnTsg7KYN5Tkwr+gptwmt+Nh8fuEsw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hn82p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:32:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N6JluV013946;
 Tue, 23 Jun 2026 06:32:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k1w1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:32:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N6W71e61407702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 06:32:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA5532004B;
 Tue, 23 Jun 2026 06:32:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44CF720040;
 Tue, 23 Jun 2026 06:32:05 +0000 (GMT)
Received: from shivang.com (unknown [9.124.222.24])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 06:32:04 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 1/2] ppc/pnv: avoid regenerating DTB if external DTB is present
Date: Tue, 23 Jun 2026 12:01:55 +0530
Message-ID: <20260623063156.1110370-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623063156.1110370-1-shivangu@linux.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5okkoRrHDdeAg-P6zJbOL1scL0ycB39O
X-Proofpoint-GUID: 6WBtQO5vGsnKeWkkTZxQnLPfqLQ1KR4z
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a286e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GMkvtKszqFOxO4YX43IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfXxhusjXEh76Vm
 KjRNzxcZ0oTxp8uhfMkLie8veO+VNCbdIcIJmfluo2slu9gHtnpMik/LoptpMlTo2gZ4UXtbn91
 t9BqSqpvfI++gaXvFEIBJ0gs6j8GF3eI00xjFdq5AvsoKQT4K0OKTT7V0MbcB1umHCG9NxSKm45
 6oUd7J9rwEiP3Amy2FZp6YTbHyG+RbcFR2QrFkdyuk+S9c1KBjVA59oAl1ywOTOuUbyP3a/9f2f
 QHKsktjignxbhqvHd+9bzepoAcIaN6vBWxKTBxptzkqDZcbMUFMys5sxa1UFR4iK7odqb++PiH8
 iZf6SIjMzb0H6LWgsZ4W72YNjF4ckIjINFCvwstGGiSkVsKR5nQxtvxuxjg818WIgUNp0DBJB5Q
 UihzUvg7Lwx6v59AIRjbxL/Eg14L8bAsqCUkDTmDc39pYBLp91UPT/g8KHIgJfZuPJxS+4b0hZ0
 E/1N76dT56Bmdg+qbIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX7hmFa5BVgZyP
 6cOmUGamQqg93lnPOwrn6uMGerX9NCHenirInWzv0JYzAAWqA+mNAWXRMmLxr/YolzM1BvAwBQ7
 L5V4/vyjYM7e6v1zawMB53zPobuToNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230048
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/pnv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 62812f22f8..6a636b5192 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -803,8 +803,14 @@ static void pnv_reset(MachineState *machine, ResetType type)
         mpipl_write_succeeded = do_mpipl_write(pnv);
     }
 
-    /* Regenerate device tree */
-    fdt = pnv_dt_create(machine);
+    if (machine->dtb) {
+        int file_size; /* discard */
+        fdt = load_device_tree(machine->dtb, &file_size);
+    } else {
+        /* Regenerate device tree */
+        fdt = pnv_dt_create(machine);
+    }
+
     _FDT((fdt_pack(fdt)));
 
     /*
-- 
2.54.0


