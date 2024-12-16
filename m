Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5DCE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN294-0007Lw-Hj; Sun, 15 Dec 2024 22:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN292-0007L1-BQ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:45 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN290-00060Y-NG
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:43 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5f1dfb0b44dso790708eaf.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321101; x=1734925901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6kwxpp6H6DpWLzGbf6AeTqxyXU7uHDghdBpIzRPpVmo=;
 b=GePnLH0ip1YYxMhETcuOH4G9Cjyc3FObFV7HqaHZkGBZNayT7h8nHX8OKDIjLynGEG
 AIswKzl9zUjtCdXHafomMis2/aGwnXqfZhFVHdKTxli9nh/3JSp2SKxulgrDvIDy2op4
 M9djGWWongHUayy9FuwAsUlcyKhpjXun/tqiQzXGKnAwZUuXFz8J1CTHrLlOu4fmZSEr
 5ArID20oL+gsMsPBHfqmaQQYanxjHT5PRNNCSeS1Ovi7i7ishE4yHbpP/kI91F5AdIqa
 jGq3sOJSUUUX6k0iuNcEyxEKVi80rzfP/kRg3iX1Ns4nCFdN0lxVsU9i4v+JeCUDJ4Pu
 gfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321101; x=1734925901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kwxpp6H6DpWLzGbf6AeTqxyXU7uHDghdBpIzRPpVmo=;
 b=vJZPNKtnZ93+KTEdYCakLtgYHiBP531hD/v7cgrwAaIaOf6L8r0Dit0yZgIEU3HIsu
 xbDOSnowr4y0RG3ZXhSlh8CV3++u1vATOde0XZgV0x5E2MvvFCLeaSZlSduOECPn3qRG
 orRGnFXnkJvJDQWcD5T55SyCu96wkDyqwNMBLO6FOhWLaKT+XraVdAANXVYzOHXjC/oO
 wGQRUc9NXGkTFGp1dxjkrNz5DekWtF6p6wg1NrnfSnwJQbkYhYZfgLkaMCcgS5P+qFdt
 3oDmvqmP8oFD2DZSJUDULVKIg1nEdLWqSaKq+jgLHT8qh4a2hoKvR+CZ9RnDtewQST8N
 dwLQ==
X-Gm-Message-State: AOJu0YyDFyMoC9ohU/u+7OCBRzwuQ08GE+mTqIziyvcsx7XQVEPboWd5
 JeELfzgxnMrG86stI4Ie1pMHAujCV1YikKqfPgYd2Q3KYEOUW2dimspkBKhnxvuU3RcNVyHwvt3
 x5F9F8w3r
X-Gm-Gg: ASbGncvyM+qf6W8+lvNsCWsriGyUtPKLxBB15MtqNii7ZJqU0wfAJHJkDQfJ35KtYMU
 msCxCTC64CJ9k3Ae0by6ZpioSrd5L2lJapom/+D9WzaPaS82/5vdtksyHWWHiiXHi/1/Siz19Mx
 xvW3FQ9SvhqMYoBds7Ktn9UCr6VSVtAm91jr3D9JscGMvaMXju3An2LQ/QK1wamf79363n3D0sc
 SkhSL7lPCoJVYkdSmQqpqrI+yOX//MZIeZHzvVgGiCdb3Nkzl9HNjZwsWDLq21T9agQU+Jr9PU3
 bhNeys2J6k9XBsDkQuF4QEhX9aSvqnkJbFXrWlrKW0M=
X-Google-Smtp-Source: AGHT+IFSMgOgEo2PL6SMfZaRgfJ044zBmN1jZjwc2ZSoDID5e18a8ZD4nCzb7487YXJzDyuEIhDFeg==
X-Received: by 2002:a05:6820:1a0b:b0:5ee:ebcb:e701 with SMTP id
 006d021491bc7-5f32948e3e2mr7252869eaf.6.1734321101568; 
 Sun, 15 Dec 2024 19:51:41 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/24] hw/scsi/megasas: Use device_class_set_props_n
Date: Sun, 15 Dec 2024 21:51:00 -0600
Message-ID: <20241216035109.3486070-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

We must remove DEFINE_PROP_END_OF_LIST so the count is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/scsi/megasas.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 8323cd18e3..7f012c218b 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2459,7 +2459,6 @@ static const Property megasas_properties_gen1[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", MegasasState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("use_jbod", MegasasState, flags,
                     MEGASAS_FLAG_USE_JBOD, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const Property megasas_properties_gen2[] = {
@@ -2473,7 +2472,6 @@ static const Property megasas_properties_gen2[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", MegasasState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("use_jbod", MegasasState, flags,
                     MEGASAS_FLAG_USE_JBOD, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 typedef struct MegasasInfo {
@@ -2488,6 +2486,7 @@ typedef struct MegasasInfo {
     int osts;
     const VMStateDescription *vmsd;
     const Property *props;
+    size_t props_count;
     InterfaceInfo *interfaces;
 } MegasasInfo;
 
@@ -2504,6 +2503,7 @@ static struct MegasasInfo megasas_devices[] = {
         .osts = MFI_1078_RM | 1,
         .vmsd = &vmstate_megasas_gen1,
         .props = megasas_properties_gen1,
+        .props_count = ARRAY_SIZE(megasas_properties_gen1),
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
@@ -2520,6 +2520,7 @@ static struct MegasasInfo megasas_devices[] = {
         .osts = MFI_GEN2_RM,
         .vmsd = &vmstate_megasas_gen2,
         .props = megasas_properties_gen2,
+        .props_count = ARRAY_SIZE(megasas_properties_gen2),
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { }
@@ -2546,7 +2547,7 @@ static void megasas_class_init(ObjectClass *oc, void *data)
     e->osts = info->osts;
     e->product_name = info->product_name;
     e->product_version = info->product_version;
-    device_class_set_props(dc, info->props);
+    device_class_set_props_n(dc, info->props, info->props_count);
     device_class_set_legacy_reset(dc, megasas_scsi_reset);
     dc->vmsd = info->vmsd;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-- 
2.43.0


