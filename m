Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A5BE7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJk4-00023U-Jm; Fri, 10 Jan 2025 13:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJk2-00022S-8L
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:28:18 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJjy-0007QA-LP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:28:16 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso17827445e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736533692; x=1737138492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/yUFaRyzJYE/4lcFjJ8uzhfiQFfrwtitfN415Djc8k=;
 b=SNUoBJkdu1QA5YJwaIQXfsdVuJpFWOZpdbT0aOcS4o7kfyIKfPFOqGD7uhfUjqVN/U
 hBaSRc1kpFgV+jSg9tMkrDYt2DLAFwq589pzIahnQzW89O8U3uPu6X+O26CyYMlnVWB7
 A5gCcLtuhBF8F8lE2Xl3mgxVHBDcsxGxBbZDXIjmwuvKllc+TWkL6k/pzOjo9AHZskYm
 xqC3Hgh92KVQpRyPqadByNoc0nt2pRojC4dUcWn0ezW2hS1AqC80HwiwgcaBHEOvfS18
 NCTyQf3wyFQvwuuGq3A07f7mFrSVqNv+3ihSccnbA6OPAcCT/qMRPrIgetAvAttgG/15
 48Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736533692; x=1737138492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/yUFaRyzJYE/4lcFjJ8uzhfiQFfrwtitfN415Djc8k=;
 b=IAL+E5wuCzDJimxUvQ5lzWPP34l97LdWYtAOB+OFNTy56mhJG5Ux6HdE9yPvLs016D
 9A2xhT2u+N0amBkmRmg68/MDVDLU+7f1C++lS/RWQdAwdFpc1goAs92BP8gbHv95utIJ
 QWO/qZGhLqRftQ5Y58iiKMeM04P+nlEIeEpGt5NjO240c7IvohDyIwJ4iOz1nRvRdXR5
 /orTSsxqN23os46tsSJLsdi/eFssLPO829K4qNudBQCUngNoHsFX59SeGGg2wiMqwIgF
 MFUk+0c4O2nJec4I4UkvLvq+MInbWNJARJuuvKY1UTWG/bQJ3OpN9wT6Dx30LoT780/P
 omwQ==
X-Gm-Message-State: AOJu0YwmyoVVbetlJggIOw1xGeFkglkPPe+tGgqfXS+qLV5pEFHyagRv
 Ov2TMTAZi8SdiskQirwxgYss6dYoobUVfpGdBZmcmKwd1KwL0TzjZ+ZCxXfYVdPaspqSPD6dk5j
 9KAU=
X-Gm-Gg: ASbGncuh+TVg3MWrZfEwhAh2w1v2WIvOZxCS1iCbwiNb1vdmhZnXxglRn3s1qjmU8Pd
 aFDs18efyrHljS1uwlKoCwHNJFBnKId3STyySboSPjbzjd5cMArm4WtMZrY01BmCpG9Yif9VLzf
 5m5/fpxJ3KGcsTTyARFiGYJlMRdBnJTLrqdgI4jX+W4hct9cKNGXZmspweU6dPYDHgV2aYCe8ed
 88e+KSGmTH3SOfD5CKRaEZxTURS5OVojFkpPl/wmx48wrTcljBJXkJdHiM2Gf2DRFa0FgGkYXbQ
 2VndVx3pRDlXLjMAZGV2B0JM852eSWQ=
X-Google-Smtp-Source: AGHT+IFojk3zpZpqZhrxbfoGfJRIV8en3JrqqWCWbZDCeXKhZHzj2jztZxTUBERwoa/p7I0SaOKHCA==
X-Received: by 2002:a05:600c:1c8b:b0:434:f5c0:32b1 with SMTP id
 5b1f17b1804b1-436e26a7578mr116218715e9.15.1736533692137; 
 Fri, 10 Jan 2025 10:28:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcc8ddddsm82415595e9.0.2025.01.10.10.28.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 10:28:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] hw/char/serial: Convert to three-phase reset
Date: Fri, 10 Jan 2025 19:27:59 +0100
Message-ID: <20250110182759.84071-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110182759.84071-1-philmd@linaro.org>
References: <20250110182759.84071-1-philmd@linaro.org>
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

Convert the TYPE_SERIAL (16550A UART) to three-phase reset.

Only local states are reset so use the ResetHold handler,
like other legacy devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 562931685e7..9cb6e30c9ce 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -851,9 +851,9 @@ const VMStateDescription vmstate_serial = {
     }
 };
 
-static void serial_reset(void *opaque)
+static void serial_reset_hold(Object *obj, ResetType type)
 {
-    SerialState *s = opaque;
+    SerialState *s = (SerialState *)obj;
 
     if (s->watch_tag > 0) {
         g_source_remove(s->watch_tag);
@@ -928,13 +928,11 @@ static void serial_realize(DeviceState *dev, Error **errp)
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-    qemu_register_reset(serial_reset, s);
 
     qemu_chr_fe_set_handlers(&s->chr, serial_can_receive1, serial_receive1,
                              serial_event, serial_be_change, s, NULL, true);
     fifo8_create(&s->recv_fifo, UART_FIFO_LENGTH);
     fifo8_create(&s->xmit_fifo, UART_FIFO_LENGTH);
-    serial_reset(s);
 }
 
 static void serial_unrealize(DeviceState *dev)
@@ -949,8 +947,6 @@ static void serial_unrealize(DeviceState *dev)
 
     fifo8_destroy(&s->recv_fifo);
     fifo8_destroy(&s->xmit_fifo);
-
-    qemu_unregister_reset(serial_reset, s);
 }
 
 const MemoryRegionOps serial_io_ops = {
@@ -975,12 +971,14 @@ static const Property serial_properties[] = {
 static void serial_class_init(ObjectClass *klass, void* data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     /* internal device for serialio/serialmm, not user-creatable */
     dc->user_creatable = false;
     dc->realize = serial_realize;
     dc->unrealize = serial_unrealize;
     device_class_set_props(dc, serial_properties);
+    rc->phases.hold = serial_reset_hold;
 }
 
 static const TypeInfo serial_info = {
-- 
2.47.1


