Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3C5FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMB8-00061n-V8; Fri, 24 Apr 2026 15:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMB7-0005w0-Va
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:27:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMB6-0001iV-5E
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:27:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso76951735e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058822; x=1777663622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A+/uEeEoevz0ROSFZ2xFn8UXd3FEwdEX8cH4Moa3juA=;
 b=EozmVlPa9wxIa/yAEG3qcrV77AsmQ8USEjynR2kZQq17plsnMayKvuhpHIq5ZGt9yU
 M5YznHEtqm1lbWLht9/MdPxmgH1QbhgP2h/OR8pHNbO8FbDpsRjItt0GQnDo8AzE7Wef
 Q/0oeKp0AdyWqjNIcNg8EkVDw4me8r8U17WzaQqLIS1jU4k15JYyUB+ID9OlQgdS+gKb
 dt7wqT6Ix7UOKYbbO4toRCHQ+R9QTy3lAv9pqFu3D7knWi57HvE1DCuWxoRodKFc1Cn+
 fdL+LyiSg36sEoYTB/zYC9cxHr+KotvMfgQT4AqdWTkDa5brWyS6PJ+Tw1hIuR+IrQgz
 Wpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058822; x=1777663622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A+/uEeEoevz0ROSFZ2xFn8UXd3FEwdEX8cH4Moa3juA=;
 b=O7KNc1XH9OG/5D2ifuWnzv2bfn0auIr4yMYs39uKjLCyf0Zku5z4xMw4xuesZtKhCH
 OgVBIzOwrVjc4MYsQMyxBdbL5D8gAUPX5a9ji2gyDu4M54jdo9kHmIFfj0BLDppsSHYp
 ns3IUnUQ/40GwGJv2K1H9Ms2sR+TiHwmvVU3ncjTlkhGKdX8nnJZUhSr6A7E18rN9rwE
 Rj5zxHNuXUJl2wduX2LxdqAg9j6saAM62uU1tmBgKC9z39NhcQ7lPNLrMzROR4u7lFxI
 o3iXyBNEV6zEz94f2E/mj1wsztbclJT3kUbMU9yQ6OUIU3SOqBHnc09dz5oQ8ULgeYWX
 msSg==
X-Gm-Message-State: AOJu0YyKxPlXQApefzFRnYt7Y0b1o6qh+7hFSmNZS1mDgH3/KyWjDYZJ
 aGFUjj8/tADxAAhngWXmyxtbS0bIxI4Xt4xIP+3YBHFYQDZfA7YIXdRQttNieGTOqAD9u8Bf5pV
 uN3utnuk=
X-Gm-Gg: AeBDietYLlv3I0jDvicxJx2gmhCcj+VDCxGd2s2elC9h6mlVLFQjXwyp5ioXEC0CGtE
 Rdyi/9LKGHMhRaZXRCMjv9FA3u2iDPv7CxQ5MRciH3nAqK5WyovESHREykv7M86q45QOdDy3CaS
 v6PMVu9xLVI0Xs86IvLoBPUbTJj6G564b+GCQGDAEqiRVnrWN/qTvTCI49w0TffM2ZUCNJadmvb
 fUHmKK7OiXa+2TzrOibzMoPjWSDtgH9oeRZ3grZl991bpDLP41oEQisJfglB4jESGorJfQF99+h
 le+A1iK/ICgwP7c9493hx6e44BrFtyZ+fyZcZF6I/WnB3SIF759P46QZTjSjJEO8tSrJeMRnM6m
 rg4qwM/Xt8NTbf5g0PgiprhfCWlQICGKtkQIpNRn9+3s2Esz5DRPqSHyLo1h4AcnkqGoskofWOB
 a4VYD+GdnVD7yCJC5Mna04xhn3iS0ZEUuVdYvogtH52Y5HQQ0dfO8k7NR6rrAneX/6/nccPWyy/
 v0QAob53lY=
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id
 5b1f17b1804b1-4890e49f7d8mr255953445e9.17.1777058822061; 
 Fri, 24 Apr 2026 12:27:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4411c9f4f03sm32096518f8f.1.2026.04.24.12.27.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:27:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 55/62] hw/usb/hcd-ehci: Introduce common properties macro
 for sysbus and pci
Date: Fri, 24 Apr 2026 21:25:43 +0200
Message-ID: <20260424192543.22614-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

EHCI properties are currently defined separately in both sysbus and
PCI implementations, leading to duplicated code for common fields
such as "maxframes".

Introduce DEFINE_EHCI_COMMON_PROPERTIES() to consolidate shared
property definitions and reuse them across both EHCISysBusState
and EHCIPCIState.

This reduces code duplication and keeps property definitions
consistent between different EHCI device variants.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260424080508.53992-8-jamin_lin@aspeedtech.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.h        | 3 +++
 hw/usb/hcd-ehci-pci.c    | 2 +-
 hw/usb/hcd-ehci-sysbus.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 4234591cb41..d038ee1e310 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -307,6 +307,9 @@ struct EHCIState {
     VMChangeStateEntry *vmstate;
 };
 
+#define DEFINE_EHCI_COMMON_PROPERTIES(_state) \
+    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)
+
 extern const VMStateDescription vmstate_ehci;
 
 void usb_ehci_init(EHCIState *s, DeviceState *dev);
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 9febcc10314..fd35d253407 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -136,7 +136,7 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, uint32_t addr,
 }
 
 static const Property ehci_pci_properties[] = {
-    DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),
+    DEFINE_EHCI_COMMON_PROPERTIES(EHCIPCIState),
 };
 
 static const VMStateDescription vmstate_ehci_pci = {
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index b31032bbf39..7f7c7f8a2f1 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -31,7 +31,7 @@ static const VMStateDescription vmstate_ehci_sysbus = {
 };
 
 static const Property ehci_sysbus_properties[] = {
-    DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),
+    DEFINE_EHCI_COMMON_PROPERTIES(EHCISysBusState),
     DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_enable,
                      false),
 };
-- 
2.53.0


