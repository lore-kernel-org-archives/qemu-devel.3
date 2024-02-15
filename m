Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4AAC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag6J-0005h6-Ka; Thu, 15 Feb 2024 13:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5R-00026E-1h
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:53 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5O-0003Dt-QI
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:52 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56399fb02b3so1545140a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020229; x=1708625029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J7vJKQXa+8iZQt74/J2PIq4S7PNQU5OOBph7QaqNT8=;
 b=L2xmsA7OzIxFYSMqiDkrrEsCWcChHteAtGCiR2/B3sDD0T3YFPmn0Z++yCAiELAEXr
 C4wl7TCHIwpiaOUjiknUK6M26nH8ax2a+Kx4+d2n94o0DbHTzfm7n8uj+qgyDTfARuxd
 9NCQPFsBRT3mqTbSm0JbcjTO1V8Y0MQW/XbMODRMKaVmAMXCy0Ua8D2jD9M3EQrK+sJl
 GaEq+HuB/8aA2sdhcgn2dFnhnNVb2hqIo3VTxJ3MJWJui37O6GbVL4Gc7llGpRwPgsYM
 5KJABNmFbmalqXLVGbUKx9QETBZY4PDuZYd4HK+yvh9Ls7r/ffIbIwKAy1qJo0LAwkM7
 IKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020229; x=1708625029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J7vJKQXa+8iZQt74/J2PIq4S7PNQU5OOBph7QaqNT8=;
 b=ZzEPnlH2HE/oPOygkcYdPl1YcCGDVWqrOLUyuqQ6YGt0LuDm1p/WN7h6vYbCfN+iFU
 tkFqN083Nkm2NP+EemIdj/0vkE+BeIBCPb0rm42ZmdZoYyEJepsKoqwYIcpzHwBZFND5
 /TKnLmW7U/B32t2xXFYDgZYi3xiITWTAKh9RkUMMLsdKXukAiU74c2q7AX1/tWzM1441
 cxOpQVuE9qxnorbsXnUIzbW3pakToRXyoO8r/5xnfXhDTW5i1+/9aRHQXiYHh8IaysWF
 3cDupYF6gB7NCaa6zCntjv5F5kHrrhGzdqNifIOeLyxl4rEk2FPf/1ZjyDJY9notJO7t
 C3iA==
X-Gm-Message-State: AOJu0YwW38IM9UxhVMBVf+vPcAsTPmn1DHkJU+MAlpGYa1EHQ/oOTIwf
 8obmzcK41Tng17OElG6eLxfV4Xq37baOQ2bwvYeZttuDQ8E1YUc3Bnvt4tROGcrpitrS9JqqBUN
 g48M=
X-Google-Smtp-Source: AGHT+IEuzZXusqj6CUZIPPdZ6ri0pDg2BwhkPW7nwbkT1kbP9ETlZG6Vidr2dVxHby6SfZinrKtb0Q==
X-Received: by 2002:a17:906:4a1a:b0:a3c:ff93:e12d with SMTP id
 w26-20020a1709064a1a00b00a3cff93e12dmr1965936eju.74.1708020229262; 
 Thu, 15 Feb 2024 10:03:49 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 vi17-20020a170907d41100b00a3d782d885dsm782424ejc.121.2024.02.15.10.03.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 53/56] hw/ide/ahci: Do not pass 'ports' argument to
 ahci_realize()
Date: Thu, 15 Feb 2024 18:57:47 +0100
Message-ID: <20240215175752.82828-54-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Explicitly set AHCIState::ports before calling ahci_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213081201.78951-8-philmd@linaro.org>
---
 hw/ide/ahci_internal.h | 2 +-
 hw/ide/ahci.c          | 9 +++++----
 hw/ide/ich.c           | 3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 4dc2805d21..4e13329bb2 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -377,7 +377,7 @@ typedef struct SDBFIS {
     uint32_t payload;
 } QEMU_PACKED SDBFIS;
 
-void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports);
+void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as);
 void ahci_init(AHCIState *s, DeviceState *qdev);
 void ahci_uninit(AHCIState *s);
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 2c3306dae4..33f7e83687 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1614,14 +1614,14 @@ void ahci_init(AHCIState *s, DeviceState *qdev)
                           "ahci-idp", 32);
 }
 
-void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, int ports)
+void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as)
 {
     qemu_irq *irqs;
     int i;
 
     s->as = as;
-    s->ports = ports;
-    s->dev = g_new0(AHCIDevice, ports);
+    assert(s->ports > 0);
+    s->dev = g_new0(AHCIDevice, s->ports);
     ahci_reg_init(s);
     irqs = qemu_allocate_irqs(ahci_irq_set, s, s->ports);
     for (i = 0; i < s->ports; i++) {
@@ -1862,7 +1862,8 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
 {
     SysbusAHCIState *s = SYSBUS_AHCI(dev);
 
-    ahci_realize(&s->ahci, dev, &address_space_memory, s->num_ports);
+    s->ahci.ports = s->num_ports;
+    ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
 static Property sysbus_ahci_properties[] = {
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index d190012a95..122fc7e0ab 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -113,7 +113,8 @@ static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
     d = ICH9_AHCI(dev);
     int ret;
 
-    ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev), 6);
+    d->ahci.ports = 6;
+    ahci_realize(&d->ahci, DEVICE(dev), pci_get_address_space(dev));
 
     pci_config_set_prog_interface(dev->config, AHCI_PROGMODE_MAJOR_REV_1);
 
-- 
2.41.0


