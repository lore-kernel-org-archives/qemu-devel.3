Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26104C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84x3-0004Wz-BB; Thu, 24 Apr 2025 18:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84x1-0004WZ-Bl
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wz-0000y6-QG
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso1145760f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533304; x=1746138104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcKxk9xHLzn4vLPNgBhLM1l0n+4cuceTbVRIhADD9/E=;
 b=cppKjg3teCSH5khxGTYY5/rKg4HjuedGZGdli3QVLF6YpfKK3yDek7K8ucibQGQFCH
 VGypJI7JZEnnNJMsHrPb2gvKO91RyC2fI5iZWpIYsfJHohFtCF53dfTOf1t9ybcoLdzl
 IMpFic89bWFrjUpho/T7ky4n4ExxS/tUxI+ywo2XumG2OrVd6TTKnv508Og4PKFm6tf+
 NW7icLODHgQsgzVrOLElCXzTTHnP7qmgec8Zg+UGTmxdNSd9yb99wrL/maM9KX9kp8hk
 atkGtqAxX9kLCcC1I7dQlIQAiqFgT1i7ATpxdmSK32/Tz5HhdJljhHR1LpGRDWr8cfTG
 cexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533304; x=1746138104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcKxk9xHLzn4vLPNgBhLM1l0n+4cuceTbVRIhADD9/E=;
 b=IDCCWzUSaFoUM0GLjAT5rCvgUBWvHs0TvY0IAKdo13Sw5nG7Hf520IlncBbltlk6oG
 ovkgySS3AWpFzowjjC1VsBD1hyBdBPHnXcfI7Sh+ivv3yEaFA63ycVxU9y7PDzVY31rs
 Ro064fPNmW5BiPIkFTWedXtCL/gOP2qfBF9OzzCObE2orxnxv3JLJjEydJJeEu6WHLlx
 3tIyHqra5dMcdhCW9PTIYXak7qZn8P9BM37aO8K0xQzWEBg8cVz139+UtjvbUPzQaDen
 drwdaiAhWASnHBd+CiI5gtnUXR02vXDY0Gfe+AfKHp7ntS8JlFz74bI3RtbJl9oGaH4f
 V9Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR2yNWhfDvhEnb66TTiTyxbp0q8GsG5tufAVX27X5zo0fHXJzhENXuIpUVkKOMpFY0bfuHiIJEZ893@nongnu.org
X-Gm-Message-State: AOJu0YxrdklfzPDGDrqbqPtaE6fnAbFtR904cNxINCfZodjbvrMl39O7
 i7RDBrUGmYRVSolMCEnYWcbnbiLkOR03iYtJ1vw6dSVO3uUeHhfKq1nt/uthm14=
X-Gm-Gg: ASbGncuQOqs2+TgjJ5d323XaDznT5zsPGEQmCb5+NABMMFqAqACSRpN5Y80ty4NNLb7
 uTW9P73lvqmsxAbwFCs4a0yvueUZjlxvvx+mrvxhQKkLEMFthcbkepUsX5jeJ4UJ7gr0tfCwGuN
 akFduRk17ulSJIfnk2Eepvnz2oD9PxZKpyVsZAdXxvpd3vjTAqBUXagf0hjX1nOQ4xCH5/gXFyL
 BsjEq6yS9ypXsaB2TSk9aLbSGrIN7DBRPG1Ib/LxovhSLvu3lNsQUQeDs4XbKSAbJLgA4BfhUle
 A2NhjXklVu3ifoK+Xsjzl/v0TD3piFkIahZecrskrbjlhn5pw21jspRLXuwJUCOouF9UDGTgn8W
 qAi6cB+94sKtImzw=
X-Google-Smtp-Source: AGHT+IH3HKGEWtPO1pWqyFffqqAR4YLf+AmhFiigG7UbXmry8ruYRR/9Iu5+LI2PiA2WPvBA2YOX8w==
X-Received: by 2002:a5d:5f43:0:b0:39c:3122:ad55 with SMTP id
 ffacd0b85a97d-3a072aa670fmr745379f8f.18.1745533304334; 
 Thu, 24 Apr 2025 15:21:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cd7fsm520024f8f.1.2025.04.24.15.21.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 06/21] hw/core: Allow ARM/Aarch64 binaries to use the
 'none' machine
Date: Fri, 25 Apr 2025 00:20:57 +0200
Message-ID: <20250424222112.36194-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

When we'll start to use target_machine_typename() to filter
machines for the ARM/Aarch64 binaries, the 'none' machine
would be filtered out. Register the proper interfaces to keep
it available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/null-machine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 3e03771d570..9009d3d96f5 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,6 +16,7 @@
 #include "hw/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/arm/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -62,6 +63,11 @@ static const TypeInfo null_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("none"),
         .parent         = TYPE_MACHINE,
         .class_init     = null_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { TYPE_TARGET_ARM_MACHINE },
+            { },
+        },
     },
 };
 
-- 
2.47.1


