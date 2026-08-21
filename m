Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A3EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1M-0001QM-2p; Fri, 21 Aug 2026 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1E-0000xU-Ks
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:42 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1C-0007Ya-By
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso7074055e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310157; x=1787914957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GawVdWQDHqb2VdR/tPStDoQ7Vl67lXfSjkdyFM0jSSE=;
 b=CA3yVz8by3wIDI/qm1l7qNBcZghjD7QZMr+AAmuxi99DvSm1g6xCyzFOuqQSx9VCmd
 kRrSY44b43jPIL7NGBv3QkJts4KfwO9VMBugO9TTitcPPNXXddjM3eAJBIbnEXh4OUI+
 QaTJTimaidAQ9mRhaqIcVxc3hlglq1LfkrksTvJKJzNIqMZm4DzBAf0ZCuaeHuidnqPK
 ry3/TE472LnH4vUPx7JhO/V26dJDcNdDjSUs5EoC5CNxQ+XkT8Hn6GrsOXnjtUQX/uU/
 nq6o9KH+ahb1Y+6rdrVtJ8DGhGpmf8dZmFKKpd1R5h8izHSGIJs0HYwfscTqoBDFpMK/
 BLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310157; x=1787914957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GawVdWQDHqb2VdR/tPStDoQ7Vl67lXfSjkdyFM0jSSE=;
 b=JzGQ6cV28BTgHB4MsUAzYFqJL1gGy3ltcUvYUDxvQLs2C4POwXkjsQJcLbllUNbLFK
 IZ4bXfyu0P6EuVQNlp1PjD3M2/d0pQeixxvB6/wLr2ciG/fNF5QtRnT0grAu0KYD73+i
 RmQO0ExnOp5cPufKlrmV0iUN/zKXjh/1sQkwcBOUjymmQre/mLADCTOdv0iadaM0ykMZ
 2o1n1ATmHJhDy2UB3ZZo9kKntW6b+TELkWcz8FonYyJAUKeEfJj+YooHnvrhzaYsVTCk
 Sq6b+KSMwp79yRX+gCZcZ86pn2NosGjCdmcvr3aoQfObAypDgzdC7ihi24ZiRSgUSF58
 Np4w==
X-Gm-Message-State: AOJu0Yyu/1lQlTRuKQlrs8qguLMVifg15bFsuPfA0pUmAMliuqMC4ZIB
 Y+UfHlaKt+Iu9unVzIDm1io3CsBAjVXi5l/1ZUkOcfZcqFw37V3fCwEBHMOkGYdfOpa/j72PRCD
 RU+DX
X-Gm-Gg: AR+sD100nHFbHhLszbU7mao7oCqyuOkrcG3oG4dyUtQxCyuvNPXW9X7q2/jkEYysEWn
 NKlOFQSzzm+tpUOfFLFGJWm0jk5lhyjMt5WIjp3NvOF8s8AcSSM8EvR0Mq3REXmek3gsPug6LBi
 WjwI/ShS0zSebHZgRlWRpdSfQYx3Ap+LV8aqd2k26X7d8QMfanifkdBX9vVBHZqmZV/g7kGADf/
 rVhYnhoO4t8m6C5u+EvP3xaYq++zRYwrp8JchTbzwPQ7BdE0xOVuTL64gH2AKRRx0WFkZiciZ0p
 d+LltI85SCAgaFHaAhCnJlXut8EoWZjGUPtKdMFjyWjNIMO/xCj40ol65VaX++4dnQVkRmqDNND
 KUKLLH57KnF5mkH8TYYsoNN5r17IV5j5zmyuXEY9f6dq2AvmdCw9zRJU09ppoOjWOJuh4oqgdkE
 s6oTeJar++RIHj81ysOn2y53xYq/zXvJSKz7W33rnqG5kh4C4RFK54jo2Hb/EZP7cjk5GFwEo9s
 y0W+JGqs0uyeiFPzfhE+IzMcWmGkM0kN+GtZ+6bsJA9EHL8ycuDc4qep0lvxcG2Nk93pQ==
X-Received: by 2002:a05:600c:5294:b0:499:8ba4:8cae with SMTP id
 5b1f17b1804b1-499b830d665mr83867755e9.1.1787310156954; 
 Fri, 21 Aug 2026 04:02:36 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/43] hw/arm: musicpal: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:53 +0100
Message-ID: <20260821110101.3971391-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Move it into a new MusicPalMachineState and register the machine type
explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-13-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 69e83bdd973..8a70ed7377e 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1200,13 +1200,18 @@ static const TypeInfo musicpal_key_info = {
 
 #define FLASH_SECTOR_SIZE   (64 * KiB)
 
-static struct arm_boot_info musicpal_binfo = {
-    .loader_start = 0x0,
-    .board_id = 0x20e,
+#define TYPE_MUSICPAL_MACHINE MACHINE_TYPE_NAME("musicpal")
+OBJECT_DECLARE_SIMPLE_TYPE(MusicPalMachineState, MUSICPAL_MACHINE)
+
+struct MusicPalMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
 };
 
 static void musicpal_init(MachineState *machine)
 {
+    MusicPalMachineState *mpms = MUSICPAL_MACHINE(machine);
     ARMCPU *cpu;
     DeviceState *dev;
     DeviceState *pic;
@@ -1341,8 +1346,10 @@ static void musicpal_init(MachineState *machine)
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(pic, MP_AUDIO_IRQ));
 
-    musicpal_binfo.ram_size = MP_RAM_DEFAULT_SIZE;
-    arm_load_kernel(cpu, machine, &musicpal_binfo);
+    mpms->bootinfo.loader_start = 0x0;
+    mpms->bootinfo.board_id = 0x20e;
+    mpms->bootinfo.ram_size = MP_RAM_DEFAULT_SIZE;
+    arm_load_kernel(cpu, machine, &mpms->bootinfo);
 }
 
 static void musicpal_machine_init(MachineClass *mc)
@@ -1357,7 +1364,9 @@ static void musicpal_machine_init(MachineClass *mc)
     machine_add_audiodev_property(mc);
 }
 
-DEFINE_MACHINE_ARM("musicpal", musicpal_machine_init)
+DEFINE_MACHINE_EXTENDED("musicpal", MACHINE, MusicPalMachineState,
+                        musicpal_machine_init, false,
+                        arm_machine_interfaces)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
-- 
2.43.0


