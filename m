Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F607C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRLg-0001ya-So; Thu, 16 Jan 2025 09:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLf-0001xy-Mb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:59:55 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLe-0008G5-74
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:59:55 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so869103f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039592; x=1737644392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edEeMM294Jj9eaK1cuGwb945w01rmWMXCcUhBjpJv0s=;
 b=p+lCYgyjiyBFnbYLT6ER6eyvdnei2WSrsIiCklnOE2wgC7Ax3d7S93QhD73zubnVu9
 lHOzxBBek4Tovg4ZYyuWHlV0Cg6P8sWvtNwVHClmkDRQnbYR548mBfxuV5P1XDrDMPFK
 CtAnyp97DOK642cAT30dMDZMnABxKEdQLXvruIBHkz9R+NrUudQfSsxv1PV+UZZIVygd
 o0Ew/2HtishYNtjthBXGw1gIvxII6kQdFIZi67vdXWemeF8RBlyADNWC/s+f5kbyWlii
 fDcMHhNSipLHxyyXKTxRJiNMeAHH55qMAtqfKNl7U2a1QgsSwKBQ2g33b8yu7PM2zaEW
 fjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039592; x=1737644392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edEeMM294Jj9eaK1cuGwb945w01rmWMXCcUhBjpJv0s=;
 b=In8y9uqZPJbKqJxiEOvaekhGYTCFXA74qNqF/bMO+hX8Qo0Y0KuJKKzoy34y84KvmG
 eCpYE60+mHaTuzJ4KX6iAtgFeS6PvLVZKnuYpJ3TREWkL7dnJj1fp2eEjVoi6tMGY/oB
 p2SfpNjcj7PABAhK/9xWyT6PljPb+7w39Wi9nOhMoGroQO9epyeOdCKtpr3SOLlMn6Kv
 96GG3YosCZVn6nLmqkr1eThtLi5k1lXK4+rn/NCR/ptwrzlQuTEM5EEoCCXxt9LPv8s7
 5zKcDkoFVCYmSoJMr/S/mLI+7onGmNt7fZnhx9s+WRsqWQegCJ1BDdx7ZKUCmKqGy90h
 x5tg==
X-Gm-Message-State: AOJu0YzQU4gpd0IoSIueUmcp1TeXIqvx+KKUuF1tGXMY5sPRczsjwe2c
 msKOzpeLD+U3GJEe9ldXZnRfkyoOCcYJGgKYzyeIKj1GO8sLdCNethKJ2UJnHomBnxvC6GbsjcP
 muLw=
X-Gm-Gg: ASbGncv+d4m052PjnF9tTyuF0ejZb3RIa5udEYhNxXiFyvYrE9DjIBRnfIDJZ0RRGcj
 f7C0rmZqj8L0cpr77tzboI0lGCDLYn7gZScsNeP/uXNNUBRryZf8sL8jwq3mndXoTYnVdjVjgZC
 diRI0O6rV1f5bwtZ5MAAekbuikGNiukuaoGkw42XFQUTVv0uDEkAtyzs6EsnjTe4tPuew2D+mF5
 Jf9PzeYcuxm9AiyX/mkBniHDiWG1fg9/EfiZ78b7a/GsQGYB3cgEg4tTcjxkc8iBJXeKTfaYaID
 eeNdXmvMuf1r7aBBkorCTUjeSXsEVJc=
X-Google-Smtp-Source: AGHT+IEh/AgKZyY1I2j1uuqP6nQT+sNAh2qwlQTGWbLLZhJjVU8XXklD1XBAO5XCAOSWIEXealXpgg==
X-Received: by 2002:a5d:5986:0:b0:385:e37a:2a56 with SMTP id
 ffacd0b85a97d-38a8733a214mr28849597f8f.52.1737039591769; 
 Thu, 16 Jan 2025 06:59:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32150a6sm95071f8f.15.2025.01.16.06.59.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 06:59:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 01/13] hw/arm/virt: Remove deprecated virt-2.6
 machine
Date: Thu, 16 Jan 2025 15:59:32 +0100
Message-ID: <20250116145944.38028-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99e0a68b6c5..3bb8a9c7bd6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3606,15 +3606,3 @@ static void virt_machine_2_7_options(MachineClass *mc)
     mc->minimum_page_bits = 0;
 }
 DEFINE_VIRT_MACHINE(2, 7)
-
-static void virt_machine_2_6_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_7_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    vmc->disallow_affinity_adjustment = true;
-    /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
-    vmc->no_pmu = true;
-}
-DEFINE_VIRT_MACHINE(2, 6)
-- 
2.47.1


