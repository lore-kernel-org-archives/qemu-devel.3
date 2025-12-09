Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37D5D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0A7-0003iV-Pk; Tue, 09 Dec 2025 11:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09m-0003cZ-Lr
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:42 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vT09k-0003sI-DC
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:01:42 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-299d40b0845so93041215ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765296098; x=1765900898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmSr+7UNGyS0cxdPZ6v+rDg2ZVlykU+2MSIiprx7dSE=;
 b=Bh9S1BCkaQWh+XjX6oaxs/nR4v5XcPfcSSlXf/y8AGPsucoWGNY818Bfa30I221i5a
 uXUNCUzE1lQTTD1lEQaY0O1VsLFFQ3+Tb/NkyvHCQGX3/4r3mMk287DpuVesbfkv3Qq4
 +olKta6WttukiRgHLnUfWaM05hNWuFJI6QIj7Pb9gFUY/ld6b0ssbCP637LuVbzgrwaR
 JBZEvIBC4um0x6pn0fuhaFJM5SNBmOETjb0X4gCeGYEj2+RlOzskmHI08O2H6BR9Scwa
 8CQmfKcIngOTGtFo/KJkgUvSXHkhIVUoGRHNMn5Y3IXrzRN5zmmZRmu+xrVIn4lLPkgd
 p4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765296098; x=1765900898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WmSr+7UNGyS0cxdPZ6v+rDg2ZVlykU+2MSIiprx7dSE=;
 b=YgmhZGE4Ar5Io3O5waFB4FMcIGlfApCfhYPkbc59luX0EpoCaGvtuWiUO5Jw/Qpgge
 C0k+6u+cJkRLykPm0mH/Ccav5uXLJjaKlRM5RcSQ9ipQHErjEE1vimTjUWlP7xlG3P2h
 Fj3XxLsBUK+XK8v1BokKtCM+3OqtUAcToADfnmcD8ofG6gUBnWxXUImIzjRZKBizgFD7
 kV0vYkkrRtzEbtNj7yWgqaJeGDQ6z4dmbMUnwhuAISHTpHLIa2yOgMZoiYBroKWvhNA8
 FFJ02JK9gU/pU63rTSX0qOcT9n17WQm4WS28rwU+MxnF+oY8UX4JyP0H93iUZ9t587qY
 m9NQ==
X-Gm-Message-State: AOJu0YwBOduNWkPtksP0GIaXncI+IeFoxgNRuGewXDX7yDZjLQ2US3w0
 l09/xAoMQQN8MF/1Cdb5HyZHla6q3aDUavBabdguHmOxJ4QlAa/WMaCVhvuuQugOBeZVKRAUNpu
 41WhIjn+MsP9J9bmIu8KcShsc0IpqC/aJYL8xqN/AASY9A/rAL0Te0h4iDcSRoCoyf3PPR+5QAw
 XSytHSiP0Slk/LaIaYcbgd9qlH5f/Gl9QLDaQ/ra1c8eU=
X-Gm-Gg: AY/fxX7emtu4QjLYsqQdF68vf2YP3tJ8CoNFGeeeaxxNuAGzyGxW9qecymju2iS/70E
 9d96hyeSTf8yfzTq+9UF4/BtZE34ScnbzDvJRmhPVKHWN7rY9X3v52dOq7OryRz9ERg4vzUdWFS
 iTiYCsXvmKbeUHD90IK0NUQ/g1G5JX76Z9pKZTcFzUOn70Vq+Ixy26Ryx33SI0tmlMhALajYann
 H3zQCTac0+LX3Iq8gQW4DIjlcb0TbuS/QU3JTZRWieXaYsWvbS0CwjEtxLByXNgEBE8SwhD658S
 TV2YvKTIJ3hwU5E0UmnvArvDHLwPuIaf1hdm3sxq0qHPY0ND3E5OKwbHrwNA/vn/4F/ZHalOebY
 NOh4qbjXHNqAHTqskuwKEvoiKS5H+JnY3XKZ+FHRhH1i8dsezqUlX/hrICcm/mNyyPxnM34eXeJ
 s32RHUn6mPD7DTz5qgjRIQr3cbDL8b4rYv1tTgBQ==
X-Google-Smtp-Source: AGHT+IF+sUn2KZYCbTWUD/QKNeD0lJ4Bv2zDIz+ZzvW6elUuO859z1+5wNWAcnUlvAaabVHN5DzU2Q==
X-Received: by 2002:a17:903:2c08:b0:295:9b73:b15c with SMTP id
 d9443c01a7336-29df5deb493mr123498985ad.42.1765296097804; 
 Tue, 09 Dec 2025 08:01:37 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e29ff6c68csm16475242b3a.19.2025.12.09.08.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:01:37 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 4/4] hw/char: sifive_uart: Remove ip variable
Date: Wed, 10 Dec 2025 00:01:17 +0800
Message-ID: <20251209160117.1239596-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209160117.1239596-1-frank.chang@sifive.com>
References: <20251209160117.1239596-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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

The ip variable is no longer used in the code. Remove it from the
codebase.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 hw/char/sifive_uart.c         | 6 ++----
 include/hw/char/sifive_uart.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index c3bb9d5ba66..4e8c8234175 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -285,7 +285,6 @@ static void sifive_uart_reset_enter(Object *obj, ResetType type)
 
     s->txfifo = 0;
     s->ie = 0;
-    s->ip = 0;
     s->txctrl = 0;
     s->rxctrl = 0;
     s->div = 0;
@@ -343,14 +342,13 @@ static void sifive_uart_reset_hold(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_sifive_uart = {
     .name = TYPE_SIFIVE_UART,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(rx_fifo, SiFiveUARTState,
                             SIFIVE_UART_RX_FIFO_SIZE),
         VMSTATE_UINT8(rx_fifo_len, SiFiveUARTState),
         VMSTATE_UINT32(ie, SiFiveUARTState),
-        VMSTATE_UINT32(ip, SiFiveUARTState),
         VMSTATE_UINT32(txctrl, SiFiveUARTState),
         VMSTATE_UINT32(rxctrl, SiFiveUARTState),
         VMSTATE_UINT32(div, SiFiveUARTState),
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index e216cacf693..50d7418f94b 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -73,7 +73,6 @@ struct SiFiveUARTState {
 
     uint32_t txfifo;
     uint32_t ie;
-    uint32_t ip;
     uint32_t txctrl;
     uint32_t rxctrl;
     uint32_t div;
-- 
2.43.0


