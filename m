Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2BDFF885A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 06:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPr8-0001Aj-A6; Sun, 03 May 2026 01:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM69-0004vX-Ug
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:21 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM68-0000T9-73
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:21 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2ef38cf04f0so1238998eec.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773498; x=1778378298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2TKKB6U+GwReeGYv3aDJklJVz+rIvoLzCBt6yji+TY=;
 b=c+Xkx3SUPuXTGiPWc8Vy6wJ5wTTfizWEpl2Ui89X56k3dj0KF0ybSNUiKeigVQFDr0
 ODUZwU1rFh60eHXM/JL677yhhvr9AvHDYFhUsxOjUDGVSOXqZJtskipXjfQWpjirTKEp
 w4Moof7G6IeIZAhbhYnN3RXCbpeJ0VTBRpGA1j/m5q/8JoTUSNM8Olu74KcSNHp9WA2p
 zRVnmA7YZ0gSCSqDymwYJZB2X/cWpxw6t0fM1QmxYxnHiyGVP8faStuT8AmkIakHsZy8
 nzMuRtn46ChP83hRK0H/xkquIngAs7UbPRZSOWgMBbHMUV58ZPSUg05TLmhQzaAH6RZv
 2Bbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773498; x=1778378298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I2TKKB6U+GwReeGYv3aDJklJVz+rIvoLzCBt6yji+TY=;
 b=gBAbbioAJSpnB6Anb1YSmYl4CEeN/QSQGMH3YhsQ+GWuMlXGhoMiEzLCJ5lpeHZ/jO
 nlBnS8ADDC/qSYcfw9IDiiKo1DANYYpse0cPGSXN4kyGW/5zT2WJf6fR4NiHXtt/HRVb
 5spMfX+3QgCI7BB+KsF+xV53Y2OCuW6MjFQXZd+zwiLOVAWJQNicPCB7NNkUsAFsKel/
 FJsqUp1UE/UFLWc3hE66SYTjOpQOTZLBds8/Cf/Tns89NcXrzKcjWruyBxpdtpcww6wH
 7T1YsAg+NmQ8zUOwptTJBZQyALzR1tz5k/rYm0F+o/4QMZVH9u3/ZvndtdZBDP9qkWxW
 sjZQ==
X-Gm-Message-State: AOJu0Yy2HUPOVbP7KbbNW50UPGZ597zL6onjiGay6jOtkXhzIi5nnGWF
 mcPyDfXOoh+UhzXD24bxU0L1o3af3Y9umnvwxP3ZEOXp7acCkGq63sn4/CM9Xg==
X-Gm-Gg: AeBDieu1dXANmLtFP3b7GiIXNaF55tT0g1UXw5nRwvng8C0BswHrAplNXbMXAlQUzh+
 QdEHxkV9ue4nhun6P8MTpE2gxlKHe3bZou6Mbsr8R8DYEFaYd2LVzzvkfWegWePwuGOmXNoCoz+
 Db3TnLyOTaI5aNvuM3Nx7GkfvPeri/rSkGH1dEQVovCr454oNpGQxwxQRJcAH5nxMzrBpL1kD+9
 NdnkdxuWstC8WIhLDKG72XKFLcxYGdt89pv3VTjbsfLH6bGDSeOi56QmB7KH9VNKVmMhF2ZRaZ/
 q+874VIf0U0RSMELw/6KUhKOsKqxWEX4w4n3Okij/Ju2nI9+1MzaPsD4restRwnW3qMVAFoLZEk
 ImW4Nd/kRREq+GZ75uXA1En1uXUwGmDiItdzlIkYN2sq+u/E1PLJ+1BSAIwSySnnW1Xwxjl7sAO
 LEoAWbv6zJUHjDXmzm03uC7ls1oONVEaTy/56C+tuc5V/3DT1eKg==
X-Received: by 2002:a05:7300:fd0a:b0:2dd:6937:79b8 with SMTP id
 5a478bee46e88-2efb7dcacd4mr2400101eec.5.1777773498418; 
 Sat, 02 May 2026 18:58:18 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:18 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 3/7] hw/char/escc: Expose diagnostic RS232 I/O routing
Date: Sat,  2 May 2026 18:57:52 -0700
Message-ID: <20260503015756.99176-4-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503015756.99176-1-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=54weasels@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:59:00 -0400
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

This adds proper initialization and routing hooks for the ESCC serial controller to support the specific diagnostic RS232 UART mappings expected by the Sun-3 Boot PROM.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 hw/char/escc.c         | 33 ++++++++++++++++++++++++---------
 include/hw/char/escc.h |  3 +++
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 3b46818ecc..d870806a35 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -313,7 +313,8 @@ static void escc_soft_reset_chn(ESCCChannelState *s)
 
     s->rregs[R_STATUS] &= STATUS_DCD | STATUS_SYNC | STATUS_CTS | STATUS_BRK;
     s->rregs[R_STATUS] |= STATUS_TXEMPTY | STATUS_TXUNDRN;
-    if (s->disabled) {
+    if (s->disabled || s->parent->force_hw_ready) {
+        /* Force assert to satisfy Sun-3 PROM Flow Control */
         s->rregs[R_STATUS] |= STATUS_DCD | STATUS_SYNC | STATUS_CTS;
     }
     s->rregs[R_SPEC] &= SPEC_ALLSENT;
@@ -653,7 +654,8 @@ static void escc_mem_write(void *opaque, hwaddr addr,
         s->txint = 0;
         escc_update_irq(s);
         s->tx = val;
-        if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { /* tx enabled */
+        if (s->parent->force_hw_ready || (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN)) {
+            /* tx consistently forced enabled for Sun-3 boot PROM hooks */
             if (s->wregs[W_MISC2] & MISC2_LCL_LOOP) {
                 serial_receive_byte(s, s->tx);
             } else if (qemu_chr_fe_backend_connected(&s->chr)) {
@@ -691,6 +693,12 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
     case SERIAL_CTRL:
         trace_escc_mem_readb_ctrl(CHN_C(s), s->reg, s->rregs[s->reg]);
         ret = s->rregs[s->reg];
+        if (s->reg == R_STATUS) {
+            if (serial->force_hw_ready) {
+                ret |= STATUS_DCD | STATUS_SYNC | STATUS_CTS;
+                /* Force Flow Control PINs */
+            }
+        }
         s->reg = 0;
         return ret;
     case SERIAL_DATA:
@@ -715,6 +723,10 @@ static const MemoryRegionOps escc_mem_ops = {
     .write = escc_mem_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+        },
+    .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
     },
@@ -1067,16 +1079,17 @@ static void escc_realize(DeviceState *dev, Error **errp)
     s->chn[0].disabled = s->disabled;
     s->chn[1].disabled = s->disabled;
 
+    uint32_t escc_size = s->mmio_size ? s->mmio_size :\
+                         (ESCC_SIZE << s->it_shift);
     memory_region_init_io(&s->mmio, OBJECT(dev), &escc_mem_ops, s, "escc",
-                          ESCC_SIZE << s->it_shift);
+                        escc_size);
 
     for (i = 0; i < 2; i++) {
-        if (qemu_chr_fe_backend_connected(&s->chn[i].chr)) {
-            s->chn[i].clock = s->frequency / 2;
-            qemu_chr_fe_set_handlers(&s->chn[i].chr, serial_can_receive,
-                                     serial_receive1, serial_event, NULL,
-                                     &s->chn[i], NULL, true);
-        }
+        s->chn[i].parent = s;
+        s->chn[i].clock = s->frequency / 2;
+        qemu_chr_fe_set_handlers(&s->chn[i].chr, serial_can_receive,
+                                 serial_receive1, serial_event, NULL,
+                                 &s->chn[i], NULL, true);
     }
 
     if (s->chn[0].type == escc_mouse) {
@@ -1093,7 +1106,9 @@ static const Property escc_properties[] = {
     DEFINE_PROP_UINT32("frequency", ESCCState, frequency,   0),
     DEFINE_PROP_UINT32("it_shift",  ESCCState, it_shift,    0),
     DEFINE_PROP_BOOL("bit_swap",    ESCCState, bit_swap,    false),
+    DEFINE_PROP_BOOL("force-hw-ready", ESCCState, force_hw_ready, false),
     DEFINE_PROP_UINT32("disabled",  ESCCState, disabled,    0),
+    DEFINE_PROP_UINT32("mmio_size", ESCCState, mmio_size,   0),
     DEFINE_PROP_UINT32("chnBtype",  ESCCState, chn[0].type, 0),
     DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
     DEFINE_PROP_CHR("chrB", ESCCState, chn[0].chr),
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 9e60175b77..db4700d8e4 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -49,6 +49,7 @@ typedef struct ESCCChannelState {
     int sunmouse_dx;
     int sunmouse_dy;
     int sunmouse_buttons;
+    ESCCState *parent;
 } ESCCChannelState;
 
 struct ESCCState {
@@ -57,9 +58,11 @@ struct ESCCState {
     struct ESCCChannelState chn[2];
     uint32_t it_shift;
     bool bit_swap;
+    bool force_hw_ready;
     MemoryRegion mmio;
     uint32_t disabled;
     uint32_t frequency;
+    uint32_t mmio_size;
 };
 
 #endif
-- 
2.50.1 (Apple Git-155)


