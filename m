Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13868C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kQt-0002nm-Rh; Sat, 27 Apr 2024 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQq-0002md-SG
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQj-0005Md-VC
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa2fso16883125e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233456; x=1714838256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0W1pDBAxPisymJilpn3Ssy5zQkizzAMOErHk8we8co=;
 b=kDFv7Hw/dPe2Ja2cQaBXauxYS03cifPAv1Fps3Snf5kCYPFqYvYDqos8rU11pyydJI
 acDSCKA3/WY4Tl5tBMrx0GvdKJIw9ZCXZVc9hbRKfZioyjr1efiHjs5uOOWxj2ZOBx4i
 L/NFvQMLHR+sAdqF6bbal+5dyDXXRjwUg7R8oNTMcWScTzUTb7PpfSpBQTvZG3gCMiEW
 tEHjPf4lsAOz24raja6kPk4hb6+SgK5e297pBy9R5r667IvgCk/0Hxa5WbhkRR+NHShT
 YD3tV4sw44T9J4RzTHh39qGgb9yiLYzoVnS7O/nOsa7pEHA5bW8m1b4+We+ro5zdhzQs
 LDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233456; x=1714838256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e0W1pDBAxPisymJilpn3Ssy5zQkizzAMOErHk8we8co=;
 b=ESpJ/1hu7qwwSU7mCijCuOkYoVeyx3jcdzvdlbAEuxY2zzDDP30XGn62bOHLd6QG/E
 wNc052j+UZOmpj5Ge8f3v6N9xBbMTh3nB3zyRBdHwYDUx87LNlv4M0I1AfDb0FZFCmv5
 eN3vOnPqq+WbjkW36Qk25uYX34zZg5Hzq52ZLhCmgxZ97NZDxLle+C4jltI9TfKLnm1P
 F0/P8QwDtYMP58tEJV0+xGoNdzlgcAh2mnc/KMrhsYSxgN5kDsgwabdQUTd4U22JDv4S
 YvxljNx6SEhDdys2+hYlOBSeoryfDdkcfZBvkkifhDtLzQFvNlP5RpqVlLNH6o6UjSM4
 6a9w==
X-Gm-Message-State: AOJu0YzPFl/NRkBjCEeViOEOiUG7Zu/kGts8k9hBDO+2xLsb/5k+jwXF
 maxW19nF9JT9zJuCaPbhgcMnawjeJojK+Jcl6QukzJAzo9dke58sMUXDMBILZlh3c6VU8uRpa4H
 ftI8=
X-Google-Smtp-Source: AGHT+IHg5GsIXZWMaBHNbipeUg1Lv4lS73eEjNaIK8ro5ZeVKRlNV4wGre1OJ8vqFYQvSCeqvFP9ng==
X-Received: by 2002:a7b:c414:0:b0:41b:4d5d:9687 with SMTP id
 k20-20020a7bc414000000b0041b4d5d9687mr3960968wmi.24.1714233456184; 
 Sat, 27 Apr 2024 08:57:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 bh18-20020a05600c3d1200b0041bd920d41csm2549565wmb.1.2024.04.27.08.57.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/14] plugins/api: Only include 'exec/ram_addr.h' with system
 emulation
Date: Sat, 27 Apr 2024 17:57:03 +0200
Message-ID: <20240427155714.53669-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

"exec/ram_addr.h" shouldn't be used with user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index 8fa5a600ac..eaee344d8e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -42,10 +42,10 @@
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
-#include "exec/ram_addr.h"
 #include "disas/disas.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
+#include "exec/ram_addr.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
-- 
2.41.0


