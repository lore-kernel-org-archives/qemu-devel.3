Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6715CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WT7-00073a-La; Thu, 02 Oct 2025 23:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSz-00072H-EL
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:21 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSq-0001Cn-NB
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:20 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33274fcf5c1so1847646a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462084; x=1760066884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzgt9NMsG+zsoSzpM68SGiuLVbfJh0cCb3ctQE5Gzr8=;
 b=Elop+4vRmKKo5jiYsQ+2pe4h1d2yK47qZgskTX9WFygz3Tk0/gmyswHKuDb1GytUfb
 pbkjcKx9FW7gymPZUc5fMsMuhqChyH614zqCgsWzsAnuXYiMjG9GVPmWN6S2Rgb5JoDw
 URaxvdeqexBTFZEiJlfTW1x3j/1SpNsZDV62Rqk/oRC2Zwe8fzCKeZUoXHbdC7qnzaLm
 u1/pFOyMHrzyqUxfzlXTzklkuNJH5vpGRiKe/dwe4i9KpZtOmswppT9WClkoZXXmwR2l
 /wx4YV+WUxV2h36Z5TAOFAnB/gYW4jrBSSJf8fgad52oHsrr82/peX+P9+BOMc5i1pKc
 5obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462084; x=1760066884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzgt9NMsG+zsoSzpM68SGiuLVbfJh0cCb3ctQE5Gzr8=;
 b=vMyWSvCzKqZtfC4/ANTAAXuKOgi+xVdNpKxbU4N9ztEbcZSFHbO42QzLNHozhOpT4a
 K5q1R1i/jAP/uYM3M/Nt/1q87wOL6DqMQJXqdliwi+OPQVoaXWbU3uXs9wtAb1J4TB1Z
 ewjAVmhRkohmF+v4NLLpE63Jin+cC8W/ItwR/Ib/S/9DFvcmVT6qPvmJvAMlP+iO8u9c
 Tj6yfJS2EwmRSiYBTFUC7D+4OEvLMJunPBjEGFAGcc/6TGudUAc45afAnJyfMtMA1FMd
 X5gSZlG1uUc1h9m7hNsTwKRmoDYm2M8Q1pZ+vVCncUxF3jpjMP6nO8JavOfEk3NP2gdh
 Vt0A==
X-Gm-Message-State: AOJu0YyrrmjXuQAO7q3g8N1FRnj9qUtSdSGI3opVTuv+lW+79Sm4IR1H
 +KUVUPphskjqoLC9bwO7bHCxiikG3C2XPSLL0bp8AyLBmKXASxHrznbqWgaU7g==
X-Gm-Gg: ASbGncs9Jut4hrDYrNlvH8DcBL6PkgCZqeGUWrPxRqBVSLuhXw8WOWhD8Pwu5A8pYLT
 J0JGPpimYLGDJ98vJbCB5JH2BGXW//HYk7xMtd76eW9cR8C0Cml+zIuc5FKZsByyuRHyIubMaeL
 //aK40e2WLeLZflz3ij91xGYJ0Qf2WjkYzk71xMG/VNOdwvd/PVNjRiwgUSzuwewNvBZ6Ayrt/D
 sIsOxsT73HIuYhT7SWgRU2h2uhC1f37VCXOuztOB3M0qTTwnrkx3BNCeDFt8ALqo7Le5F8gmkob
 Mx4pG9CU6YRZ1EdFOGYOV/9F7O1jufTD18SAvlrfMecpdSbXnMte62s3JtecyD8X987yc8qtYff
 64jZoZXa2gxtRh9twwy9XQ0QFP21HNu948zbxj4moO2ZHZyjL3Xylc/YtEiDRNNVFg6ycKhRw8T
 kbhgNe0oeuu53yym8OpGZnHYBH9o0eWkkN+7I4dJgv/9K1SPQsZwZi
X-Google-Smtp-Source: AGHT+IFCrhFlfX0dY5qYuBN2wY9afvbdyT2wTJ7F9eqcIYjm2SXNVsbY+5VMtg4Nq6ldX9sByQpr1g==
X-Received: by 2002:a17:90b:3509:b0:32e:7270:94a1 with SMTP id
 98e67ed59e1d1-339c278e605mr1887820a91.17.1759462084133; 
 Thu, 02 Oct 2025 20:28:04 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/26] hw/char: sifive_uart: Remove outdated comment about Tx
 FIFO
Date: Fri,  3 Oct 2025 13:27:00 +1000
Message-ID: <20251003032718.1324734-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since Tx FIFO is now implemented using "qemu/fifo8.h", remove the comment
that no longer reflects the current implementation.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911160647.5710-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 401f869680..baef0bd9c2 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -28,12 +28,6 @@
 
 #define TX_INTERRUPT_TRIGGER_DELAY_NS 100
 
-/*
- * Not yet implemented:
- *
- * Transmit FIFO using "qemu/fifo8.h"
- */
-
 /* Returns the state of the IP (interrupt pending) register */
 static uint32_t sifive_uart_ip(SiFiveUARTState *s)
 {
-- 
2.51.0


