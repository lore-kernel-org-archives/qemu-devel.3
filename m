Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193E7C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kz3-00007Q-9r; Wed, 23 Apr 2025 21:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwo-0004zU-D1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwj-0005TW-Qs
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so335400b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456408; x=1746061208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQn5pEpTklz98PI0kmgU6Xej9Zd0Hkqt6ZpcSg4eg/g=;
 b=iCn1l2edFt1u4td72apjz7ZO3Wjq5PBljVsRqxNn5WEKc6N14ujFU8uX4WD+k02t3V
 SiiqZkVBPmzAMOm/ERTmQbL8iI3AC9dIUc0IV9/iwSv/5SAKQtR90IKRpSCsGZmLSKSt
 /j8gBmg320sXmrHOfldzEiny1muef5DA9JfrjnytqJlwwK6tbJIKxA1niEWwZfenB0G1
 WTiTlYA/HVpVc7z02S50V8rEJkyS0QYI3z1P0KR29Y0U9PQD0dJKfs4/f1cCQi7Pyt2Y
 CJT1svxCvZf+Rho/7/mvCVzWzB6C1rkXHq446u6chSNPTB/w1sCdcm5NfSh3vFPELKQP
 8+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456408; x=1746061208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQn5pEpTklz98PI0kmgU6Xej9Zd0Hkqt6ZpcSg4eg/g=;
 b=XbDwmTQs73krgb/hzTZBURqueRX2dj85Gmpy6b9ZT1GGp0DN2IUBEzSVfIBJf8GbnE
 imyjLsBHIJxRcFEdzsIlgw/1l2F7fbuginuRE+2Ya/fPjhrHHRwCT2eIv+uUi+if/wI0
 xpy0PS6qhkS/4pCykgxjXmD8Io0uBzqawJ+4f9VnnJ3HcLMrWwTYJ2EXKrkVKxazkyFi
 diF1puegrb50jnNmi8vISvKvs5Bgihgo9IUdUc/x2umcUbnqykoL9hCc22WluNRwxmDP
 rNRH2OzuHxemfCUW5uycvoJIaV6by88ll40F8S0ETmQFKxk0lA1znPITtz75PlgbJhFf
 DTeQ==
X-Gm-Message-State: AOJu0Yz4jAhsyXHbSpl4mq+jWimEADGd8arJpvbXrHtoMi3KLfIPM0As
 roonV9GXRMRViT9FOX2FOKV7nXDkW8R9lSlLPhtunrEJ70UW0JTfuTlui9Y2qGGb54WtGg3abzn
 s
X-Gm-Gg: ASbGncs19fajSo6EWviu+5U4bBIAtzA6NPeWSrKUDRYP2ZMCoytIYRReCEW7Yluz2SJ
 iOCgS8lY8ZkNw5kt1lISizhIq8KDFJVXR0762b3R60jH4xWbN5hm5Fkdn46NvYCNvEoykLs3FpB
 cB7d1bWBNJzEt9rGEvI9smIcOaMhaVFIt3AwbE1Lbvmkie/y8twe3BfeMHbaQApBSGl30GfG1AV
 HU/GYLDMwifohjw0SxgmWwYJ4LW8oaIAHv0zj8CXXz+j2lM20Mlx6Lqx3RgQJgu64gn/Azm4KAz
 xXQJknBq6J8caNap8+1i/KkrDsXfryFvmy6Pj8Del4Bh2g3ir/1GKo1P8lAM+0vFSbdsmcu6lrI
 =
X-Google-Smtp-Source: AGHT+IE9OPWPDEtWww4pm4MsoMNGe/pw6xBPtCdkdwPgGxEGXdsu9E/vrfmOevggNiDHc2Ull0QKkA==
X-Received: by 2002:a05:6a21:918a:b0:1ee:dcd3:80d7 with SMTP id
 adf61e73a8af0-20444d1f398mr1014137637.0.1745456407956; 
 Wed, 23 Apr 2025 18:00:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 127/148] tcg: Include missing 'cpu.h' in translate-all.c
Date: Wed, 23 Apr 2025 17:49:12 -0700
Message-ID: <20250424004934.598783-128-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

tb_check_watchpoint() calls cpu_get_tb_cpu_state(),
which is declared in each "cpu.h" header. It is indirectly
included via "tcg/insn-start-words.h". Since we want to
rework "tcg/insn-start-words.h", removing "cpu.h" in the
next commit, add the missing header now, otherwise we'd
get:

  accel/tcg/translate-all.c:598:9: error: call to undeclared function 'cpu_get_tb_cpu_state' [-Wimplicit-function-declaration]
  598 |         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
      |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ed41fc5d0c..c5590eb695 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -69,6 +69,7 @@
 #include "internal-target.h"
 #include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
+#include "cpu.h"
 
 TBContext tb_ctx;
 
-- 
2.43.0


