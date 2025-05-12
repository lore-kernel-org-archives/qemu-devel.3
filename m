Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767ECC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXZI-0006iR-1d; Mon, 12 May 2025 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWy-0002YR-P2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:46 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWu-00006r-A9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:34 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso5391218a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073131; x=1747677931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynPpe+7xoYBYdred6SBN6w9Y0IgzDdC2ZAA3L0jAu5s=;
 b=eFJ0GRLVx+DxDeZWgGHmv4SEG4+1MNLAEGE5f1E04HeD5Wx0vziffJb+EOuRIVMdUw
 GMH9gqJ6vX61PagfRCUG8v9TQeIMiTar4o3b1XkqBsHtnV4qm964eFvnc7vT/o7BZsN7
 TwySzFwWzTa64/6koi6Y0OtYqajcYpe+pHSi2X4dB8mK2mGyBrHbfEqOMEFK8vuxJT9B
 eL6jXz0+vBmyVUYeO9XV7EcmSKNoAPCuMEbTP3TPtDuegRN4tAgUbskFmB2ZSdrgA5D/
 xiSD3Q8CMIBCI9LUXP7UgDM0kT4kF8xDJJtnLZYGBs/NMxL+UYMZHp5HMVMAJ0RsyPVP
 3LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073131; x=1747677931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynPpe+7xoYBYdred6SBN6w9Y0IgzDdC2ZAA3L0jAu5s=;
 b=BhQY7GcyUZqqZNsdra8JV9Y63hENwge6uvlWgj/682V6Gxyo4T1utfdbUorES+3HET
 UCEDX8UnfUwhoI0AvT+8VIpDsRqM7l8KCLJ9nn4JZCmyYZl34DIz3RwDv5oXsv6zudwj
 2Y0orJeK2zOQyvTW3EMw8whCCIzl+LBPuucRJnndzZeFJNns60qZNMitt3DPOg0V/zUN
 hYgQehq012nQilaeVQoPkGpb2RUH55IV5FCha2JWS4ztzJ70NKhzypyXQcmFeLB3+I4S
 MD3wZc/g8wX47KqUQ7ihTJyceDYg9h/OVkpy3arQcsZkPQMnvoQ/8DyEutF+X1KpSxlC
 MTOQ==
X-Gm-Message-State: AOJu0YwchgXZ0ej0gudno06bGqoRDQaycia1dy9AZ2XwmRyrM2tOqFoE
 HzBssrzJHacuPX7i7UhQfH45jzBmJ4rjv4ITlolc/6eY+tFRxJrGNrt0KSVzB4hx2QI592w6y3Z
 M
X-Gm-Gg: ASbGncvJPlQCbOccEZfsoT4GQSwtUpZSdyVWEX/DqOGioehF2vqTuPbKEpX3TjgtDks
 Oouqxm6htrgB0QMt/61k+nVueQGRb2jBzZalax/8y5lFkPw4fl6x+OZ6Z7LxhEy3MVx9vUEsIlh
 YgBAvxHLpq2SLScu3f5uutZrGR+cRubcTMHtm51ESFjTRoUmhu8gjmD02a0qw3qfUwN+/D4wqdq
 bjIco29FN56nMwIYZ6r6l4I0oyzD00LZ5ehH9IBpSxy1hMH/Pt/lULlN1rT0wcZHtmWxv9sl8uE
 QhutNVgAOolSGblGdJOqTiVEL29i3S5i+618oWvd3USYVkmde/EKUPUPy7jjHw==
X-Google-Smtp-Source: AGHT+IHOIsMsSo9l7r0BSna7qr5cjMQFR4caBJLTeNrnfl8hHoLW5O8u+UyBnmKRl9wmyrnYPFvZiw==
X-Received: by 2002:a17:903:41c7:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22fc9185f46mr214714525ad.38.1747073130756; 
 Mon, 12 May 2025 11:05:30 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 21/48] target/arm/helper: expose aarch64 cpu registration
Date: Mon, 12 May 2025 11:04:35 -0700
Message-ID: <20250512180502.2395029-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

associated define_arm_cp_regs are guarded by
"cpu_isar_feature(aa64_*)", so it's safe to expose that code for arm
target (32 bit).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d2607107eb9..92a975bbf78 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6590,7 +6590,6 @@ static const ARMCPRegInfo zcr_reginfo[] = {
       .writefn = zcr_write, .raw_writefn = raw_write },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_tpidr2(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
 {
@@ -6824,7 +6823,6 @@ static const ARMCPRegInfo nmi_reginfo[] = {
       .writefn = aa64_allint_write, .readfn = aa64_allint_read,
       .resetfn = arm_cp_reset_ignore },
 };
-#endif /* TARGET_AARCH64 */
 
 static void define_pmu_regs(ARMCPU *cpu)
 {
@@ -7016,7 +7014,6 @@ static const ARMCPRegInfo lor_reginfo[] = {
       .type = ARM_CP_CONST, .resetvalue = 0 },
 };
 
-#ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -7509,8 +7506,6 @@ static const ARMCPRegInfo nv2_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.vncr_el2) },
 };
 
-#endif /* TARGET_AARCH64 */
-
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
@@ -8951,7 +8946,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_one_arm_cp_reg(cpu, &hcrx_el2_reginfo);
     }
 
-#ifdef TARGET_AARCH64
     if (cpu_isar_feature(aa64_sme, cpu)) {
         define_arm_cp_regs(cpu, sme_reginfo);
     }
@@ -9012,7 +9006,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_nmi, cpu)) {
         define_arm_cp_regs(cpu, nmi_reginfo);
     }
-#endif
 
     if (cpu_isar_feature(any_predinv, cpu)) {
         define_arm_cp_regs(cpu, predinv_reginfo);
-- 
2.47.2


