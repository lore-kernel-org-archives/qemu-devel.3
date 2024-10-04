Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EDACF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl5M-0006dV-CP; Fri, 04 Oct 2024 12:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl57-0006MX-Ty
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:23:05 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl55-0004Ql-Qj
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:23:05 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5398ec2f3c3so3055273e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058982; x=1728663782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xgf9BvICxNs8M4a+Ynl2kNbkAd0IyBvDVaoxDWmJxpI=;
 b=JqwwkUTCGAS7MP+bCiTPAeoQsbHN5rRlGRKnOFwamWc0YD3U1gMoWnkDYluQ631gL/
 Nn0ovlnL3rNv8k7S50/a3wsgNgtHUKLgKXb5VcX1yUP7IY/elTZhBsKl/1d07OzH9LH6
 57V+NrP7bt2HRbzC5va3L4I0gvbb7gU6fc2ohPXMGx639iPiRRPzLbAcAY73c69V0bD4
 EGJMoyYwCRH6oWfVuwZJHg6gJFkvV3PSgCuw0g3Hr8INVT97aygSevm9OaR2pRNHEsf0
 OMzwIcDdKlF05gqPO5Zj0Vl7Q2bT2lzF9EHjpviFBAiLQfrDE3/T50P0CTsw8s7PF+9B
 GH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058982; x=1728663782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xgf9BvICxNs8M4a+Ynl2kNbkAd0IyBvDVaoxDWmJxpI=;
 b=gyz9Eoi4wKN27IgNlh4fO52S+aAq5qoOoW6OWSoeo+esBHerz0lKyHOwYXDXemA1xJ
 vfYzfyFP6q4hc55Ja5ce+LO9pQzP6j7NYHGcJLYoF86Fo8QpCP3/HBEeP1UhzjN0QY0L
 HV81EMCKFdNMlrLs3NE8JdRA4foY7Taay5KnO7pxYHe9ulh3O78CWX173iHrBEerqjmb
 jZSVWs7zQdZ5PQMsisqOteFjQDJoNO6UMGbiOIG4DoA/7MI9Obawcqv1xYukjicbztdE
 BsDg+1k2lHgWUA80e9PtaEdc8kFAWKefGharqQ+PkE2nGZeQGs1etJUk15h3TIH2RpeO
 zFdg==
X-Gm-Message-State: AOJu0YzwhlmZdKOQvqsSYjwgKHEiYOd2IzqdDkMmUR+udcw88L1G1LnF
 hq5g8RVVwAQ6fd/o9zFQtO4nm3/w9UqyhNq2h1j/3ODbj1jSPQEC0yz8oY1RRpna1srQA+rzcoP
 cAbRjkQ==
X-Google-Smtp-Source: AGHT+IGO5CpFc7Oka/ybHxIMXEnRPnF/3VXZLfX+84lc9+PIRpdG6uSyhdRxxxul333EJtIgaABAew==
X-Received: by 2002:a05:6512:1250:b0:536:a4e1:5fa2 with SMTP id
 2adb3069b0e04-539ab88cec1mr2019399e87.26.1728058981712; 
 Fri, 04 Oct 2024 09:23:01 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539afec8093sm483e87.80.2024.10.04.09.22.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:23:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/8] target/mips: Declare mips_env_is_bigendian() in
 'internal.h'
Date: Fri,  4 Oct 2024 13:21:15 -0300
Message-ID: <20241004162118.84570-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

In order to re-use cpu_is_bigendian(), declare it on "internal.h"
after renaming it as mips_env_is_bigendian().

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


