Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE666CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDegO-0006BH-0i; Tue, 28 Oct 2025 04:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDegL-0006A1-S3
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:03:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDegF-0000q8-Cm
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:03:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475de184058so12574705e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638624; x=1762243424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfFJAb/KcoEMKci+o785xcZsNgBjcX1J9BbfpmwSLMI=;
 b=OGoLgKdVoCaE2T3xH9wupfPbDGMJ/xnctBPlyqMa/y5KE3ZRjO17R2yQwWGaZrccvk
 kkedxlerr73yonHvcghIJQSmeqdHIUVdOkL4sZyNYASTCyChcjw5gn8lm3gQA7nvObRM
 TkkJzWmdDIRFJjEfrltjgewCliLbOI4tvplp8X11T6J8iCVerAmDxO7/IwU9ZuENAGxi
 4cxSwkPcFOzTJW7Xnm+1DStH7QFHJ9CunF5zsk1F/8fCuHMqKtmNLmK4yfIzuRSKUqgS
 g2WDwd4ctzPrhxiGS7DKICUT08J94XmNfoIkEZ1foULuUXvekmUQ9v2n2xQlMkAgNfp0
 TnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638624; x=1762243424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfFJAb/KcoEMKci+o785xcZsNgBjcX1J9BbfpmwSLMI=;
 b=aaKaFOX1Wtu5obEPqOYlC+DBP8+tp4Rvnr/7josv4pG4KwtUzVX3HxyygVuSVp0cpv
 C8wQtkbWqHdggL86xIYQzqDzhAFQXmz7Ph/Bl8dTKt76/7WOkeaJ5wUjqlNt+96h8oto
 K05DFvEdGnwgxJDrVnJsOPtUHxmeNaExH8yd7Y7z27JGMAxq9JisjwMSSDxzPVrSytih
 HxejfskKFVQ5WjCMg4vIUaJ9SY7WR3BivaOm+Qs/hiyxqJ7vDmchRNYaYj6ccHqCNgpB
 +rj60KsGoQCWjp4h8ZAwSGXwC9bjuVX4F3HMcJpp366gp9C44gL3Yt60OsaU4iep4q/7
 AzbA==
X-Gm-Message-State: AOJu0Yx5d4pBIAMULpEfsUNF/m8ZxxogWzpXfWFz5Y/MvlqAdCucrLOJ
 E/LfgUvR8eMo4W/IKctxYCDryCcpxlTQ/yb+JqBhBmQpzkfleOF+JDqr7WNK0421D7D3r8YzeCr
 s5a1pd0E=
X-Gm-Gg: ASbGncsFInMikonxf+n56iS79RhdR0P41gyNLDFGTlJ+eVsl/RW7fsCqGs9Ynlt6igI
 60ny1BiABrm3YNxR7KDgD9Yzxk+A5EltKYX+qh6Gnf4sAwgc8RBOhbf+JGwQFH5rbArax6vbdRw
 aaCoR6JFVCo1TT8q7Q4wz+0XtfDk7QasY8YWtCOZQ2FJcsNsQ/R/qZQaC3F91pMzG37aXu64WWr
 /DBoXDKUrCgBCdHCkdYZY0SgbS0QsrSky/oSC00NuuKmTQvjipxlQbaDCgp8NMdxo38BWb/61hK
 nDzaQDOpBBOXPsklRbRH1jKfwEa96TnHWgpo7gUOJkMFrfcAFz6mnbW/jw9eDGrHQPH9c+zZgpz
 vzP6kd8n3n5xuKGv4m0Xa1cvjCyrMNV9ok8j3bZtZKwEiIGfmh1Cm6r65Xkmajozc5D8tyBbtzU
 wXwNa7I0gMV8LjmR0wQSCBKgEvVGojQqDC89WlTnJS4fDcH0J9t81Iyr4=
X-Google-Smtp-Source: AGHT+IHslOLt0A2dbjqzbLtEsNJtl3R3pIFza8TJNrv03AKv+l+uzukq9Z2XKJvp6fa0I0jvn6HcRA==
X-Received: by 2002:a05:600c:8b83:b0:475:daa7:ec60 with SMTP id
 5b1f17b1804b1-47717e522ecmr18646975e9.21.1761638623972; 
 Tue, 28 Oct 2025 01:03:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4924e2sm181628655e9.8.2025.10.28.01.03.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 01:03:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 2/7] hw/i386/microvm: Use proper SysBus accessors
Date: Tue, 28 Oct 2025 09:02:52 +0100
Message-ID: <20251028080258.23309-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028080258.23309-1-philmd@linaro.org>
References: <20251028080258.23309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

SysBusDevice::mmio[] is kind of internal. Use the proper
sysbus_mmio_get_region() accessor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/microvm-dt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index cb27dfd732e..d7f49bc1b5f 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -71,7 +71,8 @@ static void dt_add_virtio(MicrovmMachineState *mms, VirtIOMMIOProxy *mmio)
         return;
     }
 
-    hwaddr base = dev->mmio[0].addr;
+    MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
+    hwaddr base = mr->addr;
     hwaddr size = 512;
     unsigned index = (base - VIRTIO_MMIO_BASE) / size;
     uint32_t irq = mms->virtio_irq_base + index;
@@ -150,7 +151,8 @@ static void dt_add_pcie(MicrovmMachineState *mms)
 
 static void dt_add_ioapic(MicrovmMachineState *mms, SysBusDevice *dev)
 {
-    hwaddr base = dev->mmio[0].addr;
+    MemoryRegion *mr = sysbus_mmio_get_region(dev, 0);
+    hwaddr base = mr->addr;
     char *nodename;
     uint32_t ph;
     int index;
-- 
2.51.0


