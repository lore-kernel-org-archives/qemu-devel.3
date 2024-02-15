Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27B6C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag0V-0002Nx-VR; Thu, 15 Feb 2024 12:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0T-0002Gh-IW
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:45 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0R-0001aU-GZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:45 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d1094b549cso16234121fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019921; x=1708624721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8Q7JMG8zjBMQCOseTC/pxZZVdCkiwcgzQoWO2YHIuA=;
 b=iLO5hOgoUCOpbTwFk1j/T5TF48CUbqBz1hEGjSNTN1CAQi0WbqRsOiL98u+4nZq2EA
 EpFeZH7ZJ1tnI7wgk4J/DmPGI5bHzd/yWJQLZc/ED6MYuaMK6tHg2stVZDumIYF4Lpb0
 zZfdXm2oadS6mEBHuQyjuAAOKaOI0e6ijcCyYvPfi7auhRHfndxwiBt41ZqVB5sXODGP
 Yrw0iT3qH7PY3Ufy4Lqv5407Dl4wgAc4ed9UxUjm0dH5PWuiumB0Kkci7W9vth9SvbpC
 syNZVEcaJfLvehkZdsqUxC7SLG+JmOhwPD45m6VoGlEBhe7fXMXJN7hIu+og8gglDWKK
 ChRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019921; x=1708624721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8Q7JMG8zjBMQCOseTC/pxZZVdCkiwcgzQoWO2YHIuA=;
 b=PbZSFFFe95FgbQfRhU+YMeiUG4JXWxsTLboUApjgMJ2dWujHlB+Z5wws5YmwizNvzk
 XKiXri+rMr6ovpbH1OOhRKn1j5EahV4NjpdVG8hvuK9jYIWwK8QqcihscCrbOIWWX2dc
 91xvpqHpjRDTHbo/Y2jyTfuWrCyo6XZdXAyaih6akhxJcMlPKQZKdJ5SXEzJV2Fn5Rvy
 1zIOPKXGxBcCjo3fYUpZUXb1ir/J8mekSwIIUzZKROb5Z7YFs7LlGHl5mKo9VMWk3Mrl
 lAjqhmewVyhxhzKFBeUa8JNYyQtmv6900zWxKThYMUVl5b8v05N5XguMb+NWfyPRXJtU
 laBQ==
X-Gm-Message-State: AOJu0YyF56RdiFm6aJsPj+qI1K9Bct6u8R7+fg0mDHBgSB0kCB0mr73W
 o79hISJX92KKqwoD1uwPY2wGgwITcrgOioO3TRPSYpuy1KnC6hHRrcqh5JFzKEGlC8ovbo6g9uS
 o2UY=
X-Google-Smtp-Source: AGHT+IE3r1xqVuIZgf9E8S42MgxdjYuv9KqdxDYlvvbwJC5je2S/DZixu6yWDGi+pnO8gKs2YFSHtw==
X-Received: by 2002:a2e:9dc5:0:b0:2d1:788:60ff with SMTP id
 x5-20020a2e9dc5000000b002d1078860ffmr1968176ljj.16.1708019921454; 
 Thu, 15 Feb 2024 09:58:41 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a05600c190c00b00410bca333b7sm5913132wmq.27.2024.02.15.09.58.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 07/56] target/mips: Remove CPUMIPSState::saarp field
Date: Thu, 15 Feb 2024 18:57:01 +0100
Message-ID: <20240215175752.82828-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

This field is never set, so remove the unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-5-philmd@linaro.org>
---
 target/mips/cpu.h  | 1 -
 hw/misc/mips_itu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index d54e9a4a1c..ef1d9f279c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1174,7 +1174,6 @@ typedef struct CPUArchState {
     uint32_t CP0_Status_rw_bitmask; /* Read/write bits in CP0_Status */
     uint32_t CP0_TCStatus_rw_bitmask; /* Read/write bits in CP0_TCStatus */
     uint64_t insn_flags; /* Supported instruction set */
-    int saarp;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index db1220f8e0..d259a88d22 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -516,7 +516,6 @@ static void mips_itu_init(Object *obj)
 static void mips_itu_realize(DeviceState *dev, Error **errp)
 {
     MIPSITUState *s = MIPS_ITU(dev);
-    CPUMIPSState *env;
 
     if (s->num_fifo > ITC_FIFO_NUM_MAX) {
         error_setg(errp, "Exceed maximum number of FIFO cells: %d",
@@ -533,11 +532,6 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    env = &MIPS_CPU(s->cpu0)->env;
-    if (env->saarp) {
-        s->saar = env->CP0_SAAR;
-    }
-
     s->cell = g_new(ITCStorageCell, get_num_cells(s));
 }
 
-- 
2.41.0


