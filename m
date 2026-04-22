Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D505CF9EDCC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXE1-0001Bm-DG; Wed, 22 Apr 2026 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDw-00017L-8W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDu-00018E-3x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so4471082f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862952; x=1777467752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
 b=Qf29bRIEhW7vHOf3rB7WIiql+vraAdD7qBllQkdWhJJGoCMPmgMIYjK4KnVZVfhg9N
 QMp2/GJZB0D9fEjyVE/swxhmwSbz14nttdkqePUehHmN/ct/aiTtI7B/XH8YsEoXhUBl
 ThuTjJy3VEr3GmPZC5yJOVJPRfu/AhpS7Wtdmynvl3HGiYGfcA3BqqFcaR8WxqjYJslt
 UDIdifIeUxERRyIm5RQ0Yj4g9uED4OwCG8RdVTGhRFaQl7dfesbjdFTEnI7tD/6KIFU7
 t12RuMNnT2A1pm9iPh/qs9gpzi1rtpa7Zj3MrC66er88JkM70Lvw7jnT/gFnF6JUxGhf
 WTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862952; x=1777467752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
 b=kn2ItbHv0rqyw1C474RGQ8ROoRNZiwKyYOK+DShnDvwqACy/gp1eaQg7AYT/LHPV72
 EV3ZL6aSjXKZwE+zvC986RuhNi9saa1sPHZDn6c7zU50jyXRETskL+/oZTIOz8oribop
 ltTSLBuJnCziUNV5c/5gVglbsuemw8/52j4EY2Uzb4ufwcYkwfEltwlWZcZVN6NMJCfU
 Th+KLAptTZHQclm0cOQ4b8NOMDJJhVWFmyDBQr82gLAh5Go5xii3bujUZULzKVzV7TFG
 f55SpSFKl8AK1D6B/8V8IxokEs7OV4RsxYUbjxqxm33CaaxKW2FsKAoWFtgbHkVWWpVP
 AaDw==
X-Gm-Message-State: AOJu0YxR200ueAGPovKP/NFccpJdoBggkoaz7xFUIOI/3AVzm1TAb9aY
 ZxwtCp1txPm9Jl6S5jbwK+/CI0FhlFgGmP9+2qDbD1ESvAQlRIVieKVK7RJsrpEgLh0=
X-Gm-Gg: AeBDietWnbAVcFxiqyIp/3Ff6D+W/loHR3f/ssqPse42MsIHI2MedH4oAa35YFaWQD1
 JZ1maH/0v23L4GlqZb+ovP6ca1f49PJUKfJapwiBrG+Qj9ALzkW+fXABtaL6iV+56+bXKGIugLd
 M4dGX3fpODKqRwivnmFrXgCWcl+1XwavhQNeTYlwyi0lPWZF1phMCmqaBjn5bil2Eqto76oZIvu
 qKOjypgMmKJBPoXne1C0mwHmLZd13EuuH9ojnShD7lnKdX31s0xa2e72ED9AjN3kIKLdHdFfYTu
 KwjdldqrOQZNoFPBVgRIidxG29w8mhPk5mGC3zm39OxliNbG1B37EEBYRNf/6KMUlEEmmMdvqVf
 BBLnEmEoNndRI95FMDX7dIqPH6VdB7DLZ4nXPNZclakhIoFQfiETkhw4WOhSjwAQJaw32XdH/Z9
 hBuv52smj00hfXF2nb8yc/Vsao/nCwwz0ENg==
X-Received: by 2002:a05:6000:420a:b0:43d:773d:78ff with SMTP id
 ffacd0b85a97d-43fe3e0b61bmr35815340f8f.27.1776862947410; 
 Wed, 22 Apr 2026 06:02:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb13a0sm45667079f8f.8.2026.04.22.06.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 50DED611A5;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 17/32] target/arm: use syndrome helpers to set SAME_EL EC
 bit
Date: Wed, 22 Apr 2026 13:52:34 +0100
Message-ID: <20260422125250.1303100-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This removes the last use of ARM_EL_EC_SHIFT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop ARM_EL_EC_SHIFT at this point
---
 target/arm/syndrome.h  | 1 -
 target/arm/tcg/debug.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 53137394e28..d4dfab8cd15 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -107,7 +107,6 @@ typedef enum {
 } GCSInstructionType;
 
 #define ARM_EL_EC_LENGTH 6
-#define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 5214e3c08a8..07a52643e71 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -56,7 +56,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
      * Similarly for watchpoint and breakpoint matches.
      */
     assert(debug_el >= cur_el);
-    syndrome |= (debug_el == cur_el) << ARM_EL_EC_SHIFT;
+    syndrome |= (debug_el == cur_el) << R_SYNDROME_EC_SHIFT;
     raise_exception(env, excp, syndrome, debug_el);
 }
 
-- 
2.47.3


