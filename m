Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB57CC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSU3-00033R-2x; Mon, 28 Jul 2025 14:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPI-0004pV-JM
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:10 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugSPC-0002ng-DB
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:17:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-75ce8f8a3a1so2759318b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753726616; x=1754331416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvS2f0D4Exw9s+LoZSdm38Sof/BlFsCywrEIpe+P6Ro=;
 b=CJQ85SKjywN6kWF/y8YIAp3d4LcXBaDw0y9eCju+gQHt/D3k5gDTwgOHQYWtCJRaMl
 bCcgQdB2X2VWsQIfrcm9EVbQJwm120kIJcRNJqYO4s6UNq+2keIFGpZT3VTQIr0jJXtz
 5pxIqwOfLz2cBzW6XfSFVG6fa7ZDW3G0emVdAUme0tslrlcUrX/iTzMMxASDAooJiYcr
 Okcx1JZdDpk8fI90mlwwA+YcHedpgUeA8T1brPo2mg3556VK0S50KW3qtiQFX8x3gdkV
 D9KLPGM6SoDoSc75X5qUfk7pbW365iDXpzVwyonenkUzRr3C8cXlO0jT13M/bWNPLMQq
 U/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726616; x=1754331416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvS2f0D4Exw9s+LoZSdm38Sof/BlFsCywrEIpe+P6Ro=;
 b=WNpjOXWq7PmvXwBuYwLL68R6ohkZE6QIbaloPzsUvrdXBs3aYDS4Bip1BVUnibXKXx
 dgzVUIO2hy1r5zKhTA9UPyDAm0gHxSXnF0wilGHR5VG670XXz16gH4bQ8sey5brPnGT8
 onxzPSBXYd96/3k2siU64Y6j3pCvHjED6pF04fkN7Q+1sBc697bhA9ws1DSmw2HB3GfL
 klwUzkBpgHDD0oe0dx3KHgstH7imVl6q7DI4tC384UtQAlumZisd7nOyTkmfInsh5yzg
 mdb8JcT3yK//qt4a/wqpzfZ/1ozCEScBCGek90uscu0H8TKl+3/TjYkoXb9cqRiq6AkG
 IiXQ==
X-Gm-Message-State: AOJu0YydZg1H4ShAgVQSIpm3MXfjuAJkSPPMvTMe1gOXH++UlfV34cSW
 eQONaUI/HLG9cyMXrOBLuE1OZ8cDnG4vn0oUOZGyLzhhrXIcBoolBXSHRgdXUh7kYLbZZU1FmFg
 +SxNQ
X-Gm-Gg: ASbGnctAbbPBdJOs07iC8xgNXKdz3tX9dmHezboWvREGPY00dW5LD7ZfYmVlfpoW57S
 Gc1otFQclgnCAupl7oC/KIgxA4/NTYSe4h1z9jonHRh9ke7FIyqeeze9BI8klrKmrHKTHy1uhdq
 gqAHEAWlCn8BKT4qMuhgIZInaRcn9j2xhhErhJtXKlAOLDcT2LuVIIjKwQ8aM0OhcKVcpriCh5n
 nyNY99puVafGU1J6J3EtugpMcJC05j/nKyQ9EPyBA/sZ8D0jup7qkIDiFB4yLoyK/I9imk0T6Ly
 7W+LQEFdzhNTq7yNWcOBusWjrY6rTrME7t/zKfRgCbsbEoxz0rKxRP8WcbCIlqlZOTgUC9Q1XeM
 /olfuqmOULcvRDoYMVKDG5xcs/dGh7H1zKiHUKJQuuRVEh4mh1pcu1ytXzKOhia85O/EqCLjfk4
 luVy6NYumQpQ==
X-Google-Smtp-Source: AGHT+IGpf3axCq1sP89aYoWf/YWSdWt3oiph0i2a4+1k2Eg5nOpzsPl+m7/0Exl/W1eeiDUzpkpuBA==
X-Received: by 2002:a05:6a00:8c6:b0:75f:b4aa:3774 with SMTP id
 d2e1a72fcca58-76338f86c2emr18046657b3a.21.1753726616404; 
 Mon, 28 Jul 2025 11:16:56 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfeb83sm5985103b3a.66.2025.07.28.11.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 11:16:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/9] target/arm/sme: Rebuild hflags in set_pstate() helpers
Date: Mon, 28 Jul 2025 08:16:43 -1000
Message-ID: <20250728181650.165114-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728181650.165114-1-richard.henderson@linaro.org>
References: <20250728181650.165114-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230112102436.1913-3-philmd@linaro.org
Message-Id: <20230112004322.161330-1-richard.henderson@linaro.org>
[PMD: Split patch in multiple tiny steps]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 3c9ee548948870c14235e3fa8fb235c0c1c20822)
---
 target/arm/sme_helper.c    | 2 ++
 target/arm/translate-a64.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/sme_helper.c b/target/arm/sme_helper.c
index e8b4ca38ff..8ba3f3a247 100644
--- a/target/arm/sme_helper.c
+++ b/target/arm/sme_helper.c
@@ -45,6 +45,7 @@ void helper_set_pstate_sm(CPUARMState *env, uint32_t i)
     }
     env->svcr ^= R_SVCR_SM_MASK;
     arm_reset_sve_state(env);
+    arm_rebuild_hflags(env);
 }
 
 void helper_set_pstate_za(CPUARMState *env, uint32_t i)
@@ -65,6 +66,7 @@ void helper_set_pstate_za(CPUARMState *env, uint32_t i)
     if (i) {
         memset(env->zarray, 0, sizeof(env->zarray));
     }
+    arm_rebuild_hflags(env);
 }
 
 void helper_sme_zero(CPUARMState *env, uint32_t imm, uint32_t svl)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b66561a5cf..fa568aa647 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1869,7 +1869,6 @@ static void handle_msr_i(DisasContext *s, uint32_t insn,
                 if ((crm & 4) && i != s->pstate_za) {
                     gen_helper_set_pstate_za(cpu_env, tcg_constant_i32(i));
                 }
-                gen_rebuild_hflags(s);
             } else {
                 s->base.is_jmp = DISAS_NEXT;
             }
-- 
2.43.0


