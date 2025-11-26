Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC74BD11197
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM3C-0004Ig-I4; Wed, 26 Nov 2025 15:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM39-00042z-Ag
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM37-0002Wi-4B
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:23:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42bb288c17bso129293f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188615; x=1764793415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRknozkFZhdeVPmoAAlQwK+1qO2Yf+FkoXswe+IPjmc=;
 b=TflN6pbdOLHQvdmBXaIybOWkRKXsohxCcH83mvll41HkwqssVPh0JDW4d81Jf8zmoy
 XaelZxXyHgWAKQ+FwlmYMWq5nmf0fQa7AbaHagVa7ngIgBAzFJrfC0KDCjYBTuGAHuJ2
 OKVZTSGG2Sf+um3xJiIScOvodn0+cxmiYfH6YOB4XqJH3Cncbi7+pOPXtGbYW4qwWuMj
 5yZxlS3hzkRVRXeChlTnUlbXKmUgtreVfo/0sH+chsesXX/s0cv+foxnAR6ojWODJqwr
 jkyw0Uc+6Xu61BRqGwr0mFK8eOPGVkGneExq97O9avc4mTZL8xBjLg7BOErFzthSwTI2
 EetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188615; x=1764793415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MRknozkFZhdeVPmoAAlQwK+1qO2Yf+FkoXswe+IPjmc=;
 b=kSfDUO7yY4UbTfewSWrkQ3rn1VuG/ZeABAum7L/X5qP9o3PwZrdBMFufLVSjIZmbi7
 rx/eKHBIvbDRWv1kffepD/93l4xAbwWQdMiptJk26MNUuD5PbHQRBmHlLgyIb5L09ToJ
 7TcN+QCtsYWY1CSSnM6TszMaZ2q/X/v1qxZZfOSjxAc6O8SboxbRyjAikRBXaYb4Fhff
 1sE31pwMl9Wwpi8qsieIC/sbNUASG9b9+v9WQxo7iBxvuCVDN9M6XUny7yvt6RqTqTpE
 xPEu/7szPagC+YgNQKeXcj22XiCcL/Rn0TSXXNDSasLGaxFP1mhfcNMQ/oEM/C3S7Wxb
 lnHQ==
X-Gm-Message-State: AOJu0Yycz0TVrbIJM4SOxb1wBeSABwE/Bc3mZMB6BvcGRbcW4xO4h4F3
 WkdVTSoQJUZqow2v5z/JUrVP9NzRtiNDJONuyh6bcIHZp1Uhfdu3ij+pzqserL3u5JDI18WVQat
 J/hibtmwU8QUQ
X-Gm-Gg: ASbGncsoemrf7c0nijqQ3iMe48aM0azbHrhS10Xd3kqAgw4UdU0rAN180i0zjynAOTJ
 ApghSfIJRY1Z2YHGhfHNBz7aJG2yrYeTd8FoGSOu/PQFkxeAYfFujGMZjoIIHWPnF2nUnRs5Lyw
 Ihag3VWM0b2FksNipKpXWxUsc6tqboSVuMb9c7wXe4xroenFSmJkHGtGGUhYwHWXJ80LNV2nSd0
 sfe6+FANRESKn6Z/B7KNTzcPPvC3FmoV1uOYmuUvi8VhBdNCxT8vnzchj5pYf03MvxEKSQDFky6
 6t/yBQee80otzT3mEHxM0ykva6WAThKLnmlYRfuTV7NxV3iixKRYh8dRcqlyttjG7SbqqYQ8ODD
 ybszCFPpUwGuLhbCwQvQnxOR/Kc8d1SBPtKrXrblQJS5QTA9Ks7uhOfy6/aA2D65BZNS/O/7k/t
 /AgMAdnAtF1gTobDfJU2kIwIadPb/ncKt1nzxEXI5HjBRDC8/NQhiTMEkow6lJ
X-Google-Smtp-Source: AGHT+IGTMdee9SGLTxNahRSCLS5wVFtYDmb07x3sRVJxAWTEZy9cKJIG6Rvx8Mehkmh3+H4gqeVpkA==
X-Received: by 2002:a5d:5850:0:b0:429:c709:7b54 with SMTP id
 ffacd0b85a97d-42cc1cf3c0bmr20705403f8f.36.1764188614892; 
 Wed, 26 Nov 2025 12:23:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8e62sm42723543f8f.35.2025.11.26.12.23.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:23:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-11.0 v3 13/22] target/mips: Pass MemOpIdx to atomic load
 helpers
Date: Wed, 26 Nov 2025 21:21:49 +0100
Message-ID: <20251126202200.23100-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Pass a full MemOpIdx at translation, then recover the
MMU index calling get_mmuidx() in the helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 4 +++-
 target/mips/tcg/translate.c   | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index c1c4a60cf3f..013cd825dac 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -30,8 +30,10 @@
 #ifndef CONFIG_USER_ONLY
 
 #define HELPER_LD_ATOMIC(name, almask, cpu_load)                              \
-target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
+target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int memop_idx)\
 {                                                                             \
+    MemOpIdx oi = memop_idx;                                                  \
+    unsigned mem_idx = get_mmuidx(oi);                                        \
     if (arg & almask) {                                                       \
         if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
             env->CP0_BadVAddr = arg;                                          \
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54849e9ff1a..c476271d6d5 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1932,16 +1932,17 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
     tcg_gen_st_tl(ret, tcg_env, offsetof(CPUMIPSState, llval));            \
 }
 #else
-#define OP_LD_ATOMIC(insn, ignored_memop)                                  \
+#define OP_LD_ATOMIC(insn, mop)                                            \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(mem_idx));      \
+    MemOpIdx oi = make_memop_idx(mop | mo_endian(ctx), mem_idx);           \
+    gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
 }
 #endif
-OP_LD_ATOMIC(ll, mo_endian(ctx) | MO_SL);
+OP_LD_ATOMIC(ll, MO_SL);
 #if defined(TARGET_MIPS64)
-OP_LD_ATOMIC(lld, mo_endian(ctx) | MO_UQ);
+OP_LD_ATOMIC(lld, MO_UQ);
 #endif
 #undef OP_LD_ATOMIC
 
-- 
2.51.0


