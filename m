Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D67E9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9e8-0002L6-Ux; Thu, 19 Feb 2026 14:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dg-0000eU-7X
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:42 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9de-0000Ib-7w
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:24:39 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so982575f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529076; x=1772133876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVulSuC4MUR7/tT6BM0faiGxtndCWhGDpB8XEO+sPBY=;
 b=fffT89uAHJ6I3V1qV0mQWxF4UwdSGPlUJGdDWqIpfx7ZMONgidOotMoE56yfol+6ST
 UiV9wOER4JbjaFjY6GP87ZuyAwHHtQ8QOdorheVZZhWWz+Ux7yIVsjHICScDz4f3UOpw
 UZHUQhquPjDYL0gmNwIG5qzWDYxVJHcBcmD9r6fN7688CUc5+uLrRjJfoToOfkKJ6UK3
 WOK7dkxqMCyoyaDcSTGERPx1hYHdh9S2wITCapr6I7zOz61OrKIZcsDDMBK39NqfGRL/
 aQ9y8sJL1zD3NUkZJW5W6qN/lk6tXSNZ3LVBGwQyd1W0xMMaVDi/3tWExxYfSY79faeH
 AAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529076; x=1772133876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVulSuC4MUR7/tT6BM0faiGxtndCWhGDpB8XEO+sPBY=;
 b=NGImmGItf8moFFfJfI5KiYgkBvvw3w9kQC/9auGqbU0Undnix12ZUWe4dgPccIm5UI
 qqO5589jo6EEOxIRuZdcvC89xTabuNtxVWj8fQmX/iOviHjDLAF2wVPpPrX2ub/in5yo
 XpIqpCT2Utc/OKo60I9VUiE175SZKckctBxeL/77gOupTSj7ZL6EMLS64toOlpOejsfh
 v1hH6YkEdeVs/Ok+rxd7k37yxdDRFxfE8d9uRg0vcbfnxWWvlLGDyPXzsJv1aNGIN7uC
 nPTWuGpKC1KKoQyjEUjUhVQGq6kWZmxSR81iWogHNLJi/HeeGku97YUSD8gs34d39R/h
 X1/g==
X-Gm-Message-State: AOJu0YwRf6zzyfUQl/F6SK7ROQVlCAgf8yPHOxmmh9lkailjK7I+KaBp
 JN+yigb9G+WfM2wvegPtezv3HxjsC7xBf6b/aLbfM39BAAUJJV7cToodo1SQIHZnZvtMp+PfK58
 53SmdpBCuBQ==
X-Gm-Gg: AZuq6aLOUlvPWoclL/aCot94YdP+zwwC6WAkw4F7rUhVBjBZpUhN9ioG2RIS1XU+A24
 hGLYBQQ6plLoJ3k5thPTrozp7UlsH3F+pX5zNpA8Ux7B3Mut2Xbw5KQybtKnIVm3tjIR4N1eSUE
 /nW5IVmbwOh27qMoc3IDx1iWQWquyP0lxgdi/VMxK/CCWZ286GHnxm/WJFd6uMI1VJHjk0IAuG5
 KM0AI9OlXfI16TnMkv4cu1G3qS0gXvNb+D9gYlRBhqrN8TVURibBCLnn4B38FY9bgHtmtiBI1GO
 eKZ/UP05cLqmDTNRiADnra/hfwWrqTIczDShKr7rtc23YpT86gCkTkMFxxUUJ2GCbNGWhcHu8lm
 hnsUTB0OdSSPk4OwY35CAPKRjBmZ1TX4boOqU6sSD49DenYAoToJDk6i61rrXbCd3Tl8vhoLKkv
 bKaTlhORYrnuJ+aW5k4dQi9ATK3g/R165fs+Y7eK27YRsu8PesAcSwDoA1vazNSq7UsmJvr7RR
X-Received: by 2002:a05:6000:4310:b0:437:719d:a753 with SMTP id
 ffacd0b85a97d-4379db3414bmr37888770f8f.11.1771529076067; 
 Thu, 19 Feb 2026 11:24:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad0166sm51766166f8f.35.2026.02.19.11.24.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v2 39/50] target/sh4: Build 'monitor.c' once for system
 binaries
Date: Thu, 19 Feb 2026 20:19:41 +0100
Message-ID: <20260219191955.83815-40-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

'monitor.c' can be built once for all qemu-system-sh4* binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/sh4/meson.build b/target/sh4/meson.build
index 221700bcf8c..1327507dfc8 100644
--- a/target/sh4/meson.build
+++ b/target/sh4/meson.build
@@ -7,8 +7,10 @@ sh4_ss.add(files(
   'translate.c',
 ))
 
-sh4_system_ss = ss.source_set()
-sh4_system_ss.add(files('monitor.c'))
+sh4_common_system_ss = ss.source_set()
+sh4_common_system_ss.add(files(
+  'monitor.c',
+))
 
 target_arch += {'sh4': sh4_ss}
-target_common_system_arch += {'sh4': sh4_system_ss}
+target_common_system_arch += {'sh4': sh4_common_system_ss}
-- 
2.52.0


