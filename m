Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133DCC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXYx-0005qU-Jd; Mon, 12 May 2025 14:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX2-0002Yj-RV
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWy-00008O-Ci
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e7eff58a0so47382575ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073134; x=1747677934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=DzlKTkuapdS2M0icbpeT1hv0TGuUhwos0Gj6uKo0PMYa0mgycuAAuj3y4Negw52k3Y
 VD8t/ul04KLLLl+eZvVC8VvSLgLWMcX2YICJ0feMInC8GjGNjsAteKkiZ9C5f7Qq2I20
 NUPJD9soJ68w2p2eNwjFG9gZqujwPVi6RBYF10u3LKAwLgqa0LAOncOMuIitK0+kDq70
 MBTnK1/TZXYEoxHRhXOQGWEhrbhOJRnGBrE7JxzCV59BR7C5dD9WnfAfKLGMfrvuKUOW
 UjKnnLNskTEw8UAVNXEtSJ1pYgRyuPjB0riD7y1GjZ9MjRhP6jtrZW0d6SS1qAZkII82
 Z4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073134; x=1747677934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=s364XDp8wRRoNV0TmJSCKZD0hZ/uwXI7tdoE86hqFm4xZVWHVo9r5hVffZnZoq0Sak
 nKaheCVDOeIquhqzoYrbGbsY6K1+g5aQztG5U6uyUG8ItuQLQCsaf9l7ydzbLI3GVyCW
 V/HDtnO3GYLXVQhbdwxPOHrdOtFSTTNubbQogMYXXPUaCm9K4jGbE9f/VNrCahYLKIbN
 vQmDsZa5zAIryB9rncHYAKepk4ITxk5neTk2MwBtz/Hf/ZXjO+/r44fNg8RBuM3gkGNt
 SR7we7XJpXoguVk9uWIL084OsjGeRmJ2w6dqrjmRPDvi3yGAkOpsi5RM058tOSpk2UMm
 7pxw==
X-Gm-Message-State: AOJu0Yxci017BzS2tn4a+/e8aJygv7vaH0qgXaM5psJ3ETs46EG+kyTG
 nypHQF+BG61Vf1tgJgsgS9CtM8D1zqw0XnhUJLYC3ybzLQ4F0ow7GTgoPGLGqUnq4H1JRRkLo9n
 9
X-Gm-Gg: ASbGncuQ9U2hdtA8etHd3ZQuD9mc966FdxbWSF+dyBRqDNdWtwbFiwL6d00uat/3w2z
 OKJvjFm1KnVSSwAvymUM+fVJGjmt77ZWxDhGjfdnHAHmSH/yQo7vh3tfCHYEt6ozNfYUqaaiopx
 NPTZGC3iXfBfo9Wqa0m2W8447Nhwge9nV1aeXN1LbAydzDlIzOCihy1lb2lMfqVpqgNME2ClJqn
 gjz/zcc0Cn+lpPKwHLon4kgiz1hqa8u20n7PRgPWscLkV+Q9dIIM53c121oIE5h0JCQQ5NalKQ/
 1UVktEuY0+UXL53Rtqpu/sCJGqqbzrLL9LVoZ1Jm/REzfeOpVTU=
X-Google-Smtp-Source: AGHT+IHRbtBZKrpk84DwZT3SC9tiE9r4mdkW5j7HAsCCRKXXvOFwFcuCksCJ+/nzbAM4OOHTV0FO3w==
X-Received: by 2002:a17:902:ccd1:b0:224:a74:28c2 with SMTP id
 d9443c01a7336-22fc8b76a88mr210233865ad.29.1747073134177; 
 Mon, 12 May 2025 11:05:34 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 25/48] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
Date: Mon, 12 May 2025 11:04:39 -0700
Message-ID: <20250512180502.2395029-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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


