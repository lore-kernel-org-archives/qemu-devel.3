Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B564C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag47-0005Bz-Pm; Thu, 15 Feb 2024 13:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3x-00048F-06
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:22 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3n-0002jV-J4
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:02:20 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d11d17dddeso13848171fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020130; x=1708624930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Ln9r8XNhJVHTgj0Hz40GMoWqZy7m2Vo8THZL+0Jl3w=;
 b=pE9DYsibGvT54p/Xfu7wHXKfOu2lttBIO+Z00OIqVsxYuFgNQJ/sXukfN8mssJ5Rf8
 RrUZ6/n5SK+ZH2YB6Hut54Cn8fQ6azoEFl8EG96I0OWG+b7YfBBj9NCG9HM9l9J8dcx2
 M8NBFG66bhgepIAaHC4f7Yjx+jQebyfOi/w0dmGb02dl9R/ZsHI+oKczGpsHV96AF7Hm
 zvvEb+yDlMZNkPPffyfEYFpsJwjlrl0Df0Fd5cwa/CDDMC2Xhqkh6J6F7K6CCASLBJKG
 vwMMUrM6r3OArjlQNrnPyumBJAtcDdW/5PO3fkQue7/axISiNytLKXB0L9+nJCiZm8hn
 JiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020130; x=1708624930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ln9r8XNhJVHTgj0Hz40GMoWqZy7m2Vo8THZL+0Jl3w=;
 b=jUNcQnQbMvrRADBlpS2gIOaG29H/QGDfc1X2cNo4CKlPc7me+mvRF1M+XNAvOvYSSa
 EnKPOJAMC/AsvBrQguiv2ee0cXSEN4TkbhW+qQxQT627uiAskPTNMt5x8JVV1xtA/kLW
 GokfoJdeRCIv+wrkZp9TyPKf2kYSKKBAQ/XzmVJrbDK/oxkIveNNVeLAoTDoXqTqdTv1
 aJxx/blRPjNi3rDrwYubVyyWxbCNX0lZmj2l6LKi00BuEoORXsYuR2mvQronIik94A3L
 Mex4n8VVe5oiTdOMOcEESa7IjeLR1NcJmq+I3DAZvSbpR03hKEIv8CsBCP3H9Pze7szD
 SMUw==
X-Gm-Message-State: AOJu0Yyp1houKtHUblKfO1wR8XZUT/osPxf/q/nPB79/C/+Or45Z/teh
 SiYY7sg1XJ2v7v4ypZamQ1YuGKK0o1ucD04NRAOeelQroGwjq9oCLl5baQxbO5KD4HCX+UODZia
 11es=
X-Google-Smtp-Source: AGHT+IH0vukX2dyPJHI8/1Z4ZPBEvNvDJ95q6cywCGSBiWFQObBYAkj2nutyMFGV9YjmcSOXUFubDw==
X-Received: by 2002:a2e:b8c8:0:b0:2d0:c77c:b1ca with SMTP id
 s8-20020a2eb8c8000000b002d0c77cb1camr2205587ljp.49.1708020129688; 
 Thu, 15 Feb 2024 10:02:09 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c4fc400b00411d0b58056sm2900310wmq.5.2024.02.15.10.02.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:02:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 38/56] hw/sparc/leon3: remove SP initialization
Date: Thu, 15 Feb 2024 18:57:32 +0100
Message-ID: <20240215175752.82828-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Clément Chigot <chigot@adacore.com>

According to the doc (see §4.2.15 in [1]), the reset operation should
not impact %SP.

[1] https://gaisler.com/doc/gr712rc-usermanual.pdf

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240131085047.18458-7-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 3f86b74ba4..46fc1e783a 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -69,7 +69,6 @@
 typedef struct ResetData {
     SPARCCPU *cpu;
     uint32_t  entry;            /* save kernel entry in case of reset */
-    target_ulong sp;            /* initial stack pointer */
 } ResetData;
 
 static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
@@ -135,7 +134,6 @@ static void main_cpu_reset(void *opaque)
     cpu->halted = 0;
     env->pc     = s->entry;
     env->npc    = s->entry + 4;
-    env->regbase[6] = s->sp;
 }
 
 static void leon3_cache_control_int(CPUSPARCState *env)
@@ -246,7 +244,6 @@ static void leon3_generic_hw_init(MachineState *machine)
     /* Reset data */
     reset_info        = g_new0(ResetData, 1);
     reset_info->cpu   = cpu;
-    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
 
     ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
-- 
2.41.0


