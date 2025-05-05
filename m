Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC42EC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57Z-0006zq-1F; Mon, 05 May 2025 19:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57I-0006Wd-6X
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57F-0003gu-Nc
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224019ad9edso75535025ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487252; x=1747092052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=GNgVe0lzPKuAUOzl/SRUzO6gmfdqWKzmDEZ895j9MqyKrD4BpyRcEGnyvaOAFtrhjQ
 bQBU4H4+6Tu0oGe1JqreVZcrIaqRIurs01q6+g1Xz+g7YfbnwKWbMfWDOLACHsWerVud
 ks5wMx0xDyNY8vz5ryxZiduK/ejI+ODVmDS4Oud9dIHe3TS37n9gNv6jYZ/cSzOldRP7
 RdyTTNiscnXhqHO57+n0PLVFpml7X4fVcxMYYTiv42CtAYaXeZBk/kr86xfPjAs/noIs
 /6NNCJxtS1kY0WefdmqtvgChOeJ+LbZOfmncVY1y5/uwiurxnaexcjr+UkJVRKoslO1/
 aSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487252; x=1747092052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=HdhuUPznD+mbHwub+Eo0SYzxjLCU+0MdUPkuLlj4kL6fECMdTdtSPIoP+pxkAXpGuU
 lURav/G9N0uWt4fBqb13wKggRatTmsOkKg+njBxjml3sXVcwGI9toHXgx4JKAydT8Jvz
 FQC2qDilyipHHM7Ej3HtgC90ZCnuimhEkH2JAB08i0owWxXxIIJTB2LrQ4AD8n/A93rp
 VSqnSQNNzN6ucmbifmarBq58mdTAx/Q8CqA5JQgCIiaCVwfg17JYIV13Hse1R36Bxb9F
 3efGGvtXmHk8eEU9Wrk436LzN2LyZhaSLc0bAIdwt3Oo+Ochhjs+Wt9Eum6ZPn79MODj
 sGhA==
X-Gm-Message-State: AOJu0YyVa7Qk2+TPWZ9cjEWp02g2KquXoIg+jEDBgdaGZKupWCykhCsX
 NXeDbCokHRY2vuzglbRIygSoygEnymXpqX2kU8ft0ISkFMhiUNneN3GXQ4M8nLOdJkxEwvrTapB
 xgxA=
X-Gm-Gg: ASbGncsIWLEgcw5A0ajyviriM/e/pOC5idS1LQu/9ZUMP+P7KWbj3Km/NtTsMwJ07Ah
 AgCs0hxtVXtjZGBs1rqJ5nR47o4dtgqgwPB0Z+YAZNJiJ5Y9TpQnmiYJXnEhEnnjHhh8Wa9IsOB
 UvAw0WuA0K6m1DEor2PCgzO/psLfeChfE39aDSUH9GGHsdMUkRhFeEujDjzFkfQfk5oqCynTk3V
 NZNS8vMWSIcCQPwJN2ajSimkazAGKnxsKVmUt6TJy128dBDC4MvxJsaLcregYQI+k8Hi+QHiejs
 pGz0orwiYIWFW2ZvXQIChrNQFFH8/+yejMuVCKTw
X-Google-Smtp-Source: AGHT+IFKCrJfIDo/31BgGwDwgpaARmni7MMqsmZbFLEssmnSeYuJ1cHa2Ln0JoRRYGFqfKT1x0RIAQ==
X-Received: by 2002:a17:903:1ce:b0:220:faa2:c911 with SMTP id
 d9443c01a7336-22e35fdf665mr13176195ad.14.1746487252440; 
 Mon, 05 May 2025 16:20:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 36/50] target/arm/machine: reduce migration include to
 avoid target specific definitions
Date: Mon,  5 May 2025 16:20:01 -0700
Message-ID: <20250505232015.130990-37-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 978249fb71b..f7956898fa1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -6,7 +6,8 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
-- 
2.47.2


