Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731B9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKN5-000422-AN; Wed, 12 Feb 2025 16:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMp-0003b7-DF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKMn-0000Xl-QF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso1234285e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396036; x=1740000836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdFpkqfd4B+rA0TtuwX6WnKMXV9HddDmN8ccU2WMJQw=;
 b=zK0+oije8isd9oOLy0H+mFcsypRoG7+ddoKPRq5M+fI/0+KRBDRT/6pkm7pEGNnVQ6
 SLe1HUSXcDIC+duJufYb7DTLBRQvjlqkt7JC1KPkvf/mkP09NbChaXbYG69NDmBclZ6i
 uPIIjH6xwGt6GMJ+5iX0icIS7aJ3JIG4QDbmaZ9xxI+OTvjF2QonDgqto8tnRG104sdQ
 RBGwnUL+O6Vlup1GiPl6Pa0izmhlQhFLG+GkDZr7RsTxykKWaY1+ybSBCSTyx/2stC1Q
 06rUQzDO9vWtF+tUjQazq8BD8NHJy+EuIPOak56XHWMv5vHFiFX/nzag5g0ysvijn9YC
 Zy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396036; x=1740000836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdFpkqfd4B+rA0TtuwX6WnKMXV9HddDmN8ccU2WMJQw=;
 b=V+L9CJYk7acXfIE2OeuqeMUhcJOkv4HAgIfroPboJhmRHOgigMDVzVdDYxD/37+RmX
 eJ7bi7Yj71toXE0TtGPbImTiPdcxNHBMnXHwEfyDlGt3YdEEB0T9uLAx7eaOjDdT3Vk9
 JCJm8H7tyvzPCltq/HWbJufUCvbR5MjtBKGc2ciUiBWOl8hLktpHlZAJ0r8nZYLqDPGv
 grayDbxUyoJD/fdvDoE6FfM6uiHEGmnxJnJlt8QCI9gG7z+1TzrA5yzQDyLZYBc0V/mL
 G8bahtntHtczxjG1m2QnY+gqdqT4tUirE6jb0T3mS2jnBTRk9kUluZDm5b0E/ONo32NB
 6S+g==
X-Gm-Message-State: AOJu0YwgyMTcVFVoJFYUlVathzZVRRjwULXvrhQI4iidSMNla5UegQgz
 se3ZMRkD5m/VwHN5ondFJFEQHvJpACpnznUvrZ+wMxvlsc+l529yOplzTVJg4OvaDzAS+OPgJEp
 RV6Y=
X-Gm-Gg: ASbGncsqVWye7UXqwmNKPt9ntkfDHr+cFHpL01Rj5T9r61HcRc6WsZowfOd1/AjTRqG
 JUokGJTHZPG701Svlmw19dxztz55Lrm8vUGKHCHhI8CA9G0NxQH5mKUbDUzX/msA37OX/oR95Ld
 VKuUl8DdbukZif4qOT/mzNWaZYBp9aOUDT2XbD7GQYx0UBH7Yb7UtknXPzCk0tdF96K5PSlwBoC
 K9KuayCUKXrmB5BSEyWxQTYex0spATeciLetMCh+Ql1o24Ut9xbyOw7uebBLfDy8PKEB3I7JodY
 Cr9swt0qOUIE01nGcX/sM4ZSMH5aFfoHRoYOrrmuPJo+HHsWz25CTJVYT8HWNHSSjQ==
X-Google-Smtp-Source: AGHT+IF4xILXPfhsfqGiPijUunnlxzjPtHU5wrtcrk7nT/RaRP1WGuO5VyqUocNnledxgA+VmlEpqw==
X-Received: by 2002:a05:600c:4fc9:b0:431:547e:81d0 with SMTP id
 5b1f17b1804b1-4395816a6bfmr62224215e9.11.1739396035785; 
 Wed, 12 Feb 2025 13:33:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a056151sm31283875e9.16.2025.02.12.13.33.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/19] hw/virtio/virtio-pci: Always allocate QOM type
 base_name
Date: Wed, 12 Feb 2025 22:32:42 +0100
Message-ID: <20250212213249.45574-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Introduce 'single_generic_device' boolean for clarity.
Allocate base_name on entry. Replace the g_free() call
by g_autofree qualifier. Use g_strconcat() instead of
g_strdup_printf().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a72f878e949..15383570c91 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2469,7 +2469,12 @@ static void virtio_pci_non_transitional_instance_init(Object *obj)
 
 void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 {
-    char *base_name = NULL;
+    /* No base type -> register a single generic device type */
+    bool single_generic_device = !t->base_name;
+    /* use intermediate %s-base-type to add generic device props */
+    g_autofree char *base_name = single_generic_device
+                                 ? g_strconcat(t->generic_name, "-base-type", NULL)
+                                 : NULL;
     TypeInfo base_type_info = {
         .name          = t->base_name,
         .parent        = t->parent ? t->parent : TYPE_VIRTIO_PCI,
@@ -2492,9 +2497,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
     };
 
     if (!base_type_info.name) {
-        /* No base type -> register a single generic device type */
-        /* use intermediate %s-base-type to add generic device props */
-        base_name = g_strdup_printf("%s-base-type", t->generic_name);
         base_type_info.name = base_name;
         base_type_info.class_init = virtio_pci_generic_class_init;
 
@@ -2544,7 +2546,6 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         };
         type_register_static(&transitional_type_info);
     }
-    g_free(base_name);
 }
 
 unsigned virtio_pci_optimal_num_queues(unsigned fixed_queues)
-- 
2.47.1


