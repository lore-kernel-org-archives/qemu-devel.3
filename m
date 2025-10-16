Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B5ACCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MvP-0007dc-QT; Thu, 16 Oct 2025 08:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mv3-0007QF-WA
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mut-0008J5-Lp
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso5574695e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617029; x=1761221829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IBmYgEsYRvfTLrhOyr4LiF1xAENNtWX+Ej8GtHd5E1I=;
 b=doDww7e34noTSy5B4LKTOxb6vSPE4+lzuKVOkF4CFLmZqzAuCwdsvrHLkdX0hL1I41
 9KMvt0xg4Aa40M7z1Lro+5YQF8X0UXvJqIV9aw+eIvd59SuX7/onnTfAzltwoMNYYWT2
 AFUjcZC3uD3wD1uwEwptFtQQ30/Z/vasYUiVWh/qPXBmkhYJIQhKsBnzupmGbvuNwX5P
 uTPzQ/c9EZ6SrnF9WxXAuLUh387Mwv1u1lb4V7037GwmO2sgbCRQYHJspawLcb39R9ZI
 +w5wpQZlEC2C2kFKTbx2R4bfkT+xUf/0JnGED4o91MHbyM4KB15unLfroS02M8ckopVv
 47AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617029; x=1761221829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBmYgEsYRvfTLrhOyr4LiF1xAENNtWX+Ej8GtHd5E1I=;
 b=hRgpRVfdY/v79gid/iWIf8Air+QHRHlpOfkpfBQrALTxKKSngo7RPZ7JgJWTWZ6hVr
 Wd1c4dSv0u/PCAepcMYZnjYf67GPAfdQGgLHTdT/iPixjOkKPDpdqB1lza3FcEl1y6lO
 6HFivLntIcBOgbbEx6tPFJdVBdbBUG0f5aqLEMGUUt76bRDVvF1+t1Niz7+NrRVgP768
 3HU/EGKo2raEiDIKBrl1D9PnSOCQm1+kEWz9LpvKxnJx3sxq+L8VMplYZ8XL1Toykyc2
 npAdHn1V7g/BRSW8FHNQ0x6rFHQtktNLEq8VZzBbVXF8KRkcFrp41QleVNcRG3v4SJvF
 672w==
X-Gm-Message-State: AOJu0YxmYd31ZnPaWoGPIIcK8Z6fPORw9cQB4KcS7ggXf+uoUJa2hbS2
 G16VxDvTHgKWWdsahCeN1ont2fRKEHum5k4/2nF5eZVkSW4dhAKdXlsOAy2pmg8Y9AyrLRebIsG
 45B0EppI=
X-Gm-Gg: ASbGncudQBc8VxikHdJE7V+fha59ZtW+2ZEYXnnKRTZUhpyaF7Ocsw1jabWQBEWrXxn
 vCZFNvM908H0219ldZEt5hFpBqh+H6469JpRh/9QOWgY2ZjMPvhxaV3R2bV4AZopXWHe43soQQs
 D61U4wluXsBaomZW841EAimG2sXtKl5jrhfGxjd6sAa7LZCcMWeH+eh1W5keFmzqbexARmKPEKP
 D8fBBORM1PcswomlAl+jRhrZoKHh91tAnNUiPBs8cc+JY+QbPyHjdVzPpfkgVTh5RzaqzW0Y976
 I2CFChtJrJ/xSU9g0/5vcrkhSkuoLxcd6JC93VwX960GlPJTCH9wPzl28wECR2o3pos2Uaf8826
 sOt+OPLLkQ8S7rGSbfRp15asLL/GW5c1B17Tgj/hvvaK0GLti+V69PtKTl2avbT+gMYgzhZIqDD
 Qu3jQwvAXQsr6Of8fIvGxxXZxoot0s424MsyfVqi7m2UsLvEYrevqMsvF5quVR7Xl9PGH55+CQ9
 jg=
X-Google-Smtp-Source: AGHT+IHCAdJ7wEh4olq/JPUIxNa6kvLpzJvQ6TGXw14ley2s5gN9TneNij/PR29t69UHsUA8ZL98nA==
X-Received: by 2002:a05:600c:3f1b:b0:46e:1a14:a81b with SMTP id
 5b1f17b1804b1-46fa9b17e09mr220913785e9.36.1760617028856; 
 Thu, 16 Oct 2025 05:17:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f66dsm23678705e9.2.2025.10.16.05.17.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/75] target/microblaze: Remove target_ulong use in
 cpu_handle_mmu_fault()
Date: Thu, 16 Oct 2025 14:14:36 +0200
Message-ID: <20251016121532.14042-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

cpu_handle_mmu_fault() -- renamed in commit f429d607c71 -- expects
a vaddr type for its address argument since commit 7510454e3e7
("cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251015180115.97493-2-philmd@linaro.org>
---
 target/microblaze/mmu.h | 2 +-
 target/microblaze/mmu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 1068bd2d52b..2aca39c923b 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -86,7 +86,7 @@ typedef struct {
 } MicroBlazeMMULookup;
 
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx);
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
 void mmu_init(MicroBlazeMMU *mmu);
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 8703ff5c657..db24cb399ce 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -78,7 +78,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx)
 {
     MicroBlazeMMU *mmu = &cpu->env.mmu;
     unsigned int i, hit = 0;
@@ -172,7 +172,7 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
     }
 done:
     qemu_log_mask(CPU_LOG_MMU,
-                  "MMU vaddr=0x" TARGET_FMT_lx
+                  "MMU vaddr=0x%" VADDR_PRIx
                   " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
                   vaddr, rw, tlb_wr, tlb_ex, hit);
     return hit;
-- 
2.51.0


