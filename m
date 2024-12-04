Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DBDE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwPw-0008KW-3w; Wed, 04 Dec 2024 15:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIwPt-0008K4-NB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:56:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIwPr-0006Q4-1J
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:56:13 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434acf1f9abso2075845e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733345769; x=1733950569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4dgzrMh++g/oTounPtmoGDAI8IhHPJPYGgHVhlbL82U=;
 b=VqztozFrRBiyfaZRLN6CCfuQIDTD2iUO23fmPMLh75N/lwdGkM2CL1ezOmZwFjVt4Z
 bNukhs6vsJ+OKdZcKjeniH//ZKtJJLORHPhlivQibQM3c1hct+ACikoVVAEz3KdNaADY
 xw3QN95DZsoryD02HR2oLjczbaMPQm1uoc7mTN9fsa+kncA1TMSJVuibp70BA3V6e09q
 MrUrwfEF6J+De5MDCkadHB8N6fzXGSFofg7tmbFCOX57KgOCkrJ0/279CI7gEWJlHRkq
 bWaUht1p75LEbcnxh64SfcZrzIEiU+bUhC4ohSxyaBaozPT9bC97JtD/gc3b0rWMoAgf
 STvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733345769; x=1733950569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4dgzrMh++g/oTounPtmoGDAI8IhHPJPYGgHVhlbL82U=;
 b=oyf61Do8N0orClTezbxgQcLPn2Q/uuMAu+yhLiVpoaHzZGkuzRRHx8HuM5pVux39tj
 U1OTfDRm4TFBiHWA3rV4kWpjPktLdkrTg7W0LkYa0ftYnWP7o6T029SY7aU/HXa1BABI
 SsY/LkCd4M/EREgdiblQhixvE71BP7DEyce3bKtzh56iCRHAk0y8HWLTXRnkTbTt9NNT
 ltJQYRCVthNE/kaXB1RRQyQdXADUiZch6VGC6zvOICAIVJLVmgrc3i8EDTiLgcqg3OZI
 CKbVb/GuD/l1L9yraG4/YXyY6tWgooLyBcEBNsZTWUHtq7M7TRDX9c5XzhcJ1UvKyE/h
 8bPA==
X-Gm-Message-State: AOJu0YyVBiFqTpsoV8AvQQAI94uTCHA/g3t0kieYU084fDSrkPSeF/yi
 k3hlcdxouRYwZ3EGQewnDEeiWaNZ7NIF5gwz6yEhvwltjnCaNZTtuyvUJ0f6CelP1R0oVYoWqB4
 p
X-Gm-Gg: ASbGncu+rfAdm8cxyABEEgJjfSWZTzUk/yDWaYmcXvo3QpXJaSI4kRkxnyA0feqT6td
 u6MIIdI5ZAh4o9HSA7c5YCGS7VOQMRU61Dk7iYOxHM9jKNEXBKC8Il110+/aVU0wsBwyQ7PIgvn
 bB80p/2/IW196DVeSoTwkahlXwBl06amAdaiqGKy9fI5kMXvfli33cyCsQVwXUtsfkbOO7tRprn
 oLe6QmAviKZG214SnEhCvWaRDBxbdMFpVz4DhH3XwjC1qeJEPC9tLcF2VmrMMwN55CPRQoVRoi8
 +pAst7oO+adrXXvfP2w/0Cu91j5KjA==
X-Google-Smtp-Source: AGHT+IEclg0e9UO3PYA/QQzv7do4XRc3Tq4+3vxAs/XK5RDJkvjbsD/tfblbeGDlehOtUHSLLLmXow==
X-Received: by 2002:a05:600c:5121:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-434d09b17c8mr69076335e9.2.1733345769180; 
 Wed, 04 Dec 2024 12:56:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm36081685e9.17.2024.12.04.12.56.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:56:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Subject: [PATCH v2] hw/arm/sbsa-ref: Require at least 2 GiB of RAM when RME
 feature enabled
Date: Wed,  4 Dec 2024 21:56:07 +0100
Message-ID: <20241204205607.62592-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

We are working on adding RME support to SBSA Reference Platform.
When RME is enabled then RMM (Realm Managment Monitor) takes 1072MB of
memory for own use. Which ends with firmware panic on 1GB machine.

Report an error so users directly start with more RAM in this case:

  $ qemu-system-aarch64 -M sbsa-ref -m 1G -cpu max,x-rme=on
  qemu-system-aarch64: sbsa-ref: RME feature requires at least 2GB of RAM

Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Suggested-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v1: https://lore.kernel.org/qemu-devel/20241126084928.252067-1-marcin.juszkiewicz@linaro.org/
---
 hw/arm/sbsa-ref.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d54497..66751d0806c 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -51,6 +51,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/cpu-features.h"
 #include "target/arm/gtimer.h"
 
 #define RAMLIMIT_GB 8192
@@ -795,6 +796,12 @@ static void sbsa_ref_init(MachineState *machine)
         object_unref(cpuobj);
     }
 
+    if (cpu_isar_feature(aa64_rme, ARM_CPU(qemu_get_cpu(0)))
+            && machine->ram_size < 2 * GiB) {
+        error_report("sbsa-ref: RME feature requires at least 2GB of RAM");
+        exit(1);
+    }
+
     memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM].base,
                                 machine->ram);
 
-- 
2.45.2


