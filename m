Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30155C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6H-0005uj-CB; Mon, 29 Jan 2024 18:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6E-0005sM-Ns
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:34 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6D-00056h-1f
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:34 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d76671e5a4so24152605ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571091; x=1707175891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeckyFuoEvdgwHDKZRRirlX+WDs+LbKrZFrG7XL0TJk=;
 b=xnik9OU4u37UwQV2jLj+YnG19G2k9IPAh46scxUfAa0icHDEO5vpdue/MCjYKBSCXn
 RUM7KflzOP513Wn1gSJgGhSxE/ylNYpaf4lDIwEKVG1tDkrWhP/X8h155kWWlhVm8hwA
 +KwMHctcnMHzidDKN/eU7sbuny+Sc4L5Y0wZuoIF38QAdhrnl41XuP8lPfnz+cvKg3ko
 P6Ab8bGJQ40toNpFoOH/hxPiMdWCSw08Uyphb+wurcCJCPGBjzzgvCTtjIcCTOHNmsI5
 K2mQ7+H8NyabT0O+FVe+/ku3DQ1UGkCHspgIs4UwB8nNX74We9ebXibb4RaErsvRDfb3
 TEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571091; x=1707175891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeckyFuoEvdgwHDKZRRirlX+WDs+LbKrZFrG7XL0TJk=;
 b=FipGBuKZmN6KyHhw3EkdEAAptfyJ6qM/OBxEnTmDY18iyeaaAovGyFKwVqo7vwnY1+
 2oJ5248LSQHNgzkInDoEgUdbAtp0P+CVjdl7lMxLNWT/lCne+hZiO7PtagqcktbdZYey
 oCtCIBcWCGiMETnb0WN0gp2CXZ8KtydiCQ3WjzzLvwt1Xvqs1Qn7VUNVGCRpQWqho5Fy
 JKseqxklZzxASL+SLtmtuX9NxkwQrtesxXr6XP8DEXM854oi0OGyYDaxrmdd2vASodm2
 453ji/eAg0ywpNcWE3y/W7rTqqtBDpD9+TaYOvIZp2+KyEW0JS8MzkqQiEpJVPOePGj0
 keDA==
X-Gm-Message-State: AOJu0Yzu9fBPnVbM7fT6Nb4CDFypilLRPYxXyu4RlHTl32z2mfaQL21G
 tbjEW8v1NHDTdaz9YPfvEAGyxIzTmAHDK2u6j06wm0ukSIgdLiPxMnQmp0nIvkDd1O1PqfsoWfK
 hzqc=
X-Google-Smtp-Source: AGHT+IEcf1hxchPld14Dmkd+CXvljYK7qCOR8zD6SErI6SzjI8olt+mXscuftIKFNsYUFYzd7qXnZA==
X-Received: by 2002:a17:902:6b46:b0:1d7:5601:9fb2 with SMTP id
 g6-20020a1709026b4600b001d756019fb2mr5324087plt.21.1706571091631; 
 Mon, 29 Jan 2024 15:31:31 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 19/33] target/openrisc: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:29 +1000
Message-Id: <20240129233043.34558-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/openrisc/cpu.h | 10 ++--------
 target/openrisc/cpu.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b454014ddd..7dbed8d8be 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -361,16 +361,10 @@ static inline void cpu_get_tb_cpu_state(CPUOpenRISCState *env, vaddr *pc,
            | (env->sr & (SR_SM | SR_DME | SR_IME | SR_OVE));
 }
 
+int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch);
 static inline int cpu_mmu_index(CPUOpenRISCState *env, bool ifetch)
 {
-    int ret = MMU_NOMMU_IDX;  /* mmu is disabled */
-
-    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
-        /* The mmu is enabled; test supervisor state.  */
-        ret = env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
-    }
-
-    return ret;
+    return openrisc_cpu_mmu_index(env_cpu(env), ifetch);
 }
 
 static inline uint32_t cpu_get_sr(const CPUOpenRISCState *env)
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 477d49d4bc..8670152c84 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -68,6 +68,18 @@ static bool openrisc_cpu_has_work(CPUState *cs)
                                     CPU_INTERRUPT_TIMER);
 }
 
+int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    CPUOpenRISCState *env = cpu_env(cs);
+
+    if (env->sr & (ifetch ? SR_IME : SR_DME)) {
+        /* The mmu is enabled; test supervisor state.  */
+        return env->sr & SR_SM ? MMU_SUPERVISOR_IDX : MMU_USER_IDX;
+    }
+
+    return MMU_NOMMU_IDX;  /* mmu is disabled */
+}
+
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->print_insn = print_insn_or1k;
@@ -239,6 +251,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
+    cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
-- 
2.34.1


