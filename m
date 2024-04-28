Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB7C25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1COw-0002yC-Ew; Sun, 28 Apr 2024 17:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1COr-0002xD-S9
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:34 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1COq-00013b-Df
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:49:33 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a55911bff66so469989466b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714340970; x=1714945770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe6fMxQCClP86U2E4tekhsNK+cCefDglZXDii44rTHQ=;
 b=HNN+Gq5iIWXjmIIcx5RZ965vgvLYHRaDbv9Bt0h7mhmt+yP4RFxr00v0IXVTUiB0et
 CQjwZn8BzMp287aoI2n78PNqQwQVI8GPXmzwFN94KCutHudh0bAwK5UFRMn/eW6SNYXZ
 7PfYRgfTNya6QsustMhP2mI0cBhJb4px7YYgWrpYeqbl77xAXNROj2M/dWczsASHZHlV
 b0iEV+Xo6tOzNtYvEC9UYDSgn/L/RQcIcwuad5vduU2YxPVlAGMjt+247gNuA7enqo2o
 L/tp1Z+FHdiXAHwBYiNC+FJCgNPVZLaFz+gu6o4TvowXJpNRS5Z3PXB193iRuv81Z39G
 NvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714340970; x=1714945770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qe6fMxQCClP86U2E4tekhsNK+cCefDglZXDii44rTHQ=;
 b=BT4yJCjFjmsL96KRk27FY3jjMUYN3HcgzKny77Q+rTMnNLhuisM7wXEdVspf5hq2q/
 9tu0USFYdUHZf97Cx2HhCiy8ab4v2AeY8YfqawhANn3h/76gwa1gXNfySGvmvwWJZVl0
 C0eD8RVQ17+X2BEOg0Zy2Z4k6FPu4zwHDlxDh/8b8CcPRzGhl3hRQJ2wF5+N70GXakoF
 z7CC5+Kj0Iry7P4/voeXmbqxXGinUVXBOZZZHo6hvU1NtLfedVIRme7nL77zvHeYPT2C
 M6kzepZsBxfYLP0j3nuyuQzMVs33f6tiXC0ge8OLRzyARBgSeG6UNJXo727PUOgIHXTv
 Wtpg==
X-Gm-Message-State: AOJu0Yxv+jNOaXzzzoPe6AgzdlyL1jDV3miuZzEEKMd9kzlWGuAXKxj8
 L9/+16m4mKFtkTN2BcXT5bs+wSJU5wxpZhfHnIoohhLfedGofFOgyqjAtUFjjGs7OTUwxJLMye2
 O
X-Google-Smtp-Source: AGHT+IGng6OcAXVm/Zchc9JyUN3zV2k47+wd3lxKFJSuijkiRsziXFU6SmiWNHlQwIAbvZm3kkvqCw==
X-Received: by 2002:a17:906:c9d8:b0:a55:b25d:9c9e with SMTP id
 hk24-20020a170906c9d800b00a55b25d9c9emr3557962ejb.74.1714340970620; 
 Sun, 28 Apr 2024 14:49:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 gc24-20020a170906c8d800b00a58f3983635sm1499209ejb.50.2024.04.28.14.49.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:49:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/12] plugins/api: Only include 'exec/ram_addr.h' with
 system emulation
Date: Sun, 28 Apr 2024 23:49:05 +0200
Message-ID: <20240428214915.10339-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

"exec/ram_addr.h" shouldn't be used with user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-4-philmd@linaro.org>
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


