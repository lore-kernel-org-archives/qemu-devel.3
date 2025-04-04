Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE06DC3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pdx-0000ns-1u; Fri, 04 Apr 2025 18:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdm-0000jH-57
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:36:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdk-00080d-9c
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3996af42857so2447382f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806153; x=1744410953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jtO3IMgAIsSiYXYuW6r2DQvOHBc5NKddZ/ZsUiqplI=;
 b=gY/97FX/JAwG1vofcGYgw2JYzMlbqQgXvusJxZfAsPXrhoAD+NPt6jlb272k+m0Qyc
 80MMeELiwEyhU23KgpS5s1LPFAze+6Xf0yd+r8tUppihJASvP61KclU5+Dt3h+axnkth
 oNv8AlHfY2IfF/O07Z8z8Bso232+K+Vr0nM1pzIfHDpOfx/ssSfc4HNDC2ZZhwM5W2EE
 10+v90xOUo54VU1dJVo2L5lr0OBvKKGdCai18ncACkcVsb/4DXTZMrpL4FfDr6YhtsjH
 poY5hWGsAGav/6M/2LydubogbKnSyB1JQqeglsDAEWr7R+458ev399wHlyd/yof6vEfd
 q0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806153; x=1744410953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jtO3IMgAIsSiYXYuW6r2DQvOHBc5NKddZ/ZsUiqplI=;
 b=Elwyo7IXZCfQrOoC6l7fJAKHha7PhvSBJLwBWnvO6mY9QwPbFRLhy9XZ17wGghKxU9
 E9DudW6JhHF+bJV5/9+9dOaOTUhv8f5IeBEcqJP7g+LnGRtr6hkJTY8eaON9QSaXTECd
 Gv8OpgG+FWzhLDzWXPY0iqQTqfXsYnAsydTtsvIaKenQepa06mYd1tmGTSp+iSB65/1t
 UDGnjRBIc2qCPvjh4BpnYCHrVKj6OXaEKddhPBK9jOdoNf55l6DCkc6WFvwAQOahUPBd
 HE5AaGarG3HBDxCmZF2byeVqYkN2XvcR2GHqft37tVcB4JQB78V3v2Wkk+xjCEXHRU/8
 3JUg==
X-Gm-Message-State: AOJu0YxFwT5LklS/wyuLGRqcQdwjJNF2sf/1d9l055WGWg3woxFs3d5l
 e6CfJt/ISD2mwnLoSYPOoJNFl6PcFdaHh3LvZtKXLbWUvpV5bK6KNkfsPCqtpyiA1T5vm3KfNaK
 e
X-Gm-Gg: ASbGnct5PIO1xXxKWFnpLZsCkfRTQds/szvlBPbCs0nGiqd1IaHmuDmArPTS2tnv3ik
 pWvrq0XhNRrZApIeEvzg1Bdd+bEmsrdPXVj9CA8DAqjbX3XEu1um8h+XSW/f/6sW+vdnEXXyW09
 zYxYSufdynlGPhlP1NdMiUzg6cgpkcQC1RBgwAT6oOFSvffwmyII//GR6UrZhPPI/9TCh5leagF
 pTbYhq38touG8PxYp8tJunATVKNLW0KiIdRCmiQPW7FBeHs0IEYNzkHjPwBZRlvxTTooZU4qTK7
 /H/AO+bEU3hoUfEjM1FYJyXBO5QklKLdxs2FomJWuac8iJIfv30KaWIaNaV4OnA4KJKxvnP8vpa
 WnnMS2yX+6OWDZ02hrJ2BVGQd
X-Google-Smtp-Source: AGHT+IFtP3Q8VM0usKUJUl+GjkENTtSEBAqcsIQRlmQpArlfcsMsPs1GBIB7BAFhIb039iAa6teSdA==
X-Received: by 2002:a05:6000:400e:b0:39c:30d8:3265 with SMTP id
 ffacd0b85a97d-39cb35b8c47mr4130816f8f.15.1743806153554; 
 Fri, 04 Apr 2025 15:35:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7064sm5495689f8f.34.2025.04.04.15.35.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 6/9] target/arm/mte: Rename 'mte_helper.h' as generic
 'mte.h'
Date: Sat,  5 Apr 2025 00:35:18 +0200
Message-ID: <20250404223521.38781-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

"tcg/mte_helper.h" header name is a bit misleading, since it
isn't restricted to TCG helpers. Rename it as "tcg/mte.h"
which is a bit more generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/{mte_helper.h => mte.h} | 0
 target/arm/gdbstub64.c                 | 2 +-
 target/arm/tcg/mte_helper.c            | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename target/arm/tcg/{mte_helper.h => mte.h} (100%)

diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte.h
similarity index 100%
rename from target/arm/tcg/mte_helper.h
rename to target/arm/tcg/mte.h
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 64ee9b3b567..65540cffd2c 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -22,7 +22,6 @@
 #include "internals.h"
 #include "gdbstub/helpers.h"
 #include "gdbstub/commands.h"
-#include "tcg/mte_helper.h"
 #if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
 #include <sys/prctl.h>
 #include "mte_user_helper.h"
@@ -30,6 +29,7 @@
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
+#include "tcg/mte.h"
 #endif
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 8a6e6e4719d..b70f23e2047 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -36,7 +36,7 @@
 #include "accel/tcg/getpc.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
-#include "mte_helper.h"
+#include "mte.h"
 
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
-- 
2.47.1


