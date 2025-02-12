Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F42C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKN7-0004C3-3O; Wed, 12 Feb 2025 16:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMz-0003rH-NB
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:11 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMx-0000YS-Qx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43956e3863eso1887285e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396045; x=1740000845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xO6SV4w4GEb/p1wdkem/NKWYVecHNr9NrkbEfMoLTPg=;
 b=WUn6rzUwepyyYHBsIIqaamu7YHpdS3EiGlZIt6HXU/WoqcjNBO9TQnipxF6V3DMN4e
 1i/FFSvDhyxUF+bbSz1Vz6bOZrbx3tIaLm1DIy54z9ob+s2zwMptODPGKYKJmmtyiT7/
 AoNUfkLDEYCzhUW9EU6tHW8bO4bYPz/oZ84m0hwhS6oCo662hj/raD4QpRn2P59VpR12
 EC0KpnFQJy492cN9dWiT07o72HdSac6k14e1d+IiYiin/v2xz9mjXEctYMK9jITxj53L
 praqgdZODpyktK/d1wq/d0gDgc7eufsxBYftPjVsalZ54Clfavs9UDJU5bKvCPamw9jM
 aDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396045; x=1740000845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xO6SV4w4GEb/p1wdkem/NKWYVecHNr9NrkbEfMoLTPg=;
 b=Rb2aLN1hmdgY2aCtwL85Cw5J78nizCwqGkVsLrz2D3GpSd1+2PzrzzTci4xNwLcQEo
 d3tXWyx2mNqeWleG1XC2euqVGzI2nMxsnt6eUDt9D/Hd6uA0QbEGeKpmSGmHrwM4N8iX
 EcYdWRDY59NpNMb0I5D0C9jcvI0/9Hkrvue9C4cEi6dnGiAROgvfQbhQFoD6ap5aoxgY
 KOXchPMSCFkIvY2ji8uVoeBFgJdGiHmsuh9wQBy18mt84SIuoMipq9Co29isWE72S1tB
 AFWjMr+GP2qWIVguLDAv+S80D+TxhN4YzfFxmgeHuGUCk+Xv9b1p58BNt/202Fh8BbgW
 P6Qw==
X-Gm-Message-State: AOJu0YwFp9XztGOQV5m/0Fv6vCFuO4ZHo2REV9BrfX6zXf25HApllTf7
 1JYa4/Hvk5rkuRDDnLdXwwtfLQCEfldS955ORGHroMyRVDmV159AKk+xGJ7U+oultzinRLLzCkb
 mYgY=
X-Gm-Gg: ASbGncuupjvBgkDMw7nz0fI7+foT244QoA0EGz37vN0XH5w/I1N1v+tBZ8ZF5QZvvJG
 EQsIgSqcWXTXilm/d1ivg8dYb66AqDBfbgF4kDNi1Ld935wknjcMU1efRzYxCTXpg9Ek+izMFFI
 IFypH9fuQvNrRcnxTOhNjA5sdTWKvaBYU1yS5M4xmjnfSDqKzMSbmt3AxRYqaBOTJ4QSrK5HzpQ
 GHyJgM5c74QsIvoEdZS5o/18dteaT+objdeqBpHBWIzRxwzQiIWTKTCzv48rxe106u8WTpL74OF
 1PaZqmcJW2kdiAJweNjiAWVC/MnU8jM9pf/jZhf7aIOD145OaXtVKjX9+yZw+yA9NA==
X-Google-Smtp-Source: AGHT+IEgr1TDCBQZessHN5VdXt2BpdOh4fzJnnNahs9Vc+A2p86E15JT+bbNmqp1MrXvOHL51IRcGQ==
X-Received: by 2002:a05:600c:3b9a:b0:439:33dd:48ea with SMTP id
 5b1f17b1804b1-4395815f6f3mr46065155e9.2.1739396045229; 
 Wed, 12 Feb 2025 13:34:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a058930sm31109815e9.17.2025.02.12.13.34.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:34:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/19] hw/virtio/virtio-pci: Do not access
 base_type_info.name directly
Date: Wed, 12 Feb 2025 22:32:44 +0100
Message-ID: <20250212213249.45574-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
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

base_type_info.name is initialized to t->base_name,
check that directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-pci.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ad1d164421d..9512590c936 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2476,7 +2476,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
                                  ? g_strconcat(t->generic_name, "-base-type", NULL)
                                  : NULL;
     TypeInfo base_type_info = {
-        .name          = t->base_name,
+        .name          = t->base_name ?: base_name,
         .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size = t->instance_size,
         .instance_init = t->instance_init,
@@ -2487,7 +2487,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     };
     TypeInfo generic_type_info = {
         .name = t->generic_name,
-        .parent = base_type_info.name,
+        .parent = t->base_name,
         .class_init = virtio_pci_generic_class_init,
         .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
@@ -2499,8 +2499,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     assert(t->base_name || !t->non_transitional_name);
     assert(t->base_name || !t->transitional_name);
 
-    if (!base_type_info.name) {
-        base_type_info.name = base_name;
+    if (!t->base_name) {
         base_type_info.class_init = virtio_pci_generic_class_init;
 
         generic_type_info.parent = base_name;
@@ -2519,7 +2518,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     if (t->non_transitional_name) {
         const TypeInfo non_transitional_type_info = {
             .name          = t->non_transitional_name,
-            .parent        = base_type_info.name,
+            .parent        = t->base_name ?: base_name,
             .instance_init = virtio_pci_non_transitional_instance_init,
             .interfaces = (const InterfaceInfo[]) {
                 { INTERFACE_PCIE_DEVICE },
@@ -2533,7 +2532,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     if (t->transitional_name) {
         const TypeInfo transitional_type_info = {
             .name          = t->transitional_name,
-            .parent        = base_type_info.name,
+            .parent        = t->base_name ?: base_name,
             .instance_init = virtio_pci_transitional_instance_init,
             .interfaces = (const InterfaceInfo[]) {
                 /*
-- 
2.47.1


