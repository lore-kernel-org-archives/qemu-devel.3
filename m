Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9EB10706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oCO-0001aU-VK; Wed, 18 Mar 2026 06:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oC3-0001Yg-BZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oBw-0002Ok-Ti
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:31:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso60403555e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829914; x=1774434714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMfrcT4w/8JaS+GLgLEbdAlqvnuBLRTQjJxeUizycR8=;
 b=rwstKfZfr0o5psUtzwW19y9UWmlWm9Mm+bIx68I6nNu6V9jYrSx1+GoPcDp4JuwXs+
 GhVwyWNjAzUKBOB3IsxJRZCHXxyEb0iXhlTMRagTrw/SApEMHNGQ+f5z4ZrJRZeYrPDL
 DGJF0853ZyN3u6FBnvOy/uu9FOjqJq1BZKhqrHEsYh77f1wWBlPv4KU7rfsxn5uxs1Z7
 58TbyaAjmHKZL9RoVyn3YE52isjP2a/eo1syzJc0gHYPX0FVUGfWkFSKzrBO7PN3h3Eu
 4LZTfoFfYkWKU7sG4H0OdmK7nQyzLz5T9nJUmAlp2WoWYrpEQmiwaoEqNELOff/WbXnK
 1ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829914; x=1774434714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FMfrcT4w/8JaS+GLgLEbdAlqvnuBLRTQjJxeUizycR8=;
 b=pTTBNJQVHqDfbMwHHC3LgvGlM0PBR9uVxHnEJxk/tRSzICZdzUaR97hle4L2J5BJNo
 p5HWjiGNQT3inEMVZ6yaM5bW3GaLeF64orr01cLwW3uA2puvrbiO0ZuTMinZ76tR6/t2
 +WXh1y09+zPTgRGcG2ngKN+3kf7q41SF6sIyNnaneMl5D0TcEHIWyA8PaEzSVqUdpOgM
 NVHzfjRtX7Fn79WFW5SFQ1KrUq1iEdxpoNqZV6onD0KbaZKD3zjeLnobOou/mKP2PNZQ
 ZdL87vfoMrSuxdpBVN+Exs3ri7PcKI8+Q/9jJQoRU6ueDjX1Yyz+dr806smA327weih7
 hP6A==
X-Gm-Message-State: AOJu0YyPZYeQ3g7nGpDygq2DBzujI74ckG1zsXU7Bby4QbzyoH3u+Qik
 iI0dnJ9uedwa5PZvoPoinAp5ipy4PGBatTIPil99NA+0UdB/3FMHyRMHvY3MFFqPsWA5MtAT6fi
 ecgCnXfg=
X-Gm-Gg: ATEYQzwQsA1cem5ucw1gjdvDz+CB9BvdIO+zawGaFXhazudXoOSE9bAhg5ls2eoKlKK
 cYQgU9ePwmnrXCD40CFv+w8k8DUWu/VUelY4hEdQRcTkP/k9GEAoEQlji8ah9p/UDoCukLChrnw
 Dr1aiZ4/xSH8KDtCEuy5o8ylZ3qWdNE24ucCh4ZUxkE0is7tN2D2RqlS9No7oJ+5NRIEYmZVFdH
 I8jL1FBjmghEBJ5NFTWpAWYYRePHKq8PF+wh0XSJZFJlyE7cq8xUhuGQBq8+oBRmC/MJg3qVaDE
 1GBGNVbEKiDSB3hqTns2JzVEcTFZBEUkFgu5d7LBlVCi+NvHlwE7+Sy/KuYxwOpdCreiuOPufor
 XNdfKchVKO2xd+4cdKo5pb5yk6J1t+MY9f5uQoe64ejsnoBg9wtzMR2+f+CncCvR6WH4IzFGSHR
 f5xruvaetcNrtyyZDDjB/BEKxfkf0+XKiHglVNXIaksHwClolcxcu3pZI7B3qSfsHHmxerHRc+
X-Received: by 2002:a05:600c:8b0a:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-486f442207amr45600085e9.3.1773829914488; 
 Wed, 18 Mar 2026 03:31:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852aa8sm6046099f8f.15.2026.03.18.03.31.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:31:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 04/16] target/riscv: Remove MTTCG check for x-rv128
 CPU model
Date: Wed, 18 Mar 2026 11:31:09 +0100
Message-ID: <20260318103122.97244-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

We had to check that mttcg was not used when executing QEMU with
-cpu x-rv128 as a single 128-bit access was done as two distinct
64-bit accesses.
Now that we use the 128-bit ld/st that access the data atomically,
this check is no longer necessary.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Message-ID: <20260101181442.2489496-3-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/tcg/tcg-cpu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f5..3407191c224 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1305,16 +1305,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
-
-    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
-        /* Missing 128-bit aligned atomics */
-        error_setg(errp,
-                   "128-bit RISC-V currently does not work with Multi "
-                   "Threaded TCG. Please use: -accel tcg,thread=single");
-        return false;
-    }
-
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.53.0


