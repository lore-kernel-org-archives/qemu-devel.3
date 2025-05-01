Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C88C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLf-0005aN-Jk; Thu, 01 May 2025 02:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLA-0005D1-8L
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:14 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANL5-0007Cc-5k
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso874757b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080646; x=1746685446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFwygMkwhCb1ZWcyfCzBjn8oVpD1D7KxEaoA5Pyvsy0=;
 b=F8AGLvo970U0hTldPL4TwHqKRgDkhgD9UOLMkZnPY8ZBVstiKdVzJzznD+tXhM3TrM
 Sk80h4SvDMX/Ssw2CqGpq+Sux8VmE415k3Xf8pFnpl9ChWSM2QUd22sHwlFxiSKKFDr5
 +YaRxGPHmVOI3mr/Y4gQpnBc7UFqSRx3nhYp75wfIlCl+lrFfq9Xr1q0SmRUbXafEBSj
 KD/sKJrMKn84kuAsDmLMtYge6lH+dVYTbwZt9eKPpRB1R4uCjk6fFyN4wIJ3hjoe3IIC
 PflPBKhfshg2c4JkRQGw2aLb/I38Tw7ULGJ26GLFToTgF6RTRfcjq23zhawU7ODz2ASf
 8Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080646; x=1746685446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFwygMkwhCb1ZWcyfCzBjn8oVpD1D7KxEaoA5Pyvsy0=;
 b=nqtxw1CwD1XLiPdqEb897Nb0brp/Gl9QZ+9ta45a7vlPku+74CvEoIiLw5TNHnS5ik
 2AvXKDyeffcSMLVMQBwxTv2gU5rrWtuwjG9e6IpHsaDQ/zZLxMREAuG+x1Ob+FwO3lU+
 oQmEUAscinQXFij/UqiOx8FtxUu/jgCWDEUa1KGyT/CVl+eB+SqlVbS/P9dK6SXw09YU
 76ii8kFAGhCdPV03o8EEEIN35xSPoSv7tBSgUOUJgsft2PToKSPSr9cyxeKi8ebZ74Kc
 pcWegGsFk5K+85+36UjjNQDBONTheARvKjmXVefKO3U7UDdUW4HSihcMTygKFUUOUkc5
 WUXg==
X-Gm-Message-State: AOJu0YxMmcgUUoTy+jJLp5a8SutJTIgSURqxWItmD1oN0YaH8wAHj1d3
 6+LjY3wQLCK7KCASJDE/cHqEaAvKupSfJEYL/8rzyJFPfEIGrV+DrdtNyCfquS60n+durvzrgoH
 X
X-Gm-Gg: ASbGnctD837UgmMAVoIeTB24+seXqcSFDtkO6cFEz9Pi13F7d/dWLZWBWzHW49avvE1
 gi80CAIzQWd5IvwwbIm1b+eyr1N9hA9IyTBQjcryyGxDSd4Yfs29vrOJkzJPcsGMJNcP4SlSypN
 9rjFn4C/UO80kn+kYlgCi+k2QfH87peZRs+RxncAOvjFOIZUKzA8N8HfdggE/9cP7WII6+/8Z3V
 NAg9VA8szZStM7cduS7bv9NQyJCF5tg1QmjMwEjJFZTK3VbqomRmk2LFbIsgp7nqQLgd2Q1hWY3
 8qbkjzqzzzN+Ygb+noNKo89ci30RK6xMN0r8bYW+
X-Google-Smtp-Source: AGHT+IFADJB2FcXdHj/QO2Pd1O841YT7LfIvcgx8grnyZrHZkJ2z2++hnDO5xALbvSxtkTgFKdc8yg==
X-Received: by 2002:a05:6a20:7f8d:b0:1ee:d8c8:4b7f with SMTP id
 adf61e73a8af0-20ba75f00f2mr2951744637.25.1746080645877; 
 Wed, 30 Apr 2025 23:24:05 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 16/33] target/arm/debug_helper: only include common helpers
Date: Wed, 30 Apr 2025 23:23:27 -0700
Message-ID: <20250501062344.2526061-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Avoid pulling helper.h which contains TARGET_AARCH64.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 473ee2af38e..357bc2141ae 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -12,10 +12,12 @@
 #include "cpu-features.h"
 #include "cpregs.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/tcg.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #ifdef CONFIG_TCG
 /* Return the Exception Level targeted by debug exceptions. */
 static int arm_debug_target_el(CPUARMState *env)
-- 
2.47.2


