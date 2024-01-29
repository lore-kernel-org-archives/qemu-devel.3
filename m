Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F0DC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUae2-0006mW-Fr; Mon, 29 Jan 2024 18:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadi-00063u-28
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:07 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUade-0008Qr-5t
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:05 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6daf694b439so1472946b3a.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569320; x=1707174120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42rrYlbSzYYq+E3YR3sViyWhIobfUBJl0iAP/F+r6Tc=;
 b=LWhUTsKB59I+RnkuB3o3HoaXtH0ZxROHl3jqW27pCOQMdC36tW0aL0RJR4NC9EXHQ/
 Q3kkUHjb4lqZh0cDbM5exb+kht0FAMfk83Uhk+h1numKVlUrfEOd5W04iZPMCYnUyCJM
 CY1LCPRJzpjQ1L+AWm7r/dpn6kxN6dC+Z8NVkb/IQjlqgz7m/t8LtVFQe1qY+M7kemx0
 HFuc6CQY7Vq4xBynrSDwRyGB+wRSXEpD0Z+6+o5yU1OBBDfTFBCHAM0x1QvRlu3mvMAJ
 b8yqFd/wG/w3TEUMKrR7SOhMceQJEza/BD39e74q/TzMz0fXx+noYrbCA0RL6yOmX2ur
 fCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569320; x=1707174120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42rrYlbSzYYq+E3YR3sViyWhIobfUBJl0iAP/F+r6Tc=;
 b=wIfF61Sc6IuWnaYA+bqc97B9vrdQkA+wUxI53ATomQIFtpmXieOpq9tya2j2hxioaj
 eyoK+uSwb896sOaoYX2mkZP2qlhoBJ5/j9FygjmAExYKTOPfDA+sSt2G2fNeZmr28BUr
 F05LIL1INJc89d1wTXRQR3YcXFIK4mji46rUUTGzAjf2dFKfJeBiOrA2+/kqCFy4t/7E
 57TZgFAL6C7J1Y3VYo05CdJML5zBO9ONvm9Y03uYs8OaamfpQ4/avbKwO/0PYHe4DskA
 OvHbmvGnU0GjZKRhokNyqULzbzfdpYKITzflPVgzjPLPNh2UP7upMXm1Yzeu49sOapRg
 uogA==
X-Gm-Message-State: AOJu0Yz++vtx0h0AvjMUc2xa5uH+Wu5Z/qS/YXfJPKwHxz4ymUsZgG5I
 kolLFw/Da+1XkHLFY7tXaD8zNfCp4jCVk3X0Vj7QUw6o5C89O6VF08nlkTsnSYKgFDggv6eKqis
 L6rs=
X-Google-Smtp-Source: AGHT+IGvCsTUMZhyIqRVohkh87v+URknO9UlFk0yLsazaQ1z08LgX+dCUbUYGSD9yedeURkRKUVR9Q==
X-Received: by 2002:aa7:8e9e:0:b0:6dd:8660:3adb with SMTP id
 a30-20020aa78e9e000000b006dd86603adbmr3154026pfr.31.1706569318948; 
 Mon, 29 Jan 2024 15:01:58 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/31] accel/tcg/cpu-exec: Use RCU_READ_LOCK_GUARD
Date: Tue, 30 Jan 2024 09:01:04 +1000
Message-Id: <20240129230121.8091-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Replace the manual rcu_read_(un)lock calls in cpu_exec().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124074201.8239-2-philmd@linaro.org>
[rth: Use RCU_READ_LOCK_GUARD not WITH_RCU_READ_LOCK_GUARD]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 40c268bfa1..950dad63cb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1050,7 +1050,7 @@ int cpu_exec(CPUState *cpu)
         return EXCP_HALTED;
     }
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     cpu_exec_enter(cpu);
 
     /*
@@ -1064,8 +1064,6 @@ int cpu_exec(CPUState *cpu)
     ret = cpu_exec_setjmp(cpu, &sc);
 
     cpu_exec_exit(cpu);
-    rcu_read_unlock();
-
     return ret;
 }
 
-- 
2.34.1


