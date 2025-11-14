Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD49CE7B1B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvmc-0007Te-Hg; Fri, 14 Nov 2025 10:32:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc1-0006JI-ND
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:21 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvby-0003tq-Qo
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:21 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47755de027eso15884185e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133677; x=1763738477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sJFpufvTLWkMH0hlDSsdkxfoRwT7meuG5aDVzEwV8Cw=;
 b=gzI9Cucj2/9n1caupHqJ+vDP2yZzYHICWUV1+ToigQn80FMjKTWZtjZxvrzZF8h/0T
 l/gFlniFqiXmgjuLAwlizGY5pBniKxN29yj/AaZhpyF7YFYBcw+x9+bwJ0rJpWTCxUVI
 8YV/eWTZKg72furuwaq5RGlMP0Rr4fq3icem5SGswa2781T2zk2yLbhPzcZQIQxFkhAb
 6ilMiPpJtp9eNQ9XxVO+H93VjmytaA37rdPmCqbkocRY/6HrLxbjGkeWW26HC1Os4UGz
 vzP7JFK9HvnRMpX6509s2Zn8+XyjhRrpxsxzc7+R3tOyQO7f8Cjsix9Ozh6gDzm5XuD4
 Z8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133677; x=1763738477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sJFpufvTLWkMH0hlDSsdkxfoRwT7meuG5aDVzEwV8Cw=;
 b=CDroI+WY3woQM6OdpF9Px3I0Vx7V6DQWpZ0aFN4PKCLOzSAuIe9rS3lZ8jTrZJ4Pbs
 duYzutz4lE0RFTan1qlDi/7Yj8ymcTk96OPJCT09dxLWhD+pQ7E26MwheOC87/kcer+K
 mV85qB1s+wzNBfWGUYQjMYJy5eeFleIuI2PoUrOPfmbx2qF5caPQxtIahu9sFYDpMn8U
 wFabWzxmnUv0Pd5QPGWw+ziuK80CY9wzQu4JOe72yQxHz2HqMK+eCBg7TJfddZrJ8oYo
 Gkeav/THrGzPaLJKAJQmwLNEQozpmPV/VauyaaHS27kZdasVrRAzH7fbn1UhqJP3R68R
 Tzbw==
X-Gm-Message-State: AOJu0Ywi5XqY615kxEwzmANDOs1DqqDsxW9o0WnhXtm3lXDWjBoJGoaL
 miXtJ9P6zFieVY271zzh3znSR6lKAUO2voB7JoL70JjPsqS3m0O54PCs48zNmIOsspZkogYfpWO
 MCd2k
X-Gm-Gg: ASbGncueBaF/FyMrWO5I8OEpOKxAg3dERyvTnuRqOfvKIXA+ho5qBHBNnu/5UPERJaz
 q30S9ZP/F3mIUcKPFMYpDpdn6CWPmWGVesEIT/YiO9B1FMkkldxrlT/656rhLI+ed9sHjs5FlnJ
 +7kUtnh7ln6EzpNnUn8VJlXA5qw4ruzChsB3iV3XRH/n1pe3trlwPved47m7rdHjeUm7Dc43/3y
 gi/ZY82wHNbfGtsHFWpQRKhmtzMHZnFidPUo6FcS26AyB+G2bHWvCh5vG6e91AJK5e3eSmkovph
 bXl7+iMnIb79niSUqYUvc/7RAGELRwPQN4+mUWWlS6wXUH+HCDy7z7189LsDCCz2X1HxPvm+fkd
 /1tltVYludMvvhd/9SsF48WZ0p29AHtfn3/wINwXHBR37VUacMGVitK+ZFWS3dyf2ccy9bi4aoz
 xw7T3tonIXBVecroPR
X-Google-Smtp-Source: AGHT+IER8g/IZYXtw+6FxTJ/+zhXlc5S79A8/9Zc7bpQuiPxJ/rS6ajV6FI76AVvWyx+qDbeLw1Oeg==
X-Received: by 2002:a05:600c:c4aa:b0:475:e09c:960e with SMTP id
 5b1f17b1804b1-4778fe88fefmr37047975e9.32.1763133676836; 
 Fri, 14 Nov 2025 07:21:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] hw/display/xlnx_dp.c: Don't abort on AUX FIFO
 overrun/underrun
Date: Fri, 14 Nov 2025 15:21:04 +0000
Message-ID: <20251114152110.2547285-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
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

The documentation of the Xilinx DisplayPort subsystem at
https://www.xilinx.com/support/documents/ip_documentation/v_dp_txss1/v3_1/pg299-v-dp-txss1.pdf
doesn't say what happens if a guest tries to issue an AUX write
command with a length greater than the amount of data in the AUX
write FIFO, or tries to write more data to the write FIFO than it can
hold, or issues multiple commands that put data into the AUX read
FIFO without reading it such that it overflows.

Currently QEMU will abort() in these guest-error situations, either
in xlnx_dp.c itself or in the fifo8 code.  Make these cases all be
logged as guest errors instead.  We choose to ignore the new data on
overflow, and return 0 on underflow. This is in line with how we handled
the "read from empty RX FIFO" case in commit a09ef5040477.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1418
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1419
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1424
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20251106145209.1083998-2-peter.maydell@linaro.org
---
 hw/display/xlnx_dp.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 96cbb1b3a7d..c2bf692e7b1 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -435,7 +435,18 @@ static void xlnx_dp_aux_clear_rx_fifo(XlnxDPState *s)
 
 static void xlnx_dp_aux_push_rx_fifo(XlnxDPState *s, uint8_t *buf, size_t len)
 {
+    size_t avail = fifo8_num_free(&s->rx_fifo);
     DPRINTF("Push %u data in rx_fifo\n", (unsigned)len);
+    if (len > avail) {
+        /*
+         * Data sheet doesn't specify behaviour here: we choose to ignore
+         * the excess data.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: ignoring %zu bytes pushed to full RX_FIFO\n",
+                      __func__, len - avail);
+        len = avail;
+    }
     fifo8_push_all(&s->rx_fifo, buf, len);
 }
 
@@ -466,7 +477,18 @@ static void xlnx_dp_aux_clear_tx_fifo(XlnxDPState *s)
 
 static void xlnx_dp_aux_push_tx_fifo(XlnxDPState *s, uint8_t *buf, size_t len)
 {
+    size_t avail = fifo8_num_free(&s->tx_fifo);
     DPRINTF("Push %u data in tx_fifo\n", (unsigned)len);
+    if (len > avail) {
+        /*
+         * Data sheet doesn't specify behaviour here: we choose to ignore
+         * the excess data.
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: ignoring %zu bytes pushed to full TX_FIFO\n",
+                      __func__, len - avail);
+        len = avail;
+    }
     fifo8_push_all(&s->tx_fifo, buf, len);
 }
 
@@ -475,8 +497,10 @@ static uint8_t xlnx_dp_aux_pop_tx_fifo(XlnxDPState *s)
     uint8_t ret;
 
     if (fifo8_is_empty(&s->tx_fifo)) {
-        error_report("%s: TX_FIFO underflow", __func__);
-        abort();
+        /* Data sheet doesn't specify behaviour here: we choose to return 0 */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: attempt to read empty TX_FIFO\n",
+                      __func__);
+        return 0;
     }
     ret = fifo8_pop(&s->tx_fifo);
     DPRINTF("pop 0x%2.2X from tx_fifo.\n", ret);
-- 
2.43.0


