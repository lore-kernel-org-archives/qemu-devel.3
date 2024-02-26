Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC2DC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reevt-00041M-NV; Mon, 26 Feb 2024 12:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reevc-0003qO-PA
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reevb-00074o-Cy
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:12 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412a390347dso10718895e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708969087; x=1709573887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8mgFB9QFF5PJ603vJYftBh86z1nFKmxYR5yaSbjagl0=;
 b=nEVBO3hw767+JvcwHRKc4CyIVLkq4IFIylqPRhUxJO1Tqm+9x8LJn44wEhy6r5Eumc
 6TNmSNAxZfXAVBKXoVsk1g72N+eOxOZqkoRin+LsT8RUWD+E2SZju5LCZ2ox8IWSJYvM
 tkHmtS9IwcHBd2vh5n1TVf3lv2BRFJbx/D2TWmKyhFNzfd4cIht2ONr/RhWTWEvuCtHk
 hFS9CSlNiLEpiFwd16E98xS64NaJsaAXGb6BhsLUMznXZMqCzo9AMY+59T7w2/32eb8D
 1wDQiVho2O3Y+bhdRLAFoGm/cOXODZnI0eYhrQ7vQ3fHiX3ScniEQSlddxRvHFFdwsAA
 BUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708969087; x=1709573887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mgFB9QFF5PJ603vJYftBh86z1nFKmxYR5yaSbjagl0=;
 b=bgAkUmdcQStcktktZTDN/4wgM9ylklL5NcYsUmpakfKLKQgkcvdvnHC6Odwd94f/fJ
 NbWe5LIr5wsJXph6ndO2HY3r65/o8ttTYOUvWcepaFsSYy1DqCOV5UAFYgzsqOWG4spk
 K4cTOW5awpled07fmaBVp2lsZEvXxGAmEud01zoawSklIeTU1i4/lpAZg6evQ37Ih2Zt
 G9Obz45M1IZLkdSsPNvxgZ0DP86c6JKB5JxcMjb6wCjMRiUP/qIZQDQ0MsKIrWoeHRCr
 ZWttufUxokPQVBS3jkBL6kL+u24AqXTojI+SBnj3GztCnnsPQww54ihouy2p/4q/wWT/
 L6HA==
X-Gm-Message-State: AOJu0YysLHREEEv5uOyuEfPqBIqit7jqwExOZGFTLxibJcX6LyLg5y+w
 6s2C5XdQYj1kLMqqZPrzljDnPY5DoRD6vVmvbjOo9KyyzogmMeYcV3nmZx6Y+jMcojFF7o6fG6w
 p
X-Google-Smtp-Source: AGHT+IFYM4cKtuWmKJToAh/zEtlYBHXwu2KWP4RaLxfEYLf1tzVD0wX4lVeWdjlBD69sFsFh0VRx7g==
X-Received: by 2002:a05:600c:34c7:b0:412:989a:f6f5 with SMTP id
 d7-20020a05600c34c700b00412989af6f5mr5761837wmq.38.1708969087571; 
 Mon, 26 Feb 2024 09:38:07 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c3b9000b0041298c75ae8sm2493367wms.1.2024.02.26.09.38.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 09:38:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] hw: Remove sysbus_address_space()
Date: Mon, 26 Feb 2024 18:37:58 +0100
Message-ID: <20240226173805.289-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

(all series reviewed)

Since v1:
- Rebased

Pass address space as link property for devices where
it seems to matter, otherwise just use get_system_memory().

Philippe Mathieu-Daudé (6):
  hw/arm: Inline sysbus_create_simple(PL110 / PL111)
  hw/display/pl110: Pass frame buffer memory region as link property
  hw/arm/exynos4210: Inline sysbus_create_varargs(EXYNOS4210_FIMD)
  hw/display/exynos4210_fimd: Pass frame buffer memory region as link
  hw/i386/kvmvapic: Inline sysbus_address_space()
  hw/sysbus: Remove now unused sysbus_address_space()

 include/hw/sysbus.h          |  1 -
 hw/arm/exynos4210.c          | 14 +++++++++-----
 hw/arm/integratorcp.c        |  7 ++++++-
 hw/arm/realview.c            |  7 ++++++-
 hw/arm/versatilepb.c         |  8 +++++++-
 hw/arm/vexpress.c            | 15 +++++++++++++--
 hw/core/sysbus.c             |  5 -----
 hw/display/exynos4210_fimd.c | 19 ++++++++++++++++---
 hw/display/pl110.c           | 20 ++++++++++++++++----
 hw/i386/kvmvapic.c           | 11 +++++------
 10 files changed, 78 insertions(+), 29 deletions(-)

-- 
2.41.0


