Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F577C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzIv-0003Cz-F6; Tue, 11 Mar 2025 09:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDp-0004v6-Qh; Tue, 11 Mar 2025 09:00:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDl-0008WV-Sd; Tue, 11 Mar 2025 09:00:35 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so7175187a91.1; 
 Tue, 11 Mar 2025 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698030; x=1742302830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+hvRNZhyfNMby5k48ebI9t7MyykDhncL1DN8gtvFQA=;
 b=eSywFVXrP4iijlCcvKDl+XqgBov45nb+yLSZgiY/DyUqwFwPPc+tSzdo/f7aNXs1iw
 AeXsPhNDgA5AmIGJGPS8BqMPt+U+MehoQJz/gFkTx874Isknio7ycfFiJPdKgEJ3lBq8
 yyVva2D3QqFAA1aXF6REiogWSSD4mrkbbai34SjClcmbhRs7F7fwnbGqjxSlewQjSZCu
 KTqGaUKSPI6crCFNQ9SU5OdcbBEW9kyN/s2ZyBxDBobn80sJ4O1WSo6T8sOB9R8w0hnR
 7QwX3eYxnuQn+1mC51fNxENvzYFEAuLN5m9ev/9oqw4hEYw6TaZGSxjxW1k4UtwJajUD
 SKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698030; x=1742302830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+hvRNZhyfNMby5k48ebI9t7MyykDhncL1DN8gtvFQA=;
 b=DMbtECXifVt4/XitHQOktuQyAfdPLGm7wwukdACrKY1IQiBakOsydZcgk7lTYHscOv
 7YMTBa6aK30b9nFappL1PW/Gf06Y9YIqCX8XMlW5Ifb3Bx+1/XyKfLWU0d5i3XySmwbP
 bfQvv0zKrc7l0rowQxFFR+tKje2rEPmNjcydy2gsVtvoJvi0pkj9073oEVhXPOB3I40g
 m8lJ0NhsunjvmjZQiPgdThxhbkYwKquPkFhkxXPtx6BPU4eGDjg4P/lnS7iw9606YLGi
 N5H3fXNTyfUKBw/ZTFEsyTiar/jpRMDFH8qsjIzaPzEdWa6IQkFB0OKKcZngrCqZgHhb
 qvbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9RfPREC1G/uoLEsSAMYyyEwbrSgLMDq2Sf92O7LIKRXTMCG++++YaWyVcG7+nSyZKop2HBInNuQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz5I05OjwhgJAxowh76v/Kupqt8cReS/G+Z8ep5pypyDREhq5Zh
 G6vo0c9WMwM6VHDKq58GCbO4OUfaJpztZBzcnvsbxZ1RJKlSPUlZsDLHvQ==
X-Gm-Gg: ASbGncuSaMvKlg2hGuua4Btlo9+CgMt1mHG95zKGvJHt4uLqpwUHT274dkat66LMC2c
 4zDPKY25fJHF9Gq/2jV2/Axit1hGRw4976zWY0Ju/N7cWjegAak9Mfi6aq1PVTF5hPpBeS+YwnA
 9YatzKpz2RDRaxyZtApwghYaRWdN8s4NN9sbcG125wnQMyJ8r5M/r4Vato5z1jy+mqtSfCpQKGs
 cORxbgC0qjrjhm0QnRYMKWn5utUJ773ztZL3IXi7ji/KoZSwAQMpzaX7QjGw1QV1E+Ukry2xhNh
 Vj+TWKYbWpVZoV3oaNaORwP3pQL2x+IGSEf+9JWkP4oc6HyOCgW9pHxhSG9Nmg==
X-Google-Smtp-Source: AGHT+IGu88eBRybEnsZgPcHrjAlxoFTCJ0W9NxLeLN700ULZI4NP7fp5wZAQOeuXJJgQfk5WJy4Ytw==
X-Received: by 2002:a17:90b:528a:b0:2ff:6e72:b8e2 with SMTP id
 98e67ed59e1d1-300ff37051bmr4324135a91.31.1741698030344; 
 Tue, 11 Mar 2025 06:00:30 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 40/72] hw/ssi/pnv_spi: Put a limit to RDR match failures
Date: Tue, 11 Mar 2025 22:57:34 +1000
Message-ID: <20250311125815.903177-41-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

There is a possibility that SPI controller can get into loop due to indefinite
RDR match failures. Hence put a limit to failures and stop the sequencer.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250303141328.23991-5-chalapathi.v@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ssi/pnv_spi.c         | 10 ++++++++++
 include/hw/ssi/pnv_spi.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 83221607c9..126070393e 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -20,6 +20,7 @@
 #define PNV_SPI_OPCODE_LO_NIBBLE(x) (x & 0x0F)
 #define PNV_SPI_MASKED_OPCODE(x) (x & 0xF0)
 #define PNV_SPI_FIFO_SIZE 16
+#define RDR_MATCH_FAILURE_LIMIT 16
 
 /*
  * Macro from include/hw/ppc/fdt.h
@@ -872,18 +873,27 @@ static void operation_sequencer(PnvSpi *s)
                 rdr_matched = does_rdr_match(s);
                 if (rdr_matched) {
                     trace_pnv_spi_RDR_match("success");
+                    s->fail_count = 0;
                     /* A match occurred, increment the sequencer index. */
                     seq_index++;
                     s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status,
                                     SEQ_STATE_INDEX_INCREMENT);
                 } else {
                     trace_pnv_spi_RDR_match("failed");
+                    s->fail_count++;
                     /*
                      * Branch the sequencer to the index coded into the op
                      * code.
                      */
                     seq_index = PNV_SPI_OPCODE_LO_NIBBLE(opcode);
                 }
+                if (s->fail_count >= RDR_MATCH_FAILURE_LIMIT) {
+                    qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi: RDR match failure"
+                                  " limit crossed %d times hence requesting "
+                                  "sequencer to stop.\n",
+                                  RDR_MATCH_FAILURE_LIMIT);
+                    stop = true;
+                }
                 /*
                  * Regardless of where the branch ended up we want the
                  * sequencer to continue shifting so we have to clear
diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index 6adb72dbb2..c591a0663d 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -40,6 +40,7 @@ typedef struct PnvSpi {
     MemoryRegion    xscom_spic_regs;
     Fifo8 tx_fifo;
     Fifo8 rx_fifo;
+    uint8_t fail_count; /* RDR Match failure counter */
     /* SPI object number */
     uint32_t        spic_num;
     uint32_t        chip_id;
-- 
2.47.1


