Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41138C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 21:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbMa-0004mc-QL; Mon, 10 Feb 2025 16:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbMO-0004Rj-2v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:30:40 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thbMK-0002WC-TH
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 16:30:31 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dc5764fc0so3562413f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 13:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739223027; x=1739827827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXKigwduHuX/BpQHRjwL+FaxSAFhm5Nedm/bXWe5Qys=;
 b=qtawM0MH95wYhPMDrMP+DL76ltL0xVQJQVp8NcrP6CATAwKS9J2eAfUECtUnKVqryH
 +Z9ZgH0U/iLUDAy9QwJiRev9x6LcyUSlwl0Tur0IFmhQbLNboXCkv61PMw9xG+BW414U
 2YiTWabswueN+iLvxAHRvQkO93h2y/HBgDv4aqpn1rtK24oMNEsPvmFU99bz9V97Dt5h
 Q5Irjfx/557teDqAOmlr9vxDG3sQvDk1q73QkEXUjO+YgrwJZdp1q4wry/qiVr56ZXPe
 9leJsWlqR8dWjvPYVYMdrU+a6/J/73dXuA7FajeL11xNPMdKBG1jQs+aw5Ou/+zTkR7E
 /Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739223027; x=1739827827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXKigwduHuX/BpQHRjwL+FaxSAFhm5Nedm/bXWe5Qys=;
 b=Uqn1DCZZIsRs2WVIUiFZgZz+PERRXC7OKISC7nKR4M6NZT/bXQzoVIzoTORlMpQ6IL
 PJ0/65Es3WXECRLomgkJOScHMZdwzEw1Osx3d8z2MOg88FXgcli1iVJvjrnGy6nIqvV0
 lZ9aaKs4L6kNHIcMmjXzSJYUEoKYhfuicZ7CwsYSYjlq4Hu8apCPUkHtlNr5PI+9KaTc
 BiQZr+xBsUglamg5T/NPZqC6LCLNyGbpSfEEdGsZLpAPLugjtb8+ekVRxRUYPphPN1jH
 I/5vQewjZHKlcGrsbMgjZXoQHyHAr3rYMR1PKPPJU64WdL4qYq3L/No3TXdoteb6lNaO
 cHoA==
X-Gm-Message-State: AOJu0YxcKT5W7+s8otUZJIEFOqRkSar+fquQ8E/RP1NgbUxeWPa3h8vj
 O4J9G07qTM6hKvwiGZbu7hrIMPxAAHdK9ARU/oTvmt3eF/jpYKSy1/SHCJ/RWisYBFtz9kkVXaS
 1Tzg=
X-Gm-Gg: ASbGncvaZoEd6UniGDAzLOP5d3RZVoUVq3Rar8GNXNWFv0JXMu3OsiH4iviCxJ1y1Ee
 Ws/NnABbZY8sdtnFG5XMQ/abCOcrZHDwSHjZIZFFzjNMpPbXB1GpK7j8vhmNkkC5/0ORTbWkslM
 v3GWlKAG/pyIHq0q9YB/nI76mcFwmX9RLalZwjWLbUexcUWby04kCV0Q/jpKCQjsgKXLxmOujA5
 ZsbtGsY8kg1n6bXTPovXjVPdOxvuw+cj8yxkZRoRSdQl30YFX9ykWahxcuQwuVnfRhwnJllvJSf
 WIDzv4m0TN8V5+5oJwln/928AB9MGj7G0mycs/nUts2O4d18cw6gyjBomDvpjp/C5A==
X-Google-Smtp-Source: AGHT+IEx5Gj2xA6G+Wr9ca7PMtqoCPy2W+JgDwQjVq9PD3gbXs4ERtepo0Iq9y2OXOa4zcUHlBMJoQ==
X-Received: by 2002:a5d:64ab:0:b0:38d:e16f:fa97 with SMTP id
 ffacd0b85a97d-38de16ffb3dmr3315465f8f.24.1739223026672; 
 Mon, 10 Feb 2025 13:30:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d933523sm194697495e9.1.2025.02.10.13.30.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 13:30:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/10] disas: Remove target_words_bigendian() call in
 initialize_debug_target()
Date: Mon, 10 Feb 2025 22:29:30 +0100
Message-ID: <20250210212931.62401-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210212931.62401-1-philmd@linaro.org>
References: <20250210212931.62401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

All CPUClass implementations must implement disas_set_info()
which sets the disassemble_info::endian value.

Ensure that by:

1/ assert disas_set_info() handler is not NULL
2/ set %endian to BFD_ENDIAN_UNKNOWN before calling the
   CPUClass::disas_set_info() handler, then assert %endian
   is not BFD_ENDIAN_UNKNOWN after the call.

This allows removing the target_words_bigendian() call in disas/.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 disas/disas-common.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/disas/disas-common.c b/disas/disas-common.c
index 57505823cb7..42e911e36be 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -7,7 +7,6 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
-#include "exec/tswap.h"
 #include "disas-internal.h"
 
 
@@ -61,15 +60,11 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
 
     s->cpu = cpu;
     s->info.print_address_func = print_address;
-    if (target_words_bigendian()) {
-        s->info.endian = BFD_ENDIAN_BIG;
-    } else {
-        s->info.endian =  BFD_ENDIAN_LITTLE;
-    }
+    s->info.endian =  BFD_ENDIAN_UNKNOWN;
 
-    if (cpu->cc->disas_set_info) {
-        cpu->cc->disas_set_info(cpu, &s->info);
-    }
+    g_assert(cpu->cc->disas_set_info);
+    cpu->cc->disas_set_info(cpu, &s->info);
+    g_assert(s->info.endian !=  BFD_ENDIAN_UNKNOWN);
 }
 
 int disas_gstring_printf(FILE *stream, const char *fmt, ...)
-- 
2.47.1


