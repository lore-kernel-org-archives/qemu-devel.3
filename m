Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E61C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1J-00019K-IG; Fri, 21 Aug 2026 07:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN16-0000mW-93
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN14-0007WO-IT
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4996f1ee4a4so5865365e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310149; x=1787914949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KYe/6B8tsxZ+nsgvyYwWpVH0krYt9p5V+gl6qmul/ng=;
 b=slvwWR1oNpp5VHssdy8SZq3eaOVO5QqpPzAdTib6DYWMz+bG15fDJPsP1iOZ41+JQj
 EFQF91yaq5WzuEZnZ/38N8oTnc5fp4A/T2GCw+VLUn+mwV5xUatoO20+qcYv+op2rXP0
 h8Y/srAtpcIsh0B72w9VRLFNAA2teaxu+Mcwbr1fucFtVLXhEOes30EZHa0+bdoZOhgQ
 GMtnl1VcOWavnr/TSh4s3otdt6zrkUsk0VlL1Zuu64jREwfkDHtcz8Qh+Kr0jGWymjIF
 pQLWOQcBpN8cMc8u78CW50UO9ClkGJVCH624XlxZrqhm+Bkb8c28ZFCPDKZPi5owhUDC
 +nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310149; x=1787914949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KYe/6B8tsxZ+nsgvyYwWpVH0krYt9p5V+gl6qmul/ng=;
 b=L3xh4eh0DFjMgfdTWkGhbrJSQnns2QPCQ7ufELR5ahaRp3emIv7xB45OosOKiEUmTL
 8kI1PGRLG8YgbXZFGHqGqWk8snWIaTCMjEDtz8XpGT434S4W0Twv7C3acITaYF/vkPI8
 SxM3fIT+81aVIBGtwgrTZsiPXXD2HK3moXUf9GQMoODXbyKf6zLkhmcKAJZlDwkB8OqT
 1LZSa0m1ReB/CIglAOf5l5/kQ4gNCz67wJwa3c7za3WYaESi9RvPlkZbMdfaETOOiZYa
 E4BRNbY4NwLxraiPwq3Vv2tQ6OEzbrpcMYJ9m0LkBsbGik668LuXqNuFWoAVQUHTgckD
 Vt6Q==
X-Gm-Message-State: AOJu0YwZ4tEWRar5TQjKgzZ94Scoi6EjxUvpk/LoMaRUe5SxVNnUmg+z
 jX0tisx293/9CWPQDGK/lqe+xn5somgvw07pfdOoSu2Hx7h4Nd24vzMBxLk7Qm6I9XTtjAtMs5V
 zqvxX
X-Gm-Gg: AR+sD133iEHA1yGIWax0JxOBxN1FW625XPfbos0GKxmfZ70f7mNCMnPg85xFX/hmwCY
 1pcrQtHC7VM/dkoqHfimR/fo/tcCra2nL5ryHlt7txO3HumUvOVKsfUmx+KTaGEKuo2B9xBxEJQ
 LxQ3EaN2HJ+Mfmz9VkJiP23K2hDqUJjryXDtH1HDh0AOijppS34DJIlfa6ivF4oeZea8N5hro0F
 yHBzCgfsF4IyROlX0SsaMXDljyjFPC4JKEEUq949S8FhBwgoES1zEgBDrSqvxKW5InUQWyzOZHh
 +QSgXstmp/Nuhg3vr38/3oRlNGxIQxVyB6olESQeph/gAXi2Y5q0rvV3H81zIBzdC+E+LNfKwHV
 Q26d91g9oJgFKGZVTX7qvNqwUIYLq1gJ7iGw7dPYpWzk0ic1xHVM7+V5JChHLHB5MOpFz9gt8XQ
 L5f+UiErwV22qS9F+jaf6nN8dVgN1IGgdftMRKKGFnmysY6iWpZj0aTeKxL75Y6eRj6cogPfeno
 L+VN0oIQ50ygf7++lMLt+2tozvWLoyrCdpYK89TtUnaacW+yWqu+DsDI99pIxkRsaWGTA==
X-Received: by 2002:a05:600c:638d:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-499b8457084mr91558445e9.9.1787310149096; 
 Fri, 21 Aug 2026 04:02:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/43] hw/arm: cubieboard: Store boot info in the machine state
Date: Fri, 21 Aug 2026 12:00:46 +0100
Message-ID: <20260821110101.3971391-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Move it into a new CubieboardMachineState and register the machine
type explicitly instead of through the DEFINE_MACHINE_ARM macro.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-6-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/cubieboard.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index a643ae4e27d..d59c1ebba7f 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -25,13 +25,18 @@
 #include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
-static struct arm_boot_info cubieboard_binfo = {
-    .loader_start = AW_A10_SDRAM_BASE,
-    .board_id = 0x1008,
+#define TYPE_CUBIEBOARD_MACHINE MACHINE_TYPE_NAME("cubieboard")
+OBJECT_DECLARE_SIMPLE_TYPE(CubieboardMachineState, CUBIEBOARD_MACHINE)
+
+struct CubieboardMachineState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
 };
 
 static void cubieboard_init(MachineState *machine)
 {
+    CubieboardMachineState *cbs = CUBIEBOARD_MACHINE(machine);
     AwA10State *a10;
     Error *err = NULL;
     DriveInfo *di;
@@ -103,8 +108,10 @@ static void cubieboard_init(MachineState *machine)
     }
     /* TODO create and connect IDE devices for ide_drive_get() */
 
-    cubieboard_binfo.ram_size = machine->ram_size;
-    arm_load_kernel(&a10->cpu, machine, &cubieboard_binfo);
+    cbs->bootinfo.loader_start = AW_A10_SDRAM_BASE;
+    cbs->bootinfo.board_id = 0x1008;
+    cbs->bootinfo.ram_size = machine->ram_size;
+    arm_load_kernel(&a10->cpu, machine, &cbs->bootinfo);
 }
 
 static void cubieboard_machine_init(MachineClass *mc)
@@ -126,4 +133,6 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("cubieboard", cubieboard_machine_init)
+DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
+                        cubieboard_machine_init, false,
+                        arm_machine_interfaces)
-- 
2.43.0


