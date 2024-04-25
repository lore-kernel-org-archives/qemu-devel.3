Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBA0C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwto-0000mc-AB; Thu, 25 Apr 2024 07:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsH-00085j-VR
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsF-0008IR-Lx
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:44 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-347c197a464so622174f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042960; x=1714647760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYhjl1/jGiesNQD68pOCk3VBrraJnT7fa7wrXc4FOT0=;
 b=sS9SNaY2m91SB2OuGxhRGe3Zi640dzqYr+7FM0qXPCca7ZjDwL/7jLEsJbRCeN/MHm
 zN1X0yKopOlZPSXZfLa3wjPoTrNBk8SINFYZR/C+049d1tuYW2c5L/Z0ui3IzYdHEbCm
 /hGKBzdn4K+uv4/MTZmHgpTgouyIjQAPlGqBs9O3RxD+gWzDjxjtPcu5D6Z2TY448kok
 03cz9qZGWePMuofu9qcMXjLqfWrk9NMXwUz9movYjDmH9UMh8GuXIE2hefebeWK66uU5
 hz7r/e/mwMwK/3nsJn/wKPm7RR9wIF+FSudPsR3mApq9xr3ehinTIGtLyNoPY+loV+th
 7tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042960; x=1714647760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYhjl1/jGiesNQD68pOCk3VBrraJnT7fa7wrXc4FOT0=;
 b=HCwH0z+oJkeau3d32PtsS498LrzpTPZaUSJM17Q+Hul9/Wbd8LKd6B48glQs+Uu6h0
 mGvHMbJm/exttrKeQUJJAXv4Kd45HQSr05mQmQscw6U50M9WYYMqfmF82NsK6IHhK5C+
 4/BFbim4oS+OT9VII5nBc/4OjcbX9p9fH0pQsL1q4Baw7xPfZH8A0Pb+1MznyXYPlBjN
 B3C1721xS9telADV/bE6OkkHPseVevYBat1Yak1ECfNBmC0XSTBHQz2RllzPn5ljwmAm
 sfudfklqfGxbjy3fMIweN7LRfPw0sklo8mdoauy8My8WkCNqVfCjaei/Wnbp2bDXKdr3
 1nXw==
X-Gm-Message-State: AOJu0YwfWueNHvrTL7ezpyG+HxKeKLyvolUjR9bMiZAo8/im+ThOXES1
 QkAwcsjSHO5CKoUer3jkhzm8ciIB6NLfqfL0nD/dp8OWBSbWHXN53NTpGSNWgUurP+0OpI3qgUm
 P
X-Google-Smtp-Source: AGHT+IE+z8VLtpiVcsEDriTtA4dS6T5UEXA3GkhSwRz42pIaS0iByWzozD1pu3D1/ycppsU1VPSF5A==
X-Received: by 2002:a05:6000:47:b0:33d:b376:8a07 with SMTP id
 k7-20020a056000004700b0033db3768a07mr3496522wrx.8.1714042960487; 
 Thu, 25 Apr 2024 04:02:40 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a5d4ad2000000b0034a0d3c0715sm19281014wrs.50.2024.04.25.04.02.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/22] hw/misc/applesmc: Simplify DeviceReset handler
Date: Thu, 25 Apr 2024 13:01:40 +0200
Message-ID: <20240425110157.20328-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Have applesmc_find_key() return a const pointer.
Since the returned buffers are not modified in
applesmc_io_data_write(), it is pointless to
delete and re-add the keys in the DeviceReset
handler. Add them once in DeviceRealize, and
discard them in the DeviceUnrealize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240410180819.92332-1-philmd@linaro.org>
---
 hw/misc/applesmc.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 14e3ef667d..59a4899312 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -145,7 +145,7 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
     s->data_pos = 0;
 }
 
-static struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
+static const struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
 {
     struct AppleSMCData *d;
 
@@ -161,7 +161,7 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                                    unsigned size)
 {
     AppleSMCState *s = opaque;
-    struct AppleSMCData *d;
+    const struct AppleSMCData *d;
 
     smc_debug("DATA received: 0x%02x\n", (uint8_t)val);
     switch (s->cmd) {
@@ -269,23 +269,10 @@ static void applesmc_add_key(AppleSMCState *s, const char *key,
 static void qdev_applesmc_isa_reset(DeviceState *dev)
 {
     AppleSMCState *s = APPLE_SMC(dev);
-    struct AppleSMCData *d, *next;
 
-    /* Remove existing entries */
-    QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
-        QLIST_REMOVE(d, node);
-        g_free(d);
-    }
     s->status = 0x00;
     s->status_1e = 0x00;
     s->last_ret = 0x00;
-
-    applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
-    applesmc_add_key(s, "OSK0", 32, s->osk);
-    applesmc_add_key(s, "OSK1", 32, s->osk + 32);
-    applesmc_add_key(s, "NATJ", 1, "\0");
-    applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
 }
 
 static const MemoryRegionOps applesmc_data_io_ops = {
@@ -343,6 +330,24 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->data_def);
+    applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
+    applesmc_add_key(s, "OSK0", 32, s->osk);
+    applesmc_add_key(s, "OSK1", 32, s->osk + 32);
+    applesmc_add_key(s, "NATJ", 1, "\0");
+    applesmc_add_key(s, "MSSP", 1, "\0");
+    applesmc_add_key(s, "MSSD", 1, "\0x3");
+}
+
+static void applesmc_unrealize(DeviceState *dev)
+{
+    AppleSMCState *s = APPLE_SMC(dev);
+    struct AppleSMCData *d, *next;
+
+    /* Remove existing entries */
+    QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
+        QLIST_REMOVE(d, node);
+        g_free(d);
+    }
 }
 
 static Property applesmc_isa_properties[] = {
@@ -377,6 +382,7 @@ static void qdev_applesmc_class_init(ObjectClass *klass, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     dc->realize = applesmc_isa_realize;
+    dc->unrealize = applesmc_unrealize;
     dc->reset = qdev_applesmc_isa_reset;
     device_class_set_props(dc, applesmc_isa_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.41.0


