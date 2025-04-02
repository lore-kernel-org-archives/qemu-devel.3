Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B4CC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06VA-0004g5-Sz; Wed, 02 Apr 2025 18:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06V5-0004ex-DL
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:23:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06V3-0002PI-Mz
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:23:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso1654405e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632636; x=1744237436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bumN4/Pb+TslNnZNvPYQc/X9CuHJhfIAJHquLppK698=;
 b=n+Fna2/+t8qjKhit74mpD9Cqe6AtVirLI5Ybr3pib0BBIuM2EH6kS7Nmf4wiZMJ2op
 EauMxRSwsAzcpOwzRtH/ZNylemdB3g/pc+1lpmGTruV24hv7g7lCSt6K24h9Ri7VQUA8
 5ZuGqzqrnNmblgN6uoP7rxVbW0dGNo/gHSnt6fR1AyVHsnO430Jw9N/QwsE0aGkcyhuo
 ImQVTWuwcNjDiHXRIJ6RGKbO2my63KIHEb36d3/x0xco9SV+GJcvXhR64XRw4zJaxD07
 PdijCeKGju3ucgYtczJ+apKLgGMWsLfSWWGGN8mJoqvFpcKmBD2JXgho/htvLW+tgsGG
 /Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632636; x=1744237436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bumN4/Pb+TslNnZNvPYQc/X9CuHJhfIAJHquLppK698=;
 b=RWxyyPi5AqP3TAK6WNT98gc3WCmj8jAIfSBRcEoWcmjsE9uNb63Czczxm8KquYxdMy
 n23+a6JowBpe+dYUQmqO0J03t11ngMTqXhzo4ViF16wKMjrQNUSas/zfPhrCGo6y3l0v
 dtJU+AnJcbDiSPdcXLkuu0NamVQybRrmYeim9kYoeoP9vJMaFKEngnY8OfsffLadlRpt
 j1t8QgV/tluQ/01yk3HPSSms673oRHIzRmLtc0yLTv7cut6ZnyQvDxgk9XvP1jyVSmOJ
 2pvqB7Jen9t/OJpswDrxu5bV77pxzgadQ0OTGJSo5seC34yKA6l4G+XqKmJ559PAgEGo
 4amA==
X-Gm-Message-State: AOJu0YwFUoaOXegxtn6nu7/c/C2LBZQcxjL/rCvDdCoRMLn6ofgl/9C9
 ylVYaiXj2TLtyhbXluj3/7fVbNMtCZMf6KQpi39tfeMo2J2tkdISmEfly2MBwpHTHPCrLvoZ556
 A
X-Gm-Gg: ASbGnctaTRPMcUJOtpEY/I3TGGdxOz+6DF4EOKsTu1xYQDrP1CEnR8iHAdUNlM/wRYe
 9b3463VjtQXt5/4wWfrBzxd3uTYQCKtjmYQjqFH5BU0fjQcSj+QFwW20pGdyev+vgGBoEsa2gpn
 g9rWHjn0HladJyC9II4HBPiAXjYJYAaFfnXowgUqpEs7qYUZpqOhMKgmboEo+dDA8QJ1emal6Pf
 mHlgum3/tcvLlo4XAcGkQEENui1YydiOy9swOYsMh3MSkK5dEYxiuDB1pOQKzVsyZLaH75p5h/p
 e6yNhu3XJSP6HQ8O8kxS9aL5bpFemQzDjdsMgNtDnWVWs8TaxgKKFuJ7PXcQP4IVH6I8Cvw57PF
 1BXJth0ptWmPuuGOvEqA=
X-Google-Smtp-Source: AGHT+IG9Cg/hQpGLpLdWHC+5IgWUZmXPRJmMMfPhO5xc5sXHo15gQnKhatfKWY3MxNWlbkmdmtPfiA==
X-Received: by 2002:a05:600c:1d88:b0:439:9e13:2dd7 with SMTP id
 5b1f17b1804b1-43eb5c180b8mr45591705e9.2.1743632635736; 
 Wed, 02 Apr 2025 15:23:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3669d0fsm158475e9.36.2025.04.02.15.23.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:23:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 04/13] target/arm/hvf: Include missing 'cpu-qom.h'
 header
Date: Thu,  3 Apr 2025 00:23:24 +0200
Message-ID: <20250402222334.66511-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

ARMCPU typedef is declared in "cpu-qom.h". Include it in
order to avoid when refactoring unrelated headers:

  target/arm/hvf_arm.h:23:41: error: unknown type name 'ARMCPU'
     23 | void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
        |                                         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 26c717b3826..ee5545f2d10 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_HVF_ARM_H
 #define QEMU_HVF_ARM_H
 
-#include "cpu.h"
+#include "target/arm/cpu-qom.h"
 
 /**
  * hvf_arm_init_debug() - initialize guest debug capabilities
-- 
2.47.1


