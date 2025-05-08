Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E63C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Yh-0002J3-WF; Thu, 08 May 2025 09:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Yf-0002I2-TC
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:45:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1Yc-00050F-3R
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:45:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso1018854b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711900; x=1747316700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0A/U1sPooJ/zOn+77YMR3kP+UO0nbbTuEYORNZS6uE=;
 b=jLNNEGzSqFJoGW4G6SrVMZ59JgdHaOJBBsjsYWp3tIzkt8oZ1NYNxGrkwd5CK6anbG
 2YG9ioGkc4jAxqetauvY87deEW6oEiaZbqZXCN84+8cTeMV229+E5IY0pz6fG4gYnUpA
 utZ/aC/bcbvVJvYf3EuepY1hlE96IrXCJIkz4kJMHklpznEqJhb7JtyaWADIBcnNZre/
 CpwxWPqwexuyEE92IBEjcy7d1+SpzxueYeqQdbybIFIeXnZUxBbt/CdMCF5jWPC/4oqR
 yD6B/yaiG5/pfXlFgBjEhWZAAMomws5DiyXu/JzYzpQyWLwqvA8L64RRr/OSGaiFAZng
 dtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711900; x=1747316700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0A/U1sPooJ/zOn+77YMR3kP+UO0nbbTuEYORNZS6uE=;
 b=LVD1k1VMdAIHR/7I9+VRRIFZsMUlZ4bVI/DcMvLHCtg4nFssTrkKJgGc0XsI/eweOj
 Epm23g47Ik7SD8gUDFKxwyg43p0BPJq2pSFf5JgMWVI4SfMbX9aOwNmv+fImpwfZIEm/
 iZvIYxvvSUcB12x4Az+KSwk9JeXof7cSm6nMHfkZpOcAP7WrjN7VE9ORHX8hNUYdYNYy
 83BDDMthmguCIueIM8v38+shFtS/z0fidftgJ2WZQbL4U1OAGQG7dwvBEffW/FzzR1yZ
 ajF1h2SXBLJhkwctuX3pwSJUOzYeBuRjYtAHfv5q0QsH2MyEqP7Q0of0S3CZdEhL3o2E
 Zjgg==
X-Gm-Message-State: AOJu0Yxt474SMRgkd2Bi8JNbHTR5J/AER4FA8dg5aozILKVLGhbAs0Et
 EabwYN+u4qC/1xxF60T7it0pr4lXhK29nt5+keTZVUdBGe75UisV+HMu91fWfwXxHVNVQsL3At9
 ENGZVSQ==
X-Gm-Gg: ASbGncugPDvHV81xNridp4lNvJJEcv16Zi3jW/HkD7gqvMGV4ydiTtlrEFwezB2Gp3R
 54Er65OcLECcp0wmJn/UYkH7N9VGO0tbpDK6LVwaA5o7I71DadnLNO+lx3K+rTKevfThhsiiyqE
 nGzhnRUL4M2fY8TUOs2tzgwMxasMUWdv4qHt9a9XSBiYkTvqfATVKQcmOE0KD0MlelWSUNsP5z0
 cj5eSRUD9a6tbhsdy3FOAAmy9a0M3HdnskmamsTq4efHfsr8bxUuw0mw7OBPjAAGkdShdqSpbfe
 Kb0XLCBPry+UXV/bHldJqSuq7VY56JMYvz9DIeAkr2RuKNtt+8T+GFXTAktec7AfCYnG8wL9J42
 NCIgs2AabnKfYXUo=
X-Google-Smtp-Source: AGHT+IFHbTrvwax7UWwh9Y73Xs5DKNO90bnJgGgnaR0eEfKH1whXMeCWqTRwEn5UTKj7+iIdniqr0Q==
X-Received: by 2002:a05:6a00:2791:b0:730:927c:d451 with SMTP id
 d2e1a72fcca58-7409cfd813dmr10943548b3a.20.1746711900247; 
 Thu, 08 May 2025 06:45:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590a489asm13619132b3a.170.2025.05.08.06.44.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:44:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v4 24/27] hw/intc/ioapic: Remove IOAPICCommonState::version
 field
Date: Thu,  8 May 2025 15:35:47 +0200
Message-ID: <20250508133550.81391-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x435.google.com
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


