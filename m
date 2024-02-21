Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64C6C54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu0r-0006jw-8b; Wed, 21 Feb 2024 16:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcu02-0004ek-KG
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzz-0001OW-Er
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:19:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41276a43dc3so7479145e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550364; x=1709155164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM3OaF5xVJiH79yUFzhlf4BJ4fqxcxDiXY4cqoH9BzE=;
 b=AdpoUhzfMXTC3rmgCYRewXCSVh3cBZKFmYxrAJ1KAbJu9a+BjkahyKyx/Ka+DoK7i+
 iWNk90ehBr8pseI39qjax8zZ6Tqg3pGKFo1tK8kDvdkAbfvlXnnvwg+SFwY9qrz1AsFw
 d9jGeIj9fbNsitQo4JEG3h40lk4FOlEYhzgBBF920oDEX7BQ66uV0t6FmD7XF75nr1Yq
 KMuqc28P8rxazbeo+SiljigLsMWv1ysw8lg/KWm8Le/ZzWAd6mUqYGnFbbtoOqGgRdDd
 dYAPKVMz6+zUfXlHRTaY4tUfq2uaN0Urcg0l1ZHdleGg0HfXOU1Xj9Q1LHQPzECw0MLR
 v9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550364; x=1709155164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NM3OaF5xVJiH79yUFzhlf4BJ4fqxcxDiXY4cqoH9BzE=;
 b=cN0lHutNGfcoFP2/sAkSlk+8MFvM3pLOU1kguVzp+NW5oK5VkW5gfAe5FgHcb+rXoh
 N0MqF7TSQH9IAsTcgbZeW6hWvAALlIwO2ORI2MB50NOfslx7NC4mgAfyAV183SM9af1v
 UzzyIcP3YCiUBrUswjA3ELYv/pTSkwrCJu2NjeHOjujHQF6BpR3iQVSE8cDD9Ut+c7dS
 AhyW5X/3m+p0MrKrcVK5+osNNc9SAPQX6w+lzcB4vq9DaxRLxAueTBjIujbg0kh3RaAP
 ZQUKrH4A8HoF2hLjfnHSCPnHAXDcjHgwt7gkFikr5T366nlu63++0m470rbxFkl1HzTo
 PnfA==
X-Gm-Message-State: AOJu0Yw+e+6+WJs2kkFr9FxUkROsR6PFqb6QX7ZP/mG0LVVoMl8wepYl
 hbjaQ5XnBqS833GY3vBY6x7mH8aQpv+cnO9l2iV6i/stdLpdhcdZk6cWu/SnbxAYCYB73C64UGq
 PrwU=
X-Google-Smtp-Source: AGHT+IH4TzS7Xe0OUBjI/T9APGMkVPdjFJDLtz24jL+Gq1/cmkyG3jbHz2oRavSrZyqQF06q0rLxuw==
X-Received: by 2002:a05:600c:5250:b0:412:63e8:b2f3 with SMTP id
 fc16-20020a05600c525000b0041263e8b2f3mr9088273wmb.4.1708550364663; 
 Wed, 21 Feb 2024 13:19:24 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c1d1400b0041256ab5becsm16906430wms.26.2024.02.21.13.19.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:19:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 25/25] hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro
Date: Wed, 21 Feb 2024 22:16:25 +0100
Message-ID: <20240221211626.48190-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Thomas Huth <thuth@redhat.com>

leon3.c currently fails to compile with some compilers when the -Wvla
option has been enabled:

 ../hw/sparc/leon3.c: In function ‘leon3_cpu_reset’:
 ../hw/sparc/leon3.c:153:5: error: ISO C90 forbids variable length array
  ‘offset_must_be_zero’ [-Werror=vla]
   153 |     ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
       |     ^~~~~~~~~
 cc1: all warnings being treated as errors

Looking at this code, the DO_UPCAST macro is indeed used in a wrong way
here: DO_UPCAST is supposed to check that the second parameter is the
first entry of the struct that the first parameter indicates, but since
we use and index into the info[] array, this of course cannot work.

The intention here was likely rather to use the container_of() macro
instead, so switch the code accordingly.

Fixes: d65aba8286 ("hw/sparc/leon3: implement multiprocessor")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240221180751.190489-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 4873b59b6c..6aaa04cb19 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -150,7 +150,7 @@ static void leon3_cpu_reset(void *opaque)
 {
     struct CPUResetData *info = (struct CPUResetData *) opaque;
     int id = info->id;
-    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
+    ResetData *s = container_of(info, ResetData, info[id]);
     CPUState *cpu = CPU(s->info[id].cpu);
     CPUSPARCState *env = cpu_env(cpu);
 
-- 
2.41.0


