Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6770CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkA-0000hX-GM; Sat, 30 Aug 2025 11:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wl-0002jI-LC
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Wj-0002g7-GA
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7723f0924a3so8890b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506296; x=1757111096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeH8XwO19Yd5VENhzbKJ915ynNMOVI6H/v6NatkJErY=;
 b=jtRCABd+ChK2QtEFE44Dn2ByqRHh3hN541QtR9iU/NFaV7m9MhPlP/lXgcpvn7tYQm
 JjibKVxaX0GKjQsjkzc2uFJ4DrzBfFPxWE7ZEsmbxgm0bs1MgFB3C6ro8fY8ARe7pRb1
 LqoJ8QJqKdSqk9Sb+dBPEzRHG/tMzaADg7rnoTZ5bzLrc0y+8k/ZFCg/OKiTjWQ1vOM9
 vsCBNpeMm8DT+Rzdl9I5yUZK96rjUe6Ov3bQwAcgf+nOjjRjkxAnQuCYOdz0thFgvPUy
 Kg62dVNJaGUlf4vGi1g68VGDaSfTA0OSHbJC8h6aXDd7aw3kWU6F/pPAlhZR4/CJYrc6
 EMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506296; x=1757111096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oeH8XwO19Yd5VENhzbKJ915ynNMOVI6H/v6NatkJErY=;
 b=Zvfa8IwaUsM/bEWoR03G0zsAmlG6DOAeqhxck1T+AnvBGUZCaQesILiGuLrUL2fc3H
 vDldQAgHYVXkaUHsvr3KdZD0eSpUCEdZdSCY9mY34r2QIPlexavNYGRl5JcYhYJoCWeC
 uVIgA9vFtK4Qdrg95BR0xCQXBNCMihVgKB3c38APtOqXaF1k2xoyBpyOqvebw3Tue/er
 eU6L8EdoLW1GF7Yall54OjG39whuFK+VN9xkvzY7PW4BUMSQ7bs4ewDgRoTgdbK7AohO
 K8NjMd2qWMiD5KR9XPUO7agHn3Rdm1YzihGrut438idL8XdGqwIOBa2NlCmbyFzDbBvk
 OhOQ==
X-Gm-Message-State: AOJu0YwZYQWyAY7WDCUTEOks0LJj7RruIazF7aW5dn8t0l2UkwQuZ2f7
 YiaWTXi8/xO/ODKtAzKGfyMqHUTXt2sEwhv1Xyu98qUyEYw3JCkH/Els2K++imytM2xpnTTde2h
 4B24wBvA=
X-Gm-Gg: ASbGncteRsd2W2IBzQIhHoRQFbhQaStir6oC9ycfGtA3Ttvj6OHXACrnN/3/YhhMLhc
 n+dXgwVju+i5M7NRX2hHLwIo2sWVucNOpYWWGg1LTHMyIv8Xka86EFmKZrF8t6HdFUl5MlrwHgh
 Da5sGuoQOBrY0R4rf2YxRzBfvgbRvyOIXN7RV2imgKmZ1Yf1G7df4LB3MB41DOqT4hhUnFrbDBS
 UZE/X2yTbRGsPxJriMdf2m+ZW3bbcEcTqI16XZQsCKxRz4sdihPly/cbv9PNhlaWMQFi5Af8Liz
 6tMwSQ3jaQ2kyiQpefpAGZO4MS7smhRSy5iD5/hlmlGs6tjS8sD+dw8qXC6S7ffjlF5YcLupfLC
 MvGsj/MUtGnc9am73L9a9aEyoLeTX+EUAnKfVrmFwO5pzJzxJ+c9Uh3yg8cedIH2p9HsWLUs=
X-Google-Smtp-Source: AGHT+IHae937BZ/y6AYYN09AMgCdYHToK+rRqHDRdaq1Uclk6D/2fBrOrp1KpnWhPCC48STCxoT02A==
X-Received: by 2002:a05:6a00:4fcd:b0:74e:ac5b:17ff with SMTP id
 d2e1a72fcca58-7723e279893mr288326b3a.13.1756506295790; 
 Fri, 29 Aug 2025 15:24:55 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/91] linux-user/ppc: Convert target_elf_gregset_t to a struct
Date: Sat, 30 Aug 2025 08:23:05 +1000
Message-ID: <20250829222427.289668-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index da57c6c2ce..0dd76937f9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -470,25 +470,27 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
 {
     int i;
     target_ulong ccr = 0;
 
     for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[i] = tswapreg(env->gpr[i]);
+        r->regs[i] = tswapreg(env->gpr[i]);
     }
 
-    (*regs)[32] = tswapreg(env->nip);
-    (*regs)[33] = tswapreg(env->msr);
-    (*regs)[35] = tswapreg(env->ctr);
-    (*regs)[36] = tswapreg(env->lr);
-    (*regs)[37] = tswapreg(cpu_read_xer(env));
+    r->regs[32] = tswapreg(env->nip);
+    r->regs[33] = tswapreg(env->msr);
+    r->regs[35] = tswapreg(env->ctr);
+    r->regs[36] = tswapreg(env->lr);
+    r->regs[37] = tswapreg(cpu_read_xer(env));
 
     ccr = ppc_get_cr(env);
-    (*regs)[38] = tswapreg(ccr);
+    r->regs[38] = tswapreg(ccr);
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


