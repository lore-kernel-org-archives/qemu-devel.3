Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BC8F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62R-00046m-W8; Tue, 24 Feb 2026 22:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62P-00046Q-Hx
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:13 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62N-0001j7-J1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:12 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43989bd056bso343764f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991890; x=1772596690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+aQ20pkuM7Svn8/+j2lniQi1nw8L4rNqCY4KxipexU=;
 b=mDAz4wiSF2CMJ+vlNLFl98o4q4UxJUQMGULooUanQvCA/k7BqsMcJO2jnvd6eBhs9a
 T2CnX5DBhC8bgKe/LICfNafKLqe4v0iYoXFurS/6VMZO8WYP8JTfo6nKxKQ8T0yVZ+xq
 IPYGtTPhxQKc/99GqRHTOPLGFuPyrGl51hyQzVnjpjyaTmp3KKz7831ZcQKbc0bbdthD
 oFUVw2tAI/fVO5/Q9zmBmrtaZrdcRb/MTSCpV5eE6Pb7whjyJWaQ2IhA8r1KNLcrBFS1
 lCpv2Xp2ojmkx3RLGuWntEGheteuu3dIsvjACJLKL/I96WIts39WGmGa21iOHC022Z2Y
 bLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991890; x=1772596690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p+aQ20pkuM7Svn8/+j2lniQi1nw8L4rNqCY4KxipexU=;
 b=qkghGV3oUaAXfpPyqY/o6bS5E/7S9rP4y+UHR83Th6GWIH18McahQ88KOErlM6m5XC
 FazlLERmvig4ii07Cfb6a3Zw6hfrdLsZZW6qKoPY48T0Gm9y+53MQwZO3riFwizSPVUi
 hpI+6pb3apSLq9MGnRfJ7zu2fsEcWmi1bgtslgJpiUioFDo4Ovo8iJQs1LNj4ClLy8uL
 dGZB/3hujycD25KGeYRqHdReskwN/AP1+q7OHOOjRa9dEWf1Y3x5GxPebhdMSTA+HOZk
 AsbfDLiExiRhctoq7Eik1xPNFh1p86PVSVV8Rhozv2v51KcWfVyMyaHCGK5wa2YXyRyR
 NTRw==
X-Gm-Message-State: AOJu0YyKHEyLMDggKYWZzabVvquQwGhvPgUcj7spFfDDoHJ5IoXqCpu4
 yJj6tetZln0eAzRiv9+g9kk4qyqbc0IY5UWm8U4lnnK+6jhIO9KlDWBf9Ja5JTn8r0hAgaKo98z
 JtRVcsX0=
X-Gm-Gg: ATEYQzzo9YRvjRVfJ/G1SSSYs59ikQEBRGBRwvjcVQ0IMzQKPKY7huTb03j383ReaIj
 JnxE2Odui93yMU/ZCYHpKFclxWQ7hwBVwhcyjn8Zb28UsQlUlKElzBCilhbrxH9xEP4XTZtJM7Q
 CGfAHZRcWr29Fp/HRw8RTL7gaLLIARxgqLDgpMk5kFvCqfYcQWET8wBYTpJCSCvij1UjvnN5zC2
 YUI958Eo+g6e/j3EofSiUWRU9tBY3QMvadC27Bqe3lYE0ibtMeo4UCb4+dIJX7z2HAsSFy+q7WK
 Q5DpK1eGxW0q1YDgBIGpg9zq1Bm2Uk0hFzb2Y8O/+OXm76mPSJoY6c9naQcjA6Zyv5hHJD/Aixp
 gbop9oS6F564fB2V1vrRIydpSFvRF1mKLmauFPec9D/xyNAbHI3FhGlaCiPWHb/RQaCEyS0jhsL
 qUSAwWP1OjFzHqJDEy/rfP7u5Dg8/kL/rzLKH3Ohb0BArh8rsbzibFzgbRR5n4M+2Ah9ajfab8
X-Received: by 2002:a05:6000:2483:b0:439:8559:98b with SMTP id
 ffacd0b85a97d-4398d83c0ffmr3744395f8f.9.1771991889610; 
 Tue, 24 Feb 2026 19:58:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9ff5sm32786361f8f.4.2026.02.24.19.58.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 04/11] hw/acpi: Always link QOM interfaces with system
 binaries
Date: Wed, 25 Feb 2026 04:57:32 +0100
Message-ID: <20260225035739.42848-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Now that acpi_interface.c only contains QOM interfaces,
unconditionally link it with system binaries, regardless
of whether CONFIG_ACPI is set or not. It is now easier to
deselect hardware models depending on ACPI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/acpi/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 66c978aae83..e1e848327b9 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,6 +1,5 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
-  'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
   'core.c',
@@ -36,4 +35,4 @@ system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
-system_ss.add(files('acpi-qmp-cmds.c'))
+system_ss.add(files('acpi-qmp-cmds.c', 'acpi_interface.c'))
-- 
2.52.0


