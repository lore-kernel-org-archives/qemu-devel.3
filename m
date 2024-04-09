Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0F2C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBhB-000771-NN; Tue, 09 Apr 2024 09:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBga-0006Bb-8S
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:54 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgY-0008Fg-Cl
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-345e1c64695so940193f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669926; x=1713274726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGzPoYfNQCrbv8SBMTgNtn+qUHBJfLjzTK3ZMwrVVa0=;
 b=YLVPHWI9qf0YqvGfy+qWUYDFO34sRgz35Kr5pF9BOGHm0J1/ie3U27Iv+Wg6NTQXmU
 Zt9CCvlcOG/Lnm1t+h0k2OUElLmhMVMYZwQPhFgx3FUeEmF1t5/IeV+K/WBxU6uwNFqK
 s57WPDAHjbduBqL0p6mss1NlQthDZfnGN+z5l4uGO7yzx67iR/pl9ksqhYvlg0ynzK8h
 aj5rDi6uSDmgbxOIt+GsOjWuOQqwVE5KHMfSbocDELpm+NDYA8ycOWFMwWitQefCV8zi
 hT4IxCEon3qEgB20gmuVtigvFkf11knelYlT2DjnWsU8C1T3OyFGtXYI5Yq26vPhhpTm
 CIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669926; x=1713274726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGzPoYfNQCrbv8SBMTgNtn+qUHBJfLjzTK3ZMwrVVa0=;
 b=HNe95lChZkKJiCDJQRNMZyP4YRBOhHRCvD3K356rDaVIuLVDML0XEm+Nw4IYhd3Exi
 bjjwEskXc43A5YWHbLC7dcpxLoGsINjFaCBuqLynE0OnC2TWB8tjRMuKpnXuZ1FujLvl
 ioGilqKIRC+EncGTvmMsqvduTs01Fr/Y8u6T4sNL30RDagRaMd9sVV9/TWI/9EotmjnM
 4UMWc8lq5L6KhksX2EGYhJGqZ+XiDQ2x/S8Wjseila/925D82y2E1LKFinc9lPhitItC
 2TozSK++bQZGwMZpKn0EdLksGUEY8GwccDlMFz+15Ync0q2ZHEYKSxcQHvY0Ey9NMO9O
 uudQ==
X-Gm-Message-State: AOJu0YwnnelMvHvQwuJVgOyeURkAtTYtbHo4OPjjQps8MVDVtxtbgjdz
 Sp3QxKAonmgVX8aXKUi9DGL1WKBn7l5FEfIr1IyR/UGbv78U5fL3InzqsHc795fvZU+KjpeHXoq
 T
X-Google-Smtp-Source: AGHT+IETTIhcSQI8zV4cGPaMOo8NFq+qsrkkC9zgOGClodeEguSGylF62XY8LCwXvLt//E5O7GFuVA==
X-Received: by 2002:adf:f7cb:0:b0:343:ba58:97c4 with SMTP id
 a11-20020adff7cb000000b00343ba5897c4mr7607183wrq.10.1712669926663; 
 Tue, 09 Apr 2024 06:38:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00343eac2acc4sm10864616wrs.111.2024.04.09.06.38.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 08/11] hw/net/lan9118: Use RX_STATUS_FIFO_BYTES
 definition
Date: Tue,  9 Apr 2024 15:37:57 +0200
Message-ID: <20240409133801.23503-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

rx_status_fifo[] is an array of words,
rx_status_fifo_size is a word count.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index a983ce193b..cace22381d 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -262,7 +262,7 @@ struct lan9118_state {
     int32_t rx_status_fifo_size;
     int32_t rx_status_fifo_used;
     int32_t rx_status_fifo_head;
-    uint32_t rx_status_fifo[896];
+    uint32_t rx_status_fifo[RX_STATUS_FIFO_BYTES / 4];
     int32_t rx_fifo_size;
     int32_t rx_fifo_used;
     int32_t rx_fifo_head;
@@ -332,7 +332,9 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_INT32(rx_status_fifo_size, lan9118_state),
         VMSTATE_INT32(rx_status_fifo_used, lan9118_state),
         VMSTATE_INT32(rx_status_fifo_head, lan9118_state),
-        VMSTATE_UINT32_ARRAY(rx_status_fifo, lan9118_state, 896),
+        VMSTATE_UINT32_ARRAY(rx_status_fifo, lan9118_state,
+                             RX_STATUS_FIFO_BYTES / 4),
+        VMSTATE_UNUSED(896 * 4 - RX_STATUS_FIFO_BYTES),
         VMSTATE_INT32(rx_fifo_size, lan9118_state),
         VMSTATE_INT32(rx_fifo_used, lan9118_state),
         VMSTATE_INT32(rx_fifo_head, lan9118_state),
@@ -458,10 +460,9 @@ static void lan9118_reset(DeviceState *d)
     s->txp->fifo_used = 0;
     s->tx_fifo_bytes = TX_DATA_FIFO_BYTES;
     s->tx_status_fifo_used = 0;
-    s->rx_status_fifo_size = 704;
     s->rx_fifo_size = 2640;
     s->rx_fifo_used = 0;
-    s->rx_status_fifo_size = 176;
+    s->rx_status_fifo_size = RX_STATUS_FIFO_BYTES / 4;
     s->rx_status_fifo_used = 0;
     s->rxp_offset = 0;
     s->rxp_size = 0;
-- 
2.41.0


