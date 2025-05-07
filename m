Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8751FC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoPy-0000Jb-SV; Wed, 07 May 2025 19:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPs-000074-5y
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:08 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPp-0002XJ-W0
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:07 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso5164825ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661382; x=1747266182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DV+2RAAVd7Czk8H7PoRnAo43qLQObnu+pSnMRVopks=;
 b=Ip89h0J4rfhd6A297IqLgoLxs9K7wr8v9ZXDzeqoy2c/m4XjPOuiV0d8bI3DECYcm3
 TLj5oUbUnt3o74rmLfSTdovmniJ3OTHv4Euf7sEMID3u4pFT1nTZXXAEVuZRjmlgX/zJ
 biv3cwpKQICUDpind7tEaTzOxC+s0JUvjKLgildopPbOFZFkW9Ehv2jxRQCh9wSagvzm
 drTCi5jGb3jZZ9nufyx3BV8iVfkV1U37oHCSma3CZgd9mYIjVlK3X04oTSbSSUjAAfoi
 guCwAz82R9aifkwZqdYwwhtmDTb8YaQntedlhQ0kmazNIwKigbu/IkMSm1Ym5hIzp03e
 LH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661382; x=1747266182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6DV+2RAAVd7Czk8H7PoRnAo43qLQObnu+pSnMRVopks=;
 b=XWNWZUdmWJwvGbC0Q8NwHlqKir1K9ZIQq0aNHvZJCFJywd1vS85RE51b9Zie6SfNnq
 8OWx3gYN4TvtGc5niG0pniXTkAIycU3Eb2a4RKJoaVO/Id9AS7Y2Zz+tVttrWI7A67Ii
 hG+uPLu+e3eDQ9GaMgLbA1i1S0SqtySiUbmjXeqG5huj/P0qM+olITP47h3f0ujXji3b
 I+h2TFxN2/RF59TkPeGFoMsmFeoGVI+t2n4/UwoVvrBuyD1l0dt1MV83HqIstYll8tpD
 fRZpP9wwVtGUIRcQdoF6hJm1DkgGHqD5qlDqqpQP4XUIvQGl01Z7wmKhZ6NoV57vtQnD
 LY7A==
X-Gm-Message-State: AOJu0Yz6xT1JQazEr+0FGLG2Dsgh8ygF9SM3C733MvAPm97EP7sd6mIb
 tMmO+yBPlXZw0RPf8ZEqt3fch6Ap6u3IP8iuw0s8ce1RFpq0+23ztJjG44AvxTHgutTt1Idl9es
 A3JUlbA==
X-Gm-Gg: ASbGncv0u0l8lZOmQ9QfE29KAtcG0NPpy9u6ftEVa6NSsW2SyhnajoiMmMeCE3P9Rt7
 jkMvm7K5FFfv7fs+brEVWgPRkrBq0WO3J8YS9TZduhsvGBgEZiAu+1wTSu9Q7GTUzfX2jJ7Ew0H
 DjofqKAla8Z4xsLhi4VIimxQ02pg5ylRE1FObBn1WLtWcft4hggy0BagPEzbYg9nq0QeLfmNhSQ
 WoEWq2W6sJkaaEUYysiEG4Z7kioFugWRkizRECuGYgcQB1OX/M62IlP7VcHX/oYJBQr8lwChq8m
 Q6m8uVEWwuWk67HNRSGYKkGiJ7jfHZH/ZSX2wSQ6
X-Google-Smtp-Source: AGHT+IEFUNK62tE1si4fuK2RKKlN0gVISYH36IdERyQZ1SgpJ1N+YZe4RJbDf6/SEw8jryGADSirZg==
X-Received: by 2002:a17:902:ce86:b0:22e:4203:9f33 with SMTP id
 d9443c01a7336-22e865f7573mr16624385ad.33.1746661382643; 
 Wed, 07 May 2025 16:43:02 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 22/49] target/arm/helper: expose aarch64 cpu registration
Date: Wed,  7 May 2025 16:42:13 -0700
Message-ID: <20250507234241.957746-23-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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
index 2e57fa80b08..18ac8192331 100644
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


