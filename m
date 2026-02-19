Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C522AE9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9fx-0006GO-Gj; Thu, 19 Feb 2026 14:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ex-0004To-54
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9eu-0000th-78
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so12341205e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529154; x=1772133954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNQ5yvqoh+4qwpXtrfNc88bhOdsGFi5L2LgElYBpSPg=;
 b=aE9aXJJES4aglF1KxP/X/dyu9zuTtuwZTVzHvnzOyDrQq2bz0hP1Q6YFTPtQ1UtCtL
 sqL4L21GJLf2AwcKjYmEVOGNPU4gU5uDODvc0iPYYBVVa7t4Ty76waGRE+D3GZ/imSXx
 G8cHYOaBmSn64z92s+PFriy+a617h8IuEzWTZ69GAM/3ia5gwCxTUyzxwBUplXMyIqkx
 f3CRWk4dREmFe4la9t5iKoJ5/VJI0Du0902IuliMaARbHbbJT6atE1qVIf7QVaotXOIX
 G3GsN7U8tsN1/e55f5pCi9dogQ0iZ8lTKACoLYM78RUTVX2BSkB42V5TiZim43h8Ddjp
 0cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529154; x=1772133954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KNQ5yvqoh+4qwpXtrfNc88bhOdsGFi5L2LgElYBpSPg=;
 b=wwu81d0DorkJLupB+/haobfo6vvy788oarwlYSDd/RWYghHcSZ6hweD/JSuXztD1Qg
 +kin/sREZ3yyIWNj9g6UnmhzIByVZ0oXumMQCzeegeNbeAQqO0H6TqArx9ToZhFBYaQm
 ZUOyFYROOzaIH/VSz3tRL9GTQDiU8gvtogIfRtkLLncL4k0QQfU3uVVSlkf0LJvJybHq
 BRtv0TTG4YfGFDvg+YfGap5Ryfje0n3adzb36T5FnPC88Pkk6F3+dHgkSVCpx7ll9Xeo
 /H/2JQL0tCH2m9ERb453p1tK0eMZS0iQe7d2jM0R5ba/SWdsaNb51RWB74goSbSZHG6w
 +CCQ==
X-Gm-Message-State: AOJu0Ywd55JXqJj5zD5k/3nmTP/i9DyTims7qEU9gTGdnt7FXVQYRbsv
 kmAEF0Ra5HgAKc85YEuOES4QzPAbguRaN3GKz9qb0LXvghlOg+KsYn6urGWdnkQ6MbIjH0mJJrH
 zQCIynSXp4g==
X-Gm-Gg: AZuq6aL+CnHTW3HZ6xT0W/RhTSwaHkr41kIzfEv6PPX9BBB9O/DjFuIEV439LfebkWE
 9Kb/ReANs0vmZpMXbyCSCrVT4DkTDXfjhCqmY/+GTocLlZDJ+5DXlQupc921EHYg2uCK6whouOg
 ur9neGxmh849cElA3C7UkkoKf50oC7hZk0tQoYS8U7K1Wnthq8nQQ+zDMcbitPoCbmG54oKb+qZ
 zF4qwI7zhAppfZKtwAJomKfeiNldngfJQKoTc8GM0OZgeYV/YTTalDXOkQpYcn+6rSwRDhHJbkc
 P+z8mGTSPQoLeakJJVwAod76e/V5G0uj/hY93tlemgRDMoqeAi7vNbGGkO6DZAsdeUDTraUsuX5
 krFB5ZR3pUX+gjh8XKCBp8mcPfREyC1pI7b8kh0pWrku9X00eatbMgMu2m5bRt1PxF2k8053HxQ
 vDHpPcvucfTokXU6qUYrcjiXfOnC/KkTwHf0BwJ9H8a/B1W7k36wIxjd5o72DF+01ORDUTnIM+p
 DoeR4Aksrc=
X-Received: by 2002:a05:600c:34c6:b0:483:6ff1:18b with SMTP id
 5b1f17b1804b1-483737bde90mr343291955e9.0.1771529153696; 
 Thu, 19 Feb 2026 11:25:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3dd3391sm4379285e9.1.2026.02.19.11.25.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v2 50/50] DONOTREVIEW Revert "target/loongarch: Build
 'gdbstub.c' once"
Date: Thu, 19 Feb 2026 20:19:52 +0100
Message-ID: <20260219191955.83815-51-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

While the previous patch "target/loongarch: Build 'gdbstub.c' once
for system single binary" can be reviewed, it depends on Anton's
"Drop TARGET_PHYS_ADDR_SPACE_BITS" series. Revert it to allow this
whole series to be tested by CI bots.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/meson.build | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 2ae96d68695..20bd3e2f0a3 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -3,14 +3,9 @@ gen = decodetree.process('insns.decode')
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
   'cpu.c',
+  'gdbstub.c',
 ))
 
-loongarch_user_ss = ss.source_set()
-loongarch_user_ss.add(files('gdbstub.c'))
-
-loongarch_common_system_ss = ss.source_set()
-loongarch_common_system_ss.add(files('gdbstub.c'))
-
 loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
   'arch_dump.c',
@@ -25,7 +20,5 @@ common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
 subdir('tcg')
 
 target_arch += {'loongarch': loongarch_ss}
-target_user_arch += {'loongarch': loongarch_user_ss}
 target_system_arch += {'loongarch': loongarch_system_ss}
-target_common_system_arch += {'loongarch': loongarch_common_system_ss}
 subdir('kvm')
-- 
2.52.0


