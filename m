Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2040C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBgD-0005up-83; Tue, 09 Apr 2024 09:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBg7-0005rP-QL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBg0-0008D5-RH
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:18 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41650ee55ffso16789115e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669894; x=1713274694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hctFmQvoI+VoJ+wRhi5qSVao9Hd6gz46Zo0ppCYqkkE=;
 b=MkNXaU16aYLZ5Bj4GLd6FHU8wRNJnqyBHEW2sC3PzpKbvENMUjK539nWTSu7rIsXID
 kFncCFWXfOZr5ifG1aehikXMluVh6R34N5MMCuoBaZDYqgX/lNVi1bGPX6DtJRQHxBbg
 KIA0YFR8YtonJDEgHleX7vTjUsgQ+r/6kKTVZ6ZL5ZbGwsxT3byIdsOMwja3SfvtIsPc
 3M1o3K114bIhIP43eRAyBQ1oHLfk5TDgtI5BxcfwOemMUdPuZ4s3zVh8jyV73wXafzH0
 Q89hGgGhH71wZNw+vhPvx/3cg83TyELI2OCqZZYXc2OlfFLVR8ipEWwWTtTbawOfubG2
 Ww4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669894; x=1713274694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hctFmQvoI+VoJ+wRhi5qSVao9Hd6gz46Zo0ppCYqkkE=;
 b=F2UU/Ysx3Z5hff2xkct8krvhirsfiT8S5Vw00YRcfv4L+gTicqIF2Obq12hWatux5G
 0Vmd8kz5NXJETs5gKNMvfKwHmuRDc3JspoHCIlE46BdLyMOy+0jRkD/dbswIyDKlPpHi
 IRg61BnLsxZpC1VeavEXwtI13DbUYIA9jrHi5bdRoZuZe6TqrE8jdB1eOLGNkU9gHUAe
 TWQ/A2OPaFslXoq5P8SM1jG6tH5AZ9ufvVABpGETJsGkVpeKfaqrfYxdJG1xIQ4ADAsp
 78oI837ocn+Sz+YeTy0zVFIHlR7phFfkknkDZzO5CLwPPFrQvcZmT5cSeO8Q/MuEMNJr
 N8Kg==
X-Gm-Message-State: AOJu0Yy0y++wCn8awGE9yj0+aHydCVW15evAgT59vQ+0vZ+a9X4t1AcR
 YXDc9hqwy9FnEw6+6heZzYPtpH1v4r55aWx2AtR1vtXnDUzQ36BKzZj/P5hMYz8Z/0cVzWldJfD
 P
X-Google-Smtp-Source: AGHT+IH+S4oDYnnEyo5S1l17ul15PStqKCyEcvvn6rs9W0vus0qfS6lrL56SzCPRMDnA3s03aJN2uQ==
X-Received: by 2002:a05:600c:154b:b0:416:9c95:b712 with SMTP id
 f11-20020a05600c154b00b004169c95b712mr1792936wmg.20.1712669894544; 
 Tue, 09 Apr 2024 06:38:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05600c0a4900b0041638a085d3sm12938995wmq.15.2024.04.09.06.38.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.0 v2 02/11] hw/net/lan9118: Fix overflow in MIL TX FIFO
Date: Tue,  9 Apr 2024 15:37:51 +0200
Message-ID: <20240409133801.23503-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

When the MAC Interface Layer (MIL) transmit FIFO is full,
truncate the packet, and raise the Transmitter Error (TXE)
flag.

Broken since model introduction in commit 2a42499017
("LAN9118 emulation").

When using the reproducer from
https://gitlab.com/qemu-project/qemu/-/issues/2267 we get:

  hw/net/lan9118.c:798:17: runtime error:
  index 2048 out of bounds for type 'uint8_t[2048]' (aka 'unsigned char[2048]')
    #0 0x563ec9a057b1 in tx_fifo_push hw/net/lan9118.c:798:43
    #1 0x563ec99fbb28 in lan9118_writel hw/net/lan9118.c:1042:9
    #2 0x563ec99f2de2 in lan9118_16bit_mode_write hw/net/lan9118.c:1205:9
    #3 0x563ecbf78013 in memory_region_write_accessor system/memory.c:497:5
    #4 0x563ecbf776f5 in access_with_adjusted_size system/memory.c:573:18
    #5 0x563ecbf75643 in memory_region_dispatch_write system/memory.c:1521:16
    #6 0x563ecc01bade in flatview_write_continue_step system/physmem.c:2713:18
    #7 0x563ecc01b374 in flatview_write_continue system/physmem.c:2743:19
    #8 0x563ecbff1c9b in flatview_write system/physmem.c:2774:12
    #9 0x563ecbff1768 in address_space_write system/physmem.c:2894:18
    ...

[*] LAN9118 DS00002266B.pdf, Table 5.3.3 "INTERRUPT STATUS REGISTER"

Reported-by: Will Lester
Reported-by: Chuhong Yuan <hslester96@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2267
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 8214569a2c..91d81b410b 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -799,8 +799,22 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
             /* Documentation is somewhat unclear on the ordering of bytes
                in FIFO words.  Empirical results show it to be little-endian.
                */
-            /* TODO: FIFO overflow checking.  */
             while (n--) {
+                if (s->txp->len == MIL_TXFIFO_SIZE) {
+                    /*
+                     * No more space in the FIFO. The datasheet is not
+                     * precise about this case. We choose what is easiest
+                     * to model: the packet is truncated, and TXE is raised.
+                     *
+                     * Note, it could be a fragmented packet, but we currently
+                     * do not handle that (see earlier TX_B case).
+                     */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "MIL TX FIFO overrun, discarding %u byte%s\n",
+                                  n, n > 1 ? "s" : "");
+                    s->int_sts |= TXE_INT;
+                    break;
+                }
                 s->txp->data[s->txp->len] = val & 0xff;
                 s->txp->len++;
                 val >>= 8;
-- 
2.41.0


