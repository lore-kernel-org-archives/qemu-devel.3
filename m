Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC59CD1BDC2
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 15:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tErj8-00024R-QZ; Sat, 23 Nov 2024 10:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tErj6-000244-TH
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 10:07:13 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tErj5-0004q1-9Q
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 10:07:12 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-295d27f9fc9so2411515fac.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732374430; x=1732979230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+soXgIGzU1qx/4reP56HeUhKrWsVcJ3S0viKluo4FI=;
 b=LnjDoSukwJc5iaaDwxp++G8QEerDLJVQ6BpG1+3pqrbyfnqixPkGreH3mraC+pO74K
 CAaXPY6+wlAs86BKDfsUU+xqjnEjYVISHjXeVwyvfdZ3Vkv6OHqLwLtYbV6iP4rgC6Wv
 uQ74m6Bmd14Q+LotquJQytXIYM4u6Hz6wr2b0UBmbucfQlDYiEGEHck6NUnpaEL214YO
 Xjg90WdS0jx+bonnGdWOiFMJ0oZZ4mcY7tiLjOAIPUZl1w97jNLc2EbTtL3jH+OVLEH+
 oVi1rXxGHEPXglwAbZwm5kLhqT4AlgRrQ7/aAhXld5Ub7HsTzPBeeZEthQb4UzFjWdml
 TDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732374430; x=1732979230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+soXgIGzU1qx/4reP56HeUhKrWsVcJ3S0viKluo4FI=;
 b=eXSWcPCMKxqKHLRQnJ2wU6apS/bsfLCSBESbvP8PurEQzJO6TjZhE/Wf9M2RcRBkKd
 SbsbqzeoaSLP5bDAOJeYRp2VZIoqDXz60sZLWpq2yUPC8xUX4SVWeg6fj1EME68WUHvA
 dPDxiSXZzbMuOV1UTS58QYnWMGbJFGRdlkI0YaEfpR9NuxyK0J5F/Cc6Wosy+UpyyJPW
 8O0Lmd2WlTNyvTDUDMhMdCJ/OjOnlkBGmrP6HngDDcKdM3Z38okGVlF/tUH7OGXVzbhx
 1n2E777PFGX2PxIZhFsqSExmEg0GR2rtzJskszbWDbfa8LH0+QKTwczJBr4tXhqTOjtt
 2tdw==
X-Gm-Message-State: AOJu0Yyesry7hidJO0NsefolUXxUHqpkaYE1mkzXiLYSDJmakM3TrJPk
 gU/X70raCPjuDmnU7FCWi7EqrmmJC2cteay4lLvCOrnfzud1EEJYU9FWbhJ+7LL9O3JgZsLjWOA
 iAHY=
X-Gm-Gg: ASbGncsIHeT+n11mrgzebsCEthoKL6b8k8G9Aq3E15E31SbSVxeEpYPi9mVWfFLe2SY
 2w584KdHSG0HQtLxPeZSm41i7ruPr77iSKuFHJtKoCcSjpnfvtiKnk0vBnZvg3w1MaLyJ6DVvmJ
 8bD46QxJQsIxarv+dsObZPcnXKzhITC5wcGmETn+SFj7tx7xLwJy0zumi04GGsHc5rZyhUX1zA8
 3ZfaR+QzJPgEUpQvOv5q07Hoz0j/6UMcQlYg7pY6h0eXrgeGY8CeaB5MQ==
X-Google-Smtp-Source: AGHT+IHzf8BEbuNggtBYeyQyaju57LSIBzubVSGd4Az7mXrJyk3AW9rsaTsYIUohapovZNOx2n1Hcw==
X-Received: by 2002:a05:6870:2188:b0:297:949:4406 with SMTP id
 586e51a60fabf-29720ede21bmr6827393fac.31.1732374430178; 
 Sat, 23 Nov 2024 07:07:10 -0800 (PST)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d82291fsm1396390fac.33.2024.11.23.07.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 07:07:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PULL 1/2] linux-user: Print tid not pid with strace
Date: Sat, 23 Nov 2024 09:07:05 -0600
Message-ID: <20241123150706.19740-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241123150706.19740-1-richard.henderson@linaro.org>
References: <20241123150706.19740-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: J. Neuschäfer <j.neuschaefer@gmx.net>

This aligns with strace, and is very useful when tracing multi-threaded
programs. The result is the same in single-threaded programs.

Signed-off-by: J. Neuschäfer <j.neuschaefer@gmx.net>
Message-Id: 20241024-strace-v1-1-56c4161431cd@gmx.net
[rth: Use TaskState.ts_tid via get_task_state()]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b70eadc19e..f68c5cdc44 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4401,7 +4401,7 @@ print_syscall(CPUArchState *cpu_env, int num,
     if (!f) {
         return;
     }
-    fprintf(f, "%d ", getpid());
+    fprintf(f, "%d ", get_task_state(env_cpu(cpu_env))->ts_tid);
 
     for (i = 0; i < nsyscalls; i++) {
         if (scnames[i].nr == num) {
-- 
2.43.0


