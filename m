Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD89E7719E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMS-00071b-Lx; Sat, 11 Jan 2025 13:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMQ-00070R-T4; Sat, 11 Jan 2025 13:37:26 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMP-0003u5-Fn; Sat, 11 Jan 2025 13:37:26 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so4130882a12.2; 
 Sat, 11 Jan 2025 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620642; x=1737225442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKrZnbsTuw0Y/FLcZknSpoAChzMgNZQkW7pMKPGttDo=;
 b=TQx3MvZaL+ntt0w+f2aXwBycSKZshhAnCmrqvlhFfEvZHYlZ22xDwgZFxlt9e0pqv9
 1wQoLpBSpU1HWHDGmnYl8/Cop7bKhxkNbig5WwfhCn3Kg4oTrACF7V0MDcKnnkeucJwT
 kUhKZdxHizQTT7Pn6E/AZHaLoK5bew/UsZb3/0BRDCWKXshsLoPqy70bym5cfkWN21xi
 DXw4wjJLM1pSXfz8VX9r9yXxmwQ8px1FV+iafweZmJt5KxjQDTCHBdhHkKsZSZekMjoU
 urI7nwYRg1sK82YK2yPlpDu8vq2pWg98a+Ry5BUHeCcJ0Cbq6v5W3bYbiDrRrVPPIJ4t
 1cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620642; x=1737225442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKrZnbsTuw0Y/FLcZknSpoAChzMgNZQkW7pMKPGttDo=;
 b=CNWvGXn/hY+ELKZRkruMvFcKE4edDemxiAYeAVflUkTMy/csVSa11zOl/R737VvX1U
 QY7TI+Ik5BOlLbd2L3CBQoM6wVklpfkjpkQGhdbF9vbXcDFUMbwIcWERERJ9Fj/WcMIZ
 vu97qwRj1xupwTNJ/GQ/yw00vNApCHnojucdF5wMDq7+cClBlUILVpu0WbAVQJDZ3nTl
 ARXEnM7vkAtOV56nQt+onb8wQ2nXmdCeKY7AWWY+iRpQnFwx9teufR1B2muup6BzCqsJ
 LA3+O3aoIrGLfK6fQ4HP6KsN6NfkkAEEcyP5HCHgKLqUSIF116ACQinKTplLBmUB6R2o
 mU5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5mTn/By8YRUMJRqjVjP1SenaPib0V0a0BRtKAZB4am9oRSMk9NH1/WPsufscfUuYnMAo2gnpKaQ==@nongnu.org,
 AJvYcCXnKRmcIj8oD4j8HI6PQuviOmvlVR09ybIGcA4IR51jbzVMZ8fNJPDyyt6RKJnM5ahLJyrO3rSJEaYWrQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzbl5HyAhSVXE6CfMZxYiStQ86Zpvvj7JOvZta+TcmmwnqW0ZKq
 EgCRVtd46sqgd7z8Y6n6iV2R+vpEJWu9pRvtNZhEg0MrJtkX7G+cejaP3w==
X-Gm-Gg: ASbGnctFZ/aqm1pmtMtxL6/3ojFdDcaIQPRcSh+c/+wi4d0o1Sf9g8unirAsPn+PtLL
 ZuYVm1fW7xffXjRmj5wD2gTSLx7ng0yPUTmY621c1+9+mLNq7meZTz3Sq9dRQPb3kS2wecZbGOX
 UFgW6QQWEwd2qJWh//Z+I/KW4v/N1pA6ItH0p0ERZ98a63W8ic9ZuGC0vS+VbaxELb+J7RadKiM
 ah3ASKgZ9GtcwgSZ8tIHNBl2NNhbmYilN1QCh5Mj64/4AHLBrmqtEpcWcV9s7uXK3uyedV3/G3q
 0erwztBNaRUDGLnEwsNHcQPcEW1tuF1R5VVv53/TOIA=
X-Google-Smtp-Source: AGHT+IHtWrLyQ+lfnYOjHykEJCbpjYc80pqn0wfgoTDYl8TgoY+HZR5gIDBKFNUCKc/mFmDZjaUwCQ==
X-Received: by 2002:a05:6402:5194:b0:5d0:fb56:3f with SMTP id
 4fb4d7f45d1cf-5d972e0e341mr34989711a12.12.1736620642049; 
 Sat, 11 Jan 2025 10:37:22 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 02/13] hw/char/imx_serial: Fix reset value of UFCR register
Date: Sat, 11 Jan 2025 19:37:00 +0100
Message-ID: <20250111183711.2338-3-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

The value of the UCFR register is respected when echoing characters to the
terminal, but its reset value is reserved. Fix the reset value to the one
documented in the datasheet.

While at it move the related attribute out of the section of unimplemented
registers since its value is actually respected.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/imx_serial.h | 2 +-
 hw/char/imx_serial.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index 65f0e97c76..90ba3ff18c 100644
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
index 12705a1337..f805da23ff 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -159,6 +159,7 @@ static void imx_serial_reset(IMXSerialState *s)
     s->ucr3 = 0x700;
     s->ubmr = 0;
     s->ubrc = 4;
+    s->ufcr = BIT(11) | BIT(0);
 
     fifo32_reset(&s->rx_fifo);
     timer_del(&s->ageing_timer);
-- 
2.48.0


