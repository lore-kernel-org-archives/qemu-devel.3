Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0E8C87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguV7-0000ol-BQ; Tue, 29 Jul 2025 20:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFa-000242-VA
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:01:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguFY-000463-1v
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74b27c1481bso215416b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833650; x=1754438450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=692glwQ3dEUiBEVYbOeZXS5dOVnpC03SFQntpFEIvtg=;
 b=Z0UFGLrMjm3rahj+u5XWAaoaHlPP7UtcEqsWYmUjsL3IpGxfCmGtobnV2twscXu4qS
 UI2ScMbqJIIpvAPXE6fCKziB1XDXue2fhurcjX4a4IYCNmMOG+3lb+sjCi4t1QIFcaTT
 Q/+QjXgD3nbdnoS4eEYDciMDgMiTcSH0s5VIsk5ypOiWkefWbJThSu3+HR8pPnw+dTuI
 vn/4klZg6e8oDEgbFce+0Byp4OR+VGtmbVl9ENnZOI64uxpLnzXmwMtu2dlk7mqJn/zm
 QvVPdu2MdBSsGBwQpfPgvcnrbotlHcG+yfl4qxmHdoEhneYqqIKxQJ7S4uPXBmYpBH+i
 kdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833650; x=1754438450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=692glwQ3dEUiBEVYbOeZXS5dOVnpC03SFQntpFEIvtg=;
 b=BTh7Zu41D+EBR5dOuFT51JqoGXAKxa/DDEfhxFGTv0Tg7D+OTvPYx0sn8RQ3jVLheh
 gzLJS2HNN7kv3V9azFKdoQgA5aT5g4kJbzjjYOAk9CCPIL2l8MUqWAS8DYexI6VAKRmF
 z7hgYcWYhlIgNHMd8Y9ra/8u7gnV1tzzFtg7LAvAMp+6ZzYGY1/eHqNJ+yQ9/ov9qVWx
 VSJ4DbUCmnEZtI+TfFx1tDr/ZcecKydTGGchge9MRt+MvpYdM68EglmTWXashTmotj+5
 NV2XP138ogBb/gDC9aLwKgm8VAyZ+XSe0icY0aqJ6pNhTjJKdE4HtwIh1Z8ECB2uv7Z8
 Niyw==
X-Gm-Message-State: AOJu0YwwQrLClrmrk/JPtEIfxTQvH+cdyk3tWerCemLZ9hOzGisSvNjV
 ZNIyv+70QDx5467yQ+I4Ps/7iYNmOBOCPwzUN2+yh/PoKJXNiOGtqPevRHFf7NwHOVbKz1ZItU3
 cjDqb
X-Gm-Gg: ASbGncsozJxB+cdveNuikgHyKAC2lqJBJP7oC3+Eh3go7JOv1SmLfpsbjQGij/SyfDN
 cXEVzuf19PQ3nStAiStB91IHqOGXBztktGLyTiPGoVo4+ZuPKKY5j/1WrZGa0uneDjhG6QqFRyZ
 egBZgEbMXKCFIwvGL58XhM9lNWuu0PgXAR/cXvpifUtMX4OGInStprQbTlLLjABWPsuLCIBRJhg
 Mt7SwLeih49hiVSVDQiC2wkhX+OWph4voQhHUmaHjnK4e2ATO+pWKZBezeSqtU6veWVQW5B0hrS
 l3otUBp+tvtletJdBl4AtTVEDb/sCUgLQrCVl0mDAaLdjHGBnI1u0OU7kwFqQ0wGTcvM9WOps4y
 4plTkYEhiQ3xlrpchXbaJWLnAiox+HVH2+0VCZezFNgI8lq2tS/6RapWd8zTRX1XjAM+JfoI/WH
 3jDWQzjlUzzg==
X-Google-Smtp-Source: AGHT+IG+NWxPUzrj6CHeHjNPx+KD4W4fPJgp8Wsn9DT2F3LWqVRYswdTMi8s35bM2OO1GGsutphFmA==
X-Received: by 2002:a05:6a20:3d0b:b0:231:c295:136d with SMTP id
 adf61e73a8af0-23dc0d3eba5mr2024211637.14.1753833649548; 
 Tue, 29 Jul 2025 17:00:49 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/89] linux-user/loongarch64: Create init_main_thread
Date: Tue, 29 Jul 2025 13:59:01 -1000
Message-ID: <20250730000003.599084-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Note that init_thread had set crmd in target_pt_regs, but
target_cpu_copy_regs did not copy to env.  This turns out to be
ok because loongarch_cpu_reset_hold initializes CRMD properly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c              |  9 +--------
 linux-user/loongarch64/cpu_loop.c | 11 ++++-------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 00a3f6d33d..4095f7615d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -539,14 +539,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 #define VDSO_HEADER "vdso.c.inc"
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    /*Set crmd PG,DA = 1,0 */
-    regs->csr.crmd = 2 << 3;
-    regs->csr.era = infop->entry;
-    regs->regs[3] = infop->start_stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index ec8a06c88c..a0a4cbb7cc 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -120,13 +120,10 @@ void cpu_loop(CPULoongArchState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        env->gpr[i] = regs->regs[i];
-    }
-    env->pc = regs->csr.era;
+    CPUArchState *env = cpu_env(cs);
 
+    env->pc = info->entry;
+    env->gpr[3] = info->start_stack;
 }
-- 
2.43.0


