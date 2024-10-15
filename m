Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E75CFC289
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewq-0006jr-RK; Tue, 15 Oct 2024 06:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewX-0006fK-0W
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewT-0005wz-Jq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43115b31366so47863945e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988696; x=1729593496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LcdUzjHr2c6vrOngrhri7Hj4mk4jIf0iNM4JVtguHnI=;
 b=F+g9sTI1J1lvSywbO5qSNkvQ4HJpoqBFlTyfU3wUWhxkA3PSZbG0GiymfKlZjC5pBy
 OS7FLMoAmr2P7go4lc66d6xfHBxRfNSFA5fKK3ch7IPhG/QQvt9HyFj9JHAF9QiYrvDN
 YJbCE6GhmQ0o+PIy6x4m3FnZVqzfm93Hcz5tUPE3X6xrga7PmHrmWRJtJnmE8nUSrgdl
 MhGMTXTtUMu67sarfR9qCFHYX0bF/vwzTVrsvh2YWj+cqbjQcltCe5BpKq1i7mtjXqDl
 tnIzneBs/7Ep/6KEsm1+Vwk6hzzUTR+YjeSTzCmK6QFy2oVDuRQLxxI8EkOW8pKb4Svy
 lJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988696; x=1729593496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcdUzjHr2c6vrOngrhri7Hj4mk4jIf0iNM4JVtguHnI=;
 b=nVZ4iDGJfwqF9e009z0LcKcd4UiRQl8rShErtiIwbpcJvxBpFsND2BBW2h150W3R7/
 6diGzC3xYWMwBjOgHpfLFyKFnRLfGbJP+6SKYk+r9d1Xq47nErhop3GRr3vLwT/vfhPO
 gyWagR53VMG3PkZa6Zt2mq/l+lltwGlsKuOhS+INPgaHbphKdhHhOEX+Ok+rnWGsFNJJ
 ota5CfQHjMObvagUGyKR92+sEjon3Z4sqeFV1fBQdZ31RcE9iNrQIqtDWdDHHOjpLpfU
 trVzF/CoO+GdjJjNeGV4fAls1SWaJm+hIajdy7rCoU2SOi8MDOeAahIl/qwUpZH++4wy
 yQ9Q==
X-Gm-Message-State: AOJu0YyUZEGO5G/YIPeUIhkGtUamqbKs0pd93aPTVHYEm4xNgnZ7fiEb
 1obwTJ6s+0krsINfMmtMh6JvbUh5S6YxXZAYinR7lW+WDm0WfeYpeT2JWA7gzA4/g4EWhBEpVhx
 2
X-Google-Smtp-Source: AGHT+IHR6QralSpsUAru8H/lXX9m5QQjE95NAdbnqpMy8Yxf3E9lVXr8UcLyKo6vbLW/KSUsDcXDrA==
X-Received: by 2002:a05:600c:1c81:b0:42c:c003:edd1 with SMTP id
 5b1f17b1804b1-4314a2b7b5emr340475e9.10.1728988695986; 
 Tue, 15 Oct 2024 03:38:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/28] hw/char/pl011: Use correct masks for IBRD and FBRD
Date: Tue, 15 Oct 2024 11:37:53 +0100
Message-Id: <20241015103808.133024-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In commit b88cfee90268cad we defined masks for the IBRD and FBRD
integer and fractional baud rate divider registers, to prevent the
guest from writing invalid values which could cause division-by-zero.
Unfortunately we got the mask values the wrong way around: the FBRD
register is six bits and the IBRD register is 16 bits, not
vice-versa.

You would only run into this bug if you programmed the UART to a baud
rate of less than 9600, because for 9600 baud and above the IBRD
value will fit into 6 bits, as per the table in
 https://developer.arm.com/documentation/ddi0183/g/programmers-model/register-descriptions/fractional-baud-rate-register--uartfbrd

The only visible effects would be that the value read back from
the register by the guest would be truncated, and we would
print an incorrect baud rate in the debug logs.

Cc: qemu-stable@nongnu.org
Fixes: b88cfee90268 ("hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2610
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20241007144732.2491331-1-peter.maydell@linaro.org
---
 hw/char/pl011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 15df7c1e1ca..0fd1334fab4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -90,10 +90,10 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define CR_UARTEN   (1 << 0)
 
 /* Integer Baud Rate Divider, UARTIBRD */
-#define IBRD_MASK 0x3f
+#define IBRD_MASK 0xffff
 
 /* Fractional Baud Rate Divider, UARTFBRD */
-#define FBRD_MASK 0xffff
+#define FBRD_MASK 0x3f
 
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
-- 
2.34.1


