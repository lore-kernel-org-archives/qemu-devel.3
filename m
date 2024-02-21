Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5A2C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzK-0000iA-7M; Wed, 21 Feb 2024 16:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzG-0000MZ-Oy
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:42 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctzF-0001C9-2H
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:42 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41275855dc4so8168445e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550318; x=1709155118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BV4BUYH/p7RXmaoiTzArsDf4sWF/v6E5dOHqrTpk5Lc=;
 b=DzMyjL/50C8/xkdUgx6OqzMnHuTdlHHoL/oIIgattKBfNrAQ7ClF6Vz7PnUo9ytoEe
 eRQF5QjIzYzP5oZL0rR9k87zBBe0YxNs11sDY+6VjApXXHPK6ZEiVpKtKFt4CETVq+k9
 xgPV7MmMxv4M/DNs5btHLEL3+oxLGIG9scM1G4ZDjjLEn4ON5/OhgbNihnQRSSzfq3Tz
 xkjyEvSf/h/me/tbERSi5Akc2xTyCpfS9+/2vkOf1wjjUeOvMwk3sCWmKL0FB1iylfCU
 aW+cmVmZ+F+WfZI2JdWXRRrIdeiawuBJYfKN+jkfCr3++RmvsUhQzxix1hEbvUR1Ijki
 VXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550318; x=1709155118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BV4BUYH/p7RXmaoiTzArsDf4sWF/v6E5dOHqrTpk5Lc=;
 b=GrIIwkRYjs+q1wOP7eWYFJFgJAwkUXheNoKdKcYnPh5TWF3vM+4kZtLXyQTwZpbDBW
 oGGdrVUHnBNZXiUrx317D7UpDJ12QyDiqTujyMHBk01WEoxxM4k6yqr/1/6NrihapkmM
 bf/iHWnnsuLpi3LlItwtUV6D94uc5TqaEQD56DlUykq/bjF4A7qOoE4o8ba4U2LQtyZX
 kmfFRMZGoioo8jzDFfS9hAkPjwa7fFx7NJWYeqQ/9eZvSMg/JIoQOvzT3sr74ZM1WSIB
 n//0RwkGx7+Tu10uB5f2n9NnqowVb1vYBQNIGv6qR0vSpxBoxKnVPmkztG/zW5EgwqzH
 ++qg==
X-Gm-Message-State: AOJu0Yy1XyjYdC+kHlatOljyAQ9ARjWYGwYL5NbvaJJIRNje2UQBKBh8
 hQEJFrR+zokKERVnRw3DirBNtIFo2XeFVL8JbQbNQq3kihsJsLqLj64u24hTvgkPcXjot+ggv1W
 +9js=
X-Google-Smtp-Source: AGHT+IFJrwEWy2FuQNI4zcUFbb+uAdmWFWnE0G8R1cTMgvtrg127DHSf4dMuVAvCebl/w9i3y3QDRQ==
X-Received: by 2002:a05:600c:4fd5:b0:411:b834:9c79 with SMTP id
 o21-20020a05600c4fd500b00411b8349c79mr14858240wmq.13.1708550317938; 
 Wed, 21 Feb 2024 13:18:37 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a05600c4f4500b004127dd1f713sm436127wmq.27.2024.02.21.13.18.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/25] hw/isa/meson.build: Sort alphabetically
Date: Wed, 21 Feb 2024 22:16:17 +0100
Message-ID: <20240221211626.48190-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Fixes: fbd758008f0f "hw/isa: extract FDC37M81X to a separate file"

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240218131701.91132-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


