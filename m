Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E4C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrJw-0002Ew-Di; Wed, 19 Feb 2025 16:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJp-00026N-9Z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrJm-00008k-QT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:09:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso1656255e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999357; x=1740604157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3COjV92AMlpj3jvv9iQTT0YQlZwWPXgOl76J5cO1OMU=;
 b=n7pKNf+JhAXKhINkvUkjqsaFXn/wK9Dp9ql/j3tEPJZOzElLQpCOPctx93I8U0zQBn
 MMYL+HKhS5w4HLlivX3Ayrg29UHfLH/D3Iglc2g4CyJRVQsQE0uPpGiHgZ1laGUeLzfv
 q8MMjFyOdwhq/WbQW0HuBGcaDhzV4VhwxyTUff6VfntW90JZ4BlgE30dUXbDVTmVHumJ
 eYURpDODFLnGcikr+ICrxDq1+LmJBbqglUFg8u/axrGRtIZEoWvGIXPjIjRmzAznFcn5
 pwhjOOmTAwmcS8c6qXGQcqSurDjhnW5bvYHPckXdM7bbRWcDPGU0yNsm0juf9oCIQJ5n
 mrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999357; x=1740604157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3COjV92AMlpj3jvv9iQTT0YQlZwWPXgOl76J5cO1OMU=;
 b=qqAsVkrPqymvJAWyGxGmM6cKjU4lF5/NmRoOLXckhQmJtde6oojnT6rFBVFF/d8GXg
 NJLq7ES0KAy0tMycYI7lBfVmXMHdqv16GRONX/Vm3EVcbyLouqDUgh1fBjGcgZldFKjC
 AWGUWeKEgS9QJ4Avi66YXSIWpQt/xusWWkwF1UXrkF7nSRY7BA1pdJDaAkBy5FAF2v/m
 YY2Qr0WL0NAlBR29W441G2eC1tNTeyfLu746GLOkYX9Su1fz+57d9dlaJ15/l8CYwXqy
 KbGy3lpYnifBwhPexQfPTo/XMGqXZX6I60mhKb8HVpeRdv5RYAwVPWqmrfli3a37fJ5B
 gglA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiNXslxgUVYYYVclTSTbWwf4mtFzvZaKjwgcFWdWvSTJTPXvL2xYstvbSQ9MIllEoOl7wdCgaBMM7K@nongnu.org
X-Gm-Message-State: AOJu0Yza7lKXnGCpcms8yn/UnK4LUMBFJgNH3LTdcUEecWlnQ8s1zOIW
 T0NuDoH/ChgkoS1G1311se//liiqoiNzgtr91KSvy9CSiY9jqbLac/a9oySbaAE=
X-Gm-Gg: ASbGncsJ3ItVZmfjK4D9FNyG8Sz0eX85sTs7BeXL6Rc2hqTWRpHVFDACEQsE6k22PNL
 2Nly1n0XQfedL0UK0OUjpbtzgg6tLASNZfp0rgXFqg50ypdXV+/IJG9iM8YlGUiHc5EsEi2ciQr
 AjFTj55wU8G/nvCuZxMvjD4vfTncRpDTw/Ek1SOaDLK89cyvWH8oaV91Led3jokVGi4u8KxDUxg
 H08t2c5+m0OoRY//Xtr26rfQIxlMH4hajL385MZzLaQR61d3MHSEdsmp1ugHV+0UZyhBDlDe1pf
 iepo8c5UGPnhyW1Ext7AY8fUAYhYFgqUgJ+DgBYSyXnmd2XfF2SDTE6JkYqDOY/Crg==
X-Google-Smtp-Source: AGHT+IHU4eUr3Yoqi1s4C3qI/7nZusOV3MFaTyZkQ5og19oJJ4B22TP2W9HKt5um3KFZ4b6STAOwHA==
X-Received: by 2002:a05:600c:1c1a:b0:439:9274:81dd with SMTP id
 5b1f17b1804b1-43999d72b69mr42422485e9.1.1739999357169; 
 Wed, 19 Feb 2025 13:09:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399600257asm55374655e9.4.2025.02.19.13.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Feb 2025 13:09:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Luc Michel <luc.michel@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Subject: [PATCH 6/9] hw/char/imx_serial: Really use RX FIFO depth
Date: Wed, 19 Feb 2025 22:08:38 +0100
Message-ID: <20250219210841.94797-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250219210841.94797-1-philmd@linaro.org>
References: <20250219210841.94797-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

While we model a 32-elements RX FIFO since the PL011 model was
introduced in commit 988f2442971 ("hw/char/imx_serial: Implement
receive FIFO and ageing timer") we only read 1 char at a time!

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/imx_serial.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 38b4865157e..6f14f8403a9 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -386,7 +386,8 @@ static void imx_serial_write(void *opaque, hwaddr offset,
 static int imx_can_receive(void *opaque)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
-    return s->ucr2 & UCR2_RXEN && fifo32_num_used(&s->rx_fifo) < FIFO_SIZE;
+
+    return s->ucr2 & UCR2_RXEN ? fifo32_num_free(&s->rx_fifo) : 0;
 }
 
 static void imx_put_data(void *opaque, uint32_t value)
@@ -417,7 +418,10 @@ static void imx_receive(void *opaque, const uint8_t *buf, int size)
     IMXSerialState *s = (IMXSerialState *)opaque;
 
     s->usr2 |= USR2_WAKE;
-    imx_put_data(opaque, *buf);
+
+    for (int i = 0; i < size; i++) {
+        imx_put_data(opaque, buf[i]);
+    }
 }
 
 static void imx_event(void *opaque, QEMUChrEvent event)
-- 
2.47.1


