Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12099C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 17:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHi7-0003xB-9r; Tue, 21 Jan 2025 12:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taHi6-0003wu-EC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:06:42 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taHi2-0006Ze-PN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 12:06:40 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2161eb95317so107243165ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737479196; x=1738083996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k61SOT55tEchcCOAJasCWVeJl795sl3BG5VEaxPqZrA=;
 b=bRdZ4RIjzru82U7P4tZmM+LF9HUTm1AdrVBh0mYHUgs/R8XPZUsBppPiF44jH9+rXJ
 BETOamb8VcQMivk6cNaeR4q8xwJj3un/1bdMqnNswCOZsdFilOHxQAiVkWiMr20Wvk2w
 /zIPEQqnTCaicfSdGqgak5IRJX3XCqDYXypXuNazl0u5nHH9D7Ns2I9PWRjCn4r0gYlM
 RmH4GEzZNAO75lobspbisUM9PKLElIVpq9J7vivl761+qx/JTEdlNsQjJTGXs+9N7syB
 GWvHDv6co1j6wjCYJchbp2M+wm3cFrrPX2UoRJA2YgIIGKsqXwhmisedX4TQExtPT4ER
 jfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737479196; x=1738083996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k61SOT55tEchcCOAJasCWVeJl795sl3BG5VEaxPqZrA=;
 b=GcxZnPeCwp5JjzzOx+/TS+BrGOJpMertGUUsyYZ0C4lkpLnXNjCIg9cbvRziXgwL3Z
 aLoneuJKWOlG+2nL6tcC/iVe7oBTKqwSN9gFQZHY98yR8NF5Tyu1efxhn5hnhfPbyHaJ
 gGM1P+seBt1gj/8GQLNccLS1aOORYGNgq9D4YuQRYh165sDHHfVx6Yzf0ZzrUL/B1+Di
 qk147mGN3+ufxuET4MPhkJ4VjmOZGpOSfZE3SVINVYmtniazs5s/p7VtE106GHsqXC60
 xuRuVYzH4ZH8jzCifHTK94yM9KpmUGHZdIarBNV3VzAToRFdOCe5So4keDNjmDkBjnUl
 TYOg==
X-Gm-Message-State: AOJu0YzFLt5J0YFxAE9aie5zHZqRDDc5gHBPsBR3VUmv/t9zz0JWk2+2
 qK7zydQt643KDsM+I5TeYSlQPvXNS+7OGKy4VDKLoMnDMCPmmt3ngG/Yr7EYgvVnkCHmmDkfAO9
 7
X-Gm-Gg: ASbGncurbGQFm4cww9u5E1VftPP4tiWsCMZmTh7QKq/GY1Zejz7v0ZsbqWSfC1VMPZV
 Uy8i9eQN5+CW4Sh6rNLABFjycba1KvMh0Jj3TtFBpnDaHAeRgE38ZjFNtepK0Y+yRL6u0XexIgK
 OMc+YRc+KHyt7D4cdGu6vtlC2Yttt4fxMJ3IxU4tkdz+KZa00OI91nbojKqrCY18svyo60Mrxuu
 AZ9E9+UQ1r5gOQpcA/lRphMJ4gav+/j2ZTDQh9yzlqkXHwyk1N3hcLMEDnY0b2fMbd7IRo+
X-Google-Smtp-Source: AGHT+IGZK8UOcIVBs2yqLfhcVzKzV8SfWjepcKwXgCX461HkOYsbkLZNNmgW0vyp9cijxUIQ2ST1kg==
X-Received: by 2002:a17:902:e5c3:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-21c351bcd36mr209315695ad.8.1737479196590; 
 Tue, 21 Jan 2025 09:06:36 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cfbbdf0sm80657825ad.105.2025.01.21.09.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 09:06:36 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 1/2] target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
Date: Tue, 21 Jan 2025 14:06:25 -0300
Message-ID: <20250121170626.1992570-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The mcontrol select bit (19) is always zero, meaning our triggers will
always match virtual addresses. In this condition, if the user does not
specify a size for the trigger, the access size defaults to XLEN.

At this moment we're using def_size = 8 regardless of CPU XLEN. Use
def_size = 4 in case we're running 32 bits.

Fixes: 95799e36c1 ("target/riscv: Add initial support for the Sdtrig extension")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index f6241a80be..9db4048523 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -478,7 +478,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
     int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
-    uint32_t size;
+    uint32_t size, def_size;
 
     if (!enabled) {
         return;
@@ -501,7 +501,9 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
             cpu_watchpoint_insert(cs, addr, size, flags,
                                   &env->cpu_watchpoint[index]);
         } else {
-            cpu_watchpoint_insert(cs, addr, 8, flags,
+            def_size = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
+
+            cpu_watchpoint_insert(cs, addr, def_size, flags,
                                   &env->cpu_watchpoint[index]);
         }
     }
-- 
2.47.1


