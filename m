Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA81C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGxn-0000WI-5N; Tue, 21 Jan 2025 11:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxi-0000US-Bz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taGxg-00061b-Nm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:18:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so67588615e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737476323; x=1738081123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jD9cKuVG+XCXNdxUzPMfstzm3XeEou9OddK//dDoGtY=;
 b=ZomgAgN99xb988bXVVrdspoR08ewc2ow2Hj27290qoAoRcQlevEpVW1pChcuhcN8dx
 HpsQXASlkr6D0wNpBftfF2WznMH7NfRyIQ62skfAh8fhq9abtjcvmkz/rSu5B0bkJMLy
 48SXs7WVx9/FxQ74oK/7n1s7CTogSn6J9be5YeOCnmiEVsWBEuOsSwDLUJVNvREg+SFK
 8xNzHfz3cDH0Nbz0RiJRriGpyks6A7p/xgO6FjPWsbR30+7wq1nfcbNTlXSEuvSJ889j
 PvoBsLXFfXFTRjiM0dXvXy00jT03Z23121tKD+/IV1GDxN33AOm4ot0pALXWZ8KU9zvN
 /uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737476323; x=1738081123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jD9cKuVG+XCXNdxUzPMfstzm3XeEou9OddK//dDoGtY=;
 b=aNU6IFgD6dN1c9jFKY6Wu5ED1HEvED0GFeXSirdU5TnSCGvB1DUhGgALsqBtnMXPaC
 H/4Vr9q8SIqjuLd6TvMG9FWunAt10RGyisez+z+jn+wcrzkW9/POiWdyNBW3D6eOcUNF
 qZ7uMcRGupIFI3nvBVfHW7bhDA1iaex7ZBj4J6Yt5+uHLoZXEYp66OexOwX6VB9kIQ/X
 f555iYxPM+iqVyMGRNU4jP8UFGdX8zOefgpDOIYXSdtkLtv39dGGLHPuIfrZanhuskp3
 YyfZDmwykyRo8vwVhBZ/IxiWWOEzhxkFHsp3s9eLTBduZAdJCPVzCazDTmE2+fqAUJRM
 s6mA==
X-Gm-Message-State: AOJu0Yymw/KSFj4PK1I59x1C4V+hXWpbi1unosPBm10M5JW/efoemAPz
 yCG5wHc9CTrIqInyq0KfpejiKU2nKcj+1jLX6m2mTYz8pHmOJlvi/pzaZ3s49eGbDq8z3uhvSab
 z55c=
X-Gm-Gg: ASbGncsQipgWLT5ZPFJdNAURA0wcjeuM6QyfhcJdnONCb54w+vSZROuhKBV3Nwliz5i
 Mt9dOz2FDE4JTuXJRIrJz/34obdTW/HxqrWOeEVjqyZVqIdl+UEKvNx7JcCUbgaW0EYVKDMPdGL
 PNw53B1eKM7ooAtC+tYfvEQLosAymii9WW9/QKUajOAMWEpNSZfK1k6xvlIVTeTWfwIglghkeUQ
 ddy/YvcHtBzlheJ7xA0BnMbQwbEqaeRI7LDQYUcq2h1cLjgNZTHMTIHYmUPn1AxgTtFdAsib6Zk
 buHUY/kInN9XsYkZkuLEm6Ij65VOt45RRRx8G5lWlXx7
X-Google-Smtp-Source: AGHT+IF7vvsUi381YAGAe41EtW3dijPioRmlnJwl+LbFrjfbgmN18MuSaaQs8D8+VDw6ucoPmrCJuw==
X-Received: by 2002:a05:600c:5119:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-438913f0620mr163155385e9.18.1737476322835; 
 Tue, 21 Jan 2025 08:18:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890468c67sm187575405e9.34.2025.01.21.08.18.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 08:18:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 5/6] target/mips: Move CPU timer from hw/mips/ to
 target/mips/system/
Date: Tue, 21 Jan 2025 17:18:16 +0100
Message-ID: <20250121161817.33654-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121161817.33654-1-philmd@linaro.org>
References: <20250121161817.33654-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

MIPS CPU timer is tied to the CPU, no point of modelling it as
a general timer device. Move mips_int.c to target/mips/system/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/mips_int.c => target/mips/system/interrupts.c | 0
 hw/mips/meson.build                                   | 2 +-
 target/mips/system/meson.build                        | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename hw/mips/mips_int.c => target/mips/system/interrupts.c (100%)

diff --git a/hw/mips/mips_int.c b/target/mips/system/interrupts.c
similarity index 100%
rename from hw/mips/mips_int.c
rename to target/mips/system/interrupts.c
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index fcbee53bb32..6dd97331ca7 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -1,5 +1,5 @@
 mips_ss = ss.source_set()
-mips_ss.add(files('bootloader.c', 'mips_int.c'))
+mips_ss.add(files('bootloader.c'))
 common_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
 mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
diff --git a/target/mips/system/meson.build b/target/mips/system/meson.build
index 498cf289d6f..cf232c9edad 100644
--- a/target/mips/system/meson.build
+++ b/target/mips/system/meson.build
@@ -2,6 +2,7 @@ mips_system_ss.add(files(
   'addr.c',
   'cp0.c',
   'cp0_timer.c',
+  'interrupts.c',
   'machine.c',
   'mips-qmp-cmds.c',
   'physaddr.c',
-- 
2.47.1


