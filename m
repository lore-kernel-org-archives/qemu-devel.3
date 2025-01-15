Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B2FC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6vH-0008BH-Vq; Wed, 15 Jan 2025 12:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6vE-0007xb-5t
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:16 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6vC-0006eH-OQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:11:15 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso50455725e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961073; x=1737565873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOweRygtApOATxyfDtRFWpTcMZz+FkF5/nAzWV1Nj4A=;
 b=Al01Wlt8FmYtUEcZiX9EUSzXmO0AibwOPydsLTxq10135Zu5iquGBA0cvYcH/fcZB2
 /vwFiqM+2h7kcQI22GOBIIoumXECjoVSLdnewW14JT7JrP/59B4WGpCfmhzppGlLrlz1
 AxsGTsdXZffgFirM56fjQvgzCZNLcC2haOtQfh90BVpzE7OFHwnHzomyZ5sTmjSuOb0X
 +qy9J1kcEfRdg1M/2/j1bCPoP8lkqvph+b3Pm8GnPgUXmpDZs1fvk10RFHzcEwRZZ/s8
 tDxd8sfJt/WKwKnt9NyntgF8aFl8uKbDhLcIuI8MsqrRIX+XOt10QAlG+U4cbSNfOtfo
 vDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961073; x=1737565873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOweRygtApOATxyfDtRFWpTcMZz+FkF5/nAzWV1Nj4A=;
 b=ME16nb+2EKRE+ADhqzoFZP1aZNscGZtfBE7w4ZO4EAOP9LAh1DWBdS+8JaKp/NkjOP
 IhlGSwUAJF1H48BwLvWTkqXVho4FN0FNpfHGQs8Dorg0smKqneLi4WKBZN6itLe/HTb2
 6sRiLX75Tj0ZDRqE2acrJMVcUPtx8eJa1zwmQoE455uyA17pzbC5LnlDOH2bQLvAv3cH
 2tVeEzUD9wwkyrT0lH9+CuWzFWyEF8cuNqBJMrfkYki2P8QlEERPdMLd8H1V6h4vb+mZ
 0xKuFmi0uSOlsg60ZnHTWBpvFhoWESVsvx49E/KTMEBaFFSGDdpYXA+PEZOR1fmiYFki
 8Fiw==
X-Gm-Message-State: AOJu0YyYUicKbahHvwfZhoQ5/aNbgxaLt1n+yGd4mAA7LuYhIBSBDUeb
 yojQsOXyDK8vEfrAAo6aHbrx/aH/H/DjzC5hpqk6cumncyIEfSNXGjpmJqLW0irs6ubHpuXYFIZ
 u2HU=
X-Gm-Gg: ASbGncsRzIY1Lkd1hERT8Js4RC0YBJH7k7NII/hTNJAMP+1AAtqXtn6ugf1QlD92fp9
 GHGwDonMH3u2MglAUgEb+IJD1ZrsKAWNRNut2IgvT52M2jR41MA4BMh9pNbWKk7K8sXo3+f/6BN
 Ei5k8WPwfm4R3ubadM3x1xJhfa8565/Pn5Wp0SO6xIPpH1W+SjwzsLWvjTH/L/8hOG1Q2DvnjNA
 mgEsOU80IF1yVbOUVxNHTyCVMCoGfqx+q881LhFVQdPipNv/gEp8/fbN3lSK4oCWTyDhI8LVjOP
 pgFDrOtS3Wc9Cqo4pe5TmDJXoe87eUp9X3QN
X-Google-Smtp-Source: AGHT+IHygtNrtl0yKo3HXkXcDAd+L/glqB1lS78FqEMnUXMC0epOBXRkJcYcQDtP6B8DJUkT4H0p4w==
X-Received: by 2002:a05:600c:3543:b0:434:f767:68ea with SMTP id
 5b1f17b1804b1-436e2677c7dmr305800585e9.5.1736961073027; 
 Wed, 15 Jan 2025 09:11:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499502sm30038845e9.4.2025.01.15.09.11.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:11:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/13] hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam
 field
Date: Wed, 15 Jan 2025 18:10:09 +0100
Message-ID: <20250115171009.19302-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The VirtMachineClass::no_highmem_ecam field was only
used by virt-2.12 machine, which got removed. Remove it
and simplify virt_instance_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b2cc012a402..9a1b0f53d21 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -119,7 +119,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool no_highmem_ecam;
     bool no_ged;   /* Machines < 4.2 have no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool no_kvm_steal_time;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a607a66a198..4de5ce3c541 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3267,7 +3267,7 @@ static void virt_instance_init(Object *obj)
     vms->highmem_compact = !vmc->no_highmem_compact;
     vms->gic_version = VIRT_GIC_VERSION_NOSEL;
 
-    vms->highmem_ecam = !vmc->no_highmem_ecam;
+    vms->highmem_ecam = true;
     vms->highmem_mmio = true;
     vms->highmem_redists = true;
 
-- 
2.47.1


