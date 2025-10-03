Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E301FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTA-00075v-HQ; Thu, 02 Oct 2025 23:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSz-00072F-9Q
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:21 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSl-0001CP-NB
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:20 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-33292adb180so1820489a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462081; x=1760066881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMoeXM28MFdHREPmoHRQpNFp6LnUVRSRZ+UWLkUpths=;
 b=EvvgmdFHnhODErqQIBdkijte/TQGLbcmfYx4rHYfQVuiuDu3X+CXZhJY1hxM2gOPjx
 7zIadpUNV7YA4dB9mBkTNQnsv6nasX60Ga8ulC6n6yTWcIROEIiFsT0hYgsBl+6y53Nu
 Kx5hw1yGdqOxLxYFNJ7fUMjYww4c3J8T7eqDjlUtGeVzeCk4YlUORT6gssYGRQWAEjAg
 gaB9FofdWxRM0T+9mPP2BsFikHDFo8jUjhRmpYM6t5GYdjUbuFtRPEjtyGGLGZk/vJ23
 aFl2dqycA1WBX53KJdmpdgWzTJ73aTrWZnvizjgACmtZEQD7NCnvbaKrl9bZqXiXRW9W
 DlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462081; x=1760066881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMoeXM28MFdHREPmoHRQpNFp6LnUVRSRZ+UWLkUpths=;
 b=uSadx8AAvfdE8QVyWWpU5FiFu6wB1mwbLZs5wzDAOJ4YAVEYzsCQ4NeXOr6hPA6i0z
 McYMn7nloAzd3GA/VAEtZSOz4pgdJH6kBs8NyT2D522jrnBPwwvq0PMkAFsv3/6gKEkT
 SHoP368J22mE7iWII1dVvl8TM5hCXKC58BHSuqQAGlM03r81pl1VI/kE/LJQ1Fmboxlq
 7P4eQVU6/VgKZPNLyN0Nxtk/yTRNOrKL3UZhuusCc0CjmF4kytONW0o8Rd9Zyou/Dehr
 tskO/M5faq2jnPlh2D7jeWxpC3UuibJ00B8FPtkiHncvVOqzjJooOa7vLx6dr+JzVNNK
 Y3gA==
X-Gm-Message-State: AOJu0Yw7VZxuv275LizP8pT1PSSjMsm5KXJITylVhpCwAERuaAzVkADD
 myqmiSNe2pBP6M5tCeTcskySBhiQOpiDuq10hsqlYQULbgEdZdMaDy1wBsSALw==
X-Gm-Gg: ASbGnctAG7ZXrWHlqp6j/QFYF7+KqIXL8otVQInHcsEUze5ppxJMLLoXZRIY+YGg8jI
 acQoR2Al+wKD0Uruthc01gD15+S6o120IjdEb9WMmtkiKU99TeQ27v3aaE4wa3MuueR6BBCebNf
 2R4Wy4mwOED9+q26xBD1LVRqMZga4DiYKlsh0reaWiQeyH48x6SsEgsFI/iuXmNnsp6QOmUeO+9
 ipH1vXi6+wmOSVyhmFuLzxc4r7I4/LLhlbpRWsOf7IAlTEK2J41uFQ4JLEGoX+Od+F4213Dj6q/
 mu2uLDpDsHsIEygH0mEsMWfrJrACgdOfEYBhqVpzfcV8hIWejFmoKvb7B8FwjNQLtQkLXq531UZ
 DrPaiUjkB9F9DMqP6lqjO2TGXuBlukT5TocpY9teErleS5Yyr43PXy1BFhWmEHmN3RcspT4aN4E
 YK6i4supDtHgteb1UCcLZGQ8yTsDbv53HercbZ3oFdA1exL9f2oj3G
X-Google-Smtp-Source: AGHT+IHJx/Ldeq+4Pbb+1cP/7gvm9xF+/72gnobMiekCG3sjGIAYhR/RseT4KRv31wezbhIBZnXD8w==
X-Received: by 2002:a17:90b:1e09:b0:32e:70f5:6988 with SMTP id
 98e67ed59e1d1-339c27b3cb3mr1627953a91.32.1759462081051; 
 Thu, 02 Oct 2025 20:28:01 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/26] hw/char: sifive_uart: Avoid pushing Tx FIFO when size is
 zero
Date: Fri,  3 Oct 2025 13:26:59 +1000
Message-ID: <20251003032718.1324734-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

There's no need to call fifo8_push_all() when size is zero.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911160647.5710-3-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 138c31fcab..401f869680 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -122,7 +122,9 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
     }
 
-    fifo8_push_all(&s->tx_fifo, buf, size);
+    if (size > 0) {
+        fifo8_push_all(&s->tx_fifo, buf, size);
+    }
 
     if (fifo8_is_full(&s->tx_fifo)) {
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
-- 
2.51.0


