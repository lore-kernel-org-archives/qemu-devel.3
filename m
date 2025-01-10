Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3723E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWJFz-00028x-Ua; Fri, 10 Jan 2025 12:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJFw-00028j-U9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:57:12 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWJFv-0003Cn-7F
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:57:12 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1307485f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736531829; x=1737136629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p5ISWojPgo9WK3ygV/aJcl6uT1BqiAXPMA4HtQhz2so=;
 b=IA8MOQaxLDhqPMtjzY6NbABPvmRVkHI4IG4l7+Dsr8yPy0D0dI3e/GwP2DkAu5kmiB
 ohrZhCVlMIp+Z8zy3pabhVkL8UkWy9jJgEGcpuvOH9Ybst7sLBsbXhngkHb/vkU7qTKS
 sOntR8XKvGLGb+EvWwVnHcxWh3B8ikgO/PpgeZr0SxFItsC1R7n9vE+whmYMZvN+2zai
 BYVvNuOTJpCnwyeKiFJQtl+vKFvvq5ulBkR/MZ6l8G0wXUkQSwQL5r9PqYjBB5h4ZIw6
 XQQ8pJ9D4mJ8FXbY6sFf8++zkRQ5NlstMqB+pl8zom1tXLol3PpNU6pt0x7JkljB29co
 T24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736531829; x=1737136629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p5ISWojPgo9WK3ygV/aJcl6uT1BqiAXPMA4HtQhz2so=;
 b=YLIsOM8YUtNFiABvrb9UrG1PdollKgZNmKiZPHs+JdfdM0zIiMM5GuBBdeQ+6l17Ya
 L9IR8ZO2jaBhD1+S3gNIIfvu98fOkfnGFkiVW6J2+zlT7uHenKSF0sCJ87rEtinHPIsF
 CjH5uUAMsy9Rl3skyVOASw/SD6PDcITU9DCeJpw7v+jKEBuuobyzZpBO+C7szxbmSNnK
 ZDw0uyw+2LFF1kBa7+5zUs4OxhBilOb4CSwGjOukDtboKCr1zcg2hxTDV4JX9F5Vhp5B
 gWJ6UNExt2B7VNvQ9EoDGzDMFG3uFDn8ZsJ7qWh9SnbSW8T/kv+PmY2wtTOwsKSeUHw8
 LmuQ==
X-Gm-Message-State: AOJu0YxrMIrgOUCWF/TB2dIb6nhwRbNDBF9cdQO8kN5c0ygXgbYHUDZG
 y92vAyVru2MDzGJ7fNVPNFW6GYbMX1T8VzDbg2NSoA1PYCmDucwgY/ELkprPQvUPUeQlkwl/y42
 6rnQ=
X-Gm-Gg: ASbGncvy56QgcG49kmkb5V4uYIiZf8m2zEFK+vP9X0NJVXwV2jp9sjZV5LU/sssbnBS
 DjkJWjkiYhzp7YgHHT+tfdQXl1ge/KMd/chCqqdaf4hPX8ekcXduwZhj9sZ1+NxLTi5RIulAkw3
 w2+Io2Jc5S6TAu6A1TVlVW42Sac8v5+xO83RJyyUjMqNIu/tsSuqeKW6s+NkbjwGSHnR5GMK8u4
 T1DtRVpgPWc9Y9NgOGWnXjMVv+62ESCmrk/HEG/l9173Ro5p7IrgsGcWo9fNDRS24uWgB9fbvNV
 MN0GK5QoEumfp5tJ6L7hiNmeidVIRqE=
X-Google-Smtp-Source: AGHT+IFpJY+6qi7o5c2lzRbVYen0GHvvgY8tqfvL1LAbH/+wpRX732DXoFyyR+SLcBRaWAy7AkE3uw==
X-Received: by 2002:a05:6000:712:b0:385:f3fb:46aa with SMTP id
 ffacd0b85a97d-38a87308c15mr11721227f8f.43.1736531828837; 
 Fri, 10 Jan 2025 09:57:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d111sm5234556f8f.18.2025.01.10.09.57.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 09:57:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/char/serial: Convert to three-phase reset
Date: Fri, 10 Jan 2025 18:57:07 +0100
Message-ID: <20250110175707.82097-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Local states are reset in the ResetHold handler.
Move the IRQ lowering to ResetExit, since it an external
object is accessed.
Note, this fixes a bug where serial_realize() was calling
serial_reset() -> qemu_irq_lower() while the IRQ was not
yet created.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
That said, externally creating IRQ like that is odd, see:

  serial_pci_realize()
  {
    SerialState *s = &pci->state;
    qdev_realize(DEVICE(s), NULL, ...);
    s->irq = pci_allocate_irq(&pci->dev);

But too much cleanup for now, one step at a time.
---
 hw/char/serial.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 70044e14a0f..0dab5fba176 100644
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
@@ -885,12 +885,18 @@ static void serial_reset(void *opaque)
 
     s->thr_ipending = 0;
     s->last_break_enable = 0;
-    qemu_irq_lower(s->irq);
 
     serial_update_msl(s);
     s->msr &= ~UART_MSR_ANY_DELTA;
 }
 
+static void serial_reset_exit(Object *obj, ResetType type)
+{
+    SerialState *s = (SerialState *)obj;
+
+    qemu_irq_lower(s->irq);
+}
+
 static int serial_be_change(void *opaque)
 {
     SerialState *s = opaque;
@@ -926,13 +932,11 @@ static void serial_realize(DeviceState *dev, Error **errp)
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
@@ -947,8 +951,6 @@ static void serial_unrealize(DeviceState *dev)
 
     fifo8_destroy(&s->recv_fifo);
     fifo8_destroy(&s->xmit_fifo);
-
-    qemu_unregister_reset(serial_reset, s);
 }
 
 const MemoryRegionOps serial_io_ops = {
@@ -973,12 +975,15 @@ static const Property serial_properties[] = {
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
+    rc->phases.exit = serial_reset_exit;
 }
 
 static const TypeInfo serial_info = {
-- 
2.47.1


