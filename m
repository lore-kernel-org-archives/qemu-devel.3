Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A64D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoC-0004zT-Ef; Tue, 13 Jan 2026 23:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsns-0004aA-Vz
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:22 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnr-0003pz-9m
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:20 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso55441635ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366098; x=1768970898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ofm+N/LDiPzYAnLWkV+TDBOxIPdJ2LtztPUqgJYqw8Q=;
 b=gb1ikUnmqWxyGPbSXLtbmZmzyS7mgtcfr9F0zapmRCqlvWGAqt/4D58vxNIlDV1QMR
 5Lr09+bSwU/L8ZhroSvTFRtI+8q45I/jy3FY3Isascffi4h6X8QOrj/UItMxIDitoBhF
 yhJeKmVXfu/J/M9BIsCkcCQ4X/F6D7vGQOvWP+VoBsdaRau5Ezf7g7WvohOoi/0rZ4EI
 c4u26S0NzJY9vaEEDeAziJIUEuIh+ljB813+g/e0Kfyyg5Ia96mqnKc6ih3jXOBkBVjy
 iVqu+2jer6kE9fXkcKazBcNXiodgJMp4zDbClYSR5ygJcja3y4Qo9vaanQDy84JaeYF+
 AGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366098; x=1768970898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ofm+N/LDiPzYAnLWkV+TDBOxIPdJ2LtztPUqgJYqw8Q=;
 b=R++MM8+/8OJ2TCYr7ap4soLbM7R914rsoT7al3hoT8AftwY4QSd9Mo2+k/sUWApHXR
 /JN90GJvODF4/s+euyTwlvqqE0ZwJQi3jvI9R1WRVrg0anFiWesFdnDBx78e18d7TsfC
 pGL95/HRt/Zyx7sakdM3OHCpPrSYCkM1iG9U/j9bND0qxxJDv58UcdcvPtrhNCXXOLIP
 h5pMt9ilgKr343hsXvbiY8c0vC2r5dZxJ8yflZeIsaVF3OJtzkf/tsZ5nqweGal43wro
 0T7BVt9pN5cttYo3Jaf9tbHwBBaEuREL+l6zM2q9n5XcFBCP06MmuHra7XTG72HTDAJw
 7vNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw9wJDVh7/foPWOmy3ybQodMh4w7KucItz981PC5R/QNPNwyZMoUhoBWEi5nxqK63vceOSqNQPmpXX@nongnu.org
X-Gm-Message-State: AOJu0YyvmLoOFtoL3FYoxrAKQcc8+hO8wo8xzWRyv2fWF/d21Y4MJj6S
 ARsK02GRxAc0T1jb2mJu5VSqc/iFEe2Uu4U38yrVgE8JBMlyXTRzrbiC
X-Gm-Gg: AY/fxX56xlYfC7AEG7zvhTosZznFm0RRtJgu1VoiSzJ/8MXHKbWtRHeNb3BFC6f9cXZ
 HzcYv/+txFnjpm3Z0NtwET+LDeMV/0/F5rLJ6A0Cq5XB3/rMwHFjPYGZGU50o1Ngw8YV45lxeGk
 Ktb3lvFXoA+gO6uJt30jEDzNnaiwGO82Mh0ndRzhfOE3wsjU6xlXJGMJE80Y1agZMyUxO/j+mlh
 tRmsjje99ZbDxH3trr9JRpCyGxhPNVK9b2qvPgdtTvH6FN6oGl13fZzL9zbzTGQgmKWrP8kM0z2
 Em2Kx346iAAluN4MJZp5WwUO73gGVXwjxiZvWq6Udbn2CJs+2RR9WP31XoSlen6UpDf1vXijSPj
 LolhzLZw+/2xH+gtx8EUcsi6QSVb4yu9K3sJY4H6m/fwexQ75wUuFucwnv4smsBSsNgO5yHaOV5
 ouHwV9nrotczIuotjYTqAEdGSrUnf4+8BszvQKa0sF0RXQobEST+xITcLNg9arSTCRyPfcAQ==
X-Received: by 2002:a17:902:d4c7:b0:2a2:f2a5:4136 with SMTP id
 d9443c01a7336-2a599dc866amr14488245ad.22.1768366097974; 
 Tue, 13 Jan 2026 20:48:17 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:17 -0800 (PST)
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
Subject: [RFC PATCH 11/25] target/riscv/debug: Fix breakpoint matching action
Date: Wed, 14 Jan 2026 14:46:44 +1000
Message-ID: <20260114044701.1173347-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

The debug exception callback is too late to find the action for the
trigger(s) which caused it, and it is actually passing the wrong thing
to do_trigger_action(), which expects a trigger index but is given
DBG_ACTION_BP (which will be interpreted as trigger 0 and use the
action set for that trigger).

It could be possible to derive the trigger index from the bp/wp address,
but that is clunky and it is really the action that determines whether
an exception should be raised, also multiple triggers may perform their
actions in the same cycle, so it is more consistent to check action
during the breakpoint matching phase. If a breakpoint exception is to be
taken then that is signaled at that time.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 7ae02fe2d2..bd61b7ff02 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -280,7 +280,8 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
     return textra;
 }
 
-static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
+/* Return true if an exception should be raised */
+static bool do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
@@ -288,8 +289,7 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
     case DBG_ACTION_NONE:
         break;
     case DBG_ACTION_BP:
-        riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
-        break;
+        return true;
     case DBG_ACTION_DBG_MODE:
     case DBG_ACTION_TRACE0:
     case DBG_ACTION_TRACE1:
@@ -302,6 +302,7 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
     default:
         g_assert_not_reached();
     }
+    return false;
 }
 
 /*
@@ -718,7 +719,9 @@ void helper_itrigger_match(CPURISCVState *env)
         }
         itrigger_set_count(env, i, count--);
         if (!count) {
-            do_trigger_action(env, i);
+            if (do_trigger_action(env, i)) {
+                riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
+            }
         } else {
             enabled = true;
         }
@@ -965,11 +968,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
 
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
-            do_trigger_action(env, DBG_ACTION_BP);
+            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         }
     } else {
         if (cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
-            do_trigger_action(env, DBG_ACTION_BP);
+            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         }
     }
 }
@@ -1006,8 +1009,10 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
+                    if (do_trigger_action(env, i)) {
+                        env->badaddr = pc;
+                        return true;
+                    }
                 }
                 break;
             case TRIGGER_TYPE_AD_MATCH6:
@@ -1015,8 +1020,10 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
+                    if (do_trigger_action(env, i)) {
+                        env->badaddr = pc;
+                        return true;
+                    }
                 }
                 break;
             default:
@@ -1067,7 +1074,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
+                if (do_trigger_action(env, i)) {
+                    return true;
+                }
             }
             break;
         case TRIGGER_TYPE_AD_MATCH6:
@@ -1083,7 +1092,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
 
             if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
+                if (do_trigger_action(env, i)) {
+                    return true;
+                }
             }
             break;
         default:
-- 
2.51.0


