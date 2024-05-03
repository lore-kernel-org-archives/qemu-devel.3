Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A907C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2p2m-0001ih-7E; Fri, 03 May 2024 05:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2k-0001iX-Pd
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:26 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2j-0003ak-5x
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-347e635b1fcso6635329f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714727843; x=1715332643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9C79ZCDN03MmjjHQ6TSF486EGxB4sAu8CtoKMbncco=;
 b=jbnHbEvsR0Xd7fBy4Vykdq9w6HG2xt09h722ooiDUBJR1EO+cdTQFvCDP0hDjMIo1B
 90zba+/17477kCJAZE1k46/PKspjaRHbZ+OaV80XiiYwhYYxEL/PAG7uoNBdzmJSjcqQ
 3ISTkbOkDN8LdNAD4lzCNrBVap3B6pq5veslO0LwuNlLue0jIJ9jUZyVWDNawXrcjdqv
 wZf+Y6RNv4Y1Yg4RYjdpYuUejiM4lpdJ3O8HzAECUAaxmHNXg/7WjJo4u2OHfyb4g9dH
 jmNQ5D64OaJbVf5w+YlNfP6pD93RbcBD+kTHJIbQd9DazMNYb4PEc+IW0vuYjmqN437R
 2Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727843; x=1715332643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9C79ZCDN03MmjjHQ6TSF486EGxB4sAu8CtoKMbncco=;
 b=U8WIC5VqW99Oht5xqbo+PjTiuLL4ka1QNazGqwN/rpHARxxMCFFqsKnE+2y7ngO79z
 u5xMSaAkEY/flUj72PXOsqql16NTLOKlgRMjO5U1LxxtoY57mHk0o+0/HJr7jk3yy15G
 KTtCVk7xLqml0+s1iwIHXVpxRpoMKT6jAUEJf2pJ7yvtPhC6NYMV80Z/IjQXeNrgxCZk
 xkMFVBZT8foeQyxziqjOB07XCoeCPeDw/vIBwMbAva4gSgGnMu0mXIVglcEevn+91z4c
 3B+3TtENvZx7oeOHkic6ZLbAtPOC6vAdGx+Vo0VPuNWcvIg4RdTvvXsa5Fa3lPLQDPWJ
 m91g==
X-Gm-Message-State: AOJu0Ywnla8nnSugbYYWVLIxbtZ/63DrmpQGBOPZF3h3IQo0PdpasJUd
 AxCvAPf8bcDi2oHWpTiSbvaD1JukCvzOOrzR9AT6fO3lz1f4W+9LJMcZdZHZgBhu/2Rr69TeX4a
 o
X-Google-Smtp-Source: AGHT+IEEI3G04u6nCTL6TaAiUU/84v+I/3OzETWJTIOnRCl/CJAOF8TXXj0BrxPeHtuvhqdUWTk6uQ==
X-Received: by 2002:a05:6000:36f:b0:343:7b6b:dcc6 with SMTP id
 f15-20020a056000036f00b003437b6bdcc6mr1352192wrf.30.1714727843314; 
 Fri, 03 May 2024 02:17:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a056000019200b00347f6b5bb6dsm3256568wrx.30.2024.05.03.02.17.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 02:17:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] accel/tcg: Introduce common tcg_exec_cpu_reset_hold()
 method
Date: Fri,  3 May 2024 11:16:56 +0200
Message-ID: <20240503091657.26468-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503091657.26468-1-philmd@linaro.org>
References: <20240503091657.26468-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Introduce a method called by cpu_reset(), common
to both system and user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h      | 2 ++
 accel/tcg/cpu-exec.c             | 4 ++++
 accel/tcg/sysemu/tcg-accel-ops.c | 3 ++-
 accel/tcg/user-exec.c            | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index edefd0dcb7..b85285e2ff 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -23,4 +23,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !(cs->tcg_cflags & CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
+void tcg_exec_cpu_reset_hold(CPUState *cpu);
+
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 225e5fbd3e..1bf85c324d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1096,3 +1096,7 @@ void tcg_exec_unrealizefn(CPUState *cpu)
     tlb_destroy(cpu);
     g_free_rcu(cpu->tb_jmp_cache, rcu);
 }
+
+void tcg_exec_cpu_reset_hold(CPUState *cpu)
+{
+}
diff --git a/accel/tcg/sysemu/tcg-accel-ops.c b/accel/tcg/sysemu/tcg-accel-ops.c
index 2c7b0cc09e..82c8368f87 100644
--- a/accel/tcg/sysemu/tcg-accel-ops.c
+++ b/accel/tcg/sysemu/tcg-accel-ops.c
@@ -36,7 +36,7 @@
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
-
+#include "../internal-common.h"
 #include "hw/core/cpu.h"
 
 #include "tcg-accel-ops.h"
@@ -82,6 +82,7 @@ int tcg_cpu_exec(CPUState *cpu)
 
 static void tcg_cpu_reset_hold(CPUState *cpu)
 {
+    tcg_exec_cpu_reset_hold(cpu);
     tcg_flush_jmp_cache(cpu);
 
     tlb_flush(cpu);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 6a108eb212..85e92ec8f2 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -39,6 +39,7 @@ __thread uintptr_t helper_retaddr;
 
 void cpu_exec_reset_hold(CPUState *cpu)
 {
+    tcg_exec_cpu_reset_hold(cpu);
 }
 
 /*
-- 
2.41.0


