Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C41CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ySX-0004Un-Ge; Wed, 01 Oct 2025 11:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ySQ-0004NR-Jz
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3yQS-0000sa-OC
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:09:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so78200885e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331244; x=1759936044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7o+nv06XBHGB51yxt1OEKJBgV9gHbisZFhpgcb1BqQ=;
 b=YUVzAZRCiIkvBfFyTl8r3vmMvqXgpkn9m0laU+u/bmKA4r1IbzpciSeTdnQmc0Tskf
 Ukzj7HaX9S+T9sILSe667G+FKJIuwojtlwtiR1SiUd17RL/YJZGm0Myp6RxTYGhZcSwM
 gQSxVCZqTuolxlgc40nvSRP5QwLJQjb1N70nw2wYC1jxoFLf02F/V+90TeqYiJ1qMpvl
 HN1Dheyn6fbBwBwy4IKdomzGXwIIbSAmZIHqP3Gi75Ze6KqESOb5/v/oCN911kfxLBzA
 tU6aSq0UtD8Y1JTfKNirvraPcUXdvjaGiNTQkkpUpwV0CT0GcTdzwZb9vQOOH98bZjyp
 C0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331244; x=1759936044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7o+nv06XBHGB51yxt1OEKJBgV9gHbisZFhpgcb1BqQ=;
 b=dsrCwmlzKopiRT6I1ySItOGllpi14N/3IMHHh8sI73lVv1hxOY2J1+GSG+t/YiSTWB
 gfrq63JU3mMdzpItz8f+JywuVWPQVfaa3ukhFUiptckC+ZYc+W0UEosxVs4TjNEPj8K9
 aLNraKHW3NEv/E/u+Jiqd3GhDU9Uptel0m5+W186t9VPwQLAThNLaLC8suxy546aXPX5
 D2OBJahAQLu4kmsSig3z8wUmnmVOr17FEO3VF9lXHOrxgmazX7n6VXIQosjzbIPGrEDb
 68MHfm3wdYSZyOKdw3Tg62nW8iUP29/Ba3rWPJdGM9XD7yuKWAGFCEFF/p3ZIOeOU7VP
 8Y1w==
X-Gm-Message-State: AOJu0Yyv/QaSih8pozI9grvLGjRZ3igfQQujmwdK7AHX4LRwInrda3DL
 j7hwXjEXJyJ3CbYUmMNfNdomxlEZC0m8Y9FytgsILr0/ytESPiY8lfCSfcE4boktYVQ1CPF872S
 l04olaIm5jA==
X-Gm-Gg: ASbGncuyhOgIwMXzoPub6Ek6HLZJtuqlBhEzu0wse8pR5wrXz9gCR7tGGTbVT6Ki0eE
 /b1bHvhVYWDVTG4WD60CDRwQ8TkGSHSVEhGU44bisKZSo2Srup6VGX2TdwsDutQh+IcR9/sxwnX
 FSbmpj6BV+kchGTUiQgLB+mI9+UlRP/aiKhFhGN4Z8jXLigRa3jSt3+pKVYE+HdyZa9tv/yDwKk
 JViTqH5NasBI3PEctJiU7UIJfM1++miORYSwZlgPSCzkWLJ83Iq0owcSIk9yqnu23FyDLpQef7X
 9u2HW51HRQyD+k7ZtmItvoJfP82+ETTZHd2qTz8soaKtKXBhxp8TmuRPmWz6Gyeiqbb0RYuSsFn
 ptcnNkaLI7sY7UTaTZ9SSa71UxZ+EbRz2gHhNyKpZE6iL4POaoowHp41LwqI2astwe/hfHzvf0s
 FYDoBLrfc/tXRJ8ardC/sqzqJXrgTgP4A=
X-Google-Smtp-Source: AGHT+IFkQNGVq0nEvAqiHZde44QbZe8PBGEZKor8cq6aaYtJtyGE0kwMUg/fi8b17T+fFK2R+KPQFg==
X-Received: by 2002:a05:600c:348a:b0:46e:3f6f:a8ee with SMTP id
 5b1f17b1804b1-46e67a5c7a0mr7124835e9.13.1759331243991; 
 Wed, 01 Oct 2025 08:07:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc8aa0078sm27313031f8f.59.2025.10.01.08.07.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 08:07:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 22/22] target/sparc: Reduce inclusions of 'exec/cpu-common.h'
Date: Wed,  1 Oct 2025 17:05:27 +0200
Message-ID: <20251001150529.14122-23-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001150529.14122-1-philmd@linaro.org>
References: <20251001150529.14122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Only 2 files require declarations from "exec/cpu-common.h".
Include it there once, instead than polluting all files
including "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h          | 1 -
 target/sparc/helper.c       | 1 +
 target/sparc/int64_helper.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31cb3d97eb1..7169a502432 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -3,7 +3,6 @@
 
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
-#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 9163b9d46ad..c5d88de37c9 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 
 void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 23adda4cad7..96ef81c26cd 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
 #include "trace.h"
-- 
2.51.0


