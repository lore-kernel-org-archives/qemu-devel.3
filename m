Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44CBC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzIw-0003FU-8s; Tue, 11 Mar 2025 09:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDl-0004tJ-OT; Tue, 11 Mar 2025 09:00:42 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDf-0008SW-Oh; Tue, 11 Mar 2025 09:00:33 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff04f36fd2so9014252a91.1; 
 Tue, 11 Mar 2025 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698025; x=1742302825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltiIpntD1e/ZvbcOYuUkJzWPVpcS1p6NcC9JSvLJgJs=;
 b=gh37F6v75VHtGQ30qUt8BY5QNVQSu+jF5GU2C4YlYgsDN/UyHTOTorKh8AaicBhq4V
 hwzJrfyqH2vT/Rxf+NYCh5p33RsvCXzkl18j+zI7u6kF/O/wp7TIr5I8sZlr+7Ahb5IZ
 DoMGWjCJDxAm36mR6LtzKQuzNs5yZFVolPwjBzduBa7caE6egW08O7wqqZxG60bvmN0R
 tR80hi2TxUFIQiNFxaVYHa1CyUVgIQ2du+T/FKDpqzFrfGS+jN9VhRL0+M3k7ykdvlDd
 eUGFJ0lnG0wcPpkOIaUQgF2kZkYj2p/7nlxkIOwmQJYZKEEYuEFDWQIZ4DBjdGlOicpO
 QwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698025; x=1742302825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltiIpntD1e/ZvbcOYuUkJzWPVpcS1p6NcC9JSvLJgJs=;
 b=QCnwBwRm58r4O089lCOCkn1SpNFIqUFWvAtvfLszY6VjilkNgH1UjC9F60wy9T7e+s
 Ag/9GZdDMxUcn3flIja0bKa6JnMTmVV/J4PtDmmTWZrghqMPkVsT/fSEddohbgLBmH6u
 RuLKiuAfA5FRrSQyUPQEefpgbL1hUBhQnlyw2lgy5xyVWWfXRR4bIIxPgoaHjj07ChQO
 vMOJrGCKZZJTkeBE11SFuDXHhwkp9pPu4LwAcId6AUNvblMgh6GkZFLplfdzPRRFtIrE
 4bIZw/BPrzIPfwuM62djg/IZ3qnmGa90Iiy5fc7pqg/Ug+MkyuVuaNcF9rRjDMsWD3R1
 kw2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMnqXcYEGufZYxmhqdN62corU3omZmSYgbokCAyHZ9+0aDpTosFYn5esq6XZEaW2HfzZWTZSUE2A==@nongnu.org
X-Gm-Message-State: AOJu0Yxg2De6tSHI0TTL7xTV3GEMwbZHkbmzUVyOh516PYhIl7W+XymF
 ccefWAyR4LlqIe3YDpvNHf6NfY39VBShYbEPMjy9DeZ8bjwJkWNsScSAQw==
X-Gm-Gg: ASbGncspVS4NBIffocKZ/bOTB8/nK9vvSu1LhFZc1jZ+9zHWn7FlbA7a6XMJRaS7+mB
 5dPktMEt9k75ELmlKKhs3OQWJzhtuhfnaHx888s4KljZv0gWtSsaMrKlcaS4kqZRpkJk1+3DTT/
 xL3jPFt9NhrLvpdpaZYuciMDAPn/epLMm5REIgJmQnPzicFzi3eha9KF8YIn502tdkXk8kj7q2H
 OYa3VY9ZrhNNLmpxtzEgNaM5aZNFmraG+aaYndpeyFGUe/o6Ph55OX8VROIMyffL/Gd/cR6pYlR
 lodYwfTyUbCSfHcWEljK0DH626ikDUwpynsWmpOqnEGEQz1Wfh0=
X-Google-Smtp-Source: AGHT+IEUX7EQKfo4DCOgQUmp+PAEpVwTq+rX9BWmWCAia6eMLOHO9RLW5iwyQW9TghvOet5wGrhpFg==
X-Received: by 2002:a17:90b:2e51:b0:2ff:7331:18bc with SMTP id
 98e67ed59e1d1-2ff7ceee7ebmr22740098a91.26.1741698024574; 
 Tue, 11 Mar 2025 06:00:24 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 38/72] hw/ssi/pnv_spi: Use local var seq_index instead of
 get_seq_index().
Date: Tue, 11 Mar 2025 22:57:32 +1000
Message-ID: <20250311125815.903177-39-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

Use a local variable seq_index instead of repeatedly calling
get_seq_index() method and open-code next_sequencer_fsm().

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250303141328.23991-3-chalapathi.v@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ssi/pnv_spi.c | 97 ++++++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 388b425157..de33542c35 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -227,18 +227,6 @@ static void transfer(PnvSpi *s)
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
@@ -664,6 +652,7 @@ static void operation_sequencer(PnvSpi *s)
     bool stop = false; /* Flag to stop the sequencer */
     uint8_t opcode = 0;
     uint8_t masked_opcode = 0;
+    uint8_t seq_index;
 
     /*
      * Clear the sequencer FSM error bit - general_SPI_status[3]
@@ -677,12 +666,17 @@ static void operation_sequencer(PnvSpi *s)
     if (GETFIELD(SPI_STS_SEQ_FSM, s->status) == SEQ_STATE_IDLE) {
         s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
     }
+    /*
+     * SPI_STS_SEQ_INDEX of status register is kept in seq_index variable and
+     * updated back to status register at the end of operation_sequencer().
+     */
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
@@ -699,7 +693,7 @@ static void operation_sequencer(PnvSpi *s)
         case SEQ_OP_STOP:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
             /* A stop operation in any position stops the sequencer */
-            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("STOP", seq_index);
 
             stop = true;
             s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
@@ -710,7 +704,7 @@ static void operation_sequencer(PnvSpi *s)
 
         case SEQ_OP_SELECT_SLAVE:
             s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
-            trace_pnv_spi_sequencer_op("SELECT_SLAVE", get_seq_index(s));
+            trace_pnv_spi_sequencer_op("SELECT_SLAVE", seq_index);
             /*
              * This device currently only supports a single responder
              * connection at position 0.  De-selecting a responder is fine
@@ -721,8 +715,7 @@ static void operation_sequencer(PnvSpi *s)
             if (s->responder_select == 0) {
                 trace_pnv_spi_shifter_done();
                 qemu_set_irq(s->cs_line[0], 1);
-                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
-                                (get_seq_index(s) + 1));
+                seq_index++;
                 s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_DONE);
             } else if (s->responder_select != 1) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
@@ -747,13 +740,15 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -785,8 +780,9 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -806,9 +802,8 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -819,14 +814,16 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -851,14 +848,16 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -874,15 +873,16 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -901,12 +901,13 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -920,19 +921,21 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -945,19 +948,21 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -965,10 +970,10 @@ static void operation_sequencer(PnvSpi *s)
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
@@ -979,6 +984,8 @@ static void operation_sequencer(PnvSpi *s)
             break;
         }
     } /* end of while */
+    /* Update sequencer index field in status.*/
+    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, seq_index);
     return;
 } /* end of operation_sequencer() */
 
-- 
2.47.1


