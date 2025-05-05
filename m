Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D25C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4a-0003LB-FE; Sun, 04 May 2025 21:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4J-0001qQ-Nc
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:31 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4H-00036S-Sc
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso3553722b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410188; x=1747014988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGt1YesVdMfmP76X8zMo/3VD34v2vwkTupFXjn4DlBU=;
 b=EUUUaIeRvLllP/Nv9+0pilZo/marW7VCwS4sObBecgKHkzJKbvX3aN+OogjjdOpEVK
 0jUt0eavgg0X41hd00Gy5b+yaEWYQw5+nU2KQsjAadC9fncX9QRs+UsvfwouxGZqAN6x
 j97Tb/TD7AFqD9uUVJld5N3EBB4GjifUf/YisJrVM3jOzFY9MV8icQzMqDef0dbjM23r
 Z4Zi/3SxCgkjViepIhPFPBRvVJDG3wk14lmkvn3OV6DN0GcIQzDTZudgp4uvKjfxuG5a
 gXGwj4g2qYN8OWh/Tfkps1tVRpopvN0ZtXzIvzsGnVwjq+iPGDKGe6YTWFqoFeYKpzIw
 0vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410188; x=1747014988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGt1YesVdMfmP76X8zMo/3VD34v2vwkTupFXjn4DlBU=;
 b=uvpuNTV/4AtyouzLdTy/67BBEffoUONebce82bbMHTHY/YmS1OkJ8zMJ3OhsAUIS22
 qYNLG2eGmbzxiMDZlfhgnnYPmMPIlw9mEyt+kNX4BastCnb0ufgsWbc+9e1O5ASwccPw
 Loy/pNiWbc1weXNOy2spdvUg87u07OIOedExLEa34AZxoW9F4gI3f3Q1x9BJB8sD/D0/
 i7sE22ENfx/zb5CnLcEEL0srh6n4HeAgSaaixIzEcA5vqXQrTdeAucS+bmCaWCcmuVvR
 0UZW/QPz1MWVmkoVu9N+4G19/01LOouTD1ZnOp4ICpG04hk9HwA8ihGXVEXc945gAv4u
 WaTg==
X-Gm-Message-State: AOJu0Yyr9YzkWgnnV+LpuVlKKhOgi0FcPeLUpAm1lhjfMmAyZU9zLMai
 itXguQI6mBe4/DOKb+EilWVVnkrFbXJY2bAi71eXhpDOSHbvDXHZjH1DMAuLdiDy54vKSfVZnY6
 9Zzk=
X-Gm-Gg: ASbGncvDYr4VnzkEKQVo12mRf0Q2qDDguv9gp2MpMl6XxuN48vJGtZ4a5vvO6WVoDwI
 52EvVQSVbyqGuyXvQfgj5eU4/WoNQzAsPo2XikW20is4+bF5WQ8nyEgnkm5+O30sB10wN9CrBna
 PQoLde7MkNthPk4tPnz8Db4Yrni649ZmUnV06GI1SeDH6cdeNvUg2HjhfRwjrR5kJBkrhkWJ5i1
 uFqTfP8Sg8S1RqIKR71Wm55aglHqPntg1nZUOwoQycLShSgdi1JfBKG1J4txTBIUWfUto30hpVq
 u4tkxGpz7MtOIbo31cv9OUCDvDOoanZQmgXD8t7i
X-Google-Smtp-Source: AGHT+IFfSDgDcOkgnrJb7vQb4Qf1FWNpsAlqKI0tyW5JpiO/Eoz46KZiZLg87R1U0m/zOjIMxixIKQ==
X-Received: by 2002:a17:90b:548b:b0:2ff:5a9d:937f with SMTP id
 98e67ed59e1d1-30a5aec1bdemr12746063a91.24.1746410188524; 
 Sun, 04 May 2025 18:56:28 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 45/48] target/arm/tcg/tlb_helper: compile file twice
 (system, user)
Date: Sun,  4 May 2025 18:52:20 -0700
Message-ID: <20250505015223.3895275-46-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 3 ++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4e3e96a2af0..feaa6025fc6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -10,8 +10,9 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index ec087076b8c..9669eab89e3 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(files(
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
-  'tlb_helper.c',
   'vec_helper.c',
   'tlb-insns.c',
   'arith_helper.c',
@@ -65,10 +64,12 @@ arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
 arm_user_ss.add(files(
   'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
-- 
2.47.2


