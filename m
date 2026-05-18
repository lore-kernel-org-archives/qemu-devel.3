Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABAFCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOs57-0001s6-SL; Mon, 18 May 2026 03:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOs4j-0001mT-V2
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:07:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOs4h-0007yk-Iy
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:07:40 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so744662b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779088058; x=1779692858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFk3zZ0Sulho5f31ptCo3ZSeZ4XkYMde8NYYf5Qulcg=;
 b=TRUBJ5dT7t5bj9vQqgQmESR6CD++HM9lJyiIBfSVrh/v2TS201mqr1wdv796d7j8Ez
 8C1wGh8sm+n2PjYAiQQzB7XiWFMynM77xH2JNmydfIfJr4PH9EgdwwgmSwMgSqdn+HdU
 sZmJpekrsLntHX+zk/5MGAHwYhMds7x7QFpXn6GE7wp8Yu9s/xlTcgyuMAmBS9IRhBHV
 zVWBd32Loofhnt5hM4VQR0EJGin/CQngcaqsSk50RTP2WW3MC7KShL3FBrBkqiBykhS+
 5erqBXwf4Efyu9GI7u4mQKJiTxnmm66E0EuCf3rkXnnKuKLio1qv0Ad5QqgSO7klpObZ
 4bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088058; x=1779692858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFk3zZ0Sulho5f31ptCo3ZSeZ4XkYMde8NYYf5Qulcg=;
 b=Q/jk4OApMZf1oQJvWsniMsMYGT+l2yw+0ihTjRW1CUo8k8lryTz4TMvifj5+ncdtzA
 U+24h1ExcuggFGsEZRI4PqsBwJi6RnOpXlpyHg1PAuM1xrGKyjkLpqOvh5kUH5a4jjdg
 vNPwjHaKR1xxlvapK/nmh8GWA37mxTLbNRmLPjk8Et3PRrzKuBXlKkh7U42RHpdEPJa1
 p3EhhhSS5ce68loq+wz2N0M6UtWcXkyzDt/2AmpqGClZSqWdrRDB5NHb+31l591DbRKD
 cnMwBuAzyZRmcwpl5d7VmhxBDDrLPJYcMoGj/KI/zMEE1AoqyfEuVoPJ3z/sx3sKThi7
 qSYQ==
X-Gm-Message-State: AOJu0YzMVBCcwM6tb+AH7koLaqtFFUVWGbbTuWsGrGrXewfa9FhyvI70
 pkjGGqWRwVbPXKf3Sz7jrKCnVXB8RU5iier1V3+b3J5ikY8ObU7e2i8DgcJWrolSc9moFvH5ura
 ozXMY/PGsoEzr/oc4gTtet40vQivK1JtjM/AMeU+7O+JQ5H2SJcvX4KggyNpqKPm4GAHLvsTZIg
 UoifZLI4LkQ5hhsDTWriqkUrikkk0EsMb8QsdXSYy1yz8=
X-Gm-Gg: Acq92OG8OKJMlnzvb9KsCn91L/b6aRDuqnJsfvwzXYAIhQ4bOiF3Rh6JHXaJ9oYjbyf
 ITs1zd/cbdLrEt94QUKC6aMZgYMo+rlqUhfL/ZnPxeRnK5oeZtz6HHA5m4NLLlz+qlQ6kshMhnI
 mHkvXoA9+n+/YbHAow5Ydwxmn8I60WWvPrmX9WIiSvDZnJLk0NNwy2Y2UIYsGTQEl2mIJwi3jmr
 bPiQvHcm7yqWSrNKUKyPKF3+QmaCrz4KCmy7DrRwLzIO0pnE5NU5CPVRAFGii/sSrOVsYQrtS8o
 q30rjNKkeOanl7rRvreHCTHZ2iZ4wnpL8MKzEyX5Wb2uGQaPL6CLFUAD3dXijtfmyhm3ruv0j1K
 nmq+RFZC/wNZdx3/vIY16Cq/SQgF18CHdPWleerkcDrIffIR75NcQ3lFrZt5LXrITthv8RTWfvO
 GCSevZVhIpOkcOPDCrGLuMPwDhgfgS4w6k9idyZDycyzOvp2yymkkrFQjrYhOU8Znwrtxy/XPa
X-Received: by 2002:a05:6a00:439b:b0:82f:2070:2683 with SMTP id
 d2e1a72fcca58-83f33c76531mr14111182b3a.21.1779088057706; 
 Mon, 18 May 2026 00:07:37 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5ceb3sm13411671b3a.34.2026.05.18.00.07.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 00:07:37 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v4 2/2] target/riscv: Use macros for PMP address alignment
Date: Mon, 18 May 2026 15:07:25 +0800
Message-ID: <20260518070725.9816-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518070725.9816-1-jay.chang@sifive.com>
References: <20260518070725.9816-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace manual bit manipulation with alignment macros for better
readability:

- TOR: Use ROUND_DOWN() to clear lower bits
- NAPOT: Use ROUND_UP() to set lower bits

The behavior remains unchanged.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/pmp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index de2157c830..238c7c5162 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     case PMP_AMATCH_TOR:
         /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
         if (g >= 1) {
-            prev_addr &= ~((1ULL << g) - 1ULL);
-            this_addr &= ~((1ULL << g) - 1ULL);
+            target_ulong granule = 1ULL << g;
+            prev_addr = ROUND_DOWN(prev_addr, granule);
+            this_addr = ROUND_DOWN(this_addr, granule);
         }
         if (prev_addr >= this_addr) {
             sa = ea = 0u;
@@ -266,7 +267,8 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     case PMP_AMATCH_NAPOT:
         /* Bits [g-2:0] need to be all one to align pmp granularity */
         if (g >= 2) {
-            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);
+            target_ulong granule = 1ULL << (g - 1);
+            this_addr = ROUND_UP(this_addr + 1ULL, granule) - 1ULL;
         }
 
         pmp_decode_napot(this_addr, &sa, &ea);
@@ -641,13 +643,15 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
         case PMP_AMATCH_TOR:
             /* Bit [g-1:0] read all zero */
             if (g >= 1 && g < TARGET_LONG_BITS) {
-                val &= ~((1ULL << g) - 1ULL);
+                target_ulong granule = 1ULL << g;
+                val = ROUND_DOWN(val, granule);
             }
             break;
         case PMP_AMATCH_NAPOT:
             /* Bit [g-2:0] read all one */
             if (g >= 2 && g < TARGET_LONG_BITS) {
-                val |= ((1ULL << (g - 1)) - 1ULL);
+                target_ulong granule = 1ULL << (g - 1);
+                val = ROUND_UP(val + 1ULL, granule) - 1ULL;
             }
             break;
         default:
-- 
2.48.1


