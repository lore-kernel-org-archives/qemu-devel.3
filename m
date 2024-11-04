Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518FAD11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kp8-0007Pv-Ur; Sun, 03 Nov 2024 19:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kp7-0007Oq-M9; Sun, 03 Nov 2024 19:20:01 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kp6-0002Kt-B4; Sun, 03 Nov 2024 19:20:01 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-720c2db824eso3318139b3a.0; 
 Sun, 03 Nov 2024 16:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679598; x=1731284398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0I9TDQdpQOkKI2wo1rQADwX0izZZzX4pvBbiiFX/Hg=;
 b=lrz6IIsI6AamTuWkD0epBhUl65hAHgeAmRTIj2FXkh8tR85HHsQvOjsnNn5dyjUFAP
 xTH2MgdsbrvRSuPXY2zbyEVsgyXJIls5RxO8N1Nf1MYUfeX6pEgebjPBvfgBqRohu/OU
 VHbi4b1ojR7iCO5mfFn1+hgC2+xwbz347atBcYcp9kkoDMLUsC+ToIC6V8h2V2YXgOhD
 lPbU1AmaQn/TBBlxHXJb6km3QfXks19CE4uHOMO+dNwBUq+hclC5NEXG+WilxHdNPFnB
 VwWdk9l2m8OmENJq8vC/B8vQvHcHrXThPwnZzpX2SKOaXJDnePB5hel9444Nl7cRWDzY
 DCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679598; x=1731284398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0I9TDQdpQOkKI2wo1rQADwX0izZZzX4pvBbiiFX/Hg=;
 b=CPQd2o7YOF2K/6xz+WZOibv1JeYHRYd7jr5NAe7Uxop+ZRAgT4V9knw7tXPCkoGGGc
 hquQAdFheDT9mA6tycXIqikgjDwCsLsAdJLv3AHsVHYrXQVkgs7MRK8FCKJlhT7bBQ/D
 fblLA7BL11Xk6YzGLD3sJXiJkkcKZ9HpMwLiPcBWIBGQ9QVv6i39nBIXEzMyqNy9fpFd
 sGKW7EN/GzXXfMUr9jiGFJ7psrSopBwP3x6piQHxhUS8C9VMzaU1eXJp148Cl7swwuYY
 c3S6Tv8LkN8ZNOyUbh82Ijtg6Fttx1OKBL72DRfSts9UAywoEAv0+V3FAyzr6/isUI4N
 unLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL4iHkNOyO6gafHV1+QZysqli6JH+7tXr/vZn+TFFTyZ40m54bHYjhEPlvnQcQlWWq32AcGjFaNA==@nongnu.org,
 AJvYcCXKDi4GaaAG5g6e6YXHiFPwoYl7GdXqKBLTnyp91f5AS8/ZTRtPH+y+C17D9KyIy431peYcHVURjSAqR9U=@nongnu.org
X-Gm-Message-State: AOJu0Yz03llt/OLKfO2Xjp2nIFTCY+ntX6jyNBxuOO2XSAO5P/AEqRJq
 US4nGFzx6nI07D7DV3uFDk3wRrILvc3uqQ7vS8qsK08RDse1QyFOIVeRBA==
X-Google-Smtp-Source: AGHT+IHVy08vcndPptgZnO+iB9WVSK8wvvL2gvxOgXb0z+56gZGLg0p0ijxZmc/1BEFTv+EuXliawQ==
X-Received: by 2002:a05:6a20:d48e:b0:1d9:ed47:3b52 with SMTP id
 adf61e73a8af0-1d9ed473c0cmr26597073637.8.1730679598137; 
 Sun, 03 Nov 2024 16:19:58 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 13/67] hw/ssi/pnv_spi: Return early in transfer()
Date: Mon,  4 Nov 2024 10:18:02 +1000
Message-ID: <20241104001900.682660-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Return early to simplify next commit.
No logical change intended.

Cc: qemu-stable@nongnu.org
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ssi/pnv_spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index d15a5970b4..72bcc00de7 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -217,6 +217,9 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
     PnvXferBuffer *rsp_payload = NULL;
 
     rsp_payload = pnv_spi_xfer_buffer_new();
+    if (!rsp_payload) {
+        return;
+    }
     for (int offset = 0; offset < payload->len; offset += s->transfer_len) {
         tx = 0;
         for (int i = 0; i < s->transfer_len; i++) {
@@ -235,9 +238,7 @@ static void transfer(PnvSpi *s, PnvXferBuffer *payload)
                     (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
         }
     }
-    if (rsp_payload != NULL) {
-        spi_response(s, s->N1_bits, rsp_payload);
-    }
+    spi_response(s, s->N1_bits, rsp_payload);
 }
 
 static inline uint8_t get_seq_index(PnvSpi *s)
-- 
2.45.2


