Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5F0C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pdV-0000gK-FG; Fri, 04 Apr 2025 18:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdR-0000fQ-Vt
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdO-0007xO-5Q
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso26816905e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806129; x=1744410929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxlCfJu/ghlRwJtFNdG3a/Et1O+b4mI9O6ETIO8F/ks=;
 b=U0Jj16oSh7JtVnmhMD+xC/NEkHh1Stwg3SI4b8YZfJN1lCh7OL2XWCAAv37iN0DrTT
 lD+c0CFmNdF+PWr/bp+3WK5ooOtds6yZRqfgDoMjhx3Fx/4oFlZEQ2BW8UEMsdPxPZjn
 WOwUmUdBwogHdvAXGWAIanlLJIbRZhNSpONCr0JVF0jLRYikv8hPvpV1FPRJYhJ0SqCD
 4siDVtsfsAlLpeJr34X3m3b9R3V8tF4Wc90kmnpO03SW19tVXzVjEWgs9Hdv8ZrWiJAS
 dTVKY7wDd2tWP8ATovOc6dAJQpTxt0kGwsGAWv8rWWn90L7VYAeuArLo7BbVo2VF1Ioh
 ziOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806129; x=1744410929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxlCfJu/ghlRwJtFNdG3a/Et1O+b4mI9O6ETIO8F/ks=;
 b=taN6sXINGCSG/AnIh9lqu9mA+ULZF2yPrTvjvRISm1RiOmcjXoBpgHD9T9n7B/N8ac
 GUJh4AALdK0YA2kAbtg54ezX+NxhICV/j1cy3ngIfZr7+4rqDUpkl+5IEsgwMB7978bx
 ce+Yc5SSH1k5YnVBdMPNzJsW6DffmgLh6reKoqU1pJHvIQIm9CgKHDS0c48utK3FFDOX
 FVWujgoGbL7Q4VXRviS0G6mJwxTI3d4eEy9Ug0180jdlT61/NLEhW21QUxbT9J/5GMvP
 Am+mf39iE7qPTVRvejESexkR9b7KfBkR12qd7CvibA0fa3wSTPXIIPD6ftbcvNPOfn9O
 t4Ig==
X-Gm-Message-State: AOJu0YxsSMg1I5TNM9mC8qdnGvk2QMgdZTh5Xmu09yrtw+KGYIEdna5B
 LX6shSHMGehNAuHQ8pmS95zt6GuimJhJE8EewlkCo/DPNTXoFAw2rIktFiJedtyFm++2ZNJ8ASh
 4
X-Gm-Gg: ASbGncu4rELR4S3iNJ1XVcCCWH6UClukj1TQyY+pklBUFs6jykesAjd2OpV9n1PgLgC
 GKmNc5P1WP4hmoALB9Jarfo4lEPtKwShrDWMTJNoDH56e/UNCkuL15q7SrTyiBZic7M4Q5BM+gZ
 VlJoXgROVw32v+IfJaia/UdQ/y4tcCtwU66XIzKpxADrfuqrw+jWU3HZ/w1yQh4OAr+aRpI8CnJ
 tu57/cg8XcIm85hD9OpRGjxNl2Rlzt34g1INjVaDJntiNzgWkn3vnuEAOCzJC7P8lXxKwqXfThw
 PX30GA3wA1CIpIBenGhnYlDNF7whbJzoYJfrdlSMQzPkE1+eLn35HThrwqHVAp3L4c5muZwmjjp
 0nH/VtxXNW6K1O6jN9q5y4Pgf
X-Google-Smtp-Source: AGHT+IHULMFoU9I6lSJs4fhIrGNL405naq7zzUhGfdPr8FgjDMFs3ympFUW5t1hQ2vzvZdeZXgAcFA==
X-Received: by 2002:a05:600c:4ec6:b0:43d:fa59:a685 with SMTP id
 5b1f17b1804b1-43ed0db4025mr38379115e9.33.1743806129342; 
 Fri, 04 Apr 2025 15:35:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b76f2sm5404476f8f.53.2025.04.04.15.35.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/9] target/arm: Remove uses of TARGET_AARCH64 in
 arch_dump.c
Date: Sat,  5 Apr 2025 00:35:13 +0200
Message-ID: <20250404223521.38781-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

It is safe to remove TARGET_AARCH64 #ifdef'ry for code
guarded by runtime check on aa64_sve ISA feature, which
is only available for Aarch64 CPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.47.1


