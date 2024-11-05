Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D67D40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8T4v-0000JD-TP; Tue, 05 Nov 2024 18:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8T4u-0000Ij-9d
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:35:16 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8T4s-0005vf-Gt
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:35:16 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so712600366b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730849712; x=1731454512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVMUnilpWTyAARMlNo8b1UDqRd7LQq70xLBCXbdhdhU=;
 b=ev4Td0lb81jqXoJ+C+JbCZ7j17r62ksleYXDUs0vtP2x61xIVMG/sj3ccN+4grZCkR
 1vHAg91KDVEhYh8awX2NrayVqzpgU/8ED6W43nQW47NX1lRdD9SLK6GAGm+Qnj4CR0nj
 zBKZdPWcv1mGB9MBOARSrZpnJPFhxLc2AALidmtaJv2GP3xSqGpBIxKRxt9w4xtVE8Hz
 OuEEEv40lLp2Iap6i3MgUYzwBuKwiJBVsao/9Gw4WTf8JPazOY5UEXyvGwfU2m94lrtl
 5IvRcqPkPi7Tist6swDThsZJb5t5qe2v7o1wRD2EtNM2FhR1rikIPmF8xwNbJZsumKBv
 S+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730849712; x=1731454512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVMUnilpWTyAARMlNo8b1UDqRd7LQq70xLBCXbdhdhU=;
 b=kDrREiDo+X3u0Im62/nfAMJjL5U2RlwBwN4Hov9IxMZw4RdQoCzFfh+wnfdJMqnywc
 HkyhtpsI6ntPxtytkfe5VNyO/m29pEKGdoPCJmk30F02pqIs4G9JuFrI6cuP4134ITUx
 MLTFFue35fUE6T8Y6ZVIK91oShMKjc9ExBkQGwHNb+9k9TXsVPNestaQZ9DaZMfMIOdJ
 PxttlVd1PyP4ls/dyLFaimAvd0Mrsm0HZv89NJt3NPAly5PJQai0kr/ffKdpmFvnoiaW
 aBEUIW3kxh5T0VdaPf3EaOpHZTuQnaQQwLTe5GWzKpQR8tL8yCPI7P0l+n7IixRblxhC
 V6cw==
X-Gm-Message-State: AOJu0Yw2y6hUU6aCW6QHTmXnog0iKUDSzizM5LUDGytAQPegxDk32bMO
 mXmIyqJzaxX5QRZW1wW4U05C89CnA2Pw3BFWYSSirYyVRvEw50oQRZSvhD37zh+pWC6EuKpp6gT
 AtoHHYg==
X-Google-Smtp-Source: AGHT+IFW91c1MCfptxMbn0BJC3OPuKHxUdGyA9drzL+mXZn5J04Uy7qYmqDpHQhk+im0u//1O56ERw==
X-Received: by 2002:a17:907:d23:b0:a99:f833:ca32 with SMTP id
 a640c23a62f3a-a9e6556fcd0mr1869938666b.18.1730849711773; 
 Tue, 05 Nov 2024 15:35:11 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16a10c4sm193453866b.33.2024.11.05.15.35.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 15:35:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL v2 01/29] target/microblaze: Alias CPU endianness property as
 'little-endian'
Date: Tue,  5 Nov 2024 23:35:03 +0000
Message-ID: <20241105233503.56812-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105233503.56812-1-philmd@linaro.org>
References: <20241105233503.56812-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Alias the 'endian' property as 'little-endian' because the 'ENDI'
bit is set when the endianness is in little order, and unset in
big order.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20241105130431.22564-2-philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <3f61b85c-9382-4520-a1ce-5476eb16fb56@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_ml605_mmu.c |  2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c     |  2 +-
 target/microblaze/cpu.c             | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index b4183c5267d..df808ac323e 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -90,7 +90,7 @@ petalogix_ml605_init(MachineState *machine)
     object_property_set_int(OBJECT(cpu), "use-fpu", 1, &error_abort);
     object_property_set_bool(OBJECT(cpu), "dcache-writeback", true,
                              &error_abort);
-    object_property_set_bool(OBJECT(cpu), "endianness", true, &error_abort);
+    object_property_set_bool(OBJECT(cpu), "little-endian", true, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 1bfc9641d29..43608c2dca4 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -90,7 +90,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->cpu), "use-pcmp-instr", true,
                              &error_abort);
     object_property_set_bool(OBJECT(&s->cpu), "use-mmu", false, &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), "endianness", true,
+    object_property_set_bool(OBJECT(&s->cpu), "little-endian", true,
                              &error_abort);
     object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
                             &error_abort);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 135947ee800..b322f060777 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -328,9 +328,16 @@ static void mb_cpu_initfn(Object *obj)
     qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_dc, "ns_axi_dc", 1);
     qdev_init_gpio_in_named(DEVICE(cpu), mb_cpu_ns_axi_ic, "ns_axi_ic", 1);
 #endif
+
+    /* Restricted 'endianness' property is equivalent of 'little-endian' */
+    object_property_add_alias(obj, "little-endian", obj, "endianness");
 }
 
 static Property mb_properties[] = {
+    /*
+     * Following properties are used by Xilinx DTS conversion tool
+     * do not rename them.
+     */
     DEFINE_PROP_UINT32("base-vectors", MicroBlazeCPU, cfg.base_vectors, 0),
     DEFINE_PROP_BOOL("use-stack-protection", MicroBlazeCPU, cfg.stackprot,
                      false),
@@ -387,6 +394,9 @@ static Property mb_properties[] = {
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
     DEFINE_PROP_UINT8("pvr-user1", MicroBlazeCPU, cfg.pvr_user1, 0),
     DEFINE_PROP_UINT32("pvr-user2", MicroBlazeCPU, cfg.pvr_user2, 0),
+    /*
+     * End of properties reserved by Xilinx DTS conversion tool.
+     */
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.45.2


