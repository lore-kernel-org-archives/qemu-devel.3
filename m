Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBE9C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnbP-0006Gc-CR; Fri, 16 May 2025 01:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbN-0006EM-Gx
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:21 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbM-0001Mf-22
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22fbbf9c01bso14480655ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373239; x=1747978039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEdpnrBOTPtpx4cupcWYpTpp82dk3nMUunAlRdaZgS0=;
 b=KgeZZyRtsTn1pbfWbPf7OmFekLJstXb4va4oM6wYmwW6nVDY9AYlN2jHAIhG9c2KtA
 ZFW9f8Fg5AWrKUHYSM1p45C33wykYEtBzFfCy/dglCm63OvSlUh7whYGwqJ65NgRqQaQ
 ERcuC/roUxOgaNKRY4xueCVwiMci66ipuA1piGp34VyGcwPM1XduGWsyIDbjzVGRnWGL
 IR6YuZtsZDmdziGo/2/6TX/DyWKagql8zOtGn/QityS4kqSjn61akrvq4uCA9jFHsPdE
 W9gMcQFQdJ8EFoxISj/sO5KAE5PnZVzxCB/3h7zu4gGhoFHrchpAfrcCuLlwJ2Xbc4JT
 KcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373239; x=1747978039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEdpnrBOTPtpx4cupcWYpTpp82dk3nMUunAlRdaZgS0=;
 b=P3u7U3p4jXQl7Ti8xNlfIrv2nVH8USCfE8lYQM9ikMfjfl5+ZfBK1i21unnw0EzDXx
 4Rmml8bJFy4dvhhLNVitaTgHwdiwJSC6mRZAMpfwWuj7jtZ4m0VSV7RlwznXAmn5ALOz
 xFl4BOI3QqQyIM8Q0NQJgle1PQYz57jojz2WuCZBkgl9XNwMEHr3mCBneDjuu9dAao8F
 nQ+TWE8jF71ZP2u7nny7Eq4LyNTv4RC8yArrSeWx3zO5ZFBaCUMLb0N832T1tnX7CVqe
 gZ3kYp5MCmbdWa2RQfoRqoxG7eXABjEYzLZ4aIJGB9b1Emfdzb90c0SeIuOG/pOSEvwC
 prUw==
X-Gm-Message-State: AOJu0Yx4zLUhPK4vvfISPACrqnlxmN++wl69iLlwlGUoEH33DmWBdgyb
 rmatzOVT2yFQAQ6wQgN9dX4R+3X9uzpGq1nRg2Ia4Y27owfxo2Mbt8ojqgSXYEd6lsXztjr43nW
 lCL6T
X-Gm-Gg: ASbGnctVBP1WCoD4Fudhg/d3VoQiVAqwnfJcuIQnvsnZk+B0nPgNHQCADz1FFpMp3B/
 zQu5568bMJ/nOJDJu1aPfs+PQnP7EC0QmavAPzeHdkKPlFgUT62/dw1+2oZBny8W1PA/latB71L
 wd9XSH/RXg75yZ7rLg1WBjTxoFbxONnkPLJRZwsIiLcaQjwGv6w7gM+rcu5kspVHyOoMsixTcFv
 zKevK5nUMeukxyYzxw2zV2mi9wo92vemZOQ2/yLEo8wYObzmUn96z+LJ025OJ8v4pdfWLmifX+Q
 b3Yx0jaa2jINsFlLbs7V2SvtHZwBne/IvqxQox6+6twiPRdeBsw=
X-Google-Smtp-Source: AGHT+IG8yS0gLwkyDwSNXlvD7vuYuDr4qKJFC6ujr89xAT2mP/Rd0/mItn05JVXm/LkiYq+VmVjFdg==
X-Received: by 2002:a17:903:1ace:b0:231:c90e:292d with SMTP id
 d9443c01a7336-231d45af19fmr28322365ad.44.1747373238737; 
 Thu, 15 May 2025 22:27:18 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabfesm6539135ad.174.2025.05.15.22.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 22:27:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/6] hw/arm: remove explicit dependencies listed
Date: Thu, 15 May 2025 22:27:04 -0700
Message-ID: <20250516052708.930928-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 5098795f61d..d90be8f4c94 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
 arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
-arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
+arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [files('musicpal.c')])
 arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
@@ -79,7 +79,7 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
-arm_common_ss.add(fdt, files('boot.c'))
+arm_common_ss.add(files('boot.c'))
 
 hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.47.2


