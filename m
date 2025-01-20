Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECDAC02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXj-00048O-Ju; Mon, 20 Jan 2025 15:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXW-000459-EU; Mon, 20 Jan 2025 15:38:30 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXV-0002ac-14; Mon, 20 Jan 2025 15:38:30 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d96944401dso8752993a12.0; 
 Mon, 20 Jan 2025 12:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405507; x=1738010307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dduh5qxzvgywVTMZ79RZj2ewixgRwgKTdJW6HsnUmTY=;
 b=LQeKg4HvlHJ1q90PlT6FXHOpo/i6xAM6CBd9lvnMi3P4HZWOgqadfJpEJ0z1nwy8P+
 w+gJaIihI7m1aU+c4ivxwCCZ8jIZXmHNjcLUztYOva/OGsoaxyddkl2q2fdyJuJvf+h7
 3FOP7oTkztQMRjGfKE2+uX0FVCZBLce8LqOPMjeedXww8fJudXAzDcezzjjCKo5HW5so
 K9CYmwvXZgwMTNsabG9Ct6cKiVMLRL8jX1AeKNi8ulqOzQh4rTY/iYkvsLSb9izOZnSs
 orKUKotuWeig0HVco1Xyu745qjeIDjgdDEwUylzR60Pi6LQJ8vGxffrbN1LgsYNamKcf
 2FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405507; x=1738010307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dduh5qxzvgywVTMZ79RZj2ewixgRwgKTdJW6HsnUmTY=;
 b=MMwKxaVjVsc+Z6LR7QEbEXdEanCBISqIXaxE03dNr+2TMV7cZ6NfJ5PMQ8KsZcVN8H
 Uh0m+lSk1FzjkdMGN3SGwGwpaMOJyrulOsldyVXqs8AX8OsmodC05hM7+bPDExNsPZqI
 W7y4fdo3WUUOHDaQSAhpYQ2w7BcSga0uFZ+IEgBi0/DP7m4YSX5BWZbIWfEydtlFvvbd
 IV9/O1m5W9cLT1mGq4IDehkfptoLz5xuZXXku+uDj7lWhAizElGYt6SX2w6eJvTFFcLi
 KumYvq6KE66MjaDE5OTNr0zzzi/zXvrncuNl8mHZP2LxZRLNIUjvTHjzZjMF0Sw3L7Dz
 yCkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG1fFhpDkMGAF8QKX/w+UuZwTFOzCwaWL+BRmYEAT44ALCfW+93Gt5G1AFLbDR2GcqQM9jbL1HQw==@nongnu.org
X-Gm-Message-State: AOJu0YzwSqKYv8GMXP59V/cF/mF4oaNJiHhErgWLjkAbgvU3O4EjH67v
 OYDIwVHgLvFh7N2Vl7uhM2DoRM7raTg5k/5PDRY2XFD5r9CZH03xTrGN0Sf5
X-Gm-Gg: ASbGncvub88i6gwxR0T//6DL8sIR7u9KrveVRtdckeBB/J0lX9YJXhjG1FB+DGtZrHy
 NAhyaq5wCu2wNdTKa6Ql0kwSV7Yu6NecWeuHuHYOrZjoXx7Rds7UH3VjEJx1PXumtyb1t7XeWqO
 kdlHdo3KQRk6XEAm/ZYdqqQDW+rbKqgN50tUpgoHMpst9bJDWV+bOyTWw2xahS4pDC123yJKai6
 nSSeJvbnu5Fuib1o3g/mcskspHJMJhsTmClRuHf8U8ADF7E9/ct9M6kntG/lX/bf/xt7v1Sbx79
 xlT61MsRLtYj8sxDzAEgVt7trze+WytwdigzymlO8aVmsTV7Bw9qwcQ1BlKL
X-Google-Smtp-Source: AGHT+IEYHyK1T2usOsqekOItcjP2iVn8VtsKNgVmfIzQzGZNZJEvlGa7nFj7j+mmxlxc6s0AjqNorA==
X-Received: by 2002:a17:907:7243:b0:aa6:87e8:1d08 with SMTP id
 a640c23a62f3a-ab38b0b9b3amr1278335866b.8.1737405506640; 
 Mon, 20 Jan 2025 12:38:26 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:26 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 21/21] hw/gpio/imx_gpio: Don't clear input GPIO values upon
 reset
Date: Mon, 20 Jan 2025 21:37:48 +0100
Message-ID: <20250120203748.4687-22-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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

Input GPIO values such as a present SD card may get notified before the GPIO
controller itself gets reset. Claring the input values thus loses data. Assuming
that input GPIO events are only fired when the state changes, the input values
shouldn't be reset.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/imx_gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 549a281ed7..25546221e0 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -298,7 +298,6 @@ static void imx_gpio_reset(DeviceState *dev)
 
     s->dr       = 0;
     s->gdir     = 0;
-    s->psr      = 0;
     s->icr      = 0;
     s->imr      = 0;
     s->isr      = 0;
-- 
2.48.1


