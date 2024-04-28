Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E952C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cpg-0002PO-Hh; Sun, 28 Apr 2024 18:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpY-00021p-62
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpJ-0005l0-Gf
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a58e787130fso205008966b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342612; x=1714947412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2r4cMzC8fAIXHZrDpn9ChefhEHuCDQQD/B5vfBV0XzY=;
 b=cTtwYmhe6kS3kdz/zzUQk8QxI00CKNbgYLhHf8Yk1kA+4lSdGUPGjv7NL5QiUxBBbx
 1WzPhJuOzayVoRfmJx1/Eslzq+S/KilZIsxEoWA1bsUgiT3C1sFtDvUAQRwjzRQrUX1A
 Skm5dMfbBuYHnCD6CbS8wKKD/Heg5U37hGqeT0A39oHq558iXsiekxX92+9dQzZiod0O
 DKczK4DRKwyoFzNFLBNvNa8fwpXGAQyyCWrxJxlxxZ3130C9WE2nHnqmZGAnD8yY5HXg
 G7/hfDWpKD7XzBhQDyUU20Yxi4QqEKmHzzaRBV4PR8K5mev+V7Zy0iaC/5eO3dgwzDO9
 /trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342612; x=1714947412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2r4cMzC8fAIXHZrDpn9ChefhEHuCDQQD/B5vfBV0XzY=;
 b=SP2ItJGANIC43TbcF/LxI1/7qUz6iu+SMXzzDM8XUtTRIbMD64phftjNwEYrOOYfOi
 NIIXEnaf25yQFV8nEaxbnXyeU3LeowJHnjv2O5auKufga1vTVzOaH47xreOENfVV5K7L
 ztT7hz+ttvjZIrwcMX/hCX/hREmtmtH34f6r66U+nnx4K2nzASBnV7y8ZxLhfbiqdI6x
 j7dsRwgLHKvpOPLVLCR2d9vcEZGwkAA/pd8ELcKtex3key/AYZGMPFMfUz9Zapsu/XBW
 CBfrqnSl1rl6jY7GHosnKs6raeJYSRxXWjlG6NqJ7opjknBH7BExqI4gig2xKAyFeM5F
 uq8Q==
X-Gm-Message-State: AOJu0Yz6eyjRT/v6s0gAjC3bEWGqlnJ0MtH4LVsHKRkg1fL7rwCdp1UR
 j9HhJImujKap71i6Ab02z0i00K2aeAjOUBdMvfVS6VJn8KziweELGwTDFFw7/K+Vtc/Obk++WwG
 K
X-Google-Smtp-Source: AGHT+IEr9szIMogTyXzEktEyerfgIs0gWWFrRGI6sLwAdZV5HwqCOEgHOzl3euPwk+3nGlIdFramBA==
X-Received: by 2002:a17:907:a49:b0:a58:c550:a102 with SMTP id
 be9-20020a1709070a4900b00a58c550a102mr9594611ejc.29.1714342611791; 
 Sun, 28 Apr 2024 15:16:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 gr13-20020a170906e2cd00b00a4e696e613esm7984526ejb.153.2024.04.28.15.16.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 22/24] accel/tcg: Move @tcg_cflags from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:48 +0200
Message-ID: <20240428221450.26460-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

@tcg_cflags is specific to TCG accelerator, move it to
its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h | 2 ++
 include/hw/core/cpu.h  | 4 +---
 accel/tcg/cpu-exec.c   | 6 +++---
 linux-user/main.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 5b31c801d8..1cdca0e0d4 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -11,9 +11,11 @@
 
 /**
  * AccelCPUState:
+ * @cflags: Pre-computed cflags for this cpu.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  */
 struct AccelCPUState {
+    uint32_t cflags;
     uint32_t cflags_next_tb;
 
     sigjmp_buf jmp_env;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 99709270fa..f6bafa090a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -396,9 +396,8 @@ struct qemu_work_item;
  *   to a cluster this will be UNASSIGNED_CLUSTER_INDEX; otherwise it will
  *   be the same as the cluster-id property of the CPU object's TYPE_CPU_CLUSTER
  *   QOM parent.
- *   Under TCG this value is propagated to @tcg_cflags.
+ *   Under TCG this value is propagated to @accel->cflags.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
- * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU core.
  * @running: #true if CPU is currently running (lockless).
@@ -515,7 +514,6 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
-    uint32_t tcg_cflags;
     uint32_t halted;
     int32_t exception_index;
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8f8e1fa948..84fd041aec 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -149,17 +149,17 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 
 bool tcg_cflags_has(CPUState *cpu, uint32_t flags)
 {
-    return cpu->tcg_cflags & flags;
+    return cpu->accel->cflags & flags;
 }
 
 void tcg_cflags_set(CPUState *cpu, uint32_t flags)
 {
-    cpu->tcg_cflags |= flags;
+    cpu->accel->cflags |= flags;
 }
 
 uint32_t curr_cflags(CPUState *cpu)
 {
-    uint32_t cflags = cpu->tcg_cflags;
+    uint32_t cflags = cpu->accel->cflags;
 
     /*
      * Record gdb single-step.  We should be exiting the TB by raising
diff --git a/linux-user/main.c b/linux-user/main.c
index 5f7f03f4b0..8be06627da 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -241,7 +241,7 @@ CPUArchState *cpu_copy(CPUArchState *env)
     /* Reset non arch specific state */
     cpu_reset(new_cpu);
 
-    new_cpu->tcg_cflags = cpu->tcg_cflags;
+    new_cpu->accel->cflags = cpu->accel->cflags;
     memcpy(new_env, env, sizeof(CPUArchState));
 #if defined(TARGET_I386) || defined(TARGET_X86_64)
     new_env->gdt.base = target_mmap(0, sizeof(uint64_t) * TARGET_GDT_ENTRIES,
-- 
2.41.0


