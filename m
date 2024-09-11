Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657CEEE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMF9-0004dP-41; Wed, 11 Sep 2024 08:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMF7-0004X7-3u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:14:41 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMF4-00078W-Hd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:14:40 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5365b71a6bdso6358587e87.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056875; x=1726661675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgquy8ayg0+igtRVZU2VaE9+ZLSxvBTEk0PAs5rrZzA=;
 b=uOBY/Teb7XBTmHItkoSmj03jQ+zpdy27ycqOutnMwZacq+RN8DkfiEDyx2YnNTeTTx
 3Rq5yysMWCRrDWvPwpq6Y5yARoJvMJatc6SaZkA+SSLSURUMUaSZAVgOP8ZX+K+NkLAB
 cqLPwNhuUTAo1Wrgpp7N+kTXBmqLE6IPm1d2KuJWG9i/i2pv4vnP5NUzmdO2CG6gAI59
 BDgDakgKdPtMqKbw01vUrwBAzrOvMYyY07MMaQFps38p6bJjH5F1aXChUbD3oxt11U3Y
 ZLu0MnggkiS2d5INyqGHfNSF6cSbTD7wwvMM9E5cR4d/ofd9SGoAWfByF72USnhr2wDd
 RQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056875; x=1726661675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgquy8ayg0+igtRVZU2VaE9+ZLSxvBTEk0PAs5rrZzA=;
 b=nNRg42Q2G7ex0yaPaI1U3tzbK8qxXkYpyHUG+QBgj6lZWbqMsFKgTsP4XWbpsVMTjP
 M4xAp51j/nuzVF2SCZyPhOMBc5Se/4kQIdpWmPOR0k24Q2/yUqon32KHbyMnLKje7r2U
 qR3l/+1p1Sm8uUjIP/U3P1ZrZlnJ0Xrt7wNWA/Uuf+9+2nV+iAsybbZGjZONGLmjC/1w
 OBeNaisSeT1dl919MzqFrMVn8O2CEMJVuyO2MuDYjR4CmLWZGdY4YOyGUEz5rMDDqgO2
 t60Xs/i087JDdIzfOzjnDaxahlOy+uMXcofOtPVA1dCRTicY0INUi6sinB2Cfs1NpNlt
 JVSw==
X-Gm-Message-State: AOJu0YyDnhZFQwNtlCJF4tXSc735G0tkxRC7wDXblguoZzZFClSisKkb
 7qq/rP2xaVpfxegTQcpbmp+gMky82neApIuMLA+nw8c7rkg8QJ3IjRNHEDafWNtHTJ9lFE5GnB1
 F
X-Google-Smtp-Source: AGHT+IH88y5IMaEvpHRgxGmgDT5hZObOQ+0YO+oXL9yXtau6bFvZLtQrk3lXKNGGHKKVuuFEFS9U/Q==
X-Received: by 2002:a05:6512:2215:b0:534:5453:ecda with SMTP id
 2adb3069b0e04-536587ae6c8mr11545244e87.23.1726056874706; 
 Wed, 11 Sep 2024 05:14:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72861sm605974066b.105.2024.09.11.05.14.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:14:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PULL 01/56] hw/pci-host/designware: Declare CPU QOM types using
 DEFINE_TYPES() macro
Date: Wed, 11 Sep 2024 14:13:26 +0200
Message-ID: <20240911121422.52585-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. In
particular because type array declared with such macro
are easier to review.

Remove a pointless structure declaration in "designware.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20231012121857.31873-2-philmd@linaro.org>
---
 include/hw/pci-host/designware.h |  2 --
 hw/pci-host/designware.c         | 39 ++++++++++++++------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index 908f3d946b..c484e377a8 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -31,8 +31,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIEHost, DESIGNWARE_PCIE_HOST)
 #define TYPE_DESIGNWARE_PCIE_ROOT "designware-pcie-root"
 OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERoot, DESIGNWARE_PCIE_ROOT)
 
-struct DesignwarePCIERoot;
-
 typedef struct DesignwarePCIEViewport {
     DesignwarePCIERoot *root;
 
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c25d50f1c6..c8ec5e8ba9 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -752,28 +752,23 @@ static void designware_pcie_host_init(Object *obj)
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
 
-static const TypeInfo designware_pcie_root_info = {
-    .name = TYPE_DESIGNWARE_PCIE_ROOT,
-    .parent = TYPE_PCI_BRIDGE,
-    .instance_size = sizeof(DesignwarePCIERoot),
-    .class_init = designware_pcie_root_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { }
+static const TypeInfo designware_pcie_types[] = {
+    {
+        .name           = TYPE_DESIGNWARE_PCIE_HOST,
+        .parent         = TYPE_PCI_HOST_BRIDGE,
+        .instance_size  = sizeof(DesignwarePCIEHost),
+        .instance_init  = designware_pcie_host_init,
+        .class_init     = designware_pcie_host_class_init,
+    }, {
+        .name           = TYPE_DESIGNWARE_PCIE_ROOT,
+        .parent         = TYPE_PCI_BRIDGE,
+        .instance_size  = sizeof(DesignwarePCIERoot),
+        .class_init     = designware_pcie_root_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { INTERFACE_PCIE_DEVICE },
+            { }
+        },
     },
 };
 
-static const TypeInfo designware_pcie_host_info = {
-    .name       = TYPE_DESIGNWARE_PCIE_HOST,
-    .parent     = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(DesignwarePCIEHost),
-    .instance_init = designware_pcie_host_init,
-    .class_init = designware_pcie_host_class_init,
-};
-
-static void designware_pcie_register(void)
-{
-    type_register_static(&designware_pcie_root_info);
-    type_register_static(&designware_pcie_host_info);
-}
-type_init(designware_pcie_register)
+DEFINE_TYPES(designware_pcie_types)
-- 
2.45.2


