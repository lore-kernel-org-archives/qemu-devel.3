Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A621E98FA9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgPp-0000lR-7y; Wed, 08 Apr 2026 23:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPo-0000km-0Y
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:48 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPm-0003u1-Js
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:47 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c70f91776fcso189453a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 20:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775706645; x=1776311445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXUUcgWi2+vh0MyaTf6jDQP+dep+qMh1XfSIKvMmAto=;
 b=YtD+hoRajgxVE9uddSH4miJs7Pyw2+5vvHNsuPeHPHlPT3XRmYLzB6OqygEh0CvfJn
 CyN0vx0TsZJrhzXWhgI+cZa4OQmWkbVUjlfi2VhW/1+zKbfK2VSF2+xy+BbPy5OOhXwi
 Ez1rf8ceu95UjDT6yRNOJ4WZO+FBEekIpiO/ZEckw4aZGGl5RgA0sw+McPijPiU3lYb6
 U9JfAJhXh/85RI3Ea58rp7H1+JZSCDcSctdaF/h0/u99eHg1YmGmJBjasR4KSokKtQBc
 MtqssGGpBTJp6j4sKtJkoyMIKWNFtC9WKID3Q9gkDg2m20SYL74yRAv+Ry1PaPO8hquC
 PtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775706645; x=1776311445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yXUUcgWi2+vh0MyaTf6jDQP+dep+qMh1XfSIKvMmAto=;
 b=T9hClQfwtpU6+fFezzIQmL/bkcQyV7UAFyu/WNqDzILD8BDGvMQMouEjX0hpVbuAor
 wjpmE2MofkLgN+3UIuCH/8TWaWGBTY6JxJZHFysyyFSqUmliD0vpag8ru/oaDsW9IaFo
 Mw6pdgfRZifuEP6eP7qiibhqBH8a4evHWh1oBVmYhNvN26OD3oYWtIU790hdGRILWh3U
 GE9feNR37IAKnQwzV70WPvsuFVdMoIBU7aEAhev/5QO08dR3AwQWOZohQoCM70HQiAX7
 ufHCZUEiTSQfqx4yuqu1Az+3vocbPTla6goZm0C5WNmjTXPDENxYC8ZbFAvTOzVYXppP
 EqkQ==
X-Gm-Message-State: AOJu0YyGYARIf655xXIUuWOU49LLEe9X+FvZakDmrrAyJw5cMxtbsm8o
 FlrsWz+jMvzqJy08HauWsBhHc3n2mT1u3MLgFlASwNKZ64ynSBr8pNRGoQgtnS/BBH2oY9mpEmn
 SyMxpEeE=
X-Gm-Gg: AeBDievbOerW5WSUCM2LNJePeP7dYm+OQOZGgkwaHBAu5e4IrAHNXDwi230KFdwHOsF
 Ylj2peVx4aGvo3F3F47KsoUQlwJqmYc17HXe4lbot+j3WKnu4ZsMY3HUxgQIpw8GyI3WQPW98JE
 fugWaDMIWjKen7mQQuUmTeL5F0T7M+LvA8WRpUjDTqhPspAIl8p1mBHtYsWYwzxqkRMMMk1csWY
 4AvT/6qHJYGtf9+/FfW9FvrZK+PzdqBrLIgO3i7SGzIsIkDXiohh9SiipZuSvOkwHW9D+iqhyBv
 OiT/eVL7Jzp6F7wukx2786V4kiceMsFoL7iFjrP4Mn82hiXxu/razkXrrGBqKprUnLSW+gmG4hd
 VR+9TK+guNqfpB5+IUsYoiRC9E7NtLrrCSh87F23HdGTkinu+93LV9pLEZ2IND9wMOVjCh0K8EG
 QG565nRyNAu5b4aUjFwNBHgXHS8qgcO4uIPKn/4OGB7yqsMEL6Ze5wnZWt
X-Received: by 2002:a17:902:db09:b0:2ad:da28:98d with SMTP id
 d9443c01a7336-2b2817be680mr260851115ad.37.1775706645176; 
 Wed, 08 Apr 2026 20:50:45 -0700 (PDT)
Received: from stoup.. (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2745c480dsm277830605ad.0.2026.04.08.20.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 20:50:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH v2 7/7] target/arm: Remove bswap_code
Date: Thu,  9 Apr 2026 13:50:15 +1000
Message-ID: <20260409035015.132370-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409035015.132370-1-richard.henderson@linaro.org>
References: <20260409035015.132370-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

This function is no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8f1afca2ae..e735357395 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2571,22 +2571,6 @@ static inline int sme_vq(CPUARMState *env)
     return EX_TBFLAG_A64(env->hflags, SVL) + 1;
 }
 
-static inline bool bswap_code(bool sctlr_b)
-{
-#ifdef CONFIG_USER_ONLY
-    /* BE8 (SCTLR.B = 0, TARGET_BIG_ENDIAN = 1) is mixed endian.
-     * The invalid combination SCTLR.B=1/CPSR.E=1/TARGET_BIG_ENDIAN=0
-     * would also end up as a mixed-endian mode with BE code, LE data.
-     */
-    return TARGET_BIG_ENDIAN ^ sctlr_b;
-#else
-    /* All code access in ARM is little endian, and there are no loaders
-     * doing swaps that need to be reversed
-     */
-    return 0;
-#endif
-}
-
 enum {
     QEMU_PSCI_CONDUIT_DISABLED = 0,
     QEMU_PSCI_CONDUIT_SMC = 1,
-- 
2.43.0


