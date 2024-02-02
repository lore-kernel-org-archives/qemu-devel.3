Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD083C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb0-0000Jx-Tt; Fri, 02 Feb 2024 10:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvay-0000FO-J0
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:48 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvax-0004TF-0q
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:48 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5113a7e662aso553370e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888205; x=1707493005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RvJ8JOx/rn0qluSRFPgqZoXgXfokD/UExFxdgtk19s8=;
 b=B6k48+oP6HvrnzK0IBjrVFFPooGoYS1OJ5Ag02iYQLuQtZIAuejG8LzSNPUjUuQprS
 yFLRTW+mPcM7KoQiA4q33FmcdaG/cgyY9jAZyUKXruFWvx/N8GhdzK4qT1R8WJHEwX6A
 TAGRye9tToio/0FmLVWpOCx9NYz+Gsd+sQgfRF1E2hbHY2tT+hniK5RxeqHN2oLzXQKe
 RT1iJFo74Krpj8/fWIQLTrl2p67D1zSi1ryUk+SUOvX+FYns6vZ89SWA2/I35WAMhacY
 XK6PtqgthvCkizb2Yq3mUGV0A8eW96V5ugC8I2VwnHloFNcV8uw5S7mnX2s2auAIP4gi
 z29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888205; x=1707493005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvJ8JOx/rn0qluSRFPgqZoXgXfokD/UExFxdgtk19s8=;
 b=rs90oXXxmNIc1zQkyTmilVb40QhlXgY1MOOh1JIEHA0Q3hwXbrqpWtSIz4nHwODS7v
 KONntziW3qyMsGxkJ5GkIqZnXchWxJqLT0ysfMt6cD6ADu2PnQL7qw0SxNlHxuFJ+L58
 CU00TOTXhCHB2rQc688MDoeMFJ2bSalMs0uSvxexaalQ6HHIhO5OI4eRF6Vv486L9gQ/
 LdqddDFoXa+snEKD/jX+6Ql8Y1eaFWYZVoxq+xKckdnwscuzaWnjQ6TmPuXDmQlZ1Qjg
 0pyPisNIBqDz50Y4Kdpn+2L/lEfTug21+rFP5KHL7g880pTEC3HPIq+/FuCiyUK5oGR3
 QFXQ==
X-Gm-Message-State: AOJu0Yzy2zK9RLnrsPfoaFJx9EocYrd5vZFQCRa3pmbUHiri1ZP2EQyj
 OTwZVhtACHt4DUCsfb7I5E2iPVjIR7sFagbRRCf5ze70MUFChfqoexS/0FjGIiw0rHqBX4JTlEm
 L
X-Google-Smtp-Source: AGHT+IEtzuILyFGGqdQby9UU9xTmMV412JhjllkW3pzXIv+1nfUVA/IYve38pXQyN7/UJ7MKNv57Qw==
X-Received: by 2002:ac2:522b:0:b0:50e:6d96:4b27 with SMTP id
 i11-20020ac2522b000000b0050e6d964b27mr4256689lfl.60.1706888205391; 
 Fri, 02 Feb 2024 07:36:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/36] hw/arm/exynos: Check for CPU types in
 machine_run_board_init()
Date: Fri,  2 Feb 2024 15:36:15 +0000
Message-Id: <20240202153637.3710444-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Restrict MachineClass::valid_cpu_types[] to the single
valid CPU type.

Instead of ignoring invalid CPU type requested by the user:

  $ qemu-system-arm -M nuri -cpu cortex-a7 -S -monitor stdio
  QEMU 8.2.50 monitor - type 'help' for more information
  (qemu) info qom-tree
  /machine (nuri-machine)
    /soc (exynos4210)
      /cpu[0] (cortex-a9-arm-cpu)
      ...

We now display an error:

  $ qemu-system-arm -M nuri -cpu cortex-a7
  qemu-system-arm: Invalid CPU model: cortex-a7
  The only valid type is: cortex-a9

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20240129151828.59544-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4_boards.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index b0e13eb4f00..01c7618a67c 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -34,6 +34,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "target/arm/cpu-qom.h"
 
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
 
@@ -150,12 +151,18 @@ static void smdkc210_init(MachineState *machine)
     arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
 }
 
+static const char * const valid_cpu_types[] = {
+    ARM_CPU_TYPE_NAME("cortex-a9"),
+    NULL
+};
+
 static void nuri_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Samsung NURI board (Exynos4210)";
     mc->init = nuri_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = EXYNOS4210_NCPUS;
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
@@ -174,6 +181,7 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Samsung SMDKC210 board (Exynos4210)";
     mc->init = smdkc210_init;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = EXYNOS4210_NCPUS;
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
-- 
2.34.1


