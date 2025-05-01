Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF4C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYpQ-0004GB-6g; Thu, 01 May 2025 14:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnp-0002Tj-1s
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:35 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYnn-0008JI-9D
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:38:32 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85b41281b50so43766939f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124710; x=1746729510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wudwU0Mjh7FMfb66kwc7bqI37P6PrLMFSD6vy2kDJU=;
 b=zN1hRrga4n7cOC7r+LfFj01SA7Tq0gcFX4Owf/sUUkP/ADH77nXb5A1zxjb8YnPCmh
 wkNzKyDjvYs9nfaHB70fZ9O9D0NvSxrT2pngvMk6vBxUmXtN5ljpIl+sVmEux/XUEFWo
 wRm1MzPXRfAoYimq6hNbAyus3WP5ywDV5V+2IUbdtSf/62fbVlhaAqYC88UppgBR8BPH
 GKHfQbugjBlg0VUhqtyc8b+oFcN3tR130quohQcBEhlTUXAPt7U6iDQUjDw1iSU62UqH
 Wqe58tr41wyP6RYeGmeRsYJ5JuLd1R+6rEtBO29Sq6JhND4rea8cvcr+m0FvmoiPbtaJ
 yZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124710; x=1746729510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wudwU0Mjh7FMfb66kwc7bqI37P6PrLMFSD6vy2kDJU=;
 b=PVpOrOHad5n6x+yUECZEAQAD3q+8cnPqLQIkYatU6pEHvHDuPRPUJWBUkpvPbfVLQu
 a8WuK/gX6Zu71QdUTiVDxWlwzmEEWfS6jOr279Fd1hxva2dOnvMs4Iu6nn9Ui9lKELMd
 sCY4d0GkX4sBm4kMY+LnAshzQEbKS/Z+JSZwcIF8WXpDtgSimY5fjcewWxqqkAr5Astu
 lEyBTWdOjk2GXJ3od0ISDQ33Slzj/ISCP6yZzB2iEk6Yr0nZAveXukYOXboE0h3E1GzN
 hpNcauaXGNSx/Ic5Lkl9GtunRiUAPwxwMu/lmkzD0pCh8p/cEIihKZCDwVNsUSYRZsD1
 x50A==
X-Gm-Message-State: AOJu0Yz3s2AwWku7XhUeKWGtHJQL85PnxFzraLqpFdUjXR0wHJpwQMi8
 TEIh601c/2Q7Ek3SzD4N7tJCMt+5RRJWAY6mDvOafMtIiJ1UI/cKXb9p/TB+EZ8Ul/BGbEvF/uR
 j
X-Gm-Gg: ASbGncvVcY5E+eec1/FRFI0ZvA070eFOsRs28b94ueSYw6RJik7DfHUY7eDDO6RPyAN
 WARb5ETWE9GPqrvwN2rrU5vFw+VgHGrMNLGB7Fw32N/7xGUB/LdXgyDdzn9etlb/dqjPLfxQPdE
 Iyx7zCPqy5RlsxbQ9Ggasp2xT5wN8OIRfABrhs1onU/+/DYj9oegnEelml4WJ266h66kBrPhsEg
 vwLIVUv0r+Np8nvFcrDsJP12IoLLATJ65SOLCxJcWG3xu0In2roPswCeKM3PZ4VDHn8QT2eiMcY
 AbM6KYpENwS/xd/CNFdynSGVfvnOsLkHnc4yf2H4Pr2mk1dn8GoRDmO3T9BzOlslPJroSbgGj/F
 iDOhulxcpAn82J6HvaQJL
X-Google-Smtp-Source: AGHT+IGfc7WsuNYh2S9L4QJeB5B/x5wvmpw48oN35C7vYywPW56/D8NAFcMFU58BG1HXgdDPG5SKsg==
X-Received: by 2002:a05:6602:2748:b0:855:5e3a:e56b with SMTP id
 ca18e2360f4ac-866b466c79cmr34962939f.12.1746124709895; 
 Thu, 01 May 2025 11:38:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa43a9f1sm21350039f.35.2025.05.01.11.38.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:38:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 13/16] hw/intc/ioapic: Remove IOAPICCommonState::version
 field
Date: Thu,  1 May 2025 20:36:25 +0200
Message-ID: <20250501183628.87479-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd32.google.com
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


