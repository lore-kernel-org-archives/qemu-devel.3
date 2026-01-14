Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A31D31A0D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoA-0004nb-G4; Tue, 13 Jan 2026 23:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnp-0004Ut-Q9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:18 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsnm-0003pN-46
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:17 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c4464dfeae8so5432003a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366093; x=1768970893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2Hb19DkgCo3AeCu7BNIkPGvJ4ku8WfXnjreJrPfJ2w=;
 b=VCohNXzHnmUFbYanvB1wLBVdYjrAS8rlpxDLDdCc5JgFYClQbcoqTBGzpzAGU/vgTF
 yazinHY4dNnqcq2j8tAIc3+/I1HCxwP4m6Wgx8WqkU2qBrT7sA+t/0tzcpzowq/Rikv+
 K8Wd43DjiATlUdqSSb218cZbrbFMlr/9nZTicOaLFtWvjtjv3zxJ1r9t/fiKAx1knitu
 OKgibv3ySYzaTEZWF4AMt9OCje1oIYb8b6+qguwoFITgmlqPDh0ytf+0uPmwKF1dVeoA
 n6y7XW+gMRnNHMtwpjsPS1GS789DF/eEMws+SbbyWq8oc+JaHxLWOS8Mt4j/MrTC9k4+
 ZfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366093; x=1768970893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z2Hb19DkgCo3AeCu7BNIkPGvJ4ku8WfXnjreJrPfJ2w=;
 b=HyW8kckJL3+KY3AimvzSRcGtWMZdN3zBwM6ITSiuRVwy3WWeXvDF0CxUMMBw1L3lWK
 DXDBZPv06p312oWS5ibyD1oFF9BBuFb2AcZ5LtDVrJOmTE/fDEJwiZiNZxjKy8/Y0N9I
 f/EFjcLdU59aGUu/wb4c4y7Zngo1g1Jp+8Ech7PNMTpLjg5WYECGRf0b7p64WjkuzDqm
 TJP6LaiSKtezRcK+NgBXXIOmv9w6c6am/PjQNp4hNwgpkCJTAnrYZLzcMqgQoFNc7/Lv
 LsYWPDQ3MprFAWTL2hs9AwRT7JN07kjkJFeWWhdetpX/TSBJPQm365VqirBrDY+mIcAz
 EskA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA4f0xERc01HcNNigxscwJ/QSAGbEfqnDV1a3ArDmpEdjZPImfWpheXIQak3FzvLi7dATgQmcM7yLM@nongnu.org
X-Gm-Message-State: AOJu0YxVLXN6Y9Ch3lqN1wyRcjoZ4g4Wc1k4JUkuUIL+tDh2nmsHhgXv
 zJIyFzIfxKupdcLMA+21kNooA8wrUsqaCQZFjQlrUPThMQ6nwmk9DwrZQa4Q6Q==
X-Gm-Gg: AY/fxX4xyDrmtODiQ5lOTQ0GjsQn3JeKIrHpeYz/wT3P6j8Rj5fbCq60anXIK7kfS+7
 QFYk4C5ytiHHKW4vwNq6rufoB2yWzFY78yi75WtblTjggzmSjpkQ4vzStXiW7ymz0TI5wG7DFrn
 RlZ/R9no3vRbAkfq26AoDj/1MDnq9YZReH7B4li68KuXxk4L4gsbbb92BhBc6ARMWhv9n/OPbT0
 irJvSb6bto1adxTPFtc0KwdQOaW6qM3rPujl9vt3b+MtYBE2kiNF3VEKWp90xzIVchOx5JngsFC
 DEd5A4+KyI7THteMIS68wo+xxblHqQAdeS1SyyAHaxp3IJVVLIIeGrjQVB4pW9Az6G9sNuhlIt2
 FJqnQobS5oQ+4fxD+hJnLzmrCD/OFzLzS/0N7yRMgMoPs5dk8xFOPuiBikcAjbrC50sqXAHeJ8Q
 HrzE8FxEc4cdxaGmKyAmfVsDi7NuF5+vp/Flc/NO8jGZWh6QsqfxL/x8mL2NhARjVO8BVEXA==
X-Received: by 2002:a05:6a20:729b:b0:361:2d0c:fd81 with SMTP id
 adf61e73a8af0-38befaf6a41mr1244313637.28.1768366092875; 
 Tue, 13 Jan 2026 20:48:12 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:12 -0800 (PST)
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
Subject: [RFC PATCH 10/25] target/riscv/debug: Maintain itrigger_enabled in
 helper_itrigger_match()
Date: Wed, 14 Jan 2026 14:46:43 +1000
Message-ID: <20260114044701.1173347-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

helper_itrigger_match() iterates over all triggers so it can maintain
itrigger_enabled rather than calling riscv_itrigger_enabled() which
becomes O(N^2) where N is the number of icount triggers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index d835c0e79a..7ae02fe2d2 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -693,9 +693,18 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
     return false;
 }
 
+/*
+ * This is called by TCG when an instruction completes.
+ * TCG runs in single-step mode when itrigger_enabled = true, so
+ * it can call after each insn.
+ */
 void helper_itrigger_match(CPURISCVState *env)
 {
     int count;
+    bool enabled = false;
+
+    g_assert(env->itrigger_enabled);
+
     for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
@@ -709,10 +718,12 @@ void helper_itrigger_match(CPURISCVState *env)
         }
         itrigger_set_count(env, i, count--);
         if (!count) {
-            env->itrigger_enabled = riscv_itrigger_enabled(env);
             do_trigger_action(env, i);
+        } else {
+            enabled = true;
         }
     }
+    env->itrigger_enabled = enabled;
 }
 
 static void riscv_itrigger_update_count(CPURISCVState *env)
-- 
2.51.0


