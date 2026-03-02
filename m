Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5F6EB3637
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBMH-0000R8-EZ; Mon, 02 Mar 2026 17:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBME-0000PL-1u
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:18 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMC-00019h-KB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:17 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43992e3f9b8so5095157f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488995; x=1773093795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbAw2Qk1cJ2b5X5jdGPs3lW1hInTRFxpK0ZyxCyCe50=;
 b=VjcqXiiX6HCrPjfhkf3bdyCIGHV9WjXABQohc+dyS4VH2Ql1DbqVxsSIICw97Zsl2E
 FnMJjDIk5dScCle/1EMhNkZPAOU3LS2ZC7DLkxK33IyGyRVqQVAnv6mzeURfgLIgrJjp
 A9SAJRQAXNSEyigBDpoP08qT46EgYM27gWpMJ+d3RfT3FNXeQyhqE7hcwO76EBfIrLrz
 QG/xrnYzUDnuWt1utlLnn0J3IpOcNIt6FwPKLpsOXtRtrWc8235G10TEmNmoITQq/gRQ
 Xj9VBqpPXXL9p2H8dJYnchJ7lX7GmOdk/e8y7RKPpb/aJGlY0DPc4Nnxw/lCvtxEWQg7
 k4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488995; x=1773093795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YbAw2Qk1cJ2b5X5jdGPs3lW1hInTRFxpK0ZyxCyCe50=;
 b=WPZxx2/CFyb/+2pC6jRZ3XA4XPWNioKlNPKAEk3lHW65se0YPZEP8UL+pX0b3O+tym
 UW/oEg6h/cQ3PyQAPeJCD3wADwHRnqZR23968qGLeUNWRwjOotgZTDkq+Nb4bo9scN+u
 RmiQWaggFaw1IYAC06CCjXLFAg4pCwWWE0DdU5xdx5MjevKkoRoslJIjn87CaPZr/aIk
 gb/e2mG/ISE5paUaH6P6RrLkz4zmnUGsmB3HIhOcl1UOS/u/WxKydY/Jvvk9NgPfYU7W
 rPyHpVs69fhWALariotGT0YF7nDF7LPKRen8k9nMd+gIw53WIjZZOnCRbjv3JpoFmIN1
 lyjA==
X-Gm-Message-State: AOJu0Yyytr5ZMdBQNOJC1koDgYvXXtBIZNRuzF44aKPNzwdi8t7mS23L
 HyprIyy1BaPzwfn6zZd4KRZxxRjNX4M6RJwv914d6QyfzxI38aUo1/X9Lbc8Lg==
X-Gm-Gg: ATEYQzxgWodKZVnmuFy20htiLD5tkT2wEeXB12oo01no2zhxDqExGz1W5D3BYiblxE7
 B4qV2CmDGF+Ii8yFdeQpDYwy0Detg/Y4WnrzZcC4ZtUZ14C95JOxl1x+aOhTrQ71jp5Anqa2zp0
 v9MpPpUgH4dDvoSWeYSMasQMtO8bOeD1MkYfxuNawNLmOWhhCtLsYP8zJUzJUKqpis1zELWc1AV
 W3aqPDWz1aUycNG7tjsJNH5lgvTZI7GriXZvmeS/vCMuxGwm4k6puLEblbVeaESggigX1bccJqQ
 cMYBm3UY1VLxx2Cb6dCwoKAdYqVS7O5ep3q+vZZ0o0hZ9ujLQbncHddIZ/xBbWOwLLIzJRF2M6z
 zB7CmgbEcBXNr3AuJp/yBYZl4ygiurpiKELh0ehI/YTEcUODQ2yBJUSdcMr9SpiJkAVxICdnyLe
 tDKf3gsNpea7K0N25sSlQRskKUHbK89Q7/bIGHJv1nW6SvQuefDoBU7/KUwt1Kr/60GYPdOXyvu
 8kTxdqLbXHaNKLsjQZXfIzyNDeaK2tI71clYO70Syownvo=
X-Received: by 2002:adf:e811:0:b0:437:6f86:d097 with SMTP id
 ffacd0b85a97d-4399ddd884dmr18105714f8f.11.1772488994595; 
 Mon, 02 Mar 2026 14:03:14 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:14 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 09/12] util/fifo8: Make all read-only methods const-correct
Date: Mon,  2 Mar 2026 23:02:51 +0100
Message-ID: <20260302220254.1166849-10-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allows these methods to be used in const contexts, i.e. where the parent
of the fifo itself is const. This is in particular useful for Rust code.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/qemu/fifo8.h | 10 +++++-----
 util/fifo8.c         | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 4f768d4ee3..6b476b404e 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -71,7 +71,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
  *
  * Returns: The peeked data byte.
  */
-uint8_t fifo8_peek(Fifo8 *fifo);
+uint8_t fifo8_peek(const Fifo8 *fifo);
 
 /**
  * fifo8_pop_buf:
@@ -181,7 +181,7 @@ void fifo8_reset(Fifo8 *fifo);
  *
  * Returns: True if the fifo is empty, false otherwise.
  */
-bool fifo8_is_empty(Fifo8 *fifo);
+bool fifo8_is_empty(const Fifo8 *fifo);
 
 /**
  * fifo8_is_full:
@@ -191,7 +191,7 @@ bool fifo8_is_empty(Fifo8 *fifo);
  *
  * Returns: True if the fifo is full, false otherwise.
  */
-bool fifo8_is_full(Fifo8 *fifo);
+bool fifo8_is_full(const Fifo8 *fifo);
 
 /**
  * fifo8_num_free:
@@ -201,7 +201,7 @@ bool fifo8_is_full(Fifo8 *fifo);
  *
  * Returns: Number of free bytes.
  */
-uint32_t fifo8_num_free(Fifo8 *fifo);
+uint32_t fifo8_num_free(const Fifo8 *fifo);
 
 /**
  * fifo8_num_used:
@@ -211,7 +211,7 @@ uint32_t fifo8_num_free(Fifo8 *fifo);
  *
  * Returns: Number of used bytes.
  */
-uint32_t fifo8_num_used(Fifo8 *fifo);
+uint32_t fifo8_num_used(const Fifo8 *fifo);
 
 extern const VMStateDescription vmstate_fifo8;
 
diff --git a/util/fifo8.c b/util/fifo8.c
index a26da66ad2..cc4f590b7a 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -71,7 +71,7 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-uint8_t fifo8_peek(Fifo8 *fifo)
+uint8_t fifo8_peek(const Fifo8 *fifo)
 {
     assert(fifo->num > 0);
     return fifo->data[fifo->head];
@@ -157,22 +157,22 @@ void fifo8_drop(Fifo8 *fifo, uint32_t len)
     assert(len == 0);
 }
 
-bool fifo8_is_empty(Fifo8 *fifo)
+bool fifo8_is_empty(const Fifo8 *fifo)
 {
     return (fifo->num == 0);
 }
 
-bool fifo8_is_full(Fifo8 *fifo)
+bool fifo8_is_full(const Fifo8 *fifo)
 {
     return (fifo->num == fifo->capacity);
 }
 
-uint32_t fifo8_num_free(Fifo8 *fifo)
+uint32_t fifo8_num_free(const Fifo8 *fifo)
 {
     return fifo->capacity - fifo->num;
 }
 
-uint32_t fifo8_num_used(Fifo8 *fifo)
+uint32_t fifo8_num_used(const Fifo8 *fifo)
 {
     return fifo->num;
 }
-- 
2.53.0


