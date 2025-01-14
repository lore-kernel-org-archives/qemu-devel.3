Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D40E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOm-0004yW-RM; Tue, 14 Jan 2025 06:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNs-0004L3-0V
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:47:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNo-0006eO-Ry
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so38382035e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855215; x=1737460015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xR1sdOln5uQTQB+HehunftAymFm05ADSFOJij2asec=;
 b=EaQs7UOe2XDLXKsvyOQBTo3sy9Zf8+cZxyi0VEmopAH1giOqeLA24yHQwmzs/WK77w
 bw2Xk38cUrMg1kAz7j/dSzkuhjNX/DuMwh9xoQGv5+WUG24N3Py3snrrIPEwbWbQk1oi
 nolRvxepG0Xvylbzhe3NWZJpRzIX3IOU2aYRtcdtc+NKl4Kcds+R/ueQsxzbRMxHVMnl
 HvpS1Cz+bgI6Kn3EkVhlqxlM6DoGmXxkzL5MtbOwcaqWzulFg0ejPVCRrk15gk4FWytZ
 qA+Y6GvX9UG+S0BQ9Spl+HjooZWfhaCo1GkIULtFWl7f1B13R3fraeTQ3W5Lh+pcLrUj
 mvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855215; x=1737460015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xR1sdOln5uQTQB+HehunftAymFm05ADSFOJij2asec=;
 b=M1zF60UfKdnOefb/I0x01RwKGFpO7lTEUmbtryqgGZXlukD+wqQVu//zJaq0wvstdx
 k6gLyB0M1qDE4lRX8pvB+PA+ub4RHkB04/F+xSp81D3ZgpI05l7uUr5+f9E8P2ryjzN2
 WRQHOqO7L+NOQLBmZsmWwuzNxcxegqHoe/Cf4Yn/Z/xByio8K7a48+CHdHFgM/+n67t9
 QIqZYIUgBggDOQiFggXbZ7OQoZ2ORLcashoCjCz5KDhtAqDHwW50SGmOa7aRNkdCOnzp
 T5P5htXxOkuwlQ+JFe6+bFd02k5ZYm63OK2zv8ajVx81DL3jm5Eec4pdY65Lr8Yks5zT
 Vg7g==
X-Gm-Message-State: AOJu0YwlfGssMjDPC4ukeeYU2Pmv0gq1PHeZoFwjzG4FUVBmb5hAPOpB
 le2MVpto/aFOAvfMh6AyxZiifhyY0Bumk66mX1QRvi8+wpeK9a3U9PsZrK6WbqI=
X-Gm-Gg: ASbGncuxVQaar/uqjb20HWDYtTQdK+ve3qBcvSyWODTuY1vci5rrR6YgVCStfoChUxl
 ziJe91wucceDwGfhRDCbpMbEhQU11fes3X7bGRd3yeIKVS2hH2bV5H7BcOKkWgPvsS7JarijoAv
 v2inh+YYk2pXNg2qhtCH4+HXlp9MtrS21F0WXOgpA0zWixdf4BN7cX9ttceNf5mTcu7vER5BdD5
 GOhRXGDp08oi/Z6x9LArS5rQE75ITqcW6vCQYDQw4tKCnAK1q9xEWY=
X-Google-Smtp-Source: AGHT+IGx2jjAPa5lEa9xVCrGaSvJMlQVVZBdnI1AUpeEKkXkyqGO0eKfU4QfeqPbSLQfJcEKmQTGQw==
X-Received: by 2002:a05:600c:1f86:b0:436:51bb:7a43 with SMTP id
 5b1f17b1804b1-436ee0f8af6mr184610285e9.5.1736855215052; 
 Tue, 14 Jan 2025 03:46:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c16c4c12sm7808995e9.3.2025.01.14.03.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D07B65FA4B;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 22/37] accel/tcg: also suppress asynchronous IRQs for
 cpu_io_recompile
Date: Tue, 14 Jan 2025 11:38:06 +0000
Message-Id: <20250114113821.768750-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Message-Id: <20250109170619.2271193-23-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
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


