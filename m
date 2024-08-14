Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06FBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seEEn-0007KA-BW; Wed, 14 Aug 2024 09:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEEZ-0007Gd-Ar
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:40:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEEX-0004eM-Td
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:40:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428243f928fso65717475e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723642812; x=1724247612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oX+ZJO9GlIxEvNmltPXVnl0FgCfTKQ9x41AhOi1yyeY=;
 b=c8y28m64glR/xWisZBrroEi0aygK92ge4j8pZq4qRANGS/sG0EXwFE7cmdOWE7XJWW
 5rWqUk8tA6Fhrfl+VCXuF8RzVEr4OeziZKh/p8Pr6wL/gauC2nFpGnlihXuNhY3EG8dw
 wbWth5gGY9gRFThwdwvoZK0UWS6NHWnZdySvUUKiO9NzcmZUjaOuafjqJghJ1DHNIJCL
 NSLLeOicCK2WwPDiErmwCtGAvosDEww0HSl3cpnHFsmSkKFv0z7catBpDUa4SRqX2R6I
 dzm485ydRjWEDYOssvdh5w1gi1or6M7jnp3gZPdFJ5BaaX2YvQTlsglmYa0TzZaacqEc
 6pAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723642812; x=1724247612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oX+ZJO9GlIxEvNmltPXVnl0FgCfTKQ9x41AhOi1yyeY=;
 b=EaGIiJ9f5dYfMKMbF1dYFzSO1JYuhasQo3sxZHhp7LC3Bj87CFIQrD4NNTEW6MGGUE
 tQ0eIOuDWqvXfxE+fB0lP+AZd+nO+JCCIAro4YkxRNYDDSomCtHYhiISZZRQ+n0vSNha
 JqR6ftShyrVZ+T2E396e7urM9hQSG4e6r5oimJK3PeBxaIRuCwjgxOvs7m9/oT+aB4Iv
 glVk4bp3Ce6qKnhgaDaaYdWzAXj3juieG84+4DplTu8DmWYpTfXec5Vq2RCyGm6wLsZ8
 yI9h+CWQgYd4Omm4VxYTEV+SyCwzhtPwnHzxpNuPxF09LoAg8U3m/GfNNb7hjcY7jP/Z
 MBjg==
X-Gm-Message-State: AOJu0YyM48xrrEaCu8wERU2jOjmp1jJEmNrY82EkWHg9L9Xdx9Rak604
 rvmwSDVRW02814PW0jOfKJh+j1fcYzIS9uHdSXRYgMevjMedAHBHZKAib9JoxVbfklrVLUKsrQD
 +6CM=
X-Google-Smtp-Source: AGHT+IHFgKMELNwMktbIzke0PrxEUnWIUrbvmw4ZRiuRAMS9atc/udYMxrJMiXKVbDa9DSLzpIcoiQ==
X-Received: by 2002:adf:ca86:0:b0:368:3384:e9da with SMTP id
 ffacd0b85a97d-371778209cfmr2403059f8f.62.1723642811832; 
 Wed, 14 Aug 2024 06:40:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4d1dac3fsm12787520f8f.63.2024.08.14.06.40.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 06:40:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 YunQiang Su <syq@debian.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 3/4] linux-user/mips: Select MIPS64R2-generic for Rel2
 binaries
Date: Wed, 14 Aug 2024 15:39:27 +0200
Message-ID: <20240814133928.6746-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814133928.6746-1-philmd@linaro.org>
References: <20240814133928.6746-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc: YunQiang Su <syq@debian.org>
Reported-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips64/target_elf.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index ce6fb6541e..a3a8b2e385 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -17,8 +17,13 @@ static inline const char *cpu_get_model(uint32_t eflags)
     default:
         break;
     }
-    if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
+    switch (eflags & EF_MIPS_ARCH) {
+    case EF_MIPS_ARCH_64R6:
         return "I6400";
+    case EF_MIPS_ARCH_64R2:
+        return "MIPS64R2-generic";
+    default:
+        break;
     }
     return "5KEf";
 }
-- 
2.45.2


