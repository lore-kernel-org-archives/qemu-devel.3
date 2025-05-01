Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FB2C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLn-00010t-6b; Thu, 01 May 2025 17:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLU-0000m5-5b
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:28 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLS-0001Sx-GM
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:27 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30820167b47so1484239a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134484; x=1746739284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbjZFCK/gmi9dPEqR55ppH6qHZIOZcKl/Zq5hVKpWF4=;
 b=uxXoZ1/bV+RjMQFjbDwbbsonY5EdebY6Km5D1o44RDNZGv70iXxz6uKXaDrLIQiSjT
 An47H0wkdW/ZZ/Kn+cT2ZcdRHyMzHzwpx4BBNJeTcqRflq+jZ8zyIYGE2qDzKZPOL1u/
 knYMFcVDhNLlf0ZkeZShqG5LiJW8M1xFUH+Nu7yjq3/JQfIOFyrgib4BQWe/FemZtwzA
 EnaKkqc3OlA6FZLrIpcFPvIToFvxWQpVD65FwfJvhlXtonS9hqhnKv9x8iZIHtkPbKGF
 szoV/VqTyRQGA/YL48XLbij//MuP1vjj7LBtzmr24zbADPYr3QB5HrSqf/Wthhek8DZD
 rYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134484; x=1746739284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbjZFCK/gmi9dPEqR55ppH6qHZIOZcKl/Zq5hVKpWF4=;
 b=aF7XgEpwx3xUCBtcGE/vn0EU6IHDqzMeza0vcxhnVV7b6QklGp/8l796nVvpPhDN8z
 pJTueBiYpMRQbjhuNONEuHsZwUbmKWB+MPxWF2GjQGu2sVulZ/aXGwVKCqqDCD8sGmcs
 uA3i5o3d95nULSKvpRc462QwkHelwl6f9OdQMtjnaV8u/DPUatx/rh5SElnk4cpBKuQ/
 5dLDJP1tt6jQO/T5ENIZhgn7B3lXSdL2Mv4zmhCOQIpIMLvtmj0dA2RY7auFTs6oGPR4
 vThJCnW+qoYuuzg0qPhdRiuzsKyV0MirEUaH96WnB4EffSJRzaZ/m3bYBwdRLEyQ8asd
 kZPQ==
X-Gm-Message-State: AOJu0Yxn5Gj8Vl35TXZLs94J2xSKLu5l+44S2P21zPrlLx7aAZ0D8ffc
 R1M1wcPNPIvktF31C9fK2hLOZ1oIkurAfE1E0HDVeu0inyG8BpRrac0snqxwZvY++tSBE0Md8Kf
 R
X-Gm-Gg: ASbGnctePDPMn3bcgT3BBNs2iPWJUG1Du/ZUb8co9yxvtH9mdb7c3kPU6F8mvQJlFbH
 QxTzg7k3C2nU2ABCHkkLs2GN98NS47GyIfX4cIojSeGgP5wv1Owq1yMSSRgNgo4OoPIp/XUgR/m
 Xri8i2my4fDoTtcUZJThj5pHwiBalJS8NSPSn0l68bwVlF7QPZCXp2Di0NNe0imRHvRc1lKwJ3O
 +n9oJOMR8dYehz8u8++IZX3QpSkpT0bVa/War4koFOjnqjY9dG53LY1yDmJv0p0LTpuSGte5Mfd
 nHPHt9THnC2c+YCRfCqduEuOZ4mEnQw/vHkzbIAYyt/29CBpQW7RA1bK6AWf1PGMwq1w38Snfwk
 =
X-Google-Smtp-Source: AGHT+IHVI8aPRb9tSzqA4M5SSBAWxNK8LoNJH6j4aA4SewvF4UsUT270yPZis8gKbOw3k0tweQksUw==
X-Received: by 2002:a17:90b:51c6:b0:2ee:9661:eafb with SMTP id
 98e67ed59e1d1-30a4e228462mr986174a91.12.1746134483949; 
 Thu, 01 May 2025 14:21:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/59] accel/tcg: Reduce scope of tb_phys_invalidate,
 tb_set_jmp_target
Date: Thu,  1 May 2025 14:20:25 -0700
Message-ID: <20250501212113.2961531-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Move the declarations of these functions out of exec/exec-all.h
to accel/tcg/internal-common.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 3 +++
 include/exec/exec-all.h     | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 573e8438c3..98c702422f 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -137,4 +137,7 @@ void page_table_config_init(void);
 G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 #endif /* CONFIG_USER_ONLY */
 
+void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
+void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bee3416e7e..24383b6aba 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -121,10 +121,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 #endif /* CONFIG_TCG */
 
 /* TranslationBlock invalidate API */
-void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
                               tb_page_addr_t last);
-void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
 #if !defined(CONFIG_USER_ONLY)
 
-- 
2.43.0


