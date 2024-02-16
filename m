Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C87C48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb0Fu-0004If-UF; Fri, 16 Feb 2024 10:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0Fs-0004HQ-LK
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:36:00 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0Fq-0008L5-Lp
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:59 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so306499866b.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708097756; x=1708702556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOmGAqEBBOEy9P6DsYyadVIEFCheEXAYvta8nSQ9bhE=;
 b=Il9PjfY1GBNrm1H293ZJGyUpt6q+yo6054KPUfrdvkQIPsbWvqWcH5zQYS/5Fol+FA
 QmgHa0uAzzGuDEX792phmJpBUeTZJvL7JdZ/lbdh1SZfy7diLp1PGHpg3wjGzpLR9hy1
 eS8+j0fg7zTlKZU/pTYlf2cTgq2vX0t0mNIPvd+SULimOlZfR0ywlrUFKiYL+IrTEj+O
 kYDFAyMrHUYpT2e74iCph96d8xGgDyIDlizB1iYRCa5nJ0sFOg0NHRsaDcPS3KveG8BR
 0P2YcsTd1tHzYYe4KmpqRWmteowe+pVqDCYc6rKsFVfUmJFFl2/tRGDCp7wiyZdugoA3
 QFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708097756; x=1708702556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hOmGAqEBBOEy9P6DsYyadVIEFCheEXAYvta8nSQ9bhE=;
 b=WktRJyzJ0PSzKX6nBqIb8+TbnOGJh2EApNmZnE8Vl3ziBZ8K4nNBoOrmYjhEfBPMP5
 GUsBu/p6LdHAY695HjJsyQNwQrdEZrW+lJplrvlvL6VMrDYwCXJC3nkE8mbAa3q+bKjh
 JH9MCLFSm8dxZsWEOBYu1HJwUnZElYEaI53zIgj0AZF4HX0skteLvcksbnUUhOvTVzqQ
 2GvkRpWAwQAimlpFzMQgebN5gbMmyqjMQkSxw7+mzJWNTDert5KYXFuoaKDnsZtBlBRK
 ufaQT0KSBGLF1ZKX8/HLNI9Jvcka5DDhcvIfbEf6fBsEBFp26DKw2N9BbPw1HmG7hrUJ
 q3UQ==
X-Gm-Message-State: AOJu0YxR2qgvJemsiB8TvDTqwlJxnSBsDKEmAYXm5XD2cJC8GIjM9gkb
 6lLRq2u+H6CX5Z/TSgEVoxK7055AqQvfJnX/Qm+GuSzOkUrLLrYFPnaGY/9LLN5Y6xnzYEcJRzU
 B
X-Google-Smtp-Source: AGHT+IGBmhb6VOfB2zCo0LEpA88KaKbBg1ovfqo3KF7CJB2va+ushmG+IzCBDpkcDMp91+krbOftmg==
X-Received: by 2002:a17:906:c415:b0:a3d:7d6b:2dc3 with SMTP id
 u21-20020a170906c41500b00a3d7d6b2dc3mr3608466ejz.73.1708097756627; 
 Fri, 16 Feb 2024 07:35:56 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 fy22-20020a170906b7d600b00a3cf4e8fdf5sm44841ejb.150.2024.02.16.07.35.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 07:35:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] hw/sysbus: Remove now unused sysbus_address_space()
Date: Fri, 16 Feb 2024 16:35:17 +0100
Message-ID: <20240216153517.49422-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216153517.49422-1-philmd@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

sysbus_address_space() is not more used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sysbus.h | 1 -
 hw/core/sysbus.c    | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 3564b7b6a2..01d4a400c6 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -85,7 +85,6 @@ void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
 void sysbus_mmio_unmap(SysBusDevice *dev, int n);
 void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
                    MemoryRegion *mem);
-MemoryRegion *sysbus_address_space(SysBusDevice *dev);
 
 bool sysbus_realize(SysBusDevice *dev, Error **errp);
 bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 35f902b582..5524287730 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -304,11 +304,6 @@ void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
     memory_region_add_subregion(get_system_io(), addr, mem);
 }
 
-MemoryRegion *sysbus_address_space(SysBusDevice *dev)
-{
-    return get_system_memory();
-}
-
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-- 
2.41.0


