Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE5E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSLY-000535-03; Wed, 08 Jan 2025 04:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKG-0003xn-2I; Wed, 08 Jan 2025 04:26:14 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKE-0004p0-Eu; Wed, 08 Jan 2025 04:26:07 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso28025980a12.0; 
 Wed, 08 Jan 2025 01:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328363; x=1736933163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fs6DjGCcdE+uixmXV2Su2ClqzCx3jJdPOZ1E1qUMw70=;
 b=HzpZ8LHpCXR62ipeE/AxTEjvjifSOzQHr+wePIAioKKProLTMjpmrgb1rR1ZWCTdZL
 E9Eaw/Sy76LYf4PZuLy4+hiuDbg9kDr1gWXz4CCGytMUcUWfufM6IZpmDrcctEPdz+ko
 zQ6mnsLH97ohxE4CkRyW4exjgYcTsU9RIpf24DsUZuKMSF0pH+pE4Ez3x23oRoWyZq/o
 HoCDkn5xtifVJxV/kMT9XpmDnby+g0Jk2aCUttrPitth3zOWQxSdJjs0IFP1V5vx8Twi
 V1fmOKx3Z5V54e+xCg2W+gkNNHUjASRBztMwMG+UiPAPWcyutxM325xv+bbA0ULwGpAj
 iWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328363; x=1736933163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fs6DjGCcdE+uixmXV2Su2ClqzCx3jJdPOZ1E1qUMw70=;
 b=pP238RTg/seakgGYu+rk4s/VPt6tw/HrkD9krh2quFQJv0rSKcb3v4MunNHnCAr07w
 9HaMY+KaoYfOUNkxDjGc0Eh30yLJfY8AMINhg3iACPpj9xVEaXTXaNUXva2rN0K0F6uQ
 +RccgS9sRJgdrjRs89MMApvHkmrzo7VNP+XvFyO211cXGQfWbVD691VoMrtSHM2ZNua9
 e7+hGHyVvYaxNKNCoBkkSws4dBQ16F51uL4x/gR0a/DqKdNw5RGfHc6z6EY+RWCMhq48
 UEZNDambhse0P0EacH0LfB8kAmm1mmnLZiYTNxGNrCdLCgn3hHWGb7nFSs+bWT4nNnkW
 rDKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY2M7WVzFAhyCgQdCak6HKEUy+b4GXJzCNyIq6M588h1FDBueyEnz6NHQoLZGY1EEdvuMhi1q3XQ==@nongnu.org,
 AJvYcCWBGJFy05IXmH8z/ezGJbljd9AJTNmEWdvoZnsie821Ut2XIMNsj/5Km3NLatgqiBNAbGUtWVP+HSGUDw==@nongnu.org
X-Gm-Message-State: AOJu0YwCs6N/SXGiGkSpuOUsqc8/jt+tmBE7LFNdTcGP+GjUDYTmn+mB
 KLGnfSo/eW0X8rpRTS2GS4XuA4JrG0e64WbzxzInfz/LnfrSRFAeApx2nYEs
X-Gm-Gg: ASbGnct+TVlSEPPnSh6NDdPxI+ydfNiv/+KFg8ZWQHkSlTS4vjCHmzPYU+OVnHdKW7V
 WR9b6dozu7stnH70Cq84wiU2fKvX8parzyIirOzLUWzGdYwqTzsZeaxdhvDJ/q7hRnLxsGss95s
 iZ2rGD0ymyv4Neqxo9cRl92hinFxXfIZIVP+NRItKwLtUYmeXrkbSreofLnIDDDzgvUwCNqOZxZ
 Y9yYcLul8P9OFxwF3aD5GuoPrN9cuEQoS3+MDFb2nBfjj1x7dHJFsgbKd6YCTLnRIuGrvVov+/g
 hTqHxSGEdx2/Q6HWRS68Sse4EQvCSpFl+nedavbp3wbgFzc=
X-Google-Smtp-Source: AGHT+IGHNLsXgqgzzRHrOSFFAiuB5D72sJFKZmgk3zOb/nTianpJix3O2TyoK6rTfZXEBrHE3/fPBg==
X-Received: by 2002:a05:6402:268c:b0:5d2:d72a:77e4 with SMTP id
 4fb4d7f45d1cf-5d972e6c9b0mr1687005a12.28.1736328363114; 
 Wed, 08 Jan 2025 01:26:03 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:26:02 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 10/14] hw/timer/imx_gpt: Remove unused define
Date: Wed,  8 Jan 2025 10:25:34 +0100
Message-ID: <20250108092538.11474-11-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/timer/imx_gpt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 2663a9d9ef..11eca9fa4d 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -20,10 +20,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#ifndef DEBUG_IMX_GPT
-#define DEBUG_IMX_GPT 0
-#endif
-
 static const char *imx_gpt_reg_name(uint32_t reg)
 {
     switch (reg) {
-- 
2.47.1


