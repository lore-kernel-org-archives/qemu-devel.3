Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A06FE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLB-0002Hx-Hp; Wed, 18 Dec 2024 08:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKc-0001NA-IR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:25 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKa-0005h2-VH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:18 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb8accbde3so381525b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529396; x=1735134196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i447dtSxlHmakblbDXagLB9a51ZdgcT0s439L6Wncxo=;
 b=GLpCgRqVWDlDgig33YG/KYOL4ZJsN71m6EJBiKcmf7yXpX6gfgMqLSZoxIli7Py+LH
 O/b1bv6BEXltJpjNaBbbnm5UOHcem+3rb9lAzZL8HJQOaaavRMT75P66vf9ndiKzljAY
 rPnjBWizeaRA+csnhFH9qk8hQdYZQWjRktU2ArKLHzZammFnlHVnmhxN9I26zUbLjqzq
 OlDHoF60FYAaKtyq4GnQZH3iWagstkE7YP5AxiMImuqMnE+T4LBwVBoauu6Y4GIUcDnX
 B87SUzwYcOeprVYFwWmPE1Zq8BQQ2X/LfUmk3WHxdR7JAkUOyzrDbYvGMOM6y8r4ydBI
 qbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529396; x=1735134196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i447dtSxlHmakblbDXagLB9a51ZdgcT0s439L6Wncxo=;
 b=Kg+Jh9Pt63RouYQdMPUZ2uuWAAMhX29BgKwEzWHpMDVy3Jlxm7mFbhf2iFFY4+/VEW
 Tv5MyKVbQWxhDjyXSZrv2nBFseCJPRuxDLgOls2XTShKH7JEUicMyv30dltugaWixJwF
 7A70h9HT7Al7lsu9+44gE1h/b5myAK3IpqItKlUCve9sCLOVtSRu8GmljJeWxL6OiLPt
 aXaRiRzdocD9iyon9Eskbzlq7tWD43REPXlndhI9Ua1MM5Ab6iceM3xIdnyTu19F1mX/
 P+C4m2lWOFBBt/jnbjztE5M3+NtH1VRfbrr0BF9tV7R4qJWB51Nm6WZzhduDIr4+clGu
 UqhQ==
X-Gm-Message-State: AOJu0YwffNccq1YhxQz/FyqIu7PU9gzrp3fqtYcuD4hBwnIN9BQjfDQK
 LcqBYmcPpG9Dlv0yPCd9KbJhUiuvfhg9ZB1eMWi5H8oXGIRazzuT5LlqQA5KevA92CqNjOJphs4
 HvancH07M
X-Gm-Gg: ASbGncsbm46dBrlCRJaQGmAptu6LFASo1LBh1rt3RVFlzbP2tFTFJNyiPOWxnw8dHDi
 lwKlvWM6gDjD/sd69FXBm6sw3GtFXZDOCr5G47wqN4v0JAs89mIgEa6ni8tJzKA0WS9HfEhSULe
 WLt80dsDcu8sAu8dXHMhJqMfEndid59GZPwx9VGByj3a1V0U4ONmSe9M/DkvK6YVQYfugOcHFra
 qkhaRji1i7s4HUo6V22ezEcHnYRvp8g66SPThiTGWmEMCSxP9BoIOdoz4Rhy/iJ
X-Google-Smtp-Source: AGHT+IFgBLJJYR4hu0zn1ogaAmLoQeoG/vcw/r76W/2d4Mg1wDpq9iKen7/HYMIv//JwC6fU7WnMPA==
X-Received: by 2002:a05:6808:3c4f:b0:3e7:bd4e:5b98 with SMTP id
 5614622812f47-3ecccd8f720mr1552235b6e.0.1734529395814; 
 Wed, 18 Dec 2024 05:43:15 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 16/24] hw/arm/armsse: Use device_class_set_props_n
Date: Wed, 18 Dec 2024 07:42:43 -0600
Message-ID: <20241218134251.4724-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 hw/arm/armsse.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 1cd6b4a4b2..ffd732f806 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -72,6 +72,7 @@ struct ARMSSEInfo {
     bool has_cpu_pwrctrl;
     bool has_sse_counter;
     bool has_tcms;
+    uint8_t props_count;
     const Property *props;
     const ARMSSEDeviceInfo *devinfo;
     const bool *irq_is_common;
@@ -87,7 +88,6 @@ static const Property iotkit_properties[] = {
     DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
     DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
     DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const Property sse200_properties[] = {
@@ -104,7 +104,6 @@ static const Property sse200_properties[] = {
     DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
     DEFINE_PROP_UINT32("CPU1_MPU_NS", ARMSSE, cpu_mpu_ns[1], 8),
     DEFINE_PROP_UINT32("CPU1_MPU_S", ARMSSE, cpu_mpu_s[1], 8),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const Property sse300_properties[] = {
@@ -117,7 +116,6 @@ static const Property sse300_properties[] = {
     DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
     DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
     DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const ARMSSEDeviceInfo iotkit_devices[] = {
@@ -528,6 +526,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_sse_counter = false,
         .has_tcms = false,
         .props = iotkit_properties,
+        .props_count = ARRAY_SIZE(iotkit_properties),
         .devinfo = iotkit_devices,
         .irq_is_common = sse200_irq_is_common,
     },
@@ -549,6 +548,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_sse_counter = false,
         .has_tcms = false,
         .props = sse200_properties,
+        .props_count = ARRAY_SIZE(sse200_properties),
         .devinfo = sse200_devices,
         .irq_is_common = sse200_irq_is_common,
     },
@@ -570,6 +570,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_sse_counter = true,
         .has_tcms = true,
         .props = sse300_properties,
+        .props_count = ARRAY_SIZE(sse300_properties),
         .devinfo = sse300_devices,
         .irq_is_common = sse300_irq_is_common,
     },
@@ -1699,7 +1700,7 @@ static void armsse_class_init(ObjectClass *klass, void *data)
 
     dc->realize = armsse_realize;
     dc->vmsd = &armsse_vmstate;
-    device_class_set_props(dc, info->props);
+    device_class_set_props_n(dc, info->props, info->props_count);
     device_class_set_legacy_reset(dc, armsse_reset);
     iic->check = armsse_idau_check;
     asc->info = info;
-- 
2.43.0


