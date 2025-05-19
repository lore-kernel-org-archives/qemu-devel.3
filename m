Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CF8C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrtF-000310-5K; Mon, 19 May 2025 00:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmc-0004jC-S6; Mon, 19 May 2025 00:07:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmb-000457-4N; Mon, 19 May 2025 00:07:22 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2322f8afe02so4399185ad.2; 
 Sun, 18 May 2025 21:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627638; x=1748232438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXBhzTWpJ1Fn/A81GjUvhAo2o2EtkxBbSGZOC7qOGx4=;
 b=KAHlNkjHjX+yVigfjQ0wbVOM9bvVQkMpR6VZQUV8htB9Aptio1kauq5wYtKfhkvCoi
 DbKc5Er2ekthDE9LntrYhmlUYJk4ROjrFzvtDUrKrjxrVHfuRJlk2cD5sXp12EiIXn6/
 zHUZgTp+roP9UUJMqBtEJ7hHteFtAMStt5uiB2EEGjBC8NHLYZLwJtsAHEQUmGDmtqrh
 j9Q0abzjiA+8S4qYNT9Z2Mdn1hRHZ7Z8n8WRoS4H0S0ppiHz+anw06aIMFJ59qCImWyE
 d2emPcSEhpGx1J5hAvynABuxIUCPv/OzgFRF3CwCgf6me2HIbNMQm26G6bHamD5KXgNr
 mf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627638; x=1748232438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXBhzTWpJ1Fn/A81GjUvhAo2o2EtkxBbSGZOC7qOGx4=;
 b=gk1xNH+o+5+KVPZq1/1O26/HWqGWaAHkDCQX10IEGanEjVQ2yos59+TtwX5Y1J8kzp
 NgBnFWM6a4/bFLU1acEDmu6FK42jgkrUdAb7OjHI9KahPwQiLBcy//FWbEB4ZvasiXxF
 WIEOzYww6vMdVcN+Nb3zAueiCHO8NGWUCCBvjK7G636ad/i4aKpCDxSBWNZzRufRW6s0
 kuWEwhBFX1r7HsgCho/f8dQ2gOVZhemi6fQKUXoyaDovoWHkG5rvo8G7OGE1YJWZ5Fx9
 EnbS2j/OwEaXr80iseZyADa9qkZm5ApSMpgVet9J11UKaxlTMt5Ngy7bMtJWy9y9DalO
 I6ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCBFnKgR+UQre0zv8GLG8OEm9y6icmfutXnWiwLfIIH2d6bP/TZ+YPR9wrgadBGtQh+lmgk/xgqzmEjA==@nongnu.org
X-Gm-Message-State: AOJu0YwtNGjoEySSFJzpFU8QClo0SOItEfeGfO9v3jRin1sx83FcI8DV
 4USEQ/furxk9s+ZvBgAB4vkm+OAlufFTwrR1do0qszVwfcDVME4a7d3SN7w/bQ==
X-Gm-Gg: ASbGnctn2c9TOR6IJ0XO9fjedBB1pQqj9/FtCXILkfY6ed1sQNFj1E7dhb7zFwb0jHH
 LB4mxqJOW815ALu0yD2Q0kK7zBqAOfCi035SQckwqyL36lDXW1WmB4+pRF1Wfp8TEQyQU7nLpLK
 DZxhZgksH9sV8n/alpHEMud3/CBtNlHnrj63ifKAfgH9ZiCrzuKRBeV7oEEVuQe0DFVY6AluMfQ
 LhDowFVGuQPbFmlcOCOuIPqj35r9l5iByjjJ/5njLswu8/hKDErUSttWzWnTfhVAveQELmWCRau
 yrPhnNAd25JYly8+tOrReaefz5gQ/YySP+u9m5iGJzOGB3WlJUaU4TCGV0Ina5XzaxOm96FyvRq
 2pLEdo6tMiH/XK7TpbsRk1w3i/qhztmVOAftHFsBB/14EWEQ+57hd7h99
X-Google-Smtp-Source: AGHT+IGhtYIuPLK8xgeav4tk0tmYHmUIFbC9BG1XLSnM4Pp8PF3Db4vVIfASQfGR1Yf0I2TF6LVOIA==
X-Received: by 2002:a17:903:41cc:b0:22e:1791:2e5a with SMTP id
 d9443c01a7336-231d459a551mr195418735ad.35.1747627637939; 
 Sun, 18 May 2025 21:07:17 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-stable@nongnu.org
Subject: [PULL 04/56] target/riscv: pmp: move Smepmp operation conversion into
 a function
Date: Mon, 19 May 2025 14:05:01 +1000
Message-ID: <20250519040555.3797167-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Loïc Lefort <loic@rivosinc.com>

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-3-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/pmp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index d8e2949aaf..3afa16917e 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -32,6 +32,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
                           uint8_t val);
 static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
 
+/*
+ * Convert the PMP permissions to match the truth table in the Smepmp spec.
+ */
+static inline uint8_t pmp_get_smepmp_operation(uint8_t cfg)
+{
+    return ((cfg & PMP_LOCK) >> 4) | ((cfg & PMP_READ) << 2) |
+           (cfg & PMP_WRITE) | ((cfg & PMP_EXEC) >> 2);
+}
+
 /*
  * Accessor method to extract address matching type 'a field' from cfg reg
  */
@@ -356,16 +365,6 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
         const uint8_t a_field =
             pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
 
-        /*
-         * Convert the PMP permissions to match the truth table in the
-         * Smepmp spec.
-         */
-        const uint8_t smepmp_operation =
-            ((env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) >> 4) |
-            ((env->pmp_state.pmp[i].cfg_reg & PMP_READ) << 2) |
-            (env->pmp_state.pmp[i].cfg_reg & PMP_WRITE) |
-            ((env->pmp_state.pmp[i].cfg_reg & PMP_EXEC) >> 2);
-
         if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
             /*
              * If the PMP entry is not off and the address is in range,
@@ -384,6 +383,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
                 /*
                  * If mseccfg.MML Bit set, do the enhanced pmp priv check
                  */
+                const uint8_t smepmp_operation =
+                    pmp_get_smepmp_operation(env->pmp_state.pmp[i].cfg_reg);
+
                 if (mode == PRV_M) {
                     switch (smepmp_operation) {
                     case 0:
-- 
2.49.0


