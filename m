Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A705ECAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwjpK-0005Av-Iv; Thu, 11 Sep 2025 12:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uwjpJ-0005Ai-40
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:07:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1uwjpF-0006Cu-UF
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:07:11 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2570bf6058aso12122735ad.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757606828; x=1758211628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOAYaDxWDZsV2hmIOq3wdPqI2Hus4uIY85BIAbPxojY=;
 b=hDb4wYJU+3I6dYwQY7rFPj3vfOh2+tppSC4LpxxxubpzU7aiGooG2ITbm3uWoU/IB/
 xBIJkRbvS+bNltpnweAQJ58qXsrs1tmWQf7z1w8U1t+4CoRzt1ocT290FHnyqBprfNH2
 h1S43tDr71uQExA3HAGqbZKWotBXMqSzaOBleTQOKLGAkcfIZ71JPMLrg6VjK/l1Y8Td
 SovA8rsZZa9RmnqkuyK4qZfE7Lza0nsvnmIPJHr5opszbI2PG9XtKgWTcLm9l3hHHJl0
 0JmcJWLX2DZ++I4s2fme9UNhNdIDJUz/sDqtS8g4/XChDXrcMNW3F0wGCgJTjNrXKVzY
 Tv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757606828; x=1758211628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOAYaDxWDZsV2hmIOq3wdPqI2Hus4uIY85BIAbPxojY=;
 b=l2vP7xmMWe5BwQ8JV21QR42uyh2Qg5Y3lJRtotZeIJizzsLQxYVy+iQbH0aKxXN6/M
 GfVhKKzM2Uf0mEI9YT9Ro3iLjF221w0XxwHcHaH/sfWdfuO3gYzVROqom1MlRsWfDYrf
 9InBpYVmXVLCojFfLnXAnyNw1pPWkYTtZTYu0oX92uhn1xwmUO8SfnmquFWYO+vXfSOs
 TdLMkzW0FxZiEPaDpUA356Yi4GTQIEqB63uzjEhS+jGstPT5yX6ewBqZm63jRbwLGMnI
 6npJNThaIg97LrDck59FKHqHhaWmGvjALX89aYFgo+RUYaMxQexZRC6JipFzTT/mOTXs
 nUng==
X-Gm-Message-State: AOJu0YxsP5d5tXJQoxJ91JdLU7eNsVdCsQK70OR3KaMgUv2KocBxzKNc
 HIzP/iowCSPevVs+9Bdde7IvS7tbC0Cb6bkUkZcHawjsRzmKLqQVjRTGt0pZRMBqJDCfkW79SO0
 LXrzgjAHAaa1PwHmil8K4mC5BVXztmIaTft4Hc8sBMwZaZVF+dJN8CChZ86obpYduNyAY/MII78
 ai2AsRBcvHIgg4L6ECn9U4gFfbL87XDrasRv33LBwYMBGWVg==
X-Gm-Gg: ASbGncuK934dRALZ3uJO5NeEfSg+XBKRMEZYq2L69SOzs/vIqZbfUYurbipaLwOFemu
 I8MhD5x4uLFTDau83uyWI9tfwlh1Uf+ki5qJAP4fJ62HdAWZE8JVTmF8RIo7Zswrdt2IC2Rf1JP
 EvqV22zCM+G68enN+QfpftcqJZ7jvweeAqS5osuJcjFVP0J80A06D9v+MEp7PT/HERO+hDB3Lzx
 JXIVfVeBIMgumjoqhY74ayJxo6V++/pKR8nk8KJqGA0XstQHPX8SxcR9z19FXfciSCOMOZcKNXE
 w1orkuQvtqBR5TEUBN6d14x4ASxD4nAzegveL/c6mJ4CS+zFSqJpwbpNB9nKwQ9yz0ZLpU0Zuyd
 jXF5Vebz3jM6b3uBTKzj9jA6eujJ//8/7dY7+hU8VPvtyTyUkVg==
X-Google-Smtp-Source: AGHT+IFF3wVYM4l1p86RBmrAbQ/XlaasdQuUrymGbpxc89MHBDtqcizKMgN0UYlu+xGL1QiOu6nQcg==
X-Received: by 2002:a17:902:e549:b0:251:493c:43e5 with SMTP id
 d9443c01a7336-25d214f424cmr475355ad.0.1757606820254; 
 Thu, 11 Sep 2025 09:07:00 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32dd9903a2asm2618765a91.24.2025.09.11.09.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 09:06:59 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH 3/4] hw/char: sifive_uart: Remove outdated comment about Tx
 FIFO
Date: Fri, 12 Sep 2025 00:06:45 +0800
Message-ID: <20250911160647.5710-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911160647.5710-1-frank.chang@sifive.com>
References: <20250911160647.5710-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Since Tx FIFO is now implemented using "qemu/fifo8.h", remove the comment
that no longer reflects the current implementation.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/char/sifive_uart.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 401f869680d..baef0bd9c28 100644
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
2.49.0


