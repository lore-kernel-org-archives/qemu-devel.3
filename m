Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F8EEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJh-0000Mh-LN; Wed, 11 Sep 2024 08:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMIK-0002Li-Eo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMII-0007bj-KF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso22965665e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057076; x=1726661876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toDCWGmT6dQ5oakPzXkIqvHFMF9yBsm83fEwIXWum9U=;
 b=nN8mwgdsb/WXkm21YfFYCd3qv1knIQWs+en9Jl0eA62HTfWY/bnii6nTUX03edQMvq
 cpQ0OVynRUSqGyQb8cbbqxviE+HreUfz4UVtGIiv79nDJpth6AmsIZlE1Xy/kZlEEQfI
 9Oa7goKDlk9+tT1blF0vA7is50yrXIsIuhDKhkq+5yquGlbNNCFJONLEaH6UeapbCtP6
 ooMvaoVS98NBroptblwFa8vnc/BjZLZcOA7LTkxFY1DU1S1/A4N6NSI0kA2VZNdBH2D3
 7hgyNvjUSoga3yUO+QWrS5Wzd0mwghSwGeqrk9EyRQk3EWquWXCiuwgJDjHruHjsTo21
 h9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057076; x=1726661876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=toDCWGmT6dQ5oakPzXkIqvHFMF9yBsm83fEwIXWum9U=;
 b=QvvGdgw86KUxEjgX25x6NI9tzlnikqOCvOxj+RHSf+UEQj8B3YEg5xXOfW0Y9jAODE
 cpxf3KRush6rKo0huzXZCeeiYEtbm5N8/RNyD06/uMrQJMu1RnWzopjQiEy4oAnKe2ec
 wDT6+ABZ+T5BF6SfORSTln+g+Z6WTA+hDQJ93ZzjsCMYYhFPcwNhrz8bQ+xs6PqvCLnu
 neaqKXmvo9FCWfK9XZRqwP/KmpykHeUoVbxPSaIvuY/9ZvLaB7A/wZ65rHXnoYNsGxcD
 mhgqWa8lv1FWuy34EW6YVWUM8l4n/byERW/IrdV2V+htnvbCZGNMDg/cClhY/QgdbA7e
 Td8A==
X-Gm-Message-State: AOJu0YxU5DnkDth0GDL2zGFR9fTokKh9O4EKCByRMxqo9gUV99c65Dvg
 KG+AbzaBBqyWawjxu4Faak9oRCnyilbZVNZlf7m5mo6hTzxw8NhUfNPtxQHUMsUVJ4T/vgyxbQX
 0
X-Google-Smtp-Source: AGHT+IGeMAg0QdWnwx1GoDAWPKa8AaQZrvyE0PcZbScmAVMepWhPp4ZBa1hZ8d26rQD9J0xVB+lrBg==
X-Received: by 2002:a05:600c:3d8c:b0:42c:afea:2a10 with SMTP id
 5b1f17b1804b1-42cafea2b1amr106443075e9.21.1726057075807; 
 Wed, 11 Sep 2024 05:17:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb32318sm138784195e9.17.2024.09.11.05.17.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/56] fifo8: rename fifo8_peekpop_buf() to
 fifo8_peekpop_bufptr()
Date: Wed, 11 Sep 2024 14:13:57 +0200
Message-ID: <20240911121422.52585-33-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is to emphasise that the function returns a pointer to the
internal FIFO buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/fifo8.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 1ffa19d900..61bce9d9a0 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -71,8 +71,8 @@ uint8_t fifo8_pop(Fifo8 *fifo)
     return ret;
 }
 
-static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
-                                        uint32_t *numptr, bool do_pop)
+static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
+                                           uint32_t *numptr, bool do_pop)
 {
     uint8_t *ret;
     uint32_t num;
@@ -94,12 +94,12 @@ static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
 
 const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_buf(fifo, max, numptr, false);
+    return fifo8_peekpop_bufptr(fifo, max, numptr, false);
 }
 
 const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_buf(fifo, max, numptr, true);
+    return fifo8_peekpop_bufptr(fifo, max, numptr, true);
 }
 
 uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
-- 
2.45.2


