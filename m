Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45179C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 22:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEy8-0005pt-Hx; Wed, 30 Jul 2025 18:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwX-0001Ju-D2
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEwT-0002aP-6E
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 18:06:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so363996b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753913191; x=1754517991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biby8AEWdDyhxbx/eUBt+4KP1PI/+4PwOX0JKhuZlPM=;
 b=eW+2I579FMM+j5DOEI2f9OI8A+NcJBcoUibr9MCacwCXrCvxSGKhub3fCH0opkJF9b
 fcBQxxG7kQ6w2HXGcTLjnpMalWQa2208dorkyNEI/PCWvZdgVELmGn1IWsOvPma6qxjE
 CMKI9d/WS2kb3VxQhRu5iavKNs7+huOu9S1svETF3Pla1yphumLYoHklMJUogbMTubyH
 HSq6W1RqmbDxiPghMm2KrwmsFeXyvCWhMsxdF5MPgL77el2R3fCnQxmEfiHs/0cNMlyi
 jEFczL2I8MrH7RcAQPJvGH52wQ5prs0r9Y/FA4qPmT4fTR9wjswvpuEzX5jPKE3qCNRt
 cGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753913191; x=1754517991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biby8AEWdDyhxbx/eUBt+4KP1PI/+4PwOX0JKhuZlPM=;
 b=ZITZEKZ7XgCCS30RUEwMC21KB/XMpkm8bsx9/GY8E9YOSi37eSXNIPnhUlPVF5xZ7j
 LISyAVQxKaYH1RLy8gu3vr+A9aFDO2axdtYNpreJ13xOWvWuiNasmlFI0chkYJKnkJom
 v5Lbej5S5msWue2jNi9N/YpQGKSJNmtAA55+c1sak9IOiR4iVIUCm9NM8mci0XmM0PEv
 PbfyOtuP7r7lUOnTnb+d7ydd8wQKKo/Bd2QLBWUmb9y60C1wEZdTsO/YTVp6X9KTrVn8
 Tny2HtdbqC4nU+6cOgSHboi2hPJziq0f3WSezFSSnyteCzmJ4j83X7hbugcMHMzKFZLV
 X2tg==
X-Gm-Message-State: AOJu0YxSdR4Yw/yxxHWPoGP4bdBsl/XteAQRHXHH8pgDlKFuBodi4Pcs
 0WnFEGm1mhg3wPD/yMsyWmY5zEHnYUiSYx3LOuH/1KyMjgcbKlKRFlkReSISV68LLsmPc9s4JHk
 D07GB
X-Gm-Gg: ASbGncvde7MCVbMRo8XK4xyJ+JTEanrR96CIHvkYVBS8giM9x9SkMCpiCKNBlEVdYDy
 P1FOYFgITXiCYBcgadHmxatlGFMho34+6oJCMKQkVvwwvW2mr1pEa7T6D2l176rtIJLInBrx3SW
 tw/Bnk88hFd7hXRFwEzFAUtWjL5CWptxccTLcNBxgqCvFy3h7COU6z80yGZ/5TWvI6SaBZCHkFl
 nbA6Xw0/6KSPNKSM5ORkY1rn7BO5pxgQIbQ6IExu26g4KB1Z58+z809D06uBNlS/kDWB1EBGeY+
 jcf9r5yubGWCxl1bP3JDAn85hM1egwHDleJn4mxNtlXdHByGbnMThSrKh89W8Z9gdY0wwmnV0dS
 5XQZ1Li9alcG2UC+3p51GNQ==
X-Google-Smtp-Source: AGHT+IEvPQWR7zgJn+Oqwe0BOueSXe0I1iEQVZkV1WjRy6zEa1UnnxsrRmmLGbKfCx8r3ACqjle2Xw==
X-Received: by 2002:a17:903:291:b0:234:df51:d16c with SMTP id
 d9443c01a7336-24096b79730mr74246705ad.45.1753913190826; 
 Wed, 30 Jul 2025 15:06:30 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d272sm981535ad.135.2025.07.30.15.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 15:06:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 03/10] semihosting/arm-compat-semi: remove
 common_semi_sys_exit_extended
Date: Wed, 30 Jul 2025 15:06:14 -0700
Message-ID: <20250730220621.1142496-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

This allows to get rid of sizeof(target_ulong) for riscv, without
changing the semantic.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/common-semi-target.h   | 5 -----
 target/riscv/common-semi-target.h | 5 -----
 semihosting/arm-compat-semi.c     | 4 +++-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index da51f2d7f54..7ebd2136d93 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -34,11 +34,6 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     }
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
-{
-    return nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cpu_env(cs));
-}
-
 static inline bool is_64bit_semihosting(CPUArchState *env)
 {
     return is_a64(env);
diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index 7c8a59e0cc3..63bbcd2d5fa 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -25,11 +25,6 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     env->gpr[xA0] = ret;
 }
 
-static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
-{
-    return (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 8);
-}
-
 static inline bool is_64bit_semihosting(CPUArchState *env)
 {
     return riscv_cpu_mxl(env) != MXL_RV32;
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 33614108094..1a3abd45c5b 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -755,7 +755,9 @@ void do_common_semihosting(CPUState *cs)
     {
         uint32_t ret;
 
-        if (common_semi_sys_exit_extended(cs, nr)) {
+        bool extended = (nr == TARGET_SYS_EXIT_EXTENDED ||
+                         is_64bit_semihosting(cpu_env(cs)));
+        if (extended) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
-- 
2.47.2


