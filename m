Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173FFF46C6D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 18:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9oeW-0007Jm-SP; Mon, 06 Apr 2026 14:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeU-0007IF-FE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:22 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9oeS-0002Kh-Rm
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 14:26:22 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so3797231a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775499979; x=1776104779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=Yt+TFOndbOhGQ1tNkbotV7j6ix4qCTeKOC3hgWTPpklKQNHC+ennOL14FcLUuBbSmx
 Dtd6lDkXq0W/jFR22uCMgCuAz2A+8FDK+JJtMn2nEJWtYzK/eb58VvzDZXKhLM9Xfmqi
 /Mxi93L12FFoOQG8S7CXZmLqnVzWXDAi4EvlbK8EDZH2iBWdeKbqukWMxTyT7XYAgEKD
 wGRg9OoC+PgJbAMOT5hFJ9aYLk0UW4lbq3+HHiFyTLQ/N7ui2n7GvazrbLf6Xh6S14ib
 +P9i4U4rfCxHLKUZk0HiXm7NRXmFqJrcXZQvnTTx1NJ+N8s02Nr5Ti2SKf7awZ7kC/Iu
 kHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775499979; x=1776104779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=O3wMIISYtcZ17SzfKQTi5F3q5U1MMc6xROmJZNsXuldpEYI+lLvu87yDn+T0jjqotf
 UPxt9xaQCufhaE1q8rQJIm4n71aUphOMnMI6vuQE7f3ssI+MWuvaq1uEuG8ziGmsGkOp
 5LuZXT4uDHunnQQyFtV5F/0AU9xeNuMHHuvcH6an6NGgOuy6lmPgoDsugd5nOTZRyRnW
 wAXCQToLNw28qvHyhaF16e6gMJO6WJOidWt5h4FwFIaNoSqjL5BkoU+9IIKiZf+q+OWc
 YfF6niiDGKb1cCVg60wwWckljEOa1pHqSaeW7C0ZzGNewd5R5AElpKBq+yfmbXAG5FHF
 z9qQ==
X-Gm-Message-State: AOJu0YxYvZB5mg0Ht557daAWRZgEOdUSGbSEkHCmSPVZlhXMretT2qaI
 /3WDEv6OGlifRaCFLhjb41GnDRWImKYJ36O4l3yuCt4hrb/vKFdwTiELf7Z4JvUR77UXRAelOPJ
 z5IfnSJ7GtQ==
X-Gm-Gg: AeBDietyeyNpJVGJx7AKYLzh8ZiLgq1hmAUZRX+DKudE/6/KYxonJZ0/C2yN9/sUPUu
 EYy4CNDMv9dDS/UXBaRUXdtyvfJDECwjJEHaAUEzUDfMmJJqYUZIfxstpjYSMms+PwPPUdLztgQ
 LlabaDNxfWEPMmp/7L0iLTBNk78wxD2lQrZMzxm4INIml5SB8zuub7aL+4ltluEv8vpX0X5YJNo
 1E/StE2D+9enM9zIbj/GJ9f5f1485EmTs2FAhTHibQSeURuUI5OxobLNN/g/VN35KWcMZgv2VLq
 tCEUFv64UeI2gITacwMZ9ltfRjUqhPTCjB1kYDn2I0s37IpGqk7JuJoBR/ajeimDaFZhg5EVJor
 4wU9mQ47wLfnkjH1U1L5Kuo8QUtH0kYdjJTw8ghdDGuwvvX8L7L5vnudXcCisWGY5D1OSuhwofD
 87+N0ClEjR+Zh9DExTTAmusHRW/ABhrFUB6RDPBuqBN99Lz8N6nm9DXbFikTAgmlIf1GUBHDS3W
 V1R0ZSDFckTY78=
X-Received: by 2002:a05:6a20:6a08:b0:39f:794f:94d8 with SMTP id
 adf61e73a8af0-39f794fd24emr4650413637.29.1775499979083; 
 Mon, 06 Apr 2026 11:26:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm12765080a12.15.2026.04.06.11.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 11:26:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v8 02/20] target/arm/translate.h: remove tcg-op.h include
Date: Mon,  6 Apr 2026 11:25:51 -0700
Message-ID: <20260406182609.193886-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Include tcg-op-common.h instead, and include target specific tcg-op.h in
files needing it. This intermediate step allows to clean up every file
(TCGv, tcg_gen.*_tl.*) in separate commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h     | 2 +-
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/translate-sve.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463e..6d52606f9b7 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,7 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "cpu.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..35ad7530c4b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d25ac5a51f..08254b088ed 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 
 /*
  * Include the generated decoder.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bace3fda1a..aa7d72a35ef 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f9d1b8897d2..56ef1e0eb59 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,6 +22,7 @@
 
 #include "translate.h"
 #include "translate-a32.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-- 
2.47.3


