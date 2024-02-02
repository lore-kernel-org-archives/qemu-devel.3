Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E14C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmRv-00014K-5e; Fri, 02 Feb 2024 00:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRt-00012n-QO
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:49 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRs-0001bf-Co
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:49 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6de2735151cso1229867b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853047; x=1707457847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ih9kNFtuKNhrUdysAgLO3jiT9TTjcwOFp1g4b3mJWUA=;
 b=QgTHM0Vpf1nqXtlqGFg5C7e4Br9r1TKRpZOw9aXUsKNrai2KIVbkEFgsuPAS68soK0
 7p0wlEEWUObisjPvHWkwhe7+AS1bCSxHjwZGSDwW3Kgdz+KDpfwjbFcXP6/9kWnyVBWb
 2DQwMLyG5OT40aBxZ45MxHXR9CYIxsK2SnqmZLX11SQn8DyouDJ8Z5TDZo1KFM5u3oT8
 4bKcTesW5WneG0e+Dtx4DtAzhtgqObHas4eSs0BlZ5PTwY8BCLFO+4n4Pvz/M7hmqpt7
 rEGKyCVKwn/Iwjh5FYes0ckMDXobWEPInET5C6I8gHj5SygyARYoxIFLro44n2EbHsVt
 5NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853047; x=1707457847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ih9kNFtuKNhrUdysAgLO3jiT9TTjcwOFp1g4b3mJWUA=;
 b=Q+72sb3ojkyei69D85Wep8zKL20nuNrwGKdWJAOXytN8kv5II0jb3j2Z3wLXYIrNNs
 dqEXWToXgifZ3/LLagor8yYQuudYpDUMPVyc6+9XS8eJlzSYjgzr89nXXfMcxgAv9PCa
 LxUKzVyhNi2WTjukU1ZZ6f6NuAXOGf8nhy1LnCBqqxwYDYdj7G3Q1oq2eZ9IHSn1h6is
 haqR7/LzNoOlIRlT+sMXkbRFBG3j1w0rHhjTipOhPjCtlHVBIJBuKKZThaWpW63VUcXh
 zjwtAGkV/7P8lzuFyManh3LStf2iOyvw2RlP+7pwRQbQ7OMIrpDTvWsZJD8Zlw7QOnEA
 h1+Q==
X-Gm-Message-State: AOJu0YyDB9Sb7fQZqU8kMfz/h4UgqeJfGelj/5/lWGr7pTN1P7DNn+Zf
 KAA/drOOpXHHwgQFuY90PXJjYA/8jxelSUjMReeU7r8+xXMc3hlYLRtb+1sDJRWEpIGdTKMGODu
 neAw=
X-Google-Smtp-Source: AGHT+IE76fgrLlqvPpz21UuQ/1qw55eyXaHWy7qxfQ78uUHMw6z/hAHi2P1wjaeLZbBlbGpQDlS/Sw==
X-Received: by 2002:a05:6a00:1407:b0:6df:f634:4f83 with SMTP id
 l7-20020a056a00140700b006dff6344f83mr1776559pfu.2.1706853046932; 
 Thu, 01 Feb 2024 21:50:46 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/57] target/alpha: Split out alpha_env_mmu_index
Date: Fri,  2 Feb 2024 15:49:41 +1000
Message-Id: <20240202055036.684176-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h       | 7 ++++++-
 target/alpha/translate.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index ce806587ca..3beff2738a 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -389,7 +389,7 @@ enum {
 
 #define TB_FLAG_UNALIGN       (1u << 1)
 
-static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
+static inline int alpha_env_mmu_index(CPUAlphaState *env)
 {
     int ret = env->flags & ENV_FLAG_PS_USER ? MMU_USER_IDX : MMU_KERNEL_IDX;
     if (env->flags & ENV_FLAG_PAL_MODE) {
@@ -398,6 +398,11 @@ static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
     return ret;
 }
 
+static inline int cpu_mmu_index(CPUAlphaState *env, bool ifetch)
+{
+    return alpha_env_mmu_index(env);
+}
+
 enum {
     IR_V0   = 0,
     IR_T0   = 1,
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 134eb7225b..4b464f8651 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2875,7 +2875,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     int64_t bound;
 
     ctx->tbflags = ctx->base.tb->flags;
-    ctx->mem_idx = cpu_mmu_index(env, false);
+    ctx->mem_idx = alpha_env_mmu_index(env);
     ctx->implver = env->implver;
     ctx->amask = env->amask;
 
-- 
2.34.1


