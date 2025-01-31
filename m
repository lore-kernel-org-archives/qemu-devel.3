Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F40C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDb-0006pC-De; Fri, 31 Jan 2025 16:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDY-0006ha-WF
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:25 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDX-0007r9-Du
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:24 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43626213fffso22827495e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357582; x=1738962382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvpUSNGJl3gdcSZd+8mgaj5Zuz9YSWmGxH935I21O3k=;
 b=Ybs0W1rLMfkR/HR9zun1Y7t/wYmP4zOLtqx1qK/xGuIV6/qurkDLJyFzQ+ngtstnFq
 aS2r+ULQCMpNd8bzwcOAxh2u05w37Jl2yfvq6FIZ98s0y0T9WBpFxFWDGy9/I6rscy95
 gHLF8tsEZ4spX4Tyyo+ppiVMPFdEyRf5hPE1RARFnF6qzm3OlkwdV7jif6E+33LPer6K
 8CuHuqOiWsMDH+FrK/XqscLjTNYWWJI6K0sz8uBmFPrkCJEVERLPDG07t/gF00UxlRo4
 RfjLweDXXg6dXj6E9XEmbcAtoDoU0Rn6UmGjJv5Xh6K0U96/wrmk9305zXJbqnPlhDSp
 ewEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357582; x=1738962382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvpUSNGJl3gdcSZd+8mgaj5Zuz9YSWmGxH935I21O3k=;
 b=mGEuANmpKizrfwRVZ+tZPBpDY9HPQJe3Yo5G05hrnLas+4YvSDwkekapjYKgrt2jGR
 T2fARwJa2LQkuhh9vu7tdLImXcgbakcoUEgwx8aqlHmZYM8YVsIJfIyuZ4w2tW2o3qOc
 /fIRffA/BMcLxSGiObBHa9pInMPcjjmm1UMkOeaiAwcl30SoxOTNeX7tmD4acoCBVaWs
 NLfOYeihpKmk4d44CQEMKlV0a4A+4uoglWxKQnLHFI5bS4/WK7rix9RxaXYGGcglRdY0
 vDs+uDRs0i5DTUJaUqlxRjlCl3myF+YPWeScHTz6ewi34KZIN/VlV/H/GCmXvCXsEwgt
 LA0g==
X-Gm-Message-State: AOJu0YwiSyzU9BizpMuknjjIYUA2lpUeOmq5Ceys5LgLs2lI7YLZ55PS
 n+tBTLTn27HfkykWKkUneZDvppI0NaJgWdWytAU7aPH/ux+vXIGv0PEqYnkd3AmKYr14y9aSMfz
 49Dc=
X-Gm-Gg: ASbGncu1AHAPZULAmg2zWPd4qkPpW/e6LCGayztHBaPX7jXZHxRLmemeDli5mgvQi9Z
 aBKmFKm1CgJ9j/ffXh5e2Mb+izwZm8MFEKs/aV4450Kz3unf15FggVoNT6LZ5wHPPHT/9I5hX+5
 6dT0v7o041z1OocuSWNEG7l5OtCW4NoKDpRF+dHPvoQc9ZL4ymUEZiX7xAKLEfhmfhH4ff66FaI
 qURCExdN6Q7trmyvsKQbi5vShqk7y7XXxGyw/I0LHP0cAfXLHM7X4RhmrSaq5NzqU06KxLaP9Ye
 IqI0USCHb7IqfssRNOmswgroHIUh3lDJa36Uz0zX1VJifms/YT1RxH30FRYDcquvvQ==
X-Google-Smtp-Source: AGHT+IH24/ceA6j9BDYcLq99bSKXVwD7fQ01/7ennyNdyZqA+lGis9hnurhvp1YKwsPJ+hiGZ7nGmQ==
X-Received: by 2002:a05:600c:3b05:b0:436:76bf:51cc with SMTP id
 5b1f17b1804b1-438e6eff2a2mr36132475e9.12.1738357581641; 
 Fri, 31 Jan 2025 13:06:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245efbcsm65198765e9.33.2025.01.31.13.06.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/36] hw/mips/loongson3_bootp: Move to common_ss[]
Date: Fri, 31 Jan 2025 22:04:55 +0100
Message-ID: <20250131210520.85874-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
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

loongson3_bootp.c doesn't contain any target-specific code
and can be build generically, move it to common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-12-philmd@linaro.org>
---
 hw/mips/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index fcbee53bb32..31dbd2bf4d9 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -1,7 +1,8 @@
 mips_ss = ss.source_set()
 mips_ss.add(files('bootloader.c', 'mips_int.c'))
 common_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
-mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
+common_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c'))
+mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_virt.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
 
-- 
2.47.1


