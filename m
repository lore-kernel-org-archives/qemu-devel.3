Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DA7D31A0E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoE-00055u-JT; Tue, 13 Jan 2026 23:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfso2-0004gh-RI
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:31 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfso1-0003rV-CF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:30 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a1022dda33so50079665ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366108; x=1768970908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xGtMJKc8fbK/RX0Osf7Yr/1w4EJKUbQsbZnj2zQwzQ=;
 b=lJojp72H7poCTQGsEjSJgB4eJD7veMik52sB9fDMst5PSb8H+sDVMVcg6cJua4faBE
 tFHhhvmUXvMG67CLt2eOa0v8RDQTrZQn3/COm7W2iwBczkhguyRNXbTXJOpYAVVaZiP1
 6OWNanuJv8X7hFxHxQvVbPLEnynpBKbRPcJB2aoL+zQtyYUJyC9WXVLhubVgzVazEiqp
 ywweOG8JLvuMU1wDvvFJ8v6ZBUQ6ZdVi6+PERSzjILqCGTuQsvH00KQFq2SQYak7oEm2
 vblO5KQIOOTKy4fpcnyLY9WRNkx7TBZibJTSQM1Dt0TqLfcPmEzWOkTFU8rgfFSYNHpH
 c4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366108; x=1768970908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3xGtMJKc8fbK/RX0Osf7Yr/1w4EJKUbQsbZnj2zQwzQ=;
 b=CVDeY2U0jERUNRA5qSJcUa7q2GwKlaA42GySOmsBC/91Q4HEfmVIUGkHgwrovnp2bo
 rX7U0TFtNVYbZ4E/2hDOJ2dQrbOq5NS/8bUqSwCR3RurTeCrnH1+YRlASX10AQoOeMdX
 h7gYtdXbQBCCbOq7lfZRNeGCvTXWFJGmYL1NllVDH6DuMci1/ogoeOhKdmRHicDxM2nF
 P8ggM8/8D2ty6oFEa0355BCl6cK+A8d2SsiGFsoJIM8AXQ2mq3zpivJcMRkBSNyiKMLk
 NaP5qQzBeFQQvJbDw5wxm6cjW5JpfIc0F0pEJtyUcirdflG0buXeBpG2+K9zMy02VQq+
 xZ5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN3l9YrTyAvK5zD9utOD6SLneZNq33JeeSL2YmJENv+6uCgT5TPmF5XZX8N99P/DV1kPTHJvU4VyJe@nongnu.org
X-Gm-Message-State: AOJu0Yz9P2WvfjIBfcjpmLoWB/qAjGQUvmnOUby2wpHXmruP93T76duU
 f8gjAQXcS6eQNjLrDGHgL+iAB8ivrKkuNajnyZXFU3yjFey5bMjpd3bg
X-Gm-Gg: AY/fxX66D7JxW9a5c2GUdSa3ZgX1no0wwyva7QB7VOBHSHNTXw8DvJFrYNhtogGN5u9
 0bMDC6yF7aAWMZL+BEmZ+v5vNMziIXAngOjyVl/k+RdOfUpDbqHmPMIFC//WCvb74xzIDQLHqza
 4Bx4exVlEsrArbqYvJrml/Bx8bGYxV7t9JIF6NUCHn3zf0+VA63Z5IkjhiZLNsUXaG161Rzi1FH
 2ZH769pMRJJNiDtGro7NnMEQv7ZMBb6JJK71zQvafsMzgK/k6sY+Zrut63fL1a9z8Un1kj4/qqa
 TTsuIOommaE+Zd1zYYwcbaHTHkbe09HjHLVP+GigD2vVo2/lrk+iMYmJ33O7sSWeE6tpEI99vaN
 YvB89H2s7OvFzPghWv8wfwT1HAQFEM/0PHi3MU8aQRxbTu/OrgljXHGpDf9Z1n6nP2yO1b40cPh
 0NI66bJATCKwkzzNvJm4MdSJLtSNSaxIyjfo9MXg6emxrYZRy1C5JqrC4vI5M=
X-Received: by 2002:a17:903:2cf:b0:295:99f0:6c66 with SMTP id
 d9443c01a7336-2a599e09e05mr16186025ad.36.1768366108085; 
 Tue, 13 Jan 2026 20:48:28 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:27 -0800 (PST)
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
Subject: [RFC PATCH 13/25] target/riscv/debug: Remove breakpoints on reset
Date: Wed, 14 Jan 2026 14:46:46 +1000
Message-ID: <20260114044701.1173347-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Remove TCG breakpoints/watchpoints when the CPU is reset.
Currently they get lost.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 19c45fb13c..973de3b2e2 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1131,6 +1131,19 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
 
     /* init to type 2 triggers */
     for (i = 0; i < RV_MAX_TRIGGERS; i++) {
+        int trigger_type = get_trigger_type(env, i);
+
+        switch (trigger_type) {
+        case TRIGGER_TYPE_AD_MATCH:
+            type2_breakpoint_remove(env, i);
+            break;
+        case TRIGGER_TYPE_AD_MATCH6:
+            type6_breakpoint_remove(env, i);
+            break;
+        default:
+            break;
+        }
+
         /*
          * type = TRIGGER_TYPE_AD_MATCH
          * dmode = 0 (both debug and M-mode can write tdata)
@@ -1147,8 +1160,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
         env->tdata1[i] = tdata1;
         env->tdata2[i] = 0;
         env->tdata3[i] = 0;
-        env->cpu_breakpoint[i] = NULL;
-        env->cpu_watchpoint[i] = NULL;
         timer_del(env->itrigger_timer[i]);
     }
 
-- 
2.51.0


