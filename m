Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C06EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2V-0000CU-Gb; Fri, 25 Apr 2025 11:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2G-0007WP-S9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2E-00049S-ML
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1efbefc6so1734435f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595133; x=1746199933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EELvltSoqjycSzfTXLLiwOA4/4MwtemDzO18DWWtAns=;
 b=jCDc0tGFXToPeYY2Fk8uxQB1wSd4vmXbHw3SgQn7kIsomeSTNBG6+3NN2yp2Dpdeqn
 E0CJbLWRMCmGLzThzWsoMpXca/IZq4ld+XvmeE0bBs5xGa0L+dbDxAH/8KI6fqVYM+Mf
 dPI+XWcN0+l0Ep/jckxE7sYOrnmBfHkoEWNIzg3B/O0ZQ8wDczri79p1K7kT6G9NF5MX
 E2xKNGqqpCF49lgYEfXH3ET37TQHwZBH3ReH7oyT2UzoLLscWmpBvDExvEUfvxZ/5CaM
 2U2kHDx0eM26EOICLoM6Mv0AhTz6eZtCfCdvU3a+IkgIjmoBuXIJGsAe14DZm0obPW6D
 OAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595133; x=1746199933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EELvltSoqjycSzfTXLLiwOA4/4MwtemDzO18DWWtAns=;
 b=U+8C8pq4/bwjWJ2T3WZeKVRe6htMv5nyPaIf9B/rahzszyKgj4q9Al0HvqJmxLADcl
 dHI3I5Q6fG4w04wN7wVfKlcsypWrhvFE0ce4j7/r1h9q1uB0586NsFBPCv7s8+a+g1Ua
 xZKC0ZOXZGVPTPHdG9sanibPdotomk+nOoecoXua4QwojRW5P4WAk58ZrSMOfi6RbMpg
 +SIGQF9nhV6BfB8bqaXVGegGi0CPtL/clgak8i3zJ6XXwcXn1fTPokANz9kMuGumzGsN
 sfsdGFD1FVDkMEggdXw0/L9AgnqL+ScpLP1y/xfJORBym+reeSrGBy3NvXbcAcWTD+pj
 FTcQ==
X-Gm-Message-State: AOJu0Ywg0RZVbioHIyIsJaC+LrG6S/fgXaSwY1y8NMZtiqYrgr+yT2vU
 5ULYP6N/JUXRHMDaCfE+ZqEkrm264MYZ56tgBVfXOZz+jqHCXmO3LwfM8BKdaChhyvc9O34QHsW
 R
X-Gm-Gg: ASbGncsifW09oTTVTc46cK1FkBu8LUV7dIoUevYKq387ZS/eR/PPDc/ukdFT7dfCNGA
 v7pI8Zj0wBnLkC5Gh24xairtmd/Izui3NEB3F/t8NnBNIbHu0tkWod+v1jwecGjRXWIi1t33zxB
 iQHguOxBqBAUoaWEuKDPbdasqjatjdwZLcEQxEGTGgVO6qFvcNiVxyJoP1QR2nN1XkwDg2tTn1J
 JP9PG5Zkugv86zez0R/91v3LredNWhJq5kadasC2dJCU6L6L0x8L3bSXrMi6KKFwfnzIToKsPL2
 0uVk+Vg3i0FViy8g7WJk0hLiMrAQtFIIZkYbt7+knEbBLvUnzkgzNvDYnMmfrRfg3JYsoZHi+wi
 sJFnSgU38XZtsT2w=
X-Google-Smtp-Source: AGHT+IF/RD7nTh5HmJo8iKoAP1f6SNpFHcFQ9Ov7medVI9U/IroALc0zZZ6SFtpMStMfYpFXRJ8VgA==
X-Received: by 2002:a05:6000:402c:b0:391:43cb:43e6 with SMTP id
 ffacd0b85a97d-3a074f3a152mr2071514f8f.51.1745595132765; 
 Fri, 25 Apr 2025 08:32:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc1842sm2730638f8f.54.2025.04.25.08.32.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PULL 42/58] accel/tcg: Correct list of included headers in tcg-stub.c
Date: Fri, 25 Apr 2025 17:28:26 +0200
Message-ID: <20250425152843.69638-43-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
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

In commit 3549118b498 we moved cpu_loop_exit*() declarations to
"exec/cpu-common.h" but neglected to update tcg-stub.c. We missed
it because "exec/cpu-common.h" is indirectly pulled in via
"exec/exec-all.h" -> "exec/translation-block.h". Include it
directly instead of the not necessary "exec/exec-all.h".

Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
removed the need for "exec/tb-flush.h", so remote it too.

Fixes: 3549118b498 ("exec: Move cpu_loop_foo() functions to 'cpu-common.h'")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Message-Id: <20250424094653.35932-4-philmd@linaro.org>
---
 accel/stubs/tcg-stub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index b2b9881bdfb..3b76b8b17c1 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,8 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/tb-flush.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 
 G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
-- 
2.47.1


