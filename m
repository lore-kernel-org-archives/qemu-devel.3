Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C17E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdkB-0005xe-Va; Fri, 06 Dec 2024 14:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdkA-0005xV-Vt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:12:03 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJdk9-0001fS-6k
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:12:02 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e2880606so2074950f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733512319; x=1734117119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usuUWxdQ8ewKippAge2X3v0Dk+bE+NLkyVAycBl0ZOQ=;
 b=rxmsR1l/a4FkHH7rqqPFaJ55XtXrBfFk3Vv57OqjHE5U6BUP2syAZy4vVjhx/dX+TE
 w2fwLFZPp6eJn+H62wM9FvnMauDHKpf2YiiB/TWeUQNnPLNObowTE2YYw2lqRW1gwoLl
 FMyWxZ5yjH6XFZd/Fil4KE70kOBE2N9LoXyHC8cSeaVj0gk2LSjimhEoJ9d9BwZYInQt
 q0DdrA69d0PvMFmKLnF99ojm2X7YT/cj179q0MOjuaAQfQ7h7vnIMxLA9gjDMAJ1Y9eO
 AJ3aJ6Zvv6xEBsBt2u78MRGltcya6Fm8Dw5w8/rLg3kOiODtVdcCUmO3J/HRhTk6OLUD
 U8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512319; x=1734117119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usuUWxdQ8ewKippAge2X3v0Dk+bE+NLkyVAycBl0ZOQ=;
 b=EuI0aPwZrmTUWFTqJhSDom3qjpC2aOP4UQ2FGnWbhvpOn4LZJDTZdn5dhdF5ZTp3xH
 w6VfluoAh+SHMtjczk+zav2Xe2Pp6WoJvAyzlMKebLWut141Ez4sswBFwSl0gIXg2FNE
 dAcri6rXULf7Sji0AsErEMJsk11sjVpj8Fk9jCxcdzQM0eorv6zz8Fyf0X3z7P2uc+Qa
 x7rCO7qei8Y8Yvho3OH2D446A4NNJhLyiAp6YkygNAo9ElAK7Gza2o5bMslTYrkedIXm
 o7+Gkvy0YbHQb+CaJdkC4otVbvJhAlu8GaLG1Pi6VuIE88fQ8ww5c090oyrsXYfhsgaM
 R8nA==
X-Gm-Message-State: AOJu0YxME0vs9WyxKXpHvsQRhNLFIKlGvoU+vctnAfaMCr7hB0ElmOG9
 QbdwLJLQcub6TKqAUKc64SHULliGWwT9a/QcJ81eiftJ6LPlKSvucnj55NNohy7Ah1GuDDW94fj
 V6X4=
X-Gm-Gg: ASbGncsd61Hw2pJ5K5kmFC/0YWXq2YDhrgv5yK+GA5rOAEQea21VnHjlNUkRjcdD7cu
 gGwNrL3zuoT6h3RHY0MRXmctS9kK9q4iLoXfiEJe/afz9ykMbZKTRLQilwpb25lIjlAVM9fIEBt
 KXiY/Kld9pWT1kfYvp9tQxHt46MLzS3vgkqlraDGUVDqO71r7jK0je+ux/MfRg6riEanm1nAhJX
 y8ixYHifdnzerKjGlTe1sZyTdB3UXf7UFcdtlPLfig8Uc00z7f4GaD0Ya+qNkaHkgA=
X-Google-Smtp-Source: AGHT+IGLZHNP1iVokAKRip01VWw4auDu3tIDhR95tQQDmSfTUI6AuJvvISDTyS1PxmPYxeH7LzCG4A==
X-Received: by 2002:a05:6000:401e:b0:385:e4a7:df09 with SMTP id
 ffacd0b85a97d-3862b3cdcd3mr3352553f8f.44.1733512319429; 
 Fri, 06 Dec 2024 11:11:59 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219095easm5400867f8f.83.2024.12.06.11.11.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 11:11:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/timer/hpet: Hold fw_cfg state within HPET class
Date: Fri,  6 Dec 2024 20:11:24 +0100
Message-ID: <20241206191124.9195-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206191124.9195-1-philmd@linaro.org>
References: <20241206191124.9195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

We maintain one hpet_cfg[] state for all HPET instances.
Move it to a new HPET class.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/hpet.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 849cb3e669b..c5aeac860b4 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -57,7 +57,7 @@ struct hpet_fw_config
 
 #define HPET_MSI_SUPPORT        0
 
-OBJECT_DECLARE_SIMPLE_TYPE(HPETState, HPET)
+OBJECT_DECLARE_TYPE(HPETState, HPETClass, HPET)
 
 struct HPETState;
 typedef struct HPETTimer {  /* timers */
@@ -101,7 +101,11 @@ struct HPETState {
     uint8_t  hpet_id;           /* instance id */
 };
 
-static struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
+struct HPETClass {
+    SysBusDeviceClass parent_class;
+
+    struct hpet_fw_config fw_cfg;
+};
 
 static uint32_t hpet_in_legacy_mode(HPETState *s)
 {
@@ -279,6 +283,7 @@ static bool hpet_validate_num_timers(void *opaque, int version_id)
 static int hpet_post_load(void *opaque, int version_id)
 {
     HPETState *s = opaque;
+    HPETClass *hc = HPET_GET_CLASS(s);
     int i;
 
     for (i = 0; i < s->num_timers; i++) {
@@ -295,7 +300,7 @@ static int hpet_post_load(void *opaque, int version_id)
     /* Push number of timers into capability returned via HPET_ID */
     s->capability &= ~HPET_ID_NUM_TIM_MASK;
     s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
+    hc->fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
 
     /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
     s->flags &= ~(1 << HPET_MSI_SUPPORT);
@@ -660,6 +665,7 @@ static const MemoryRegionOps hpet_ram_ops = {
 static void hpet_reset(DeviceState *d)
 {
     HPETState *s = HPET(d);
+    HPETClass *hc = HPET_GET_CLASS(d);
     SysBusDevice *sbd = SYS_BUS_DEVICE(d);
     int i;
 
@@ -682,8 +688,8 @@ static void hpet_reset(DeviceState *d)
     s->hpet_counter = 0ULL;
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
-    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
+    hc->fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
+    hc->fw_cfg.hpet[s->hpet_id].address = sbd->mmio[0].addr;
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
@@ -719,23 +725,24 @@ static void hpet_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     HPETState *s = HPET(dev);
+    HPETClass *hc = HPET_GET_CLASS(dev);
     int i;
     HPETTimer *timer;
 
     if (!s->intcap) {
         warn_report("Hpet's intcap not initialized");
     }
-    if (hpet_cfg.count == UINT8_MAX) {
+    if (hc->fw_cfg.count == UINT8_MAX) {
         /* first instance */
-        hpet_cfg.count = 0;
+        hc->fw_cfg.count = 0;
     }
 
-    if (hpet_cfg.count == 8) {
+    if (hc->fw_cfg.count == 8) {
         error_setg(errp, "Only 8 instances of HPET is allowed");
         return;
     }
 
-    s->hpet_id = hpet_cfg.count++;
+    s->hpet_id = hc->fw_cfg.count++;
 
     for (i = 0; i < HPET_NUM_IRQ_ROUTES; i++) {
         sysbus_init_irq(sbd, &s->irqs[i]);
@@ -773,11 +780,14 @@ static Property hpet_device_properties[] = {
 static void hpet_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    HPETClass *hc = HPET_CLASS(klass);
 
     dc->realize = hpet_realize;
     device_class_set_legacy_reset(dc, hpet_reset);
     dc->vmsd = &vmstate_hpet;
     device_class_set_props(dc, hpet_device_properties);
+
+    hc->fw_cfg.count = UINT8_MAX;
 }
 
 static const TypeInfo hpet_device_info = {
@@ -797,7 +807,9 @@ type_init(hpet_register_types)
 
 bool hpet_add_fw_cfg_bytes(FWCfgState *fw_cfg, Error **errp)
 {
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
+    HPETClass *hc = HPET_GET_CLASS(hpet_find());
+
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hc->fw_cfg, sizeof(hc->fw_cfg));
 
     return true;
 }
-- 
2.45.2


