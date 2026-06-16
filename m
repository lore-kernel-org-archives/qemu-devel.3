Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D30ACD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhY-0001QV-Ba; Tue, 16 Jun 2026 06:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhV-0001AL-R9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:21 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhU-0003SV-5O
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:21 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c85a2ca7bf7so1608285a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604439; x=1782209239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtqmoh4dg8khN5cnWu/i5fmQVO199sh9k7HIZoSec9Y=;
 b=UjqE5BY2bqLF0eKU/78Bz3wxLdDyNVLBWthxcaLRfMRFkvP1TIJWgDXigf4t1IwWfp
 rR/AUwHFbULpKBG9CgftrdOI2NDMvT/0h+BLXRegn5SLQxc+gim7aWpLQSrIwQRzSCPc
 OnsWNa/dr+q7ERiYECvbKutnhFd7KHJgcyeNl3pu9ew4KLLzlXleU4Jv4UyJbG3qgQwZ
 bIM5TgA74WjR8JiWBmd+LoHhBJodZKViNY9NM6XhjgI0NLJ41rknhuFwcFdG1yxY1998
 /0EdxJHJoBFuWckP1d+PsbpGWtGL1NLttPeA+yxxILi9aCSpyEVcvGak3zmKVcR9r5e0
 jbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604439; x=1782209239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vtqmoh4dg8khN5cnWu/i5fmQVO199sh9k7HIZoSec9Y=;
 b=Y2xxhv6mM99wVa6G+dIaoyRs2jBA5cFzXzJdHUuaGaefnupPa64jYpAPF0c+PRctir
 mvqvYWUn4Ww4zvztpu6St0cQI8Uahsm58nvZYU+GBfDWezU8s3cHRrLSqeAbXZWZiKDq
 jmqy4m6nlpQAP1/UQEX0QLG/RC04UyD/h9CwS22ehPYMKCHgwfH9gAPUGeX8cWb9aJu3
 BhgbAMagkPEvoZkurK2sR0dMEvBFMTzNscqlepOOuAJ695eD69b9m/Z3Vq4chqe3Ywv3
 ZBLX7iQqDowhdWVk1ZNMw8TrsIkWf6WbHyS0oZy6IJ6jybydH8/M+tQGE51tG91nKSI5
 0sOQ==
X-Gm-Message-State: AOJu0YyBtrhn0HGfFXmivkqOOooz8CQYmLC8bG0hZn9qGK5eAhQtkSe3
 R01626jRbVachjt9Qhke+jQ758Odkf4oSdwy/OEKAWvBPchhlRJiL3RS40Ehw1Iq
X-Gm-Gg: Acq92OGFt7TFTgcoL5mJ63IM7kBtNQEYvThuMXOr+taQwEt44b0AAtxPe+uuvGWKdgQ
 qXlY8p3UJlM2udYyt7yerYY0PCe+gHc6MPHDkEAipfbAyQFJnq+0+hwNWwquvUaheSDPINtl35t
 tlGIErpbi8oi4sMxTebNRboHVmujEY0WBTbvloWbVcakhgtsFgsmzEXgpUptEtA+rW6R2IwKnq9
 koKOc8S1s1XdnD9NxTFkL0Jplx7ZCFwZgYhNO9UFMuTZwwQiqbWnX+ursufhF/NIviVnL7Wr5f2
 OuAsOjSp9C+YfdPct5SUaF72Hj70TvumllecqEcnsedPhWtueT6eJP8mOqr5A+sxXy1orwX0VgF
 w0d1It2SU6ucg3xqGAUWWw+hCjtv/XDTvslt7ltiycCc/3nEQI43H3I5SkQWeZFk0RV/ZSYTYwT
 rTfI0wf5U1XM27rho9czS+VqCD5L9bTSaqOc6m9z2n
X-Received: by 2002:a05:6300:4049:b0:3b4:7236:1b5 with SMTP id
 adf61e73a8af0-3b783f66890mr20953213637.26.1781604438786; 
 Tue, 16 Jun 2026 03:07:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/83] target/riscv: Replace target_ulong in
 riscv_ctr_add_entry()
Date: Tue, 16 Jun 2026 20:04:33 +1000
Message-ID: <20260616100527.1939565-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Anton Johansson <anjo@rev.ng>

Widen to 64 bits in size to hold all relevant values.  Note: src and dst
arguments change from signed to unsigned but no functional change is
incurred.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-20-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 5 +++--
 target/riscv/cpu_helper.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a92cb249fa..48d5c769f1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -664,8 +664,9 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
                         bool virt_en);
 
-void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, privilege_mode_t prev_priv, bool prev_virt);
+void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
+                         enum CTRType type, privilege_mode_t prev_priv,
+                         bool prev_virt);
 void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ae0490a086..57e6f8217c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -977,8 +977,9 @@ static bool riscv_ctr_check_xte(CPURISCVState *env,
  *    entry = isel - CTR_ENTRIES_FIRST;
  *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
  */
-void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
-    enum CTRType type, privilege_mode_t src_priv, bool src_virt)
+void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
+                         enum CTRType type, privilege_mode_t src_priv,
+                         bool src_virt)
 {
     bool tgt_virt = env->virt_enabled;
     uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);
-- 
2.54.0


