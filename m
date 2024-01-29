Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E189C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb62-0005SE-NC; Mon, 29 Jan 2024 18:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5b-0005P6-JV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:56 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5Z-000508-UW
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:30:55 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d8e7ebbbadso8416195ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571052; x=1707175852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuLjJD6Uv7AUoT7v/CmrWdMUNxFVKqK7N1yrIDiYHSI=;
 b=Mjp+ErrdOjwvT1r7yE+NwAS617+jGXodN1iq92arzoP+Dj1D144MGeJTcZc4YWirAr
 VOmXpwEdrrsHCo/n84Km2n5Zl3/k970dQEs0PAGD8FGnhnV4bz5ya7ONSdPznNNxWODc
 yJG9rO9CrRovnH8FMafz87OjC2TwXNQOAae6c7rWCBGK652lYmXAOZlvaXlNXA0m9YiY
 /Rt6F36fqaG2izT5LxTWnEcT36iDwtFiv5Nm16wjRoDB6izKkeifOIonr+dMp9/ASp1W
 K+jIEkOlHMO4nnjudx6v31zgP6Vgj4nB9gSInYnuI01YO/b5Ie5JPs+SjH7aqi000O4K
 TEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571052; x=1707175852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GuLjJD6Uv7AUoT7v/CmrWdMUNxFVKqK7N1yrIDiYHSI=;
 b=BhiPrjxSthQhEK8tIXr58yaXbp3wzZmVnbh2dBbxBIhVotM1KpiMlJ6RFHPFiddgkB
 8ItXr/s6fRdsZdVY38LlZfArHnwjH0J7rsMQ0LeeS+7OhevrcjU5/eIUtIExGuKFaGzg
 ldah/dh7ZO3aY4uaeO0GUkpkehhtYtMdVFEm302QUqhly3VXSP/JoUgw71WF4PwVKIlW
 3RjGSZw9v+fdzuB8DagsK5iJbqf1m4OxHh9aViR88Bn1P6/X9n59DsUe7Zq4e03H8E7i
 itg+Jcv3m8SWyzTpYfIr+H1rGvrvFiRxuwLMYXCE7RxExpAg4paminFAwhlUJKAmONen
 XHXA==
X-Gm-Message-State: AOJu0Ywq1L0VRtikR4oj/LhsrDGNNeccuCxQxSmZVNTT6dNyTYL1U9hM
 kEwwrs8hgfDtlUtoSrxYDjtlbP+ZpWyiM9+ahNXb3ZiDXkkNhHXGk8AQgA9r7dUQc77hk7AE6It
 ICVc=
X-Google-Smtp-Source: AGHT+IEktvo2+X+OHpoDfnI6CRxmWwjdpQaddSl7mclrMTwuxda8uAaYjYqpnDDWb3/HM698h6y/gA==
X-Received: by 2002:a17:902:bc44:b0:1d8:fe1e:7c8a with SMTP id
 t4-20020a170902bc4400b001d8fe1e7c8amr1370350plz.106.1706571052578; 
 Mon, 29 Jan 2024 15:30:52 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:30:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 02/33] target/alpha: Split out alpha_env_mmu_index
Date: Tue, 30 Jan 2024 09:30:12 +1000
Message-Id: <20240129233043.34558-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


