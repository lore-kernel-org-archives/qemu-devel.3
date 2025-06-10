Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E85C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXF-0006Zh-03; Tue, 10 Jun 2025 08:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyX8-0006YQ-R1
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyX5-0002Z8-43
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:56:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so4442388f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560209; x=1750165009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYWOMe7KOZYqH5WTkINgsrklm0G/7PrDwav/PmZ5N5o=;
 b=mGF1KB+X14vYj+bUE2xesW4InYkk1PopxIZ0aD5KJr1JIBAMaoXEwQFvK8sc+bY0CU
 7kt6MqHaZ7EP26iDS1pkgq2wzR8sNwxPaDRLT27Y3P/EbdNTXIqsBALdOHOlzmvGnpro
 SOlBviJLvZo/dpZW78Fwzn/vuYnRJ+/1wCd33gXgU4oEjCRkYEBlJFZ3d7d8kT6oGIrW
 0JjHufDaHPbqim4cNoSe8TamqmpESoBTNmnEfRSR89OeBvWcYbrmmPnCo8vD40krZpGP
 NjSVw29aDPhDQeRGwnneksSyKRgd6QoIKagwVt8teWUV/Qqx/0ZWtiFCAdLxoV2P7iG7
 lCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560209; x=1750165009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYWOMe7KOZYqH5WTkINgsrklm0G/7PrDwav/PmZ5N5o=;
 b=JCxRURJ6stazjHWPIIgKl/ffhzpBgAU5p6xn46Wwb5gZ3Ed/qcssfxwuszHKiMKYkz
 626cjhOYoBGdzALXaOo+wnOsWsGEijz/MznVm1XtP2yogWNZ22IHfZQDj2Dee/4DjJQn
 G3YEC3HOeVaT2K8J8swT/kElI25ocImYc5ySwlYv/N/cYWVU/MYvriyT/2JWhyoHAdLg
 kVx3pUvUDDj+MHrooOY1cugUYG8rNDcJNyTrXsINkXssByimOlH9ujAfA71Xfl2DNIut
 ChDPOwWbwrjL+WMflbg0TSoxQTy0Tz1zWglunRU2sQ6EKAiQu/94UA4EuDtirwaSC0Uj
 gdNw==
X-Gm-Message-State: AOJu0YyZIfIsIMH4qsze4NO0aHnlYGkr3LVN7ntCMJQZ0UmvoJzW1NF7
 58+a+CuFVD0wSlP/lK6nDCAgnnM37qM7AYTF+qlUS8pqPN9ko43vq6PLwIyL21B2puvkbkVl+nb
 jfGLDnT8=
X-Gm-Gg: ASbGnct0ZVvBhBF2n1WBgX+zeUJYHjjyB410fyTbqXFYlywtfW4dDTLk3CSg/qsany5
 QbhhEm0uMXE+DVfL9l/iHYYKZVeq+4Uv/tXt/uYDaIUCtAU2nfvm2gynTLSeTM950ZeLyllW3fy
 TvTx0S2NUaer03kqqcko2Yf4CJiF7Oiuaa5fYGfMnLABGpq94jYk2heIfv2CkTop1D2eJuG7zlC
 YI6MLTugw8/8/CLEGNu+pBViOwuIFFQXksii65L7y3+kh0UvD7tn6bF8Wns9wKKZxtJlxZkcL2C
 JQE2DuWrbrHpI2iLbSLFCcjOqWvTE27nKkCCog+GDBzrKH7M9t6FLMWO13yTIzBhlrXwVqhnb8t
 vjf4LtdMt3a1R4DIE78st1XsEsFiKSztLnzHbxpGzvA==
X-Google-Smtp-Source: AGHT+IEgf6of4EgJUYnT1rI2k6XmYt7cRtgY7eqQA/xRiHMLNjEdtFvdPjqWsaQ71VFfWdy0S57r1A==
X-Received: by 2002:a5d:564d:0:b0:3a5:39e9:7997 with SMTP id
 ffacd0b85a97d-3a539e979e5mr8554336f8f.34.1749560208877; 
 Tue, 10 Jun 2025 05:56:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532435f95sm7698854f8f.60.2025.06.10.05.56.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:56:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/24] hw/pci-host/raven: Remove is-legacy-prep property
Date: Tue, 10 Jun 2025 14:56:12 +0200
Message-ID: <20250610125633.24411-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This was a workaround for the prep machine that was removed 5 years
ago so this is no longer needed.

Fixes: b2ce76a073 (hw/ppc/prep: Remove the deprecated "prep" machine        and the OpenHackware BIOS)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <0d41c18a8831bd4c8b0948eda3ef8f60f5a311f3.1746374076.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 21f7ca65e06..b78a8f32d32 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -75,7 +75,6 @@ struct PRePPCIState {
     RavenPCIState pci_dev;
 
     int contiguous_map;
-    bool is_legacy_prep;
 };
 
 #define BIOS_SIZE (1 * MiB)
@@ -243,22 +242,18 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     MemoryRegion *address_space_mem = get_system_memory();
     int i;
 
-    if (s->is_legacy_prep) {
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            sysbus_init_irq(dev, &s->pci_irqs[i]);
-        }
-    } else {
-        /* According to PReP specification section 6.1.6 "System Interrupt
-         * Assignments", all PCI interrupts are routed via IRQ 15 */
-        s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
-        object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
-                                &error_fatal);
-        qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
-        sysbus_init_irq(dev, &s->or_irq->out_irq);
+    /*
+     * According to PReP specification section 6.1.6 "System Interrupt
+     * Assignments", all PCI interrupts are routed via IRQ 15
+     */
+    s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
+    object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
+                            &error_fatal);
+    qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
+    sysbus_init_irq(dev, &s->or_irq->out_irq);
 
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
-        }
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
     }
 
     qdev_init_gpio_in(d, raven_change_gpio, 1);
@@ -426,9 +421,6 @@ static const Property raven_pcihost_properties[] = {
     DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
                        EM_NONE),
     DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
-    /* Temporary workaround until legacy prep machine is removed */
-    DEFINE_PROP_BOOL("is-legacy-prep", PREPPCIState, is_legacy_prep,
-                     false),
 };
 
 static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
-- 
2.49.0


