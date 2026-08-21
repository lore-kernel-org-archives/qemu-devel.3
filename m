Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC8EC5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1M-0001Uv-PA; Fri, 21 Aug 2026 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1H-00012S-0X
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1F-0007Z8-8g
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so3570575e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310160; x=1787914960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jDgg4EScB8bslHVWuzjdiznJQxcizlYwx+ib9GrZvI0=;
 b=tVD7vVj8nJhHA/BcQ6EKO7p6PdriIxNeKFARshpll9esYVAitEP2GSLsQvzaiSJL7P
 F4kIQ7JE5R7XowPcc375EY72QQfGjx068z1HnhGOYTkbjLwb6pDvOe9cVJnaPCfPfVFL
 nbfpNpCPO529hFggE1ypfmWx/cuZcXyTdC0HiipPAqR3hiGcKe3WYo0MGnBjajE1Pmnu
 axoGsGMWu0c9GX/5VcaYfKDyTU11FfAUWG6HD1L25SPGTS3fABIQ480PxtdzV2r03FsD
 MDX6apwTVrLmoRkcikV+9OV9SWTdIkqbiVzL9KlEEbsMvvuPoKqoIYv+oKOs5hk9/V4w
 q1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310160; x=1787914960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jDgg4EScB8bslHVWuzjdiznJQxcizlYwx+ib9GrZvI0=;
 b=L6G78tPrMAzBRSKoKY//wONhHGq/6Ok19wEeKwNJ3jPF+JHrS9L41obEazHFgImI75
 rGqBqHHtntZwAX2H0PSwiQhREwTUZli7mGzWzuTlhZOoyT4HaZVhS7llmfAEQyIX7QLc
 9qS2G9W4BYmThOHRS6UWJRz/3I904YQzI2ujj4FoOoD26HFStj3kgDWRQL2ltnJtgcaC
 LZKFXQE+mk4KYMRMjLHhMj1brpyLGyw9mjRyG98qCgJWaicF4UDWzGJRwDoWTNLck/zO
 elZJ12vegsyQXV8gOKhfEgo282ag62iU3ZDEsHRhfMhDQr/QBLMmOmKdOgHC8b9CQ41Z
 DiOA==
X-Gm-Message-State: AOJu0YyBRy2NJ22T8QwFvqrvrBZkzRew3VP40TCWJDdNKmvYvGEMVdlv
 l1cEFdCyZq2XGABjmZ+jqXbQW57UoDaLfX4LXahhIgz09kkKex77RksCmk53oDBdb2jjcohi6ju
 wthkK
X-Gm-Gg: AR+sD13NuMqFuVoNpVQfHwgvMt/MYrrrGg9/9w6KHPoikac9VMnFSbfd6NtKj59SXsx
 9IJGvRlpi6SAAe0mFUuimygGA67nJrc7EIiJ1kkYlHrSMUwuyE5NLyxI52NGTcdw9k6y7Ou08jj
 yaoz1jxIzUXKueA8oQnnsQijID76o4tL1DXcnY7yOGqL7TnNCikWXVep6xzTWo/vlQ5DqMmhZDz
 GNdTkNmL02SyVfBUte0sX9b2DdqYHnfkKZZIxSrHoVCWbFzZp2KfjOCTdEwPiG5MHbu0p9XXcmY
 K3tqlBGG642mN43qRsfQGOMhCmPE5CKVuw9fxUpPMEkvnVE4w4CS346QvsKOOlarY4AX8/v8q+g
 E6HOs8h5M+U/D0whE8beL4GRQUbVc3CAIk/SorxGIU9ApplzNi/nI6Ym01mW6cy6uZSGzo6UAgw
 qdBFQxISiETzzKud8SF0hczyElmNHFgW+4w2gNgBu6WXt/nULZF3Ks9bCtRPBehp64qDfS9cx9F
 4jSAz4f4C5L/qoA56k9pM86wypGx854dNX1vTRh/v2J532h5CJZAPKuSw/i7BJUhOcf9w==
X-Received: by 2002:a05:600c:37c6:b0:499:858f:2653 with SMTP id
 5b1f17b1804b1-499b830d08emr87013745e9.2.1787310159819; 
 Fri, 21 Aug 2026 04:02:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/43] hw/arm: omap_sx1: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:56 +0100
Message-ID: <20260821110101.3971391-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Meng <bin.meng@processmission.com>

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

Give both the sx1 and sx1-v1 machine types the same Sx1MachineState
instance struct and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260816131300.51799-16-bin.meng@processmission.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap_sx1.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index bcb7105323f..3b628d13cbc 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -91,14 +91,16 @@ static const MemoryRegionOps static_ops = {
 #define FLASH1_SIZE     (8 * MiB)
 #define FLASH2_SIZE     (32 * MiB)
 
-static struct arm_boot_info sx1_binfo = {
-    .loader_start = OMAP_EMIFF_BASE,
-    .ram_size = SDRAM_SIZE,
-    .board_id = 0x265,
-};
+typedef struct Sx1MachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} Sx1MachineState;
 
 static void sx1_init(MachineState *machine, const int version)
 {
+    /* Both sx1 and sx1-v1 embed the same state as their first member */
+    Sx1MachineState *sms = (Sx1MachineState *)machine;
     struct omap_mpu_state_s *mpu;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     MemoryRegion *address_space = get_system_memory();
@@ -187,7 +189,10 @@ static void sx1_init(MachineState *machine, const int version)
     }
 
     /* Load the kernel.  */
-    arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
+    sms->bootinfo.loader_start = OMAP_EMIFF_BASE;
+    sms->bootinfo.ram_size = SDRAM_SIZE;
+    sms->bootinfo.board_id = 0x265;
+    arm_load_kernel(mpu->cpu, machine, &sms->bootinfo);
 
     /* TODO: fix next line */
     //~ qemu_console_resize(ds, 640, 480);
@@ -220,6 +225,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .name = MACHINE_TYPE_NAME("sx1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
+    .instance_size = sizeof(Sx1MachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -240,6 +246,7 @@ static const TypeInfo sx1_machine_v1_type = {
     .name = MACHINE_TYPE_NAME("sx1-v1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
+    .instance_size = sizeof(Sx1MachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.43.0


