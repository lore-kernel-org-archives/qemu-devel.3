Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A61C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAvay-0007nu-4N; Fri, 02 May 2025 14:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvao-000798-67
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:38 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAvag-0005fr-7w
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:58:37 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso4475891a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746212308; x=1746817108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0A/U1sPooJ/zOn+77YMR3kP+UO0nbbTuEYORNZS6uE=;
 b=x5KxkQGG4OHsTeQYxdaiSMb+lGwRt/DOjlBCyzs05wKWWjKYnvMAAlaMDrjyl9/MTl
 I5Zqd/JjDQXOZXybxgl6sV1KdaUehdi5n8KyRH4YkeNHEXg49+C+DuOl+KbReiEDGMx1
 0qONppMlXJkusx8Z43eyIGeQyDuQD5+jZ8e1Xui0rxAimWZjAoAHb17F8+P8QONAK/m7
 R2N1PaaPyV8nJvEquFBM1etHO0tHDapM4IXvPocWGm8GoWshQgZho2zI6rpv3xoEojIL
 Uk+2Jwl/+sjhzw1w5/iP0ebARmHoj71n/ha6Gf7A0fk3NU27QW3EWDkY0F/YfaAqN4Ou
 VyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746212308; x=1746817108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0A/U1sPooJ/zOn+77YMR3kP+UO0nbbTuEYORNZS6uE=;
 b=OmCPNp3Vv360C3WKP7tFB4Ap4nxQ3cmGd+8QcT/EN4lr0NN0NpKcEksXbUHR1J2lLB
 bS/Ssv9M/lJd/QZkQ/E72Gt9wIID4FQTFQcqKWgDDiN8wzQiBGtG4YJoochuZIi1kY+X
 7YoDm9j6+UuiVStugelzDrGaFwGAducxDi2DMC7YxLlze3N+xt8xXx38WMex+xoA9RYV
 HWayynZ5gHfNOYR83TT484v0CE/4vqteJLx2jcMxI/RSETf7T3YuwfFQ6c9408ROxFPT
 s5VgRF438zGCr8jPMB8ARuDC4VhW6ZLAgu153QSJ99+be3fX+ekyUr5VlNoiTScS0C0K
 aIPA==
X-Gm-Message-State: AOJu0Yy9Sl232i7EMR63gaXB/XA2Y5aKaHm4OY0VEtk2gDLjkOf0W2qp
 ips4/yVagWvOJMebYfYtbBotQ6hO2FafJXYECuPgaM8lGcYejLE/HK5+qanEBSfpiRnjrMBVFxY
 U
X-Gm-Gg: ASbGncv/4C5UomfsRKQEJPmD611htwfBNj2+OA16N51y82k+PZRrCYQCP96/L9W+P+M
 NSm4+/4DDU3OIByifRv87UFSDYAXDaPGKbvU6QA83O3iI5pWvy50LLxOjbfnWNfUlKoGiUogvzM
 vfe5qinkl9pInKBNm+1k6L1DbSf6BPknVsDjT1bgaufU36B21wWSZ8mHdrfQI/v3nwH0FnCL41O
 nrxccnXyvTG4+c/Mo+EXL7uA7itPcp0PsCXHXTKbplnYMj97IyW4P4pXJegPqDQC+1jff503PMA
 wtMdNYTZc3RhsB0w1mj3VZm/ccHWJhe9hDyk7rLVBH5W6V7CgCiMF0A12j3W0VRkxlvhqRti+Uh
 ticvzOUfn+PwXl5jCKTo6xYdfl3dmKz4=
X-Google-Smtp-Source: AGHT+IFWiLSVzTmaXc0rED+0MroSCC0mr9smiOzx/BdcePCS2SUO3yIG/YNKAy8xJLBf/yCl1WjtNA==
X-Received: by 2002:a05:6402:350c:b0:5f8:504a:88d5 with SMTP id
 4fb4d7f45d1cf-5faa7f31700mr178673a12.7.1746212307893; 
 Fri, 02 May 2025 11:58:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c732bsm1620533a12.20.2025.05.02.11.58.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 11:58:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v3 16/19] hw/intc/ioapic: Remove IOAPICCommonState::version
 field
Date: Fri,  2 May 2025 20:56:48 +0200
Message-ID: <20250502185652.67370-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502185652.67370-1-philmd@linaro.org>
References: <20250502185652.67370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

For the record, this field was introduced in commit
20fd4b7b6d9 ("x86: ioapic: add support for explicit EOI"):

 >   Some old Linux kernels (upstream before v4.0), or any released RHEL
 >   kernels has problem in sending APIC EOI when IR is enabled.
 >   Meanwhile, many of them only support explicit EOI for IOAPIC, which
 >   is only introduced in IOAPIC version 0x20. This patch provide a way
 >   to boost QEMU IOAPIC to version 0x20, in order for QEMU to correctly
 >   receive EOI messages.
 >
 >   Without boosting IOAPIC version to 0x20, kernels before commit
 >   d32932d ("x86/irq: Convert IOAPIC to use hierarchical irqdomain
 >   interfaces") will have trouble enabling both IR and level-triggered
 >   interrupt devices (like e1000).
 >
 >   To upgrade IOAPIC to version 0x20, we need to specify:
 >
 >     -global ioapic.version=0x20
 >
 >   To be compatible with old systems, 0x11 will still be the default
 >   IOAPIC version. Here 0x11 and 0x20 are the only versions to be
 >   supported.
 >
 >   One thing to mention: this patch only applies to emulated IOAPIC. It
 >   does not affect kernel IOAPIC behavior.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


