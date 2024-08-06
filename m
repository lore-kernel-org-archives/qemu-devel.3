Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E7BC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbKYl-00076Z-LA; Tue, 06 Aug 2024 09:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sbKYk-00070p-0o; Tue, 06 Aug 2024 09:49:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sbKYh-00008d-AT; Tue, 06 Aug 2024 09:49:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476DS9E4003668;
 Tue, 6 Aug 2024 13:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=njhY+8pWbmSqV
 05vrqqIx5rF7+Jirf/vmlViYNIIlH8=; b=KrUXkQHe8D8c4rbn1aRbSEoRqnmS2
 jNzf9lfuieCH9zYjkdGopHBysS5dtad84PY7a1f1QuTupiR1EiwFukwNMceOhGer
 NruMjXSmtZNzYDXul0XES76mParn50uiX0jHvab+yCZFCLBDcQWrpr9CqQsoMZVs
 JhU49gSmj41xGefKvXnpO/HVxaCc/poip1ShP1mkM0ZUK6BCu8iRyNBm/8hQH9KA
 MGM9T+KnD3P80UMsVUlujb4V0mKQTFyql80HO9bkyDaIpsWnHMx9xKi/jUKt2dXu
 jZiGUHc1EJieV39dXi/P235jNsWgP7/pO44M7ZBs4MenX3LYLGgN/sExw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40umqvr1s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476Dmrbc009431;
 Tue, 6 Aug 2024 13:48:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40umqvr1s1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 476BJFpq024361; Tue, 6 Aug 2024 13:48:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90m22f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Aug 2024 13:48:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 476DmkE647972780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Aug 2024 13:48:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9C0720049;
 Tue,  6 Aug 2024 13:48:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8A2220040;
 Tue,  6 Aug 2024 13:48:43 +0000 (GMT)
Received: from LAPTOP-UGTOAIPD.ibm.com (unknown [9.43.9.228])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Aug 2024 13:48:43 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v1 1/2] Fixes: Coverity CID 1558827
Date: Tue,  6 Aug 2024 19:18:28 +0530
Message-Id: <20240806134829.351703-2-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
References: <20240806134829.351703-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wJpIUueAH2JGNlT00r6HADEyLiLPGclE
X-Proofpoint-GUID: FHuk5ayT6-N72h9qTSCvsnj_pI0gOFLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxlogscore=629 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408060093
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

In this commit the following coverity scan defect has been fixed.
CID 1558827:    (OVERRUN)
  Overrunning array "s->seq_op" of 8 bytes at byte offset 16
using index "get_seq_index(s) + 1" (which evaluates to 16).

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index c1297ab733..a33f682897 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -729,7 +729,7 @@ static void operation_sequencer(PnvSpi *s)
      * some operations may cause more than one frame to be sequenced.
      */
     while (get_seq_index(s) < NUM_SEQ_OPS) {
-        opcode = s->seq_op[get_seq_index(s)];
+        opcode = s->seq_op[(get_seq_index(s) & 0x7)];
         /* Set sequencer state to decode */
         s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DECODE);
         /*
@@ -834,8 +834,8 @@ static void operation_sequencer(PnvSpi *s)
                  * transmission to the responder without requiring a refill of
                  * the TDR between the two operations.
                  */
-                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1])
-                                == SEQ_OP_SHIFT_N2) {
+                if (PNV_SPI_MASKED_OPCODE(s->seq_op[((get_seq_index(s) + 1) &
+                                                0x7)]) == SEQ_OP_SHIFT_N2) {
                     send_n1_alone = false;
                 }
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
-- 
2.34.1


