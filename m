Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39264CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mu2-0006Eh-4X; Thu, 16 Oct 2025 08:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtz-0006Ap-5W
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtq-00087v-Pb
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42701f2ad61so256595f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616958; x=1761221758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MG76ZHuOFDp9nKGKME0FcXDd+gBoTD4h2sGrYalA88M=;
 b=Fl91wWxQ/vNfZvLZ4dT7ggTb/ix/f0TqJBDjMFRUA0EdQwl5rQyzWrSQqYlU7hQExB
 uJ3QeCTcAgjAQSMoby6+uVp3GPthKZrFK7fgFjO7XpMf2GUL4GDIvXZzvWVZEPvP8i9V
 Yf2OlvX+VO//zdjed9iJ/wYYzXZ+zoUKNUzsYNwY3flBBRCJQO3Pvx0nuTZ8wo968CzZ
 zjM7pb9/b5dv7BxwCieT2wUJBFqoKHa/tnMPXqZOhpP3prOenUjU3Wu32HFVR1w2liX+
 jFUOU1cx17MIm/ZA0nJpG4Ly6APFghPzZ7DXb/29GPO4NInj42hd9//4KqvP83nvqcPe
 OSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616958; x=1761221758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MG76ZHuOFDp9nKGKME0FcXDd+gBoTD4h2sGrYalA88M=;
 b=qxyuOpuP+enTDp7dJwmsoeMKGMHKQ3xU/BLd23a3mO0Z6feGtyB6h6haFogQHJcLjZ
 m/XcG4WZ+BevnMPluShRh5I9/tiipTWhERsafk/1vtaDbJYCcQGuOunLxO3yWPe1lTAH
 0s8dZyk8ZitFydwJd8kACbNeQvx59cObXFcli03/9H26DwXVB58Jf+AiZbMUuJKVtg9R
 XyMeL3RjF5ANkYYfwWbScLf+ou30Z9dXGBsaQXJxjNsteFWTVfiEncj0gnK1qvoVVAUy
 WDqsFdvFxquYO1ZEAL07Todv9qmeS5n8WSevWgs/K9IS3wZpwm82JhDLoooBdJxC0IFl
 fvCw==
X-Gm-Message-State: AOJu0YzaJ+y/KAKkJ4Emrq0WU1KMnuIuqs/Vdf1B+2Wl476MRBAUByz3
 jq7YtYX3mf09GTjALyYROhw+JobA9FeYw+l5SwQj0RT9F6RmUKx7aXJBWRs1/mD00nc7Bl28gb+
 AvgRzefI=
X-Gm-Gg: ASbGnctDoQk5KiqJVhKVOnWB0CoAG9CcuTfT4Xg39RyklzpDybYE7skHoNc3kUs5pDn
 SsH3P6eOj0b7A6syjRrlpeB0FQkvRB+x2MSae+HscyemhEJ1SDsCLRBFtSSjvpTGiB0Drv19QUj
 C161cO8cw9UvYbjtvztrve6i6QpGq5zol8p78we48HHh42NX6Ujko3KT1eHe97HoNWFJvStZV1v
 yPa4cD9Noeg/3d5X2LRjiQnkZyGEtS3CL590XA0ywpz+eTQy6efQ6+28JjVuaqvQVbQiwJfq7G0
 Jc1xWsU8C4HXOYhxTybHXRyivmbkd376e06XjvjGdvo24EMIGgHzloq/zNNQbc6GOZFATfgvuRm
 fRraDti2Oy6zfQXXtA0eV/CGBLSiGuoiHfVio/RN81Rj8ghCGup/YfspYvn76p6DXssVDitgYq9
 g7/9z0FRWkYj7vajEBq1Wjb3WqY+hhlx9Ttw2kNMgLw5a4iXkMDUVTb7bZ3squEZro
X-Google-Smtp-Source: AGHT+IHS+mX58Jt00ykWMbRmvqJX7+z2aYY7zipSA3uurbufZ1V5M5n/orSNMRsHc1fvhin2o1SDJA==
X-Received: by 2002:a05:6000:420c:b0:3f4:5bda:271a with SMTP id
 ffacd0b85a97d-42666ac39e4mr18682874f8f.6.1760616958303; 
 Thu, 16 Oct 2025 05:15:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e50ef821sm20293559f8f.38.2025.10.16.05.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:15:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/75] target/hppa: Have hppa_form_gva*() return vaddr type
Date: Thu, 16 Oct 2025 14:14:21 +0200
Message-ID: <20251016121532.14042-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-3-philmd@linaro.org>
---
 target/hppa/cpu.h        | 8 ++++----
 target/hppa/helper.c     | 4 ++--
 target/hppa/mem_helper.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 869a75876e2..c652ef945ac 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -320,8 +320,8 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
-static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
-                                        uint64_t spc, target_ulong off)
+static inline vaddr hppa_form_gva_mask(uint64_t gva_offset_mask,
+                                       uint64_t spc, target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
     return off & gva_offset_mask;
@@ -330,8 +330,8 @@ static inline target_ulong hppa_form_gva_mask(uint64_t gva_offset_mask,
 #endif
 }
 
-static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
-                                         target_ulong off)
+static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
+                                  target_ulong off)
 {
     return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
 }
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


