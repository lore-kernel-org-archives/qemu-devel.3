Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE18C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8P3-0001Pi-1S; Wed, 30 Apr 2025 10:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8OR-0001EW-Ck
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:38 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8OM-000765-Av
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:35 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c081915cf3so1177716085a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023188; x=1746627988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wudwU0Mjh7FMfb66kwc7bqI37P6PrLMFSD6vy2kDJU=;
 b=laY85Oe7/k0g2bXHnk3xoPtuAJ06mQmd1glTk+q3ik+qFwroDjzdZE6kNscZwtjkWq
 aGfp6u6VJ8WyLFRopKZxAibbYUTaubi2guTzbIFsqyWDtYFDTUi1kSnDayoHnxl08Ue4
 1y0KmPy00oE2IuOPM0kzC0SjTbDNmM/CkxjiJAQOoD3My0sSr2QSb2VQzntJsOLXD1K1
 Q33CkaNjSrZXRJNTP+wfOktk6fFmrGJNk2ktKoWRTcZdqugWkP3Q2NwzXVxoXErx7Ooq
 1pXKfjcoQL05uWxEnag7B8ec7EDK/BKbXA4Uskl6AQuqO+47jBetZcbFqhEqS9OHguXJ
 v84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023188; x=1746627988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wudwU0Mjh7FMfb66kwc7bqI37P6PrLMFSD6vy2kDJU=;
 b=NEpMYwSesLOwHYjZM+//vhHM9NIR/ww0dIw9axUQjABvauuqmSnrzC7IGrbiO5ejKP
 dD23+runMrH/Z3TMHs/oprYZTnJWKXPH5Kl/W8hnjiyBPIT/WJ0xpo1oLZqOX3KmkszY
 Dws0xc2gnnuhdVMIwqROQrb+QkVN6xeSw0MWVH/1BmKnpQ2ZpgqAGgrIyEiiCESYe9Gn
 rkO7IcI1Fjb2nDtl88D/DBr9lC23uZ0jgiVrfXTgjy6ucnuLjklJJW872+wDYasgZZ5v
 4iKEM2DFt8RchZkZdLmrXw44HkHn61b82ojdUWa+QPeADlz1cWdv+dxh19dji0xnchIz
 iHwA==
X-Gm-Message-State: AOJu0YzkPxrnZOOOENGeEYo3EKzLx3ogWQ5rPjeGq35w0KusKYum7vLm
 sJtRp3FZt/kGmDAtnItBswdq+slmFmcrYa6uVDW8WU9qhu9gH7AxCfU3lE6V+CsaNpB7e3ejoO7
 P
X-Gm-Gg: ASbGncssb2BIt2297KjHdZ3WqJDMgb0p2BRWAWksKrkctmscMoCf+fnx0hpGLs8ud6J
 AOfh6HE8Y7bt4eP4e2CBu9AOtIjA8Mq9JafPG8lBMF7JgjtcPUSkLS6Ezsh87JHHca5SIzYvdhl
 hT+XAUKHP84GPBi6EMtkAoAj8DwkrwhXZjH9mEg0iBshRBG9gQRKmmNJnwUSxUs6H/q3HLDPoWV
 AQKXFdpd7ZFxq3P10UoeMbF7YGqn9L7cSoM+iznItGqZ/BFVHMumc/5TWo+5kwoENSDQpq8LMB1
 cJS9fEjYjFhUWstRejMTDO0lPSlKSfeTnJRTUDiB5MyBeRj+lVzeYsgUf55S4zowNTSzFmZlhLG
 sPPQX0znyz3uq9ko=
X-Google-Smtp-Source: AGHT+IE8kgSvLk6eL9zyOnSn0o9HeKRN/nWHaxdVgkiRb7SHu7sHw1t3P+7H5jtm88+xUtRFKpWSxg==
X-Received: by 2002:a05:620a:469f:b0:7c7:56ac:1e89 with SMTP id
 af79cd13be357-7cac7dd38b8mr379745885a.3.1746023187979; 
 Wed, 30 Apr 2025 07:26:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958d87309sm859262085a.80.2025.04.30.07.26.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 07:26:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/intc/ioapic: Remove IOAPICCommonState::version field
Date: Wed, 30 Apr 2025 16:26:06 +0200
Message-ID: <20250430142609.84134-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430142609.84134-1-philmd@linaro.org>
References: <20250430142609.84134-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x72d.google.com
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

The IOAPICCommonState::version integer was only set
in the hw_compat_2_7[] array, via the 'version=0x11'
property. We removed all machines using that array,
lets remove that property, simplify by only using the
default version (defined as IOAPIC_VER_DEF).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/ioapic_internal.h |  3 +--
 hw/intc/ioapic.c          | 18 ++----------------
 hw/intc/ioapic_common.c   |  2 +-
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
index 51205767f44..330ce195222 100644
--- a/hw/intc/ioapic_internal.h
+++ b/hw/intc/ioapic_internal.h
@@ -82,7 +82,7 @@
 #define IOAPIC_ID_MASK                  0xf
 
 #define IOAPIC_VER_ENTRIES_SHIFT        16
-
+#define IOAPIC_VER_DEF                  0x20
 
 #define TYPE_IOAPIC_COMMON "ioapic-common"
 OBJECT_DECLARE_TYPE(IOAPICCommonState, IOAPICCommonClass, IOAPIC_COMMON)
@@ -104,7 +104,6 @@ struct IOAPICCommonState {
     uint32_t irr;
     uint64_t ioredtbl[IOAPIC_NUM_PINS];
     Notifier machine_done;
-    uint8_t version;
     uint64_t irq_count[IOAPIC_NUM_PINS];
     int irq_level[IOAPIC_NUM_PINS];
     int irq_eoi[IOAPIC_NUM_PINS];
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 133bef852d1..5cc97767d9d 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -315,7 +315,7 @@ ioapic_mem_read(void *opaque, hwaddr addr, unsigned int size)
             val = s->id << IOAPIC_ID_SHIFT;
             break;
         case IOAPIC_REG_VER:
-            val = s->version |
+            val = IOAPIC_VER_DEF |
                 ((IOAPIC_NUM_PINS - 1) << IOAPIC_VER_ENTRIES_SHIFT);
             break;
         default:
@@ -411,8 +411,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
         }
         break;
     case IOAPIC_EOI:
-        /* Explicit EOI is only supported for IOAPIC version 0x20 */
-        if (size != 4 || s->version != 0x20) {
+        if (size != 4) {
             break;
         }
         ioapic_eoi_broadcast(val);
@@ -444,18 +443,10 @@ static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 #endif
 }
 
-#define IOAPIC_VER_DEF 0x20
-
 static void ioapic_realize(DeviceState *dev, Error **errp)
 {
     IOAPICCommonState *s = IOAPIC_COMMON(dev);
 
-    if (s->version != 0x11 && s->version != 0x20) {
-        error_setg(errp, "IOAPIC only supports version 0x11 or 0x20 "
-                   "(default: 0x%x).", IOAPIC_VER_DEF);
-        return;
-    }
-
     memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
                           "ioapic", 0x1000);
 
@@ -476,10 +467,6 @@ static void ioapic_unrealize(DeviceState *dev)
     timer_free(s->delayed_ioapic_service_timer);
 }
 
-static const Property ioapic_properties[] = {
-    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
-};
-
 static void ioapic_class_init(ObjectClass *klass, const void *data)
 {
     IOAPICCommonClass *k = IOAPIC_COMMON_CLASS(klass);
@@ -493,7 +480,6 @@ static void ioapic_class_init(ObjectClass *klass, const void *data)
      */
     k->post_load = ioapic_update_kvm_routes;
     device_class_set_legacy_reset(dc, ioapic_reset_common);
-    device_class_set_props(dc, ioapic_properties);
 }
 
 static const TypeInfo ioapic_info = {
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index fce3486e519..8b3e2ba9384 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -83,7 +83,7 @@ static void ioapic_print_redtbl(GString *buf, IOAPICCommonState *s)
     int i;
 
     g_string_append_printf(buf, "ioapic0: ver=0x%x id=0x%02x sel=0x%02x",
-                           s->version, s->id, s->ioregsel);
+                           IOAPIC_VER_DEF, s->id, s->ioregsel);
     if (s->ioregsel) {
         g_string_append_printf(buf, " (redir[%u])\n",
                                (s->ioregsel - IOAPIC_REG_REDTBL_BASE) >> 1);
-- 
2.47.1


