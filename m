Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B348C369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 21:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2z0s-0005xE-Ks; Thu, 10 Apr 2025 17:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0q-0005w9-7l
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2z0o-0001l8-Fx
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 17:00:39 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso1102744b3a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744318837; x=1744923637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQocORlIWShowiqK86UH/3i1rW1ojRKl4ZKvCvKtX1c=;
 b=Tf9Lszg03CbeOjREJHpkDMjVGwB4TBi8NBoUQ5dAspJbJeocMKfsyiMBanSmugWaEs
 wx5PW5TpyGgmhmG57rMJmgAwhKSsbECgxJorgR577/bpYecRkRT9/m7R4NF1z2bNz4Zs
 SPUUeshBWz5p2PuOYCd2Y4pQ5RYceN0qQ/dvPYC0b9RwXAAdCWGydjXIZipW/EpA68gm
 DfnwyI+npId+u5gVZgLeZ/3o9Xxtkvgm53uwAC+K7mYtYYDVD8edwEwazfkkfMN98kTy
 mVX31sK1i8R4fOjs4gcO4QWjNEiMwctU4Qft/TVxNbZIpBqKV6CZ0A4NKNZxDh2Lk1jS
 C4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744318837; x=1744923637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQocORlIWShowiqK86UH/3i1rW1ojRKl4ZKvCvKtX1c=;
 b=gOm5zxbCQ/PJcCyLNHttHpmUGg5RKZFs0sY0YXd96FhT8jWcOeEiWB1TkOG20UsgEx
 R4VPWUiIyJ/5/P1DiuVE/7d1101pSD6zSMuRGH1i4itP3wV/OBPd4fGoo5IQ4omHHWyM
 cjAQ6n7D7ufbJ1e0PYROaXj1MfESu7j7f81U6de7bVTbix5HdJzrNqPkJHWPcVjDf6Qw
 OZPosBfs+8cp129PjEct37v/2/omTNrouy2/y06ecwMWdzdxnoMjOP//swT88PapjsH6
 d1lLLbJ9X6K4LS9beHLw64eSZomPe2lRon0meBdGMz+p+HTyb9OPiXOieOcolxp7J74L
 cObA==
X-Gm-Message-State: AOJu0YxgNC57w7Yk+iAOUUGZlVnb1dLWfsfxD/KC/tYi3B/hIZZqORr7
 j5zfBU7sM82Lb3qhi3S4NOUREvL8KLgN1/PQL4Hy4RifpjqhhzAq4CXsa1aj73b3b7Sh/Wqc2Ws
 Q
X-Gm-Gg: ASbGnctqqfKEm/FGoxJWNUk+0dCUPWjCQhaiXk5iNA5sUP8U4qk/apu2NLpwBAX7CSt
 /eeHDHgdIl23zljMR38kylCubnPHzBDClskEtcCM7ciaKqEcki4Dz3erTf7sfxArCDnmYtDxuLm
 zQxTm2imdiEa0tiViu56AWgNdI26QaLQG9mTNRA6BkhCKf5RNoW4EBWJmVPYIj0ZsmUM7NlYFIS
 nMiC7aAaZkWOrGGJV9K+BvzSB+hg1AkBRhJjz7V3ZuZ/VGCGwRIZ7WQ9ugfCJ6mgOrW73d7CirE
 3+qzDZ6DO9SPhBdYqqWUOpTNpgyyvYkWcyhT1kAPXszYyDO8q5Q=
X-Google-Smtp-Source: AGHT+IGzeww3U8kOE0MMW031fRG2ZvP0muFJ3dukUFGeGEgW/yFFEZB8SP3ucUih1wFJ97p4lnaXDg==
X-Received: by 2002:a05:6a00:179e:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-73bd11e7135mr381290b3a.6.1744318837234; 
 Thu, 10 Apr 2025 14:00:37 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82a3sm12431b3a.90.2025.04.10.14.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 14:00:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org,
 Yannis Bolliger <yannis.bolliger@protonmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/4] target/arm/ptw: get current security_space for current
 mmu_idx
Date: Thu, 10 Apr 2025 14:00:20 -0700
Message-Id: <20250410210022.809905-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
References: <20250410210022.809905-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

It should be equivalent to previous code.
Allow to call common function to get a page address later.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 5e196cfa955..754ef0d3a25 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3635,7 +3635,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
-    ARMSecuritySpace ss = arm_security_space(env);
+    ARMSecuritySpace ss = arm_mmu_idx_to_security_space(env, mmu_idx);
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = ss,
-- 
2.39.5


