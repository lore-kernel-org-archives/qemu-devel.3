Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6106CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVlw-0002Cq-VB; Fri, 03 Jul 2026 00:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVln-0002Af-DZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlZ-00038d-0H
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631INjC1451905
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=loIHwhEySbYTYFHnw
 hNPaeQZhR2r9c8mXCh9mCViEp0=; b=qfAQLVqVCK9FRV9TPx+bR0lrSKN4UCBph
 wrY3j2jIYFEXhFfq10p4u8qwh0YyfnORTzmWFl0cj8ZSgU4kGakbeqWkzmT8RVE5
 NuHBgjHdiRdOo951lXJ9Yvk7+Wv0GALLz8QB+Gx8ydbGGLN3Bb6lHzaXGsTq8mBu
 tAUjKHu3D+M94YcrM+Gdb1eD7cgWLIDv2MyMg0M+s+WJyXtd/fA2p+tFLPymIBnG
 eFc3TyixUGA6QRD4/WulmMgalqmlQj4ND48yHTd7e+dB776GCVamMdUQc/uvlCpY
 eLEHAVfVekVwhkfPxPot8HayIkSqvyOXytLTXKnfvko0p4Rk7iI4w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgdbfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634YdWo030073
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukf6ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634iOM549414584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 04:44:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D01D220043;
 Fri,  3 Jul 2026 04:44:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F56C20040;
 Fri,  3 Jul 2026 04:44:23 +0000 (GMT)
Received: from Mac-11.lan (unknown [9.39.22.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 04:44:22 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 6/7] ppc/pnv: avoid regenerating DTB if external DTB is present
Date: Fri,  3 Jul 2026 10:14:01 +0530
Message-ID: <20260703044402.79723-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a473e2e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Xamm_NQRB25PeBKQrqEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX1hYq9gCcF+ur
 hUZCtIuJ4VcemFQnabrygNqWEcIhwXc2plQrQ+hdivv/lYPmA9MpzlSu9+MNqZ/b9RH7aZMEexf
 36YJNI4jCjh377pU/5d4ooccjZKhVew=
X-Proofpoint-GUID: uD2qc2gvNxIKPVAEzdiKwwn1IEzOCVTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX994uxdkAzG+i
 oScYfkAd/dUW3mAENNcF/6AmU5KsjJRUuoRWRpuHu+/BdnjkycFv55dLadEk6hvL4sevHPj2k3n
 UsMMwoLqztzHpU/oz5q15UG6ZDyXMyKbZrfYEHC5r8Onpe53uG1mWsHWd4h2J/bW+/b8zf6+Qcn
 8XV2GSNSzoW2xpM8ctTfD94vSM8KwvlDYvHQ0I16EeMj0A6voDNc2+D0F66fgE9ECiT58Gnw+sC
 Aqe95WvGQ2Jga6Aua57JeY2GSUhNJ4Eq4BU27r1+3uWuCzyviySF04CJbaHaOED49qvQxdQBBpP
 rbB7JA0UNvoKZLMc4LVJQbTCi5nloFB9yumF53bCNm7xoOcPRco7Lehr+ipWC+g1LTPxU3Qj4ZQ
 kvGklz8n3XNd9hqCl7ViYBpLCjksOxrYs2V1I35bKbGyzz4K/6fNcrYjXg4OY4gv50MdBCgkXUC
 c1jq594Ev1NT097Nvkw==
X-Proofpoint-ORIG-GUID: uD2qc2gvNxIKPVAEzdiKwwn1IEzOCVTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030037
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Currently externally provided dtb is overwritten in `pnv_reset`.
Fix this by only creating dtb if not provided from `-dtb`.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260630103508.254000-2-shivangu@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 62812f22f8..afb6019b10 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -803,9 +803,13 @@ static void pnv_reset(MachineState *machine, ResetType type)
         mpipl_write_succeeded = do_mpipl_write(pnv);
     }
 
-    /* Regenerate device tree */
-    fdt = pnv_dt_create(machine);
-    _FDT((fdt_pack(fdt)));
+    /* Only create new dt if not provided in -dtb */
+    if (!machine->dtb) {
+        fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(fdt)));
+    } else {
+        fdt = machine->fdt;
+    }
 
     /*
      * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
-- 
2.52.0


