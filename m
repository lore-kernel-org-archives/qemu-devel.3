Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7886E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN295-0007MZ-MN; Sun, 15 Dec 2024 22:51:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN293-0007Lc-Hu
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:45 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN291-00060i-QV
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:45 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5f2dee7d218so1601261eaf.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321103; x=1734925903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i447dtSxlHmakblbDXagLB9a51ZdgcT0s439L6Wncxo=;
 b=RXJDlEinePf/KsJBsKlFJcR6VvQe5w3oP2SBlSD7hQCLLzjPR+oU31Jfv7bzpl0/IT
 CGujFVwlMod4dbfttGp593Tlhh+PiYgM9TPYAZQ5JRnSrPmT/D+q8YP63d7NrfAO7LbE
 jRCtTMx7/ZjE4oTQzr1s0Xq5pEcop2+Pa1Co9grkNThrjd19Z4jKv7H1Q+GD03Dz2bvE
 E9J/fNmZMrYy4SDM/jj+IemTBdR1lPVFHtHmY3Y9qVdTaDy935CjgE8EDsxxpvbeku+S
 QrcCssnLKfi36S7/NMQtsun+VHyAEJXLuweFsbwSwX8tUXezFtCVme/0tK5voCE3LydE
 Thjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321103; x=1734925903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i447dtSxlHmakblbDXagLB9a51ZdgcT0s439L6Wncxo=;
 b=kKT6BL2ING2kwFoSp7JarfO8jIjIvUfaXn2Xs5qrguZHdBYSzL7gBpRsYz/VyBGmOt
 KqMtaSP0DeqKWAD8xyfSJP3HyxcDONkAiAa2muqHXzyimtI9FyCtkdmXXfAduBss3oim
 xL6xAAuI9ZE1eyQuA4OJm49bSrF+y1j8yK8PacXAwyGFVDq03GsA6bJJyzXnMiGX07L3
 pRFBxYM5v2TBI+yIMygFnjpsG+aPZzGOjR4f0D2RwjW2HxHN5Gj/V6BiRVZfAM32LyzK
 dB8GvtCR+kGqwqxB2sbMi3iXP4X/iNIaUGufl58of+wp7gDZJXnMw/ENa4tjm8/VV/M7
 NSkA==
X-Gm-Message-State: AOJu0YzXZvTnayqsu+DquSHkgoJwY36djnSBMDrT99+EDmQOWAvxcyJ3
 /632htyTwKlxWhcwOm1igAR+hPvM59Ug6h6WWXihyuutmqftAmnAqXlHYEhZ4NfrzQGqAmp5a9g
 PRRcA6CdY
X-Gm-Gg: ASbGncuT8rKyvl6KfPrldGLsYfw1/44KV4BfoAFAfM5YAS3mJ4EgZdrgKnJpeVUiKpi
 WmWmzbwUcsz5OQhV5pxDo8FCvlza3xfNNdrTS4KFIz3zI7b0fi20G/DVoIr7GzoZxp6ZjUMr12v
 v72sMSSg9zyMfueQd60pshqMiMIhyaNfPjo0QKcbfYHirri/K13kh4wMuOmLE3WY6wwcivfqey1
 R+9nMNeOgMalsZk3krUqyap5i2BtEsdBj/zIcnUuokEKbOFj+KlwAkzuiWtZMCtrc9h+RibDULj
 YXZWpkhxKoeIVpRC8jE6oIIZ3a3aNF66IbUA1E2XYRM=
X-Google-Smtp-Source: AGHT+IGIIrUSe5gRvsknmfNzMOWx0YHa5jof7EJCqwMnl9/BDSzqomzwQdggOYy54iSFPYp1KDA3lQ==
X-Received: by 2002:a05:6870:b07:b0:29e:37bb:c0e0 with SMTP id
 586e51a60fabf-2a3ac6b9185mr5902576fac.23.1734321102636; 
 Sun, 15 Dec 2024 19:51:42 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/24] hw/arm/armsse: Use device_class_set_props_n
Date: Sun, 15 Dec 2024 21:51:01 -0600
Message-ID: <20241216035109.3486070-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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


