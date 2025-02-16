Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB645C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuI-000483-94; Sun, 16 Feb 2025 18:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntP-0002xG-Dt
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:43 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntL-00064f-C2
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:42 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-221057b6ac4so19389325ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747857; x=1740352657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3X8zpaBPG0U32VcwjOMGk4yoM6w3WNPdiH/kcAZjDZA=;
 b=A7PC3xxhaeolDUtE1GY7oMVc/9JXuVVIQvkQYyJAFRdg8JsiYlHY0ExdrAUOibByB4
 scmxJCORLmQawTK9cAVZmtyR4p1TkmdCCdzRjcCCLxiZMdcb6VcXIWvY+7yjpzY2Ga82
 +JZ5wfnSlay0UpzAfZKwdJ2fU5MKukPnwnVlyW/T080U8fb3+8Pk1wCKc1jmC86CBmQ7
 HznZVeGx7Fi4k+YTaNBx0LKrm0XkPtlxBTcGPohSUdTBmCRqt+dXfMimKvAjHHrDw9jZ
 S4kmw49wztxDc41DBtDRD+i3uV4DSW0Wvba5m4Ed2UvNWW0+9mGYI3iDW+fkqus3Weis
 p6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747857; x=1740352657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3X8zpaBPG0U32VcwjOMGk4yoM6w3WNPdiH/kcAZjDZA=;
 b=hGOZe/wFC0ZrIRmOAUREV7ADz8o8QsM5l8Vz9cgtK2dmqrJ2KuPDd7PRVNOEQ2UKNs
 8pyO8abEOSaq3qG0bLT+mfF9KY+H7Ylsyvbr8UoVj/yqGOcAJ87heabvEHRsKBr6wN93
 RtQAhbKzl7FIaCxex71qnm5xnCBS76ghLTk8K6xqNvsuXiOgDW4EhyoEEbu6ApwD5rms
 B4ni7JQuX+r4R4gHJzBwb297dCHMaaXHBtb/KHMhfGHCT8gsREswPT3bVXViTCApX4X9
 yFBRz/w+Mx4e+FLYx2FxY8xs+BFS9y7p1Axpu86EgxR4v4g7fFPqmYObUnHc9qanmEJI
 +iRQ==
X-Gm-Message-State: AOJu0YzCkEZdSQxCC+sgiudihQp1P2UYlYoRDk/LRrbiHha8OcH7SIZz
 YFt2bKLF/y5C1tdPguutC2vuCaAS6Bm06pZ6QmQ1+LLnlzOg3SCEgBBWCInNKppukBoMgB2BG+O
 1
X-Gm-Gg: ASbGncv1X/1ynkqavfBaPKQ0hS2JwKK88R9zGUQ1FPBN5RVBd/jofnevxAtVoCPDPX9
 cnscbSRwtMfl19V/Mt0BjNvhFLj3qDTshAMRZvaF2nd8jKL4q/4pRqGhyWDHss+3Sb7igM5nz4h
 FvCnRbsTf7ZNsG72lVva29o5ZsB13aSaLEFrC+rVmmfzvRgHWSQlWxW9sZUhxaPBHC4iGTNL5ho
 OMnLUYKpmYRxYqq4zPbIQ0+gqDSrXcXfNZ8D5LVELJFsXBolLVuGfZ7BhhgWvJiN2suwvSPQn3J
 6dcIPqh88/FGcgSqEiZFtA3iAv9hD4/HI3iKdkupI8yUJeA=
X-Google-Smtp-Source: AGHT+IHZ8QA+X9do+KWTfUbGWGS7PnAaXOY3lDXMswysRkB7bAIORXKH4C25kUfATPYUd1MVjVjFHQ==
X-Received: by 2002:a17:902:e847:b0:220:c066:94eb with SMTP id
 d9443c01a7336-22104061288mr123479075ad.25.1739747856873; 
 Sun, 16 Feb 2025 15:17:36 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 110/162] tcg: Move i into each for loop in liveness_pass_1
Date: Sun, 16 Feb 2025 15:09:19 -0800
Message-ID: <20250216231012.2808572-111-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index c54fe90309..74911962a4 100644
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


