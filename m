Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B8BC28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1sU-0006sn-Ds; Sat, 08 Mar 2025 16:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rB-0005YE-3A
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:20 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1r3-0003ur-Vp
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:15 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso384192f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469828; x=1742074628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMei/vL26mhTGl41GbDkmhJ/KXJkHCw9uJWhPvP3Z6w=;
 b=z21EBV6ywampdlYy9NWn0h8qF97tiG4m7PZ8R8IpoeDMX38WmkAJeyGtp0kH65jScE
 dEMKQX+OAIFvFOl8T77+0znMq/WqUXG/oFgmbfRpt2OC7+YZ0E+LLSZmH7IoAtouHhZl
 G9WPreYQlzBLHkooGOOIJduJ7+ZvpN2phoP+fDW2sTDKaM+Ddypk7silPClBxrdPqE4p
 fK49IgKhbOrh3egOzbnlZeWclQ9Hx5iHs5Xdf7PXre06/L/wBWLadCR6eQYPovEAf5tS
 AjlraaORfV/OGgBy0QxinZDkGo1gH6EfI89hCeknkmFyEufDCB8LIf1HBMBtHy4eCmtg
 s3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469828; x=1742074628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMei/vL26mhTGl41GbDkmhJ/KXJkHCw9uJWhPvP3Z6w=;
 b=dCKTC0tWreT8HyVpxMV3oq+s2LRj//H4PZ8Dsn3eeuSy94FQWyzU/3ui71BqJOedEm
 CtycYCL+DOKz3SCQsGV4pgEl23G1NxsOvAJmYZPRnt5rlYTZP4NjSn0iXfeMfR6o5wdv
 iv4kPegx0GYwBuxY4sJf5jRmwUDV9TfoayRM89xHRcb3a9AfphjCIDoJu1O6AZz/lyO2
 sM8Z0ycvoG8VsTqxKpx6a1pFv9s7zWa8Vt8M/C57/N9JRWjPis6OV8YRC464re4jf1+z
 Nxf6/QDhHKj26Fgg9l3eifLbvNnTiFHW1Gip5Xjb2Q1w9I1vXPLjCtWUW0K4Y3YvIlTE
 3TJQ==
X-Gm-Message-State: AOJu0YzPLMYLjkUyo6ENnae1A2AdKXfRnvhCbt1aHGDT+5Pac06YWlce
 39VZrkkGiEWIQyEA5fVDHv1VUZSuEPWks4bR2DceTPjRs75wWe6tzVTeM9gVnmEnDFygeD22NJp
 or+U=
X-Gm-Gg: ASbGncuWqQm7Vwmhlui/1X66eiSsF5rgSumMoLNB77N8vmT34gcyiDD3vDjIOgeWmtd
 u+1SgGTNND7VyLuWEEW4q7ZIcQQUB597fxYJX29HP5txFiAYtJpIi6KgEZJpXtUFbdjo5OlTsTW
 0kJDgDSE47AGx5DgL1zs4CDq4KZFEgYmrmq/g+JWXQQyPQtJqjdgfYP/u4e+mXZu9lsNBUtLNeG
 lDpiTv75bfqoOzJpmpT0LKfwpQzcwPADYk/aPdqXCKYwbCC8ubc5MvICn3wyM1WgnRTuWVOrXQt
 moDJqOh6/mDqQa5n5u6jMUu8rQ3G2RD+kZ0gqmQlsGjsQhO+/sLEluZPN7TYMAEkNhc64VBch13
 NZ2hshuAFK6v1VP6QQk4=
X-Google-Smtp-Source: AGHT+IFEvqoOhWSWS6tg30hVm2pmsUYIMiATIkgYBvjCVbw4S3/C8ES3L8pq0tg+uL4BjDPgaTHWxg==
X-Received: by 2002:a5d:6d84:0:b0:391:65c:1b05 with SMTP id
 ffacd0b85a97d-3913aef5f15mr2375513f8f.11.1741469828116; 
 Sat, 08 Mar 2025 13:37:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0195casm10040270f8f.53.2025.03.08.13.37.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 05/14] hw/sd/sdhci: Make I/O region size a class property
Date: Sat,  8 Mar 2025 22:36:31 +0100
Message-ID: <20250308213640.13138-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Be ready to have SDHC implementations to cover
a wider I/O address range.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 0616ce3aa59..2709a7a69d5 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -113,6 +113,7 @@ typedef struct SDHCIClass {
     };
 
     uint32_t quirks;
+    uint64_t iomem_size;
 } SDHCIClass;
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2b7eb11a14a..637067fef50 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1443,6 +1443,8 @@ void sdhci_uninitfn(SDHCIState *s)
 void sdhci_common_realize(SDHCIState *s, Error **errp)
 {
     ERRP_GUARD();
+    SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
+    const char *class_name = object_get_typename(OBJECT(s));
 
     switch (s->endianness) {
     case DEVICE_LITTLE_ENDIAN:
@@ -1468,8 +1470,9 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
     s->buf_maxsz = sdhci_get_fifolen(s);
     s->fifo_buffer = g_malloc0(s->buf_maxsz);
 
-    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, "sdhci",
-                          SDHC_REGISTERS_MAP_SIZE);
+    assert(sc->iomem_size >= SDHC_REGISTERS_MAP_SIZE);
+    memory_region_init_io(&s->iomem, OBJECT(s), s->io_ops, s, class_name,
+                          sc->iomem_size);
 }
 
 void sdhci_common_unrealize(SDHCIState *s)
@@ -1621,11 +1624,14 @@ static void sdhci_sysbus_unrealize(DeviceState *dev)
 static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(klass);
 
     device_class_set_props(dc, sdhci_sysbus_properties);
     dc->realize = sdhci_sysbus_realize;
     dc->unrealize = sdhci_sysbus_unrealize;
 
+    sc->iomem_size = SDHC_REGISTERS_MAP_SIZE;
+
     sdhci_common_class_init(klass, data);
 }
 
-- 
2.47.1


