Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B99E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlCa-0000Tb-85; Fri, 03 Jan 2025 12:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCR-0000SP-HG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:11:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCQ-0006nx-1V
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:11:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso82555325e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924260; x=1736529060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5XdE242or4AIgVZWPEadWGVw1QKMWXHY4iwMfcXJLM=;
 b=D8mcgKEXXgw0FqNtBfDFED/+AhBGUp8gatP/52JFK+d63do4Y+vFw4Q4kXIH9FBgf0
 0NB3+0JNuDpVsQ+S/+L1o+3WcCIZBjpODMIIYsTj60WLoLx+eN7PjaiOeQxH4bsAfY8X
 kvvPhumg5mQ2yWbP/f/crqG2fQYgLYK2pWqVLhv2dhhHfh+xNf2xNAf6BDQaCw1qKlkq
 K1nJBmg+b+S6mwjuWYZO6JtgNNOmHk/NutLLIWECrIQns0x83My8AAq2lOu/wdrvvN3n
 BiqOKQ7fmL/CiBqiJ8mq0laNtf6XqXUcE/ThG3yBG706pGcu8VJWLGtikOsqZSPz2O29
 Qn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924260; x=1736529060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5XdE242or4AIgVZWPEadWGVw1QKMWXHY4iwMfcXJLM=;
 b=a986Cb8OCpuebj7YLqeNUJJ4wcZGxuMklE8bj5YuyaBAggH+kx7ExJbBAhG7OTUkoZ
 qoyfKfpID82mqUH6U6NidFBhDXnxJkfDxDU/8srKqzC4quSj3eATMkkJkJuISMrmxcEi
 JHWzVauOfnLSUiJltDEzOic2qm5sfauWFmzUzBCsZIO9XfXOUReDRKiw12D5JJwmCNlp
 TiIATyBX4M6sONcV8D2Sd4CJyrTCJLm89A+zrq5rDcKmfSdENO6J9jURyFWWgt20lX7+
 KGr3+PCPb0oo88bJSb9JZn0raTN2lan4gSdbCPGDpKGv5p78RHnm7qz5QfXIUQigpQeb
 W9qw==
X-Gm-Message-State: AOJu0YxoHAfqT8Xs1TcLKTlpj9AdgSMywkzGmYZ5dxVeD1KeXMxdOvmB
 42mfK1ILanpg4eDZtf3Bep954LYT2zUW1U2iWI40Dpsk8gT3X3huZgkRbXauXFi23L3ZRBhTesJ
 0bD4=
X-Gm-Gg: ASbGnctp3AzmhWmtl4RcYaeP88JA2EC6rLgsxBFcTL8iROFdNXegCKFB6ctv3zM26l6
 q1FeJnJXQld+7pNonbTBTuBBEbib8yoChH/LwxC2mHx+33QF3brZ35ktoiVzNzodUbWumSqZkmP
 jBE9aX7hv0uADqRHkYVJPy5rUboJEhpAzsmU5Noduanjb6Wc4zCFl3+BLs677Ar8SEJz9hafScG
 WqX+EzV36S2rKkgc6iSuLQuB4VwAT3drM+SMXPNzsIloEZBovDub1PTsBHt0nxOlMCm+ER1ZAY+
 nj1TrVIvPv9mXfSJfJP3gmoomyiCukU=
X-Google-Smtp-Source: AGHT+IERC60Agg1k2eN1gd88XTgS6bx2NpC5+LTqOO1XivlHcuIt5iuShlhqjWQR9o+zzB1I1uKB9g==
X-Received: by 2002:a05:600c:548e:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-436686431a0mr401008775e9.8.1735924260263; 
 Fri, 03 Jan 2025 09:11:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289d3dsm494171645e9.41.2025.01.03.09.10.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:10:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] semihosting/console: Avoid including 'cpu.h'
Date: Fri,  3 Jan 2025 18:10:36 +0100
Message-ID: <20250103171037.11265-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103171037.11265-1-philmd@linaro.org>
References: <20250103171037.11265-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The CPUState structure is declared in "hw/core/cpu.h",
the EXCP_HALTED definition in "exec/cpu-common.h".
Both headers are indirectly include by "cpu.h". In
order to remove "cpu.h" from "semihosting/console.h",
explicitly include them in console.c, otherwise we'd
get:

  ../semihosting/console.c:88:11: error: incomplete definition of type 'struct CPUState'
     88 |         cs->exception_index = EXCP_HALTED;
        |         ~~^
  ../semihosting/console.c:88:31: error: use of undeclared identifier 'EXCP_HALTED'
     88 |         cs->exception_index = EXCP_HALTED;
        |                               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/semihosting/console.h | 2 --
 semihosting/console.c         | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/semihosting/console.h b/include/semihosting/console.h
index bd78e5f03fc..1c12e178ee3 100644
--- a/include/semihosting/console.h
+++ b/include/semihosting/console.h
@@ -9,8 +9,6 @@
 #ifndef SEMIHOST_CONSOLE_H
 #define SEMIHOST_CONSOLE_H
 
-#include "cpu.h"
-
 /**
  * qemu_semihosting_console_read:
  * @cs: CPUState
diff --git a/semihosting/console.c b/semihosting/console.c
index 60102bbab66..c3683a15668 100644
--- a/semihosting/console.c
+++ b/semihosting/console.c
@@ -18,14 +18,15 @@
 #include "qemu/osdep.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
+#include "exec/cpu-common.h"
 #include "exec/gdbstub.h"
-#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu/fifo8.h"
+#include "hw/core/cpu.h"
 
 /* Access to this structure is protected by the BQL */
 typedef struct SemihostingConsole {
-- 
2.47.1


