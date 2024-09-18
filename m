Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B780BCDD549
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxu1-0007tn-M8; Wed, 18 Sep 2024 12:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sqxtv-0007ff-Q1; Wed, 18 Sep 2024 12:51:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sqxtr-0007kw-0D; Wed, 18 Sep 2024 12:51:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IEZ9Oc013578;
 Wed, 18 Sep 2024 16:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=RBl27lVRQwuS7
 XPzc9I+Jwjap3fEp6EqKfIFk9ZGTSA=; b=c+1/sr8atu+G+FdFB/i2/w99rqsTy
 02YxtNwSPw11wZwwpdotRxc2c0+JYPhjfgmiuy89sJq5DWMWjjNGGUuBxrPSpE93
 Nv9LSmJgqsheZG13GB/usu/7NKP+8h09Fpol7WoHw8siBp40ORacXj0tex3ylrgO
 FRE6nU3ByOrYc+YsF5CE4ypwBSrnGlOdEYzUhjeQeFcBmkil0STei7y1h3wEiNmH
 5ZIOjLpdh8Z1dRLITEJK5KIF0ZSmaA4fok8ELKm9hJENNuFC78WfzKKt2vsAlVts
 NPg6Z//U7y+r0SSVN9BVhRCfA+qDGH4DKnUo4MrshuScQS2bb1U7NBf5A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41aq448-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48IGpJha000970;
 Wed, 18 Sep 2024 16:51:19 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41aq444-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48IG3Da0001892;
 Wed, 18 Sep 2024 16:51:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtuvhwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 16:51:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48IGpE3D36962806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2024 16:51:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4D4220049;
 Wed, 18 Sep 2024 16:51:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4C2720040;
 Wed, 18 Sep 2024 16:51:12 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2024 16:51:12 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v3 3/3] hw/ssi/pnv_spi: Use local var seq_index instead of
 get_seq_index().
Date: Wed, 18 Sep 2024 11:50:45 -0500
Message-Id: <20240918165045.21298-4-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -VLKMdax0HoF6gw7vsT8n7pYpw6jlDFD
X-Proofpoint-ORIG-GUID: LP4IToh9U-vHkHqrNnjU8cWbGIwtVe-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=802 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use a local variable seq_index instead of repeatedly caling
get_seq_index() method.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 61 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 2fd5aa0a96..962115f40f 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -210,15 +210,8 @@ static void transfer(PnvSpi *s)
     fifo8_reset(&s->rx_fifo);
 }
 
-static inline uint8_t get_seq_index(PnvSpi *s)
-{
-    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
-}
-
 static inline void next_sequencer_fsm(PnvSpi *s)
 {
-    uint8_t seq_index = get_seq_index(s);
-    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 1));
     s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_INCREMENT);
 }
 
@@ -647,6 +640,7 @@ static void operation_sequencer(PnvSpi *s)
     bool stop = false; /* Flag to stop the sequencer */
     uint8_t opcode = 0;
     uint8_t masked_opcode = 0;
+    uint8_t seq_index;
 
     /*
      * Clear the sequencer FSM error bit - general_SPI_status[3]
@@ -660,12 +654,13 @@ static void operation_sequencer(PnvSpi *s)
     if (GETFIELD(SPI_STS_SEQ_FSM, s->status) == SEQ_STATE_IDLE) {
         s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
     }
+    seq_index = GETFIELD(SPI_STS_SEQ_INDEX, s->status);
     /*
      * There are only 8 possible operation IDs to iterate through though
      * some operations may cause more than one frame to be sequenced.
      */
-    while (get_seq_index(s) < NUM_SEQ_OPS) {
-        opcode = s->seq_op[get_seq_index(s)];
+    while (seq_index < NUM_SEQ_OPS) {
+        opcode = s->seq_op[seq_index];
         /* Set sequencer state to decode */
         s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DECODE);
         /*
@@ -682,7 +677,7 @@ static void operation_sequencer(PnvSpi *s)
         case SEQ_OP_STOP:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             /* A stop operation in any position stops the sequencer */
-            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("STOP", seq_index);
 
             stop = true;
             s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
@@ -693,7 +688,7 @@ static void operation_sequencer(PnvSpi *s)
 
         case SEQ_OP_SELECT_SLAVE:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("SELECT_SLAVE", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("SELECT_SLAVE", seq_index);
             /*
              * This device currently only supports a single responder
              * connection at position 0.  De-selecting a responder is fine
@@ -704,8 +699,7 @@ static void operation_sequencer(PnvSpi *s)
             if (s->responder_select == 0) {
                 trace_pnv_spi_shifter_done();
                 qemu_set_irq(s->cs_line[0], 1);
-                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                (get_seq_index(s) + 1));
+                seq_index++;
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_DONE);
             } else if (s->responder_select != 1) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
@@ -732,13 +726,14 @@ static void operation_sequencer(PnvSpi *s)
                  * applies once a valid responder select has occurred.
                  */
                 s->shift_n1_done = false;
+                seq_index++;
                 next_sequencer_fsm(s);
             }
             break;
 
         case SEQ_OP_SHIFT_N1:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("SHIFT_N1", seq_index);
             /*
              * Only allow a shift_n1 when the state is not IDLE or DONE.
              * In either of those two cases the sequencer is not in a proper
@@ -770,8 +765,9 @@ static void operation_sequencer(PnvSpi *s)
                  * transmission to the responder without requiring a refill of
                  * the TDR between the two operations.
                  */
-                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1])
-                                == SEQ_OP_SHIFT_N2) {
+                if ((seq_index != 7) &&
+                    PNV_SPI_MASKED_OPCODE(s->seq_op[(seq_index + 1)]) ==
+                    SEQ_OP_SHIFT_N2) {
                     send_n1_alone = false;
                 }
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
@@ -793,8 +789,7 @@ static void operation_sequencer(PnvSpi *s)
                         s->shift_n1_done = true;
                         s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
                                                   FSM_SHIFT_N2);
-                        s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                        (get_seq_index(s) + 1));
+                        seq_index++;
                     } else {
                         /*
                          * This is case (1) or (2) so the sequencer needs to
@@ -806,6 +801,7 @@ static void operation_sequencer(PnvSpi *s)
                 } else {
                     /* Ok to move on to the next index */
                     s->shift_n1_done = true;
+                    seq_index++;
                     next_sequencer_fsm(s);
                 }
             }
@@ -813,7 +809,7 @@ static void operation_sequencer(PnvSpi *s)
 
         case SEQ_OP_SHIFT_N2:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("SHIFT_N2", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("SHIFT_N2", seq_index);
             if (!s->shift_n1_done) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not allowed if a "
                               "Shift_N1 is not done, shifter state = 0x%llx",
@@ -841,6 +837,7 @@ static void operation_sequencer(PnvSpi *s)
                                     FSM_WAIT);
                 } else {
                     /* Ok to move on to the next index */
+                    seq_index++;
                     next_sequencer_fsm(s);
                 }
             }
@@ -848,7 +845,7 @@ static void operation_sequencer(PnvSpi *s)
 
         case SEQ_OP_BRANCH_IFNEQ_RDR:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR", seq_index);
             /*
              * The memory mapping register RDR match value is compared against
              * the 16 rightmost bytes of the RDR (potentially with masking).
@@ -864,6 +861,7 @@ static void operation_sequencer(PnvSpi *s)
                 if (rdr_matched) {
                     trace_pnv_spi_RDR_match("success");
                     /* A match occurred, increment the sequencer index. */
+                    seq_index++;
                     next_sequencer_fsm(s);
                 } else {
                     trace_pnv_spi_RDR_match("failed");
@@ -871,8 +869,7 @@ static void operation_sequencer(PnvSpi *s)
                      * Branch the sequencer to the index coded into the op
                      * code.
                      */
-                    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                    PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                    seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 }
                 /*
                  * Regardless of where the branch ended up we want the
@@ -891,12 +888,13 @@ static void operation_sequencer(PnvSpi *s)
         case SEQ_OP_TRANSFER_TDR:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not supported\n");
+            seq_index++;
             next_sequencer_fsm(s);
             break;
 
         case SEQ_OP_BRANCH_IFNEQ_INC_1:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1", seq_index);
             /*
              * The spec says the loop should execute count compare + 1 times.
              * However we learned from engineering that we really only loop
@@ -910,18 +908,18 @@ static void operation_sequencer(PnvSpi *s)
                  * mask off all but the first three bits so we don't try to
                  * access beyond the sequencer_operation_reg boundary.
                  */
-                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 s->loop_counter_1++;
             } else {
                 /* Continue to next index if loop counter is reached */
+                seq_index++;
                 next_sequencer_fsm(s);
             }
             break;
 
         case SEQ_OP_BRANCH_IFNEQ_INC_2:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", seq_index);
             uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
                               s->regs[SPI_CTR_CFG_REG]);
             /*
@@ -936,11 +934,11 @@ static void operation_sequencer(PnvSpi *s)
                  * mask off all but the first three bits so we don't try to
                  * access beyond the sequencer_operation_reg boundary.
                  */
-                s->status = SETFIELD(SPI_STS_SEQ_INDEX,
-                                s->status, PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 s->loop_counter_2++;
             } else {
                 /* Continue to next index if loop counter is reached */
+                seq_index++;
                 next_sequencer_fsm(s);
             }
             break;
@@ -948,6 +946,7 @@ static void operation_sequencer(PnvSpi *s)
         default:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             /* Ignore unsupported operations. */
+            seq_index++;
             next_sequencer_fsm(s);
             break;
         } /* end of switch */
@@ -956,10 +955,10 @@ static void operation_sequencer(PnvSpi *s)
          * we need to go ahead and end things as if there was a STOP at the
          * end.
          */
-        if (get_seq_index(s) == NUM_SEQ_OPS) {
+        if (seq_index == NUM_SEQ_OPS) {
             /* All 8 opcodes completed, sequencer idling */
             s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
-            s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
+            seq_index = 0;
             s->loop_counter_1 = 0;
             s->loop_counter_2 = 0;
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_IDLE);
@@ -970,6 +969,8 @@ static void operation_sequencer(PnvSpi *s)
             break;
         }
     } /* end of while */
+    /* Update sequencer index field in status.*/
+    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, seq_index);
     return;
 } /* end of operation_sequencer() */
 
-- 
2.39.5


