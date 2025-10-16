Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F10CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mze-0006qO-KV; Thu, 16 Oct 2025 08:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9My5-0004tU-6K
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxl-0000LV-Mi
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-471131d6121so4593945e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617203; x=1761222003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cKWZ/R2hl8sxJNhZB4ATBbXGJnuQp175pWuG145Dhi8=;
 b=LT0hX29cWNJUKeCxDt/qZgz87cTt/c+02yW7m7Kh5zz7EtKRx8La0KvUAC2KG8zng1
 l2n26obG+835qVJzoefv20a8seSZUM96sR/paZFQKfhAh7p7ky3y36tZHiShibiW8rJR
 nBQGr7/+H5bM+M3WNocQxhKGwIyCyaAEa4VkVJOsThF0m/bwgoHvpSTbQFStA+Qf9BYY
 SW+Rl+biCInmjdTbzOBhfHwgZpYiCmM+5hG6prDAAKqKDBVrLd7qcrmaTZ86U1exNA3W
 TuWHB7Yz2kLDhn05fm7q9bgNlvNmhFUv8JhuquGMDNKBvxxzhE0n7na8Cvu9/8PG1PGW
 Ktkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617203; x=1761222003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKWZ/R2hl8sxJNhZB4ATBbXGJnuQp175pWuG145Dhi8=;
 b=eYumfVRk9Tbro5IHT/F1c1vJBpdrgDtY7rXBCaWVUqsge5JMmVOr3IHlx87jaUDpmC
 eW05Ne0GPQeCgovYNCQveCjGx/pun2zPC81elj6oe2LAM4W2wHJtlWt/dOj76OJLmavV
 TzC+hU05mDaFuYTj4bhhP5y8aZdu3bvbfrsWxIPhjoyye17qMjcUMiJ580mWNNLsG5ds
 Jd3EamDv5eoD5Mij3SBfpjz0HH65AOhYzp46skCK0a/Ls2Rik3+JsfrbZ4WztQ4kCPXr
 9+k2lYJmOggjTYEtYTlQLenx9CHmIPQBFixVpqhSulapnlZop+aQ2hjm1D30DI815Gst
 h05A==
X-Gm-Message-State: AOJu0YxkBxzSR06oTGqwSwBGjtTzmKA2AhHxBLpNWkLX8Gv/Lid8fRMy
 p5I1iyGFuPz7ES6p93asQtQ7kDUt4BkPPCejcVtiz/5pKlydw/av6gcUE8raPL14QG1Amkv5HuU
 Co+GEFpw=
X-Gm-Gg: ASbGncs3zdIaVUzzO6Js5YuJsJQ0eeIiNXJBISuntl5cw6fWm2e5Bpn//A21zMy5RIi
 Pc6cQ9X5g44/Usvi8tc/GaV4TD+07xgwOZNDy0uHpjYh4UMqzHKVYHxwNhBomiTjKlhENhlHg4G
 pEBlc39mfIMVZRdMREAYQU+9quPdihDKm0u6jCVa8KTBlB/Ucg6kwunPYfDI084zgRnK6wUO6xQ
 VxeYWhIVB8KZ+0UJdtmkp0qU9lJFVg1W6SHj4yAYSlJId0vqJTXLEk1eZkOIb/+PJkUNMuT13oF
 oPM8JBlvF6O3cip0lyPVgtFgxAOTq63Wt4U8ISkr+OUj7L4uXncx+Nfa/k1+wutAjLzqDdi29Ze
 naOQcT7hv1roxz60b2I5/AXs0nrMCz2/4xGsPAXjhnK7M5XEfYXXkiLNg2mLfduR9QhG9Yg9s1u
 Yu8yrtDdmMAPEQQEcs3Vv0Xj1u1eKzh3QhjYC1hxHW762BJ8+vSyO4UGRK8B41E6J9
X-Google-Smtp-Source: AGHT+IE2kcXavJ4X+8uzXTaOHNbgJMQxL98Wc/7fFaBZMs5jnI48504rzDGkDFZlo7ue64j0wn0COw==
X-Received: by 2002:a5d:588d:0:b0:3e5:a68:bdd0 with SMTP id
 ffacd0b85a97d-4266e8e0ademr22671635f8f.52.1760617203492; 
 Thu, 16 Oct 2025 05:20:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5d015esm35414918f8f.33.2025.10.16.05.20.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/75] target/sparc: Reduce inclusions of 'exec/cpu-common.h'
Date: Thu, 16 Oct 2025 14:15:14 +0200
Message-ID: <20251016121532.14042-59-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Only 2 files require declarations from "exec/cpu-common.h".
Include it there once, instead than polluting all files
including "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20251002145742.75624-7-philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/sparc/cpu.h          | 1 -
 target/sparc/helper.c       | 1 +
 target/sparc/int64_helper.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31cb3d97eb1..7169a502432 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -3,7 +3,6 @@
 
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
-#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 9163b9d46ad..c5d88de37c9 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 
 void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 23adda4cad7..96ef81c26cd 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
 #include "trace.h"
-- 
2.51.0


