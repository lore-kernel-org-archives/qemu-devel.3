Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CEEC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJK-00045t-Qf; Tue, 11 Mar 2025 09:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDw-0004zk-O4; Tue, 11 Mar 2025 09:00:49 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDt-00007a-Hp; Tue, 11 Mar 2025 09:00:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so7759815a91.2; 
 Tue, 11 Mar 2025 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698039; x=1742302839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ef5JtUmQjY3eZoVQLsqqxOztpN+e+XJ12V25TE9Pgi8=;
 b=R5K31FYExGIIdHSgoQ1uFjhDjRnvBSsRdZWjyWL3RtyBIraPc8a8igtKfRyLo6vxkE
 R7KURS+/OjPnkYOkfowOuYUJ36gaXbBs0P2R0MDDXFhF807gv/Echi0vm3+dXWa8DXhL
 CWZ4L1K9OE5SAQ8fA4dHRVIRD2zu6sNWntWIqjWhyeXIA1BxwXGs7HQojM4alYN0sEj7
 b2+rI/OskHBZ5xIhTz8EOyE1sjju5WWci78Vxm/S2RuSuRQzn3Zv2bY9ui/rB8Snifr3
 hE5le4TIT/rXpVeROnIN7Zh286GRzuIrWiQv9/p5XyE0dVwkiD/zzNI6PBALjRqpV8nY
 dliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698039; x=1742302839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ef5JtUmQjY3eZoVQLsqqxOztpN+e+XJ12V25TE9Pgi8=;
 b=snMy09y3gGb36B8cwi4YctyiZTs47mh24e8m/6MGFEsgG+oVmSrah8h0ueT8dBr2Jw
 TM8DvWo3UuB5uwSNFwBanj1f/D993ONmDoiYXbQL+t4hfLWsqvgOnsxw1lvz6lX2T419
 boebcCi7OGHkAJme45NqVOzRjcC5QemCKkuLUYflafubD6VK/npdrtBYjqWuW+zwjtH2
 9XwkBuHZ5ej+Eocsp2fSnbEEU7nRLYa+ft+1VlKUcS86Xl1sOh03tRmRDMNOfxJA/u/Q
 y9TXmeHiJaem2l884PQ9tJ1P7nItDqHVJwHqAJ9WlKfV9vBWeFgQjHj/6YmKxiMBb3hE
 Mi5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURu+umiYqh3qsAl5OugzxgVmvoXRZOS73X55rvPTZadXKCvWwSfs2qDPPam43J79F5dPuQ4sJp9A==@nongnu.org
X-Gm-Message-State: AOJu0Yw3MCPysFSy7i4CuGvWjkitcGO9XXXfbXZslOe4R+OAO2CALAr1
 Zh257XgEVy9LrzK5Lu6XpHFSbfCGYp5SI2wpFdjPykVyW90Yzz1DzLRntQ==
X-Gm-Gg: ASbGncu+TLF7Z1Kw7YJw1p6eNmyeCTe2rr9qDlXpDDM2uHG9n3MBH8bzrym3jZEVK8i
 OEbPHSv4Hc8qouDd6pUsP12OxCtl4mJJEaq9ywDT4312wWkpNy1KZ7JJV+/X4i51OEs0K1SxSC2
 +a6DDIr/KjfzyTXjpSeGF+8TZoK0ITSfBreDEzERM2qFFtfKNU/mSK13efEGaQ8X+ajg1BruWru
 H9RCH0TILPPn8xseXhbenb+bBb5z1QY/xUgGBbbK+0fejUWOUBC+QnHG60ijxTy4S5PZIf5ZBxi
 RuibenwzPcwanB/DM2w3U3Vfl/BAitxdePuXxWcwk/lB6oe4wZQ=
X-Google-Smtp-Source: AGHT+IH45hJAsbcuERTowHkzKWunADMl6tTLtwrJOii8wJU6Mh69BxSiogcqltCklb7uCL7iO4fkxw==
X-Received: by 2002:a17:90a:ec87:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-2ff7ce8fa48mr26297537a91.10.1741698038779; 
 Tue, 11 Mar 2025 06:00:38 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 43/72] target/ppc: Make ppc_ldl_code() declaration public
Date: Tue, 11 Mar 2025 22:57:37 +1000
Message-ID: <20250311125815.903177-44-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We are going to move code calling ppc_ldl_code() out of
excp_helper.c where it is defined. Expose its declaration
for few commits, until eventually making it static again
once everything is moved.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-4-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 2 +-
 target/ppc/internal.h    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fde9912230..7ed4bbec03 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -144,7 +144,7 @@ static inline bool insn_need_byteswap(CPUArchState *env)
     return !!(env->msr & ((target_ulong)1 << MSR_LE));
 }
 
-static uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr)
 {
     uint32_t insn = cpu_ldl_code(env, addr);
 
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 20fb2ec593..46db6adfcf 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -268,6 +268,8 @@ static inline void pte_invalidate(target_ulong *pte0)
 #define PTE_PTEM_MASK 0x7FFFFFBF
 #define PTE_CHECK_MASK (TARGET_PAGE_MASK | 0x7B)
 
+uint32_t ppc_ldl_code(CPUArchState *env, target_ulong addr);
+
 #ifdef CONFIG_USER_ONLY
 void ppc_cpu_record_sigsegv(CPUState *cs, vaddr addr,
                             MMUAccessType access_type,
-- 
2.47.1


