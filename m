Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AE9E7545C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRLM-0002oJ-Bg; Wed, 24 Dec 2025 11:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRLK-0002iG-Q5
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:04:06 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRLI-0006z6-Sc
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:04:06 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7a6e56193cso993375466b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592243; x=1767197043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9eWKXFyC8Z6JuLmxA6QqxDs8eZFIhgPCVC+BmGyXEM=;
 b=yhoxI9AAOJrNkRCMrBqXUe3HM7M5zV6qXdUt5okbZQ80GdVz2cChKsuN8fPVRbgw6D
 xBapkVj6TIURDqR8CuJsDfERGBx1hUUWWrtGb2egaHfj2pzAPNB7ENjSWOez+RBPcYf2
 2gw60+DjGRX/nCtOZ6fv4b5S64t8RjV8D1z98GIB/N6Sg9MVnphGy1jU78V9O29pEYyW
 Bw3vZPubHj0BYfQLXmnnFw9kkCRRpwfURC8pRkx/tnhksgYmokMZdggHxXaoxOuDSWTX
 4VhhlgIcQURuI/Tp2sleFUjlhIO0lxm5XKM90mbheUQBqGCiK2wfEjHwFg8bWMROTymX
 Spwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592243; x=1767197043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z9eWKXFyC8Z6JuLmxA6QqxDs8eZFIhgPCVC+BmGyXEM=;
 b=qCAnsNiA41gM0sUwxlkcVfEeEYuUofPEwJkiHOnvzwedAQTYc3P+QOKec0nxiGjbBG
 fJZrCi2FJJ7DyfPJVnDahsntHxBVvUHgubluDGRN4/4CBjD68NopYdNfnEmrM99bE2VX
 i3lSuoXhojsk3YU0sUEykOhXItwVOYweP/Qmxldml5vr4tmvz70g1TIISQIh6gpMy3Q+
 25VMeq+bQjUT6WRaJqRUak60fIW6jtYp1sSdWyhIaCsO/ChzNKMyrlZOLxAfiQtwIuEd
 8C+4X+2sovY0koiPLGq3T8Qq31AnYKPGKq7+KtOt0mQH98dvfLh/Rav03pi8GaEI7n8X
 eFqQ==
X-Gm-Message-State: AOJu0YzW/LuhWWuF0rd2ly+gyEm5kFc6iHq3KpPbCEqxKL598DH7rF8J
 u5bYmrPrj+CjkciZLVavonitvdmCi2uVoli3KpsFwTpMe1k73tYhfEahnci7jZsPqitDrUaAdG4
 JB847asM=
X-Gm-Gg: AY/fxX5uO0TScZUqy/or+91GBcs8fu7nTRKSxJrInje/IM5B0ygV3pqxU7xpO+6uQn0
 a0WQrZiKh1N5j/cypbwvWKzYzATIV8hgjt5QMk940icc4kDGrZzRJqDDRmqyaqFTfno2T/0cdwd
 iytfdbJHMT1QRUwtKYAj+ft60N0jR+ED5/ZyDIXdQlJ7vvRqfDEChKivEZjaqk4vClh4f3Fzn8I
 Sx7SsT29Ez2qeHkwXxMwtN5P88/GyOTRyDVu96+kA+Xn4CHacX3ARyzDO9yCMIPfD1HPJI9p1Xp
 XAuT66VeMZO+CTCRMScUMw6CnLwq/t26kN2MFiamjHarHSOwhHzCxDjJRmKpQ+1UOu0Vhp4RRuo
 SKpXFh9MnRuI2NcedqTd6Q/kV+K39QTzJAUB7jI/fOjwkdReuDwsqk08mtz4F4ixv7eV7E7XCO5
 ccifHUxvJZDJB4wueEMyGz9Y9o34plrCNUdt+eWv1zz3TIiNd5lVmX5WA=
X-Google-Smtp-Source: AGHT+IFzeCX3q+4OHoG32ga2liHAjm/V1RFXHeNod4/8J2fm8rqy3TLYZNJ0msmosSm045UMgeNiUQ==
X-Received: by 2002:a17:907:3c87:b0:b76:3476:a83c with SMTP id
 a640c23a62f3a-b80371d7dcbmr2019059466b.40.1766592242814; 
 Wed, 24 Dec 2025 08:04:02 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f089fesm1794837366b.46.2025.12.24.08.04.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:04:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] configs/targets: Forbid AVR to use legacy native
 endianness API
Date: Wed, 24 Dec 2025 17:03:35 +0100
Message-ID: <20251224160335.88861-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224160335.88861-1-philmd@linaro.org>
References: <20251224160335.88861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

The qemu-system-avr binary is buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/avr-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index baf20fb7f2f..154f58448ae 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


