Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87194CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTC-00076J-82; Thu, 02 Oct 2025 23:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WT5-00073Y-VY
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSs-0001DF-MC
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso1305847b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462087; x=1760066887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVHDxeuFLHNMsQQgp4hcMXnofXDcnErbdO9hDFAxj1Q=;
 b=JfJtBdf56i4Ek6Uf86SW+v7zDqC9NEAAEf4sGr9X1WDEmj1lxMRA0h+HyTevB+oOJI
 haRM6kiq1I/qjtqiZMhIu9PT4ILRGda9d4yBbAVrjJKHpcz+rdrCBN2ZeeFH+j7d0dJk
 e0v5sjoiQjbg4vVrJNZD1AwVKl2NDFfjS9wS3ki0xVOLehS2az202ouyWz4zzscS/6UH
 9gCp7wuiW/TWvXL9Y2+zGrVx6K5yke1BtP8RXokE/wzH5dlSOrwsj1neG4TItMXRNJIV
 8u/sr83nEN+lq0tW0c9Trk/ojZEtGUEOrwJm2khHrExJWesTYXS7tpSZewLFWuhemqLW
 Zh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462087; x=1760066887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVHDxeuFLHNMsQQgp4hcMXnofXDcnErbdO9hDFAxj1Q=;
 b=GiUryjxZ9UlY0DhmBXtu4chU29qUKw8JxnXBSxFL/D8F0ee+G9a3mibZK9grYIXZF1
 Gw7V4gQNaJDPId+pn3t7WaydKj/Zx8tbXXYH3HbF6w+CXaXDqAqoqyJe1v8z5hYDQnXk
 PKb8zRcIAgIOLWQEwWTPo9jKS47QyTa9a85EbaDJTIgq37TCxtvXDwq5RpftxqQQbLfO
 kFPvLUewOzg+hsHrW2RtUAtS0jcSyiQ3YvBxFN5gBaNyfE9FAKjfoDqEg0ksi5G0+KYk
 xFDQKX0IqFsps6yglelNdxaYenH+ja60mJ1BXt7/gH+SlpPR2ma49iDrmTjFSSGm8wd5
 jE2w==
X-Gm-Message-State: AOJu0YxynXXrluhW4vYKNG/vOh/OYHqXcvYjl2h9rw2TJB26Sf8b9/RJ
 sEuL+wO27pNEVd22VtFBw/47V7hsXneAn6yTK+tSqdfC7yt7iHeyzTgiVotELA==
X-Gm-Gg: ASbGnctNHLwWTS9vnE/x3w1i8yBAQyZYvuBW6d/5rw1mQNn+mHaZ3XvXPUBPWevBoLd
 swd3fsFVGyUy6AECKeynkNjQxLSePntBS/4FScs7MKpgxhWKlSfpGVt35yvkls5870Bv8sKNVKk
 Q9f7EfsGkz6DH4ejQv6AOIaUD/0vGOuXC3syxE1Sgtr5yScoblHwFVQS0v2H/TN7eNFf0warVEo
 NafqKL2rf8SjSgDWjR83322dS2T6USQ2uzCS3xVGBaFsbPgpupbYz89WzqgfOW2URJC494xFJGr
 oXSGB/MwVlA22i8HMdbKueeDfMMnNeNUyb7c3asWZYEqg7caqQzI+uYaSJw75nqLLaYr98ewBdo
 uFvZXSFIymNeKMN/wOut1fV713xLsWdEXmxwtxqmzS9u3HEhrjoc8sI3QoSMJ/M8NPQd2E0FE+J
 8So1gGlLyzF/ESidfihIUTEYQjoVrkKnVbgxX9X9Tq1FaAsM4ueD9p
X-Google-Smtp-Source: AGHT+IExk5KR0ASl7qsjTc3S/Az6BLTjgZU2FBq0uedVA6BFSKqYS6d8x/HWPIpkcXUoUF54od8hNw==
X-Received: by 2002:a05:6a20:7354:b0:300:f598:915e with SMTP id
 adf61e73a8af0-32b61e6b99bmr1989849637.15.1759462087062; 
 Thu, 02 Oct 2025 20:28:07 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:06 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/26] hw/char: sifive_uart: Add newline to error message
Date: Fri,  3 Oct 2025 13:27:01 +1000
Message-ID: <20251003032718.1324734-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Adds a missing newline character to the error message.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911160647.5710-5-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index baef0bd9c2..e7357d585a 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -113,7 +113,7 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
 
     if (size > fifo8_num_free(&s->tx_fifo)) {
         size = fifo8_num_free(&s->tx_fifo);
-        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
+        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n");
     }
 
     if (size > 0) {
-- 
2.51.0


