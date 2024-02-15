Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A54C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZK4-0001rp-7m; Thu, 15 Feb 2024 05:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZK2-0001rF-FL
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:30 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZK0-0007WN-V5
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:30 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so1213517a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 02:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707994227; x=1708599027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4H6r4N7AivgzoKJ92Ycqsqp3ekwmltnC77Az1yhOAZE=;
 b=o7etBia8kWjlqIX/A2ye3A4ts3U5Sz3PGf7sckHRX01WntWwcK8ZD/iPLaPjR9PjBx
 Iq36jSKcw2rShZU4ag14e1sJN4eNiHlTHE8zf84gfwiULGM+hBbxG6ewcc41lFiiFs2L
 fN0TNS70uIoutPtke4qai+ow9ox1VemfektzuBgw2SDdfOCQJ4awEd/Amid/aOm9FST0
 ZqnXCYiXyl+0bKvhE1RV2RS4QESUvJOUMgm0vh4wzdVpL8zqFS5OsQstkFS5BlUqkGQQ
 e2EpW1I3Fj7u4jqj8dJ+49f5Zih9cAGM64p5Y3cdFboVmKJphtouvWzzah5yQYV5brLO
 TDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707994227; x=1708599027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4H6r4N7AivgzoKJ92Ycqsqp3ekwmltnC77Az1yhOAZE=;
 b=GARKowtKXxmc12nZ3V/hjrEJYD27gWqvz0BvSQygve0GpzjF0NZtiKxHKSN4+L3gYb
 9vpt371MxB4+khH1sNGAz4ewgBiAVArgON43cobO0V5Z2eV6eHTWz3Hg/7q5Hzs+r48R
 i1RKzi92XDUuP9ceXnz3j+KxxF3zEbZQ63Vr/g0Ye9knjEJGpDTGCRPFR0svcdpw7azN
 VOzrGhq7l/YnW3o0OzIw+igg7pVlVLmlNXX9Ved9AOeH+rJwgWbyKJqzi39D3qPfW1qS
 VAMOz3PfAht3k3X9VtAg9IUqkloyoW+I6v+IztLQe96+BbVIACk7mAX/hacJkuBIYjzZ
 q+jg==
X-Gm-Message-State: AOJu0YyELx3b0IIgysJX9mbqhToKHzRVubTVqef2uyMvVVccEg0Wm/7G
 dGzmVYqVinUs3j0I6j5JwfQQoUVrDZdejYkdIRden21RcpPEpvk5C/uSumG8UHFKrloZ92oFtXm
 6mxw=
X-Google-Smtp-Source: AGHT+IFIWGLI2bxH6V6j3QF49PJeGgYOga5fpm+277dSmAlVOWx2QtxOJUS3gE+OZGXmTkKUj+hf+g==
X-Received: by 2002:aa7:d148:0:b0:563:c54e:f7 with SMTP id
 r8-20020aa7d148000000b00563c54e00f7mr217290edo.17.1707994226761; 
 Thu, 15 Feb 2024 02:50:26 -0800 (PST)
Received: from localhost.localdomain ([92.88.170.215])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a056402428d00b0055d333a0584sm430757edc.72.2024.02.15.02.50.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 02:50:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/4] hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
Date: Thu, 15 Feb 2024 11:50:13 +0100
Message-ID: <20240215105017.57748-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215105017.57748-1-philmd@linaro.org>
References: <20240215105017.57748-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/ppc440_pcix.c | 1 -
 hw/ppc/ppc4xx_pci.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index df4ee374d0..d84418cb7b 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -25,7 +25,6 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 0a07aab5d1..e4101398c9 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.41.0


