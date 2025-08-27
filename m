Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6A2CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 22:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urOD2-0006fz-FH; Wed, 27 Aug 2025 18:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1urOCz-0006f2-Hx
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:33 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1urOCw-0007eB-Sp
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b4d8921f2so2339595e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756332089; x=1756936889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYDCRX59FanNn5HNp7EQuX7HSdi+9rNxfs8qelh7zGc=;
 b=RClTksj5Di1aFYsIBSdFQxSBTAa5vLJ6GTJY7+d7BdcHJfEJXV90TAmrzA/OBIVvm0
 OTzYP/zd26fvJjhI3Z61fHjIsPuhqT3DJ9w9COD6ADRN/j7M51/g39pQTFCJUw8cU6ai
 GYBU/B+cHh4h2HEhxDCcCAmlPrfHhazGWMNojVSmT8H2oDgn4Xdh0+aQWVKrmdJK0YA8
 /1IcgvNybau6aCJp+5hrY21z1lyThW9sMQ8uB+jTQGZRWDpJ0W8K56C2YuC8eMVq98Gd
 dtQkcvVGeo54HAtvj9gSEusmaAaR5mG9+zmws5cHeEc7RTZU1tRIDJ7eBxLo1aZYcXUv
 tysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756332089; x=1756936889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYDCRX59FanNn5HNp7EQuX7HSdi+9rNxfs8qelh7zGc=;
 b=GxHUJeyeD5Xb3DNodth4qccHEIxSKKddNWhE8bREyiLxpm1i/MQSZI0k4W8SUOk3u7
 83qBZrUbrrjIRis1Y51OTQbGZt9Do6KfGj159/a8NjxU6S8MAEl2WxrN6O61ScXa9Uha
 IsRX4z36v/9hR/3M/BxvO90SgLxuaGuGOxQX8xamtxGCOGY2zcX1wSzJ+gfr7dHZ55Tq
 0kiyE8yYqE/JEp/tC60ph/kiTduYIVR9D4FUUuLGYSmKG9GUUjA37WFcuYz/i6hVkKyN
 hrTZjU9V6SvrBZG5Ekztq8dn+rL2UJagnJetUrowTQ8xr/XwR2DSzfFtgSVOEf9PPXSn
 8Mnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdcW0VfYOXem7xaefCTSFEofPeVDBQpvT5jw4pUwE0H7HQSBN5uWu5Ov6M69IoSCr+vwJqTKSWJDGj@nongnu.org
X-Gm-Message-State: AOJu0Yy+flhHCA0I2sprYAJwG4m2+Z5iy02rNxMXVH4jNrOwCkvu8CNl
 QNP/dAMvXxOMdZSV3sqkBybDJFYdk4HB5878e0kf1sTl1QTTiuTldneJyXoS17fs
X-Gm-Gg: ASbGncsRitTKKeqQ/OrVreCDvtMrPChKKX1OlUetdtTEgRZC+ajjcpvpHxHh2M5b/6H
 hJhDmYIvI403KQNJfbJjb6Gic/P3VR4Se7QBYibbs/WohMSlpA/AAig3mTzrI2h2RsKpJLmXjsD
 dIntXJv+mHoOV7OtLj3DEfHi6E7tjTJ66aBHiy88ZwygSJgfnu5Xn0fbXeaf6rHBLvOYrxxB/KU
 887kNO8PR8kDYysIguoKpSok+PrPhcrBZqv/czC6folb7kxs7fw1DB9ML+ISas5r8vjLH7SdOcF
 GTOUSQpSI3t9KFdQUev8Lf85q8cwJoTIBX3pwvSseDiiOs5Rb8jSUlgFkvCdbVlYRxuetL4B68l
 lnI2aMagW34gz9R0bTDNE9wvRuyb8JmnbIuIS3MMgG4tPcf71E1/njus/9fbswDsQJzWdGUrJki
 z6Qv3MIaAgvQ==
X-Google-Smtp-Source: AGHT+IEDVo47DbeBWfQC+qCr0SIZsS/rbEQO8X1f/71St4548tp5XGzMg04Y490MKDvzWbeN52w0ig==
X-Received: by 2002:a05:600c:a46:b0:456:1bca:7faf with SMTP id
 5b1f17b1804b1-45b517ad840mr251749995e9.16.1756332089058; 
 Wed, 27 Aug 2025 15:01:29 -0700 (PDT)
Received: from localhost.localdomain (46-116-237-160.bb.netvision.net.il.
 [46.116.237.160]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b797ce2b8sm4116755e9.12.2025.08.27.15.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 15:01:28 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] hw/acpi: Support extended GPE handling for additional
 ACPI devices
Date: Thu, 28 Aug 2025 01:00:47 +0300
Message-ID: <20250827220054.37268-2-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827220054.37268-1-lb.workbox@gmail.com>
References: <20250827220054.37268-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch extends the GPE (General Purpose Event) handling to support
the maximum number of interrupts available based on the machine's GPE
register length, rather than being limited to the first 8 bits.

This change is needed to support additional ACPI devices that will be
introduced in subsequent patches (Battery, AC adapter, and button devices).
These new devices require GPE event bits beyond the first 8, which were
previously not being properly handled by the event sending and SCI
(System Control Interrupt) update mechanisms.

The actual number of available GPE interrupts varies by machine type:
- PIIX4: GPE_LEN = 4 (32 bits total across status and enable registers)
- ICH9: ICH9_PMIO_GPE0_LEN = 16 (128 bits total)

The patch modifies:
- acpi_send_gpe_event(): Now properly propagates status bits across all
  available GPE registers based on the machine's gpe.len value
- acpi_update_sci(): Checks all GPE registers for pending interrupts,
  not just the first byte

Note: A future enhancement could refactor the GPE handling to use the
bitmap API from bitops.h instead of the current manual bit manipulation,
which would provide a cleaner interface for these operations.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 hw/acpi/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 58f8964e13..3240ec185e 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -729,19 +729,32 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
                          AcpiEventStatusBits status)
 {
-    ar->gpe.sts[0] |= status;
+    int i;
+    AcpiEventStatusBits st = status;
+
+    for (i = 0; i < ar->gpe.len / 2; i++) {
+        ar->gpe.sts[i] |= st;
+        st >>= TYPE_WIDTH(ar->gpe.sts[0]);
+    }
+
     acpi_update_sci(ar, irq);
 }
 
 void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
 {
     int sci_level, pm1a_sts;
+    bool gpe_sci = false;
+    int i;
 
     pm1a_sts = acpi_pm1_evt_get_sts(regs);
 
+    for (i = 0; i < regs->gpe.len / 2; i++) {
+        gpe_sci = gpe_sci || !!(regs->gpe.sts[i] & regs->gpe.en[i]);
+    }
+
     sci_level = ((pm1a_sts &
                   regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) != 0) ||
-                ((regs->gpe.sts[0] & regs->gpe.en[0]) != 0);
+                gpe_sci;
 
     qemu_set_irq(irq, sci_level);
 
-- 
2.51.0


