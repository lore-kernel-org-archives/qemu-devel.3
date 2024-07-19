Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED127C3DA7E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 18:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUs50-0003VA-Ts; Fri, 19 Jul 2024 14:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4m-0002kQ-2z
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:28 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUs4i-0003qG-Lo
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 14:11:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-36798779d75so1108452f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721412680; x=1722017480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1KnnMz9QclH4DdZ0a7ONIaMOEDb8CpMIUXc7bRjrWI=;
 b=Tzpf0W61kW6KWL6zDf4iEIn75s8Cqd/ELkfoZaXfKnGZ21aVntorBjBwsScpMejugQ
 sKFXTQ/vtyYvda4LL3IfBuMfmst2GbjZI3N2a6ljAdvvtMQdNtLixX70+LAtFvIrS0AK
 fxZlikzpFsd9T6gyVSjsdwvgBPhNyyO4FBD/UZhohsD1Wlk5yghX9i6adBSyKfZGutCx
 MR0J/E8LLfqiu9ZL3i/j8+Ic9MmP0bpc4DEHG+1f9UNnwyW65EUcuF1SUTwzbW2frNxl
 4hCOxa73R+bR4Q5bVoTe33rU4ACoGp9jqpuCxEj5pw6XRPqXULimJNPj6uA+6WL5x0tu
 Ch/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721412680; x=1722017480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1KnnMz9QclH4DdZ0a7ONIaMOEDb8CpMIUXc7bRjrWI=;
 b=AW+bWak7HhmstJcD3SDfX2PU9c9vOrBOEQM4cnkDAqQU0aDZxITJD+tohpAjI3PsAT
 opp1QpaINDWaeHf/15OiA7yo+5iVOj/SZFWhurYqJSPPelK/GC/lF2tRgs8KbyOLXsIM
 KbRJj6q9GmgaLN7/ff8aYqGvfUPB2HuOGW8F7mJvh5GXWLs/FFBSNFMs9IgFsIjNTz0c
 ijOAk5eik92axu0gArG11RRPkmXV245RMqVKZ6+/0GuwNOlSoubJ+joX9PbUbKXhifJp
 nTRMGGYgXZ8YgTMWGUapmcL81DON9souwowraFBbtT4Sqlo03HEq5eLsKduYucqo/kl1
 XEqQ==
X-Gm-Message-State: AOJu0Ywn18QEX0xUArtV7OqOTMfrJtozQqJZse7v1hy7EtJhiYsT8LVt
 oSPsBc85PnLODCHk+rlF2UOSrra2tETMJ/MeFyPAzIAqdV2f0adDIp3PD5funHVY6NYoiioptRS
 v
X-Google-Smtp-Source: AGHT+IG9hl88XdJg/Z73hgjLd2nmae6FJDicArw0XdXqkXkS5y4JzZxWDEEbwJuiyZoqf0LbZ2f/Hg==
X-Received: by 2002:a5d:4609:0:b0:368:78d0:c240 with SMTP id
 ffacd0b85a97d-36878d0c769mr2212400f8f.35.1721412680638; 
 Fri, 19 Jul 2024 11:11:20 -0700 (PDT)
Received: from localhost.localdomain (52.170.88.92.rev.sfr.net. [92.88.170.52])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868bb00sm2245597f8f.43.2024.07.19.11.11.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 11:11:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 06/16] hw/char/pl011: Extract pl011_write_txdata() from
 pl011_write()
Date: Fri, 19 Jul 2024 20:10:31 +0200
Message-ID: <20240719181041.49545-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

When implementing FIFO, this code will become more complex.
Start by factoring it out to a new pl011_write_txdata() function.
No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/char/pl011.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 3d294c3b52..c2ee9b0321 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -221,6 +221,18 @@ static void pl011_loopback_tx(PL011State *s, uint32_t value)
     pl011_put_fifo(s, value);
 }
 
+static void pl011_write_txdata(PL011State *s, uint8_t data)
+{
+    /* ??? Check if transmitter is enabled.  */
+
+    /* XXX this blocks entire thread. Rewrite to use
+     * qemu_chr_fe_write and background I/O callbacks */
+    qemu_chr_fe_write_all(&s->chr, &data, 1);
+    pl011_loopback_tx(s, data);
+    s->int_level |= INT_TX;
+    pl011_update(s);
+}
+
 static uint64_t pl011_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -388,14 +400,8 @@ static void pl011_write(void *opaque, hwaddr offset,
 
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
2.41.0


