Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32682D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlD-0002f4-BP; Tue, 15 Oct 2024 11:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jl5-00028o-4j
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jl2-0000ub-H2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:49 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cbcd71012so31043135ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007207; x=1729612007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW4qiUY1SBbVKJJvqRXRWIOZdgv3cj76vj7S3dJPHUU=;
 b=MkUPYbYiRO1+j0D/uoQzMgNIuVqMLCuuZAfmt1MVBDgE5oLfyBsXgz249klmlwdcGV
 gFTmETx7ruYM5FLiyk7mbKmjZQ9FGNqhMSQiGrjRY0a74uuhPNqqeqEAybM5KKmglb+w
 uc4eI4lDIzD8bGeN2W6/TwxV71GjUET0bp7f2jE4htSKQ3bbpKwyuKZ/SF/pZBlVZD4g
 VIGAkneB8ZivHzBZsMOsTK2dbogeORIwRyPlDTdkGc3YnaocTF5qdH666jHVa19SQ+ex
 ZraBSf8pYRYL+D19esUAuqAuucyWCKVTStUe/7egtaRPIVqIkKxXSf7uJlfoEOE9I6uS
 JLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007207; x=1729612007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eW4qiUY1SBbVKJJvqRXRWIOZdgv3cj76vj7S3dJPHUU=;
 b=MRJvxPZgbsW+z8ZpJLTOrxquFc1CFSYxd3oUuBhBmdQU9L9hCfQ7KloTFELj+L52Gc
 g/1j0zxUeDFn/+Nc6tYOO6Pze/1d/QkpYW28DJoj8Z90P6iPH2nuL2vsp1TOBPTta/wA
 iflm1WkavY9VnKASPsCtyHobfIEhpvaBSzQem6OPRTugaQWczbGjSjECQDu0rwYIvvO/
 ieqZy9Ruz8OdNg9RDXiR+c5MoSKqgOkqjOKpF49BiFrGgbZHyOXVKZbwFMoKdvg0susn
 MNmb2fONR8SS/F/ntH94iGWqY7Q9pFKEIfPy7+T/6NHuh26pyJHDf4j7bp2dgf71eu4A
 8mfw==
X-Gm-Message-State: AOJu0YwfhuJvMTLG0AW8Nqhbx82Y9Zp02/OrBDZc6CngARD6Nt8ExsoJ
 N2i4y7UQ75fV7vQr/zxaPOBCnQQhqnCYKCgLV1bbMNDrlOEKjnBOVuzzi5BLUd1M+Z5DSR7V0i6
 P
X-Google-Smtp-Source: AGHT+IE1/HHdRZpUByX513Ft8e3jFhEioi5m+hE3WlcP9S0I2JpzeKAHc/FioN5NnJPvRm+9evWWYw==
X-Received: by 2002:a17:902:e749:b0:20c:716c:5c2 with SMTP id
 d9443c01a7336-20cbb1bb0f5mr141110715ad.13.1729007206847; 
 Tue, 15 Oct 2024 08:46:46 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1806c713sm13409135ad.303.2024.10.15.08.46.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/33] target/mips: Declare mips_env_is_bigendian() in
 'internal.h'
Date: Tue, 15 Oct 2024 12:44:26 -0300
Message-ID: <20241015154443.71763-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In order to re-use cpu_is_bigendian(), declare it on "internal.h"
after renaming it as mips_env_is_bigendian().

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-2-philmd@linaro.org>
---
 target/mips/internal.h        |  5 +++++
 target/mips/tcg/ldst_helper.c | 15 +++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index a9a22ea00ec..84c8e5e1ae7 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -225,6 +225,11 @@ static inline void mips_env_set_pc(CPUMIPSState *env, target_ulong value)
     }
 }
 
+static inline bool mips_env_is_bigendian(CPUMIPSState *env)
+{
+    return extract32(env->CP0_Config0, CP0C0_BE, 1);
+}
+
 static inline void restore_pamask(CPUMIPSState *env)
 {
     if (env->hflags & MIPS_HFLAG_ELPA) {
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index 97056d00a27..f92a923d7ad 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -53,11 +53,6 @@ HELPER_LD_ATOMIC(lld, ldq, 0x7, (target_ulong))
 
 #endif /* !CONFIG_USER_ONLY */
 
-static inline bool cpu_is_bigendian(CPUMIPSState *env)
-{
-    return extract32(env->CP0_Config0, CP0C0_BE, 1);
-}
-
 static inline target_ulong get_lmask(CPUMIPSState *env,
                                      target_ulong value, unsigned bits)
 {
@@ -65,7 +60,7 @@ static inline target_ulong get_lmask(CPUMIPSState *env,
 
     value &= mask;
 
-    if (!cpu_is_bigendian(env)) {
+    if (!mips_env_is_bigendian(env)) {
         value ^= mask;
     }
 
@@ -76,7 +71,7 @@ void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
 
@@ -100,7 +95,7 @@ void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 32);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
@@ -130,7 +125,7 @@ void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
 
@@ -174,7 +169,7 @@ void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
                 int mem_idx)
 {
     target_ulong lmask = get_lmask(env, arg2, 64);
-    int dir = cpu_is_bigendian(env) ? 1 : -1;
+    int dir = mips_env_is_bigendian(env) ? 1 : -1;
 
     cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
 
-- 
2.45.2


