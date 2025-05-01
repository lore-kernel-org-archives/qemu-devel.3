Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E240C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLi-0005bv-Vj; Thu, 01 May 2025 02:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLL-0005G7-8x
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:24 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLE-0007H7-OR
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so849307b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080648; x=1746685448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8qwK/HCEw1i46saViqejeACvzUpjG6Ezmpbs5eELYY=;
 b=fzueKSjTelhuk9bEvqKOrJ8E5IPLVvKfVq2tul6L9W0OQgJGBjflXDT63rMs88xryA
 vzJUx0JjCIlignL3E9Dt54Ek5w8+AnxP2oLh8VSrPByF+rUXGc8x6G/XRE9ukUtjym+l
 2MPUkV7tUMfy6BciGg0mvQkUcc3sV6WY4Zrw1jJkRSjoQQNjWOPNrKhvTxZWZaQ4wSbq
 e8h3WU6O6dnldMNLtTz7iFcGGHlaZljpfgYjRSeHjXSOuE9y96BpPCULwb2CLAX8FdxL
 gMpDib50BDPDtg5KKRs/IPUvtwHuOVUmtLS+UGQgZTDgxx9MypnjXdazBc7FIHtwWakq
 cdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080648; x=1746685448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8qwK/HCEw1i46saViqejeACvzUpjG6Ezmpbs5eELYY=;
 b=k/8nyL2Rftu+BfWTZGt+gUET2uvObLsLwN9E74xViAb+q0LCgYWVBdMsZ1ZFVNRoDe
 p1rK+GdDV7z80A4pWmcfYxwtw5fLKpdtv8K85CERG3wmPqMSNmV6NEJztNs7SuCv7m5P
 jLnOPfcPOGIrn5498x5xzwxcMsNy7vxWDYurt3E1U8mfZEUtSbiMeukJGnQjaI4rAeLJ
 XaRW1YBn3tv73e9kNwvoi/bk72uacAJIszyJUibvF2J+TFy3Z6E7u7oRxsfQhh23Ej6C
 neLnOtPqgFu15u+TKr+Vx5b5eihAggRG31eNYbZjIQcuSBMMXbBxh2WDz41Yztr1Tbaa
 Ni5Q==
X-Gm-Message-State: AOJu0YynRRbXdDYdSn2TkBSpkJiAkhEJxZtCVigBsRr77OoUaYhfux0I
 dLEkhLLevIala8VV6V+1QEVJmLecgkEiFzZOpnNZ/f/7D/fNnXOsYezPB8UB8TQvwTh1+Fkjlqu
 W
X-Gm-Gg: ASbGncu5lc4yF7tzJvI3A6dWVruIw9ewOzgXEZ3Vbvbit6hOxKgIrm1BSSVtHOTyw9v
 JOP94YQqSYr6c/TAcp9m+OwnGrlCeUStEE5kSQWHWt9QA2D7C3KUBxteRwApwXNFlyABNAOa8ok
 bpZUE9LEB5Sf3q2E70lTqqXrZPD+d8bXHTWhOrq2lvFbQFdpiu9HliR/v017naebWSj2IZFGBHK
 XaqQRGNUmNWi/5Ad/5HPM5kA2lOoLG45vE3V+QdI30ptYw9CbXBMMz5E1oRSJdqE8AUznKLiApV
 rFGSGSivWDERfg56ehMopXg46t0zsHpQPxHpaJfi
X-Google-Smtp-Source: AGHT+IGrgUKmcCRVBMb5krJnI6qBInswBqP/CfMh/qvXh475gMhq7CTc84gIms6BVmzHce7FJGFwGg==
X-Received: by 2002:a05:6a00:2e9a:b0:736:457b:9858 with SMTP id
 d2e1a72fcca58-7404777fa13mr2551923b3a.10.1746080648457; 
 Wed, 30 Apr 2025 23:24:08 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 19/33] target/arm/helper: restrict include to common helpers
Date: Wed, 30 Apr 2025 23:23:30 -0700
Message-ID: <20250501062344.2526061-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 257b1ba5270..085c1656027 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
@@ -36,6 +35,9 @@
 #include "target/arm/gtimer.h"
 #include "qemu/plugin.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 static void switch_mode(CPUARMState *env, int mode);
-- 
2.47.2


