Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67DBC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNiM-0007Wm-G8; Mon, 27 Jan 2025 06:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNi6-0006ze-0n
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:25 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNi1-0007D8-PL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:55:21 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so4517926f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737978916; x=1738583716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=477b2+132Twzc6vm7x293Qvrvp4aEfDDM84pZnLDz7E=;
 b=A30Hdz7DgNSk/txVVLqyttURob1pvTspsV1OrXuq6BP+rrCMsb3cR3jCvHhAU5zXy0
 2P+inoAUoI+vsj9Bo3yDQA+WBzhol+dIdi/PR3jRbo4VU3qkW9s9ewdS2c4I1Fx69UC3
 2USRtgLzjJeD+uvUwesUBXpzyhHwbucQYMFUpzalUN5GbnqxB7CQSSaQtrhchCyOoPen
 6aEUiysDCL/76HzS1aBlcukYqhsDGu0e89VLb19DIpSWEOnuE5eNsceBW/XudCd4PlFA
 54nwvd6YrgqO7uxIDTGJqcD7Tfb1zKyh2quAbuona05YUXXh7TNNPUEE8+Wlt88+P4ci
 WRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737978916; x=1738583716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=477b2+132Twzc6vm7x293Qvrvp4aEfDDM84pZnLDz7E=;
 b=ocZGBWulrDhIczlXs9aZMYEpFpmumQoFp6KumZLsJzAcWYQHgQwGvZiZH1Ez1UANJK
 At5XNFg1Hq6bNtBFcOEyOCCoXU/npMCUvttWXFfcMzntbynV1GeF2YpY5CyV/y75HdNU
 OmmNuZ2IumExKu+K0/dTRYVCtBfojjSBxF0GrX57wUxAJXcqASl7Yh9ZGlcjJLOvFRPj
 mS/6toQ16jA0UsDTXY/NSqPGxdTvWXNXYpqsWTGCZdnw3EVgB6zj/eZ/RNx332SqrCpG
 e018WuaknNXlwjyRYg9u4QJQ7sNw9cZpd8xmHL4S0gmzU7N06eYYv0HYIaLc43RqCegh
 lqkw==
X-Gm-Message-State: AOJu0YyZy2/TNh6awpnmKdJJBerw0rxZ6HIKIaRWlNqzMbjswweZa5z2
 oZCf99bSqniBRynTv4jJsDUCKHX5W8aL5qficFf7R2uDgH5ZkRlIPJcVK1VMGXHAvQs/cMylHe0
 AyBc=
X-Gm-Gg: ASbGncs/fWsJ7XvZIUBsc/Wa/QafHQXlbNifYJ05zYBZ9DQUCDI9LDo/JDM0jRnBajC
 rBEBFBjpr8K6+4UiBESWNJi3BNvgIpiIffgyG+4a90KiyJd8GJr5MBWdk9O+5jqYtqxdcLQIl50
 7+IUQQpeP/WbxSkIfHAJU1V2S9RMZ4MnkPrGjwYTPuJ9y/A/8w9aKXbXxZ+6ezG+auSBCNVeiww
 q+AYEzKwlmjT6HzVr8EdyYFHDKUce84CfFtatsyPKMf32p+5uTiwnBMrRxPisOP1s+V8E6Onb7F
 y8c7v6M31xxZczJ133qjjIb+P8jcNPv6IXvp2yslpbwL7atYdoq5JZE=
X-Google-Smtp-Source: AGHT+IGHWLmSvU1P39gqGXFnIhRl/32Yegnv45d7TusjfscIdD5eIgw0WV1HeMUXoBfBZqD4Icviow==
X-Received: by 2002:a05:6000:1788:b0:385:ea2b:12cc with SMTP id
 ffacd0b85a97d-38bf56628e4mr37165113f8f.13.1737978915871; 
 Mon, 27 Jan 2025 03:55:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bbd93sm10884096f8f.76.2025.01.27.03.55.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:55:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/10] disas: Remove target_words_bigendian() call in
 initialize_debug_target()
Date: Mon, 27 Jan 2025 12:54:26 +0100
Message-ID: <20250127115426.51355-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127115426.51355-1-philmd@linaro.org>
References: <20250127115426.51355-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


