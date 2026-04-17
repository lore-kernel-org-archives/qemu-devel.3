Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7497F436BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmI6-0003OD-JH; Fri, 17 Apr 2026 12:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI2-0003NI-Pg
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI1-0004ru-0h
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so8333455e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444211; x=1777049011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEJIxMfFA7t/v3vI4nCMmg8KNvTmqFUhyW5+C81my/8=;
 b=k+9SaIuBYqdBYx7SbXPgUvgAkB9LjnvX8MAQ8xyx0Qv3oiNv3lozFhqNGZxDMDIoad
 F9W5PdPjxZ5HYtdp0yjoxO1MsFKgSyH3mR4871lZ5DraGgJ8kqFFqVgZfDsgPlPRAAn8
 RqovLjxu2u0OAcPUVSgWnSq3tWDEut6xnrcioneqbUQv89OXEHKP6hqeh7ARdS3nVfY5
 x+Dhw9TpdoI04MRhXW3lJSDL6KTiVte0HUdWcqhr0jmg7bPH5cQ/0Uv2jE45/XixDxO6
 YCEu0Vk8XROWvDRgdBgHKRoU3EAlpbV0/jrRPAAfBokk4JzlgmnbDlraAkBqm1fZaL3V
 XbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444211; x=1777049011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEJIxMfFA7t/v3vI4nCMmg8KNvTmqFUhyW5+C81my/8=;
 b=P0adnzmpMgyiR8v1C3OImY/GjQCNnn+6E9dup86GbaPeUKX9rvXszqagr9L/7oeciN
 ApYW5Dh0dHue06cgjrtFBfc1lySEQKdpyW/tbtvLHuxpQNo9Kl5EB++vT24I5pEN2DQ1
 FKxSQYdPInyP8qKtYWp9dQ/GSo6khR+ZM/8ldCII/qFbr55kEF8FLqRr05/qbRRIOZIM
 8mCI/5C6MXJy0zcUffAxHlCMAcQmvVjX4zxteNUpAU0/3r6X8YVUJT9TwE9BtYmstZs3
 fTD7bpqUKD6c48U5GeDblD0Sh5UwvBdMo4w44RJIA+gWivtbC7AZuscYZROvKazHf/lZ
 ccMw==
X-Gm-Message-State: AOJu0YyL6r8Xiuw+Rk4yjZPkkO3+rOcGJHP2Fxn9yhfzoIJvlXqKY7gG
 3EJmn0hWrLLmmcGKrlJTen1M1qcpyyshcojvHqEvglYHnfeg8yiOQHOdmpfeXyxCxm1kE3fIX/8
 NkgzVlac=
X-Gm-Gg: AeBDievuqtgs9m8tpzqdUu9f0jz0RSCM53FmAOYjuRPbl2j7bsQR5Xm4SMvKXSrx4+B
 BRx671wgWuSs5BlK2Uu71OYRP0WZcfQUaoeTphJWvICk2rGDzsXL1S/s/rAEn0M71q9H7NWHAxm
 ZNBOwQd3fKlfLl46ns7bYfpImkpLM/TcyyhNCT+X8vwdVjjGDLzMrc9owuxoi63Wzp5MK1rrKMC
 9rMg4xLfq2YeNEYhmeuFamnPtmi/rxm+goZJtgwuj2XrQcBNjGPsjmeHrO9W+Jx3LNJb6874UyW
 bt4IaiYNU5T+fv5YNiDCYWNH9I4b8tsMq4xfPJJ4nsxwYWSAskqhCdT8tIxKGoFtUasAt+Flagy
 aqCsDFTjCgp+qgnjjBOErZ/SnmewA48kUhyztB3Y5LQFH9HjO2zvJyWa8d3jw4Uh0/IUU4W0qpO
 zeffOcPWFweDm2CjpTfd6Myn5F71wl41besw==
X-Received: by 2002:a05:600d:8451:b0:487:20ee:bef6 with SMTP id
 5b1f17b1804b1-488fb745684mr44735925e9.11.1776444211560; 
 Fri, 17 Apr 2026 09:43:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1070bfsm58149815e9.7.2026.04.17.09.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:43:29 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A02705F9CD;
 Fri, 17 Apr 2026 17:43:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/7] tests/tcg: convert aarch64 feat-xs test to use helpers
Date: Fri, 17 Apr 2026 17:43:22 +0100
Message-ID: <20260417164328.1009132-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417164328.1009132-1-alex.bennee@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/feat-xs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/system/feat-xs.c b/tests/tcg/aarch64/system/feat-xs.c
index f310fc837e0..e2324cef1af 100644
--- a/tests/tcg/aarch64/system/feat-xs.c
+++ b/tests/tcg/aarch64/system/feat-xs.c
@@ -8,12 +8,12 @@
 
 #include <minilib.h>
 #include <stdint.h>
+#include "sysregs.h"
 
 int main(void)
 {
-    uint64_t isar1;
+    uint64_t isar1 = read_sysreg(id_aa64isar1_el1);
 
-    asm volatile ("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
     if (((isar1 >> 56) & 0xf) < 1) {
         ml_printf("FEAT_XS not supported by CPU");
         return 1;
-- 
2.47.3


