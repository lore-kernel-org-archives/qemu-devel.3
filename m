Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68426C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyE9-0000fN-LL; Fri, 31 Jan 2025 16:07:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyE7-0000Yu-S3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyE6-0007uP-8b
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:59 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso18797515e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357616; x=1738962416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDQ5LJGo9o+LKPmuD53dLkja8+w1xu30AF94L0IcYX4=;
 b=rsSXQjCnGFu1kqXcJ2BmFF9YLAGRlVpqxtLQWnWSSb15rl7E1FX3bYj4aII9gbiNow
 MbLLr2jkZkBPFiOHoa2R39xLfqXgTGU2u8yITFQH7NSXPRLUr4rNoGDT8R4P7XJodorW
 u7n3QGBxeJrDgPgOiawxgXyNVKpiCkw23DGvc5TsvfMuUk7Tq9vK5v6tlu/um/iLPIj6
 gQRo+y1y+LVHfYDsdPmhELSzPjoxhZUlpBTxRSBptemyobD9udnHwg0T0I/V5SdaqUg/
 ntauMPgu6iKtWhWOg2ODFWrK2OjEwfKbutDSXBa+gAVW0prlBZ2meYHfNb5PJIbAvmfU
 h4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357616; x=1738962416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDQ5LJGo9o+LKPmuD53dLkja8+w1xu30AF94L0IcYX4=;
 b=shWpEPXMKLxCWXzEHBawY43ksPAScJyGfrwkrD1SKumPvb5JODSTFGYHef4IDjckaB
 l/qD3mTa9jSv59LARKx/kGNMu3HlfOBFDzT0+CKU6BbkB3YftqDWAy7qxweJ9et4Hksv
 u5h8DvE7oojWeKj/oYqxnSQJftYv+QHxCJ0uC1pWKES/wc1sIMg7YylcLqj9aFJ0QHN/
 GE47Wvcm3mwmQEU3F0rPJr/Gq0KUrubJeWXtp3CLDW1H7z94xKA5rD0HoZH8s1OtmWXo
 qjR+WR932BF8AxTwn+BtB5bPiKXfZtJ6RpsUZfpBY1fktGrp1gDp9Nf8Gq4k366zmllq
 l6vQ==
X-Gm-Message-State: AOJu0Yw74TIFyHRZjfVMCrMQbnVd2OgCBEdxprIXrJbvBriZpY4SzQwh
 jY9743bVNprPGFPZTylm+f88xZzbn371EGum1x4FccA5uCnGoL9I8LWJIBeB4V/tUhnG0xeqeFK
 ltuw=
X-Gm-Gg: ASbGncumlzbuIMenVICnWSvRTu/09FInMFOOvZ+nMArzBtd+ZdA+1+ZVRwcniDaphj7
 PpWtXyA0AzLk6S8hNO9TZhJK7ZokCFxtxlkKFXo3V+EB1nSyIQIjZ0JkuzABsahazAlayMxoyRM
 MwOZkI0Pgt4y1qTsnoaknaQAtB5MM2lLWAcEdzTfAdrm/oLKz76F4aT8k6/7NYnyk8UVZBEDK8B
 rlesFRXRhjS274uHXn8lAxvVzC5K35UITy3XuH3YL7U3m9WfNitmz5oFcb2Bcy++U76NtZIV9io
 tEF91vBftBDdNQF9VKpcsObJSVmW1A2fjflR/cVcWtzS83Gk62WPikdiQ69Aviu0PQ==
X-Google-Smtp-Source: AGHT+IHuwt52Nm4Wo0Iz6wxTYPBWT/DQOJ2FLt0I+Nppl4GRxWhV9JanaMdhiNcGM8mQdv6mF+2Btw==
X-Received: by 2002:a5d:6d8d:0:b0:38b:ebcd:305c with SMTP id
 ffacd0b85a97d-38c519698e9mr10751541f8f.29.1738357616312; 
 Fri, 31 Jan 2025 13:06:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ecc80sm5707516f8f.16.2025.01.31.13.06.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/36] hw/usb/hcd-ehci: Fix debug printf format string
Date: Fri, 31 Jan 2025 22:05:02 +0100
Message-ID: <20250131210520.85874-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The variable is uint64_t so needs %PRIu64 instead of %d.

Fixes: 3ae7eb88c47 ("ehci: fix overflow in frame timer code")
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250124124713.64F8C4E6031@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 6c4c14c8959..b090f253656 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2287,7 +2287,8 @@ static void ehci_work_bh(void *opaque)
             ehci_update_frindex(ehci, skipped_uframes);
             ehci->last_run_ns += UFRAME_TIMER_NS * skipped_uframes;
             uframes -= skipped_uframes;
-            DPRINTF("WARNING - EHCI skipped %d uframes\n", skipped_uframes);
+            DPRINTF("WARNING - EHCI skipped %"PRIu64" uframes\n",
+                    skipped_uframes);
         }
 
         for (i = 0; i < uframes; i++) {
-- 
2.47.1


