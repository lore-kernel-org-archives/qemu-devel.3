Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE66CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeUO-0001Do-9w; Tue, 28 Oct 2025 03:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeTw-0000xj-Jb
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:51:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDeTr-0007SV-LF
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:51:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so42481315e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761637854; x=1762242654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9egxmHKDvuJWJJTxkhR6DcARHBOqueiUDPaa2dbAdsg=;
 b=fzchjVqUd51YSrnhPCFQCUk5ev/7yIWr1do2iWMTM+SBnWsubMLDzGSCnRVGJ5s6xx
 NRzy0NTL7u+foJ6ijv9gILRZf4mciwkLQFMpXhRffwiHxRXAc0wFRlXc7mZYjyyJpXzg
 4lWWkMQxQrEbmCcyOiFqhRGRQPkLnJA06a4IShqyR2J0/EEXEp5LycaBjTaHq/Lzk2QJ
 748FTgqOj7oLLnUuxikXqAHoTvKlqqFvKdU02ZnR36EA8LbGuvT+DEOoeq1H4dyAA/MI
 yqErhHC3U0KJUNcVSivVUIAm0SwYPBYBGN4NH+jDwRQSZ0GgQLODX7RpapQL3IRtvv8u
 uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761637854; x=1762242654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9egxmHKDvuJWJJTxkhR6DcARHBOqueiUDPaa2dbAdsg=;
 b=aaKOi8qLo489/9M1YI6QDqqSoTyFF12Bfz9ClhhPwktY83+f24ORmsxUubyzOxusuQ
 Tk6xLFmckE3b2SUmfMB21JPd3cMWsHI3kxrUMSwMkJlFvK6AN8TY1SMdy425mbDOccFI
 2R8+oxxnIul+Rznn8YIQFAQGUsUNumt1WN7pWYYba1rcmjTuO1PinQrPzgow22y4y29C
 c/qoaw7V3KiBWZYWnwaodQwq+qQs2akgljas/TExrewri9iq04HLJqqxWgnAVcv1FGxj
 7Kc8mkkamv+wwtvQsJF8EDI5CiOpe9nw5UQkdMoBW4PhbQOZcuS9GZcO6QSkPHeEne+R
 BwHA==
X-Gm-Message-State: AOJu0YzmGHBbAhdB+o+IdGBjLHwBstNw/bLlw92Z2L7a7jLD7MmSbvl+
 46BAVhtUqmN+elJL7yBTB2FgwX2U6Z+CTgpO80JdQMJigHnWObx+tR6+wTRsPtEuXsU88fp+7jD
 mWTK7s0o=
X-Gm-Gg: ASbGncu6eucHebWFkcnZgQvXCpdtqaB0Rkc68LCSgOMYBgJFskZO2PaouvnKe6gNncw
 hIcNe+xftIYqnV2KOxs1Dd8YGkGmZBwq1ootxLsi2K/3XbFoEyPUvhaewnTsfwDMc7MI7miyduM
 AMbi2JSzYm+YBqX0OKkgQu95Eh8cYUPu5UzfC5HQ2pUFkReoERXBxbH0Su6rhX4ruBTyB7/28pT
 puzCkcg/uGQ6wbxMxkIGK8055eaUdDczhH6j4aIUGN3GyLiILqDPmsdUlQ8hFy35wYR90Kv9hY9
 kw/dvHl07M55sKGHthuKpv9CoW6QGIdbRCo1KJotJ3kU4w1Ngs6+H1Phf3UBCLlQv+4l1vWMABs
 CYDDu8JQUMA7vV2KhfgDTg85Z7R5Lm02aoPgAc7sUCp5v2q0O/H1O6WXrzokgTWMtG3m5LDsuP9
 djYSop2n3NWFG8ZcsnQgGLw5sOuYnrHumiIV7sdcHiQlHP0Z3UmYnOQlQ=
X-Google-Smtp-Source: AGHT+IGKFQ3aedt7d8Gi8vst0DpNgYVFHAHsRujUo4jBUOjxKnpJQr56ihbzQTKM6HL0LJk1blps3Q==
X-Received: by 2002:a05:600c:4686:b0:471:15bb:ad7b with SMTP id
 5b1f17b1804b1-47717deeb8cmr22695215e9.6.1761637854299; 
 Tue, 28 Oct 2025 00:50:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd035e05sm179237645e9.7.2025.10.28.00.50.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 00:50:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org
Subject: [PULL 05/23] hw/pci-host/raven: Simplify creating PCI facing part
Date: Tue, 28 Oct 2025 08:48:41 +0100
Message-ID: <20251028074901.22062-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028074901.22062-1-philmd@linaro.org>
References: <20251028074901.22062-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

There is no need to init and realize the PCI facing part of the host
bridge separately as it does not expose any properties that need to be
available before realize. It can be simpilfied using pci_create_simple.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5a60e395d72e5eb4d01093434fbb645d72ac567a.1761232472.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/raven.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index eacffc86d84..c0492d14569 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -65,7 +65,6 @@ struct PRePPCIState {
     MemoryRegion bm_ram_alias;
     MemoryRegion bm_pci_memory_alias;
     AddressSpace bm_as;
-    RavenPCIState pci_dev;
 
     int contiguous_map;
 };
@@ -260,8 +259,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
                           "pci-intack", 1);
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
-    /* TODO Remove once realize propagates to child devices. */
-    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
+    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
 }
 
 static void raven_pcihost_initfn(Object *obj)
@@ -269,7 +267,6 @@ static void raven_pcihost_initfn(Object *obj)
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
     MemoryRegion *address_space_mem = get_system_memory();
-    DeviceState *pci_dev;
 
     memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
     memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
@@ -306,12 +303,6 @@ static void raven_pcihost_initfn(Object *obj)
     pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
 
     h->bus = &s->pci_bus;
-
-    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DEVICE);
-    pci_dev = DEVICE(&s->pci_dev);
-    object_property_set_int(OBJECT(&s->pci_dev), "addr", PCI_DEVFN(0, 0),
-                            NULL);
-    qdev_prop_set_bit(pci_dev, "multifunction", false);
 }
 
 static void raven_realize(PCIDevice *d, Error **errp)
-- 
2.51.0


