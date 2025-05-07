Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EF1C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQC-0000in-Hq; Wed, 07 May 2025 19:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPs-00006y-4K
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:08 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPq-0002Xc-00
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22fa48f7cb2so331035ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661383; x=1747266183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzs2UwtIJQNFywCbX3keywjm1hoL8ZwFtVh1FsE0O+o=;
 b=rpAMrpdQCp+nEGUXta3Y+E7qoK/nuXOperJ1fqPbalR86GRB7dL+W8FShdjbrSAlV8
 fiVvug2JhlUPWtDwhA6vV/2ceddwnicQSYAXwZQpkQWsZvQ/wzGpRGQYqd7MYGUiZXP3
 bmOnfhX57hcFha/z/mQhpu7aX6vaxfR9sP7ol7IHziWD1KSSSN2YNsX0/Y77+Bke1Ekk
 gxW2X/0laeUFx0Nh90KB/eDeSzLvKFbkNcd6PhlPai2libVgfDriNB12uWGFfHIopyoj
 miWXnbbMmWCSfgHkEBagId3uJ5weKMyEPetE10dEGNYXcIsKhKCibsqoU7dvt7f/+ScY
 JbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661383; x=1747266183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzs2UwtIJQNFywCbX3keywjm1hoL8ZwFtVh1FsE0O+o=;
 b=XImhRm54m9iY+0AE5Q87bkFWHt8PeGfJN+FXxmYo8gq8RRmiURw2ag8aU2b3NY0OZh
 1Vtl6rzIpQHf4+m5BYmFXValT6XuA6JFShUGxFEeKno36s6m35Z7ov0IJ1ghQXHVvV0m
 6rSLkaWpfrWcifh/iVr3ipeZXHx6Pzbqu1CDZtiVckOMRtClTNuUE77irYiJQUb7ySES
 S/ravy4o4qtnDu/2HaBgCQf7leyNfHoK6c63YHUityi8dG0YpRTw0uQmJcjm6kzYHLdn
 /5dS6S/MQNfy907YJeJS0GWgBtHOyJh+fDaYGDTtXnnySSakG90ACqo4lcxcBJQiaklC
 LFmw==
X-Gm-Message-State: AOJu0Yy8FfrH7vGKxE/ITyd3P4TjOv5wXSaB5Q2trXkvMjlnXNDpKDZK
 QCuxtWL9sc+LSOA5HqeMnEyZRgDK1dwo4VSAvz/gOkzTTkzXUV+vmF+gTluQ/YtfT9rxMupwJtM
 Q4fvkEQ==
X-Gm-Gg: ASbGncvMPUhC6UAi8UlhBqH1255dlqi9pLg+rdt3yzB+ljxlnOee70q058BTIBJCZaz
 L/cdNfBRuUatyw3+xLxLfnjtwxjVQUaLrXOBq3tI00yYIDnyx97+MK/ytvOMrBUli2K7gew/fXA
 A1nPztqLPxHlNijSbzYzPFD+tatjszxDveC8MmD+S0TNQ206fzHLoAk2h5irhoJKyuk8k2cyaEu
 vm3yuhTUiuQ7XQcsezisDdTYDYUhhhn4ZwTS0wTRLkos8x/BUiqQ5T/h8FdaijY8qLymeAGOk8p
 O7k1D70qQvHq6Hn0TGu1fbPB7Y/C3sEKFl0Mg/fR
X-Google-Smtp-Source: AGHT+IEBA0reiSqxw/k61eFRA3NP84FfIPAPz1InObOyyt1+kBS+UY/gwjXbg6ZmBzPN1LbTd/0qqQ==
X-Received: by 2002:a17:903:32ce:b0:226:3781:379d with SMTP id
 d9443c01a7336-22e5ece3fb5mr76592015ad.33.1746661383483; 
 Wed, 07 May 2025 16:43:03 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 23/49] target/arm/helper: remove remaining TARGET_AARCH64
Date: Wed,  7 May 2025 16:42:14 -0700
Message-ID: <20250507234241.957746-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

They were hiding aarch64_sve_narrow_vq and aarch64_sve_change_el, which
we can expose safely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 18ac8192331..e3ca4f5187d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -29,6 +29,7 @@
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
 #include "accel/tcg/probe.h"
+#include "accel/tcg/getpc.h"
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
@@ -6565,9 +6566,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
 
@@ -10625,9 +10624,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
-#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
-#endif
     }
 
     if (cur_el < new_el) {
@@ -11418,7 +11415,6 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
 
-#ifdef TARGET_AARCH64
 /*
  * The manual says that when SVE is enabled and VQ is widened the
  * implementation is allowed to zero the previously inaccessible
@@ -11530,12 +11526,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
-#endif
 
 #ifndef CONFIG_USER_ONLY
 ARMSecuritySpace arm_security_space(CPUARMState *env)
-- 
2.47.2


