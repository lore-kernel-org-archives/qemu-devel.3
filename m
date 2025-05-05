Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A4BC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1L-00053H-TS; Sun, 04 May 2025 21:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0t-00040i-4e
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0o-0002b7-Gg
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so4347194b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409973; x=1747014773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=PJseyKk2zjaFnbTgKbb5yzu/aF6UEyuq1FFCWPI+yz7N7SZAnxLr9aNTh++eaT7qty
 JmJNfY4r+SidgOmJQirSfPsJatkWVz4sfzlpu5UibFpJZDlyk8RvKL42znDHv536EaW8
 Tq0tairK/WQjp3oDeTD2dUzkWxh4BLIFCCv4hFbeMaxuCAthYOR6rm3xs+11oWKvJiMa
 xN5FeBYJ4DbhxW0wM7IWbULWh0yYhyJwGglDTGqfLkPqP5kv/TtxQfZkzZLFl4yMBP9H
 GIJYfPMIxweRXR4QmlKRblei7HCTWRFBbInGhy1PjulsGMbeUubPX/hh+R+JA9iikqdh
 O5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409973; x=1747014773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=vI/CoZweKMSnQwvOmAQGpLk8/62R6IS3TjRcx24oEU+MzhGlL6WBzG+TEyB8OXR7Hr
 OhX9OtipiJwPFWEAQ+HUZw/kPKX3HMK0QIZE9GYaoOBhFddEPgU9iM1QkMR1XNtI9B/p
 CWEU3MFYc0eyg/kTBzxli/h4EeFGEE+ovXC/ZC3sHZHCXMHysyYPq1wZ5yzgTc1C8kg7
 bzAMveC/TRAtvEMlzQY+5Ni9WBHcMxkPIU8fFH46vH2SNumXfvQ67juFDSNVetMhaL2f
 nHkbW1yStHyUcEq9QySzs+bS2KyoflQttoO/npp1jpbEyonqBR4tAgZyJXWpps50Cdaz
 eOqA==
X-Gm-Message-State: AOJu0YwOsvirlwc7q38Elb8GglegsChWOWtE+pySKjN/+9TuWTOETwR2
 JeAc4A2zpwvVPDVSpD1fBIEhi2N+MktCg3BKytpYpmjmOK+kTIgYAcqmy+t7V5zyrXmnjVC0AZF
 I/Es=
X-Gm-Gg: ASbGncsRhzWjYMFYCu1eHYuJJdd4rvN3QzdD0DyaoDTRIJRMipG362G7Hqfq3/GhtwR
 Gtwm1L78qZEVRpTFVmBbMMZgBG+aqmQdDIYpFCCItuR+/sudfrxbTAFZ6qyoEPSxxFZRMHs+C76
 UvjQh4yJRUY/LWiuPoPU8mfggCTG7um+4U4sEVqUCQPJav+9oUeTKWQm7X1boGinZRLJErBi4Py
 bbmsLPHH5+cfUZG1zLuCAwlrDDLJaTo/oc13JeeLkJi29mubN8gDH61sBqwUCCtKMa9U92uVMrH
 Gs5WUVFH95C+VXwMaZaVPz4znx2y5qeT4HzU5i95
X-Google-Smtp-Source: AGHT+IGBQ16QZAGwgjeEboATnbwXZoFnP6fmv9Cr4aS9PWpTHF70jGWZcZkTQiKdWRxPemZ0zpyEXA==
X-Received: by 2002:a05:6a20:1589:b0:1f5:6c94:2cc1 with SMTP id
 adf61e73a8af0-20e96ae6ab0mr7772543637.21.1746409972928; 
 Sun, 04 May 2025 18:52:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 27/48] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
Date: Sun,  4 May 2025 18:52:02 -0700
Message-ID: <20250505015223.3895275-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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


