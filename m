Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D9ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiH-0003EZ-NN; Sat, 30 Aug 2025 11:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wu-0002wJ-Qa
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wr-0002q9-Dg
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:07 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1238402b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506303; x=1757111103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bq6bpjIPp00ohe3kju2P0pETtz/AxcC5+J8q+lpmdRY=;
 b=pTOHFi+yv4WSPweolwzzeSh+z/Uvg9F3NiHzqzUFkvzOVmZhlO+FatGYaMBGLzndGh
 TovJFGjaQrXWvsXb6tx7KK5JCL2AWQFEuXhY88j9CJ0o7egFlPpDWoH4+Xqv9gguPAI3
 sIqLaNAi6MKmE/7/N6pgoWhNJqSZL7sqEnu8Nwbvo8W+BQ8Cvt2RkrdgAx5h9ZATSG6C
 m0RkXKaWL+Nru3zrvObv/sZDVd+zHywOaGIYkDW1kVQp3+Ie3OtKHXRcNkNVneApTQ9E
 eQfFI56wo8JB71upTli8vgWGgpMzL3qNth0T/2tLP3eOycXEzs0UXqOp3cY5cnGvOj1p
 MzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506303; x=1757111103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bq6bpjIPp00ohe3kju2P0pETtz/AxcC5+J8q+lpmdRY=;
 b=te3ivAUZLYQYZuwwOjWeW/dInDM6ytDIrHPkV0vzuS8g+PSUhZUcNZwHv/RIX69kLB
 fdilPpgb5Z5IO+zF5j3+dbFQ9+DZvc0erPXUNJqxvSvFsFG2WiKxtwR1lDBn8tlWsMGN
 wR8QWVqk9lIDPjw0qS8K89L5n9B5FDkJTE1ysLglFOu6Ws7fFzY/65HKd76n0+IVI8qt
 iKOp3rxCcxh0iYzvDn6mZcuQYwRTDXfS/M+PsuRC9S686+Hy6AGM6OskO6K+yD1Vd/WW
 5q1ruNdL/JjVWTnzpE7y29NkY9dYGj/z5wGk/lNbgXG3+ahR/40IdGOACq2dxryzkWZF
 NK2Q==
X-Gm-Message-State: AOJu0Yw+S/lhlK1arDJT+LtUYom1mSE40OxFtn6bWFIN/5VcwWE6iaFl
 DcqOZV3KBJKxnZUc8r+Sb92srwBQxARcNBjWWLlbYTYgXmRqT6DbGyhI3HSG0FOOZEFnY8HIKO4
 kB84d0PU=
X-Gm-Gg: ASbGncvvbiMfaUP7GMrUW89aJqqy2QxoYmiMa/4bSWy/OD/3oU5ShCdFxiP4W9YHejc
 9Pv8VeCvH/vtBJnUFo06j/Ens09Db/rFq4ucxF/Moh2aKbaOKb1TGRnK9MJs0tCzmSQ643NMhqL
 y0cjcr7i/GC06J/S0OC+BgcAmrCeFL/wqOxabnIDV50wnRR4qWz2rNnItFeod/h+i96Zw954wMN
 97RUTCm2z9s371SzMn71mwJiEWHNl+59pxiVyIMOF4Mfb8zMWI7zH9JrITeRT1VS/8qcz3ydIWX
 3k2MrEFi7ugGphj8XiwbaLrmEsYjMtm9OgGhhYaYLpgK6k/2mVf9K00VGNpCdJ3LsMMGmTxtCv2
 fhsk55BAMsY6DKyb9BGob9I64vcslTkQoioFdZ0guhtZ/i5teBmcwN4fuQKljFzDOibB66aY=
X-Google-Smtp-Source: AGHT+IEpUBG66KxSOM8HzJ1vW+85QL3ZeTSta18A+/3sZqfO8H8BqaYG0TEt9ROPkjmRSpXVZMe1kA==
X-Received: by 2002:a05:6a00:10cd:b0:772:398a:7655 with SMTP id
 d2e1a72fcca58-7723e38ae13mr209676b3a.23.1756506303069; 
 Fri, 29 Aug 2025 15:25:03 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/91] linux-user/microblaze: Convert target_elf_gregset_t to a
 struct
Date: Sat, 30 Aug 2025 08:23:08 +1000
Message-ID: <20250829222427.289668-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

While we're at it, drop "pos++" and simply open-code indexes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8fcdb0569b..40a5bcccab 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -623,23 +623,23 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 
 #define USE_ELF_CORE_DUMP
 #define ELF_NREG 38
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
 {
-    int i, pos = 0;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[pos++] = tswapreg(env->regs[i]);
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->regs[i]);
     }
 
-    (*regs)[pos++] = tswapreg(env->pc);
-    (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->ear);
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->esr);
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(mb_cpu_read_msr(env));
+    r->regs[34] = 0;
+    r->regs[35] = tswapreg(env->ear);
+    r->regs[36] = 0;
+    r->regs[37] = tswapreg(env->esr);
 }
 
 #endif /* TARGET_MICROBLAZE */
-- 
2.43.0


