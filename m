Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F0FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeTZ-0003R4-28; Fri, 04 Jul 2025 07:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeTV-0003Lv-7j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:21:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeTT-0007Oq-6H
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:21:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7481600130eso1267333b3a.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751628057; x=1752232857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaD+R83FMH0JVnQwqbAhU4SC3S3GpT+xzhhalZlRRr0=;
 b=T+fWYrxJd//nU9AUTgjGHEQjAlE3fhVTy5o28FekvLu4Mv+3y/eulcTmNH9tGmad9l
 sSB3AqBjsKEXKo0JCPpU7XF/hEUubPElvlqJi1am57zOyJlNUOd12J7YouE/eh0doIXV
 SNK8SqTAoXU4HK2anO6/cYgKL98RCOLc1UQffzcueG0L2odkOmNTeiRJOXzdwWjE8qL2
 Qp+Eeua9yipXN1SiVvF7BICgU78GX1uXGp6P5zR2GnduUXndYG3dHlmgTEu45aSNaAPs
 FrZMa4oQVNS/u6bRCUzFx8vJp9VFQwjjrKwKBzgqhdbyLCmcdgZzBWhV33iYFRnR5mTw
 zYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751628057; x=1752232857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FaD+R83FMH0JVnQwqbAhU4SC3S3GpT+xzhhalZlRRr0=;
 b=B43ocixOeoNsVd9gtsMVE0WBHSlzRxTMFZOTrSNA909IRM+pFCt5rlYdM73VwFup5h
 ctE0RgEI3wvknyxT2aWhLnYhtbVhDrgMC2G2kyqBcsyFRuUlnQ/srGmaHwS9ixkdZeSs
 GpNvDOj1NmG4IaqK5gNFt9geAg/+S6Ewz1FQ9UtVzvaZwOHBjnIEXXBmgGeAkuRFkyTY
 5a1iICPzP3tIBQQNB7qVDb7CJeVe/U74ymG2PkoHuLmv0uIvrPJARaTKucw+sAwEH+/+
 xp4Eb1jArEb9VTsIz2GgHdFbxjFAODxIByh9p1uaNtYqe52lftSprkEqciaMB5EaiWRt
 UCmA==
X-Gm-Message-State: AOJu0YydOysVWh4wo8N0BI1/ywpfaIy4Kdg7aUgcjq44WN8Jnj+uwkzs
 9JHYKtncWE8ViS82a/Ls7lLmGbHhmjrdiXvNkyUIwJJjA43zpJby36D0DzD0qg==
X-Gm-Gg: ASbGnctAECZsRT6MczjxA9GYwys7ewtu5iA0uWPoIZ1aydGb27pVBMqS9qGZm6H0i2A
 wn+O2S63vman/Oro9/kvS983+gCCGU9jsws1LLhzzrIaZTGeIUpaG2jmkxSR+fkjnuhvvZ3qnA8
 IdNvV/I1WhLkzVCY5QQkWb/KHuv8QFxRuicrUk6aPvgTmE4C8h5S1SzC+VluYPD2iq/FAB1uJD5
 NC6CYwRxKSVAnLbCPnxwrMCxFMHmfvfsgig3lHeW3dlUsQFJl6exBAo6eklsMOr3yYExResX7ua
 WURxCg9tmuNoOH5Mq+Ddv5jBHYJxDKJ5Sh4/27pNJeLaI+h1CYYGjXhd7/4TtkFV+p9jtKQHBXP
 7utlYuKIDyoRJWC7k63ksQ16mNXU/v4XCYoPZZZUier4FS3jnutJF9+f8PveVZUL+z3U=
X-Google-Smtp-Source: AGHT+IEMhOaa+rasxWQjzEUSRTe2vAFXArcPgAYBZFqynqRxrvZinRiJDUdZNApt1HJZmO5/2V32dg==
X-Received: by 2002:a17:903:19cc:b0:234:f580:9ed with SMTP id
 d9443c01a7336-23c85e18d97mr42510405ad.21.1751627553809; 
 Fri, 04 Jul 2025 04:12:33 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/40] target/riscv: Add the checking into stimecmp write
 function.
Date: Fri,  4 Jul 2025 21:11:28 +1000
Message-ID: <20250704111207.591994-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Jim Shu <jim.shu@sifive.com>

Preparation commit to let aclint timer to use stimecmp write function.
Aclint timer doesn't call sstc() predicate so we need to check inside
the stimecmp write function.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250519143518.11086-2-jim.shu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index bc0d9a0c4c..aebf0798d0 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -46,8 +46,23 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMUTimer *timer,
 {
     uint64_t diff, ns_diff, next;
     RISCVAclintMTimerState *mtimer = env->rdtime_fn_arg;
-    uint32_t timebase_freq = mtimer->timebase_freq;
-    uint64_t rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
+    uint32_t timebase_freq;
+    uint64_t rtc_r;
+
+    if (!riscv_cpu_cfg(env)->ext_sstc || !env->rdtime_fn ||
+        !env->rdtime_fn_arg || !get_field(env->menvcfg, MENVCFG_STCE)) {
+        /* S/VS Timer IRQ depends on sstc extension, rdtime_fn(), and STCE. */
+        return;
+    }
+
+    if (timer_irq == MIP_VSTIP &&
+        (!riscv_has_ext(env, RVH) || !get_field(env->henvcfg, HENVCFG_STCE))) {
+        /* VS Timer IRQ also depends on RVH and henvcfg.STCE. */
+        return;
+    }
+
+    timebase_freq = mtimer->timebase_freq;
+    rtc_r = env->rdtime_fn(env->rdtime_fn_arg) + delta;
 
     if (timecmp <= rtc_r) {
         /*
-- 
2.50.0


