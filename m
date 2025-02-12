Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4E5C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKNA-0004ZJ-9d; Wed, 12 Feb 2025 16:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKN4-000408-2l
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:14 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKN1-0000Yj-U8
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:13 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so74831f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396050; x=1740000850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwHmoUxqvyoHDNzHHszg1KhqHnkiNXqZBs1FtjR02c8=;
 b=aTSccO4POZTmRx+LI2CmRyReR0hXojkvJPaIGETRxZARI9Mc2OaxfGpnfSxqLVwzyZ
 4fGPce24IAcM7w2Mfe03BVRzwsdnbZU68aZMT29xM21cxerFBhYd3whubC5qdkA22E08
 cDCjVCJU5aNJE6CGdkdSah1rHga4GhR5eM9LjQAX9JgdBlOeZDunbCaIk843FvcNFx3u
 hKSnW0DgF0PZGzXro1RgV7WrHmOHyzUg7C50HlgvpjE+5rXD7bZ1ZLPTUeCS/7P6L4Hm
 b0INrLqEEtdc3fmOcuqDkulTzmpMWzxAbW02dcPR4Gj2hqDU8q6HkDegEvAwzZiUw24s
 FldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396050; x=1740000850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwHmoUxqvyoHDNzHHszg1KhqHnkiNXqZBs1FtjR02c8=;
 b=UzbiiQKmflJPCxC5zHvQNqdWYBA0ZHWo6l6e/yoweGusHBJ6KyBu16g1on7ULGJxEX
 /MhsNqMhfuK/G28SGjiP2p4KVGlJWt8uKNZSzMvPGefBKgSQu+QoiQ5NQjiWX9nefl09
 x3V6FTLh0u3D4nU1ILFhMGJ11rpzbqeusm4LFCztHUfzEn3SkmJEQC6DsqwL2gXqoaji
 2Wvlj9sDb13zPPGwzGBDoqK80cS7fVLUOWfbkgcYdj73/aNn/GmxM4AGlvg3f+f7KXkS
 LZksvegyflK4HWPcho7Dhow8o69nP1LYgO7eo5QRjnzqw8NJqe2LMJ3dvUPpc7P5ATSZ
 bZIQ==
X-Gm-Message-State: AOJu0YwPH9y05T/kRsya5NK/GSiIAMCjbPrVqe44nDpWEqpqerv/nZJV
 PSiE4uWXPnlc2E5CARRye5xZqQ65MfSX2s1w56tvp+7zf4crFFcemu3QiUlwZoo6n9+fqgEK8eo
 NEKQ=
X-Gm-Gg: ASbGncutLw+jzuOEfOWynrrEQVxCEThmL2uJKSI+ijwj5UwwFcuiyTgNha41NRwfTJl
 M1oEzNULxofTRPNsLnCsi2HIyqBHFSIU6moyVxZX+vbCagaDg5uYsVHiI468HWnPc3KetS2WyIu
 mqm4F0fJEdatgv1PovKoSgyVy1qyZBre4IttQRyR86TNPA51/sv70mZfXd0HSmdOvtm9/Zw30XH
 TfbJITWTMlhVcL1B7qLxJIYZVR0zIyOMk9JPvCsOUJamYB3wsbuLk+PZmLECC55JMEm1nd44YS6
 s3bgJ42A/z6KB1doJGqTXgTt4Mspg2eJrZ2TB4JyaTI5ppoBpH5/4GFJy1FPaGwdVQ==
X-Google-Smtp-Source: AGHT+IGb7051VZGFw+gqy7rP2wyXbr7J1lpTvq69q8D4w15LiPmGS+Dn+qFtFw4ZncxuDKm51L/QMQ==
X-Received: by 2002:adf:e60e:0:b0:38b:f4dc:4483 with SMTP id
 ffacd0b85a97d-38dea28c1e0mr3422437f8f.29.1739396049853; 
 Wed, 12 Feb 2025 13:34:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4491sm49523f8f.7.2025.02.12.13.34.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:34:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/19] hw/virtio/virtio-pci: Constify base_type_info
Date: Wed, 12 Feb 2025 22:32:45 +0100
Message-ID: <20250212213249.45574-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
 hw/virtio/virtio-pci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9512590c936..a33d1b2cbcf 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2475,13 +2475,16 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     g_autofree char *base_name = single_generic_device
                                  ? g_strconcat(t->generic_name, "-base-type", NULL)
                                  : NULL;
-    TypeInfo base_type_info = {
+    const TypeInfo base_type_info = {
         .name          = t->base_name ?: base_name,
         .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size = t->instance_size,
         .instance_init = t->instance_init,
         .instance_finalize = t->instance_finalize,
         .class_size    = t->class_size,
+        .class_init    = t->base_name ? virtio_pci_base_class_init
+                                      : virtio_pci_generic_class_init,
+        .class_data    = t->base_name ? t : NULL,
         .abstract      = true,
         .interfaces    = t->interfaces,
     };
@@ -2499,18 +2502,14 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     assert(t->base_name || !t->non_transitional_name);
     assert(t->base_name || !t->transitional_name);
 
-    if (!t->base_name) {
-        base_type_info.class_init = virtio_pci_generic_class_init;
+    type_register_static(&base_type_info);
 
+    if (!t->base_name) {
         generic_type_info.parent = base_name;
         generic_type_info.class_init = virtio_pci_base_class_init;
         generic_type_info.class_data = t;
-    } else {
-        base_type_info.class_init = virtio_pci_base_class_init;
-        base_type_info.class_data = t;
     }
 
-    type_register_static(&base_type_info);
     if (generic_type_info.name) {
         type_register_static(&generic_type_info);
     }
-- 
2.47.1


