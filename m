Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2771FC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUaeV-0006qW-9b; Mon, 29 Jan 2024 18:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadv-0006Sz-OL
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:19 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadt-0008UI-Vf
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:19 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ddc0c02593so1489436b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569336; x=1707174136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TByYFDCUWCaxnnHjASz8MJMk4paFqdDSnL+kqN7t/Zk=;
 b=hSCT53HDAci2j+cCdASuI7LxpjcndbObfO9x000oCavtVAIyfDXs4Z+QcrB/yjf2Bg
 bfDyj4Srd985+vLPKMD2t3h74shHB7M3oXKXtQvkl4DVAOyxHLAnzl5e8fYvSFIZoKI7
 zuQZt0lnRHLM5A3lNUAyYgKLmImTi2s4x0fKb+9oOd6qG2MdXFW+yeLsAghMIfstRdBB
 VmvJYUbKsOIPXnftMJ6fwePC5NAq8LLmy9NgcyCDtHrPPPUxJr0N5yJOGSWeoLvnj1U4
 QzK38jroyY4cKTbBalcC75/tyeyQwjgFPbT9mx99zvgjjJkHHXBN3XNxb9h279oh75fE
 s8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569336; x=1707174136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TByYFDCUWCaxnnHjASz8MJMk4paFqdDSnL+kqN7t/Zk=;
 b=QxkvA2oG58vc0tfoLC8yH/hyHdLJipZVbUH8zFgsAKfXBQCqkYgV7Yp4wqITZiKVpS
 4yo3cuHfCeQIoRvV6xQTgWH3WCqSBDtS8brvTQGd6MPsYKIba4ynTbcs6H6QB5hkEE3N
 fYH7ZFoyyqOghVqNQ0GVRr38sBiMc8cf4t4RRs9D2zs+I0jVruAuiLZlgV0vZIuhPJhj
 aTQgRfOLfFamrdqb/YyyccVWukKNnxqK3/+Q5NS6XGOteFcoAKcydpdLa/TNRbR1+lYw
 SGOCVECp3KCcR3W9wBsqEMzaCUjHEWWsA1QcM2bfULrBeolHe4/ijkhkNhDC6KWQ5AAE
 nFfA==
X-Gm-Message-State: AOJu0Yw/YY0703Llfwo4MoZKGGJoEQnM87oqxG2N+ZjKW1b+6H+qQjBf
 EIXtw+22tJ/uAk708dUM99NUKtwuL4aI/4yTU3Z8G2gcETEjUqA9wVOCpbpjIoCi9QTx7nJAKb8
 rBTQ=
X-Google-Smtp-Source: AGHT+IHnxPh5JFlKRym7vnV6mjfqqT14mWr35zTT2N1sxiVR7oOuddJWz3JvRSWO7TBWdv71iomttg==
X-Received: by 2002:a05:6a00:2d0c:b0:6db:c6b3:25e5 with SMTP id
 fa12-20020a056a002d0c00b006dbc6b325e5mr3553233pfb.12.1706569335181; 
 Mon, 29 Jan 2024 15:02:15 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 18/31] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
Date: Tue, 30 Jan 2024 09:01:08 +1000
Message-Id: <20240129230121.8091-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Preparation for moving perf.c to tcg/.

This affects only profiling guest code, which has code in a non-0 based
segment, e.g., 16-bit code, which is not particularly important.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-4-iii@linux.ibm.com>
Message-Id: <20240125054631.78867-4-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/perf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index ba75c1bbe4..68a46b1b52 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -337,10 +337,6 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
         q[insn].address = gen_insn_data[insn * start_words + 0];
         if (tb_cflags(tb) & CF_PCREL) {
             q[insn].address |= (guest_pc & qemu_target_page_mask());
-        } else {
-#if defined(TARGET_I386)
-            q[insn].address -= tb->cs_base;
-#endif
         }
         q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
     }
-- 
2.34.1


