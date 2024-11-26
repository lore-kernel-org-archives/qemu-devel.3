Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17576D3B985
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtgg-0007ws-TE; Tue, 26 Nov 2024 06:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtff-0004cQ-P9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfc-0002ym-VX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so48157995e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620230; x=1733225030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+ncjcv7Qm8z1k3YSKR9YOc81bQXCEn50hblae0ujWI=;
 b=mPjTnidVBAmieTlEBb3JK2OCO1rPpoTDuxdZndla7PRHQH2bsD2x6HV5LtV7Vo5T/x
 qf5pQMegmGDGMifh0OFa7xj5H2cK9pKHX3GxpGykMg7utWwOorvHjRMNHnyrxqfGrnaG
 ajDJRwJV84A+pHSGvIV3Wi82seXl3nqX0Xwmc0sBhxHrEaKageI0VR7p1gZxPTfSdJfn
 AiwY7Q6ESsiqPM+WI+K/qbmdyLDbLHNp9Bg6X+QW8APWOplHbPMAZzHFODOfekaGHShP
 B0RCJXUGjDj+XauBlYOKJkMTXWQG7SpYnx8FVBPXmrgl5OscSlp6aMWpggF7mqo4TbN8
 NEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620230; x=1733225030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5+ncjcv7Qm8z1k3YSKR9YOc81bQXCEn50hblae0ujWI=;
 b=QWldOePgPqcrnodbdoJoGshkcn7KI+2Yje2RVQWXxH3HaVY0LSxINtoQ9EmzmkJFMA
 gFGosGsJsa+Rl4/lxu5+k6jWR1hSxS/Ex825jbzUCEZpb68d1YSUxMEbl2awlBOD8I6Q
 PhXvPKkqsE86RgTil4ODCLcL9jCt7yvUdxn77wr84zFSTq4easB52dO3vopZvbFS+dkS
 tiCn5UenKrZ83j1eO21xne8O35RveXuA/KAm6daHcEuzc+MBKyh/ZQEWocHnSNr4HxOl
 lg5eVk1nHEf1QhzIlRBU5BXOtByvR9FzDWslw6CRj+hlkhPz2BdXfHWYfQzfEIRonMWN
 OGeQ==
X-Gm-Message-State: AOJu0YzfNn+g6IrYHhh/ZJhBVxzTJVHOpQh8P8ArWyGomyNB3umj6Cdl
 zVMRWEyYLGLkWgPkZq9ElYSpa/d54dKfpHOS0aXzqUGaMFe8b16GApxCSyXsz0U2peYBcMPl9l2
 l
X-Gm-Gg: ASbGnctCe5D6UPz3LlenfSmEA5ta4+WzWW2tbrjhghlyKYzWNXUF2cyRDUs8Es9Sfto
 k7kku8JB+BaTZBMo4yoM1q3y8MfcNGHH+bzOWrDK1qZmw+QFU1Aw1pm2Yr3xfZKncOrofEExsJ7
 kgEEwTHNjYzmPNAXFk6Yx/qIrlmr3nHho4ZjmjsHzYgrQcWU7uhZcavczXsmfigB4BecVYUo3Qm
 FwOWFR/MfYugTwvuGLOFy72SZXgBDnyOfV0BeDHrrN4zBaarJz19xarqgfDm8xceTu49BFc
X-Google-Smtp-Source: AGHT+IEWnMepl8291UsjGt1x7FxwGMlx+dTJpW2PPVSPZnH6RlwpFeqa5cY5lPOr9MHCyA/gXIc+0g==
X-Received: by 2002:a05:600c:3d09:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-434a711b1acmr16755115e9.17.1732620230484; 
 Tue, 26 Nov 2024 03:23:50 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a8051ddesm9540385e9.8.2024.11.26.03.23.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:23:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 11/13] hw/arm/virt: Create GPEX host bridge
 without refuse-bar-at-addr-0
Date: Tue, 26 Nov 2024 12:22:10 +0100
Message-ID: <20241126112212.64524-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

ARM virt and sbsa-ref machines set MachineClass::pci_allow_0_address
(see commit 74de8c3568 "hw/arm/virt: Allow zero address for PCI IO
space"), directly create the GPEX host bridge using the default
'false' value of the "refuse-bar-at-addr-0" property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 3 ---
 hw/arm/virt.c     | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f6cf43cf0c9..c232b933c07 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -647,8 +647,6 @@ static void create_pcie(SBSAMachineState *sms)
     int i;
 
     dev = qdev_new(TYPE_GPEX_HOST);
-    object_property_set_bool(OBJECT(dev), "refuse-bar-at-addr-0",
-                             true, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map ECAM space */
@@ -898,7 +896,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n2");
     mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = 512;
-    mc->pci_allow_0_address = true;
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 06affc3638b..f9ec3c22409 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1510,8 +1510,6 @@ static void create_pcie(VirtMachineState *vms)
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
     dev = qdev_new(TYPE_GPEX_HOST);
-    object_property_set_bool(OBJECT(dev), "refuse-bar-at-addr-0",
-                             true, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
@@ -3126,7 +3124,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #endif
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
-- 
2.45.2


