Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C21C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcG-0004so-PZ; Wed, 30 Apr 2025 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcF-0004o7-Cl
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:48:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcD-0001t1-Ql
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:48:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so1239482b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031736; x=1746636536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEe9bxPY78rzldhxeSl0yGcr1LEt/gfI/ABj5JQK6lg=;
 b=KK7nyOnes8LsJ3/kuzaFefB9ID7cmyhbHtG2RgXh1YWkdEj7VSrP7n3X11qBrQqAah
 Yu68vJwvUFZ0FdKChRCP1xGtCNCukF08IPl69zIGS0eCbbyt5v3psrIGZWrRfRsVVUVk
 3OuIJtlmgMaWLbY9I+aeRM6AMGhDdd9G/yzcxiBYqg3IFlPfhWWKOQHvrPjjGl5insOG
 GrQ30LwjDh5+gYfj0cn40G3qFl6kSAbiobUY0p0ueBVGM6bEMJkPhMIrNulq5r6oVF73
 yAoj+zaCHqcW1kI+vQGMlWuogdTNKPwX62McBZ9w90KF4364hS32AXwcrEgQ+DySkdkS
 2YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031736; x=1746636536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEe9bxPY78rzldhxeSl0yGcr1LEt/gfI/ABj5JQK6lg=;
 b=oMz1qyjtkEjAml3U8k56ueXhNoqjsWoUT7RUeQ1RRcLkpw09WiljBmTm8AmMHhBQIi
 bREtGYY6x0AaTSD+Pb3QkfwakdNhc/g1DnjUjzy9OSFPDE8AGk8Btv3Zz5EC9JAogLyU
 K7ISCNb+tp7/LYna0hL25EWcMua3Ecam61vogGh+iaj+pQ7zSiCZ6QDMSnIEEeARXGiJ
 dgFL1s1OhKiSDPfjF/isC79LH2uYfnLlKfat3/GRGslNByQa6ckHV5Nn7Dv4STaY+8cs
 zLE/kN7uhBN3iN3F6KabitvSa2pvl5nicJUl+qfBUHwMEXpqZb8AAas/9ziuECNl72V1
 +u0A==
X-Gm-Message-State: AOJu0YwfjPezXgjCH5dKclj+EghnL/tt8Opuug/gE867lYae91fBnQkz
 JwPCeQ6jVG31Oyx8dnuicT1fjGmFw3bq51ETSLBxhenpMM02X2GKqQvpToi6UWh+k4GhDn0MQyr
 s
X-Gm-Gg: ASbGncuHhRfB4hqF4Xk/Y+9qj4TMH3oD1iKGVIig1yFo8rGH3eFoBH2e9R3FWQlJ1La
 Qom9vbs4nOMyZ5WBO7bQCnm49ycbl3R55jWDA3cKix+tO6UjnFcqJCKzJLuPEpWD7NIdS9gYq6r
 6uLf6fI6YKiLFt5XN1OTBxtLJdtU6R1nGyOSdtaQ6hOZvnVOLXOluYGK/tREB4VvQKqivp2xwFH
 PiZEjAdi1rLLXC7vCjq766Eot1NVF55pDQ+vyc6vFq2+ibCr1LowFStJwA3AZS195hcxoH/XpHJ
 AYe1siq4o6JfWSiyEX4BT9gipIffSbM1TLOvTBqgPRwN1rw0dL4d9d5mOBwxcafk4buQyWRlccU
 =
X-Google-Smtp-Source: AGHT+IGI3/QXBrZKOsMmPLeYSI3uNZ6/5PtDuhNqCMRPomMAnvVbazYYqketqmBdKVMjbPgADmgb0A==
X-Received: by 2002:a05:6a20:9e06:b0:1ee:d664:17a4 with SMTP id
 adf61e73a8af0-20b972547damr238217637.10.1746031736316; 
 Wed, 30 Apr 2025 09:48:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:48:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 01/16] accel/tcg: Generalize fake_user_interrupt test
Date: Wed, 30 Apr 2025 09:48:39 -0700
Message-ID: <20250430164854.2233995-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Test for the hook being present instead of ifdef TARGET_I386.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 279df5fae7..8ff4a34509 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -732,10 +732,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
      * If user mode only, we simulate a fake exception which will be
      * handled outside the cpu execution loop.
      */
-#if defined(TARGET_I386)
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    tcg_ops->fake_user_interrupt(cpu);
-#endif /* TARGET_I386 */
+    if (tcg_ops->fake_user_interrupt) {
+        tcg_ops->fake_user_interrupt(cpu);
+    }
     *ret = cpu->exception_index;
     cpu->exception_index = -1;
     return true;
-- 
2.43.0


