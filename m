Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F74BC369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mHT-0003Wa-JO; Tue, 15 Apr 2025 15:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m8S-0003E4-Bg
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:39:59 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m7J-0005bk-CR
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:39:55 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2d0d25cebfeso3401893fac.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745906; x=1745350706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q+Mbw1kWUVx++6+SPoi3ERW5wJQBg1pHm1f8I9Gr2Vg=;
 b=qk4JgC25jWckZD9FddpF11TKmvfndJc/lPdiFcyYCQCmoF/tx5s2rrIvUHkdkXDC49
 lTRti0m7HClcfjl7wGVckP/SzYopRkF4ioyNS2MLIKmIcLgoD1NcMUS6StDCSJMQA+PD
 NA2aFzIGXz0vzFPBe886vrmoFu/bInsw9yK3qf9kjJB+ALGW1gRxTw9o9T7T0eRY77/4
 CacSX/3ng6Kr8xehVdKyOJqLxdsZZ/N+QotngmJuQOXJfTrTH7a97KdsiDziIfJGzi/g
 2xpCiQoE88y6Vxadd9JxituKCQbZD29gTbD2m+3hM5QbKbjqUEcnCYjGQw9xWSAKu7Dq
 HZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745906; x=1745350706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+Mbw1kWUVx++6+SPoi3ERW5wJQBg1pHm1f8I9Gr2Vg=;
 b=Tp+B0SsW/UjgcpHV5IhAX7aIZryYTil0uA0RUqRVgdDrhKR7unhpRooQcvPu5HUY1r
 szt4orwPpG+5pgxlU3dj2pkRfH3dsfRum6NvzYdQ9JvTApD/qNHHhn//xf0cQrok5qJn
 EOqatI9b47reM+orOrbgBHYU2G99ruj2OHXsht5L3f9y486pDtXGSpEb/R8unsMX2BCz
 4yOCsw4iqmW8QJ7VwibmHAbvqm6p/cknbT1lFDGh5jk8GqA3OovNkhDcFVwQL1KzsBUb
 VC4GqcrZa8zw7yGwAoZ0xOBUvNW5OpTM/YI5WlXzmDgEpFxZmEUfV1cFeaF257TZH1Wq
 mydw==
X-Gm-Message-State: AOJu0YzzN3CYReGQ5CMRqXdVK65f3dS4+HNP0+RY/SxPIdbdk0U2y6ht
 ubQxuk8k9RURncjLMhGD9RlNwNvKk/WMjbMPLq9dBW/Wbr4qn7j1OVgIg68mMNANq7a40GIz+YE
 V
X-Gm-Gg: ASbGncsFd0G04aDcPeG+iNO54PBm6mQl1VFFcTIslhEY8icOHt/+glinb3MRL0Q+Asg
 xXBBPUcgyxYx5VS48K6Ox8j3MI7vANOMOrsgvCpXpDByr6dFDFClI3KbLEJJr0jS/n4GQatvcF1
 7Ym2d6UG1fbYi4SKypIpjOEONhiYegXXK02PPqiFk9oZ6+IZ6u6Wz/fL/owIW4u2DRdh1UzF5L5
 Z/feF/Ui5M5QGMAMn6DKnOomMkU0C1PmDoQG7BrZbaFa5J3Kw6ZwwRxUKG6skhyBbj9Khs6r5qi
 SpHlXj33iV7ugacbTHFNmQNgEcyGoR7gzG2aOU4l+mvldxQ/xvAWx6aVuwofKyYAok6eZIW/hDw
 =
X-Google-Smtp-Source: AGHT+IEyUXRR0WroZl4iXKunjUv1lqY0x6nejrSAytpHYT2slHMM1tuhXvMPHOdRNvQ2K6Doe5fwsg==
X-Received: by 2002:a17:903:3202:b0:227:ac2a:1dd6 with SMTP id
 d9443c01a7336-22c319e8a90mr6926255ad.24.1744745569839; 
 Tue, 15 Apr 2025 12:32:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 111/163] tcg: Move i into each for loop in liveness_pass_1
Date: Tue, 15 Apr 2025 12:24:22 -0700
Message-ID: <20250415192515.232910-112-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index ed03840988..9da6c8bb4d 100644
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


