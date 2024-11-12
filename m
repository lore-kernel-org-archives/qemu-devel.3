Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C89D42BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 15:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtHX-0002LV-Pf; Tue, 12 Nov 2024 10:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tAtHN-0002Ke-6g; Tue, 12 Nov 2024 10:58:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tAtHL-0001eE-90; Tue, 12 Nov 2024 10:58:08 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFeCwo003041;
 Tue, 12 Nov 2024 15:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RsHom+cV/PCnrj3ze
 xPa05UgTEsdBBRlm3sBdGiz7d0=; b=I0OZs7U57s5lkjXebx29S2Q+m3Jk4Cpvj
 d1s69V/+NthX/9c3wp8K54NoM9XQ5EX7vH5G7R3fry9xc2pJsRkMFpOQUjxMLjwW
 QmCfXOCfjzPXEPAKDMaCdR3NgaL81N3LRWZk97Kc/CtbLB98S7LB5+4hYYuPbH+S
 k+K/nr72cj1+jVrv1AGjHfjiHbDL105mtFOopk4eGfujJ1EHOqMAU/iCnMr54WhK
 uodJ8nfYr3XOj7jTD2KrPm1Rm9feQvTzG8DgZX+J5RI8KDLvWtb0OVqs8sv7omV8
 6UveXOE7giu617iRUgUzHCSC5JflL5D+iSbvypyKRTpSj4TxHtFSA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9uy82gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:58:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ACFrkmS001348;
 Tue, 12 Nov 2024 15:58:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9uy82ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:58:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFvoR7029698;
 Tue, 12 Nov 2024 15:58:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjktf99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:58:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFvqgO18940380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:57:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E4A520043;
 Tue, 12 Nov 2024 15:57:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2982220040;
 Tue, 12 Nov 2024 15:57:50 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:57:49 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v4 2/2] hw/ssi/pnv_spi: Coverity CID 1558827: Use local var
 seq_index instead of get_seq_index().
Date: Tue, 12 Nov 2024 09:57:39 -0600
Message-Id: <20241112155739.4447-3-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112155739.4447-1-chalapathi.v@linux.ibm.com>
References: <20241112155739.4447-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PXwOKOlqX8Q6qwR0YUDUuSzXkq0bKPpP
X-Proofpoint-GUID: dcWYGF_9Q44wa0WqZ1e3qOyiWJ_0-Owb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=852 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use a local variable seq_index instead of repeatedly calling
get_seq_index() method and open-code next_sequencer_fsm().

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 hw/ssi/pnv_spi.c | 93 +++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 45 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index c2f1c6ca8e..f26b0da1fc 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -212,18 +212,6 @@ static void transfer(PnvSpi *s)
     fifo8_reset(&s->rx_fifo);
 }
 
-static inline uint8_t get_seq_index(PnvSpi *s)
-{
-    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
-}
-
-static inline void next_sequencer_fsm(PnvSpi *s)
-{
-    uint8_t seq_index = get_seq_index(s);
-    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 1));
-    s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_INCREMENT);
-}
-
 /*
  * Calculate the N1 counters based on passed in opcode and
  * internal register values.
@@ -637,6 +625,7 @@ static void operation_sequencer(PnvSpi *s)
     bool stop = false; /* Flag to stop the sequencer */
     uint8_t opcode = 0;
     uint8_t masked_opcode = 0;
+    uint8_t seq_index;
 
     /*
      * Clear the sequencer FSM error bit - general_SPI_status[3]
@@ -650,12 +639,13 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -672,7 +662,7 @@ static void operation_sequencer(PnvSpi *s)
         case SEQ_OP_STOP:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             /* A stop operation in any position stops the sequencer */
-            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("STOP", seq_index);
 
             stop = true;
             s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
@@ -683,7 +673,7 @@ static void operation_sequencer(PnvSpi *s)
 
         case SEQ_OP_SELECT_SLAVE:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("SELECT_SLAVE", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("SELECT_SLAVE", seq_index);
             /*
              * This device currently only supports a single responder
              * connection at position 0.  De-selecting a responder is fine
@@ -694,8 +684,7 @@ static void operation_sequencer(PnvSpi *s)
             if (s->responder_select == 0) {
                 trace_pnv_spi_shifter_done();
                 qemu_set_irq(s->cs_line[0], 1);
-                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                (get_seq_index(s) + 1));
+                seq_index++;
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_DONE);
             } else if (s->responder_select != 1) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
@@ -720,13 +709,15 @@ static void operation_sequencer(PnvSpi *s)
                  * applies once a valid responder select has occurred.
                  */
                 s->shift_n1_done = false;
-                next_sequencer_fsm(s);
+                seq_index++;
+                s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
+                                SEQ_STATE_INDEX_INCREMENT);
             }
             break;
 
         case SEQ_OP_SHIFT_N1:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("SHIFT_N1", seq_index);
             /*
              * Only allow a shift_n1 when the state is not IDLE or DONE.
              * In either of those two cases the sequencer is not in a proper
@@ -758,8 +749,9 @@ static void operation_sequencer(PnvSpi *s)
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
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_SHIFT_N1);
@@ -779,9 +771,8 @@ static void operation_sequencer(PnvSpi *s)
                     if (GETFIELD(SPI_STS_TDR_UNDERRUN, s->status)) {
                         s->shift_n1_done = true;
                         s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
-                                        FSM_SHIFT_N2);
-                        s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                        (get_seq_index(s) + 1));
+                                                  FSM_SHIFT_N2);
+                        seq_index++;
                     } else {
                         /*
                          * This is case (1) or (2) so the sequencer needs to
@@ -792,14 +783,16 @@ static void operation_sequencer(PnvSpi *s)
                 } else {
                     /* Ok to move on to the next index */
                     s->shift_n1_done = true;
-                    next_sequencer_fsm(s);
+                    seq_index++;
+                    s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
+                                    SEQ_STATE_INDEX_INCREMENT);
                 }
             }
             break;
 
         case SEQ_OP_SHIFT_N2:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("SHIFT_N2", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("SHIFT_N2", seq_index);
             if (!s->shift_n1_done) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Shift_N2 is not allowed if a "
                               "Shift_N1 is not done, shifter state = 0x%llx",
@@ -824,14 +817,16 @@ static void operation_sequencer(PnvSpi *s)
                     s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_WAIT);
                 } else {
                     /* Ok to move on to the next index */
-                    next_sequencer_fsm(s);
+                    seq_index++;
+                    s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
+                                    SEQ_STATE_INDEX_INCREMENT);
                 }
             }
             break;
 
         case SEQ_OP_BRANCH_IFNEQ_RDR:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_RDR", seq_index);
             /*
              * The memory mapping register RDR match value is compared against
              * the 16 rightmost bytes of the RDR (potentially with masking).
@@ -847,15 +842,16 @@ static void operation_sequencer(PnvSpi *s)
                 if (rdr_matched) {
                     trace_pnv_spi_RDR_match("success");
                     /* A match occurred, increment the sequencer index. */
-                    next_sequencer_fsm(s);
+                    seq_index++;
+                    s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
+                                    SEQ_STATE_INDEX_INCREMENT);
                 } else {
                     trace_pnv_spi_RDR_match("failed");
                     /*
                      * Branch the sequencer to the index coded into the op
                      * code.
                      */
-                    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                    PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                    seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 }
                 /*
                  * Regardless of where the branch ended up we want the
@@ -874,12 +870,13 @@ static void operation_sequencer(PnvSpi *s)
         case SEQ_OP_TRANSFER_TDR:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             qemu_log_mask(LOG_GUEST_ERROR, "Transfer TDR is not supported\n");
-            next_sequencer_fsm(s);
+            seq_index++;
+            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_INCREMENT);
             break;
 
         case SEQ_OP_BRANCH_IFNEQ_INC_1:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_1", seq_index);
             /*
              * The spec says the loop should execute count compare + 1 times.
              * However we learned from engineering that we really only loop
@@ -893,19 +890,21 @@ static void operation_sequencer(PnvSpi *s)
                  * mask off all but the first three bits so we don't try to
                  * access beyond the sequencer_operation_reg boundary.
                  */
-                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 s->loop_counter_1++;
             } else {
                 /* Continue to next index if loop counter is reached */
-                next_sequencer_fsm(s);
+                seq_index++;
+                s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
+                                SEQ_STATE_INDEX_INCREMENT);
             }
             break;
 
         case SEQ_OP_BRANCH_IFNEQ_INC_2:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", get_seq_index(s));
-            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2, s->regs[SPI_CTR_CFG_REG]);
+            trace_pnv_spi_sequencer_op("BRANCH_IFNEQ_INC_2", seq_index);
+            uint8_t condition2 = GETFIELD(SPI_CTR_CFG_CMP2,
+                              s->regs[SPI_CTR_CFG_REG]);
             /*
              * The spec says the loop should execute count compare + 1 times.
              * However we learned from engineering that we really only loop
@@ -918,19 +917,21 @@ static void operation_sequencer(PnvSpi *s)
                  * mask off all but the first three bits so we don't try to
                  * access beyond the sequencer_operation_reg boundary.
                  */
-                s->status = SETFIELD(SPI_STS_SEQ_INDEX,
-                                s->status, PNV_SPI_OPCODE_LO_NIBBLE(opcode));
+                seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 s->loop_counter_2++;
             } else {
                 /* Continue to next index if loop counter is reached */
-                next_sequencer_fsm(s);
+                seq_index++;
+                s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
+                                SEQ_STATE_INDEX_INCREMENT);
             }
             break;
 
         default:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             /* Ignore unsupported operations. */
-            next_sequencer_fsm(s);
+            seq_index++;
+            s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_INCREMENT);
             break;
         } /* end of switch */
         /*
@@ -938,10 +939,10 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -952,6 +953,8 @@ static void operation_sequencer(PnvSpi *s)
             break;
         }
     } /* end of while */
+    /* Update sequencer index field in status.*/
+    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, seq_index);
     return;
 } /* end of operation_sequencer() */
 
-- 
2.39.5


