Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E717C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 21:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb5Bv-0004xa-Fi; Thu, 23 Jan 2025 16:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bt-0004xD-TT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb5Bs-0002me-DK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 16:56:45 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so819956f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 13:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737669402; x=1738274202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHD1U6D3WvJOsbcmnGXDiHvtbFUdg0u7emrKOSlHmN4=;
 b=ZtNq3ZEklS8e4F1uJlKdmF6Dki/rlgEt6EyqLSwNrnBcUsRCunibhEXafPAAtanNKc
 lEK+LUT0Po9rNn6PBqr2wEpRdt3cR2o3I85akwCy32yHahfmYh+PfU3XbVs5i5Q2JIN3
 OWdM8uL8fd1yj8ulzmN51eHKdNTw/J8jDv3wCgd2NF2EurnoVuGhBEpUEDTrWElcF9PQ
 b/ZfAis8ml7rEVCSo+xjUuwbbFW60490Gu9+6EMxY44v85wvevF0LQlzApxgIvm0sv87
 XFpTz8OMiDCU4UKRdp1vOtrBTS0TPWvXD4+HKD16ZjRku5/hLdDERC7o5vmie6wRelQv
 K9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737669402; x=1738274202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHD1U6D3WvJOsbcmnGXDiHvtbFUdg0u7emrKOSlHmN4=;
 b=Q4icjzlnB9OLccmEcin0N/M/4nDjxh6h0D+etkeyQst8bfXdE/wgDHKp3T8s7SQM1P
 SNcPBC/0noy9kN+31E03hytVtXRBji5146Arc7CZr+ushm7juzK/ufJwTKCprsfH14h4
 KvZSrLg1ucgojqR/6B9xk/10JrvMBvZLkaOeMgeANgDaCxZLo5g6YXvwVX76sxDbWFly
 H6ZBW/4xSgHW9N4evrYMePFXcwWlNLA1WCXXq11+bYIqR+IQagky8AtNjbwAfInXtS3P
 7CDbrK2kEYefUF3OvBNqDOfdslO9nDkJFByrwMEt2HCpul4FUNlQX7nb35L5pXl3+WGc
 PeuQ==
X-Gm-Message-State: AOJu0YxMqrfRjhs0Ae+86dI5aR16sJ7VtbKSHG0n0bIY1VJzi+y5S41t
 yCiaCqxcOoTck9WzrxrdDogJbcH/1W8pE4yrfFyM0wv6h6YZiyzsItVBeoq6r18biTT6TxvA1Wm
 Lzl8=
X-Gm-Gg: ASbGncsMStdWzCy08+Y5lH+rxuvRqSNvRmDSGfA9gYMaKPw75VVvwvpHwI6s0U7zepa
 CYie9P8V0wV4fkdkRClwQfmyWqvfZDQYAuxJ2CL3cA3lnn3pvgrpnJtCbOjzlMnb+ExzqgmEQK1
 xUoPMtOpoQZ1vVjpkKxKDEvFYjGKSCA3TdpRkMWiBDTgMdKVgHzZSZsJUMGJN+PYe1PgydUo9/i
 6qTgrA66XxZ3b7a8pGmchEigz1KOisCcJMSyCiLQbTDS3bhuZYRmYBlZmBdakcNSZrq8y18BVMd
 G/M7SsmcNV+KdgicYz7WPvcm7p2CC7cuFwqp+V2SjiRjrubleHtujtU=
X-Google-Smtp-Source: AGHT+IGW6dFDiLoB8AqLGHXeDzhu8K9990Bq9Q8t0O9WqE7YfcLfeC+ZEQ3TuxNwVLyXFtos8porRA==
X-Received: by 2002:a5d:64e4:0:b0:38a:5ce8:df51 with SMTP id
 ffacd0b85a97d-38bf564d5f2mr27169952f8f.2.1737669402622; 
 Thu, 23 Jan 2025 13:56:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188689sm796191f8f.48.2025.01.23.13.56.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 13:56:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/15] target/ppc: Ensure powerpc_checkstop() is only called
 under TCG
Date: Thu, 23 Jan 2025 22:56:00 +0100
Message-ID: <20250123215609.30432-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123215609.30432-1-philmd@linaro.org>
References: <20250123215609.30432-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/excp_helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8956466db1d..b08cd53688c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "system/tcg.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "cpu.h"
@@ -30,7 +31,6 @@
 #include "trace.h"
 
 #ifdef CONFIG_TCG
-#include "system/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #endif
@@ -443,13 +443,11 @@ void helper_attn(CPUPPCState *env)
 static void powerpc_mcheck_checkstop(CPUPPCState *env)
 {
     /* KVM guests always have MSR[ME] enabled */
-#ifdef CONFIG_TCG
     if (FIELD_EX64(env->msr, MSR, ME)) {
         return;
     }
-
+    assert(tcg_enabled());
     powerpc_checkstop(env, "machine check with MSR[ME]=0");
-#endif
 }
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
-- 
2.47.1


