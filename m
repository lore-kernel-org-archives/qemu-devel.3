Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D2DD31A0D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsoK-0005ZV-1Z; Tue, 13 Jan 2026 23:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoE-0005Cd-IO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoB-0003t9-T1
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:48:41 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a3e89aa5d0so64211665ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366118; x=1768970918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvCDt1t2ZjnFsrVTwfes5buVqpc80guQM15D2ZP9G30=;
 b=QWBek8SS5p0/QYICOYYc4mscZtzc58h//UB+Q8wXK8RAO+wjcgsSyB4LQM06Esud1V
 6zXQNMW8f+Fn+Mtsl0/9z6VX0Q1WL9Rv08gLJ86rFwwTiFGYWxxB5X2/V160Gdngo5Qx
 GUq3JTWPfDLLfAcjNfdTEOIq1SyBKJmqQr/3TxHWsLhSQB27Qnf+4WBwVaZ4HdLb42kx
 MQhg3afRh6xFeV5qHnhew4/WnHtESfskA3lG4i75wlx6DQ10j7Fb1iXWkD9MkaDwxOJ3
 N1P2rvilAzajO+dHzSihStA2rVSb58qKpsaAVtZD+ADtcy2sek4WJSfGVMYEkkfaKplN
 5oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366118; x=1768970918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qvCDt1t2ZjnFsrVTwfes5buVqpc80guQM15D2ZP9G30=;
 b=lY1bFoOxUDi770iw8KYRQqhfVjvgNXnXSF6z8ryT2i2TT+pKafW/MAfWhMxByApe8Z
 uYbdJiqXCN6mRmkdK7pY6Kz8yVyTBaXMROnmBimCw4rEpCr5Dq0htcgc85qr04nySVk6
 Ra6ci5qk2057lauuJ78O81/2LRkEvAfVf7ZFp0bizdxtKaxLb6v3KGXheDTt+JGrROVl
 e89oWDRe2HoPlhVs9EdoHKaSsKXL5+nRk8Xrhx++O2j3XLlvrq6+urY7O0/WtKxGaKEl
 jaTXV8qgCZzoMo845l12DkvaQttnNhTVpbwPWemjaEfUX99RIdL0R8uNUplRxwkUulOf
 1BOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ/fIIFsoFX5VHGIZ6W2yOmSx4W/9zLzWkIqOHLlw/nFXK7Xr+QE4sZMrvsVit1mgemcf6KV631/o9@nongnu.org
X-Gm-Message-State: AOJu0Yy+cvfravjMHbiiKoPiSMRDFDU4/F+1GtzZOmIS3lm1dZ7hmv6W
 xTMIcj/kjuu9+aXbgbVk2bb5H6jx31sL6+cGBo8CBdyExmW3UvCouzDM
X-Gm-Gg: AY/fxX4gpw3ECNHOZGKQLons8iMyFabygB1cm359ROFJ/MwZgXXulvHNM1BjF8Yf9GK
 cebpvzjGm/JtACkZWXmmzgDMz0UVNgDsmVInogMOM5MzRrrZ6DRhATNHtcIGM0Y+MPCy6azuUkF
 zJKXE8XlHYtGpv66aPttYHM67KN1r4eN8IdOimLv2jPBxGXJpVE4tgrjvq8BpjQvdl7SfeT4X9n
 r2NgmjOSI/6UI75FDh7zRwkywEYejg/fJi3/jbDr/lq6l/z3EUZPa6Pj+WND81T6gAQQeaV0yFI
 TducmRERNtQFGx+wDaQ4JHb0OGSJWd1QL1qIV8MsTHXgnsrXcmgnhQci0mLlH5xAeKcueZoap+g
 eEfL1CK8mLJmdMvZyGSYZRw1IIeZbs2SfBK470s/TkV18pIx1ifiQs99NEviAn9pNFljUFsulFq
 ttwocBrC1HjkD5faMZLJj9jz0QEjdn+DhYY+QcLyj+UfV7wmnxqceY7gJiCD4=
X-Received: by 2002:a17:903:2ecb:b0:2a1:3cd9:a734 with SMTP id
 d9443c01a7336-2a59bc36b61mr7470745ad.43.1768366118364; 
 Tue, 13 Jan 2026 20:48:38 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:48:37 -0800 (PST)
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
Subject: [RFC PATCH 15/25] target/riscv/debug: Insert breakpoints after
 migration
Date: Wed, 14 Jan 2026 14:46:48 +1000
Message-ID: <20260114044701.1173347-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

After migration, TCG breakpoints should be re-established based
on debug register state.

icount trigger timer in the icount_enabled() path is also missing,
but that path will be removed subsequently so don't bother to fix
it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/debug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 24161fd46b..a30b345b25 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -1126,6 +1126,20 @@ void riscv_cpu_debug_change_priv(CPURISCVState *env)
 
 void riscv_cpu_debug_post_load(CPURISCVState *env)
 {
+    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+        int trigger_type = get_trigger_type(env, i);
+
+        switch (trigger_type) {
+        case TRIGGER_TYPE_AD_MATCH:
+            type2_breakpoint_insert(env, i);
+            break;
+        case TRIGGER_TYPE_AD_MATCH6:
+            type6_breakpoint_insert(env, i);
+            break;
+        default:
+            break;
+        }
+    }
     if (!icount_enabled()) {
         env->itrigger_enabled = riscv_itrigger_enabled(env);
     }
-- 
2.51.0


