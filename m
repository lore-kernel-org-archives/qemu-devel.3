Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662B2CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6x7a-0003Zt-95; Thu, 09 Oct 2025 16:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7X-0003YW-5c
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:20:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6x7T-0007Y9-W7
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:20:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so14155825e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760041209; x=1760646009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cz9eJ7l65uvp3HvDZSjhvUhN2k1gW4KljY+HIgDhJY=;
 b=deZzpWKsl1ycVhOwFzSl7dfxjUJuycDW80uI4ZgrOeL+hmakMo46CeX+52wNJzDL1R
 FkAUrslKhHV38i5WFgNWi933f2zcFnl5BILwQMfuOktCryOLlXUTkf5VxTCvPqTue8h/
 QjiyfryMbUFST46vrsyEsROxMcEQvpvEolkC2PkNhRJ9qoAR3wcnPgViCAR6Woi0N6x6
 f7uxEB+dwJaso+gUWcZwIN+vkMYOJVYXhpqXvsDX/IpTkmdycY/CnrZEU1QpYA1qfUz1
 Tty7ptB5PraV0v41u0v5q0wc5IDY+t9MWSZKYVj/YDweytg7nzpFtsPx83Yu0l8Lo4Y+
 6ufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760041209; x=1760646009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cz9eJ7l65uvp3HvDZSjhvUhN2k1gW4KljY+HIgDhJY=;
 b=J3Hp286qt3YPQ7lRi/DIJvywTrRNGz+0zDsvx0Bbw+TmmLDrZBadNmEopgbdh7O8Um
 gwMZPCfvDaYSSbEPwfL9NUlaTO16SPr7hH6qkRzA2hJRIdPrV6nNIfE9EDc7G2w81Yiv
 BEMUHoVgpx6KgGK4eaRcXQINqUcfMOe2d7j2YaGd7PHuthWA+cNmZzcQA7AYUPvELzG6
 ZhipPPkRHx8XYtn8k5Bg8N7MhHl0w4lxPmX5wT8ca7RofF6i1wSsUGMIWJgdKxlwub1K
 bteS8e/LmwbwLWAapDEwsAOlUsZhlyfwGYW6h3c5c3YA50dnx0ENoKJy3M/Tu9nFM5ES
 ALVg==
X-Gm-Message-State: AOJu0YyFC9lvFD7fnHTQvMJ2zt+zFUAhs3XPAIer9Yh0oyfCIz8+x6zI
 MQFDrVV8SWLq456rJsa6wiskQYl1CjKBAM94HY7pDna+lG4szkUN4gcfxKSE3YrT6SVm5VIqIwm
 L1F58DaNKvw==
X-Gm-Gg: ASbGncvXwo5xQCj4uByzhyX4CbfQtaKbN1aMOz2aEcpSx/cyfY9bPstQk0bqkRJCslj
 32R1bIis9yUN0YTUZz2wzlo6GVyZenExTCch0LiXQDoiE7UINLa9AIDZNaTa3yg3snHrc+AqVBi
 4VtCOYF9viGWjBfmh2oqMkpMbF3se4UuP8cGH330LxQvbqIS936KzjXlQVtzvBip/kqiaAvYDFt
 VDPSBmxrbG0l51qOnLLHaqVYPm50yogXh7hrsMUrA/RPu67znGZM8qxOJesbKJSnrQExJWF3y8a
 WQtaTmsfJc/yVgJrj7vqtyP2OnC/rVCQ9bhHDMFRnXoHVI6fLWDV3CZX/ODY+uDGiZNMMSqE5HM
 Ow/M5ir+P8fr7l+HGjBBTrMjNUClSVvubKkHw1x1zqbG+3H2rWcXeC+/M2Nxv0dhRUafbD/CaEX
 KhzOq7nbu9ccGOQn/50vaSYyZAdBlHW02KK6k=
X-Google-Smtp-Source: AGHT+IFUesgI7GDjCnuL0BiZb1a3C5n1efEHafTBJ+tIxi0rY1j3ydydGaP2Y5k+K+IRb83leSOYyA==
X-Received: by 2002:a5d:64c3:0:b0:3fa:2316:c21 with SMTP id
 ffacd0b85a97d-42669895abbmr5733212f8f.17.1760041208841; 
 Thu, 09 Oct 2025 13:20:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab36a773sm45958475e9.0.2025.10.09.13.20.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 13:20:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] target/loongarch: Do not use target_ulong type for LDDIR
 level
Date: Thu,  9 Oct 2025 22:19:46 +0200
Message-ID: <20251009201947.34643-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009201947.34643-1-philmd@linaro.org>
References: <20251009201947.34643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The LDDIR level page table is a 5-bit immediate. Using the
uint32_t type for it is sufficient. Avoid the target_ulong type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu-mmu.h                             | 2 +-
 target/loongarch/tcg/helper.h                          | 2 +-
 target/loongarch/cpu_helper.c                          | 2 +-
 target/loongarch/tcg/tlb_helper.c                      | 4 ++--
 target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 0068d22efcb..dbc69c7c0f2 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -34,7 +34,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                               uint64_t *dir_width, target_ulong level);
+                        uint64_t *dir_width, unsigned int level);
 hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index db57dbfc167..7e508c5a7b9 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -129,7 +129,7 @@ DEF_HELPER_2(invtlb_all_asid, void, env, tl)
 DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
 DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
 
-DEF_HELPER_4(lddir, tl, env, tl, tl, i32)
+DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
 DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
 DEF_HELPER_1(ertn, void, env)
 DEF_HELPER_1(idle, void, env)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4a9db3ea4c1..867e7c88670 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -17,7 +17,7 @@
 #include "tcg/tcg_loongarch.h"
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                        uint64_t *dir_width, target_ulong level)
+                        uint64_t *dir_width, unsigned int level)
 {
     switch (level) {
     case 1:
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8cfce48a297..f85b68fa53d 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -595,7 +595,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 }
 
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
-                          target_ulong level, uint32_t mem_idx)
+                          uint32_t level, uint32_t mem_idx)
 {
     CPUState *cs = env_cpu(env);
     target_ulong badvaddr, index, phys;
@@ -603,7 +603,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
 
     if (unlikely((level == 0) || (level > 4))) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "Attepted LDDIR with level %"PRId64"\n", level);
+                      "Attepted LDDIR with level %u\n", level);
         return base;
     }
 
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index a407ab51b74..64e53a44606 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -380,7 +380,7 @@ static bool trans_lddir(DisasContext *ctx, arg_lddir *a)
     if (check_plv(ctx)) {
         return false;
     }
-    gen_helper_lddir(dest, tcg_env, src, tcg_constant_tl(a->imm), mem_idx);
+    gen_helper_lddir(dest, tcg_env, src, tcg_constant_i32(a->imm), mem_idx);
     return true;
 }
 
-- 
2.51.0


