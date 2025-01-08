Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DBFE7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKk-00048v-Fb; Wed, 08 Jan 2025 04:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK6-0003v7-MD; Wed, 08 Jan 2025 04:25:59 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK4-0004m9-GP; Wed, 08 Jan 2025 04:25:58 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so4477484a12.0; 
 Wed, 08 Jan 2025 01:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328354; x=1736933154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WARyL/sIptXT/6LU6CvnimThOZH1GGz60bhERGh4Qio=;
 b=Ll+7BDf1I7g5wbiOCuj5bDsiQMrAcGsJx8M+3h7w5V5oflfrVCIj0LAd4GXTOJsyRd
 C9cl/Mfsmg3AvcfARaBAGnOub32Jg/syNdDpALDYIBN2Ce8r5JzgIWEMlPegNfLpBfTm
 lT4JzJFfNTP0yIYz21F4WT9PmOgzJ937XMNHwSXxC8dYxDDhRHbl0h9A+3Y7q7VQAZnd
 w85ugBX/aQEHN9HRGDUJqyejNIM5p4zICYfxmk2FWWAU2OM2fJTF1i5rTENumLpJX1N3
 NKo/4rrcfuYmVuzq7optpbRxm2sTy4gQgXfVejxxdRlWLMy4pM4nmDAcDvHPnBBOHrWf
 wUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328354; x=1736933154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WARyL/sIptXT/6LU6CvnimThOZH1GGz60bhERGh4Qio=;
 b=DmfA4hLKAxgYgid/oxtJw0Pxpk8pACMT0rt1PUFWx8O0eNXXVNqmtYX8L3+H55n+Bk
 LZrrKqoBIHUcRy5wzHohfq/aRAdRCEyWYQORlN2RpNbbdImHZH9XFlF11XFS77LOe7LL
 /krSUYLopVsGc+0SouJCbojG07J9kljwbMmsTXKRg4ahwC/wJI+g6RPxYcGhvu5NANwl
 bt9bIZdyGXsaNBkF/xEJmSTQU6RzRi1ctDSJ7A5qsoCXSY29xmJsNj++hwQzh04OV9/Q
 IYvDFRtKg47aixzLhkcJ1ouoTXr52OUHVspIZ0/9wea0D0LVKi9hZVNFKu7EAEAxG9HP
 1mxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ZIdoEaA0Xv/ZzK3fgTm5ISSspF2gmfTW2z1tbBvwnlsLV13BBYFRQPBweq0ayBQhdae1SaRW8U4FcA==@nongnu.org,
 AJvYcCWYEXTd7XoEWKdUeDZCFSDb7oTBRVnXe8/OrS9rzDrRX7hrNAhKTZ5EdUzJ13UbejQGC4OHObh3gw==@nongnu.org
X-Gm-Message-State: AOJu0Yyt+Ch9o5G8vl3Q6yJnXK8aW2ip/XJV34QFOE+cPN/RM+JDXraH
 9lEgdlNXLSOZtpMbYCh4s/+A3F2LbbIXq5kbmQGEkjke5tYHakKyGJajHnS1
X-Gm-Gg: ASbGncuAMTxunaEX5lI4TuVbCzeH92Q/qWmKjqQ8aiuSFHxMP2gYTI/c8jxnHY4tSoN
 iyGKaufjbV+SaeyZDJLtoPVBQDPQaee/ihyEQWHf3Ta3Ip9KAhkmSvRmZSrkIDIro1iETmGhkko
 xut6YoNHr9r/bud4wnBbbMzu8F1De9WXYTZ8xjeYtZaENS4woIcb02WCUQwFgulSD6XuBKFoOxi
 eAXN9BqLchCzSalNufBDIxaCX0kDUNU7TBGVSuacLbooc+3ua3mF6tiCy7L1rHPpT3JVNFNpFYl
 oWajpg1phlW14OOC6CG3TqY7wOZgx+rRlR2iZ2j/xBs3ApY=
X-Google-Smtp-Source: AGHT+IE1scwrn+1aPYcOQezRhReM9RpnOzi+LYbbriSddKttnoTUo9u5sN338NRmoif0SowZpTHRhA==
X-Received: by 2002:a05:6402:90e:b0:5d3:ec6e:64bf with SMTP id
 4fb4d7f45d1cf-5d972e6f92amr1699829a12.34.1736328353712; 
 Wed, 08 Jan 2025 01:25:53 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:52 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 03/14] hw/char/imx_serial: Update all state before restarting
 ageing timer
Date: Wed,  8 Jan 2025 10:25:27 +0100
Message-ID: <20250108092538.11474-4-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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

Fixes characters to be "echoed" after each keystroke rather than after every
other since imx_serial_rx_fifo_ageing_timer_restart() would see ~UTS1_RXEMPTY
only after every other keystroke.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/imx_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index f805da23ff..be06f39a4d 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -381,14 +381,14 @@ static void imx_put_data(void *opaque, uint32_t value)
     if (fifo32_num_used(&s->rx_fifo) >= rxtl) {
         s->usr1 |= USR1_RRDY;
     }
-
-    imx_serial_rx_fifo_ageing_timer_restart(s);
-
     s->usr2 |= USR2_RDR;
     s->uts1 &= ~UTS1_RXEMPTY;
     if (value & URXD_BRK) {
         s->usr2 |= USR2_BRCD;
     }
+
+    imx_serial_rx_fifo_ageing_timer_restart(s);
+
     imx_update(s);
 }
 
-- 
2.47.1


