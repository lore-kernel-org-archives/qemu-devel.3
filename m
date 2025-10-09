Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516FDCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nbx-0005Yi-UZ; Thu, 09 Oct 2025 06:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nbw-0005Ya-ON
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nbr-00079b-80
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:11:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so565212f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004651; x=1760609451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23HRSw/NaB6miuHpdFpETzgDRZhrcy3YY6wUWV6uGmQ=;
 b=e62WWzLynCme/Y1vwBpIzDCyQMdOW02PLbeDgnbLnaGs4cvCXWEEBLyM7EsX6442Fh
 h8tUxVGMR3lA7GcYg4cAjz8cjKUhq3tdJl6br9cjzLy/08wcGgmEzXIbYry8pJolXzqr
 FX/9zSSvQL6+GeJ/rNXvM6xM80PS8rroQ3szC+I7tSxlYf8hrTZdTR7ymkp+PLjZirA8
 WbT+RN+oiLGuwm+OT0w+KmeMPTgsTu7w1RGnvjwpabU5vVQFMxF9lcY3Yul5l9TQZ1Ww
 8x4JxJ8LUj69uJACtAddKKSAnRD+Z8mlWkFc8szwOACigvKh8zQPSsR2Ve2r5TtjLyYJ
 WcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004651; x=1760609451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23HRSw/NaB6miuHpdFpETzgDRZhrcy3YY6wUWV6uGmQ=;
 b=G11adt8c7Drx/r2+bv6vCHlzmr7THvAgJVuxufLWJC9Jj7WOPtMy+pzIdG6ymKP06Y
 1Q6XeYztnZF5xrl/5JsCvXKlv3V0Y7CLjQ7BNE03tYziXn4kaCkXDBTaiwVt2mp55KnL
 3vuHrcdBjRjGNp/kQp1lgYuSc46kYiXl6ZOsvoWaxHW28sjb78BrvG4ELOjsYFy9miLv
 FMRzYm0gvP3X6HwKl0/lb9Dcz3fe3TF2JExelSMwTHhJCKxoduMvrY3lL8CIYwym3Sow
 yYHsXPgeuplkO8S1/xVziMJfXlt7Aj9FROrkXNM7xXrxLxgt41xk6KmePOEvtI2yCvwI
 owaQ==
X-Gm-Message-State: AOJu0Yxx8POha9bTYicbVYZ62GhZovgFpVWNDyCDW93BAfohdPW9NS77
 ZpzPaKBeN81Hb2nYxiMl22gso9Dfafr233dSPm+bBTyJhUjs+ByMGox0jyKZclRmVKeij0dQz60
 wt3+2wUs95w==
X-Gm-Gg: ASbGnctlGq5/8QNaL9V84iiMqjX0SVy36z/KJh8i1Xo+Qt6kmUgPKNsmggj5FBMzV2q
 uMm5FeijYjfGmBSxi/Dm2B0LIx05oaYpZBLe5kTmalXr+CFlmKWKNVFTn1XtUUrw1le5lUyrTlS
 hRLVUMDO7UHdwcUg+nquZe8ozSiIXGMLd9plEbCBWMIaEdMfcbLuWighRG6Z6JubnskSRQlHnqc
 8gcbr7sZsYlwvRJ8o0wPq2T4N/oDfWpzST/lacyKVVVFtU3nsmyhYQbJvpA3Yy8s8bGmcFuZ7Ib
 2rIQpfYCnL1o3Sgki0VrDwUFG7fgKPDCigBjJ4TdsgmYY+SoLN0gfaZHBws6gcCuTLxS4rxqTWu
 iRrf89T78o40TkrJvBsxJVfc9uXr+1awPEoCc8YAu3nSHDE/rfdQ8QKze5fu/QXnUsKSGe8Waou
 YPiM5iJ6NRzcOwehhWQBiPG4FFj0tApJ2X080=
X-Google-Smtp-Source: AGHT+IGOq42dr5wEBb1MTPaPusIORtZe9fwzdCJx/sboXXwb23T84IXH/FxT+UIH21Og/vxfrAectQ==
X-Received: by 2002:a05:6000:240a:b0:406:87ba:997c with SMTP id
 ffacd0b85a97d-4266e7df82fmr4198043f8f.40.1760004651393; 
 Thu, 09 Oct 2025 03:10:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01a0sm33764655f8f.48.2025.10.09.03.10.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:10:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/9] target/hppa: Have hppa_form_gva*() return vaddr type
Date: Thu,  9 Oct 2025 12:10:32 +0200
Message-ID: <20251009101040.18378-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009101040.18378-1-philmd@linaro.org>
References: <20251009101040.18378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Return a 'vaddr' type for "guest virtual address".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h        | 4 ++--
 target/hppa/helper.c     | 4 ++--
 target/hppa/mem_helper.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 869a75876e2..e14f238827b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -320,7 +320,7 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
+static inline vaddr hppa_form_gva_mask(uint64_t gva_offset_mask,
                                         uint64_t spc, target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
@@ -330,7 +330,7 @@ static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
 #endif
 }
 
-static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
+static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
                                          target_ulong off)
 {
     return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index d7f8495d982..edcd2bf27c8 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -148,8 +148,8 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         m = UINT32_MAX;
     }
 
-    qemu_fprintf(f, "IA_F %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n"
-                    "IA_B %08" PRIx64 ":%0*" PRIx64 " (" TARGET_FMT_lx ")\n",
+    qemu_fprintf(f, "IA_F %08" PRIx64 ":%0*" PRIx64 " (0x%" VADDR_PRIx ")\n"
+                    "IA_B %08" PRIx64 ":%0*" PRIx64 " (0x%" VADDR_PRIx ")\n",
                  env->iasq_f >> 32, w, m & env->iaoq_f,
                  hppa_form_gva_mask(env->gva_offset_mask, env->iasq_f,
 				    env->iaoq_f),
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 9bdd0a6f23d..cce82e65999 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -803,7 +803,7 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
 
 uint64_t HELPER(b_gate_priv)(CPUHPPAState *env, uint64_t iaoq_f)
 {
-    uint64_t gva = hppa_form_gva(env, env->iasq_f, iaoq_f);
+    vaddr gva = hppa_form_gva(env, env->iasq_f, iaoq_f);
     HPPATLBEntry *ent = hppa_find_tlb(env, gva);
 
     if (ent == NULL) {
-- 
2.51.0


