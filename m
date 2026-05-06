Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B5AFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcji-000190-SX; Wed, 06 May 2026 09:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcja-00011a-5I
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:19 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjW-0007s0-BY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso3339521f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075772; x=1778680572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yissrnBuTWv4fjwd6ejChJgAlwRvBntR3xzr7tIy6UM=;
 b=T+r9boFFcn3IN44Li9CyCd1pHAOgA3zu8sZE7Q++LPBF9QYvyNJe45AOJZi8MGsTLg
 LITO1vlO0myQvUQXT8erbi8/gYi5jaV+Nf8tCFLDta3AHvXfNblyCB+Oel+FxiDhLagm
 j0OAlaqmQ3rd4oz9MNPUJYLf/onWHtTHNp2YaH2UGCCvhtL8QUY46oXSH/jZetbv2sTU
 a7tj8p7KlF0CE3I1dbHzloM80bkcuQQHqTEM+8+FSbCFIpjYaMVtNgu/wDr1LJFwQLpR
 VWVU0xZ+Xtj/SNzvmrjmLijcjlWh4hgIEWEb6G/DWacAKgXmHmOzlccP7spdP6u+Bmg0
 vqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075772; x=1778680572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yissrnBuTWv4fjwd6ejChJgAlwRvBntR3xzr7tIy6UM=;
 b=YnhdM7nrRvpTFk19HWYXcYXS2aC/JSnNRJHgDDd5nvNII2fHSsrkdaPHXxapL6bdTs
 tK1Mb+Q1+kGF9So6V8dP0pue1OMHGLnVNG0yOl/rKzbh8cmnsXoAhuIg0nEFyzAT2RXB
 OBhXABa0GL2RwixCYerGy9y3B4+QofeOTLp1uoWhAi+QopYQ5O8KajfwZqxtjx4t0dDA
 S4x4VjPmbdiiYHjYxRwmyHTDMlaecBWdNvA1zUH0MqNnYfq1T9Onp6ust0upmBiCqMiJ
 KGD7ACQnqV0lCeSmTLWWQikLoJcp4Z5w/qyZW7wmzBgr9Gn4vU1M0STi9fXNuC8Uglmo
 +rhQ==
X-Gm-Message-State: AOJu0YyS6xjJAySly/8Fab3Wn7HWg/JMVZYMY6QXLetC8ucNf3UcXsVc
 OXTu2qAc1zj61nBp3m0YYU7R9kURyhDMjJZebCAok00hYv3GQcAHF8hxk/5kUvTzVYIuJCTYmte
 vjSvd0HY=
X-Gm-Gg: AeBDieta1KKFdLylR2VhXGctd4Yf0Npil9Uob6PJqdttONNinnKtrrrCkVDxdlE0M66
 hphIFhOxSmsbNVKjhCzAwYHTvhu5wloOHClsu6JfoqmoQ8f6F+3SXPT3aIQjxniQtNKHiqbhcdw
 +3PXfliLhmBJwGdQVbwbbBz8fiDmvd/UxAVkhT8vCilc6m4qj7X2VXY+9cRcfX4MXt3FPOYZMq9
 MtEJgzGqqiOPNkS0Ybu7WrLeZ3OqKZBnnInJzGEIrL9P3+5KuqfyHIfCGhwgN4oJvWi1dU4Uyvh
 sAQ/7jLeKoY318u8rOEtmBWUpQJguP526H9zHY57uZieeCutemPcdUBml6vSz0+dE+b4vzIOiEf
 BLCNEc5ZsNtvqCyB7MziuWcutHy+EeQHxaiMGyUXOzmp81Zd8eIVLJuUpHMId9Ye6ME17Bynqov
 1UDOLRnBZ7luNhErQRBP3Y1gWqhuRl6x2jPWj70hTlliYbtz5qtu64JP9yco/VEYvP/O4FeEJAH
 G5ES77e0SY=
X-Received: by 2002:a5d:5f53:0:b0:43e:a69b:d810 with SMTP id
 ffacd0b85a97d-4515d9a0839mr6168437f8f.38.1778075771606; 
 Wed, 06 May 2026 06:56:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4511d8cd160sm8085848f8f.8.2026.05.06.06.56.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 006/110] target/i386: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:38 +0200
Message-ID: <20260506135524.20617-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/i386/cpu.h:2777:43: error: unknown type name 'target_ulong'
   2777 | void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3);
        |                                           ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-10-philmd@linaro.org>
---
 target/i386/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 16de67e5464..fd8d98a4bdd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -26,6 +26,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #include "exec/memop.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
-- 
2.53.0


