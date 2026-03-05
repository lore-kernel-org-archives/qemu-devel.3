Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B46F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGtR-00029Q-KG; Thu, 05 Mar 2026 17:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGtK-0001dW-8h
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:59 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGt4-0002K7-Vn
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:44 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439ac15f35fso5296960f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748579; x=1773353379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0fWQlcqEdu3xeEmPvKTBsrxxf87NhxamikRBUy0vjs=;
 b=hXj8j/BTfDgVMp1cLJFi9Z6Q5krhKZ9t1RNoD2PTXAkyVn2A5NWo/zFtsdUX2v7X/M
 DELLFlGjzlMGOo911AoFnRIr8SdKt0j46+yHEJVdy63OBYLn3kN1qgNdnaiLLQFL5XO8
 kbHRz8uf3dDFzCrgFRmWAdz7SbEij7oD8ABSfIP/dZwoEpxRtmCKxfPXkcnHTK2u9ype
 br24z8SDFgWJX+0/yf9pZj3HFrfh0YRtuqJgMviORGAxn349nynH+AU21aSZQLTL8RF/
 RAK6STG05mhreKVe8u/m15L4bE8pHuxWeHw5KxKWpTR7VyDMibXMKLEK6lyCpbjSg18t
 RM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748579; x=1773353379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f0fWQlcqEdu3xeEmPvKTBsrxxf87NhxamikRBUy0vjs=;
 b=ixvvPvtLBClukkqCgcK6AmE/cLeffDrRRspHMzfzCOaY4e14i8DoFAI1rgnnmpI0Ef
 BAI6u63NnOi+w8+//KY7ue+/oV1qzCh3qv/OEHrcApELa+vYe8cXSrgDf+VVIr//dSot
 QrPq+O5wuxbmCaw3ybacTra/2pVoNsaS3Xa7D56oDZvupzuttw4ebU8G/UoB4dH4v3pB
 RhhHOwIB8Sp02pWCUWBI6uZZ+7A6S+pkBtHfyO6ZyzpsUjzP2wEju0I87iTXP1sQJrab
 wFkfKcQAREuHlRknhpBc3xcGCAoA/ahy8o8gDCWiBfGxVoB2iCCH1Qs8UTPhjTKWy57d
 qq1g==
X-Gm-Message-State: AOJu0Yw6j67pe0XjWpMge84UMu44XfZ30a0vhEzkuDphW406srxBWwFD
 h48S2AZGXrszMRDsCvche8g5X1tcBlOM6R/SFqRRG9IYSwSRtlI4WB3c559/Gw==
X-Gm-Gg: ATEYQzwbAEgjcIk2eMBYdyhIXlmd9fD89uTYIv7DIgWA/En0DunJpV40Le6AMHh5zqX
 09a+sAzBqr9o6/xcdB2ZiKPPiGhyQAeJ+cvhqtKr8vDhp6GaehEc3ph7NoY6AkyZeFP0ewc9F8L
 W/jzvGeUaDPGjjhH1/tmVZJzZ33R8DtMegIZkbbtdmgyUR5Dj2hM6bV4WZIj1gwE/E6EwFTfb5u
 EKS4vBeLnRocCtBx7beiF/oj63mDNgaJM4gRJZ14Krd6TCk5WatpdaG+deMh2IK4tiOXhpOYPFv
 TtjCsB+D/nwEQx2qDoKYEwIgT0nbZPW1e/RQiw+tptyCGl6zjt0RjIYVoaIaMMgJou2CQrBS22F
 dTHucHoWBDlusPm907VOdAIZkhSzMeVHMjjFKVZoFx8apncoI5O03PtL4Ak1hvo1ksxDkO7cMVh
 yTtybchgWQii7pvjSA0isrkryMaDoTXSJYAHeMIrlzExd0TVmM153/humhviK9tqL2Ry1t3Kaoy
 5mJIJduLWV0hEIKsiOAZcNvHKBUAAiEIv5pr7PkxKP4ozA=
X-Received: by 2002:a05:600c:4e05:b0:483:612d:7a9a with SMTP id
 5b1f17b1804b1-485197d632emr132061455e9.0.1772748579431; 
 Thu, 05 Mar 2026 14:09:39 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:39 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 14/14] hw/char/serial: Plug into reset framework
Date: Thu,  5 Mar 2026 23:09:11 +0100
Message-ID: <20260305220911.131508-15-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that SerialState inherits from SysBusDevice we can take advantage of
having the reset method be called by the bus hierarchy rather than having
to plug and unplug it manually.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index fc92897376..31ce3c7b40 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -31,7 +31,6 @@
 #include "chardev/char-serial.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
-#include "system/reset.h"
 #include "system/runstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -853,9 +852,9 @@ const VMStateDescription vmstate_serial = {
     }
 };
 
-static void serial_reset(void *opaque)
+static void serial_reset(DeviceState *dev)
 {
-    SerialState *s = opaque;
+    SerialState *s = SERIAL(dev);
 
     if (s->watch_tag > 0) {
         g_source_remove(s->watch_tag);
@@ -985,7 +984,6 @@ static void serial_realize(DeviceState *dev, Error **errp)
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-    qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
                              serial_event, serial_be_change, s, NULL, true);
@@ -1008,8 +1006,6 @@ static void serial_unrealize(DeviceState *dev)
 
     fifo8_destroy(&s->recv_fifo);
     fifo8_destroy(&s->xmit_fifo);
-
-    qemu_unregister_reset(serial_reset, s);
 }
 
 static const Property serial_properties[] = {
@@ -1032,6 +1028,7 @@ static void serial_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable = false;
     dc->realize = serial_realize;
     dc->unrealize = serial_unrealize;
+    device_class_set_legacy_reset(dc, serial_reset);
     device_class_set_props(dc, serial_properties);
 }
 
-- 
2.53.0


