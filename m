Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E567FE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzj-0004no-31; Thu, 09 Jan 2025 12:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzd-0004kk-MR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:50 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzc-00071s-3W
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:49 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so1733411a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442407; x=1737047207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXTY3v0Mhju7JfKzKJdD6zSDlC5CNwIYMzPHdmiHijQ=;
 b=YIZlH3JkcQBP1MHBIF0VovJFD6kmK2LSJ9wHwh3HoNyKYdQwVKUZA9+cWlsvS/PTOK
 lZ+IixtcvwNj4umhOsWM38Vsb5MkklTFkqGCy4uzfBgQYPNMJfKIyMdN5CGg7/qfhBg5
 zpQCspUGUIaej6uhO/Oi3JBonpqblV8PVZFjZnpCJ1eCYPmyvfWLm7JgpW2CBc7ckKgq
 zF7tAjgE/bjritQfMHP7vuw1zrocB4Wy6M4Ekf+nc9bjQ4zlp5AkYCDMJ7O+qUUnuCL7
 sN0DfwlAlvgWHXHR6bJBCssDtciSruXrQQNjdPMT3LEWvAaIhSkjPowD+g21WZ94WE/7
 Z3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442407; x=1737047207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXTY3v0Mhju7JfKzKJdD6zSDlC5CNwIYMzPHdmiHijQ=;
 b=Uo1Ju3dAX5aaLYqg9Uy0G/69KKY93y6LjhA338xQfvZSEb4RGjWi+/OZ5lWvePdhBV
 GO5hQvC/TEdGjso6ticrIr5jwsxf3jtfyz3kmnRSwyfLeaNbcoep+ujD1Eh7OpQ+fNXn
 Klv2plsn0yO4i162lGqzVR41xyX1fMpL4t2KLABXqp3UkzEyo6ooIMitOB4/pFNujJ//
 f7BatzTmaKHnwQaGWgH6IJt26QxXvLPV/MRu0xujsW8Cky/P3fOGbQPJgGKTfRCqL5oH
 hoTLgEW7rw6tfJJ3SoFy4JL01aIio/s17euPfVm/B2lPPkYD++QE5/0Cs46K6kO+bBn8
 9R+g==
X-Gm-Message-State: AOJu0YwgXZ8a+iclfBO9RQwOTvKIPzF6Hi4eM/7sGFIPqHBQpj6LABhh
 rEUzYiLwdMIlDxJT771fTWx+8neZwla25sW/TILaGnkPrjdM2hQVfuxZDuIKcBI=
X-Gm-Gg: ASbGncse2QaTLafFsDokLHriVnXKyU5BKHfDch28edgyfSW7yl+boXvaJ3fsYLhjh/D
 xsLbZLBVpmPvZqlElnBP7rBis4m6w67Q1FohPzuZsMHqINON2lEc4FKAr2BFkqy92wyklBgwdPo
 APtpDc15P8bXH5BWNgJzqTO4f6RMC2/9RdqrUdqFxTkNWqq8NJxp1VFFG5kqy6CfuSXAcI2NSh9
 Utdf3s8ztYj1Xz6TyXzDTXLwyf4d08zZIJzrnrcMXvJj8DatuPMWvc=
X-Google-Smtp-Source: AGHT+IFcyDhMCLcyPKRjNRSyiaTcuwr6cg5FOsTleZ2NI+uvaWzPzzAdWjw9hBaqlXfubgXpha7ydw==
X-Received: by 2002:a05:6402:270d:b0:5d2:728f:d5f8 with SMTP id
 4fb4d7f45d1cf-5d972e4dcddmr6326742a12.27.1736442406671; 
 Thu, 09 Jan 2025 09:06:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046a17fsm782811a12.62.2025.01.09.09.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D898C61546;
 Thu,  9 Jan 2025 17:06:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH 22/22] accel/tcg: also suppress asynchronous IRQs for
 cpu_io_recompile
Date: Thu,  9 Jan 2025 17:06:19 +0000
Message-Id: <20250109170619.2271193-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

While it would be technically correct to allow an IRQ to happen (as
the offending instruction never really completed) it messes up
instrumentation. We already take care to only use memory
instrumentation on the block, we should also suppress IRQs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Julian Ganz <neither@nut.email>
---
 accel/tcg/translate-all.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 453eb20ec9..d56ca13cdd 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -633,9 +633,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * Exit the loop and potentially generate a new TB executing the
      * just the I/O insns. We also limit instrumentation to memory
      * operations only (which execute after completion) so we don't
-     * double instrument the instruction.
+     * double instrument the instruction. Also don't let an IRQ sneak
+     * in before we execute it.
      */
-    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
+    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = cpu->cc->get_pc(cpu);
-- 
2.39.5


