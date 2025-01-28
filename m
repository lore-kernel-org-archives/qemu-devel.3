Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5B3C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxh-00025N-7A; Tue, 28 Jan 2025 15:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxd-000244-25
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:25 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxa-0001YW-Jm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso40639695e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095201; x=1738700001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZkoSXgK6l6zjPVHbKtolL2udkdTnsrzkLxTFGg34voM=;
 b=z8XKDrsqwwedhhZGUoSTA+2DGaub/K6ZaT6T9/7d4Vt1jwbaAwzlJ4mSn/ivmEd3lP
 +0N0e31i2d8K993T/uBPh+54LWWTFb8yXQjI3sqBxYM9CllO8z5xesrTsbCtAvQpdUwY
 KC1H2DB15r3SkjzqBXtdivwSytsqTpIzFoCaeCjNaXwM+JNHAYxf12G1a5P0HU3OzNix
 nYQkTWQ357kQncVFSoVg9XMhsbEaioN/u+YDI1oXaW6FbjEfq7TSOYTC/9mrmmA+0ijw
 Qz+rVpfJb1W6Qm6j9sVYnQdupD/wQXUyAh58LbV7XyXO8tZtUlAmXwqa+kxY6kZIqXA/
 EGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095201; x=1738700001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkoSXgK6l6zjPVHbKtolL2udkdTnsrzkLxTFGg34voM=;
 b=LicllwLF+AWRAbj401HUsRy1F/PjDjukO77sodxf0mD4RZFtAw4N2BOdfOmQJbknwv
 tSCVL3L/O53vkVhjq8UQBM9fkCXVTb1mMtMfGJv2noPGPV2sqDMfbBghGRsVnFteJFi6
 q6jrXFQZL3qkiHRIrzL16Ow5gSI0qQ74fI0MjBYJU0IgXlEdU8IsH3XRbNDHV3tJMejG
 m8MG0YtFumEZh/S7VIosBCWCm3ErcvtFqrEtDZp56oG2H9tM9SIjHORt+ZdR7lEurN4t
 wN+tvMIF5+Zy3eyvCGpCbBMWW05fhxUWbG1laFAN3CSPQc1lxtSM1eQKJ6CK1SWQTbQf
 LPlg==
X-Gm-Message-State: AOJu0YzQ+JENa+yGDZiMG+u5GXMnt5xon+1EorScLF3SKv3fjs3xNUHF
 2J8BKEvP/Szqx4OzLCN6BkbeDPhFZfsD1OernvPORJAEjE0MzYafWFjYZbmYJZBQHdyDCLrpQ4K
 2
X-Gm-Gg: ASbGnctWoL9lY5htvsGCOliKoQtKeZkMDn25/UjAtfk6LrMx+c9XDOr6DFBXhEbUKJp
 1bgjz8l5D5InDH/n6SbDRRojjI86645rxDraKL5ASh+GMwj8InAnT14qaZljeGibVUokiQgXarS
 O1JGwwstduKhdtq75Xn2EcHdLfMVuHxJRblPMG9ra/fx5VdVbWEDyLbxXu3hJfS0Y5ey2Q+vKV+
 Ss4HtwGjEfvZfkS7Z3qFghROA/hyvqUjFBjQdb2yDClMRVR+r9nstK1zBZHE25dENPMnKfkvKk2
 po6i9CA8dx8OxMNOC3l3zw==
X-Google-Smtp-Source: AGHT+IFUWEeQnWR1WNRFhY6QeCS2MH1XuKt+WJXQhb9NQPIx3FnykdrlW9WG0Us9M3vm4irtPD8Cqg==
X-Received: by 2002:a05:600c:474f:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-438dc3c346fmr2398355e9.9.1738095201131; 
 Tue, 28 Jan 2025 12:13:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/36] hw/char/imx_serial: Fix reset value of UFCR register
Date: Tue, 28 Jan 2025 20:12:42 +0000
Message-Id: <20250128201314.44038-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The value of the UCFR register is respected when echoing characters to the
terminal, but its reset value is reserved. Fix the reset value to the one
documented in the datasheet.

While at it move the related attribute out of the section of unimplemented
registers since its value is actually respected.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/imx_serial.h | 2 +-
 hw/char/imx_serial.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 65f0e97c76b..90ba3ff18c2 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -109,13 +109,13 @@ struct IMXSerialState {
     uint32_t ucr1;
     uint32_t ucr2;
     uint32_t uts1;
+    uint32_t ufcr;
 
     /*
      * The registers below are implemented just so that the
      * guest OS sees what it has written
      */
     uint32_t onems;
-    uint32_t ufcr;
     uint32_t ubmr;
     uint32_t ubrc;
     uint32_t ucr3;
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 7c353fde509..cb6761d40e4 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -160,6 +160,7 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
+    s->ufcr = BIT(11) | BIT(0);
 
     fifo32_reset(&s->rx_fifo);
     timer_del(&s->ageing_timer);
-- 
2.34.1


