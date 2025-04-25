Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FCAC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAg-0003Gd-Px; Fri, 25 Apr 2025 18:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7q-0005lg-Mi
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7n-0001P7-70
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso3103242b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618541; x=1746223341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8//ojLZJrPt4VyoPAL/J6gTwyVjXocIJX+OHfLkTJEA=;
 b=GRyqo+e3R8TH8YYu1bbCsf8U8MxKZlfEVQeTxSJevlACP6nwLczOfAcoF8aD3CvsBF
 yBVtebH5Cdp2uHrq+IReNwYNxzNXy6Uo0qR1RWk+5hfT/pEbaiSQsG7LiKTg5QoZaif0
 I32EYxBYsq7gtRN271WnEn0XwoXSS01DNQOqEi53nLfOa0t/HxDrtJu+dRjIgGOxP3xO
 tQH4uLje9Hm+59qoHo4qdIwlyGzfcd3XvXsqgkOugKl3k46Ars0U/phVbIArmlXgNMHK
 Ro68FUwJCsHpJ98C8Of9T/ielhsJbq6HLg0sIL/G0GItrah6x/n3Qa0J/wzFJiUB98G/
 chmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618541; x=1746223341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8//ojLZJrPt4VyoPAL/J6gTwyVjXocIJX+OHfLkTJEA=;
 b=ZM6oe+XySxmQlFgbUl2euNr+BjXnBVhwvwftLRYe2fi52u33/d/vSRyHIUU0fpfdSP
 TbDR/34iWLClE+PvgRmDObDRHEpxLWjltCHdZhbQ3muakBqltcAfCzbABbV6aJ9USfOf
 35yxC4dooQcWfSEdHMsz+5ExtX6CPMXtvoNJLDr8RetyxdzrXC7rrO3ABWFhHI5UDgzP
 wWQ00/QFpRroVcfq7xYHSKxYk12g7LTC/lbLaSy5G35LE7yfT4XNbH+vP9LPrdxJ8AZJ
 hAeU9EViDomCoXh1dllDEhBUZtIFT2u2tJmrOEEAkZi2Mz+UmN0AUVQKLm/GVrzHVJlm
 Noeg==
X-Gm-Message-State: AOJu0YzCMxT8/SflJa64u+K2XyBGLATWXonA3VWKqZ6bRCYvEh1QdE9l
 FYk6rx76eceU0TAjg79fpTNjeAn+/5GbeRubuI/RQkF8RAdBPmn7sIwy+BzklmFhG22GOil7IqU
 W
X-Gm-Gg: ASbGncsEjwbcwlYGCdvPnl/FM+Ca7i+RsyaBq6aChMa8JY3RYLoD+5jnPMNkhgInS4o
 4on2Mij0KvOGwESpWg1dfgEsQBbcAgW45/g57ihJjHAQ3saWyK9v2vRfLeQAds01qe0TLx01yLi
 73Kl3JqhaIcvQG0Q8JopOoGJn0Jw9SwyjVVYkLgFfp4DCZagDkCFBGsRLcTkp9aVyxg+Wc6qBUT
 BdwrDVdxeZPy239eXkktFIzS+F18TBileHDh/+OPzQ4gQl4numXSdpeJtz4LUtorwlYFI0zj+zy
 52z9srwpKJrc+aQp4upaA0onNNK4WfLJuN3Q+d0dZnE3AqFCiH5szwA5WXKfiKs/Y1ZPX6Q6GLN
 b8ew9enFfCg==
X-Google-Smtp-Source: AGHT+IGLISKj9fF5+kxEPuTsTJWcvwV/w1xeUnjSz/llUAp8Q4ADEUpufNqhPNvHEein0EzuY9Jf3A==
X-Received: by 2002:a17:90b:3dcf:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-30a013bcf66mr1566166a91.35.1745618541399; 
 Fri, 25 Apr 2025 15:02:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 115/159] tcg: Move i into each for loop in liveness_pass_1
Date: Fri, 25 Apr 2025 14:54:09 -0700
Message-ID: <20250425215454.886111-116-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use per-loop variables instead of one 'i' for the function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 037b5a4664..e2ca02eddf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3924,10 +3924,9 @@ liveness_pass_1(TCGContext *s)
     int nb_temps = s->nb_temps;
     TCGOp *op, *op_prev;
     TCGRegSet *prefs;
-    int i;
 
     prefs = tcg_malloc(sizeof(TCGRegSet) * nb_temps);
-    for (i = 0; i < nb_temps; ++i) {
+    for (int i = 0; i < nb_temps; ++i) {
         s->temps[i].state_ptr = prefs + i;
     }
 
@@ -3954,7 +3953,7 @@ liveness_pass_1(TCGContext *s)
 
                 /* pure functions can be removed if their result is unused */
                 if (call_flags & TCG_CALL_NO_SIDE_EFFECTS) {
-                    for (i = 0; i < nb_oargs; i++) {
+                    for (int i = 0; i < nb_oargs; i++) {
                         ts = arg_temp(op->args[i]);
                         if (ts->state != TS_DEAD) {
                             goto do_not_remove_call;
@@ -3965,7 +3964,7 @@ liveness_pass_1(TCGContext *s)
             do_not_remove_call:
 
                 /* Output args are dead.  */
-                for (i = 0; i < nb_oargs; i++) {
+                for (int i = 0; i < nb_oargs; i++) {
                     ts = arg_temp(op->args[i]);
                     if (ts->state & TS_DEAD) {
                         arg_life |= DEAD_ARG << i;
@@ -3988,7 +3987,7 @@ liveness_pass_1(TCGContext *s)
                 }
 
                 /* Record arguments that die in this helper.  */
-                for (i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
+                for (int i = nb_oargs; i < nb_iargs + nb_oargs; i++) {
                     ts = arg_temp(op->args[i]);
                     if (ts->state & TS_DEAD) {
                         arg_life |= DEAD_ARG << i;
@@ -4008,7 +4007,7 @@ liveness_pass_1(TCGContext *s)
                  * order so that if a temp is used more than once, the stack
                  * reset to max happens before the register reset to 0.
                  */
-                for (i = nb_iargs - 1; i >= 0; i--) {
+                for (int i = nb_iargs - 1; i >= 0; i--) {
                     const TCGCallArgumentLoc *loc = &info->in[i];
                     ts = arg_temp(op->args[nb_oargs + i]);
 
@@ -4036,7 +4035,7 @@ liveness_pass_1(TCGContext *s)
                  * If a temp is used once, this produces a single set bit;
                  * if a temp is used multiple times, this produces a set.
                  */
-                for (i = 0; i < nb_iargs; i++) {
+                for (int i = 0; i < nb_iargs; i++) {
                     const TCGCallArgumentLoc *loc = &info->in[i];
                     ts = arg_temp(op->args[nb_oargs + i]);
 
@@ -4135,7 +4134,7 @@ liveness_pass_1(TCGContext *s)
                its outputs are dead. We assume that nb_oargs == 0
                implies side effects */
             if (!(def->flags & TCG_OPF_SIDE_EFFECTS) && nb_oargs != 0) {
-                for (i = 0; i < nb_oargs; i++) {
+                for (int i = 0; i < nb_oargs; i++) {
                     if (arg_temp(op->args[i])->state != TS_DEAD) {
                         goto do_not_remove;
                     }
@@ -4149,7 +4148,7 @@ liveness_pass_1(TCGContext *s)
             break;
 
         do_not_remove:
-            for (i = 0; i < nb_oargs; i++) {
+            for (int i = 0; i < nb_oargs; i++) {
                 ts = arg_temp(op->args[i]);
 
                 /* Remember the preference of the uses that followed.  */
@@ -4183,7 +4182,7 @@ liveness_pass_1(TCGContext *s)
             }
 
             /* Record arguments that die in this opcode.  */
-            for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
+            for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
                 ts = arg_temp(op->args[i]);
                 if (ts->state & TS_DEAD) {
                     arg_life |= DEAD_ARG << i;
@@ -4191,7 +4190,7 @@ liveness_pass_1(TCGContext *s)
             }
 
             /* Input arguments are live for preceding opcodes.  */
-            for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
+            for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
                 ts = arg_temp(op->args[i]);
                 if (ts->state & TS_DEAD) {
                     /* For operands that were dead, initially allow
@@ -4215,7 +4214,7 @@ liveness_pass_1(TCGContext *s)
 
             default:
                 args_ct = opcode_args_ct(op);
-                for (i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
+                for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
                     const TCGArgConstraint *ct = &args_ct[i];
                     TCGRegSet set, *pset;
 
-- 
2.43.0


