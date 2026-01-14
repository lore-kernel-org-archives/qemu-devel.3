Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E6CD31A0E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsnF-0003hQ-Mb; Tue, 13 Jan 2026 23:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsn9-0003dt-Ad
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:35 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsn7-0003jD-I5
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:47:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a58f2e514eso9293565ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366052; x=1768970852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EODmgB2Z2Uc8Ax58+q72/O+PBlwoivJ4Lq2ghFezO2g=;
 b=QFEiALHW9AjmHIahyp/8vg36GLQ2PYjm222/rwtaNAdwt+hlyC7aQdRnJw+BkOnW1J
 LQYHA0MyJLXi8PQAPVDw/FXLfSq8+lPiIY+ZOhyLz3hrohAT2vleaCGoUul8/BgjZmaT
 KJMqTh/zwnoqMhxptR1YmJmLBv6bJK7NS0yOMFRsCZNUEkwwo17jmnt4cn2xsvQsriTN
 GMxDMsyC0+C+sI3fWwpcN60AZJYbGDSTo8oJJumkTgVzkpg0P/J4CFctd6v+hOHDFMBp
 UhqbdG6vYTOCjDNJnzNNAWV9Y0IYmuQFtsKLDSZIVPlRKK3BFUJfwyBl9NPUffyltY+i
 3WQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366052; x=1768970852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EODmgB2Z2Uc8Ax58+q72/O+PBlwoivJ4Lq2ghFezO2g=;
 b=DMhxETxxCtF5qmHzPkBz7xArXEmrfo6RfFdYtsjWylOKvTcDnf/Vu/5z7xmZfl6upK
 /O2nF/PnT54TCkK7h2R7Afvt8wzYO1YA7Eo6YM1WYva+tpvHhp3dI1JqQltjUCShiB+5
 ozgflewEBUEZlrxbPdis84yi8EtAuxWLApLlWppmpBMx9NAZdWdYbYnGhU2qYkh3Bmd7
 LfeGARbb4/en7HpvTt4I3G8RIJUryfJfzTqjaMdHkfFnxTyot1aOX30cFEVsazbg2JwZ
 eZwDaZ3rob+uPfSTlWqwGIpGAtjU8LRpxyh68syfWCFu4ydS9r4KqWzT0XypEt+f9gu5
 UxIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUZTOxepPkMyEzPMb0nWofZXAhFyck2RCQ5IgM9BfuMZXLnF9/RuDPyLep3efjOk2IRyUS/jf+AmSn@nongnu.org
X-Gm-Message-State: AOJu0Yzi23kT3EMVx1h0DDPfQSb6y5zEUX6cr+z36Qv+axt7J7tlQ13V
 26LH1OseyU0PVSWsuc/ee764lhWUcq0fnR6Xq0twdxR/x1XNqjx7mD1O
X-Gm-Gg: AY/fxX6ppTUisIDQfOt0KlVv84nJQPOTZQn3+qTR8Dgz/CX8lgludN8brNmAqu30R/g
 RBdIxqwQc2LMMylTYlT00AmeB593YoAZZuQ78oAqkt8uDMsQWQJIXCgHdOahvIAwb9WVrP3uUMs
 HNug+1ewQ1EIR1e77YBcLxs1rpMDEf7dCM8uqUaGnGYbTfAlX8VKKgjOD9xvSJ+APvD27AXBlTu
 ret2biXznGF21zcHppEa0r2fy8haKUL+rMQCMwG1+FkRNPWj9+82GveBcMdE+gg7bJXquNpWiPW
 q4LKlnSBx7L1du/eFqjUmhWywDFJsj/RE04nA0ywwk/s6/5BJh1EIHzV0jUa6LEzKc570K7DxiI
 26irWntM2chmKhsyVV7iW0g1oWBJXpPAJbYCtiTRuEkcq1vzEAURrKQE4UcPRtxX2zGpFbNZrTX
 PvOOpc+2E10w5aoHtH1XBx7Vg5t4JpgIhrNIF50pFW43lWtleeDGd3OpjkmAA=
X-Received: by 2002:a17:903:2c0e:b0:2a0:b467:a7ce with SMTP id
 d9443c01a7336-2a599e34922mr16482255ad.36.1768366052210; 
 Tue, 13 Jan 2026 20:47:32 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:47:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 02/25] target/riscv/debug: Handle changing trigger types
Date: Wed, 14 Jan 2026 14:46:35 +1000
Message-ID: <20260114044701.1173347-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

Updating debug registers will first remove the existing TCG breakpoint /
watchpoint, then adds it back with new values.

Writing TDATA1 with a value that changes the trigger type attempts to
remove the facility for the new trigger type rather than the existing
one. That is, it will not remove a breakpoint if the type is changed to
a non-breakpoint type.

Fix this by removing based on the old trigger type, then inserting based
on the new type.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 64 +++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 4273ab7a8d..2190c25f23 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -528,23 +528,12 @@ static void type2_breakpoint_remove(CPURISCVState *env, target_ulong index)
 static void type2_reg_write(CPURISCVState *env, target_ulong index,
                             int tdata_index, target_ulong val)
 {
-    target_ulong new_val;
-
     switch (tdata_index) {
     case TDATA1:
-        new_val = type2_mcontrol_validate(env, val);
-        if (new_val != env->tdata1[index]) {
-            env->tdata1[index] = new_val;
-            type2_breakpoint_remove(env, index);
-            type2_breakpoint_insert(env, index);
-        }
+        env->tdata1[index] = type2_mcontrol_validate(env, val);
         break;
     case TDATA2:
-        if (val != env->tdata2[index]) {
-            env->tdata2[index] = val;
-            type2_breakpoint_remove(env, index);
-            type2_breakpoint_insert(env, index);
-        }
+        env->tdata2[index] = val;
         break;
     case TDATA3:
         env->tdata3[index] = textra_validate(env, val);
@@ -552,6 +541,8 @@ static void type2_reg_write(CPURISCVState *env, target_ulong index,
     default:
         g_assert_not_reached();
     }
+
+    type2_breakpoint_insert(env, index);
 }
 
 /* type 6 trigger */
@@ -642,23 +633,12 @@ static void type6_breakpoint_remove(CPURISCVState *env, target_ulong index)
 static void type6_reg_write(CPURISCVState *env, target_ulong index,
                             int tdata_index, target_ulong val)
 {
-    target_ulong new_val;
-
     switch (tdata_index) {
     case TDATA1:
-        new_val = type6_mcontrol6_validate(env, val);
-        if (new_val != env->tdata1[index]) {
-            env->tdata1[index] = new_val;
-            type6_breakpoint_remove(env, index);
-            type6_breakpoint_insert(env, index);
-        }
+        env->tdata1[index] = type6_mcontrol6_validate(env, val);
         break;
     case TDATA2:
-        if (val != env->tdata2[index]) {
-            env->tdata2[index] = val;
-            type6_breakpoint_remove(env, index);
-            type6_breakpoint_insert(env, index);
-        }
+        env->tdata2[index] = val;
         break;
     case TDATA3:
         env->tdata3[index] = textra_validate(env, val);
@@ -666,6 +646,7 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
     default:
         g_assert_not_reached();
     }
+    type6_breakpoint_insert(env, index);
 }
 
 /* icount trigger type */
@@ -831,8 +812,6 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
                 /* set the count to timer */
                 timer_mod(env->itrigger_timer[index],
                           env->last_icount + itrigger_get_count(env, index));
-            } else {
-                env->itrigger_enabled = riscv_itrigger_enabled(env);
             }
         }
         break;
@@ -881,12 +860,30 @@ target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
 
 void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 {
-    int trigger_type;
+    int trigger_type = get_trigger_type(env, env->trigger_cur);
+    bool check_itrigger = false;
+
+    switch (trigger_type) {
+    case TRIGGER_TYPE_AD_MATCH:
+        type2_breakpoint_remove(env, env->trigger_cur);
+        break;
+    case TRIGGER_TYPE_AD_MATCH6:
+        type6_breakpoint_remove(env, env->trigger_cur);
+        break;
+    case TRIGGER_TYPE_INST_CNT:
+        /*
+         * itrigger_enabled is the union of all enabled icount triggers,
+         * so it's easiest to recheck all if any have changed (removed or
+         * added or modified).
+         */
+        check_itrigger = true;
+        break;
+    default:
+        break;
+    }
 
     if (tdata_index == TDATA1) {
         trigger_type = extract_trigger_type(env, val);
-    } else {
-        trigger_type = get_trigger_type(env, env->trigger_cur);
     }
 
     switch (trigger_type) {
@@ -898,6 +895,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
         break;
     case TRIGGER_TYPE_INST_CNT:
         itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
+        check_itrigger = true;
         break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
@@ -913,6 +911,10 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
     default:
         g_assert_not_reached();
     }
+
+    if (check_itrigger && !icount_enabled()) {
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
+    }
 }
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
-- 
2.51.0


