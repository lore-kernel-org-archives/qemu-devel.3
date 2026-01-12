Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65C6C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKE-0008U9-4q; Mon, 12 Jan 2026 09:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJo-0007pr-GW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:57 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJj-0001bf-70
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b87018f11e3so243032466b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229689; x=1768834489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFkaOn9dkeddhVGvavU/6xkr3hsrAucosLysslgaXmA=;
 b=AfOEoh23YVs6qWR2aBf6Ose5sIv5jjUcxgg/IiRk/IqarXsPmSpVgxCergbBZP9yDr
 d0eqNQTZx46G1DOKalOwAAKButCYL1o8TTsNqCl/4L8rNBmqPdt3U0SXCtFR5YUGuSCF
 70Qy/PkYJKAsxC1lOpNuGWIf6C5ns8w1A1aC23JEawaJdoAdF3SR2nYHVyGO9DPvn9L2
 Vhs/IxrwKcdLq2OhuQDs7OnvVA/pDuZTXcK68atYHAZbP2fBUIzAxibG0Go9pnr49ma8
 wO6w4JS5ZZtgfISOfL5my97yhDSCflOFh+2sq/3iDZ2rMi7GiqUA3IbKBe8EQs4YMjDY
 dqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229689; x=1768834489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GFkaOn9dkeddhVGvavU/6xkr3hsrAucosLysslgaXmA=;
 b=kWdBJVWOO4C17zV95Jlw/GsXWzPNTngLSZ7M5CzERwb/NHZPki/4IW/3zdAOUfzqjQ
 3/I1W/jIXOOe2ftof3N4xUV9W9erAaWJXzJffg3LaRgNUSdkX60gz+atG3pC0/9ohW5q
 zDFq7X/qLT7NDXhaVBfuJ+UdQwXKe21y0UeYEaJ57M6YzIwTBsQASx+l1zRBRfasb2An
 q2k7z0YDsMiVe9Aep79327CpO+u+RATFnPkHb54crDtOwBeV4Ttfkbl/8DdarO2fPm5A
 ItQiun/f+npDcAOjAnOH3rsIQnPV7KNh2Pq5P8POAuRgUnyF45UQB88prHMDh8Z+3k7v
 D9LQ==
X-Gm-Message-State: AOJu0YxNEBbI4A88Yi46yWG/+O8PeNVS0k2gKHpabFK9Sa9z31Sf5oHw
 QSjtEyxW3FkuMjrM2YQ6YIs4IuS4D78oDsA5m7KkvVCLP4kTrxLpnMxpbPDq66Kc
X-Gm-Gg: AY/fxX6dDbATY2iQeP9NCeU4OEfzbG9Tc4CUDhusYLqMbgzN+IBX28w2DZlsS5rnQDa
 hLzejKnrej3xN/vzkiLYDYb/iwycvc/zEKnalUrhtP5kdhuszzWvwenc7ClagSaEcI+eT6fzE0j
 G8+Brv/P3Jb9+QPdnLpfDenXSSq1NFEQkrNxZhZa0qao9G1ImaQWlU0+LagE/bofODNqOfpeAo6
 UhbyCAFTZ1MVUXfrGYqhCh1YnuD6hmDB/kTQyke18DaVa9PSrHVDSfWz/WdjRFwMw8PL+NaBXNW
 qcsQgIU8PKJi3+T869+JCqRwYwUbTy4z/nuXFjG8zmAdvUtDgwlR+AzxEAcxi5S1czu4BGn1rEq
 6fSrUbOpCGEWJgUak+frgH771RY2Cr0Zc+HmWfwm+TInSzREAIcAiLi+IT8zY2iXQFJj+vU9bgT
 R+1fA1gjfZWo0xf2dDeKUHtR6KvfhneqnuEKrIkzwfWRQlmmzDgiGnEOIAtauKxW4PYWo+xXtXa
 h3tcKlhCiE=
X-Google-Smtp-Source: AGHT+IGCum0tVd4xocmLeXxuZ3Rri5vYo8Gsw8H+xQMZt1UgOGNrgSm0BX0/t5mTEEnrAalkCGJ9pg==
X-Received: by 2002:a17:907:1b08:b0:b73:6e0d:4f6b with SMTP id
 a640c23a62f3a-b8444f4aa3fmr1796213066b.36.1768229689132; 
 Mon, 12 Jan 2026 06:54:49 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:48 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 11/14] hw/sd/sdhci: Remove endianness property
Date: Mon, 12 Jan 2026 15:54:15 +0100
Message-ID: <20260112145418.220506-12-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

The endianness property was only explicitly set in the e500 machine which
now instantiates TYPE_FSL_ESDHC_BE. The property could also not be used
meaningfully in a hypothetical, common TYPE_FSL_ESDHC device model since
sdhci_common_realize() would fail in that case or it would need to know
all MMIO implementations upfront. Remove the property in favor of dedicated
device models.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci-internal.h |  1 -
 include/hw/sd/sdhci.h  |  1 -
 hw/sd/sdhci.c          | 35 ++---------------------------------
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index f24532eed2..50fb746a17 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -307,7 +307,6 @@ extern const VMStateDescription sdhci_vmstate;
 #define SDHC_CAPAB_REG_DEFAULT 0x057834b4
 
 #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
-    DEFINE_PROP_UINT8("endianness", _state, endianness, DEVICE_LITTLE_ENDIAN), \
     DEFINE_PROP_UINT8("sd-spec-version", _state, sd_spec_version, 2), \
     DEFINE_PROP_UINT8("uhs", _state, uhs_mode, UHS_NOT_SUPPORTED), \
     DEFINE_PROP_UINT8("vendor", _state, vendor, SDHCI_VENDOR_NONE), \
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 32c52c7d0b..51551348cf 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -96,7 +96,6 @@ struct SDHCIState {
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint32_t quirks;
-    uint8_t endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
     uint8_t vendor;        /* For vendor specific functionality */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6001b71c61..eab814096d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1374,7 +1374,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
                        value >> shift, value >> shift);
 }
 
-static const MemoryRegionOps sdhci_mmio_le_ops = {
+static const MemoryRegionOps sdhci_mmio_ops = {
     .read = sdhci_read,
     .write = sdhci_write,
     .valid = {
@@ -1385,21 +1385,6 @@ static const MemoryRegionOps sdhci_mmio_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static const MemoryRegionOps sdhci_mmio_be_ops = {
-    .read = sdhci_read,
-    .write = sdhci_write,
-    .impl = {
-        .min_access_size = 4,
-        .max_access_size = 4,
-    },
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-        .unaligned = false
-    },
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 {
     ERRP_GUARD();
@@ -1430,7 +1415,7 @@ void sdhci_initfn(SDHCIState *s)
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      sdhci_data_transfer, s);
 
-    s->io_ops = &sdhci_mmio_le_ops;
+    s->io_ops = &sdhci_mmio_ops;
 }
 
 void sdhci_uninitfn(SDHCIState *s)
@@ -1446,22 +1431,6 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
     ERRP_GUARD();
 
-    switch (s->endianness) {
-    case DEVICE_LITTLE_ENDIAN:
-        /* s->io_ops is little endian by default */
-        break;
-    case DEVICE_BIG_ENDIAN:
-        if (s->io_ops != &sdhci_mmio_le_ops) {
-            error_setg(errp, "SD controller doesn't support big endianness");
-            return;
-        }
-        s->io_ops = &sdhci_mmio_be_ops;
-        break;
-    default:
-        error_setg(errp, "Incorrect endianness");
-        return;
-    }
-
     sdhci_init_readonly_registers(s, errp);
     if (*errp) {
         return;
-- 
2.52.0


