Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445CDC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCqh-0007aZ-2f; Wed, 15 Jan 2025 18:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqc-0007BS-92
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:54 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqa-0005CY-DT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:53 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so2243365e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983850; x=1737588650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DNHrtCXUBQyNp6czmCeP9tPr+zdqB+MqJBbYxRNIgo=;
 b=hamJ5yiL2K5FJXt7utojqV+Mx+ldY8x2X4cVS8CIzEo/fzXHucf0Dd/oGxtWhLo9dc
 ABE5dn3fYoGaRdim3oLXSPxZ4rrKgj8u26EhV3HKHbaKZiqSpbeYBygKFH0qIS6kzf2l
 eL8jPyt4fXpRvy/cuSIl+liXtlJiH75oCxkvaXZK/XtUDhQe2mFnZFzrpWuJuTCyiu0A
 J+L/mrC+DGYwzZFVoNq720waxEoTToJNfv8VkzYT5wzXvQtAF/jdABjcFygY6PXSNg6t
 fpAK/linUFoXHRq3xCFdg9z+SESnASSgjb+DzuwN6Y30f6j1S6FCKvRHawbM50rckDYB
 Vtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983850; x=1737588650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DNHrtCXUBQyNp6czmCeP9tPr+zdqB+MqJBbYxRNIgo=;
 b=R5jkC/Y4aWFmPFGV2Mio2QCDaxPng/ZP9bI0IL5k7xIcVnZDMd95H6g6pGIkdEAO7g
 EfhrouUcwKa1hs0ZS+Dku3PGvBIi50USMC+YB0kFoSdcSYV7nhLjhjMwzQ7bAmACjoM/
 rZcQayQu1iKo8lfOvDvIWdNWWvyZ2RfpZvBgrmGPs62hMo2X9xYZTUIzJfcmjucwd+r0
 QriiFWYEJseVAJ35kRz4aYeY9ikxkkfHDNvHOrLemosumpLmuahNddPD74xGiXAvd81I
 X8exdrQwOmRYdIXWFV4dIPMqp4hT11MM7OrQEKo9RChADu8emlKtlIF61LS0LksAUy+k
 mu2g==
X-Gm-Message-State: AOJu0YyGbRnev1J61TJ7zviARtA4mtoiP16Cwz+i2zEBGYXW4Z0aIdyN
 hDMA9aBd0YqweeuRij5vC9LePZcco6kkqWa6YCOP7WOoWJ4fzwSpGE9tfQDA8bRXkiu07L3ZDhE
 +xlc=
X-Gm-Gg: ASbGncsesiauDmiSBJHiEoTw+L23unJ1zmNUcE/7K/w27LlygvUwlFeL5dXE/Th+koq
 XiCw10AVNS00eozpRmeiJKHii/Jm+oPiUjg11ymQhSNiME4Sh86oSYNL132eeedSAlRE8psz60x
 Ebqbje+b2E5nmCWdeao8yvNZkAlfK0e/FFeslWkjE4yTp8DankYiX44oeR1m4sZhqLEoAAZPn+j
 AIXy/QM6WoKftfmmSeXXzEdgbCrulvID2AT5KrWkAEFUr46VgLZFXCs7hhkUWUNnZOKmvX5pgd/
 jIRWohC50cESCnLATz30sAVMmsur0qg=
X-Google-Smtp-Source: AGHT+IE8BvobjsS4J1B0Sa/UkwX8XRTPMB7NVtCNm0yz1CwICFnZHzJL4qV0gSkbmaYtIC154XStEQ==
X-Received: by 2002:a05:600c:5112:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-436e267f77amr270344785e9.2.1736983849976; 
 Wed, 15 Jan 2025 15:30:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74bfa35sm38536625e9.18.2025.01.15.15.30.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 11/11] hw/mips/loongson3_bootp: Move to common_ss[]
Date: Thu, 16 Jan 2025 00:29:51 +0100
Message-ID: <20250115232952.31166-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


