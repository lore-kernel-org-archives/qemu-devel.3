Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA49AC021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKNC-0004n6-T8; Wed, 12 Feb 2025 16:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKN8-0004R0-O5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:18 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKN6-0000Yy-Sz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dd93a4e8eso120095f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396055; x=1740000855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUmnlPPLPQjrTTXNDitdBPrUpGSeikKZ8+CtY1G8/RY=;
 b=zMpDGn59dPp+WkeBmH/xCxoGiQ4Y27K+l23PCjOaZg+09rmenRl/v3zLp6ecsO2xYc
 4yP4DxC5ylnEWURUvqNONJFd9drBbMetm+ynEkorP9BzVSQrHumWtlawRM845O5RtYm+
 DD+VViTq/5H2olmcYgjhhCd4aG0qHmZ9OPynuJ+lmkieGeR9/0bNKnaXnSkNBSQFV5ZD
 RKuEAMLAVK2ftyk9XhlN7AWsV4sZoF5dUBBWZpdiBXeXPl+c01PaENqCF95VD5I4sq0Q
 k2aYAOqndRhF4kxoSZl+cSVFxMmCTeqTRTFbHyESc6Y9UWmVl/0NhP0Y1pC15Yo9Gyxx
 eNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396055; x=1740000855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XUmnlPPLPQjrTTXNDitdBPrUpGSeikKZ8+CtY1G8/RY=;
 b=Dtm6XYufFX87jecTzN+XgjIngyjdPsGb5AmYB08JgDPL/8SOr36EkOFvFFOrjHjhP7
 hMV0/u9lVVmf0NiggG+eSF30ysiw1o6pKQwlAm9DWMKmhbo/GGm38LAqlUi6Ph5mAYLH
 ULABevQxpJjvJHwtDLFK7VjxuwVwpnXoeXsLsfbyAuuterkKJWuzInOwDih72jprFeHn
 rUeKXIZZqmaARhL7uguvb4YxXTXJvNphD37WVJVW9AQ/Pw+j1O8KzGvLEQ59mcV0ryAB
 Sdezo1EBVQ1Cr/wp/weXtL1CyKb7ddpuXPClo8mdqIe76/MydYue+pdXlSncQhcdPeE2
 HpfQ==
X-Gm-Message-State: AOJu0YxYLA03cZr71L8HVGa3Ek+XRmzXWXUJdIJ1w852cLFF/QDLjyLC
 zCxSwuEcy4UH/p+Jz58QVmMYIWQ5RfVRf7w0Os1xciVVg6ixlzzSLITggdp5R0KKdlPFHVNkR7w
 +j90=
X-Gm-Gg: ASbGncvp8t2TvjsUc9YeqOboFNuT2edrC6DtDsj7GL9Z+WEujh1A1jYcdwjzeRgGiIc
 zP9OTp+hMTM2mLJ1MuBUqqeKH+3q5CsnerSoklEqAdawFwRocMVTIxPJfLt5rzDF+ctHu2+8LN0
 d2QFVqo1yyhQrhgEF3RHTBEoNWhGr+eBSlVXxxck3+czBOwEGgur809Zgx46shCyi6+ckKoPB8w
 9HP+1Q842oPsvbSGsWpSi+XtfDp+D70Gau/qG2N6jT0drE6dkxT2g/uDPoqSQPeb0RHwi4EGVhO
 twNdtYbpoEwPcwlbmzLNLjDA5KyU1dNzIZGlkJj2yzZJDmMtarSNwaIUAAUWe9NjLw==
X-Google-Smtp-Source: AGHT+IE1eVloI516Vo1RTBENLFd+naT4Rg4ZF0SLKA1fu9aX2v46qN48qGbY4Qycye0914rN9CkERA==
X-Received: by 2002:a05:6000:18a6:b0:38d:d299:7097 with SMTP id
 ffacd0b85a97d-38f244da177mr899339f8f.5.1739396055077; 
 Wed, 12 Feb 2025 13:34:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8115sm14785f8f.92.2025.02.12.13.34.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:34:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/19] hw/virtio/virtio-pci: Constify generic_type_info
Date: Wed, 12 Feb 2025 22:32:46 +0100
Message-ID: <20250212213249.45574-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-pci.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a33d1b2cbcf..6f0e1772669 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2488,10 +2488,12 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .abstract      = true,
         .interfaces    = t->interfaces,
     };
-    TypeInfo generic_type_info = {
+    const TypeInfo generic_type_info = {
         .name = t->generic_name,
-        .parent = t->base_name,
-        .class_init = virtio_pci_generic_class_init,
+        .parent = t->base_name ?: base_name,
+        .class_init = t->base_name ? virtio_pci_generic_class_init
+                                   : virtio_pci_base_class_init,
+        .class_data = t->base_name ? NULL : t,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2504,13 +2506,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 
     type_register_static(&base_type_info);
 
-    if (!t->base_name) {
-        generic_type_info.parent = base_name;
-        generic_type_info.class_init = virtio_pci_base_class_init;
-        generic_type_info.class_data = t;
-    }
-
-    if (generic_type_info.name) {
+    if (t->generic_name) {
         type_register_static(&generic_type_info);
     }
 
-- 
2.47.1


