Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE132C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1Q-0001kj-Fi; Fri, 21 Aug 2026 07:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1L-0001Pg-Jp
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1J-0007aV-Re
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so7877545e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310164; x=1787914964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cBek9kLx+MkiFoIG2V0LBP5n+4hnmWgnu83ORFPB5T0=;
 b=AmU0R/nmSrpJxB1Gj5R9CNtgdDuMFDko/KyArXXOr+kf97cvY5La5WlQ+i5+lspDyh
 S01DVCcvGt6Ni6R3KHXoNkH09uYYt3STazdO16mGkoHNA6bf4roXnhlyNGnvSs1cY8Us
 436RTsK/D2UAD3MBNzeJpBfHj4I3SCuF23z8J9HBxolg+6J20UiJVMu61prldEgucHWY
 ZiW6wyB+BO7DPJUz4VOzDPDPQ6aAndbYhvVNXvN4Fgoch2p+t9IBUO6ptaGGgs5vRd0Z
 1XceuPazKiLYLVU9iLIK+qiDXAT5zdnYN+kw4Hky0x7k5WZlsj5f8u2W1mQKICQK+a/h
 TY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310164; x=1787914964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cBek9kLx+MkiFoIG2V0LBP5n+4hnmWgnu83ORFPB5T0=;
 b=DJivWPWoXDsaWOObG7rI1LU4b6zqN2hEZqGSHnAc1s+XUFkCQbFpyBhlUuPC05rmAu
 TpAGFo+keOt97wW4Dj/mRwspwwx4IkK5aUb3QLTjXHjh3LFkl9DRKAk6Rlgb/1UOFZD2
 MzbO3XIHqbiE4jFOibTC35/0YLO5oNQQZKRYnsvjkeZOfFkcwytqDbvICVYsy/u9N67a
 35GCL5lu7GoPTCO8KC3AcP1sUXale1nkYMjhG350HKKnDTvJZ7twN6/akDXSqgU1PY8Y
 XFahQ9dRmX1gnI2e6LLDrMQ4364Q1rIXHczOgXP7QAscTjycBIQkWWT+JHmLnDTBghXs
 CAWA==
X-Gm-Message-State: AOJu0YxJX2+iPOUT9xuj2WMnxeEU8v7w9eXqbgR3Um/X7NG7RfyIRIDl
 73LgVfWdOzeK3Y+4eOvzqq7tz6TgzTUHupSwjFO45zikYwwr/hSdmky81SLxM//VNhQFEsS8wzT
 pD3xC
X-Gm-Gg: AR+sD11wwkVmFESREF/d3ZH2eZOikJfz0KQdwd87SjVRAaRThMYuKmbZ+UbgI1okRJ9
 zPqlXmBRIl4mFOOmDOpsJsjIzj/g2vpxOenxU2wV5NYYoI+DXyIKECSUPk54U3AAO5f9dJeq5Pk
 x3GFPO49h3uqgDOZvRjbI35eNkCL8XuFjzJmZUzrb7g2M/GqbYp4yhd/jVKiZH+sKxI42TV47b0
 zP/bAwwxpd+oS/LS72ApNRr4jguPaXY3VuHDzD6/iOvnewKcLAcCU9px7AS3mc8JU/FQdwacvay
 NyTVQ1j/UTBeUD9nKPjTsjoas9Qjrxqp+Pq6D/7zFakCHuWGtkC+wVgL0KWJXdpOjD9HtGgiVq5
 Q7RTPwPfGaquWHWVnb9tpjISPqSzLYx5QYo/hS+XN2EELIzPaooJ8zwN6jDg7N6WRHM848NcF6Q
 yk36YSjbs0IE/J2H2RcOVVSPd6tA5Cfi4CRKFhyTFSP5TZOo3SFUeakcDXthROwADuyuhXUiTrI
 /LQKQ4u8X0xmUlSRmPZF/Bhxwc94VTliX7Es2gLhFbPJGIJRiZRHVz2RHvst3FUROY5+Q==
X-Received: by 2002:a05:600c:4f05:b0:499:8ff5:8ecc with SMTP id
 5b1f17b1804b1-499b8474e8bmr67560815e9.15.1787310164199; 
 Fri, 21 Aug 2026 04:02:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/43] hw/arm: versatilepb: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:01:00 +0100
Message-ID: <20260821110101.3971391-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Give both machine types the same VersatileMachineState instance struct
and store the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-20-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/versatilepb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index c6991a52e65..520af79c800 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -182,10 +182,16 @@ static void vpb_sic_init(Object *obj)
    peripherals and expansion busses.  For now we emulate a subset of the
    PB peripherals and just change the board ID.  */
 
-static struct arm_boot_info versatile_binfo;
+typedef struct VersatileMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+} VersatileMachineState;
 
 static void versatile_init(MachineState *machine, int board_id)
 {
+    /* versatilepb and versatileab embed the same state as first member */
+    VersatileMachineState *vms = (VersatileMachineState *)machine;
     Object *cpuobj;
     ARMCPU *cpu;
     MemoryRegion *sysmem = get_system_memory();
@@ -397,9 +403,9 @@ static void versatile_init(MachineState *machine, int board_id)
                           VERSATILE_FLASH_SECT_SIZE,
                           4, 0x0089, 0x0018, 0x0000, 0x0, 0);
 
-    versatile_binfo.ram_size = machine->ram_size;
-    versatile_binfo.board_id = board_id;
-    arm_load_kernel(cpu, machine, &versatile_binfo);
+    vms->bootinfo.ram_size = machine->ram_size;
+    vms->bootinfo.board_id = board_id;
+    arm_load_kernel(cpu, machine, &vms->bootinfo);
 }
 
 static void vpb_init(MachineState *machine)
@@ -431,6 +437,7 @@ static const TypeInfo versatilepb_type = {
     .name = MACHINE_TYPE_NAME("versatilepb"),
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
+    .instance_size = sizeof(VersatileMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
@@ -453,6 +460,7 @@ static const TypeInfo versatileab_type = {
     .name = MACHINE_TYPE_NAME("versatileab"),
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
+    .instance_size = sizeof(VersatileMachineState),
     .interfaces = arm_machine_interfaces,
 };
 
-- 
2.43.0


