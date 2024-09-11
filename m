Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E6FEE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIs-00058B-AF; Wed, 11 Sep 2024 08:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHw-0001MX-D6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHt-0007Yk-8a
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3770320574aso4227937f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057047; x=1726661847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9gIofjX7RIq2gT0KXoGguqrnUK/Equy8B4Tk/49iCs=;
 b=X9esdbGm+pv6nEEsRlzxpoGH3O/ynFVMIXlvQeZzW254NXRBh9xiRa791HaLeGZLh/
 ZIuZ+BY2K+csrZKbBI8Z1ufGVpk2CCl271GV8Fg6pQZPRXewNt3mrel/UHCP74UKHchJ
 IlS/0nzk5SBdjHsY/caIsl7bHu+7FEMVH/w7HaMAuIMAk4TAJIYxC+upetw+Cpgdl6iV
 UCIx3OVZKLQ9TSbzECbuq1NXAI1pj0YnWPVE8LZonFSzoNcVXAkjtT6m48lVI7lcWMfv
 ORsFH/TPL6NWy12K1rS0VkEdjBPhHuD8AxL1fP/ULgk5Sj/Wz5qpZBpy3qrF7+AySK9G
 v+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057047; x=1726661847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9gIofjX7RIq2gT0KXoGguqrnUK/Equy8B4Tk/49iCs=;
 b=qEtTXfvlIk5jhhOisF/02i9fonKRO7eqZzDAaFWWj+XnwMNuqJlUrRdDzObHNFq61+
 n5fEb+ZiTI8npUvX9/6dMZEPHls8bhfgn9M7XeOIBuAlkRfGeZa2WhnAiEX3SQMkXPJy
 oUfYaaGHEPUuiOHmsHHwOf3qwQKvMJzmxnODjptbCKRXzlLP2A3vqiwqHZ7o5vX+c2MM
 /0C3e9fGQvuIPu7AJGenUBHUS17ZOvsz6W6M3DJVrAAB5nGHiXYOBny2BJFyjEe9sPmF
 s2vq8SIowyCDxsAB0DmHYjhVcakHUlR57t7feiwfudXBYHqrsbPXFuzT7gkAHWpjcgHJ
 ZSNw==
X-Gm-Message-State: AOJu0Yyh93JuwK94GzZG3En2OjFbscl/q3MyPI3MI8DKAPny9t7+GJKD
 QdkktXY9hblZTlwFIzljsq/ZlhR1Wvn5CoqSxDpRHqyKqDn4c7JuInRteuoVQobRXcKcDEICAHb
 R
X-Google-Smtp-Source: AGHT+IEsDzIJZMIDeAJOQPx539Vl/Gcph9UM8MJg+IdzoPna19nZqZMWOa58endrQxmI3uBAS+ve0Q==
X-Received: by 2002:adf:db41:0:b0:374:c324:eab5 with SMTP id
 ffacd0b85a97d-3788967ab6amr11602696f8f.41.1726057047235; 
 Wed, 11 Sep 2024 05:17:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649733sm11446642f8f.8.2024.09.11.05.17.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 27/56] hw/char/pl011: Extract pl011_write_txdata() from
 pl011_write()
Date: Wed, 11 Sep 2024 14:13:52 +0200
Message-ID: <20240911121422.52585-28-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

When implementing FIFO, this code will become more complex.
Start by factoring it out to a new pl011_write_txdata() function.
No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240719181041.49545-7-philmd@linaro.org>
---
 hw/char/pl011.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 3d294c3b52..1dfa60cb12 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -221,6 +221,20 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_put_fifo(s, value);
 }
 
+static void pl011_write_txdata(PL011State *s, uint8_t data)
+{
+    /* ??? Check if transmitter is enabled.  */
+
+    /*
+     * XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks
+     */
+    qemu_chr_fe_write_all(&s->chr, &data, 1);
+    pl011_loopback_tx(s, data);
+    s->int_level |= INT_TX;
+    pl011_update(s);
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -388,14 +402,8 @@ static void pl011_write(void *opaque, hwaddr offset,
 
     switch (offset >> 2) {
     case 0: /* UARTDR */
-        /* ??? Check if transmitter is enabled.  */
         ch = value;
-        /* XXX this blocks entire thread. Rewrite to use
-         * qemu_chr_fe_write and background I/O callbacks */
-        qemu_chr_fe_write_all(&s->chr, &ch, 1);
-        pl011_loopback_tx(s, ch);
-        s->int_level |= INT_TX;
-        pl011_update(s);
+        pl011_write_txdata(s, ch);
         break;
     case 1: /* UARTRSR/UARTECR */
         s->rsr = 0;
-- 
2.45.2


