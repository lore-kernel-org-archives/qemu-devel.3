Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A7DC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIO2-00005V-Rb; Tue, 04 Feb 2025 07:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINe-0008JM-3y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:18 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINa-00029C-VG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:17 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so4665268f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673413; x=1739278213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cl2nmICirpIXVtF8Zl43t73+3pCHJ4PZJWOB63ih4s=;
 b=YqfVa9dpzxiR8jRkudOrwWJJEpan3CBqJbKh2m3p7sYaH1ftLVJSa4G/qg4VYKOp3w
 DEYXmVDp1kMyT/3BSGzBrST10kYa57WSUqmZkczFgCeC6yU5nM3ekZgcb2iqENkHpkoK
 dpyvtb15vvr/Xoc7YwDz3BvS5UvdoSvp1kN5T9PES13G4CAWjSjexybLQo23TRHuaIPG
 oQqKPvX3vhUpS9ou/cM5VVlhXb4PtahUt/jF8ii8SeQwPG2XRb+CnVnuuGxSpr2Xd2Uv
 Z6FbSJ3F9gnF7WnNhYb3AfqRU5TiAXofZP7jhtVhAeXJmNAJSA5lRX5iBzTnL3bM8dL1
 tweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673413; x=1739278213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cl2nmICirpIXVtF8Zl43t73+3pCHJ4PZJWOB63ih4s=;
 b=v0Lpm980fSGDSdUUfg+CmNM3s7r/RSmPik0yI+0oLFWZpjd4BN8i3bMJruVRpEgM4O
 PeFhkqAjCC7UlquLD5umzzIClLykjhYeCFmT87uftqrOlbyuqW5f4TQjcga8JzULRwm/
 wSKK+qIXjVb7pYZZkRD4PU2HpSbx4YkEBdwb0cw80v8vYSBlAi78t1SmhaS+TRyCKZte
 x53YLa7snQcdmw20kCJ0xDYW5RBwQ2wLep2FKIJgg2pnrBTQy72gcjLbzRu2OJnQbPf5
 BK3sRuYTnmpQAvDOh9UdGKGjBQdj36PeSTeVDwkFpvbWERVaWj7e/kSAILsz756mncRH
 FHHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbKBgOdooK90kNw2KKXv+ayD79TZstltXP1g85cOb0Mkcfn8bGIoIm/rBriPZU3Dq0NydfpzTx17Fo@nongnu.org
X-Gm-Message-State: AOJu0YyKjVa723n1S49AOSeu88i8QzZTKEQKFlZ6AYGNBhA2L/Hs4GD9
 eD9npkMB7Bhll+SUiyRiYS6hoQTnB8tf6VSOKLOmhexXiQRxEkjfrOZsV08Ht+0=
X-Gm-Gg: ASbGncv5yaWAOtWM/hc3O1e+BPyba1CUcxTkd8AvPk/jZUDl2tvvpzeX0pvnR/4Xnw6
 T0T7RVCjKseD5qhbUb/AqeKb68J8tQO/0Hq60/Imn8V4Wecf8y9KUBXSL65cX+cge7BBjE++AZ2
 rGwYh6zTOHfhfGnmZKUVzOi5yhlkeUW92hJX4DjnHCa6I2hvEnLQLyt2k78U7HPP23xmpkHiFk1
 f8UAtkjLFO49ArYgJU43ko/FVRjMYz6a9fPPVpZxS5lgpsyAplDn12C8xtJh3uk5N4X3EM6KfHn
 UPGW5Xr6UnaNheK+2VrPZw==
X-Google-Smtp-Source: AGHT+IGNOP9780Zm3sXo3On9fKjhQUBV6/nFYl3NSUhLd17mMupuDNqsLTtIcFXUHBXL/9AK0iYzSA==
X-Received: by 2002:a05:6000:50c:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38c52097153mr17445706f8f.38.1738673413147; 
 Tue, 04 Feb 2025 04:50:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 1/9] target/arm: Apply correct timer offset when
 calculating deadlines
Date: Tue,  4 Feb 2025 12:50:01 +0000
Message-Id: <20250204125009.2281315-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

When we are calculating timer deadlines, the correct definition of
whether or not to apply an offset to the physical count is described
in the Arm ARM DDI4087 rev L.a section D12.2.4.1.  This is different
from when the offset should be applied for a direct read of the
counter sysreg.

We got this right for the EL1 physical timer and for the EL1 virtual
timer, but got all the rest wrong: they should be using a zero offset
always.

Factor the offset calculation out into a function that has a comment
documenting exactly which offset it is calculating and which gets the
HYP, SEC, and HYPVIRT cases right.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1fee8fae127..049362a5500 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2460,6 +2460,32 @@ static uint64_t gt_phys_cnt_offset(CPUARMState *env)
     return gt_phys_raw_cnt_offset(env);
 }
 
+static uint64_t gt_indirect_access_timer_offset(CPUARMState *env, int timeridx)
+{
+    /*
+     * Return the timer offset to use for indirect accesses to the timer.
+     * This is the Offset value as defined in D12.2.4.1 "Operation of the
+     * CompareValue views of the timers".
+     *
+     * The condition here is not always the same as the condition for
+     * whether to apply an offset register when doing a direct read of
+     * the counter sysreg; those conditions are described in the
+     * access pseudocode for each counter register.
+     */
+    switch (timeridx) {
+    case GTIMER_PHYS:
+        return gt_phys_raw_cnt_offset(env);
+    case GTIMER_VIRT:
+        return env->cp15.cntvoff_el2;
+    case GTIMER_HYP:
+    case GTIMER_SEC:
+    case GTIMER_HYPVIRT:
+        return 0;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
 {
     ARMGenericTimer *gt = &cpu->env.cp15.c14_timer[timeridx];
@@ -2469,8 +2495,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * Timer enabled: calculate and set current ISTATUS, irq, and
          * reset timer to when ISTATUS next has to change
          */
-        uint64_t offset = timeridx == GTIMER_VIRT ?
-            cpu->env.cp15.cntvoff_el2 : gt_phys_raw_cnt_offset(&cpu->env);
+        uint64_t offset = gt_indirect_access_timer_offset(&cpu->env, timeridx);
         uint64_t count = gt_get_countervalue(&cpu->env);
         /* Note that this must be unsigned 64 bit arithmetic: */
         int istatus = count - offset >= gt->cval;
-- 
2.34.1


