Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6BDC55165
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpaka-0001mP-II; Thu, 30 Jul 2026 20:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakU-0001ek-Pp
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakR-0001Ku-8g
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84e507b079dso341510b3a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456307; x=1786061107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qRjKxR75IWjdo0us7kDQs5ebV8BgOMjNrEQhKv4w6gQ=;
 b=QfwGu2gitGdZgkZIF7yQFhVOOsFkPJcuyEywk0vkNkHz5mLbLaxZfmqdA0x/N2aIH8
 azAFcjbDuQHGaXWUXvVw7XsNPakFbcZVOxI+y6tGTbyiWon+GEkX+hpMIG5EnGxTA/Bh
 S5qjP/retD3ICTozhrryqbs1xC7K7V8O2HAmPVWjIrIitVYqRNzjkBd1os+nlQ+x9B0A
 M9DOT7FIhSj5jZiPKxDJdklBASQvoeAaOfB9a3UkhSx42kc5WepWwDYK0KxDeVvuGFqk
 ji+gbPSReAeoWp45np+SOERxIi5SuCGBz0Egyu/Ea3moCwNWjqxdICEA22mBkpGKs8rV
 63/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456307; x=1786061107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qRjKxR75IWjdo0us7kDQs5ebV8BgOMjNrEQhKv4w6gQ=;
 b=hF75UV0CI/GMusYvr8hDHTiH8N1VG6ZxXHWta2yDxRxpceDFrf00BJEZqxCQBwv1n1
 VCIn9mZvChb3UU/h1+Ivs2o2Em8ed4mD1+Lx+bR+HbNmLv4+OA8m++PcW14qGsOO8tBT
 BDd5wVOqIUIblQSHSZ0ZZGriASz+fP+XrpMH7ME6njE1l5ORSoGEshSecLGRH46toeA2
 mjzEJvsAZ3KvPeOpV9Rs7JVAuOrs1HNTkLwIqviWPzbQXcSrAWolHbuO62P2qohslR/t
 K5M3Wsfm3grh2XbaE+W/mhLr6iUn+aIoIoHYfqhVkjUq1GsF0ZsQ4zZyPTVCDzu2MYWC
 hy9A==
X-Gm-Message-State: AOJu0YzWwDQh5zy8xgvVsVLcLCVuzgT20b9i+PPfJg1EsiG2PhPMOduG
 Y/6H42OgKTrb1W7I/X3gjGb50+Bnn4eknRNZMubIPTewigyTChKcXhznGY0OYMV22k99/qSo2sm
 wIfoZ
X-Gm-Gg: AR+sD136FcO3zbYsCvpa5NRMCVucfwFrwQZJk0Jw0YI+sUzj7bUPptAxx2/MCV2DXLk
 vw/NRUaqnKIoYq/wvSliAwtDJx+YTxJ8HV5njlbE97imfoRXZkpCpI6E3qR5QkPdnhhQAF840q4
 vktexlPKAutSnqDppW4+wQcAgpmgzq0janYfLckID6XTh3vm/r9MIJ9Q0+piDrvMXlAkbh9I/YS
 Houq9AUWymkeoe84fhDgRP/ZEZ+0ac4xYnXJh1g4OhAJ0SBs9pk4xD43xdc3G9NKsYpqKlxe4FU
 EuDo5wpEhDtTKiZEoTNsuQ1qr9J4vAS2O0oi9j+w4NK9xJwGrf3wdLtBw8PfgHnxn0xJ29W+v7+
 MmR+ja74Vqn3zZ3mZdW1JbufHv2dDK1deWZfDzNXzO24phTdtHiH282eOkr7PV7u/GU0YPrv6om
 RgjygWct6/qKoi9LLBAWnmFF+3vqu1R2lVj5sfI3UCzHw5KcBG0DQWvEfkHp8mh0k4EXBIRG90A
 M41UhxYQMrOBpNvz1w1
X-Received: by 2002:a05:6a20:1f28:b0:3c3:7f8f:88c9 with SMTP id
 adf61e73a8af0-3c9008acd7cmr4246569637.54.1785456307314; 
 Thu, 30 Jul 2026 17:05:07 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 03/11] target/arm: Use generic tcg_gen_revbit*
Date: Thu, 30 Jul 2026 17:04:55 -0700
Message-ID: <20260731000503.170446-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 1 -
 target/arm/tcg/helper-defs.h     | 1 -
 target/arm/tcg/helper-a64.c      | 5 -----
 target/arm/tcg/op_helper.c       | 5 -----
 target/arm/tcg/translate-a64.c   | 4 ++--
 target/arm/tcg/translate.c       | 2 +-
 6 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 0e56e00f45..12f58c6a44 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -18,7 +18,6 @@
  */
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_2(msr_i_spsel, void, env, i32)
 DEF_HELPER_2(msr_i_daifset, void, env, i32)
 DEF_HELPER_2(msr_i_daifclear, void, env, i32)
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 0077aeb4e2..42376af2c6 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -10,7 +10,6 @@ DEF_HELPER_3(add_usaturate, i32, env, i32, i32)
 DEF_HELPER_3(sub_usaturate, i32, env, i32, i32)
 DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_RWG, s32, env, s32, s32)
 DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_RWG, i32, env, i32, i32)
-DEF_HELPER_FLAGS_1(rbit, TCG_CALL_NO_RWG_SE, i32, i32)
 
 #define PAS_OP(pfx)  \
     DEF_HELPER_3(pfx ## add8, i32, i32, i32, ptr) \
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 05ab9ab6d3..9d805231a0 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -69,11 +69,6 @@ int64_t HELPER(sdiv64)(int64_t num, int64_t den)
     return num / den;
 }
 
-uint64_t HELPER(rbit64)(uint64_t x)
-{
-    return revbit64(x);
-}
-
 void HELPER(msr_i_spsel)(CPUARMState *env, uint32_t imm)
 {
     update_spsel(env, imm);
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c4433be2ed..857e897a48 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -172,11 +172,6 @@ uint32_t HELPER(udiv)(CPUARMState *env, uint32_t num, uint32_t den)
     return num / den;
 }
 
-uint32_t HELPER(rbit)(uint32_t x)
-{
-    return revbit32(x);
-}
-
 uint32_t HELPER(add_setq)(CPUARMState *env, uint32_t a, uint32_t b)
 {
     uint32_t res = a + b;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1780490065..4f9a93950b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8963,7 +8963,7 @@ static void gen_wrap2_i32(TCGv_i64 d, TCGv_i64 n, NeonGenOneOpFn fn)
 
 static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    gen_wrap2_i32(tcg_rd, tcg_rn, gen_helper_rbit);
+    tcg_gen_revbit32_i64(tcg_rd, tcg_rn, TCG_BSWAP_OZ);
 }
 
 static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
@@ -8998,7 +8998,7 @@ static void gen_rev32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
     tcg_gen_rotri_i64(tcg_rd, tcg_rd, 32);
 }
 
-TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? gen_helper_rbit64 : gen_rbit32)
+TRANS(RBIT, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_revbit64_i64 : gen_rbit32)
 TRANS(REV16, gen_rr, a->rd, a->rn, a->sf ? gen_rev16_64 : gen_rev16_32)
 TRANS(REV32, gen_rr, a->rd, a->rn, a->sf ? gen_rev32 : gen_rev_32)
 TRANS(REV64, gen_rr, a->rd, a->rn, tcg_gen_bswap64_i64)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index a1fc050618..1ee8ac9ffe 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4811,7 +4811,7 @@ static bool trans_RBIT(DisasContext *s, arg_rr *a)
     if (!ENABLE_ARCH_6T2) {
         return false;
     }
-    return op_rr(s, a, gen_helper_rbit);
+    return op_rr(s, a, tcg_gen_revbit32_i32);
 }
 
 /*
-- 
2.43.0


