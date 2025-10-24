Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F169CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNG0-0007LT-4l; Fri, 24 Oct 2025 15:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNFp-0007Ea-Ji
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:15:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNFm-0007KL-DY
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:15:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-475c696ab72so19274525e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761333307; x=1761938107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mty3IBivH6Vnk+xdMuiwBkLnhhTV1D3AWcAhgKsnzI8=;
 b=O2A9iXcCJbkisWGAjWfIBmNOC1GcrXu3C3JnF9szEq/B2T8/doAyRCzDTlPTWklH5+
 3i/+9OPdCzuhxVhOkXxQnhEQLdE7lw9XAQSzi8/KiiNgO7NoiZLh48wlVduH1FZ2BlWq
 mHH9AdH8AUgwlKe1dY12CZNJJCneMZm3+SAeh84tGyIFOVsUw5yhsb6v/bzC93CrOvqU
 WyUEPD4SgOl0VbztnAJCigmM9Uu6WxVn4hvRWGYLyR6pwTZ0QS5g1SIy16ASWgNbDz/J
 lJulh9uW0zh071HifU7D5ZMOL/UFJtqMaqWlXpEH0aa7ClBe0BlD2RNlex3xSDGW8YSl
 k8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333307; x=1761938107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mty3IBivH6Vnk+xdMuiwBkLnhhTV1D3AWcAhgKsnzI8=;
 b=PDo7FKcqXj0kEuiHysb/ZXFlqgHhxaroS/OObXv3RuvV6woQpYFVxX5+sN85cCAFRO
 yLASruPhBplKt02OtosEIbVmYry59gKwEpGCZA0zGxmUvsLN1rjSu3Dg7eMkeucg8M4N
 PTjpclCb1+WBmX1jpqa1wOEfDqLaJ7GAvQPP9PIihPe8WDWLvpNXGt51Lonkjje81JHE
 WLGMTgb0f2v/2A/7OIt6n0ZLf6dnNc5fncX4ifC8ZMzfmE3D2nxXPHuqW6cmnERdyXnu
 k1J5fWFomHrwWSt64yQsrqsinzMVzmbNDMWifWCziRCRSe09JFjgZc9QE7ee4lhLOICF
 XNVw==
X-Gm-Message-State: AOJu0YzY7+hyFDIxHvxMdQsXb8dTPo+YxK7eDYHB8+buiBge6VqPve/w
 2f8m0D0iIp3XgcBeY2A4B8xoGP9qISf7Qqr48aj7n/ry2JwNzyQ6uaV2n9tEFyBzTVmnvrkwPAX
 M1OdJ1rs=
X-Gm-Gg: ASbGncvUn9dSo4ks3m++H4aMxCVIDqD1awW65ZVgEoIa+gT+BENM7fJnoSNPdRznAMX
 Kz9obR0KChbBaOKTpP2DYaUXi3HOt9tx1/HwiUZa1ARzDxQD3gDrrXHdSebErYxK1/w82z66Wn6
 gdrSw2JiW1X2qd4GMvubTAD6NI0KnEbq9YFqBGFAm9wi1Zjclw6xkIv5TCR68UxyAYXZFngw/3N
 A0p0EBOvHzmUBJh1C24oF/UHWnWIDgLC4Y5SCcuYhtstYpnYe98FK/93KWAXRSyeQR6bbi6Tego
 6VvtlrvOak0uIQ68n3a8mx8qWpsS9bI3usiv7oXiaaSSk754IIsny3cJi+6Ug3NMqasxEJ9IOtS
 hjIXOFe+sGIl5vt/Be+1egpq1ltlaF/j5gylVVbpIuvT7oDW+v5szIkWvjHYsyGuBkFqDBuva3N
 7qtkRgguVzRR08rpT2b0gatbrbATVTJBG4oR71eHxdyYmPGEHoVg==
X-Google-Smtp-Source: AGHT+IHJPulElC4lE3QAPYJe+DLg06Uu2ObsGTptGP/SwFf6wsdthQIWa17PhJOf2v9TAr2kywqJKw==
X-Received: by 2002:a05:600c:35c3:b0:471:5bf:cd02 with SMTP id
 5b1f17b1804b1-475d2e83b91mr31895795e9.11.1761333306698; 
 Fri, 24 Oct 2025 12:15:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475caf2ef9fsm105040325e9.13.2025.10.24.12.15.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:15:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 07/27] hw/sysbus: Add sysbus_has_pio() and
 sysbus_pio_get_address()
Date: Fri, 24 Oct 2025 21:03:54 +0200
Message-ID: <20251024190416.8803-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Similarly to sysbus_has_mmio() and sysbus_mmio_get_region(),
add sysbus_has_pio() and sysbus_pio_get_address() for PIO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sysbus.h |  2 ++
 hw/core/sysbus.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 69eb62e29c8..07a307b5ca0 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -71,6 +71,7 @@ typedef void FindSysbusDeviceFunc(SysBusDevice *sbdev, void *opaque);
 
 void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory);
 MemoryRegion *sysbus_mmio_get_region(const SysBusDevice *dev, int n);
+uint32_t sysbus_pio_get_address(const SysBusDevice *dev, int n);
 void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p);
 void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target);
 void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size);
@@ -78,6 +79,7 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size);
 
 bool sysbus_has_irq(const SysBusDevice *dev, int n);
 bool sysbus_has_mmio(const SysBusDevice *dev, unsigned int n);
+bool sysbus_has_pio(const SysBusDevice *dev, unsigned int n);
 void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq);
 bool sysbus_is_irq_connected(const SysBusDevice *dev, int n);
 qemu_irq sysbus_get_connected_irq(const SysBusDevice *dev, int n);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index d33be6b2b52..1dbc345a3ef 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -206,6 +206,17 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
     }
 }
 
+bool sysbus_has_pio(const SysBusDevice *dev, unsigned int n)
+{
+    return (n < dev->num_pio);
+}
+
+uint32_t sysbus_pio_get_address(const SysBusDevice *dev, int n)
+{
+    assert(n >= 0 && n < QDEV_MAX_PIO);
+    return dev->pio[n];
+}
+
 /* The purpose of preserving this empty realize function
  * is to prevent the parent_realize field of some subclasses
  * from being set to NULL to break the normal init/realize
-- 
2.51.0


