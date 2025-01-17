Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153DBC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1v-00040e-8t; Fri, 17 Jan 2025 13:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1s-0003yQ-NE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:12 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1q-0007r9-PR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:12 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso45849125ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138309; x=1737743109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWOubo1yw/jMK9n7npaDQ/kdBR0LHc4+hHuxEbmZxkw=;
 b=ocAFvnUlPu/0w5IUFBYl7jRv8B88wNs+ry6v1cxdDxAujF+qFMUBrI+tPCnxUVAVKd
 j6aKtfSp7ao4BnU2vuLyBxoyyzhTXGndWUKR6VxQvr77z232JRjGeBnLRaroENIOWGHw
 W33VoJc+tJp1PcjEfnUADlNDnFcp/jpIwhVDRXfvJDpdwur/VENy8aSfWzBfHXRj9Oyt
 zMBvPVZEMl+sVJgFnJOu12oe02s0eC+t1yFYckwX9mmeKoTkWY45Ud/OrBrkUuep7ZV1
 4/zYKUKS0sNb2KlFyDGUw2DkHOVlHvebw1OGjmBLCyrfZrelv89aZvfI0cLmvjF0qCQk
 EK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138309; x=1737743109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWOubo1yw/jMK9n7npaDQ/kdBR0LHc4+hHuxEbmZxkw=;
 b=GBzOqzCnJwO+NPYUN2e6d/VYJHCqOwB6sQecyfdr/ajlSnEJJQCCoVFlfQukTsMLjE
 LMMNRNDKp6mjTSWVGFFy2HDmsrq4vELNHBhZZWObV4f0F5MUPljviLvsQlL/DE5VsHT+
 PjyGfwziG2DE60uDfAMYcEdg0aT/0Utc2W78m48aflfVWUOcCNoiYdV1gUAhpmbJNiTp
 T2drecy//MA+ivgCtTreI6Zn+3tmma1VcpfDRIKE238sCw+p8GkSy2kp3HLL1JVs9RMg
 +trbKmO5JRf4Ur9iTCco1HbAD2oFqSAgRjQYmnobyHSxJcdmM07Dgp8yozDQ5qAmDmsC
 Rnnw==
X-Gm-Message-State: AOJu0Yx4LJaEJepPq7SYWg+XRHnoYmDVkfC/TYtcXrTuNOTGFSyCJ9rN
 Xbc0OO20Zrr+JMIhrMFiDJe4aIsK3GfSGunz2yuGsKxHxjE8OnUH0KhNPhItj/sZjRJ6DbXXY5w
 C
X-Gm-Gg: ASbGncuXiwP9ehC12uN29pupSwVEXbCD92oq3cXxJYkDL6XHjR+Yl2pFZJtRLpNsros
 0L20ZW1adrNUzicV5tYss+jGzY0xve4+JWBOtkT+P1CZ3RyU62W60RWewb1BAsLBZUe05Coezmr
 P7B0OnYVoYGkow0weIzll3CKv3jJ/EVV31ItH+3dOYJsM14yxa0AF6cbpOTX4gfd8nXzk/3VC13
 vldhuM5cefxxRq7hLXxXb0LNCZO9zVatwdScP8JQpbXgYzI5QYh0XTPy6K3GxHI0PCEcQ8V2UH4
 G8UO65tB83foQYA=
X-Google-Smtp-Source: AGHT+IHCQj2W9FI5/5LdK/a6NASONSIJERqffvlA61KQvb6e64CyCM+PB2dteAzEFfaV8kHekAGw8g==
X-Received: by 2002:a17:902:d4c8:b0:216:725c:a11a with SMTP id
 d9443c01a7336-21c352c8145mr62648135ad.10.1737138308995; 
 Fri, 17 Jan 2025 10:25:08 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/68] tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
Date: Fri, 17 Jan 2025 10:24:04 -0800
Message-ID: <20250117182456.2077110-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

In addition, add empty files for mips, sparc64 and tci.
Make the include unconditional within tcg-opc.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h                                      | 4 +---
 tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc}     | 0
 tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
 tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc}        | 0
 tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} | 0
 tcg/mips/tcg-target-opc.h.inc                              | 1 +
 tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
 tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
 tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
 tcg/sparc64/tcg-target-opc.h.inc                           | 1 +
 tcg/tci/tcg-target-opc.h.inc                               | 1 +
 11 files changed, 4 insertions(+), 3 deletions(-)
 rename tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/mips/tcg-target-opc.h.inc
 rename tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/sparc64/tcg-target-opc.h.inc
 create mode 100644 tcg/tci/tcg-target-opc.h.inc

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 546eb49c11..93622f3f6b 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -301,9 +301,7 @@ DEF(cmpsel_vec, 1, 4, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_cmpsel_vec))
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
-#if TCG_TARGET_MAYBE_vec
-#include "tcg-target.opc.h"
-#endif
+#include "tcg-target-opc.h.inc"
 
 #ifdef TCG_TARGET_INTERPRETER
 /* These opcodes are only for use between the tci generator and interpreter. */
diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/aarch64/tcg-target.opc.h
rename to tcg/aarch64/tcg-target-opc.h.inc
diff --git a/tcg/arm/tcg-target.opc.h b/tcg/arm/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/arm/tcg-target.opc.h
rename to tcg/arm/tcg-target-opc.h.inc
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/i386/tcg-target.opc.h
rename to tcg/i386/tcg-target-opc.h.inc
diff --git a/tcg/loongarch64/tcg-target.opc.h b/tcg/loongarch64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/loongarch64/tcg-target.opc.h
rename to tcg/loongarch64/tcg-target-opc.h.inc
diff --git a/tcg/mips/tcg-target-opc.h.inc b/tcg/mips/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/mips/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/ppc/tcg-target.opc.h
rename to tcg/ppc/tcg-target-opc.h.inc
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/riscv/tcg-target.opc.h
rename to tcg/riscv/tcg-target-opc.h.inc
diff --git a/tcg/s390x/tcg-target.opc.h b/tcg/s390x/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/s390x/tcg-target.opc.h
rename to tcg/s390x/tcg-target-opc.h.inc
diff --git a/tcg/sparc64/tcg-target-opc.h.inc b/tcg/sparc64/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/sparc64/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
-- 
2.43.0


