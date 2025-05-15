Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0CDC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVop-0007fl-M3; Thu, 15 May 2025 06:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnV-0005Ie-78
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnS-0008Ee-3h
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442ea95f738so5531175e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304795; x=1747909595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X3sKaOriNp2h2IwJgF6fYokuc0VVHT+FQQSKLvZf+Go=;
 b=h94PPpNmJgdLq6d8m3Irwdvo2W7PmxxhuE1EspynIBM86sylhckxLYAd5NbguyXH7p
 xnqA6Zsm3FmYYkWkrBb7ybFyCrxbVIXZUxhw9Lal4T9dWk138k5+f9UGwXnjMDS5B4l5
 Qhz4gA+h8JPL4qevKebZXSE5Xi9F2ag3aUuuH/kwSqPtzqZe1WExfLyDRToPNbm6TKb0
 OOZG96wYWqZtGj5+XOPRdUQKa8lyAQPBWkPCeHzKHAhwiSzC/Ho1oegh0YxffRqCLLkU
 Mtj+VZuvWx/rZD2FykoRttskKa0f0eOL2HINAs8ej7tbLgNEypGXfmvai4R6S4LJITJa
 gaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304795; x=1747909595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3sKaOriNp2h2IwJgF6fYokuc0VVHT+FQQSKLvZf+Go=;
 b=hbksqzauFYy9ExSgc0TCmhoeFwyl4e/6vfY9C4zMGUTYMpfRXme3x6o4BnoHIXISX/
 ypYFuzf3SUCLoyonvN2+HTDqlTEpujK67eQQyPQmxcaDrOENMv24HqnBXFKkelx5Q8nN
 VGkE3GpY5vgmrJKEHbbGMHnRcIL3ur1BGVYNTS3xg8SUV2nTUOsPA4SgA5IqBthjsr4L
 y6MV/HzUlqCrw1QyIgjlL3aBfkHI3Dyz10gg3aj7JIllw1DZr/Q1bIO2ZVYiwruwqInP
 hRIJFYXnegTWN7vxOX3ZpbIlg+BRWcZngXfVruq02G5oZKyV7/2BDv2XsdFOAyxt36Wn
 gAfA==
X-Gm-Message-State: AOJu0YxA+1jRZGGlvmH/hMiL1yYV2btPin3mQucs7MIlC9j1L0xBdiHU
 0STD36BNlCaEeKT5WIN20DPx9huuKADBsALDNSb45Ee/TYke208K243PqO60BOOakz2Dc0fXPQV
 NXEs=
X-Gm-Gg: ASbGncssrepYLzbSwnxIY0NqxK5wr7Pivy3vkbJTcFjMErgaMfGTnW7zJvEZ6yLKwap
 iej/qao/79kILJUHg9paww3siefQXniyb4dd9DaLF+BO6JlMMqy4aTkbnPSVaPLhkrdfBCSatAy
 8Is/zRuTTPfWVU4FAvL8kBbDIZHJcVxnQ3dJDSLwJEZn761Zzek9iF8crx0allKrrE9RRgoK8Ay
 fTfi/ZZ/T5MI8OiMD/MpE9Djp9AVytqMNie/gCsSQOaKl5Hl0wby8TRBCqxa7pChWTiznH66ip6
 Vayaj/tksgaVoOGtZJ3F/9OS5GBc55ZrtFy7wbJ1Thjlxij8f2KZNqOj1g==
X-Google-Smtp-Source: AGHT+IEudtdh1A9BekdzJS6Ien7VHT/jOYWeaKpXD42/i95Ldz00bI5u31E67L9ESM9gocXauVfZvQ==
X-Received: by 2002:a05:600c:1e84:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-442f20b91cemr72082485e9.3.1747304794595; 
 Thu, 15 May 2025 03:26:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/58] target/arm/arch_dump: remove TARGET_AARCH64 conditionals
Date: Thu, 15 May 2025 11:25:23 +0100
Message-ID: <20250515102546.2149601-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Associated code is protected by cpu_isar_feature(aa64*)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-26-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arch_dump.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index c40df4e7fd7..1dd79849c13 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -143,7 +143,6 @@ static int aarch64_write_elf64_prfpreg(WriteCoreDumpFunction f,
     return 0;
 }
 
-#ifdef TARGET_AARCH64
 static off_t sve_zreg_offset(uint32_t vq, int n)
 {
     off_t off = sizeof(struct aarch64_user_sve_header);
@@ -231,7 +230,6 @@ static int aarch64_write_elf64_sve(WriteCoreDumpFunction f,
 
     return 0;
 }
-#endif
 
 int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, DumpState *s)
@@ -273,11 +271,9 @@ int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
         return ret;
     }
 
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_sve, cpu)) {
         ret = aarch64_write_elf64_sve(f, env, cpuid, s);
     }
-#endif
 
     return ret;
 }
@@ -451,11 +447,9 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
     if (class == ELFCLASS64) {
         note_size = AARCH64_PRSTATUS_NOTE_SIZE;
         note_size += AARCH64_PRFPREG_NOTE_SIZE;
-#ifdef TARGET_AARCH64
         if (cpu_isar_feature(aa64_sve, cpu)) {
             note_size += AARCH64_SVE_NOTE_SIZE(&cpu->env);
         }
-#endif
     } else {
         note_size = ARM_PRSTATUS_NOTE_SIZE;
         if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
-- 
2.43.0


