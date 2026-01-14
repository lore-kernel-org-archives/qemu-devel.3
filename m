Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DB8D31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoG-0005Ms-Q0; Tue, 13 Jan 2026 23:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfso9-0004q4-69
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfso6-0003sG-Kv
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29f102b013fso75528125ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366113; x=1768970913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAsFVKRwN90WkmQQPQFGWYihLeux/Lo7eb+Pl/bXD/w=;
 b=R5I+AdKENkytsOwYtqEoGJO9jL0nPSRjB9JnEmI05yMDI7xxcCCU0wHEsT9LNTTgLk
 VK2zfd1WJe1zYvFBkLzt4GflHnscq7viYTmjaCc2PiqjS6dCBUG6lXIHn6/NXU29LP/F
 B2ZsaKRpaI3qoEvCEQeGTfvgecKC2uFPYhXAZHDUGUU5D2kuRTT7VDC5LYHuYYcGhIJi
 GdxpjlNgmFWPObWGeLHiDBDACLH1Az7juqVZa+PcEwWK1HE6aCVcxNfbFSXe7D111mzg
 x2aDbiobEn6jonte+fqvILjIpVeeunRRitJkFjw6QjmE7+2bUK7FT187Nm6L27KJG3X4
 3PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366113; x=1768970913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kAsFVKRwN90WkmQQPQFGWYihLeux/Lo7eb+Pl/bXD/w=;
 b=GUInExKeZT47ZxN/ok18AGh4AlICbVhMTwcKpU3aJW+Zaa13wL+2sxDXG8E9tZFueB
 380Ja8Lv+T3CWQfgvK32f60xzm15UhIQXgJHthceU0+E4qqtRJ6FsS6bWnmZaeDucqiI
 Mjk+/ZZ2ESMAnuRRrQHwJSpqeBjfs/Eokzc0ajxVudxkJKqPBSyLehHsnPyQhrz/g9sE
 5g7DDbmqjGSdUuScAx0yMjv/l+AD1mfiLTRjyh0WuzjuT4buKdfhIUa0+l8g/RPO4hpO
 oQJkkmiAiFDW+0XC0hgz2JwvTnsccfsCBsgAEaKBf3SFtYqcR2wT5lDQuhhmz17N9ioy
 nupg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB3pg1vm3lEFmzuxqrCU/7xvfgxpg1ompo1bNYSbvN45L9CYAdEBxpUjXGnPNhbCJwtgLWHKeDmAqf@nongnu.org
X-Gm-Message-State: AOJu0YwXyonx7xkkJ4cUhG3Z/07dbyihqSDZO/idwwcruJIEUGOf1SUA
 nsspLDF90bdxDljzDMwwNJijmb+pxVFdnhtg/ZfB6jviDeGj0HFYKa0O
X-Gm-Gg: AY/fxX538u/I0lAO1tIOL+a8VDpqMaMfk79e8JLBKpdUShJGDjU5w3RGheUbBUdffIn
 2iHJLNZe0LrZUtzGqFKP/6O58cqBotxX9SusG/8yrukKUWUIZ/fAcU8Z9GaxXLnS129n2Bvb9S5
 olgGoqug3RJ2X7yExi54kQvGY65iLgrJu50ZH4Dj4ufdYQIqytUmKavWPBp3rncBXrfUetqkyS5
 bd3mLhUoqtvn9YCI2rbIPluHm7c957qNFJkSTEeDmwK1bJz++Pcie5IGWnkps5LacZRNiHzUQ70
 GermNAxUQeLcV95U2mz80REyv9w9jQ31LBHVjiDHgFncSsEU4MkjbOhVuwwCtyKSCwzTyVy7IwN
 qBU3o4+ouFeP12wvnr+6O6qkYfdr+5K+5Z2I1ydTaxiYPgSNcnc0TzlGW/41dyzSs8Z3d7GsFmt
 swK4ZFLjJnD7FgsZ9iMm3IjgWuXDkuI1IkDunvN517sag6/Y8acUOJl7Uce7E=
X-Received: by 2002:a17:903:2a83:b0:2a0:c1f6:6bc2 with SMTP id
 d9443c01a7336-2a599e73cedmr14380345ad.59.1768366113267; 
 Tue, 13 Jan 2026 20:48:33 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:32 -0800 (PST)
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
Subject: [RFC PATCH 14/25] target/riscv/debug: Move debug CPU post_load
 details into debug.c
Date: Wed, 14 Jan 2026 14:46:47 +1000
Message-ID: <20260114044701.1173347-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

No need for machine.c to know internals of how debug.c maintains debug
state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c   | 9 ++++++++-
 target/riscv/debug.h   | 2 +-
 target/riscv/machine.c | 4 +---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 973de3b2e2..24161fd46b 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -673,7 +673,7 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
     return icount_priv_match(env, index);
 }
 
-bool riscv_itrigger_enabled(CPURISCVState *env)
+static bool riscv_itrigger_enabled(CPURISCVState *env)
 {
     int count;
 
@@ -1124,6 +1124,13 @@ void riscv_cpu_debug_change_priv(CPURISCVState *env)
     }
 }
 
+void riscv_cpu_debug_post_load(CPURISCVState *env)
+{
+    if (!icount_enabled()) {
+        env->itrigger_enabled = riscv_itrigger_enabled(env);
+    }
+}
+
 void riscv_trigger_reset_hold(CPURISCVState *env)
 {
     target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 5a14b7894e..400c023943 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -151,9 +151,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 void riscv_trigger_realize(CPURISCVState *env);
 void riscv_trigger_reset_hold(CPURISCVState *env);
 
-bool riscv_itrigger_enabled(CPURISCVState *env);
 void riscv_itrigger_update_priv(CPURISCVState *env);
 
 void riscv_cpu_debug_change_priv(CPURISCVState *env);
+void riscv_cpu_debug_post_load(CPURISCVState *env);
 
 #endif /* RISCV_DEBUG_H */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 34fd73c920..bee1445a31 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -230,9 +230,7 @@ static int debug_post_load(void *opaque, int version_id)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    if (!icount_enabled()) {
-        env->itrigger_enabled = riscv_itrigger_enabled(env);
-    }
+    riscv_cpu_debug_post_load(env);
 
     return 0;
 }
-- 
2.51.0


