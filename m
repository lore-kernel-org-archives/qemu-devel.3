Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BF1C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNYj-0007tH-AK; Mon, 14 Jul 2025 14:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSk-0004a6-99
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSh-0001J8-84
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:33 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2989659f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752512129; x=1753116929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WAd9m8e33PKa1oGnuqT0APNMRjVofzTCm9BK9/hgKY=;
 b=E6txaNRu0ZwWrXEoWZqXLHlpl0eSGWws+13zZ5jv7MDEG6zz5zYMdcooBkLl3qQOkT
 7gDEofiYeO1q8b3H2M/nnrDqFSmMjoChygV1aEVQT7IS/Vi1IyJu7d30rbcAQgOkeaQB
 f6kbbFXQaoAFi1ZUtgjXm48C8Kaoo2K/6KfoUJmUnmdRIoDFBQFU+WZjTG44wyulkhAh
 YOhvfMDQ2tyzBzfL2tkM8uoh9jF9p8yI70d1K+p5YNsKkvuJofSTC9VkyHT7afaGu0nq
 GTS7dytln8s4HoveUl/h2SLae9PVA13CJQSHom3TTWeniN/7HuSfPNBhurQQhzCNEgqE
 ECqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752512129; x=1753116929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WAd9m8e33PKa1oGnuqT0APNMRjVofzTCm9BK9/hgKY=;
 b=ETHpDmTqhO8Y+9h83HGHiJoTlHAQa4Dx0xaXe+N/W74IGFRk2mUKxu+GDAsTXjLEk7
 ExFIfVsVsv546KeZsiDL4ptcdxYBCWIgn2kPLFWMipaha7BMg0WAyOe96B5auWRW2B8L
 JQA2tAZFMzQOIikWTS14y5EADIglRX6lQTCQDTcugTfcBSdBg6q6b1SjogklsDWsegIP
 zFdws6qItsaf+S+hrlrJcr2u7JdPVuuoSI2iYpbPg2NCualPDK4I3tjitympuzfo+jhi
 djnZCqO0sfR7q3fCDbspzup9F9s8kXamV6tSlPBv5k1xtLA2rFUkb5EZ6TURomKNQa4i
 e6+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAJTzT2cK96O13sqqUC886RzbnIlhIRUR8BGbyR3IBCQkWOhNP5akXPr2TBQ8U27LRqzyOs2va9X0D@nongnu.org
X-Gm-Message-State: AOJu0YyiujY4CbCVsLdQkHjraFVi01z8qOT1RZLca+HwvweoljJhLHno
 Bdgnqa0rrOazwPoQoo5OFBVSbjlXgCJGDnfJMgaEH+QsRc9aw4rKoKN3WpHOwsGS6aA=
X-Gm-Gg: ASbGncsgmwuuZKdhwLV7eNZIWXbpNNg5Iuuvg38ceCFkzPYoK3FYU/p51c+jSOieuY5
 phUOf2dnBCJ+n1sAqJG0LsPa+4ZnZgac4uiS4ffla7ccA7XiWE/k/3lopPyp+Iaxw/n6S8BDIKm
 EsdHBoNPQgJantSca4mK4pIzWSmkSNypveHizrI+nHZpOCmMzDoVpv9Oi3Rv5Y9HDWG4asQWEOT
 UmoAZyVtfOIIkogOmzxxRBOgIBz4/amSzVhHurLDa2ffRUhYw4B8w+R91kDBuemfI+e2s2xKRFd
 4mlRc8aFhje0oTJ9ctfXrHzPJ6r2kwsd2o01xduiEt1fxC/BYyxMnkXNoNTWS9qLElxP/DMw+YL
 weVCHnxw1M85Av6il/m4Z/FaYxC/g
X-Google-Smtp-Source: AGHT+IF+w0jSj/V7Z7QVWt/OlBIfPTwpI8k28WpIjSbSUuDO/4L33AITtFyF7HxsIxbe/DQsoeDQew==
X-Received: by 2002:a05:6000:4813:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b609522266mr325287f8f.6.1752512129388; 
 Mon, 14 Jul 2025 09:55:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd15bfsm13164665f8f.19.2025.07.14.09.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:55:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/4] hw/net/npcm_gmac.c: Correct test for when to reallocate
 packet buffer
Date: Mon, 14 Jul 2025 17:55:22 +0100
Message-ID: <20250714165523.1956235-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714165523.1956235-1-peter.maydell@linaro.org>
References: <20250714165523.1956235-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In gmac_try_send_next_packet() we have code that does "if this block
of data won't fit in the buffer, reallocate it".  However, the
condition it uses is
  if ((prev_buf_size + tx_buf_len) > sizeof(buf))
where buf is a uint8_t *.

This means that sizeof(buf) is always 8 bytes, and the condition will
almost always be true, so we will reallocate the buffer more often
than we need to.

Correct the condition to test against tx_buffer_size, which is
where we track how big the allocated buffer is.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/npcm_gmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index a0050a7725f..0c17ae9b2a9 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -569,7 +569,7 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
         tx_buf_len = TX_DESC_TDES1_BFFR1_SZ_MASK(tx_desc.tdes1);
         buf = &tx_send_buffer[prev_buf_size];
 
-        if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
+        if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
             tx_buffer_size = prev_buf_size + tx_buf_len;
             tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
             buf = &tx_send_buffer[prev_buf_size];
@@ -591,7 +591,7 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             tx_buf_len = TX_DESC_TDES1_BFFR2_SZ_MASK(tx_desc.tdes1);
             buf = &tx_send_buffer[prev_buf_size];
 
-            if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
+            if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
                 tx_buffer_size = prev_buf_size + tx_buf_len;
                 tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
                 buf = &tx_send_buffer[prev_buf_size];
-- 
2.43.0


