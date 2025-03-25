Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A41C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6PA-0003rT-AT; Tue, 25 Mar 2025 11:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6P7-0003qm-3v
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6P3-00047w-P3
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so53879235e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917280; x=1743522080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLYIE82ADpP9MMv3tzyn92JCIJn6rh3Qqe+NEpTBgls=;
 b=mLzcgHjimvDBBfsB8XrcP7/rupcg1tde2k/DjvMh7/813fK188SYe5uYQbLiQr1w9b
 rGlbPyH4/DbtdYP5ohbrvSMdy0JBpmjFyOxqXly0EftIl1iGvr8eVSpiWn66xrdT/LSB
 o+LI1/3T65HyejSLumjhT8/XdEX5jgpaA8TIsHitG+dfaJOnM7oeOjbqy8QVVaBTgMF5
 mVNwM0bJmY3stFszSJFMwioBcMRUhwiJzUpcO4GqkmSFcOXT2w1hnDTiubdfT5fiasPN
 N4takroXKdZRk6KQ4GJoE2AhRLvvwIhDMzFfxS8qJA8RdQzaqphXr9JDdwFg6qJdbLxM
 tLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917280; x=1743522080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLYIE82ADpP9MMv3tzyn92JCIJn6rh3Qqe+NEpTBgls=;
 b=w+3654M6sF7AI/JkqDINTzQzMa92AyVYpH8vH2VLb6YoqUz9YD1OjCGvLOQMci0dvL
 R103H53qJPGjSDthhEzPALvM7KieRdQbM2hNZEVd5vvbhch851nZTvNkDogqPxrJhYOB
 A2t1olus+5mNizPqQru600W5zigLIjTKDGOS1VvZbRre8bkxSfUoHGR3Zo+Lu76RiDBk
 SBWJpSWcAMBZBNNL89P8t+LnIg0e9xkTbzHbNyACtvwu5NTeB97bUrv+Y1ObyL01ImtF
 umZQdRIlIbRBLiGwowg8/zYBbQRg7P9nSe74eBYdguyt9tqnlCcTDOl8LnTVugRJRFVw
 +lrA==
X-Gm-Message-State: AOJu0Yw3HhjiYZ2KtqtXiwXPm/I22y3+zmgekSOUWnVUIyg9X+5EG4xI
 rPGgkaaiZj0W6GB3Vfr4KE7n8zXvdXS497YXKmDBixwz1qOlkaZRH8MKZJkXieS8T4PbTBDT0KU
 r
X-Gm-Gg: ASbGncvYbG3Q0oFGEjVKtuvvxx5idEqfSirzj3YaAsRI//CfrBAbmBLuKE4G27fWp0h
 9CMyGjd5yb/DG1EQ88z37tXVHZJg2MkBA+VSmLf/B4Tm0IztwhBztMigOuGz2Aby6CMgGu63LHw
 JwBq5BEyn4Fr0/shNXDvCuEC2yBOdJjVmI5vmG/JIgDxSkDrVhIwffLG+dAnPwZl0S+X8cscSxg
 ZQ5akYQWQ7EqcGwImMq7eBGE/onEd04RftUXAytN1D1fol1OVbDl/bNk75M7Ir9ycTt2/KZsfqI
 bKM8tdzcj7kJt+2XiTk97NFPUyEvCdw5m7CDEc8t8hBbW2MbJL87KnV8nOkNvB6Db2+ZHrzhFxE
 4zC00RA22DRZSBqNJTwTg71uj+JrZJA==
X-Google-Smtp-Source: AGHT+IGSHgYzV8FIt/jQwdeaOtOswtV83eIQS4NoWVpi1HUv8C8xKZUmmLo5OqkIJB7OBDDUqywmQA==
X-Received: by 2002:a05:600c:3c9e:b0:439:9424:1b70 with SMTP id
 5b1f17b1804b1-43d50a4f8camr173393095e9.30.1742917279777; 
 Tue, 25 Mar 2025 08:41:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9ef098sm13767225f8f.84.2025.03.25.08.41.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 4/8] target/mips: Prefix MMU API with 'mips_'
Date: Tue, 25 Mar 2025 16:40:54 +0100
Message-ID: <20250325154058.92735-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

MIPS MMU API declared in tcg-internal.h has public linkage.
In order to avoid name clashing with other targets, prefix
the API with 'mips_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/tcg-internal.h      | 2 +-
 target/mips/cpu.c                   | 2 +-
 target/mips/tcg/system/tlb_helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 74fc1309a71..a8bf2a5da40 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -45,7 +45,7 @@ void do_raise_exception(CPUMIPSState *env,
 void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
-void mmu_init(CPUMIPSState *env, const mips_def_t *def);
+void mips_mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
 void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 5ed6b3402d3..d8930468b7d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -485,7 +485,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     env->exception_base = (int32_t)0xBFC00000;
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    mmu_init(env, env->cpu_model);
+    mips_mmu_init(env, env->cpu_model);
 #endif
     fpu_init(env, env->cpu_model);
     mvp_init(env);
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index ca4d6b27bc9..1ef2c32cfd4 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -466,7 +466,7 @@ static void r4k_mmu_init(CPUMIPSState *env, const mips_def_t *def)
     env->tlb->helper_tlbinvf = r4k_helper_tlbinvf;
 }
 
-void mmu_init(CPUMIPSState *env, const mips_def_t *def)
+void mips_mmu_init(CPUMIPSState *env, const mips_def_t *def)
 {
     env->tlb = g_malloc0(sizeof(CPUMIPSTLBContext));
 
-- 
2.47.1


