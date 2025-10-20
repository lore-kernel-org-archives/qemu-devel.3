Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CBDCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy57-0006bu-1G; Mon, 20 Oct 2025 18:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy54-0006bE-Ql
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAy53-0006Hr-6N
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:10:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso34344005e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998215; x=1761603015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sl5D2OBPAk30ix5XFbA96G64ecqbTuVPaB9Fe4lYaE=;
 b=Jt4nZNglwi8mzrVe7AICukwaap0SA/wBBoRJ5aD8jbuO3dPtNbb2VrGiYN1s1IIEZW
 U2zPsCk424Bp8T0HGBz7FtpUYG+7ZIJBRD1e/4RrIvkeJ0TH64x7vrKS7Ulj9ycQDc5D
 nA07kmb/D+PX15rxa1jBYzl9uK1/0BmuhljFli2/gsp/VQC0Cnj4PQtM8DXT7JhpZarO
 73T5A+g7G3rzgNoxgloTHuyw/Wt+xaynFLcX7uZEizXS5KJi5vTmkHeI0SQ9wyjyETRx
 qx37ExlBNA0nK4xR/pDqPMg/ao9Xlm2pcUfRUqLT/4ut1JO8zHHwO6I/A+EQXaFMxWpR
 oFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998215; x=1761603015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sl5D2OBPAk30ix5XFbA96G64ecqbTuVPaB9Fe4lYaE=;
 b=G2sBxK2NBajNgRbKv8SoQhKuE4oeNTn9QTCAKGvpPA9b5zx4slFbWQuctUhCHGNXcA
 N7joAKCIFhLQKiPoI3JXRTWx5x0ByZbT4dfE8Q6VFRlr6+aUDHI0g0jvyx9MVxBP6V4K
 2fp83sh6ZmeKwseLN/dfIf4h8h33/ym5ak2wgYM0vWT7b3y++O4ohl/TTPEieSToQdzl
 NB+2zw0JludwHs+gWRYM6AdsQ7mspMZBa3C8sRzELhW8XlQxq1MJVx0lvWdTL7GfTlo8
 JlHwtmnJOXEETUkPN8qdzoAZv55TFPW1imA5yoBHJuraHdyuRFCxoHdM/3Apex/IDEs9
 F2/g==
X-Gm-Message-State: AOJu0Yz4zOm8K6nN0oDgI0EIOCUhCVNgTdhmrElcg0nClr6g8o3f2tum
 0entPQ2+xlQFIRmQr9C+y49KS2qBOx+x0jgGwn2Hf4Ak4vr7dZXQCtBd3Yw0hnVuJXSQUnhS2fb
 YMQBv9TE=
X-Gm-Gg: ASbGncteOWuPdCLiiePL307eGa826O7Brf3HzvOpMOFX2jxM4LEHvRahT9ifAHkRYUJ
 6VA7hALPiS/1XTIvUKs+gBsqhiGnJ2u4qhQegHpWisYAWzUe+fCpDqQpk8sFeNeUP6nkPDZftRJ
 GZdhbfm8ifhhP650THmZD0q7UQ5tknbyxVJOfMeLXcDMNVYP3sKaseaj5Jps7cGppjh0O2Gxwaz
 tqLnpl7eBNCIydFcu27tD9qSFbONDy/HllkT2ufjR9KrfLaTTFRrQmXVEDuSNMb5vtJfIzVga3Z
 0aPciGSY9ta/Jii9ZXDCfEUDSVDbvyM5AV+M7NazzQk6h8sXF3C6tyoN2ExKgY9fRP1dMLH8Wxt
 oTB5d6ruD98+goxDjcR8TBMvC08YJVTvQQKjOjJ08peoxpFE6F5uKU80ZNOolxq7y3X7QPnywqK
 P579iA2qedA4A/ZMyqICGUu1BA+7ThMNYJoffBtsSsZ67LmXAUWA==
X-Google-Smtp-Source: AGHT+IE+vX4pO5dXERXxNooJDvsEmYVIlONKnJr6ISUfLsDV7Tbejw7J4MCHCnZoj53rT51/Mtwlow==
X-Received: by 2002:a05:600d:1c:b0:46d:e5bd:2ba4 with SMTP id
 5b1f17b1804b1-47109b5f38fmr102660625e9.18.1760998215231; 
 Mon, 20 Oct 2025 15:10:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715257d916sm158729025e9.4.2025.10.20.15.10.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:10:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v6 06/30] hw/core: Allow ARM/Aarch64 binaries to use the
 'none' machine
Date: Tue, 21 Oct 2025 00:09:15 +0200
Message-ID: <20251020220941.65269-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
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
would be filtered. Register the proper interfaces to keep
it available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/null-machine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index a6e477a2d88..67b769bd3e0 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,6 +16,7 @@
 #include "hw/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/arm/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -55,4 +56,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_cdrom = 1;
 }
 
-DEFINE_MACHINE("none", machine_none_machine_init)
+DEFINE_MACHINE_WITH_INTERFACES("none", machine_none_machine_init,
+                               { TYPE_TARGET_AARCH64_MACHINE },
+                               { TYPE_TARGET_ARM_MACHINE },
+                               { })
-- 
2.51.0


