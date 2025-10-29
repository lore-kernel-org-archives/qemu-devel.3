Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14A5CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Yj-0005RI-4O; Wed, 29 Oct 2025 11:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ya-0005FP-8H
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:55 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003Xf-Tn
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:51 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso11458219a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753451; x=1762358251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89K9UohZzH0h6Hv05a+atCjJ751UhZo4tfa75Adu0VM=;
 b=MXT7WeFQtgXydoJiN87S/gCj3mgDZbmdCgUb+JXxLQDTktyBqsEJaWygX6A8T+riH0
 Gs044drrdW7jhw3Xjeys5tFHPUUBE2MV1w3VEsOyn4QafN/rSmszY6NtnfunLIn1Pjh8
 xX50UtuzDhZ1LjH5CUILfquXeks/2HwOJ7LXJnmIgP+K8NvR/CU2PT++8STibok4Yy6k
 hPDsaMSGiiCM1aYOavNVNvnq1+1VQB8Mi1sgIzcyZNn0A2dqmumAE2pQMfYV5YU4rmbE
 62E/XKBeiqYY/AEXHEUL1gRSsmjMYr1JCk7OvwEiw6AqRM3AxEC0ok2kAu/oicIXl2vA
 m2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753451; x=1762358251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89K9UohZzH0h6Hv05a+atCjJ751UhZo4tfa75Adu0VM=;
 b=goeXcgV9z1Z0rgftFi6yQcs5qMy2FofFE/Ad/JNAHju6AN70mIPLEIypAbu0QVN6O7
 pFTywniAszlfFYA/W9MTHo/6h+2l/sjMFgcxOo42VM0SahdW5rtRfNi8v+lUD070wQ5y
 hurefd3UlOit7fwNW9QlfI+kUktJsNAWZ5kpeXJFnHH6miwG6smeio16AQuQ6TsX2DQj
 6I4NZnqvBjHthuFt5WUHEeT52tZg/8DSrSTsPzK7i+tD/7OTHqs4tTCo33DOI6Z+Rf/Q
 ELvUoMsJzIH2FWr3B+DK18mLWMJeKtVQLLCfHfq/x5W6GkrCPN/ef7GcpXJ/ad/9m4U4
 85eA==
X-Gm-Message-State: AOJu0YxAhp90tnxIyhRiBNgwpyNj+CBDcLBOuT7TSyVAsimhiv56b1is
 69BOvJcNNdCA45QR7Jck68o6qEksK7FtSEcUE1ymUIUDmR5zlGbYqs7mcJv5/eRcN/s=
X-Gm-Gg: ASbGncuaOXs2MbLxUwaEsBEUkdjcArBAwz/d+6ncScyp+vhnwDZhzHnV2Qyimz0zA0f
 mXwtwx+o/bXYOxhFqXkFB7HtUa6r4Zi5vbSgeCEjoIEGsF5cPaykiD32FvWORHwTQ8JWi9yKUMl
 wp1IePnxYMI6exadUy6Gh3zOvNhP9PehwY9MpMQXC/Rfw1XXuPEyXqcCotWTS/5wM5jPzYgd0Vn
 1/DyU34s36y4mRN+YK5K2T3u9BJrpyvKw5S6CkqjatJ21Z+rt3BBeaIr4yTnmT/ic8eo2YLBCRg
 +0XZ8bzzEwAxvnToqHb2bu6Dy0zSKLQfr5kDGtQFQuml45QgQXETPH2JrQaOUAnN8Cv5kLIMoCQ
 mnNnSlFjntXMZ2hSQBCu9QEARh68zyIRF9RauD3C0QmEmDxxT5rCPaddapYnpc5/nIaHCxvbBIm
 4U
X-Google-Smtp-Source: AGHT+IEdRGuVDjp+89hHJhLbme6fxra2eMMvOY4Rvjg5qASqG4xWdLo7iYrljRz2UrF1o6SdpJn+PQ==
X-Received: by 2002:a05:6402:40c3:b0:63c:58b6:25ef with SMTP id
 4fb4d7f45d1cf-64044246f86mr2958856a12.20.1761753451449; 
 Wed, 29 Oct 2025 08:57:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef6c129sm12372234a12.3.2025.10.29.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B3BC60E7B;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 26/35] target/sparc: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:35 +0000
Message-ID: <20251029155045.257802-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for SPARC (32bit and 64bit) targets. We treat
any interrupt other than EXTINT and IVEC as exceptions as they appear to
be synchroneous events.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-27-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index fdcaa0a578b..b29f693a6bf 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -24,6 +24,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/log.h"
 #include "system/runstate.h"
+#include "qemu/plugin.h"
 
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
@@ -174,4 +175,10 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         env->qemu_irq_ack(env, intno);
     }
 #endif
+
+    if (intno == TT_EXTINT) {
+        qemu_plugin_vcpu_interrupt_cb(cs, env->regwptr[9]);
+    } else {
+        qemu_plugin_vcpu_exception_cb(cs, env->regwptr[9]);
+    }
 }
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 96ef81c26cd..60ab0478fc6 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/log.h"
 #include "trace.h"
+#include "qemu/plugin.h"
 
 #define DEBUG_PCALL
 
@@ -256,6 +257,15 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     }
     env->npc = env->pc + 4;
     cs->exception_index = -1;
+
+    switch (intno) {
+    case TT_EXTINT:
+    case TT_IVEC:
+        qemu_plugin_vcpu_interrupt_cb(cs, tsptr->tpc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, tsptr->tpc);
+    }
 }
 
 trap_state *cpu_tsptr(CPUSPARCState* env)
-- 
2.47.3


