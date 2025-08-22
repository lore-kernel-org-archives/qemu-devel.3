Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1316CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTIO-0002p6-Kk; Fri, 22 Aug 2025 11:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTHE-0001zU-Uk
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:02:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGg-000521-3J
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:01:59 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2449788923eso16880315ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874880; x=1756479680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7GETELPD3VGF6/REM63Q115JGqnxMS395y7OJ9SbQ4=;
 b=MG57EUt17yo8CdFgOkc05o1U2p0+cpX+WQFLb5jjASqu5XSMehXj7GbCci5XPqbD9P
 u8zv7HsN2lpspKjhrVg4C6ZvvIDIp/2cou7wzYPw/noPHYPwYWqSzjM43Y2Jq6I+47Rr
 sAv0KtPl2iS5mxJyiAeJVvDNSBUAh5OJE2myqf/eaoDJsmmeffZfKKvhL489e+r4qLwd
 8nNhJlUiIg3DzqksCOxjUdMipLP5aGveD+ohqg7vnGjayoRCRbM2aeOnvIL/7H6BdlAh
 ZqKRaIxaUAZcDDNR1mOGHrOsAYLtKR8w3PD8NNSvuEX1or1Ml0TavBCUy1V09FyR6rdi
 DZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874880; x=1756479680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7GETELPD3VGF6/REM63Q115JGqnxMS395y7OJ9SbQ4=;
 b=J+4cXLswAaoZHUQATT32reKHUhNTmH1diJT/x8CxOf5lHfJRiLhT2x/hgeQF+SWPXl
 +v3dkg5lFuqpv/7H6OhqczfLs7rNRWbjBIE865kSXh1Q53gxWsEB8ltf/IZWWaFeS15F
 otIFdUzf2IWSoLrVP2b2mt28jqenwwju7Zc3/3S3gSqNIa6Ks+SwcX7eUOHcqrbEj9Q2
 ne7NEex95nYg3kcvHFqmibedTEVv5edRFO+tZcRi3llC8Ex6qYI8me+AcMIBzXoA36p1
 PfKofb5hvqLJDGaQafDQCE/TibRJcFwCya4Ug1s+zc8QRVBRTSTc+AsDZRm/3Qg/eG3t
 bcDg==
X-Gm-Message-State: AOJu0YxmgYgDzQ2BWE0Nc0jf431weU7UTcXtmRkhxG6CpWhOqmqY0fbj
 QKkgNVL4fNkSyXFROSnlOpTWTJQzEZQ2n+5O9aRM0xUAK9Amq1LLhyN2oeIsECFrdBO2bu0kCXm
 j9ed7qGcedQ==
X-Gm-Gg: ASbGncs43M1qwae87eujD1mM7yvgHmgepaejc2vpwQSPs8dt/cvSEdBJqbTcwgqeyy9
 sETtQLkB39kWJBP3iTest8jICLj0+xXbAPBncNAiEkqi9vUAmQRohdaNdZyWAd1aqN3kDlq2Itp
 t2DGz2RqkBiWaryZWXB4sVSumf3Qhtnh75qaR4Ny22SjInfMBI7t74AjtUH9X1oMAO/or+SmP+y
 t04SUAKLYyNCpjiduJVBFefqNbHDX5dPrkv/nZ/Kjrr5qN6i6KrZQKC/yYcZFON7PiutoSoWxUL
 QKWcY7ifKHy0VIouuIK+/0IsqLTQqWXqPdNBYtlItcNE5CxnqHu3GxXonJM4DrC21BkRJV9OlEs
 mtW61qQXiZnCsoGGjgqE31Tw6GaDFM1aaXAWzIf7PRz0=
X-Google-Smtp-Source: AGHT+IFAYwjfrxBcI9mVRV8zO7zjdsnbdIzEU5dN2j4c+g0y38O10N5W2GleyrmyZVJoiZ1zDWGX7A==
X-Received: by 2002:a17:903:19cb:b0:246:2e9b:e7e0 with SMTP id
 d9443c01a7336-2462ee7370amr46917395ad.25.1755874879485; 
 Fri, 22 Aug 2025 08:01:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed5406e4sm85929495ad.165.2025.08.22.08.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 08:01:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 12/12] semihosting/arm-compat-semi: compile once in system
 and per target for user mode
Date: Fri, 22 Aug 2025 08:00:58 -0700
Message-ID: <20250822150058.18692-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
References: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We don't have any target dependency left in system mode, so we can
compile once.

User mode depends on qemu.h, which is duplicated between linux and bsd,
so we can't easily compile it once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index bb0db323937..99f10e2e2bb 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -12,9 +12,10 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+  if_true: files('arm-compat-semi.c'),
   if_false: files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
+specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING', 'CONFIG_USER_ONLY'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.47.2


