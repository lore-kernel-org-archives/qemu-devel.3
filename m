Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AA3C3ABC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZv-00074x-Mq; Sun, 11 May 2025 23:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZu-00074V-8K; Sun, 11 May 2025 23:11:42 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZs-0006kg-JZ; Sun, 11 May 2025 23:11:41 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so4453046b3a.0; 
 Sun, 11 May 2025 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019498; x=1747624298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRvTAYNmL8RyPffLRzrCxFQw869umWAXeoSjF7/UghA=;
 b=bwFKNI/Q5BV8w88DPQmqfqrNPwWFsq4eQMSipw46JwLYJMh3wwf8XI4tpohGaH6B4g
 30KMOkVD+6ccufieOtExJrl8McNLOy2IU+NsYI0badjBuC+E5GLiZKOnIhMs6eom/EFE
 IPVTpPQffoqrL0owCBjkxCcVI37+6NINzQ8/qdDcoDPvFuJzEs2Y7qeNmjwwt7EXX7rn
 sWXhMg/m3yDtUi4L5xoozBtomPoQQ4/Ud6YvUa0KkwangGW0N6CcZbVS5nGKBGFmEnqU
 tKdqy+y5WaDluP0IDy1uIbTXJWnEEXCbbhOJJwDBryQ69+uLwbvEjDKsIonIQyl1Hf8K
 ok+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019498; x=1747624298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRvTAYNmL8RyPffLRzrCxFQw869umWAXeoSjF7/UghA=;
 b=ekHMv9ksrN1n4XaxpP0aOJbdbYTOt05NiFsLUFnMJZZ0drpVhdPC1FGXYn6f/WF87t
 qe203cGZv22Eu65MvbfvRIxmiplsvUZIdogzQ1Eg+ycXsOEjOKVNAZRnBd9s66H+BQXB
 /K3XKXjwYc8KYHEyJLQyI3+O3el7nBOy4JWJrv9XSfPAeeoFtGSyvjw9YE6S4FSrUoeO
 k9WntcKYrlsQBCl1KvD/jaD26uH5TiAMWI8qYrL5tpsfAO/o97Ye5zSMRSizbI9hD8Pv
 jFbY+LIbKKbFt84Zomx8HVD3CcTXjKVLpS++2cRLXsxtzqEc2UcWMF/uqNWMXP8UHhtl
 qujg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZYITxMDfajCenZ4ToxG3uUD1qZJERTKwpFmb9t9GiGczEiKGg2zfaDhobIHuA8HqbY90qVjq5Xhi3@nongnu.org
X-Gm-Message-State: AOJu0YzteyLjinbX8bHieaKWGOYmeNXYb3/OBE/NilewuqZ0BQ7Hzb6Z
 DWqpzNjUEvTnuL/tbSiotIKz7OwYkNLQOFg6KWnNY5inSQXVMnJrI7QPnA==
X-Gm-Gg: ASbGncuNYw11PR0pXHPVHjsvScqBiyrTkNDfkqnFn3rKLQ0vhdNhI6KxbEmdSEwj/11
 QpaW+9SHKBp124J+992wx6kemWBOT28tYRw+5z/sdhQfqJg8YgOSpWdeg4JDJZ183pvR5lO2xEG
 pxvON3Lwqag6bgbwz97cTZbQM77+ZR+8JuchMxwNel4h/wmyu2rCvFloVnJhDLr9A+8rNP2CKWw
 nZizRIC2WaNyZ3JIsgDtQQBLqxY9T4LJ4SzcvuCspweMitw5lgxt1WN1Hw8TCczrPWAFG7lWz0m
 L9zZfEbNmkbDXKuXBfiuNf2SmNSbcFG1C8ZkfXwRkJ5lLM1AFOgFMuGThQ==
X-Google-Smtp-Source: AGHT+IGLwW1vyGKDTdqFLuL2vb+elJ+wgQX6pM6InVmSMMxUtheXR9B6y9C/Y6FCrnI8TfqqlegGqA==
X-Received: by 2002:a05:6a20:d48d:b0:1fd:f4df:ab67 with SMTP id
 adf61e73a8af0-215ab6db883mr16330950637.21.1747019498305; 
 Sun, 11 May 2025 20:11:38 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 08/50] ppc/xive2: Use fair irq target search algorithm
Date: Mon, 12 May 2025 13:10:17 +1000
Message-ID: <20250512031100.439842-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

From: Glenn Miles <milesg@linux.ibm.com>

The current xive algorithm for finding a matching group vCPU
target always uses the first vCPU found.  And, since it always
starts the search with thread 0 of a core, thread 0 is almost
always used to handle group interrupts.  This can lead to additional
interrupt latency and poor performance for interrupt intensive
work loads.

Changing this to use a simple round-robin algorithm for deciding which
thread number to use when starting a search, which leads to a more
distributed use of threads for handling group interrupts.

[npiggin: Also round-robin among threads, not just cores]
Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 72cdf0f20c..d7ca97ecbb 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -643,13 +643,18 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
     int i, j;
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
+    static int next_start_core;
+    static int next_start_thread;
+    int start_core = next_start_core;
+    int start_thread = next_start_thread;
 
     for (i = 0; i < chip->nr_cores; i++) {
-        PnvCore *pc = chip->cores[i];
+        PnvCore *pc = chip->cores[(i + start_core) % chip->nr_cores];
         CPUCore *cc = CPU_CORE(pc);
 
         for (j = 0; j < cc->nr_threads; j++) {
-            PowerPCCPU *cpu = pc->threads[j];
+            /* Start search for match with different thread each call */
+            PowerPCCPU *cpu = pc->threads[(j + start_thread) % cc->nr_threads];
             XiveTCTX *tctx;
             int ring;
 
@@ -694,6 +699,15 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                     if (!match->tctx) {
                         match->ring = ring;
                         match->tctx = tctx;
+
+                        next_start_thread = j + start_thread + 1;
+                        if (next_start_thread >= cc->nr_threads) {
+                            next_start_thread = 0;
+                            next_start_core = i + start_core + 1;
+                            if (next_start_core >= chip->nr_cores) {
+                                next_start_core = 0;
+                            }
+                        }
                     }
                     count++;
                 }
-- 
2.47.1


