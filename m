Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA8EC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57M-0006dD-Lm; Mon, 05 May 2025 19:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57B-0006QY-Dv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC578-0003dE-35
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227b828de00so57592025ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487244; x=1747092044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=slAL7+2Plf1tQD59rryCmHijf+7IiC4zWHsqbrxDMMNAC+4qYrhZ502byPVJLarkmE
 v8jBQU6Esepy2Yeb45rBz02PipQP4btkFAX4q6Xx6/fashtFfbw/ugeL2WmyG89Zt3Cr
 fYyxeMdmPlKOwzbSVfNDs5JV7xobQesh5cukdoiRPYFU/6SIFyWnHV0ArPlJwHHqJdg9
 gBQd+Ud0xPHSKoRsobe9pHXidNfGkri3WrT9LhLOI1RZiayQBfuMgQ8gc/tq/WhPKGkV
 Ffaohyy+P2UVC9LCUXVU1qLH2Bo/ptvz91Bziux2oZTBl4ov5HMI6nsJyFA5bS51TNZL
 BNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487244; x=1747092044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zqH0yuKEeNcEhgp08pnDlbJMJEZktVD9woNi3X9JPBk=;
 b=PimluA9A0p1pXE8upZHeY0+jouX7SWiOyR5G0eMgrOrldrSKl7xQ0bW1DXw0r4uD8+
 d6LdT6KUqCj7/6swMO6U9KKt80P8lju5JgS+fCYKQzdcT+D+SEo9if6//3EK0knPFbVt
 nwDvo2oKCTKVObrRd6sNwaclEjehf0o4WxEc70WeozaKMD1E76SikcTUPLxpsGUSp3KJ
 bTK92YO1xLx+3WNa1jj0Nnm0VXOT9UhTb9TNeepwfZTWkxNRxwwiA2Nx/HGU8Gtdosgz
 Z2nOAL32yUzejy/DeQnkXCERFt1+wFzsAlmMbhRI0922QfUgtwZ5OM3kHlOlfhchFOcg
 W2ng==
X-Gm-Message-State: AOJu0YxzZyN8+mha2zJ1c3Ef/kCUtOsuQDne1SxJ383Dvz86id4BTV1E
 b7K5QYl7AoNg14ZqYuVki/uf+NjJ5gEok0FValBRl34eD4TW19WH+5rLtIGApdDcV0o+nyJwvbW
 O3Ws=
X-Gm-Gg: ASbGncsTNsAnOf45kapO3wGaTIpi8fuvE42ofUL+CId9a41fvzhQA0xKKkTgv0DJ64O
 CPQmuH8try1Wm9yKEeVnwxhpU41V6N5SPDpdbyR4XfiC6jDisxoBhEzw1NWtYNYioEFfGjtYW5D
 mocCL+NZdG9hZME030cNs7LS1g4ABFAYs7SXpK4pK4dCFoeYbY1cR5lgx04Zm5qeVcVSfpYKPyU
 2Z99+vgENw6A9HGAca37b56CfV14pV0XeTDyCCVyNYg0yHVMa00Qea5Pa59uRVotCAPh9U3bNNy
 CWl8geZKavmIxZXG+iuDJWdMC0bAzW72qE7Leu7E
X-Google-Smtp-Source: AGHT+IEM7kaXEWCjPJCRibG1QX47pOlJJpefd7EuFnbK5xMzUMnHJ0NFjXgA0rgQXuFWitn7GRKtLw==
X-Received: by 2002:a17:902:ce91:b0:223:325c:89f6 with SMTP id
 d9443c01a7336-22e35fa30eemr13388815ad.10.1746487244580; 
 Mon, 05 May 2025 16:20:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 27/50] target/arm/arch_dump: remove TARGET_AARCH64
 conditionals
Date: Mon,  5 May 2025 16:19:52 -0700
Message-ID: <20250505232015.130990-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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


