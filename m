Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D88AEC113C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyy-0006d2-Hc; Mon, 23 Feb 2026 15:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyu-0006aW-1e
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:40 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucys-00081J-D1
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:39 -0500
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-463a0e14b4cso1723205b6e.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880197; x=1772484997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFsLZqSPw6S0O+pghMfu9lM9hMoZ8EcgNpx7lqQrLaM=;
 b=PGhtW++Gak0Xz5oktDojknresuhhlSCFIOe+IdhcSqSXhiTIU05HtV2TABWHCbyJu/
 GP3RA64TzcWJV2v0y9HKnWOHgBDEC5AlL98RMCmdvgvY8vDNUESCrv4V9s9h2mmLxlo4
 k43nmXL4s7CYWLCp75PDEQK8Z827GIZ2UWxPB3PaFLDPhyduq5be2R1M2G8VdafLt/1y
 M3fNfS+dO79qj21eJgRBTUOAt2LcLJsE1MY24jSvKFBiWw0xXPEHQWC3RPWYpqubxjNN
 0SmTx1wyPsfm+PtUMJe5qmd9EL8bygjnYOmh0SwI8TiR0nlbV64oZi7oL4kCDumHX3Fo
 AuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880197; x=1772484997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QFsLZqSPw6S0O+pghMfu9lM9hMoZ8EcgNpx7lqQrLaM=;
 b=os/pZZGkKuAv9ZdDcAnKyNHc+0njbn3zH2toQpa9hstXrZamWLBADDo8iiV9Gi0gQc
 H27tdpr7273DnlaEl6G9rfHdatQ0pusq9Aqz/iZc48SXNCI5EpyUW888JNEPES2wyTzj
 aNooqGfi6Cw/YRW1YgL9cTudkKo3LvBwqH/+EiUMj3o8ZrHy+V4ocKZAy6ccybeXHDUK
 S/6SkqHje/ozGlzX04hLVhC+wJto9Iw4793wXFoz8Ca/GqjoEqoQzi7Nv3lCamzQX6qS
 AnllYtsngiMt9Vb5VqdYzRjYpp4pew8KmzX0hKjqJxmNqE9bTkNdkxDgKyK2WkYuHcvO
 8zLw==
X-Gm-Message-State: AOJu0YxjK/DZJvF3gH1MxxNx1EvTLIBPnBOhjC/ixXY+MPejy3m328ZD
 JOdNy90YMVYLTUg1db7+68uxefwvhofJbdc83Eq26sVBW5oxf1x83qOaVPPfI0jk
X-Gm-Gg: AZuq6aKO0+7S9IjKLeWxo8vvEXodtvTgeJufBpTx0tQPkfVuTdej5xvz5P4TH1SQoKz
 K4odWXG+dhUfdNC7H38pB0vahXDDeKU93joYd6/AxL1pOvpCfIs7tnJUBRU49exWVEF3XQPIHaL
 WMtBx841O4NODB3LgMzhFV1muzHXY6PFe0l3B1/NllcVbs6ZVwmAWoivPrIvKPzUMH3ioEkTDAg
 m0Fb3omWJFhmhjF3ocHeImknJ9mBZkPvb50PP16jv+rTWnWRCAo0MGygyGFYaInN2IvHeYShvf0
 zuorsbB+Z7/HYojbgoZgzog91lLrk5lEELCznHpSItaRQGWvX1AbedHagN/9U5Eux5NvwZ24z5A
 GhYOtt+ohYorJXPVwTeTi1+ftLi9lP4ChBqBXFv93VdQVL0nA+z9v/b9sCENbYP1SlC0QfdVDOP
 WSy2iCJJia+kQvSnyNPZEDKnxNTLgQB/dLa/iowSLw6p5i6lPRitXZwTXOaD+mTTJnaUcp7gGvW
 D8zA6JII2a3yCbmh/mIfeKPxSMMYshQLWqXfA==
X-Received: by 2002:a05:6808:c1b2:b0:45f:2042:8fbe with SMTP id
 5614622812f47-4644616c0e6mr6467222b6e.13.1771880195993; 
 Mon, 23 Feb 2026 12:56:35 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:35 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 2/8] Hexagon (target/hexagon) Check for GPR multiwrite in
 analyze_packet
Date: Mon, 23 Feb 2026 13:56:26 -0700
Message-ID: <20260223205632.223714-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x242.google.com
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

For now, assert the new method is a subset of the old method
We'll remove the old method in a subsequent patch

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h |  6 ++++++
 target/hexagon/translate.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index b37cb49238..54276fb9d0 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -39,6 +39,8 @@ typedef struct DisasContext {
     int reg_log_idx;
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
+    DECLARE_BITMAP(gpr_multi_write, TOTAL_PER_THREAD_REGS);
+    DECLARE_BITMAP(gpr_uncond, TOTAL_PER_THREAD_REGS);
     bool implicit_usr_write;
     int preg_log[PRED_WRITES_MAX];
     int preg_log_idx;
@@ -113,9 +115,13 @@ static inline void ctx_log_reg_write(DisasContext *ctx, int rnum,
             ctx->reg_log[ctx->reg_log_idx] = rnum;
             ctx->reg_log_idx++;
             set_bit(rnum, ctx->regs_written);
+        } else {
+            set_bit(rnum, ctx->gpr_multi_write);
         }
         if (is_predicated) {
             set_bit(rnum, ctx->predicated_regs);
+        } else {
+            set_bit(rnum, ctx->gpr_uncond);
         }
     }
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 6e32805202..c5d161745e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -417,6 +417,8 @@ static void clear_pkt_ctx(DisasContext *ctx)
     ctx->reg_log_idx = 0;
     bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
     bitmap_zero(ctx->predicated_regs, TOTAL_PER_THREAD_REGS);
+    bitmap_zero(ctx->gpr_multi_write, TOTAL_PER_THREAD_REGS);
+    bitmap_zero(ctx->gpr_uncond, TOTAL_PER_THREAD_REGS);
     ctx->preg_log_idx = 0;
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
     ctx->future_vregs_idx = 0;
@@ -443,6 +445,19 @@ static void clear_pkt_ctx(DisasContext *ctx)
     }
 }
 
+static bool pkt_has_write_conflict(DisasContext *ctx)
+{
+    DECLARE_BITMAP(gpr_conflict, TOTAL_PER_THREAD_REGS);
+
+    bitmap_and(gpr_conflict, ctx->gpr_multi_write, ctx->gpr_uncond,
+               TOTAL_PER_THREAD_REGS);
+    if (!bitmap_empty(gpr_conflict, TOTAL_PER_THREAD_REGS)) {
+        return true;
+    }
+
+    return false;
+}
+
 static void analyze_packet(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
@@ -965,7 +980,12 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         clear_pkt_ctx(ctx);
         analyze_packet(ctx);
 
-        if (pkt.pkt_has_write_conflict) {
+        /*
+         * Check that the new method is a superset of the old methond
+         * Remove in a later patch
+         */
+        g_assert(!pkt.pkt_has_write_conflict || pkt_has_write_conflict(ctx));
+        if (pkt_has_write_conflict(ctx)) {
             gen_exception_decode_fail(ctx, words_read,
                                       HEX_CAUSE_REG_WRITE_CONFLICT);
             return;
-- 
2.43.0


