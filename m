Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA67FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQF-0000nh-4O; Wed, 07 May 2025 19:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPv-0000DQ-0A
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPr-0002Yd-80
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e7e5bce38so4502445ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661386; x=1747266186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=ze+4mDxIhNVFn9PYBCVRyHCWH6m/x7LgrRIJq2XexgEmAQAwccurOE3giMmsFn9Py5
 +a4XqGp5N8ahcRh8KEh2rHeJMw3CDaUcEB1D9yNwChgh0rnmm5Hqa6AhrhziUZOgbj6W
 AA9VEV8w5w77j1Jds7vMMhHMI6rAKMk73uDjWYZim4QUQxc6FnMrYJlSAU3Fld66s+gC
 GPPCMKV7tXyVaDrmjARmNBMjha3hYXoIil6+mV6EUe0A+KYfGgleSg6QwYfURSYqmTom
 6TfY25jMgdoRnm9xceS85bU6kO010c2dGm2qPOr7jr2QmqB2r1+qW90i3JgXkRZa8P5e
 BKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661386; x=1747266186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=HXhDLGcp8c8Efn41BuQY25LS0ll4OZT0kEaf+kYv9XNIOHFfKJ4xD6js/NKx4dn5Dx
 Rf7GoRMQeTYWoFI0M6TBDvmdi3LfTY856cfPkVpGn8pJMDMM4cumzQ1e5/EO/sfjjniv
 L5QsCytHW3Qep7RR0rpmPT0BNz+Fst9wIt8xUWo7tbiN1WAaP2KBhK9BlUfGLANIwVV7
 BfQJJlMG4SYjOsTQWBUwQcPbzS9r0sJFcLDa6dtYsWDHPhf5OxFNuY3XyheDJvSPiyLV
 KHoR99KNJf7tUsxbGy/5astQaWOWg3aamEUFtewImFS1J47ekLd2Ah7EySWGQdttgzVe
 Q7Cg==
X-Gm-Message-State: AOJu0YwyeE30mgKpwf41a5e1Md5M647w9Ux8LnN6IBcwFANZOHU1VTQs
 jZ4iY7+uvPrGmUgFvHMWXkP3gSg4p7rONadQHDNdEAV0dm3StwpVb/jJ74AxUnMqImx1uJ+NX6p
 4GunKYg==
X-Gm-Gg: ASbGncsgssgYiZlHb4H9FZnlPAiNdA1X1r8Nv4d/hJECdEb4dkHt6LS6tY2jOtFOWdy
 8k16TH+2jcwh8a8ytVbak5aRzUaL2LjxJV6fu3mU9tatx6zp9S+xQTedPR9YGvUXRuEzNyXWXp6
 5LxEgEqbv7XEz+3pQRJEMxkIXHIvreEC749hL+2P9TCqT5ZQwLjeFHYGsObmFk8MbEikxdlgLTw
 SVkyNLsiNaA8l577q+aLWscEms/FfLLezhoRZkxkGTBss4h2XWbS0WAC3OYYKfq5/xUJXfVP9Zl
 bX5fFyeCUt9bgl8wcIfPpxBP6vy7gz090+6CsmwflW4D89usNgM=
X-Google-Smtp-Source: AGHT+IEU4Pf5XRCP/PZVO8a05wh2KG6IVjY9T2lfZS6hZzaegkdfG3OhY+b1/nT4B2UQV8lzgvaq0A==
X-Received: by 2002:a17:903:2352:b0:220:d078:eb33 with SMTP id
 d9443c01a7336-22e5eccc55emr75031795ad.36.1746661385885; 
 Wed, 07 May 2025 16:43:05 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 26/49] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
Date: Wed,  7 May 2025 16:42:17 -0700
Message-ID: <20250507234241.957746-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Associated code is protected by cpu_isar_feature(aa64*)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


