Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA6EC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 13:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbh2k-000480-3M; Sun, 18 Feb 2024 08:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2h-00047c-Ew
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:15 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2g-0007tz-1T
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:15 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3e550ef31cso46670466b.3
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 05:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708262232; x=1708867032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mdrd6lyD+OAHQ6EU+CbZYbjUquylpmMCAszxB0ULtc8=;
 b=dELGuuXYEwYQv/vEa3EQB/+k3H5fqwn++oX+yVjjMt5dveA79gMcibkQQPoMVB5JV5
 xhjnHuvhnJKbR6euDW1R/x8Deu2Zxo3CDYfTtxox/CLtRKL0khcGYgGR7v9baKpu9hNY
 gGA8FccVuWcOJVcNKyHPcWc+YjrSO2vQNL6mR4dTwyogxOgNmi20OaKIgMCi+ptBmfXM
 V/6SD+c/ntGFPU7qv6RCU0WHfcL6r+EGikVqr9yEFMxf+ntRysQTZ82LWhGGYw4c2bF/
 gKO+frOKDXDC/yo9vawwX4O+am8TqQBAmoT5NiMktXzAjLodX+T11hOfGp2K/AlrkL8c
 v7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708262232; x=1708867032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mdrd6lyD+OAHQ6EU+CbZYbjUquylpmMCAszxB0ULtc8=;
 b=I6xyo787UikahjdsKHDNfbI9RBzXKS+Fblsc/XIbsXnuXzOxVgcOMP9w87Gqpe6qUt
 p9xzmmBFRriU5ldanD9Jy4mLl4NSK8CWLC+syPTFl5ck7waJmFHOce9UuPmu1aBKvG7M
 zeLbrJGA09SdF4BARaIuLYX7SF0xzKZWN0AqAcVzosQobvakU8poT0os45TFiBU2B5CZ
 6Y5qV5uWr8L0afrAqn5H1fnMX1rFreeOJZD03Y3dFZ8kobmr8bKDBZzlTN89eO+F62Pr
 EZG8JZTtTrZUdlgm6V80QoJCb2vk8KGkG7OoOsD/OTBLDXk38vAo3L9aGXFRhSy0dNQe
 T86A==
X-Gm-Message-State: AOJu0YyAP7hm/F/K/2Pj4Dxm+zmTocfF2lLmxD05lZOc/FPPXbegyPGJ
 57dYvROU2kg4jYCKGtGuXTarSlQwei/u0yD8BIJsU+JRfi5cOfazBiurrpik
X-Google-Smtp-Source: AGHT+IGMd+2Cp8gB7CEybE8+YTsZ9Ci7+kWqGGHMGMY4sw9wz5cw36tr7LtnCOcBElL62x6S3qYSMA==
X-Received: by 2002:a17:906:b259:b0:a3e:56d5:71fd with SMTP id
 ce25-20020a170906b25900b00a3e56d571fdmr1335568ejb.47.1708262231581; 
 Sun, 18 Feb 2024 05:17:11 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-149-080.78.54.pool.telefonica.de.
 [78.54.149.80]) by smtp.gmail.com with ESMTPSA id
 jw15-20020a170906e94f00b00a3e86a9c55asm255088ejb.146.2024.02.18.05.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 05:17:10 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/5] hw/isa/meson.build: Sort alphabetically
Date: Sun, 18 Feb 2024 14:16:57 +0100
Message-ID: <20240218131701.91132-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218131701.91132-1-shentey@gmail.com>
References: <20240218131701.91132-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes: fbd758008f0f "hw/isa: extract FDC37M81X to a separate file"

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index f650b39507..3219282217 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -1,10 +1,10 @@
 system_ss.add(when: 'CONFIG_APM', if_true: files('apm.c'))
+system_ss.add(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-superio.c'))
 system_ss.add(when: 'CONFIG_I82378', if_true: files('i82378.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
 system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
 system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
 system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
-system_ss.add(when: 'CONFIG_FDC37M81X', if_true: files('fdc37m81x-superio.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
-- 
2.43.2


